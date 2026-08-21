
--
-- <代码文件解释说明>
--

---@class UIBossraidModel : UIBaseModel
---@field bossraid Bossraid
local UIBossraidModel = BaseClass("UIBossraidModel",UIBaseModel)
local base = UIBaseModel
local this = UIBossraidModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type BossraidComponent
    local bossraidComponent = Game.Scene.Player:GetComponent("BossraidComponent")
    self.bossraid = bossraidComponent:GetFirstBossraid()
end

function this:RefreshLeaderboard(startRank, endRank, currentCount)
    ---@type BossraidComponent
    local bossraidComponent = Game.Scene.Player:GetComponent("BossraidComponent")
    bossraidComponent:GetLeaderboard(self.bossraid.bossraidId, startRank, endRank, function()
        self.bossraid = bossraidComponent:GetFirstBossraid()
        self:UIBroadcast(UIMessageNames.ON_BOSSRAID_LEADER_UPDATE_PUSH, currentCount)
    end)
end

local function ON_BOSSRAID_UPDATE_PUSH(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_BOSSRAID_UPDATE_PUSH)
end

local function OnItemInfoChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_ITEM_DATA_UPDATE)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_BOSSRAID_UPDATE_PUSH,ON_BOSSRAID_UPDATE_PUSH)
    self:AddDataListener(DataMessageNames.ON_ITEM_DATA_UPDATE, OnItemInfoChg)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_BOSSRAID_UPDATE_PUSH)
    self:RemoveDataListener(DataMessageNames.ON_ITEM_DATA_UPDATE)
end

return this
