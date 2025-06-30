
---@class UIFormationChooseFightSoulModel : UIBaseModel
---@field fightSoulToCard table<number, number> @ key: fightSoulId, value: cardId
local UIFormationChooseFightSoulModel = BaseClass("UIFormationChooseFightSoulModel",UIBaseModel)
local base = UIBaseModel
local this = UIFormationChooseFightSoulModel

local choosedCardMap = {}


function this.OnCreate(self)
    base.OnCreate(self)
   
end

--- fightSoulToCard key: fightSoulId, value: cardId
---@param self UIFormationChooseFightSoulModel
---@param data {class:number, fightSoulToCard:table, chooseFightSoul:FightSoul, confirmCallBack:function}
function this.OnEnable(self,data)
    if data == nil then data = {} end
    self.characterId = data.characterId
    self.isShowProperty = data.isShowProperty
    self.fightSoulToCard = data.fightSoulToCard or {} -- key: fightSoulId, value: cardId
    self.chooseFightSoul = data.chooseFightSoul or nil
    self.showFightSouls = {}
    ---@type FightSoul[]
    local fightSouls = Game.Scene.Player:GetComponent("FightSoulComponent"):GetFightSoulList()
    for key, value in pairs(fightSouls) do
        if table.contains(value.config.ClassLimit, data.class) then
            if self.chooseFightSoul == nil or self.chooseFightSoul.Id ~= value.Id then
                table.insert(self.showFightSouls, value)
            end
        end
    end
    if self.chooseFightSoul ~= nil then
        table.insert(self.showFightSouls, 1, self.chooseFightSoul)
    end
    self.confirmCallBack = data.confirmCallBack
    base.OnEnable(self)
    self:OnRefresh()
end

function this.OnRefresh(self)

end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this
