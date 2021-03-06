--checks for spawning validity and if valid, clears space for the spawn
function clearArea(center, surface)
    for y = center.y-8, center.y+8 do --fail if any water in area
        for x = center.x-8, center.x+8 do
            if surface.get_tile(x, y).name == "water" or surface.get_tile(x, y).name == "deepwater" then
                return false
            end
        end
    end

    local area = {{center.x-8.8,center.y-8.8},{center.x+8.8,center.y+8.8}}
    -- Ensures factory won't overlap with resources or cliffs
    for index, entity in pairs(surface.find_entities(area)) do
        if entity.valid and entity.type ~= "tree" then
            return false
        end
    end

    -- If only obstacle is trees, remove the trees
    for index, entity in pairs(surface.find_entities(area)) do
        if entity.valid and entity.type == "tree" then --don't destroy ores, cliffs might become invalid after we destroy their neighbours, so check .valid
            entity.destroy()
        end
    end

    return true
end

function spawn(center, surface)
    local ce = surface.create_entity --save typing
    local force = game.forces.player
    local assembly_to_furnace_ratio = 1.2  -- How many assembly machines you want per furnace spawn

    if clearArea(center, surface) then
        addPoint(center)

        if probability(1/(1+assembly_to_furnace_ratio)) then
            entityname = "big-furnace"
        else
            entityname = "big-assembly"
        end
        
        if global.whistlestats[entityname] == nil then
            global.whistlestats[entityname] = 0
        end
        global.whistlestats[entityname] = global.whistlestats[entityname] + 1
        local en = ce{name = entityname, position = {center.x, center.y}, force = force}
        local event = {created_entity=en, player_index=1}
        script.raise_event(defines.events.on_built_entity, event)
    end
end
