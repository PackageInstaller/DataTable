local UILoginChooseView = BaseClass("UILoginChooseView", UIBaseView)
local base = UIBaseView
local this = UILoginChooseView

function this.OnCreate(self)
    base.OnCreate(self)
    self.eventBg = self.rc:GetObject("EventBg")
    self.topTxt = self.rc:GetObject("TopText")
    self.titleTxt = self.rc:GetObject("TitleTxt")
    self.closeBtn = self.rc:GetObject("CloseBtn")
    self.twitterBtn = self.rc:GetObject("TwritterBtn")
    self.appleBtn = self.rc:GetObject("AppleBtn")
    self.googleBtn = self.rc:GetObject("GoogleBtn")
    self.codeBtn = self.rc:GetObject("CodeBtn")
    self.uidBtn = self.rc:GetObject("UidBtn")
    self.cancelBtn = self.rc:GetObject("CancelBtn")
    self.confirmBtn = self.rc:GetObject("ConfirmBtn")

    self.twitterBtn:GetComponent("Button").interactable = false
    self.appleBtn:GetComponent("Button").interactable = false
    self.googleBtn:GetComponent("Button").interactable = false

    if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.IPhonePlayer then -- 安卓平台
        self.appleBtn:SetActive(false)
    end

    self.twitterBtn:SetActive(false)
    self.appleBtn:SetActive(false)
    self.googleBtn:SetActive(false)

    local cancelFunc = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginChoose)
        local loginView = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin).View
        loginView:OnStatuteDisable()
    end

    EventTriggerListener.Get(self.eventBg).onLuaClick = cancelFunc
    UIUtil.AddBtnEvent(self.closeBtn, cancelFunc)
    UIUtil.AddBtnEvent(self.cancelBtn, cancelFunc)

    self.select = 0
    self.actives = {}
    self.actives[1] = self.twitterBtn.transform:Find("Active")
    self.actives[2] = self.appleBtn.transform:Find("Active")
    self.actives[3] = self.googleBtn.transform:Find("Active")
    self.actives[4] = self.codeBtn.transform:Find("Active")
    self.actives[5] = self.uidBtn.transform:Find("Active")
    UIUtil.AddBtnEvent(self.twitterBtn, function () 
        self.select = 1 
        table.walk(self.actives, function (key, val) val.gameObject:SetActive(false) end)
        self.actives[self.select].gameObject:SetActive(true)
    end)
    UIUtil.AddBtnEvent(self.appleBtn, function () 
        self.select = 2
        table.walk(self.actives, function (key, val) val.gameObject:SetActive(false) end)
        self.actives[self.select].gameObject:SetActive(true)
    end)
    UIUtil.AddBtnEvent(self.googleBtn, function () 
        self.select = 3
        table.walk(self.actives, function (key, val) val.gameObject:SetActive(false) end)
        self.actives[self.select].gameObject:SetActive(true)
    end)
    UIUtil.AddBtnEvent(self.codeBtn, function () 
        self.select = 4
        table.walk(self.actives, function (key, val) val.gameObject:SetActive(false) end)
        self.actives[self.select].gameObject:SetActive(true)
    end)
    UIUtil.AddBtnEvent(self.uidBtn, function () 
        self.select = 5
        table.walk(self.actives, function (key, val) val.gameObject:SetActive(false) end)
        self.actives[self.select].gameObject:SetActive(true)
    end)

    UIUtil.AddBtnEvent(self.confirmBtn, function ()
        if self.select == 0 then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(910))--"请选择登入方式"
            return
        end
        if self.select == 5 then
            local loginCtrl = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin).Ctrl
            loginCtrl:Login(777, nil, "", function () UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginChoose) end)
            return
        end
        if self.select == 4 then
            UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginChoose)
            UIManager:GetInstance():OpenWindow(UIWindowNames.UILoginGenerateCode)
        end
    end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.topTxt).text = LangUtil.GetSysLang(4011)
    LangUtil.BindText(self.titleTxt).text = LangUtil.GetSysLang(4012)
    LangUtil.BindText(self.codeBtn.transform:Find("Text")).text = LangUtil.GetSysLang(4014)
    LangUtil.BindText(self.uidBtn.transform:Find("Text")).text =  LangUtil.GetSysLang(4065)
    LangUtil.BindText(self.confirmBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3018)
    LangUtil.BindText(self.cancelBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3017)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.select = 0
    table.walk(self.actives, function (key, val) val.gameObject:SetActive(false) end)
end

return UILoginChooseView