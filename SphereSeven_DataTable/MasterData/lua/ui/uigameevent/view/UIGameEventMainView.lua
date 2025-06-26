--
-- <代码文件解释说明>
--

---@class UIGameEventMainView : UIBaseView
---@field model UIGameEventMainModel
---@field ctrl UIGameEventMainCtrl
---@field gameEventViewData {prefab:UnityEngine.GameObject, view:gameEventViewData}[]
local UIGameEventMainView = BaseClass("UIGameEventMainView",UIBaseView)
local base = UIBaseView
local this = UIGameEventMainView

local leftButtonPrefabName = "GameEventLeftButton"

function this:ChangeGameEvent()
    local data = self.model.data[self.model.index]

    for eventId, value in pairs(self.gameEventViewData) do
        if value.prefab ~= nil then
            value.prefab.gameObject:SetActive(eventId == data.eventId)

        end
    end

    if  self.GameEventComponent:GetGameEventModule(data.gameEvent.entryModuleId).config.ViewScript  == "" then
        self.gameEventViewData[data.eventId] = {
        }
        return
    end
    local prefab
    ---@type UIGameEventNewbieTaskSubView
    local view
    if self.gameEventViewData[data.eventId] == nil then

        local entryModuleData = self.GameEventComponent:GetGameEventModule(data.gameEvent.entryModuleId)

        -- BattleInfoPanel
        prefab = GameObjectPool:GetInstance():CoGetGameObjectAsync(string.format("UI/GameEvent/Prefab/%s.prefab", entryModuleData.config.prefab))
        prefab.transform:SetParent(self.mainUI.transform, false)
        local rectTnf = prefab:GetComponent("RectTransform")
        rectTnf:DOAnchorMax(Vector2.New(0.5, 0.5), 0)
        rectTnf:DOAnchorMin(Vector2.New(0.5, 0.5), 0)
        rectTnf:DOPivot(Vector2.New(0.5, 0.5), 0)
        rectTnf:DOSizeDelta(Vector2.New(UIManager:GetInstance().maxWidth, UIManager:GetInstance().maxHeight), 0)

        view = require ("UI.UIGameEvent.View." .. entryModuleData.config.ViewScript)
        self.gameEventViewData[data.eventId] = {
            prefab = prefab,
            view = view,
        }
        view.OnCreate(self, prefab, data.eventId)
    else
        prefab = self.gameEventViewData[data.eventId].prefab
        view = self.gameEventViewData[data.eventId].view
    end
    prefab.gameObject:SetActive(true)
    view.OnRefresh(self)
end

function this:OnLeftButtonClick(index)
    if self.model.data[index] == nil or self.model.data[index].isTitle then
        Logger.LogError("error: index is error or isTitle" .. index)
        return
    end

    for key, value in pairs(self.leftButtonList) do
        value.mask:SetActive(index ~= key)
        value.active:SetActive(index == key)
    end
    self.model.index = index
    coroutine.start(function()
        self:ChangeGameEvent()
    end)
end

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    self.lastTimeText = LangUtil.BindText(self.langRc:GetObject("LastTimeText"))
end

function this:Update()
    local eventId = self.model.data[self.model.index].eventId
    if self.gameEventViewData == nil or self.model.index == nil or self.gameEventViewData[eventId] == nil then
        return
    end
    local view = self.gameEventViewData[eventId].view
    if view ~= nil and view.showEndTime ~= nil and view.showEndTime(self) ~= nil then
        self.lastTimeText.text = view.showEndTime(self)
    else
        self.lastTimeText.text = ""
    end
end

