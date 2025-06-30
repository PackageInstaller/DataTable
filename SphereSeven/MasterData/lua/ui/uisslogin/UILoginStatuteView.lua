local UILoginStatuteView = BaseClass("UILoginStatuteView", UIBaseView)
local base = UIBaseView
local this = UILoginStatuteView

function this.OnCreate(self)
    base.OnCreate(self)
    self.eventBg = self.rc:GetObject("EventBg")
    self.closeBtn = self.rc:GetObject("CloseBtn")
    self.titleTxt = self.rc:GetObject("TitleTxt")
    self.statueText = self.rc:GetObject("StatueText")
    self.statuteButton = self.rc:GetObject("StatuteButton")
    self.agreeButton = self.rc:GetObject("AgreeButton")
    self.toggle = self.rc:GetObject("Toggle"):GetComponent("Toggle")
    self.confirmBtn = self.rc:GetObject("ConfirmBtn")
    self.cancelBtn = self.rc:GetObject("CancelBtn")
    
    self.toggle.isOn = false
    
    local cancelFunc = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginStatute)
        local loginView = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin).View
        loginView:OnStatuteDisable()
    end
    
    EventTriggerListener.Get(self.eventBg).onLuaClick = cancelFunc
    UIUtil.AddBtnEvent(self.closeBtn, cancelFunc)
    UIUtil.AddBtnEvent(self.cancelBtn, cancelFunc)

    UIUtil.AddBtnEvent(self.statuteButton, function() 
        UIManager:GetInstance():OpenWindow(UIWindowNames.UILoginStatuteDetail, {
            Title = 4005, 
            Content = 4008}) 
    end)
    UIUtil.AddBtnEvent(self.agreeButton, function() 
        UIManager:GetInstance():OpenWindow(UIWindowNames.UILoginStatuteDetail, {
            Title = 4006, 
            Content = 4009})
    end)

    UIUtil.AddBtnEvent(self.confirmBtn, function() 
        if self.toggle.isOn then
            UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginStatute)
            -- local loginCtrl = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin).Ctrl
            -- loginCtrl:Login(777, nil, "", function () UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginChoose) end)
            if UNITY_EDITOR or not ChannelManager:GetInstance():IsSdk() then
                local loginCtrl = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin).Ctrl
                loginCtrl:Login(777, nil, "", function () UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginChoose) end)
            else
                ChannelManager:GetInstance():Login()
            end
            return
            -- if UNITY_EDITOR or not ChannelManager:GetInstance():IsSdk() then
            --     UIManager:GetInstance():OpenWindow(UIWindowNames.UILoginChoose)
            -- else
            --     ChannelManager:GetInstance():Login()
            -- end
        else
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(4010))
        end
    end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.titleTxt).text = LangUtil.GetSysLang(4003)
    LangUtil.BindText(self.statueText).text = LangUtil.GetSysLang(4004)
    LangUtil.BindText(self.statuteButton.transform:Find("Text")).text = LangUtil.GetSysLang(4005)
    LangUtil.BindText(self.agreeButton.transform:Find("Text")).text = LangUtil.GetSysLang(4006)
    LangUtil.BindText(self.toggle.transform:Find("Label")).text = LangUtil.GetSysLang(4007)
    LangUtil.BindText(self.confirmBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3018)
    LangUtil.BindText(self.cancelBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3017)
end

return UILoginStatuteView;