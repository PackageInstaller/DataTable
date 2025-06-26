
--
-- <代码文件解释说明>
--

---@class UIGameEventLevelMainModel : UIBaseModel
local UIGameEventLevelMainModel = BaseClass("UIGameEventLevelMainModel",UIBaseModel)
local base = UIBaseModel
local this = UIGameEventLevelMainModel

local GameEventId
local ShopModule
local TaskModule
local LevelModule
local ExLevelModule

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    if data ~= nil then
        GameEventId = data.eventId
    end
    local config = Z_GameEvents[GameEventId]

    for k, v in pairs(config) do
        if v.ModuleType == GameEventModuleType.GameEventModuleShop then
            ShopModule = v.ModuleId
        elseif v.ModuleType == GameEventModuleType.GameEventModuleTask or
        v.ModuleType == GameEventModuleType.GameEventModuleDailyTask or
        v.ModuleType == GameEventModuleType.GameEventModuleWeeklyTask then
            TaskModule = v.ModuleId
        elseif v.ModuleType == GameEventModuleType.GameEventModuleLevel then
            if v.ShowParams[2] == 1 then
                LevelModule = v.ModuleId
            elseif v.ShowParams[2] == 2 then
                ExLevelModule = v.ModuleId
            else
                ExLevelModule = v.ModuleId
                -- Logger.LogError("ShowParams is error, ModuleId:" .. v.ModuleId)
            end
        end
    end
    self.stageIndex = 1
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    self.gameEvent = gameEventComponent:GetGameEvent(GameEventId)
    self.entryModule = gameEventComponent:GetGameEventModule(self.gameEvent.entryModuleId)
    self.shopModule = gameEventComponent:GetGameEventModule(ShopModule)
    self.taskModule = gameEventComponent:GetGameEventModule(TaskModule)
    self.levelModule = gameEventComponent:GetGameEventModule(LevelModule)
    self.exLevelModule = gameEventComponent:GetGameEventModule(ExLevelModule)

    self.LevelDropBoostList = {}
    for key, value in pairs(self.gameEvent.config) do
        if value.ModuleType == GameEventModuleType.GameEventModuleLevelDropBoost then
            local module = gameEventComponent:GetGameEventModule(value.ModuleId)
            if module ~= nil and module.status == GameEventStatus.GameEventStatusInProgress then
                table.insert(self.LevelDropBoostList, {
                    isOn = true,
                    config = value,
                    rate = value.ModuleParams[1],
                })
            else
                table.insert(self.LevelDropBoostList, {
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
