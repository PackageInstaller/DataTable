---@class WinSDK : WinSDK_Generate
---##################### 【WinSDK Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WinSDK Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WinSDK = require "WinSDK_Generate"

local LoginPanelMode = 
{
    LoginMode = 1,  --登录
    RegisterMode = 2,   --注册
    ForgotPassward = 3  --忘记密码
}

local _VerifyCodeState = {
    CanSend = 1,
    Waiting = 2,
}

local _verifyBtnColor = Color.NewFromStr("D96928")
local _verifyWaitColor = Color.NewFromStr("888888")
local _phoneRegister = true -- 只在国服有效
local _tapExclusive = false -- Android Tap独家

function WinSDK:InitLogic(data)
    self.loginType = GE.LoginType.Official
    self.formalRegister:SetActive(false)
    self.accountExtra:SetActive(false)
    self.forgetPasswordBtn:SetActive(false)
    -- self.loginChoosePanel.protoAgreementCheck:SetActive(false)

    self.isAgreementOn = nil -- 是否勾选协议
    --self:initVerifyBtn()

    if SDKMgr.IOSReview then
        _phoneRegister = false
        -- self.formalRegister.phoneVerifyCodeNode:SetActive(false)
    end
    self.verifyCodeState = _VerifyCodeState.CanSend
    self.verifyCodeBtn.txt.text.text = LocalStrEnum.ActionFailReason_BindPhoneVerifySend

end

function WinSDK:setLastLoginInfo()
    if self.loginType == GE.LoginType.Official then
        local loginData = SDKMgr:getAccountPasswordData()
        --LuaLogger.ds("loginData", tablex.dump(loginData))
        self.account.inputField.text = loginData.account
        self.password.inputField.text = loginData.password
    elseif self.loginType == GE.LoginType.Firebase_Email then
        local loginData = SDKMgr:getEmailPasswordData()
        self.account.inputField.text = loginData.emailAccount
        self.password.inputField.text = loginData.emailPassword
    end
end

-- 登录模式，登录按钮在上，注册按钮在下，都存在
-- 注册模式，原注册按钮隐藏掉，登录按钮上的文字在账号密码方式注册时显示为"注册并登录"，在邮箱密码方式注册显示为"注册"
function WinSDK:setLoginUIByMode()
    -- LuaLogger.ds("setLoginUIByMode loginType", self.loginType)
    -- LuaLogger.ds("setLoginUIByMode funcType", self.funcType)
    -- LuaLogger.ds("setLoginUIByMode LoginPanelMode", self.LoginPanelMode)
    --实名认证
    if self.funcType == GE.SDKFuncType.Auth then
        self.authRegister:SetActive(true)
        self.officialPanel:SetActive(false)
        self.formalRegister:SetActive(false)
        return
    end
    self.authRegister:SetActive(false)
    self.loginChoosePanel:SetActive(false)
    self.officialPanel:SetActive(true)
    self.forgetPasswordBtn:SetActive(true)
    --登录
    if self.funcType == GE.SDKFuncType.Login then
        --登录
        if self.LoginPanelMode == LoginPanelMode.LoginMode then
            self.accountExtra:SetActive(false)
            -- -- 官网包、对外展示包均不开放注册
            -- self.register:SetActive(SDKMgr:getChannel() ~= GE.Channel.Formal_Official
            --      and SDKMgr:getChannel() ~= GE.Channel.Externalshow)
            --渠道开关
            local channelOpen = false
            self.otherDesc:SetActive(channelOpen)
            self.channelList:SetActive(channelOpen)
            self:setLastLoginInfo()
        --注册
        elseif self.LoginPanelMode == LoginPanelMode.RegisterMode then
            self:clearFormalRegisterUI()
            --使用验证码作为密码 关闭
            self.formalRegister.toggle:SetActive(false)
            self.formalRegister:SetActive(true)
            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.middlePart.transform)
            --官网
            if self.loginType == GE.LoginType.Official then
                self.formalRegister.titleTxt.text.text = LocalStrEnum.LoginText --账号登录
                self.formalRegister.formalRegisterBtn.txt.text.text = LocalStrEnum.RegisterText -- 注册
            end
            if GV.IsEditor then
                self.placeholder.text.text = "手机号码 内网模式无需真实手机号和验证码"
            end
        --忘记密码
        elseif self.LoginPanelMode == LoginPanelMode.ForgotPassward then
            self:clearFormalRegisterUI()
            self.formalRegister:SetActive(true)
            self.formalRegister.toggle:SetActive(false)
            self:__resetToggle()
            self.formalRegister.titleTxt.text.text = LocalStrEnum.ForgetPasswordTitleText --忘记密码
            self.formalRegister.formalRegisterBtn.txt.text.text = LocalStrEnum.ChangePasswordText -- 修改密码
        end
    else -- 绑定模式
        self.loginText.text.text = LocalStrEnum.BindText
        if self.loginType == GE.LoginType.Official then
            self.title.text.text = LocalStrEnum.AccountPasswordBindText
            self.accountExtra:SetActive(true)
        else
            self.title.text.text = LocalStrEnum.EmailPasswordBindText
            self.accountExtra:SetActive(false)
        end
        self.register:SetActive(false)
    end
