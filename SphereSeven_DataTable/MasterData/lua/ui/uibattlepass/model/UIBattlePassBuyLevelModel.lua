
--
-- <代码文件解释说明>
--

---@class UIBattlePassBuyLevelModel : UIBaseModel
---@field pass Pass
---@field countPreLevel number @ 每一级对应购买数量
local UIBattlePassBuyLevelModel = BaseClass("UIBattlePassBuyLevelModel",UIBaseModel)
local base = UIBaseModel
local this = UIBattlePassBuyLevelModel

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

    local zStore = Z_Store[self.pass.config.ExpStoreId]
    local rewardId = zStore.RewardId
    local zReward = Z_Reward[rewardId]
    local prePassProgress = 0
    for index, value in ipairs(zReward) do
        if value.Type == RewardType.RewardTypePassProgress or value.Type == RewardType.RewardTypePassProgressWithAddition then
            prePassProgress = prePassProgress + value.Count
        end
    end
    prePassProgress = prePassProgress * zStore.Amount

    self.countPreLevel = self.pass.config.ProgressPerStage // prePassProgress

    self.itemId = zStore.PriceType
    self.itemCount = zStore.TotalPrice * self.countPreLevel
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
