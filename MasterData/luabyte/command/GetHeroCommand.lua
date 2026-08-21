--[[local GetHeroCommand = BaseClass("GetHeroCommand", BaseCommand)
local M = GetHeroCommand

function M:Execute(heroIds)
    --C#List转lua table
    local heros = {}
    for i = 0, heroIds.Count - 1 do
        heros[i + 1] = heroIds[i]
    end
    TeamConfMgr:GetInstance():AddHero(heros)
end

return GetHeroCommand--]]
