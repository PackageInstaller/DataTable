local UILoginGenerateCodeView = BaseClass("UILoginGenerateCodeView", UIBaseView)
local base = UIBaseView
local this = UILoginGenerateCodeView

function this.OnCreate(self)
    base.OnCreate(self)
    self.eventBg = self.rc:GetObject("EventBg")
    self.closeBtn = self.rc:GetObject("CloseBtn")
    self.topText = self.rc:GetObject("TopText")
    
    self.idIpt = self.rc:GetObject("IDIpt"):GetComponent("InputField")
    self.passwordIpt = self.rc:GetObject("PasswordIpt"):GetComponent("InputField")
    self.passwordTxt = self.rc:GetObject("PasswordText")
    self.infoTxt = self.rc:GetObject("InfoText")
    
    self.confirmBtn = self.rc:GetObject("ConfirmBtn")
    self.cancelBtn = self.rc:GetObject("CancelBtn")

    local cancelFunc = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginGenerateCode)
        local loginView = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin).View
        loginView:OnStatuteDisable()
    end

    EventTriggerListener.Get(self.eventBg).onLuaClick = cancelFunc
    UIUtil.AddBtnEvent(self.closeBtn, cancelFunc)
    UIUtil.AddBtnEvent(self.cancelBtn, cancelFunc)

    UIUtil.AddBtnEvent(self.confirmBtn, function ()
        if string.IsNullOrEmpty(self.idIpt.text) or string.IsNullOrEmpty(self.passwordIpt.text) then
            -- 账号密码是空
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(1003))
            return
        end
        -- 生成码登录
        -- 登陆成功关闭该窗口，登录失败给提示
        local loginCtrl = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin).Ctrl
        if CS.UnityEngine.Application.isEditor then
            -- 内部测试就不要更新密码了
            loginCtrl:Login(self.idIpt.text, self.passwordIpt.text, "", function ()
                UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginGenerateCode)
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(4040))
            end);
            return
        end
        -- 登录后必须修改密码，避免用生成码反复登录
        loginCtrl:Login(self.idIpt.text, self.passwordIpt.text, "Update", function () 
            UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginGenerateCode) 
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(4040))
        end);
    end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.topText).text = LangUtil.GetSysLang(4013)
    LangUtil.BindText(self.passwordTxt).text = LangUtil.GetSysLang(4014)
    LangUtil.BindText(self.infoTxt).text = LangUtil.GetSysLang(4015)
    LangUtil.BindText(self.idIpt.transform:Find("Placeholder")).text = LangUtil.GetSysLang(4016)
    LangUtil.BindText(self.passwordIpt.transform:Find("Placeholder")).text = LangUtil.GetSysLang(4017)
    LangUtil.BindText(self.idIpt.transform:Find("Text"))
    LangUtil.BindText(self.passwordIpt.transform:Find("Text"))
    LangUtil.BindText(self.confirmBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3018)
    LangUtil.BindText(self.cancelBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3017)
    LangUtil.BindText(self.rc:GetObject("UID")).text = "UID"
end

return UILoginGenerateCodeView