
--
-- <代码文件解释说明>
--

---@class UIBattlePassBuyPassModel : UIBaseModel
---@field pass Pass
local UIBattlePassBuyPassModel = BaseClass("UIBattlePassBuyPassModel",UIBaseModel)
local base = UIBaseModel
local this = UIBattlePassBuyPassModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.passId = data.passId
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type PassComponent
    local passComponent = Game.Scene.Player:GetComponent("PassComponent")
    self.pass = passComponent:GetPass(self.passId)

    local zStarLightStoneShop = Z_StarLightStoneShop[self.pass.config.SpecialStoreId]
    self.rewardId = zStarLightStoneShop.FirstRewards
    self.price = zStarLightStoneShop.Price
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
