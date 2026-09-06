-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonFmtView.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonFmtView", package.seeall)

local OriginDualDragonFmtView = class("OriginDualDragonFmtView", ViewComponent)

function OriginDualDragonFmtView:ctor()
	OriginDualDragonFmtView.super.ctor(self)
end

function OriginDualDragonFmtView:buildUI()
	OriginDualDragonFmtView.super.buildUI(self)

	self._maskInfo = self:getGo("maskInfo")
	self._txtTips = self:getTxt("maskInfo/txtTips")
end

function OriginDualDragonFmtView:bindEvents()
	OriginDualDragonFmtView.super.bindEvents(self)
end

function OriginDualDragonFmtView:unbindEvents()
	OriginDualDragonFmtView.super.unbindEvents(self)
end

function OriginDualDragonFmtView:onEnter()
	OriginDualDragonFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo and self._fmtMo:getActivityId()
	self._stageId = self._fmtMo and self._fmtMo:getStageId()

	if self._maskInfo then
		GameUtil.SetActive(self._maskInfo, not GameUtil.isEmptyString(self._fmtMo and self._fmtMo:getBuffDescStr()))
	end

	if self._txtTips then
		self._txtTips.text = self._fmtMo and lang(self._fmtMo:getBuffDescStr()) or ""
	end
end

function OriginDualDragonFmtView:onExit()
	OriginDualDragonFmtView.super.onExit(self)
end

return OriginDualDragonFmtView
