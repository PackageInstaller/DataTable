
--
-- <代码文件解释说明>
--

---@class UIGameEventLevelExLevelModel : UIBaseModel
local UIGameEventLevelExLevelModel = BaseClass("UIGameEventLevelExLevelModel",UIBaseModel)
local base = UIBaseModel
local this = UIGameEventLevelExLevelModel


local GameEventId
local ExLevelModule

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    if data ~= nil then
        GameEventId = data.eventId
        ExLevelModule = data.moduleId
    end
    self.levelType = LevelType.LevelTypeGameEvent

    self:OnRefresh()
end

function this:OnRefresh()
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    self.gameEvent = gameEventComponent:GetGameEvent(GameEventId)
    self.module = gameEventComponent:GetGameEventModule(ExLevelModule)

    self.chapterId = self.module.config.ShowParams[1]
    self.UILandladyId = 1011
    self.imageIndex = 0
    if self.module.config.ImageParams[1] ~= nil then
        self.UILandladyId = self.module.config.ImageParams[1]
    end
    if self.module.config.ImageParams[2] ~= nil then
        self.imageIndex = self.module.config.ImageParams[2]
    end

    ---@type StoryComponent
    local storyComponent = Game.Scene.Player:GetComponent("StoryComponent")

    self.sections = {}
    for key, value in pairs(Z_GameEventsLevel) do
        if value.ChapterId == self.chapterId then
            if storyComponent:CheckLevelIsUnlock(LevelType.LevelTypeGameEvent, value.Id) then
            table.insert(self.sections, value)
        end
    end

    end
    table.sort(self.sections, function(a, b)
        return a.Id < b.Id
    end)
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
