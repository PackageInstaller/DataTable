-- chunkname: @modules/logic/herogroup/view/HeroGroupInfoScrollView.lua

module("modules.logic.herogroup.view.HeroGroupInfoScrollView", package.seeall)

local HeroGroupInfoScrollView = class("HeroGroupInfoScrollView", BaseView)

function HeroGroupInfoScrollView:onInitView()
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#go_container/#scroll_info")
	self._container = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain")
	self._arrow = gohelper.findChild(self.viewGO, "#go_container/#go_arrow")
end

function HeroGroupInfoScrollView:addEvents()
	self._scrollinfo:AddOnValueChanged(self.onValueChange, self)
	self.addEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function HeroGroupInfoScrollView:removeEvents()
	self._scrollinfo:RemoveOnValueChanged()
	self.removeEventCb(self, self.viewContainer, HeroGroupEvent.SwitchBalance, self._refreshUI, self)
end

function HeroGroupInfoScrollView:_refreshUI()
	ZProj.UGUIHelper.RebuildLayout(self._scrollinfo.transform)
end

function HeroGroupInfoScrollView:onOpen()
	self._scrollHeight = recthelper.getHeight(self._scrollinfo.transform)

	TaskDispatcher.runRepeat(self._checkContainHeight, self, 0)
end

function HeroGroupInfoScrollView:onClose()
	TaskDispatcher.cancelTask(self._checkContainHeight, self)
end

function HeroGroupInfoScrollView:_checkContainHeight()
	local height = recthelper.getHeight(self._container.transform)

	if height == self._containerHeight then
		return
	end

	self._containerHeight = height
	self._showArrow = self._scrollHeight < self._containerHeight

	gohelper.setActive(self._arrow, self._showArrow)
end

function HeroGroupInfoScrollView:onValueChange(x, y)
	if not self._showArrow then
		return
	end

	gohelper.setActive(self._arrow, y > 0)
end

return HeroGroupInfoScrollView
