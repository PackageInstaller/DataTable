---@class ProtoAgreementPart : ProtoAgreementPart_Generate
---##################### 【ProtoAgreementPart Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ProtoAgreementPart Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ProtoAgreementPart = require "ProtoAgreementPart_Generate"

function ProtoAgreementPart:InitLogic(data)

end

--function ProtoAgreementPart:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/Root onValueChanged 
--]]
function ProtoAgreementPart:toggle_Toggle_onValueChanged(toggle,isOn)

end

--[[
/agreement1Btn onClick 
--]]
function ProtoAgreementPart:agreement1Btn_Button_onClick(agreement1Btn)

end

--[[
/agreement2Btn onClick 
--]]
function ProtoAgreementPart:agreement2Btn_Button_onClick(agreement2Btn)

end

--[[
/RegisterAgreement/okBtn onClick 
--]]
function ProtoAgreementPart:okBtn_Button_onClick(okBtn)

end

return ProtoAgreementPart
