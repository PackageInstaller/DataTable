-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipViewStatusComponent.lua

module("logic.extensions.charactersystem.view.equip.EquipViewStatusComponent", package.seeall)

local M = class("EquipViewStatusComponent", ViewComponent)
local UIStatus = EquipEnum.MainUIStatus
local UIStatusAni = {
	[UIStatus.LvUp] = "a",
	[UIStatus.Timing] = "b",
	[UIStatus.Retiming] = "c"
}

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._guiAnimation = nil
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.EQUIP_UI_STATUS_CHANGED, self.toChangeStatus, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._onCloseTimingAni, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_UI_STATUS_CHANGED, self.toChangeStatus, self)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._onCloseTimingAni, self)
end

function M:onEnter()
	self._curStatus = UIStatus.LvUp

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)

	if self._viewPresentor:getIsBackOpen() then
		settimer(0, self.onBackOpen, self, false)
	end

	self._isTimingClose = self._statusView[UIStatus.LvUp]:checkJumpToTimingView()
end

function M:onBackOpen()
	if EquipIntensifyModel.instance:getIsJumpToD6() then
		self._curStatus = UIStatus.Retiming

		self:toChangeStatus(nil, UIStatus.Timing)
	end
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
end

function M:toChangeStatus(e, targetStatus, isClickHole)
	if targetStatus == UIStatus.LvUp then
		self._isTimingClose = false
	end

	if not targetStatus or self._curStatus and self._curStatus == targetStatus then
		local view = self._statusView[targetStatus]

		if view then
			view:onShow()
		end

		if (targetStatus == UIStatus.LvUp or targetStatus == UIStatus.Retiming) and isClickHole then
			self._statusView[UIStatus.LvUp]:setPageIndex(targetStatus == UIStatus.LvUp and 1 or 2)
		end

		return
	end

	if self._statusView[UIStatus.LvUp].onStatusChange then
		self._statusView[UIStatus.LvUp]:onStatusChange(targetStatus)
	end

	local aniName = self:getStatusAniName(self._curStatus, targetStatus)

	self:playGuiAni(aniName)

	local oldView = self._statusView[self._curStatus]
	local newView = self._statusView[targetStatus]

	if oldView.onHide then
		oldView:onHide()
	end

	if newView.onShow then
		newView:onShow()
	end

	if (targetStatus == UIStatus.LvUp or targetStatus == UIStatus.Retiming) and isClickHole then
		self._statusView[UIStatus.LvUp]:setPageIndex(targetStatus == UIStatus.LvUp and 1 or 2)
	end

	self._curStatus = targetStatus
end

function M:getUIStatus()
	return self._curStatus
end

function M:tryBack()
	if not self._isTimingClose and self._curStatus and self._curStatus == UIStatus.Timing then
		self:toChangeStatus(self._curStatus, UIStatus.Retiming)

		return
	end

	EquipIntensifyModel.instance:clear()
	ViewMgr.instance:close(self._viewPresentor:getViewName(), true)
end

function M:getStatusAniName(oldStatus, newStatus)
	return UIStatusAni[oldStatus] .. "-" .. UIStatusAni[newStatus]
end

function M:playGuiAni(name)
	self._guiAnimation:StopTimelineAni()

	if self.mainGO.activeSelf and not string.nilorempty(name) then
		self._guiAnimation:PlayAniByName(name)
	end
end

function M:setStatusView(lvView, timingView, retmingView)
	self._statusView = {
		[UIStatus.LvUp] = lvView,
		[UIStatus.Timing] = timingView,
		[UIStatus.Retiming] = retmingView
	}
end

function M:_onCloseTimingAni(e, viewName)
	if viewName == ViewName.EquipTimingAnimation and self._curStatus and self._curStatus ~= UIStatus.Retiming then
		self:toChangeStatus(self._curStatus, UIStatus.Retiming)

		return
	end
end

return M
