
---队伍数据
---@class Team:Entity
---@field Id number @ 队伍编号
---@field cardIds table<number, number> @ 队伍中的角色id
---@field fightSoulIds table<number, number> @ 队伍中的战魂id
local Team = BaseClass("Team",Entity)
local base = Entity

---@param self Team
---@param teamInfo protocol.Formation
local function Awake(self,teamInfo)
    base.Awake(self)
    self.Id = teamInfo.id
    self.TeamNo = teamInfo.id
    self.cardIds = teamInfo.id_list
    self.fightSoulIds = teamInfo.fight_soul_list
end

---@param self Team
---@param teamInfo protocol.Formation
local function UpdateData(self, teamInfo)
    self.cardIds = teamInfo.id_list or self.cardIds
    self.fightSoulIds = teamInfo.fight_soul_list or self.fightSoulIds
end

---@param self Team
---@return table<number, Card | nil>
local function GetCardList(self)
    local list = {}
    local cardComponent = Game.Scene.Player:GetComponent("CardComponent")
    for index, value in ipairs(self.cardIds) do
        if value ~= 0 then
            local card = cardComponent:Get(value)
            list[index] = card
        else
            list[index] = nil
        end
    end
    return list
end

---@param self Team
---@return table<number, FightSoul | nil>
local function GetFightSoulList(self)
    local list = {}
    local fightSoulComponent = Game.Scene.Player:GetComponent("FightSoulComponent")
    for index, value in ipairs(self.fightSoulIds) do
        if value ~= 0 then
            local fightSoul = fightSoulComponent:Get(value)
            list[index] = fightSoul
        else
            list[index] = nil
        end
    end
    return list
end

local function Dispose(self)
    base.Dispose(self)
end

Team.Awake = Awake
Team.Dispose = Dispose
Team.GetCardList = GetCardList
Team.GetFightSoulList = GetFightSoulList
Team.UpdateData = UpdateData
return Team