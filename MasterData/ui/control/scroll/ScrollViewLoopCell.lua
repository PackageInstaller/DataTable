-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Scroll\\ScrollViewLoopCell.lua

local IUIBase = require("UI/Control/Base/IUIBase")
local UIUtils = require("Framework.UI.UIUtils")
local ScrollViewLoopCell = Class("ScrollViewLoopCell", IUIBase)
local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)

function ScrollViewLoopCell:ctor(scrollLoop, prefabPath, idx, width, height)
	self.mScrollLoop = scrollLoop
	self.mIndex = idx
	self.mParent = scrollLoop.mParent
	self.mWindow = scrollLoop.mWindow

	local parentUID = self.mParent.id or self.mParent.mRoot.id

	UIUtils.CreateUILoopCell(prefabPath, self, width or 0, height or 0, scrollLoop._obj, parentUID)
end

function ScrollViewLoopCell:destroy()
	return
end

function ScrollViewLoopCell:OnClearStart()
	RedDotManager.clearRedDots(self.id, false)
	self:onClear()
end

function ScrollViewLoopCell:OnIndexChanged(newIdx)
	self.mIndex = newIdx
end

function ScrollViewLoopCell:onClear()
	return
end

function ScrollViewLoopCell:setVisible(v)
	return
end

function ScrollViewLoopCell:getVisible()
	return
end

function ScrollViewLoopCell:setLayoutSize(width, height)
	if self._layoutEmt == nil then
		self._layoutEmt = self:getController():GetComponent(LayoutElementType)
	end

	if width ~= nil then
		self._layoutEmt.preferredWidth = width
	end

	if height ~= nil then
		self._layoutEmt.preferredHeight = height
	end
end

return ScrollViewLoopCell
