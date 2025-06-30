--
-- <代码文件解释说明>
--

---@class UIGameEventLevelExLevelView : UIBaseView
---@field model UIGameEventLevelExLevelModel
---@field ctrl UIGameEventLevelExLevelCtrl
local UIGameEventLevelExLevelView = BaseClass("UIGameEventLevelExLevelView",UIBaseView)
local base = UIBaseView
local this = UIGameEventLevelExLevelView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
end

function this:OnCreate()
    base.OnCreate(self)

    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"), 
        UIWindowNames.UIGameEventLevelExLevel,
        606
    )
    self.face = UILandlady.New(self.rc:GetObject("Paint"), 1011, self.rc:GetObject("Lines"))

    local right = self.rc:GetObject("Right").transform
    self.levelItem = {}
    for i = 0, right.childCount - 1 do
        local child = right:GetChild(i)
        self.levelItem[i + 1] = {
            root = child.gameObject,
            activity = child:Find("Root/Activity").gameObject,
            text = LangUtil.BindText(child:Find("Root/Text")),
            lock = child:Find("Root/Lock").gameObject,
        }
    end
    self.imageRoot = self.rc:GetObject("ImageRoot").transform
end

function this:PlayAnim()
    self.face:CoPlay(self.model.UILandladyId)
end

function this:OnEnable()
    base.OnEnable(self)
    self:PlayAnim()
    self:OnRefresh()
end

function this:OnRefresh()
    for i = 0, self.imageRoot.childCount-1 do
        local child = self.imageRoot:GetChild(i).gameObject
        child:SetActive(i == self.model.imageIndex)
    end

    ---@type StoryComponent
    local storyComponent = Game.Scene.Player:GetComponent("StoryComponent")
    local completeIds = storyComponent:GetCompletedSection(self.model.chapterId, self.model.levelType)
    local sectionId = completeIds[1]
    local completeCount = 0
    for index, value in ipairs(self.model.sections) do
        if value.Id <= sectionId then
            completeCount = completeCount + 1
        end
    end
    self.againstComponent = Game.Scene:GetComponent("AgainstComponent")
    
    for index, value in ipairs(self.levelItem) do
        value.root:SetActive(self.model.sections[index] ~= nil)
        if self.model.sections[index] ~= nil then
            local section = self.model.sections[index]
            value.text.text = section.Name

            UIUtil.AddBtnEvent(value.activity, function()
                -- if completeCount+1 >= index then
                --     return
                -- end
                self.againstComponent.CurLevelId = section.LevelId
                self.againstComponent.SectionId =  section.Id
                local info ={
                                levelId = section.Id,
                                levelTypeId = self.model.levelType,
                                callBack = function()
                                    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)   
                                    -- self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
                                    -- self.comTopView:InitComTop(self, self:GetName())
                                end
                            }
        
                coroutine.start(function()
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UIStorySectionInfo, info)
                end)
            end)

            value.lock:SetActive(completeCount + 1 < index)

            for i = 0, value.activity.transform.childCount-1 do
                local child = value.activity.transform:GetChild(i).gameObject
                child:SetActive(i == self.model.imageIndex)
            end

            for i = 0, value.lock.transform.childCount-1 do
                local child = value.lock.transform:GetChild(i).gameObject
                child:SetActive(i == self.model.imageIndex)
            end
        end
    end
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddUIListener(UIMessageNames.xxx, func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveUIListener(UIMessageNames.xxx)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    -- UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)   
    -- self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    -- self.comTopView:InitComTop(self, self:GetName())
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    -- UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this:OnDisable()
    base.OnDisable(self)
    self.face:Disable()
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this