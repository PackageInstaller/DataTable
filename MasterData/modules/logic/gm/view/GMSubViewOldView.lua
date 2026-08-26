-- chunkname: @modules/logic/gm/view/GMSubViewOldView.lua

module("modules.logic.gm.view.GMSubViewOldView", package.seeall)

local tabOnColor = Color.New(0.88, 0.84, 0.5, 1)
local tabOffColor = Color.New(0.75, 0.75, 0.75, 0.75)
local GMSubViewOldView = class("GMSubViewOldView", GMSubViewBase)

function GMSubViewOldView:onOpen()
	self:addSubViewGo("ALL")
end

function GMSubViewOldView:_onToggleValueChanged(toggleId, isOn)
	if isOn then
		if not self._subViewContent then
			self:initViewContent()
		end

		self.viewContainer:selectToggle(self._toggleWrap)
	end

	gohelper.setActive(self._mainViewBg, isOn)
	gohelper.setActive(self._mainViewPort, isOn)

	if isOn then
		self._toggleImage.color = tabOnColor or tabOffColor
	end
end

return GMSubViewOldView