end

--function WinSDK:StartCreating(time)
--
--end

--function WinSDK:StartEnter(time)
--
--end

--function WinSDK:StartRemoving(time)
--
--end

--function WinSDK:StartExit(time)
--
--end

function WinSDK:OnOpen(data, initiative)
	-- if not initiative then
	-- 	return
	-- end

    local isInEditor = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or
            UnityEngine.Application.platform == UnityEngine.RuntimePlatform.OSXEditor or
            UnityEngine.Application.platform == UnityEngine.RuntimePlatform.LinuxEditor

    local channel = SDKMgr:getChannel()
    if isInEditor then
        channel = ResMgr.config.channel
    end
    
    _tapExclusive = _tapExclusive and channel == GE.Channel.Formal_TapTap

    self.LoginPanelMode = LoginPanelMode.LoginMode
    self.funcType = data.funcType or GE.SDKFuncType.Login
    self.continueFunc = data.continueFunc --实名认证回调
    self:setLoginUIByMode()
    --是否使用验证码作为密码快速注册 进入界面默认关闭
    self:__resetToggle()

    -- local loginChoosePanelShow
    -- if GV.GlobalConfig.IsInternalFormal() then
    --     LuaLogger.ds(GlobalInfo.LoginType,"?????????????????")
    --     LuaLogger.ds(not _tapExclusive,",.,,,,,,,,,,,,,,,,,,,,,,,")

    --     if GlobalInfo.LoginType == GE.LoginType.Official and not _tapExclusive then
    --         self:accountBtn_Button_onClick(nil)
    --     else
    --         -- self.loginChoosePanel.protoAgreementCheck:SetActive(false)
    --         loginChoosePanelShow = true
    --     end
    -- else
    --     -- self.loginChoosePanel.protoAgreementCheck:SetActive(false)
    --     loginChoosePanelShow = true
    -- end

    -- self.loginChoosePanel.tapTapBtn:SetActive(_tapExclusive)
    -- -- self.accountBtn:SetActive(_tapExclusive or GV.GlobalConfig.IsChannelTest() or GV.GlobalConfig.IsAbroadRelease()) -- Tap独家的时候也显示官方账号密码登录按钮
    -- self.accountBtn.image.enabled = not _tapExclusive
    -- self.accountBtn.tapImage:SetActive(_tapExclusive)

    -- if GV.GlobalConfig.IsAbroadRelease() then
    --     self.googleBtn.gameObject:SetActive(true)
    --     self.facebookBtn.gameObject:SetActive(true)
    --     self.emailBtn.gameObject:SetActive(true)
    -- else
    --     self.googleBtn.gameObject:SetActive(false)
    --     self.facebookBtn.gameObject:SetActive(false)
    --     self.emailBtn.gameObject:SetActive(false)
    -- end

    -- self.quickBtn:SetActive(self.funcType == GE.SDKFuncType.Login and not GV.GlobalConfig.IsInternalFormal())
    -- self.bindText:SetActive(self.funcType == GE.SDKFuncType.Bind)
    
    -- self.loginChoosePanel.quickSdkBtn.gameObject:SetActive(GlobalInfo.LoginType == GE.LoginType.QuickWrap)
    -- self.loginChoosePanel.huaweiBtn.gameObject:SetActive(GlobalInfo.LoginType == GE.LoginType.Huawei)
    -- if GlobalInfo.LoginType == GE.LoginType.Huawei or GlobalInfo.LoginType == GE.LoginType.QuickWrap then
    --     self.quickBtn:SetActive(false)
    --     -- self.loginChoosePanel.protoAgreementCheck.gameObject:SetActive(true)
    -- else
    --     -- self.loginChoosePanel.protoAgreementCheck.gameObject:SetActive(false)
    -- end

    -- local isIOS = UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer and not _tapExclusive
    -- --isIOS = true
    -- self.appleBtn:SetActive(isIOS)

    -- if isIOS then
    --     local height = self.loginChoosePanel.rectTransform.rect.height
    --     self.loginChoosePanel.rectTransform:SetSizeWithCurrentAnchors(UnityEngine.RectTransform.Axis.Vertical, height + 65) 
    -- end

    -- if GlobalInfo.ResConfig.noReg then
    --     self.register.button.interactable = false
    -- end

    -- self.loginChoosePanel:SetActive(loginChoosePanelShow)
    -- self.officialPanel:SetActive(not loginChoosePanelShow)

    -- -- 编辑器调试用
    -- if GlobalInfo.DirectLogin then
    --     self:setLastLoginInfo()
    -- 	self:login_ScaleButton_onClick()
    -- end
