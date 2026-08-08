---@class Adult : Adult_Generate
---##################### 【Adult Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【Adult Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local Adult = require "Adult_Generate"

function Adult:InitLogic(data)

end

--function Adult:StartCreating(time)
--
--end

--function Adult:StartEnter(time)
--
--end

--function Adult:StartRemoving(time)
--
--end

--function Adult:StartExit(time)
--
--end

--function Adult:OnOpen(data, initiative)
--
--end

--function Adult:OnClose(initiative)
--
--end

--function Adult:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function Adult:OnRefresh(data)
--
--end

--[[
/BoxBg/CloseBtn onClick 退出按钮
--]]
function Adult:closeBtn_ScaleButton_onClick(closeBtn)
    Application.Quit()
end

--[[
/maskImg onClick 背景遮罩
--]]
function Adult:maskImg_Button_onClick(maskImg)
    Application.Quit()
end

return Adult
