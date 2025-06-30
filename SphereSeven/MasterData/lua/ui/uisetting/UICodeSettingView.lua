
local UICodeSettingView = BaseClass("UICodeSettingView",UIBaseView);
local this = UICodeSettingView;
local base = UIBaseView;

local function OpenDataWindows(self)
    if self.model.data ~= nil and self.model.data.windowNames ~= nil then
        for k,v in pairs(self.model.data.windowNames) do
            UIManager:GetInstance():OpenWindow(v)
        end
    end
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.eventBg = self.rc:GetObject("EventBg")
    self.closeBtn = self.rc:GetObject("CloseBtn")
    self.topText = self.rc:GetObject("TopText")
    
    self.info = self.rc:GetObject("Info")
    self.code = self.rc:GetObject("Code")
    
    self.uidTxt = self.rc:GetObject("UidText")
    self.passwordTxt = self.rc:GetObject("PasswordText")

    self.codeBtn = self.rc:GetObject("CodeBtn")
    self.twitterBtn = self.rc:GetObject("TwitterBtn")
    self.googleBtn = self.rc:GetObject("GoggleBtn")
    self.codeBtn2 = self.rc:GetObject("CodeBtn2")
    
    local closeFunc = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UICodeSetting)
        OpenDataWindows(self)
    end
    EventTriggerListener.Get(self.eventBg).onLuaClick = closeFunc
    UIUtil.AddBtnEvent(self.closeBtn, closeFunc)

    self.twitterBtn:GetComponent("Button").interactable = false
    self.googleBtn:GetComponent("Button").interactable = false

    self.twitterBtn:SetActive(false)
    self.googleBtn:SetActive(false)
    
    local func = function()
        local client_data = ClientData:GetInstance()
        Game.Scene:GetComponent("SessionComponent"):UpdatePassword(client_data.uid, client_data.password, "OnlyUpdate", function (msg)
            self.info:SetActive(false)
            self.code:SetActive(true)

            self.codeBtn:SetActive(false)
            self.twitterBtn:SetActive(false)
            self.googleBtn:SetActive(false)
            self.codeBtn2:SetActive(true)

            self.uidTxt:GetComponent("Text").text = ClientData:GetInstance().uid
            self.passwordTxt:GetComponent("Text").text = ClientData:GetInstance().password

            -- 提示
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(4024))
        end, function ()
            -- 提示
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(4029))
        end)
    end
    
    UIUtil.AddBtnEvent(self.codeBtn, func)
    UIUtil.AddBtnEvent(self.codeBtn2, func)
    UIUtil.AddBtnEvent(self.twitterBtn, function() end)
    UIUtil.AddBtnEvent(self.googleBtn, function() end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.topText).text = LangUtil.GetSysLang(4018)
    if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.IPhonePlayer then -- 非IOS
        LangUtil.BindText(self.info.transform:Find("Text")).text = LangUtil.GetSysLang(4025)
    else
        LangUtil.BindText(self.info.transform:Find("Text")).text = LangUtil.GetSysLang(4026)
    end
    LangUtil.BindText(self.codeBtn2.transform:Find("Text")).text = LangUtil.GetSysLang(4021)
    LangUtil.BindText(self.codeBtn.transform:Find("Text")).text = LangUtil.GetSysLang(4021)
    LangUtil.BindText(self.twitterBtn.transform:Find("Text")).text = LangUtil.GetSysLang(4022)
    LangUtil.BindText(self.googleBtn.transform:Find("Text")).text = LangUtil.GetSysLang(4023)

    LangUtil.BindText(self.code.transform:Find("PasswordName")).text = LangUtil.GetSysLang(4019)
    LangUtil.BindText(self.code.transform:Find("InfoText")).text = LangUtil.GetSysLang(4020)
    LangUtil.BindText(self.uidTxt)
    LangUtil.BindText(self.passwordTxt)
    LangUtil.BindText(self.code.transform:Find("Text")).text = "UID"
end

function this.OnEnable(self)
    base.OnEnable(self);

    self.info:SetActive(true)
    self.code:SetActive(false)
    
    self.codeBtn:SetActive(true)
    self.twitterBtn:SetActive(false)
    self.googleBtn:SetActive(false)
    self.codeBtn2:SetActive(false)
end
    
return this;