---@class LoginEnrollPanel : LoginEnrollPanel_Generate
---##################### 【LoginEnrollPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LoginEnrollPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LoginEnrollPanel = require "LoginEnrollPanel_Generate"

function LoginEnrollPanel:InitLogic(data)
    self.WaitSecond = 60
end

--function LoginEnrollPanel:StartCreating(time)
--
--end

--function LoginEnrollPanel:StartEnter(time)
--
--end

--function LoginEnrollPanel:StartRemoving(time)
--
--end

--function LoginEnrollPanel:StartExit(time)
--
--end

function LoginEnrollPanel:OnOpen(data, initiative)

    self.label.textLink:SetCallback(self.label.text, function(linkID, linkData)
        LuaLogger.ds("linkID", linkID)
        LuaLogger.ds("linkData", linkData)
        if linkID == "UserAgreement" then
            Application.OpenURL("http://www.moefantasy.com/")
        elseif linkID == "PrivacyPolicy" then
            Application.OpenURL("http://www.moefantasy.com/")
        end
    end)

    --self.phoneInput.inputField.text --手机号
    --self.codeInput.inputField.text --验证码
    --self.newPasswordInput.inputField.text --密码
    --self.cheakPasswordInput.inputField.text --确认密码
end

--function LoginEnrollPanel:OnClose(initiative)
--
--end

function LoginEnrollPanel:OkBtnOnClick()
    --self.phoneInput.inputField.text --手机号
        self.label:SetActive(false)
        UIMgr:popUI("MsgBox", {
            title = "提示", 
            content = "需同意用户协议及隐私条款后方可注册",
            type = MsgBoxType.OK,
            okCallback = function()
                self.label:SetActive(true)
                UIMgr:closeUI("MsgBox")
            end,
        })

        return
    end
    if self.phoneInput.inputField.text == "" then
        UICommonUtils.PopToast("请输入手机号")
        return
    end
    if self.codeInput.inputField.text == "" then
        UICommonUtils.PopToast("请输入验证码")
        return
    end
    if self.newPasswordInput.inputField.text == "" then
        UICommonUtils.PopToast("请输入密码")
        return
    end
    if self.cheakPasswordInput.inputField.text == "" then
        UICommonUtils.PopToast("请输入确认密码")
        return
    end
    if self.newPasswordInput.inputField.text ~= self.cheakPasswordInput.inputField.text then
        UICommonUtils.PopToast("两次输入的密码不一致")
        return
    end

    --TODO: 用户注册逻辑===============================
end

--验证码按钮点击
function LoginEnrollPanel:SendCodeOnClick()
    --TODO: 发送验证码逻辑================
    --验证码开始倒计时============
    if self.recoverTicketCountDownTimer then
        DLuaTimer:RemoveTimer(self.recoverTicketCountDownTimer)
    end
    self.waitBtn:SetActive(true)
    self.recoverTicketCountDownTimer = DLuaTimer:DoRepeatForever(1, function()
        self.WaitSecond = self.WaitSecond - 1
        self.waitBtn.sendCodeTxt.text.text = self.WaitSecond.."s后可发送"
        if self.WaitSecond <= 0 then
            self.waitBtn:SetActive(false)
            self.WaitSecond = 60
            self.waitBtn.sendCodeTxt.text.text = self.WaitSecond.."s后可发送"
            DLuaTimer:RemoveTimer(self.recoverTicketCountDownTimer)
        end
    end)
end

--function LoginEnrollPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function LoginEnrollPanel:OnRefresh(data)
--
--end

--[[
/MaskBg onClick 
--]]
function LoginEnrollPanel:maskBg_Button_onClick(maskBg)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/PhoneInput onEndEdit 
--]]
function LoginEnrollPanel:phoneInput_InputField_onEndEdit(phoneInput,content)

end

--[[
/PanelBg/PhoneInput onValueChanged 
--]]
function LoginEnrollPanel:phoneInput_InputField_onValueChanged(phoneInput,content)

end

--[[
/PanelBg/CodeInput onEndEdit 
--]]
function LoginEnrollPanel:codeInput_InputField_onEndEdit(codeInput,content)

end

--[[
/PanelBg/CodeInput onValueChanged 
--]]
function LoginEnrollPanel:codeInput_InputField_onValueChanged(codeInput,content)

end

--[[
/PanelBg/NewPasswordInput onEndEdit 
--]]
function LoginEnrollPanel:newPasswordInput_InputField_onEndEdit(newPasswordInput,content)

end

--[[
/PanelBg/NewPasswordInput onValueChanged 
--]]
function LoginEnrollPanel:newPasswordInput_InputField_onValueChanged(newPasswordInput,content)

end

--[[
/PanelBg/CheakPasswordInput onEndEdit 
--]]
function LoginEnrollPanel:cheakPasswordInput_InputField_onEndEdit(cheakPasswordInput,content)

end

--[[
/PanelBg/CheakPasswordInput onValueChanged 
--]]
function LoginEnrollPanel:cheakPasswordInput_InputField_onValueChanged(cheakPasswordInput,content)

end

--[[
/PanelBg/SendCodeBtn onClick 
--]]
function LoginEnrollPanel:sendCodeBtn_ScaleButton_onClick(sendCodeBtn)
    self:SendCodeOnClick()
end

--[[
/PanelBg/OkBtn onClick 
--]]
function LoginEnrollPanel:okBtn_ScaleButton_onClick(okBtn)
    self:OkBtnOnClick()
end

--[[
/PanelBg/CloseBtn onClick 
--]]
function LoginEnrollPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

--[[
/PanelBg/CheakToggle onValueChanged 
--]]
function LoginEnrollPanel:cheakToggle_Toggle_onValueChanged(cheakToggle,isOn)

end

return LoginEnrollPanel