end

--- 重置使用验证码作为密码的状态
function WinSDK:__resetToggle()
    self._isUseCodeAsPassword = false   
    self:OnSelectToggle()
end
--function WinSDK:OnClose(initiative)
--
--end

--function WinSDK:OnDestroy()
--
--end

--function WinSDK:OnRefresh(data)
--
--end

function WinSDK:TouchBG_Close()
    -- if SDKMgr:isloginIn() or GlobalInfo.DevMode then
    --     UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    --     UIMgr:closeUI(self)
    --     return
    -- end

    -- if self.loginType ~= nil then
    --     if GV.GlobalConfig.IsAbroadRelease() and self.LoginPanelMode == LoginPanelMode.RegisterMode then
    --         self.LoginPanelMode = LoginPanelMode.LoginMode
    --         self:setLoginUIByMode()
    --         return
    --     end
        
    --     if not GV.GlobalConfig.IsInternalFormal() or _tapExclusive then -- 海外版或者Tap独家的时候，在账号密码登录界面点遮罩区域要返回登录选择框
    --         self.officialPanel:SetActive(true)
    --         --self.loginChoosePanel:SetActive(true)
    --         self.loginType = nil
    --     end
    -- end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    UIMgr:closeUI(self)
end

function WinSDK:checkAccountPasswordValid(loginData)
    if Standalone or GV.GlobalConfig.LocalServerTest then
        return true
    end
    
    if not GF.IsFormalAccountValid(loginData.account) then
        UICommonUtils.MsgBoxLogicError(false, ActionFailReason.AccountOnlyAlphaNum)
        return
    end

    if not GF.IsFormalPasswordValid(loginData.password) then
        UICommonUtils.MsgBoxLogicError(false, ActionFailReason.AcPwShouldBe616)
        return
    end

    if not stringx.isEmailValid(loginData.bindEmail) then
        UICommonUtils.PopPromptBox(LocalStrEnum.InvalidEmail)
        return
    end
    
    return true
end

function WinSDK:loginByData(loginData, failedCallback) -- 目前只有quickBtn_Button_onClick里传了第二个参数
    self.loginType = loginData.loginType
    SDKMgr:doLogin(loginData, function(bSuccess, data) -- data中的数据如果是Firebase登录的话数据在dealFirebaseLoginCallback中处理
        if bSuccess == false then
            if failedCallback then
                failedCallback(bSuccess, data)
            else
                UICommonUtils.DealSDKError(data, LocalStrEnum.LoginFailedText)
            end
        else
            UIMgr:closeUI(self)
            SDKMgr:doLoginSuccess(data)
            LuaLogger.ds("login success!")
        end
    end)
end

