-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoomTipsView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTipsView", package.seeall)

local V1a6_CachotRoomTipsView = class("V1a6_CachotRoomTipsView", BaseView)

function V1a6_CachotRoomTipsView:onInitView()
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txtRoomInfo = gohelper.findChildTextMesh(self.viewGO, "#go_tips/line/#txt_mapname")
	self._txtRoomNameEn = gohelper.findChildTextMesh(self.viewGO, "#go_tips/#txt_mapnameen")
	self._tipsAnim = self._gotips:GetComponent(typeof(UnityEngine.Animator))
end

function V1a6_CachotRoomTipsView:addEvents()
	self.viewContainer:registerCallback(V1a6_CachotEvent.RoomChangeAnimEnd, self.showRoomInfo, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function V1a6_CachotRoomTipsView:removeEvents()
	self.viewContainer:unregisterCallback(V1a6_CachotEvent.RoomChangeAnimEnd, self.showRoomInfo, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function V1a6_CachotRoomTipsView:onOpen()
	gohelper.setActive(self._gotips, false)
end

function V1a6_CachotRoomTipsView:_onCloseView(viewName)
	if viewName == ViewName.LoadingView or viewName == ViewName.V1a6_CachotLoadingView or viewName == ViewName.V1a6_CachotLayerChangeView then
		self:showRoomInfo()
	end
end

function V1a6_CachotRoomTipsView:showRoomInfo()
	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		return
	end

	gohelper.setActive(self._gotips, true)
	self._tipsAnim:Play("go_mapname_in", 0, 0)

	local roomId = V1a6_CachotModel.instance:getRogueInfo().room
	local roomCo = lua_rogue_room.configDict[roomId]
	local index, count = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(roomId)

	self._txtRoomInfo.text = string.format("%s（%d/%d）", roomCo.name, index, count)
	self._txtRoomNameEn.text = roomCo.nameEn

	TaskDispatcher.cancelTask(self.playHideTipsGo, self)
	TaskDispatcher.cancelTask(self.hideTipsGo, self)
	TaskDispatcher.runDelay(self.playHideTipsGo, self, 4.167)
end

function V1a6_CachotRoomTipsView:playHideTipsGo()
	if not self._tipsAnim then
		return
	end

	self._tipsAnim:Play("go_mapname_out", 0, 0)
	TaskDispatcher.runDelay(self.hideTipsGo, self, 0.433)
end

function V1a6_CachotRoomTipsView:hideTipsGo()
	gohelper.setActive(self._gotips, false)
end

function V1a6_CachotRoomTipsView:onClose()
	TaskDispatcher.cancelTask(self.playHideTipsGo, self)
	TaskDispatcher.cancelTask(self.hideTipsGo, self)
end

return V1a6_CachotRoomTipsView
