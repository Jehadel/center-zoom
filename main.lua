function love.load()
    -- Charger l'image
    image = love.graphics.newImage("monimage.png")
    
    -- Facteur de zoom initial
    zoom = 1
    
    -- Vitesse de zoom
    zoomSpeed = 0.1
    
    -- Position de l'image
    imgX = 100
    imgY = 100
end

function love.wheelmoved(x, y)
    -- Sauvegarder l'ancien zoom
    local ancienZoom = zoom
    
    -- Modifier le zoom
    if y > 0 then
        zoom = zoom + zoomSpeed
    elseif y < 0 then
        zoom = math.max(0.1, zoom - zoomSpeed)
    end
    
    -- Récupérer la position de la souris (espace écran)
    local mx, my = love.mouse.getPosition()
    
    -- Le point qu'on veut garder fixe :
    -- Position écran avant : imgX * ancienZoom
    -- Position écran après : imgX_new * zoom
    -- On veut que la distance souris-image reste proportionnelle
    
    imgX = mx / zoom - (mx / ancienZoom - imgX)
    imgY = my / zoom - (my / ancienZoom - imgY)
end

function love.draw()
    -- Sauvegarder l'état graphique
    love.graphics.push()
    
    -- Appliquer uniquement le scale
    love.graphics.scale(zoom, zoom)
    
    -- Dessiner l'image à sa position (dans l'espace zoomé)
    love.graphics.draw(image, imgX, imgY)
    
    -- Restaurer l'état graphique
    love.graphics.pop()
    
    -- Afficher le niveau de zoom
    love.graphics.print("Zoom: " .. string.format("%.1f", zoom), 10, 10)
end