function WinSDK:bindByData(bindData)
    if bindData.loginType == GE.LoginType.Official then
        local bindEmail = self.accountExtra.inputField.text
        bindData.bindEmail = bindEmail
        if not self:checkAccountPasswordValid(bindData) then
            return
        end
    end
    
    local loaderId = UIMgr:startLoad(1)
    SDKMgr:doBind(bindData, function (bSuccess, data)
        UIMgr:endLoad(loaderId)
        if bSuccess == false then
            UICommonUtils.DealSDKError(data, LocalStrEnum.BindFailedText)
        else
            if bindData.loginType == GE.LoginType.Firebase_Email and data.waitForEmailToVerify then
                UICommonUtils.PopPromptBox(LocalStrEnum.EmailAccountNeedVerifyToBind)
            else
                GlobalInfo.account = data.account
                SDKMgr:saveLoginData(data)
                LuaLogger.ds("bind success!")
                UICommonUtils.PopPromptBox(LocalStrEnum.BindSuccessText)
                UIMgr:closeUI(self)
            end
        end
    end)
end

--选中使用验证码作为密码快速注册 表现
function WinSDK:OnSelectToggle()
    local state = self._isUseCodeAsPassword
    self.toggle.tick:SetActive(state)
    self.passwordNode:SetActive(not state)
    self.passwordConfirmNode:SetActive(not state)
    self.spaceTips:SetActive(not state)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.middlePart.transform)
end

function WinSDK:clearFormalRegisterUI()
    self.formalRegister.password.inputField.text = ""
    self.formalRegister.passwordConfirm.inputField.text = ""
    -- self.formalRegister.optionalPhonePart.phoneNum.inputField.text = ""
    -- self.formalRegister.phoneVerifyCode.inputField.text = ""
end

--[[
/QuickRegister onClick 
--]]
function WinSDK:quickRegister_Button_onClick(quickRegister)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    -- 改成别的按钮了
	--SDKMgr:doFastRegister(function(bSuccess, data)
    --    if bSuccess == false then
    --        UICommonUtils.DealSDKError(data, LocalStrEnum.RegisterFailedText)
    --    else
    --        print("FastRegister Account:" ..  data.account ..  " Password:" .. data.password)
    --        self:saveLoginData(data)
    --        self:InitUI()
    --        LuaLogger.d("register success!")
    --    end
    --end)
end

