-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Base\\UIBaseLogo.lua

local IUIBase = require("UI/Control/Base/IUIBase")
local UIUtils = require("Framework.UI.UIUtils")
local UIBaseLogo = Class("UIBaseLogo", IUIBase)

function UIBaseLogo:ctor(entityController, prefabPath, x, y)
	self.entityController = entityController
	self._visible = true
	x = x or 0
	y = y or 0
	self.id = UIUtils.CreateToplogo(prefabPath, self, self.entityController, x, y)
end

function UIBaseLogo:setVisible(v)
	self._visible = v

	UIUtils.SetUIVisible(self.id, v, false)
end

function UIBaseLogo:isInShow()
	return self._visible
end

function UIBaseLogo:setHide(hide)
	if self._hide ~= hide then
		self._hide = hide

		if self._hide then
			UIUtils.ScaleHideUI(self.id, 1)
		else
			UIUtils.ScaleHideUI(self.id, 0)
		end
	end
end

return UIBaseLogo
