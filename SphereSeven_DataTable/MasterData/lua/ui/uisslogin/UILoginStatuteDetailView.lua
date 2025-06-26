local UILoginStatuteDetailView = BaseClass("UILoginStatuteDetailView", UIBaseView)
local base = UIBaseView
local this = UILoginStatuteDetailView

function this.OnCreate(self)
    base.OnCreate(self)
    self.eventBg = self.rc:GetObject("EventBg")
    self.closeBtn = self.rc:GetObject("CloseBtn")
    self.titleTxt = self.rc:GetObject("TitleTxt"):GetComponent("Text")
    self.text = self.rc:GetObject("Text"):GetComponent("Text")
    self.confirmBtn = self.rc:GetObject("ConfirmBtn")
    self.scrollRect = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")

    EventTriggerListener.Get(self.eventBg).onLuaClick = function() UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginStatuteDetail) end
    UIUtil.AddBtnEvent(self.closeBtn, function() UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginStatuteDetail) end)
    UIUtil.AddBtnEvent(self.confirmBtn, function() UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginStatuteDetail) end)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.titleTxt.text = LangUtil.GetSysLang(self.model.title)
    self.text.text = string.gsub(LangUtil.GetSysLang(self.model.content), " ", "\u{00A0}")
    self.scrollRect.verticalScrollbar.value = 1
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.confirmBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3018)
    LangUtil.BindText(self.titleTxt)
    LangUtil.BindText(self.text)
end

return UILoginStatuteDetailView