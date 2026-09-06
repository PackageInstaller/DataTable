-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/UITextMaxHeightComponent.lua

module("logiccommon.common.components.UITextMaxHeightComponent", package.seeall)

local UITextMaxHeightComponent = class("UITextMaxHeightComponent")

function UITextMaxHeightComponent:ctor()
	self._maxHeight = 0
	self._text = nil
	self._layoutElement = nil
	self._addFixHeight = 0
end

function UITextMaxHeightComponent:dispose()
	removetimer(self._updateTextMax, self)

	self._text = nil
	self._layoutElement = nil
	self._maxHeight = 0
	self._addFixHeight = 0
end

function UITextMaxHeightComponent:initText(layoutElementGo, textGo, maxHeight, addFixHeight)
	self._layoutElement = layoutElementGo:GetComponent(ComponentType.LayoutElement)
	self._text = textGo:GetComponent(goutil.Type_UIText)
	self._maxHeight = maxHeight
	self._addFixHeight = checknumber(addFixHeight)

	settimer(0, self._updateTextMax, self, true)
end

function UITextMaxHeightComponent:_updateTextMax()
	if self._layoutElement and self._text then
		local curWidth = self._text.preferredHeight

		self._layoutElement.preferredHeight = curWidth < self._maxHeight and curWidth + self._addFixHeight or self._maxHeight + self._addFixHeight
	end
end

return UITextMaxHeightComponent
