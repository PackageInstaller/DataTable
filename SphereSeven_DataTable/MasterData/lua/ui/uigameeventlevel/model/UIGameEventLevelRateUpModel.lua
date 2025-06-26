
--
-- <代码文件解释说明>
--

---@class UIGameEventLevelRateUpModel : UIBaseModel
local UIGameEventLevelRateUpModel = BaseClass("UIGameEventLevelRateUpModel",UIBaseModel)
local base = UIBaseModel
local this = UIGameEventLevelRateUpModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.eventId = data.eventId
    self.itemId = data.itemId
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
    self.gameEvent = gameEventComponent:GetGameEvent(self.eventId)
    self.entryModule = gameEventComponent:GetGameEventModule(self.gameEvent.entryModuleId)


    self.imageIndex = 0
    self.LevelDropBoostList = {}
    for key, value in pairs(self.gameEvent.config) do
        if value.ModuleType == GameEventModuleType.GameEventModuleLevelDropBoost and checkIsShow(value) then
            local module = gameEventComponent:GetGameEventModule(value.ModuleId)
            local isOn = false
            local condition = value.StartConditions[1]
            local zCondition = Z_Condition[condition]
            local id
            if self.itemId == nil or self.itemId == value.ShowParams[1] then
                if value.ImageParams ~= nil and value.ImageParams[1] ~= nil then
                    self.imageIndex = value.ImageParams[1]
                end
    
                if module ~= nil and module.status == GameEventStatus.GameEventStatusInProgress then
                    isOn = true
                end
                
                for i, v in ipairs(zCondition) do
                    if v.Type == ConditionType.ConditionTypeHasCharacter then
                        id = tonumber(v.Params[1])
                        break
                    end
                end
    
                table.insert(self.LevelDropBoostList, {
                    isOn = isOn,
                    config = value,
                    rate = value.ModuleParams[1],
                    id = id,
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
