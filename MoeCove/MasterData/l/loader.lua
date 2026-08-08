---@class Loader : Loader_Generate
---##################### 【Loader Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【Loader Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local Loader = require "Loader_Generate"

function Loader:InitLogic(data)

end

function Loader:Hide()
	self.image:SetActive(false)
end

function Loader:Show()
	self.image:SetActive(true)
end

--function Loader:StartCreating(time)
--
--end

--function Loader:StartRemoving(time)
--
--end

function Loader:OnOpen(data, initiative)
	LuaLogger.ds("Loader:OnOpen", debug.traceback())
	if initiative then
		self:Hide()
	end
end

--function Loader:OnClose(initiative)
--
--end

--function Loader:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function Loader:OnRefresh(data)
--
--end

return Loader
