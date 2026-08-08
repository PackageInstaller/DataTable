---@class BgClickClose : BgClickClose__Generate
---##################### 【BgClickClose Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BgClickClose Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BgClickClose = require "BgClickClose_Generate"

function BgClickClose:InitLogic(data)
	EventTriggerListener.Get(self.gameObject).onClick = function ()
		local luaMono = self.transform.parent:GetComponentLua(nil)
		if luaMono then
			UIMgr:closeUI(luaMono)
		else
			self.transform.parent.gameObject:SetActive(false)
		end
	end
end

return BgClickClose
