---@class AgeTips : AgeTips_Generate
---##################### 【AgeTips Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AgeTips Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AgeTips = require "AgeTips_Generate"

function AgeTips:InitLogic(data)

end

--function AgeTips:StartCreating(time)
--
--end

--function AgeTips:StartEnter(time)
--
--end

--function AgeTips:StartRemoving(time)
--
--end

--function AgeTips:StartExit(time)
--
--end

function AgeTips:OnOpen(data, initiative)

end

--function AgeTips:OnClose(initiative)
--
--end

--function AgeTips:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function AgeTips:OnRefresh(data)
--
--end

--[[
/BoxBg/BtnList/disagreeBtn onClick 
--]]
function AgeTips:disagreeBtn_ScaleButton_onClick(disagreeBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:closeUI(self)
end

--[[
/BoxBg/BtnList/agreeBtn onClick 
--]]
function AgeTips:agreeBtn_ScaleButton_onClick(agreeBtn)

end

--[[
/closeBg onClick 
--]]
function AgeTips:closeBg_Button_onClick(closeBg)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:closeUI(self)
end

return AgeTips
