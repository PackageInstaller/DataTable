-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnityCompMainSceneClockBannerUI.lua

module("logic.extensions.mainui.scene.unit.UnityCompMainSceneClockBannerUI", package.seeall)

local M = class("UnityCompMainSceneClockBannerUI", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._resLoaderClockUI = MultiResLoader.New()
	self._resDictClockUI = {}

	self:tryInitUI()
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseOpenEvent, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewCloseOpenEvent, self)
end

function M:OnEnable()
	M.super.OnEnable(self)
end

function M:OnDisable()
	M.super.OnDisable(self)
end

function M:onDestroy()
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseOpenEvent, self)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewCloseOpenEvent, self)
	self:_clear()

	self._resLoaderClockUI = nil
	self._resDictClockUI = nil
end

function M:onLeaveScene(needUnloadRes)
	self:showUI(false)
end

function M:onReturnScene(needUnloadRes)
	return
end

function M:onReturnSceneFinished(needUnloadRes)
	self:showUI(true)
end

function M:_handleViewCloseOpenEvent(e)
	local mainUIOpen = ViewMgr.instance:isOpen(ViewName.MainUIView)

	self:showUI(mainUIOpen)
end

function M:tryInitUI()
	local path = ResName.MainScene_Btn_System

	self._resLoaderClockUI:setResPaths({
		path
	})
	self._resLoaderClockUI:load(self._onAllLoadedClockUI, self._onLoadedClockUI, self)
end

function M:_clear()
	self:unbindUI()

	for _resTyp, go in pairs(self._resDictClockUI or {}) do
		goutil.destroy(go)
	end

	self._resDictClockUI = {}

	self._resLoaderClockUI:clear()
end

function M:getInst(resPath)
	if self._resDictClockUI then
		return self._resDictClockUI[resPath]
	end

	return nil
end

function M:_onAllLoadedClockUI(loader)
	self._resLoaderClockUI:clear()
end

function M:_onLoadedClockUI(res)
	if not self._resDictClockUI then
		self._resDictClockUI = {}
	end

	if res.IsSuccess then
		res:Retain()

		if not self._resDictClockUI[res.ResPath] then
			local inst = goutil.cloneAndSetParent(res:GetAsset(nil, nil), self._unit.mainGO.transform)

			self._resDictClockUI[res.ResPath] = inst

			goutil.setActive(inst.gameObject, true)
			self:_buildUI(inst)
		end
	end
end

function M:showUI(show)
	local path = ResName.MainScene_Btn_System
	local uiGo = self:getInst(path)

	if uiGo then
		goutil.setActive(uiGo.gameObject, show)
		self:_refreshRedPoint()
	end
end

function M:_buildUI(mainGO)
	if not mainGO then
		return
	end

	self._goRedPoint = goutil.findChild(mainGO, "red_point_scene")

	self:_setEvent(true)
	self:_refreshRedPoint()
end

function M:unbindUI()
	self:_setEvent(false)

	self._goRedPoint = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SEASON_INFO_UPDATE, self._refreshRedPoint, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_TASK_UPDATE, self._refreshRedPoint, self)
		GlobalDispatcher:addEventListener(EventType.SEASON_RECEIVE_TASK, self._refreshRedPoint, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SEASON_INFO_UPDATE, self._refreshRedPoint, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_TASK_UPDATE, self._refreshRedPoint, self)
		GlobalDispatcher:removeEventListener(EventType.SEASON_RECEIVE_TASK, self._refreshRedPoint, self)
	end
end

function M:_refreshRedPoint()
	return
end

return M
