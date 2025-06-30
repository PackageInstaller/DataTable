
---@class UIBossraidChooseCardModel : UIBaseModel
local UIBossraidChooseCardModel = BaseClass("UIBossraidChooseCardModel",UIBaseModel)
local base = UIBaseModel
local this = UIBossraidChooseCardModel

local choosedCardMap = {}


function this.OnCreate(self)
    base.OnCreate(self)
   
end

---@param self UIBossraidChooseCardModel
function this.OnEnable(self,data)
    if data == nil then data = {} end
    self.cardList = data.cardList
    choosedCardMap = {}
    for _, value in pairs(data.cardList) do
        if value.card ~= nil then
            choosedCardMap[value.card.Id] = value.card
        end
    end

    self.currentCard = data.currentCard
    self.confirmCallBack = data.confirmCallBack

    local allCards = Game.Scene.Player:GetComponent("CardComponent").Cards
    self.showCards = {}
    for _, value in pairs(allCards) do
        if choosedCardMap[value.Id] == nil then
            table.insert(self.showCards,value)
        end
    end
    table.insert(self.showCards, self.currentCard)

    ---@type BossraidComponent
    local bossraidComponent = Game.Scene.Player:GetComponent("BossraidComponent")
    local bossraid = bossraidComponent:GetFirstBossraid()
    self.usedRole = {}
    if bossraid.remainBattle ~= nil and bossraid.remainBattle.usedRoles ~= nil then
        self.usedRole = bossraid.remainBattle.usedRoles
    end

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
