
--
-- <代码文件解释说明>
--

---@class UIGameEventTabData
---@field type number @ 对应 GameEventType, 仅用于显示
---@field isTitle boolean @ 是否是标题
---@field width number @ tab控件宽度
---@field height number @ tab控件高度
---@field gameEvent GameEvent|nil
---@field eventId number|nil

---@class UIGameEventMainModel : UIBaseModel
---@field index number @ 当前GameEvent索引
---@field data UIGameEventTabData[]
local UIGameEventMainModel = BaseClass("UIGameEventMainModel",UIBaseModel)
local base = UIBaseModel
local this = UIGameEventMainModel

--- 这里写死显示顺序
local EventTypeShowSort = {
    1, 2
}
function this:OnCreate()
    base.OnCreate(self)
end
 
function this:OnEnable(data)
    if data == nil then data = {} end
    base.OnEnable(self)
    self.eventId = data.eventId
    self:OnRefresh()
end

function this:OnRefresh()

    self:RefreshData()
    self.index = nil
    for index, value in ipairs(self.data) do
        if not value.isTitle and value.eventId == self.eventId then
            self.index = index
            break
        end
    end

    if self.index == nil then
        for index, value in ipairs(self.data) do
            if not value.isTitle then
                self.index = index
                break
            end
        end
        if self.index == nil then
            self.index = 1
        end
    end
end

function this:RefreshData()
    ---@type GameEventComponent
    local GameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    local gameEvents = GameEventComponent:GetGameEvent()
    local gameEventsByType = {}
    for index, value in pairs(GameEventType) do
        gameEventsByType[value] = {}
    end

    for index, value in ipairs(gameEvents) do
        if value.status == GameEventStatus.GameEventStatusInProgress then
            local gameEventModel = GameEventComponent:GetGameEventModule(value.entryModuleId)
            table.insert(gameEventsByType[gameEventModel.config.GameEventType], value.eventId)
        end
    end

    self.data = {}
    
    for _, type in ipairs(EventTypeShowSort) do
        if gameEventsByType[type] ~= nil and table.count(gameEventsByType[type]) > 0 then
            table.insert(self.data, {
                type = type,
                isTitle = true,
                width = 315,
                height = 54,
                gameEvent = nil,
                eventId = nil,
                --- width 315, height 54/134
            })
            for _, eventId in ipairs(gameEventsByType[type]) do
                table.insert(self.data, {
                    type = type,
                    isTitle = false,
                    width = 315,
                    height = 134,
                    gameEvent = GameEventComponent:GetGameEvent(eventId),
                    eventId = eventId,
                })
            end
        end
    end
end

local function ON_PASS_UPDATE_PUSH(self)
    self:UIBroadcast(UIMessageNames.ON_PASS_UPDATE_PUSH)
end

local function ON_TASK_UPDATE(self, type)
    self:UIBroadcast(UIMessageNames.ON_TASK_UPDATE, type)
end

local function ON_GAME_EVENT_UPDATE(self)
    self:UIBroadcast(UIMessageNames.ON_GAME_EVENT_UPDATE)
end

local function ON_CHECK_IN_UPDATE(self)
    self:UIBroadcast(UIMessageNames.ON_CHECK_IN_UPDATE)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_PASS_UPDATE_PUSH,ON_PASS_UPDATE_PUSH)
    self:AddDataListener(DataMessageNames.ON_TASK_UPDATE, ON_TASK_UPDATE)
    self:AddDataListener(DataMessageNames.ON_GAME_EVENT_UPDATE, ON_GAME_EVENT_UPDATE)
    self:AddDataListener(DataMessageNames.ON_CHECK_IN_UPDATE, ON_CHECK_IN_UPDATE)

end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_PASS_UPDATE_PUSH)
    self:RemoveDataListener(DataMessageNames.ON_TASK_UPDATE)
    self:RemoveDataListener(DataMessageNames.ON_GAME_EVENT_UPDATE)
    self:RemoveDataListener(DataMessageNames.ON_CHECK_IN_UPDATE)

end

return this
