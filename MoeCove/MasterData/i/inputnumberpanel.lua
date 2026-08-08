---@class InputNumberPanel : InputNumberPanel__Generate
---##################### 【InputNumberPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【InputNumberPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local InputNumberPanel = require "InputNumberPanel_Generate"

function InputNumberPanel:InitLogic(data)

end

--function InputNumberPanel:StartCreating(time)
--
--end

--function InputNumberPanel:StartEnter(time)
--
--end

--function InputNumberPanel:StartRemoving(time)
--
--end

--function InputNumberPanel:StartExit(time)
--
--end

--function InputNumberPanel:OnOpen(data, initiative)
--
--end

--function InputNumberPanel:OnClose(initiative)
--
--end

--function InputNumberPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function InputNumberPanel:OnRefresh(data)
--
--end

function InputNumberPanel:TouchBG_Close()
	self:Close()
end

--[[
/BottomBtns/OkButton onClick 
--]]
function InputNumberPanel:okButton_Button_onClick(okButton)

end

--[[
/BottomBtns/CancleButton onClick 
--]]
function InputNumberPanel:cancleButton_Button_onClick(cancleButton)

end

return InputNumberPanel