--[[
/LoginChoosePanel/LoginWays/GoogleBtn onClick 
--]]
function WinSDK:googleBtn_Button_onClick(googleBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.funcType == GE.SDKFuncType.Login then
        self:loginByData({loginType = GE.LoginType.Firebase_Google})
    else
        self:bindByData({loginType = GE.LoginType.Firebase_Google})
    end
end

--[[
/LoginChoosePanel/LoginWays/AppleBtn onClick 
--]]
function WinSDK:appleBtn_Button_onClick(appleBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.funcType == GE.SDKFuncType.Login then
        self:loginByData({loginType = GE.LoginType.Firebase_Apple})
    else
        self:bindByData({loginType = GE.LoginType.Firebase_Apple})
    end
end

--[[
/LoginChoosePanel/LoginWays/FacebookBtn onClick 
--]]
function WinSDK:facebookBtn_Button_onClick(facebookBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.funcType == GE.SDKFuncType.Login then
        self:loginByData({loginType = GE.LoginType.Firebase_Facebook})
    else
        self:bindByData({loginType = GE.LoginType.Firebase_Facebook})
    end
end

--[[
/LoginChoosePanel/LoginWays/TwitterBtn onClick 
--]]
function WinSDK:twitterBtn_Button_onClick(twitterBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.funcType == GE.SDKFuncType.Login then
        self:loginByData({loginType = GE.LoginType.Firebase_Twitter})
    else
        self:bindByData({loginType = GE.LoginType.Firebase_Twitter})
    end
end

--[[
/LoginChoosePanel/LoginWays/EmailBtn onClick 
--]]
function WinSDK:emailBtn_Button_onClick(emailBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.loginType = GE.LoginType.Firebase_Email
    
    self:setLoginUIByMode()
end

--[[
/LoginChoosePanel/LoginWays/PhoneBtn onClick 
--]]
function WinSDK:phoneBtn_Button_onClick(phoneBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --self:loginByData({loginType = GE.LoginType.Firebase_Google})
end

--[[
/LoginChoosePanel/LoginWays/AccountBtn onClick 
--]]
function WinSDK:accountBtn_Button_onClick(accountBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local func = function ()
        self.loginType = GE.LoginType.Official
        self:setLoginUIByMode()
    end

    if not GV.GlobalConfig.IsInternalFormal() then
        local formalAccountData = SDKMgr:getFormalAccountLoginData()
        if not formalAccountData or self.funcType == GE.SDKFuncType.Bind then
            UICommonUtils.PopOkCancelBox(LocalStrEnum.PromptTitle, LocalStrEnum.SuggestNonAccountPassword, func)
            return
        end
    end
    
    func()
end

--[[
/LoginChoosePanel/LoginWays/QuickBtn onClick 
--]]
function WinSDK:quickBtn_Button_onClick(quickBtn)  
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)  
    self.loginType = GE.LoginType.Official
    
    local regFunc = function ()
        SDKMgr:doFastRegister(function (bSuccess, data)
            if not bSuccess then
                UICommonUtils.DealSDKError(data, LocalStrEnum.PromptTitle, false)
            else
                LuaLogger.ds("faster register", data.account, data.password)
                self:loginByData({account = data.account, password = data.password, loginType = GE.LoginType.Official})
            end
        end)
    end
    
    local quickLoginData = SDKMgr:getQuickLoginData()
    if quickLoginData then
        self:loginByData(quickLoginData, function (bSuccess, data)
            if not bSuccess and (data.error == GE.PassportErrorCode.AccountNotExist or data.error == GE.PassportErrorCode.PasswordNotCorrect) then
                regFunc()
            end
        end)
    else
        regFunc()
    end
end

--[[ 忘记密码
/forgetPasswordBtn onClick 
--]]
function WinSDK:forgetPasswordBtn_Button_onClick(forgetPasswordBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.loginType = GE.LoginType.Official
    self.LoginPanelMode = LoginPanelMode.ForgotPassward
    self:setLoginUIByMode()
end

--[[
/LoginChoosePanel/LoginWays/HuaweiBtn onClick 
--]]
function WinSDK:huaweiBtn_Button_onClick(huaweiBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.isAgreementOn then
        UICommonUtils.PopPromptBox(LocalStrEnum.AgreementNotYetAgreed)
        return false
    end
    
    self:loginByData({loginType = GE.LoginType.Huawei})
end

--[[
/LoginChoosePanel/LoginWays/QuickSdkBtn onClick 
--]]
function WinSDK:quickSdkBtn_Button_onClick(quickSdkBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    -- if not self.loginChoosePanel.protoAgreementCheck.protoAgreementCheck.isAgreementOn then
    --     UICommonUtils.PopPromptBox(LocalStrEnum.AgreementNotYetAgreed)
    --     return false
    -- end

    self:loginByData({loginType = GE.LoginType.QuickWrap })
end

--初始化短信验证码状态
function WinSDK:InitVerifyBtnOuter()
    self.verifyCodeState = _VerifyCodeState.CanSend
    self:__RefreshBtnState()
end

--刷新短信验证码按钮状态
function WinSDK:__RefreshBtnState()
    self.verifyCodeBtn:SetActive(self.verifyCodeState == _VerifyCodeState.CanSend)
    self.cdBtn:SetActive(self.verifyCodeState == _VerifyCodeState.Waiting)
end

function WinSDK:VerifyCodeBtnOuter()
    LuaLogger.ds("VerifyCodeBtnOuter 发送验证码")
    if self.verifyCodeState ~= _VerifyCodeState.CanSend then
        return
    end
    local phoneNum = self.formalRegister.optionalPhonePart.phoneNum.inputField.text
    if not stringx.isPhoneNumCn(phoneNum) then
        LuaLogger.ds("手机号码不合法")
        UICommonUtils.PopToast(LocalStrEnum.InvalidPhoneNumber)
        return
    end
    --发送验证码
    SDKMgr:GetVerifyPhoneCode({phone = phoneNum}, function (success, data)
        if success then
            LuaLogger.ds("获取验证码成功")
            --修改按钮状态
            self.verifyCodeState = _VerifyCodeState.Waiting
            self:__RefreshBtnState()
            local leftSeconds = 60
            self.cdBtn.txt.text.text = string.format(LocalStrEnum.ActionFailReason_BindPhoneVerifyResend, leftSeconds)
            self:AddAutoReleaseTimer(DLuaTimer:DoRepeat(1, leftSeconds, function()
                self.cdBtn.txt.text.text = string.format(LocalStrEnum.ActionFailReason_BindPhoneVerifyResend, leftSeconds)
                leftSeconds = leftSeconds - 1

                if leftSeconds == 0 then
                    --重置按钮状态
                    self:InitVerifyBtnOuter()
                end
            end))
        else
            LuaLogger.es("获取验证码失败", tablex.dump(data))
            UICommonUtils.DealSDKError(data, LocalStrEnum.PromptTitle, false)
        end
    end)
end

--[[
/LoginChoosePanel/LoginWays/TapTapBtn onClick 
--]]
function WinSDK:tapTapBtn_Button_onClick(tapTapBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    -- 目前没有游客登录，再绑定Tap的情况
    --if self.funcType == GE.SDKFuncType.Login then
        self:loginByData({loginType = GE.LoginType.TapTap})
    --else
    --    self:bindByData({loginType = GE.LoginType.TapTap})
    --end
end

--[[ 注册
/OfficialPanel/BoxBg/BtnList/Register onClick 
--]]
function WinSDK:register_ScaleButton_onClick(register)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.loginType = GE.LoginType.Official
    SDKMgr:getLoginInfo(function ()
        -- if GV.GlobalConfig.IsInternalFormal() then
        --     self.formalRegister:SetActive(true)
        --     -- self.formalRegister.optionalPhonePart:SetActive(_phoneRegister)
        -- else
            self.LoginPanelMode = LoginPanelMode.RegisterMode
            self:setLoginUIByMode()
        -- end
    end, function(bSuccess, data)
        if bSuccess == false then
            UICommonUtils.DealSDKError(data, LocalStrEnum.LoginFailedText)
        end
    end)
end

--[[ 登录
/OfficialPanel/BoxBg/BtnList/Login onClick 
--]]
function WinSDK:login_ScaleButton_onClick(login)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.loginType = GE.LoginType.Official 
	local account = self.account.inputField.text
	local password = self.password.inputField.text
    local loginType = self.loginType

    --TODO: 拦截
    if account == "" then
        UICommonUtils.PopToast(LocalStrEnum.AccountEmpty)
        return
    end

    if password == "" then
        UICommonUtils.PopToast(LocalStrEnum.PasswordEmpty)
        return
    end

    local loginData = {loginType = loginType}
    if loginType == GE.LoginType.Official then
        loginData.account = account
        loginData.password = password
    elseif loginType == GE.LoginType.Firebase_Email then
        loginData.emailAccount = account
        loginData.emailPassword = password
    end
    
    if self.funcType == GE.SDKFuncType.Login then
        local function login()
            self:loginByData(loginData)
        end
        login()
    else
        self:bindByData(loginData)
    end
end

--[[    登录界面 右上角关闭按钮
/OfficialPanel/BoxBg/CloseBtn onClick 
--]]
function WinSDK:closeBtn_ScaleButton_onClick(closeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:TouchBG_Close()
end

--[[    qq登录
/OfficialPanel/BoxBg/channelList/qq onClick 
--]]
function WinSDK:qq_ScaleButton_onClick(qq)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[    微信登录
/OfficialPanel/BoxBg/channelList/wechat onClick 
--]]
function WinSDK:wechat_ScaleButton_onClick(wechat)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[    taptap
/OfficialPanel/BoxBg/channelList/taptap onClick 
--]]
function WinSDK:taptap_ScaleButton_onClick(taptap)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[  注册界面 发送验证码
/FormalRegister/middlePart/PhoneVerifyCodeNode/PhoneVerifyCode/verifyCodeBtn onClick 
--]]
function WinSDK:verifyCodeBtn_ScaleButton_onClick(verifyCodeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    LuaLogger.ds("verifyCodeBtn_Button_onClick")
    if not _phoneRegister then
        LuaLogger.ws("not phoneRegister mode")
        return
    end

    self:VerifyCodeBtnOuter()
end

--[[  注册界面 验证码cd中
/FormalRegister/middlePart/PhoneVerifyCodeNode/PhoneVerifyCode/cdBtn onClick 
--]]
function WinSDK:cdBtn_ScaleButton_onClick(cdBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
end

--[[  注册界面 注册按钮
/FormalRegister/middlePart/FormalRegisterBtn/FormalRegisterBtn onClick 
--]]
function WinSDK:formalRegisterBtn_ScaleButton_onClick(formalRegisterBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local account
    -- local account = self.formalRegister.optionalPhonePart.phoneNum.inputField.text
    local password = self.formalRegister.password.inputField.text
    local passwordConfirm = self.formalRegister.passwordConfirm.inputField.text
    -- local userName = self.formalRegister.userName.inputField.text
    -- local iDNum = self.formalRegister.iDNum.inputField.text
    local phoneNum = self.formalRegister.optionalPhonePart.phoneNum.inputField.text
    local verifyCode = self.formalRegister.phoneVerifyCode.inputField.text

    --检测手机号
    if _phoneRegister then
        --内网模式下不检测手机号和验证码
        if not GV.IsEditor then
            if not stringx.isPhoneNumCn(phoneNum) then
                UICommonUtils.PopToast(LocalStrEnum.InvalidPhoneNumber)
                return
            end
    
            if #verifyCode ~= 6 then
                UICommonUtils.PopToast(LocalStrEnum.VerifyCodeInvalid)
                return
            end
        end
        account = phoneNum
        if #account == 0 then
            UICommonUtils.PopToast(LocalStrEnum.InvalidPhoneNumber)
        end
    -- else
    --     if not GF.IsFormalAccountValid(account) then
    --         UICommonUtils.PopToast(LocalStrEnum.AccountPatternInvalidStr)
    --         return
    --     end 
    end

    --若为注册模式下 用验证码当做密码
    if self.LoginPanelMode == LoginPanelMode.RegisterMode and self._isUseCodeAsPassword then
        password = self.formalRegister.phoneVerifyCode.inputField.text
    else
        --密码长度不符
        if not GV.GlobalConfig.CheckPasswordValid(password) then
            UICommonUtils.PopToast(LocalStrEnum.PasswordTooShortText)
            return
        end
    
        --密码不一致
        if password ~= passwordConfirm then
            UICommonUtils.PopToast(LocalStrEnum.PasswordDifferText)
            return
        end
    end
    if #password == 0 then
        UICommonUtils.PopToast(LocalStrEnum.PasswordTooShortText)
    end

    -- if not SDKMgr.IOSReview and not GV.GlobalConfig.CheckIDNameValid(userName) then
    --     UICommonUtils.PopPromptBox("请输入正确的姓名")
    --     return
    -- end
    
    -- if GV.GlobalConfig.CheckIdCard() then
    --     local idNumLen = #iDNum
    --     if idNumLen ~= 15 and idNumLen ~= 18 then
    --         UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.IDNumWrongText)
    --         return
    --     end
    -- end

    --IDIdentify.CheckValidation(iDNum, userName, function (rtCode, rtString)
    --    LuaLogger.ws("rtCode:" .. tostring(rtCode))    
    --    LuaLogger.ws("rtString:" .. tostring(rtString))
    --    local cjson = require "cjson"
    --    if isstring(rtString) then
    --        local t = cjson.decode(rtString)
    --        if istable(t.result) then
    --            LuaLogger.ds(t.result.isok) -- true则验证成功，false则验证失败
    --        end
    --    end
    --end)
    -- if not self.formalRegister.protoAgreementCheck.protoAgreementPart.isAgreementOn then
    --     UICommonUtils.PopPromptBox(LocalStrEnum.AgreementNotYetAgreed)
    --     return false
    -- end
    --注册埋点
    if self.LoginPanelMode == LoginPanelMode.RegisterMode then
        ClientData:sendGameOpenLogMessage(Config.GameStageStr.Reg)
    end

    local loginData = {
        account = account,
        password = password,
        loginType = self.loginType,
        -- id = iDNum,
        -- name = stringx.urlEncode(userName),
        phone = phoneNum,
        verifyCode = self.formalRegister.phoneVerifyCode.inputField.text,
        phoneReg = _phoneRegister,
        channel = SDKMgr:getChannel(),
    }
    --注册
    if self.LoginPanelMode == LoginPanelMode.RegisterMode then
        UIMgr:popUI("MsgBox", {
            title = LocalStrEnum.MasgboxAgreementTitle, 
            type = MsgBoxType.Agreement,
            okCallback = function()
                GameMsgMgr:sendEvent(GameMsgType.SetProtoAgreementCheck)
                SDKMgr:doRegisterFormal(loginData, function(bSuccess, data)
                    -- self.formalRegister.protoAgreementCheck.protoAgreementPart.toggle.isOn = false
                    
                    if not bSuccess then
                        UICommonUtils.DealSDKError(data, LocalStrEnum.RegisterFailedText)
                    else
                        --注册成功
                        UICommonUtils.PopToast(LocalStrEnum.RegisterSuccessText)
                        self.account.inputField.text = account
                        self.password.inputField.text = password
                        self.formalRegister:SetActive(false)
                    end
                end)
            end,
            userpotocolUrl = "https://www.moecove.com/agreement.html",
            policyUrl = "https://www.moecove.com/privacy.html",
            confirmText = LocalStrEnum.MsgboxConfirm2,
            cancelText = LocalStrEnum.MsgboxCancel2,
        })
    --修改密码
    elseif self.LoginPanelMode == LoginPanelMode.ForgotPassward then
        SDKMgr:doChangePassword(loginData, function(bSuccess, data)
            if not bSuccess then
                LuaLogger.ds("修改密码失败", tablex.dump(data))
                UICommonUtils.DealSDKError(data, LocalStrEnum.ChangePasswordFailedText)
            else
                --注册成功
                UICommonUtils.PopToast(LocalStrEnum.ChangePasswordSuccessText)
                self.account.inputField.text = account
                self.password.inputField.text = password
                self.formalRegister:SetActive(false)
            end
        end)
    end
end

--[[    使用验证码作为密码快速注册
/FormalRegister/middlePart/toggle/toggle onClick 
--]]
function WinSDK:toggle_Button_onClick(toggle)
    self._isUseCodeAsPassword = not self._isUseCodeAsPassword
    self:OnSelectToggle()
end

--[[    实名认证 认证按钮
/AuthRegister/verifyBtn onClick 
--]]
function WinSDK:verifyBtn_ScaleButton_onClick(verifyBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local userName = self.authRegister.namePart.inputField.text   --姓名
    local iDNum = self.authRegister.iDPart.inputField.text         --身份证

    if not SDKMgr.IOSReview and not GV.GlobalConfig.CheckIDNameValid(userName) then
        UICommonUtils.PopPromptBox("请输入正确的姓名")
        return
    end
    
    if GV.GlobalConfig.CheckIdCard() then
        local idNumLen = #iDNum
        if idNumLen ~= 15 and idNumLen ~= 18 then
            UICommonUtils.PopOkBox(LocalStrEnum.PromptTitle, LocalStrEnum.IDNumWrongText)
            return
        end
    end

    -- IDIdentify.CheckValidation(iDNum, userName, function (rtCode, rtString)
    --    LuaLogger.ws("rtCode:" .. tostring(rtCode))    
    --    LuaLogger.ws("rtString:" .. tostring(rtString))
    --    local cjson = require "cjson"
    --    if isstring(rtString) then
    --        local t = cjson.decode(rtString)
    --        if istable(t.result) then
    --            LuaLogger.ds(t.result.isok) -- true则验证成功，false则验证失败
    --        end
    --    end
    -- end)
    local data = {
        name = userName,
        id_card = iDNum,
        account = SDKMgr:getSaveID(),
        token = SDKMgr:GetToken(),
    }
    --实名认证
    SDKMgr:GetVerifyAuthentication(data, function(success, response)
        if success then
            SDKMgr:SetIsNeedAuth(false)
            if self.continueFunc then
                self.continueFunc()
				self.continueFunc = nil
            end
            UICommonUtils.PopToast("认证成功")
            UIMgr:closeUI(self)
        else
            local key = ""
            for k, v in pairs(GE.authenticationResult) do
                if v == response.error then
                    key = "authenticationResult_" .. k
                    break
                end
            end
            if key == "" then
                for k, v in pairs(GE.PassportErrorCode) do
                    if v == response.error then
                        key = "PassportErrorCode_" .. k
                        break
                    end
                end
            end
            local str = LocalStrEnum[key]
            UICommonUtils.PopToast(str)
        end
    end)
end

--[[
/FormalRegister/CloseBtn2 onClick 注册界面右上角关闭界面
--]]
function WinSDK:closeBtn2_ScaleButton_onClick(closeBtn2)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    -- self:TouchBG_Close()
    self.formalRegister:SetActive(false)
end

return WinSDK