function this:OnCreate()
    base.OnCreate(self)

    ---@type HintComponent
    local hintComponent = Game.Scene:GetComponent("HintComponent")
    ---@type HintNode
    self.ActivityHint = hintComponent.Activity

    self.gameEventViewData = {}
    self.mainUI = self.rc:GetObject("MainUI")

    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"), 
        UIWindowNames.UIGameEventMain,
        nil
    )
    

    self.leftTabContent = self.rc:GetObject("BtnPanel")

    ---@type GameEventComponent
    self.GameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    ListChildPool:GetInstance():ClearContent(self.leftTabContent)
    self.leftButtonList = {}
    for index, data in ipairs(self.model.data) do
        ListChildPool:GetInstance():GetChild(leftButtonPrefabName, self.leftTabContent, function(gameObject)
            ---@type UIGameEventTabData
            local rc = gameObject:GetComponent("ReferenceCollector")
            rc:GetObject("Title"):SetActive(data.isTitle)
            rc:GetObject("GameEvent"):SetActive(not data.isTitle)
            -- 调整gameObject的宽高
            local rectTransform = gameObject:GetComponent("RectTransform")
            rectTransform.sizeDelta = Vector2.New(data.width, data.height)
            local hint = rc:GetObject("Hint")
            if data.isTitle then
                LangUtil.BindText(rc:GetObject("TitleText")).text = LangUtil.GetSysLang(GameEventTypeNameSysKey[data.type])
                gameObject:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/tab_acitivy_1.jpg")
                hint:SetActive(false)
            else
                gameObject:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/GameEvent/tab_activity_2.png")
                local image = rc:GetObject("Image"):GetComponent("Image")
                local entryModuleData = self.GameEventComponent:GetGameEventModule(data.gameEvent.entryModuleId)
                if tonumber(entryModuleData.config.TabImage) ~= nil then
                    LangUtil.GetSpriteLang(tonumber(entryModuleData.config.TabImage), function(sprite) 
                        if IsNull(sprite) or sprite == nil then
                            image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/GameEvent/Tab/%s.png", entryModuleData.config.TabImage))
                        else
                            image.sprite = sprite
                        end
                    end)
                else
                    image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/GameEvent/Tab/%s.png", entryModuleData.config.TabImage))
                end

                if self.ActivityHint:GetChild(data.eventId) ~= nil then
                    self.ActivityHint:GetChild(data.eventId):AddObject(hint, "GameEventTab")
                end

                coroutine.start(function()
                    coroutine.waitforframes(4)
                    image:SetNativeSize()
                end)

                local text = LangUtil.GetConfLang(entryModuleData.config, "TabName")
                LangUtil.BindText(rc:GetObject("MaskText")).text = text
                LangUtil.BindText(rc:GetObject("ActiveText")).text = text
            end
            self.leftButtonList[index] = {
                mask = rc:GetObject("Mask"),
                active = rc:GetObject("Active"),
            }
            UIUtil.AddBtnEvent(gameObject, function()
                if data.isTitle then
                    return
                end
                if self.clickTabTime ~= nil and TimeUtil.GetServerTime() - self.clickTabTime < ClickTimeInterval then
                    return
                end
                self.clickTabTime = TimeUtil.GetServerTime()

                self:OnLeftButtonClick(index)
            end)
    
        end)
    end
    self:OnLeftButtonClick(self.model.index)
end

---@param self UIGameEventMainView
local function ON_TASK_UPDATE(self, type)
    for key, value in pairs(self.gameEventViewData) do
        if value.view.OnTaskUpdate ~= nil then
            value.view.OnTaskUpdate(self, type)
        end
    end
end

---@param self UIGameEventMainView
local function ON_GAME_EVENT_UPDATE(self)
    for key, value in pairs(self.gameEventViewData) do
        if value.view.OnGameEventUpdate ~= nil then
            value.view.OnGameEventUpdate(self)
        end
    end
end


---@param self UIGameEventMainView
local function OnCheckInUpdate(self)
    for key, value in pairs(self.gameEventViewData) do
        if value.view.OnCheckInUpdate ~= nil then
            value.view.OnCheckInUpdate(self)
        end
    end
end

---@param self UIGameEventMainView
local function ON_PASS_UPDATE_PUSH(self)
    for key, value in pairs(self.gameEventViewData) do
        if value.view.OnPassUpdatePush ~= nil then
            value.view.OnPassUpdatePush(self)
        end
    end
end



function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_PASS_UPDATE_PUSH, ON_PASS_UPDATE_PUSH)
    self:AddUIListener(UIMessageNames.ON_TASK_UPDATE, ON_TASK_UPDATE)
    self:AddUIListener(UIMessageNames.ON_GAME_EVENT_UPDATE, ON_GAME_EVENT_UPDATE)
    self:AddUIListener(UIMessageNames.ON_CHECK_IN_UPDATE, OnCheckInUpdate)
    
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_PASS_UPDATE_PUSH)
    self:RemoveUIListener(UIMessageNames.ON_TASK_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_GAME_EVENT_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_CHECK_IN_UPDATE)

end


function this:OnDisable()
    base.OnDisable(self)
    ListChildPool:GetInstance():ClearContent(self.leftTabContent)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
