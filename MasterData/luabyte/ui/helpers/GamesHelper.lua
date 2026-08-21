local GamesHelper = {}


function GamesHelper.GameName(type)
    if type == 1 then return 'GamesBeeUI' end
end


function GamesHelper.GamePrefabPath(type)
    if type == 1 then return 'UI/Prefab/Games/Game_Bee/ToggleGameBee' end
end


function GamesHelper.GameEmojiPrefabPath(name)
    return string.format('UI/Prefab/Games/Game_Emoji/%s', name)
end


function GamesHelper.Games_BeeMonsterImagePath(id)
    return string.format('UI/SpritePics/game/game_bee/ui_games_monster_0%d', id)
end


function GamesHelper.Games_BeeMonsterSize(id)
    if id == 4 then 
        return {x = 138, y = 64}
    end

    return {x = 64, y = 64}
end


function GamesHelper.TimeString(time)
    local ret = ''
    local splits = GamesHelper.SplitSecond(time)

    if splits.day ~= 0 then
        ret = ret .. (splits.day .. ConfigHelper.GetLocalString(706))
    end

    if splits.hour ~= 0 then
        ret = ret .. (splits.hour .. ConfigHelper.GetLocalString(703))
    end

    if splits.minute ~= 0 then
        ret = ret .. (splits.minute .. ConfigHelper.GetLocalString(704))
    end

    if splits.second ~= 0 then
        ret = ret .. (string.format('%g', splits.second)..ConfigHelper.GetLocalString(705))
    end
    
    return ret
end


function GamesHelper.SplitSecond(value)
    local day = math.floor(value / 86400)
    value = value - day * 86400
    local hour = math.floor(value / 3600)
    value = value - hour * 3600
    local minute = math.floor(value / 60)
    local second = value - minute * 60
    return { day = day, hour = hour, minute = minute, second = second }
end


function GamesHelper.Random(list, weigths)
    local weigth = 0
    for i,v in ipairs(weigths) do
        weigth = weigth + v
    end

    local random = math.random(1, weigth)
    for i,v in ipairs(weigths) do
        if v < random then
            random = random - v
        else
            return list[i]
        end
    end
end


return GamesHelper