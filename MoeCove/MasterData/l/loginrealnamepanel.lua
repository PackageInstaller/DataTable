---@class LoginRealNamePanel : LoginRealNamePanel_Generate
---##################### 【LoginRealNamePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LoginRealNamePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LoginRealNamePanel = require "LoginRealNamePanel_Generate"

function LoginRealNamePanel:InitLogic(data)

end

--function LoginRealNamePanel:StartCreating(time)
--
--end

--function LoginRealNamePanel:StartEnter(time)
--
--end

--function LoginRealNamePanel:StartRemoving(time)
--
--end

--function LoginRealNamePanel:StartExit(time)
--
--end

function LoginRealNamePanel:OnOpen(data, initiative)
end

--认证按钮点击
function LoginRealNamePanel:OkBtnOnClick()
    if self.nameInput.inputField.text == "" then
        UICommonUtils.PopToast("请输入姓名")
        return
    end

    if self.idCardInput.inputField.text == "" then
        UICommonUtils.PopToast("请输入身份证")
        return
    end

    --TODO: 实名认证逻辑=======================
    
end

--function LoginRealNamePanel:OnClose(initiative)
--
--end

--function LoginRealNamePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function LoginRealNamePanel:OnRefresh(data)
--
--end

--[[
/MaskBg onClick 
--]]
function LoginRealNamePanel:maskBg_Button_onClick(maskBg)

end

--[[
/PanelBg/NameInput onEndEdit 
--]]
function LoginRealNamePanel:nameInput_InputField_onEndEdit(nameInput,content)

end

--[[
/PanelBg/NameInput onValueChanged 
--]]
function LoginRealNamePanel:nameInput_InputField_onValueChanged(nameInput,content)

end

--[[
/PanelBg/IdCardInput onEndEdit 
--]]
function LoginRealNamePanel:idCardInput_InputField_onEndEdit(idCardInput,content)

end

--[[
/PanelBg/IdCardInput onValueChanged 
--]]
function LoginRealNamePanel:idCardInput_InputField_onValueChanged(idCardInput,content)

end

--[[
/PanelBg/OkBtn onClick 
--]]
function LoginRealNamePanel:okBtn_ScaleButton_onClick(okBtn)
    self:OkBtnOnClick()
end

return LoginRealNamePanel
