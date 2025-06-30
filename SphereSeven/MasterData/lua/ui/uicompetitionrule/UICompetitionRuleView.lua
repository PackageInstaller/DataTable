--
-- <代码文件解释说明>
--

---@class UICompetitionRuleView : UIBaseView
---@field model UICompetitionRuleModel
---@field ctrl UICompetitionRuleCtrl
local UICompetitionRuleView = BaseClass("UICompetitionRuleView",UIBaseView)
local base = UIBaseView
local this = UICompetitionRuleView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.rc:GetObject("Title")).text = LangUtil.GetSysLang(453)
    self.desc = LangUtil.BindText(self.rc:GetObject("Desc"))
end

function this:OnCreate()
    base.OnCreate(self)
    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"),function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIHelpText)
    end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.desc.text = self.model.text
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddUIListener(UIMessageNames.xxx, func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveUIListener(UIMessageNames.xxx)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
