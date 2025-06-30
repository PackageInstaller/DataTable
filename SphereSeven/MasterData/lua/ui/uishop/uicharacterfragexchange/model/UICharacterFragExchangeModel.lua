
--
-- <代码文件解释说明>
--

---@class UICharacterFragExchangeModel : UIBaseModel
---@field items Item[] @ 所有可转换的碎片
---@field rareItemCounts <number, number>{} @ key: 稀有度, value: 碎片数量. 对应稀有度 碎片数量
local UICharacterFragExchangeModel = BaseClass("UICharacterFragExchangeModel",UIBaseModel)
local base = UIBaseModel
local this = UICharacterFragExchangeModel

local CHARACTER_CONSTELLATION_LIMIT = tonumber(Z_Misc["CHARACTER_CONSTELLATION_LIMIT"].Value[1])
function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type CardComponent
    local cardComponent = Game.Scene.Player:GetComponent("CardComponent")
    local cardIds = {}
    for cardId, card in pairs(cardComponent.Cards) do
        if card.Constellation == CHARACTER_CONSTELLATION_LIMIT then
            table.insert(cardIds, cardId)
        end
    end

    ---@type ItemComponent
    local itemComponent = Game.Scene.Player:GetComponent("ItemComponent")
    
    ---@type Item[]
    local fragItems = itemComponent:GetItemsByUesType(ItemUseType.ItemUseTypeCharacterFrag)
    self.items = {}
    self.rareItemCounts = {}
    for i, item in pairs(fragItems) do
        local cardId = tonumber(item.config.UseParams[1])
        if item.Amount > 0 and table.contains(cardIds, cardId) then
            local zCharacter = Z_Character[cardId]
            local rarity = zCharacter.Rarity
            if self.rareItemCounts[rarity] == nil then
                self.rareItemCounts[rarity] = item.Amount
            else
                self.rareItemCounts[rarity] = self.rareItemCounts[rarity] + item.Amount
            end
            table.insert(self.items, item)
        end
    end
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddDataListener(DataMessageNames.xxx,func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveDataListener(DataMessageNames.xxx)
end

return this
