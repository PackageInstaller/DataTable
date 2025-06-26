
--
-- <代码文件解释说明>
--

---@class UIGameEventLevel2MainModel : UIBaseModel
---@field levelModules GameEventModule[]
local UIGameEventLevel2MainModel = BaseClass("UIGameEventLevel2MainModel",UIBaseModel)
local base = UIBaseModel
local this = UIGameEventLevel2MainModel

local GameEventId
local ShopModule
local TaskModule
local LevelModules = {}
local ExLevelModules = {}

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    if data ~= nil then
        GameEventId = data.eventId
    end
    local config = Z_GameEvents[GameEventId]
    LevelModules = {}
    ExLevelModules = {}

    for k, v in pairs(config) do
        if v.ModuleType == GameEventModuleType.GameEventModuleShop then
            ShopModule = v.ModuleId
        elseif v.ModuleType == GameEventModuleType.GameEventModuleTask or
        v.ModuleType == GameEventModuleType.GameEventModuleDailyTask or
        v.ModuleType == GameEventModuleType.GameEventModuleWeeklyTask then
            TaskModule = v.ModuleId
        elseif v.ModuleType == GameEventModuleType.GameEventModuleLevel then
            if v.ShowParams[2] == 1 then
                LevelModules[ v.ShowParams[3] ] = v.ModuleId
            elseif v.ShowParams[2] == 2 then
                ExLevelModules[ v.ShowParams[3] ] = v.ModuleId
            else
                Logger.LogError("ShowParams is error, ModuleId:" .. v.ModuleId)
            end
        end
    end
    self.stageIndex = 1
    self:OnRefresh()
end

local function checkIsShow(value)
    local currentTime = TimeUtil.GetServerTime()
    if not string.IsNullOrEmpty(value.StartTime) then
        if currentTime < TimeUtil.ParseDateTime(value.StartTime) then
            return false
        end
    end

    if not string.IsNullOrEmpty(value.EndTime) then
        if currentTime > TimeUtil.ParseDateTime(value.EndTime) then
            return false
        end
    end

    return true
end

function this:OnRefresh()
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    self.gameEvent = gameEventComponent:GetGameEvent(GameEventId)
    self.entryModule = gameEventComponent:GetGameEventModule(self.gameEvent.entryModuleId)
    self.shopModule = gameEventComponent:GetGameEventModule(ShopModule)
    self.taskModule = gameEventComponent:GetGameEventModule(TaskModule)
    self.levelModules = {}
    for k, v in pairs(LevelModules) do
        self.levelModules[k] = gameEventComponent:GetGameEventModule(v)
    end
    self.exLevelModules = {}
    for k, v in pairs(ExLevelModules) do
        self.exLevelModules[k] = gameEventComponent:GetGameEventModule(v)
    end
    self.levelModule = self.levelModules[self.stageIndex]
    self.exLevelModule = self.exLevelModules[self.stageIndex]

    self.LevelDropBoostList = {}
    for key, value in pairs(self.gameEvent.config) do
        if value.ModuleType == GameEventModuleType.GameEventModuleLevelDropBoost and checkIsShow(value) then
            local module = gameEventComponent:GetGameEventModule(value.ModuleId)
            local ii = 1
            if value.ShowParams[1] ~= nil then
                ii = value.ShowParams[1]
            end
            if self.LevelDropBoostList[ii] == nil then
                self.LevelDropBoostList[ii] = {}
            end
            if module ~= nil and module.status == GameEventStatus.GameEventStatusInProgress then
                table.insert(self.LevelDropBoostList[ii], {
                    isOn = true,
                    config = value,
                    rate = value.ModuleParams[1],
                })
            else
                table.insert(self.LevelDropBoostList[ii], {
                    isOn = false,
                    config = value,
                    rate = value.ModuleParams[1],
                })
            end
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
