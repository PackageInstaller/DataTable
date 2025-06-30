
--
-- <代码文件解释说明>
--

---@class UICompetitionModel : UIBaseModel
---@field arenaInfo ArenaInfo
local UICompetitionModel = BaseClass("UICompetitionModel",UIBaseModel)
local base = UIBaseModel
local this = UICompetitionModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    self.arenaInfo = competitionComponent:GetArenaInfo()
end

function this:RefreshLeaderboard(leaderboardPage)
    self:UIBroadcast(UIMessageNames.ON_LEADERBOARD_UPDATE)
end

local function OnChallengerUpdate(self)
    self:UIBroadcast(UIMessageNames.ON_CHALLENGER_UPDATE)
end

local function ON_ARENA_UPDATE(self)
    self:UIBroadcast(UIMessageNames.ON_ARENA_UPDATE)
end

local function ON_ARENA_RECORD_UPDATE(self)
    self:UIBroadcast(UIMessageNames.ON_ARENA_RECORD_UPDATE)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_CHALLENGER_UPDATE, OnChallengerUpdate)
    self:AddDataListener(DataMessageNames.ON_ARENA_UPDATE, ON_ARENA_UPDATE)
    self:AddDataListener(DataMessageNames.ON_ARENA_RECORD_UPDATE, ON_ARENA_RECORD_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_CHALLENGER_UPDATE)
    self:RemoveDataListener(DataMessageNames.ON_ARENA_UPDATE)
    self:RemoveDataListener(DataMessageNames.ON_ARENA_RECORD_UPDATE)
end

return this
