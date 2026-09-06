-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/OriginDreamTeamTabShowView.lua

module("logic.extensions.groupregress.view.OriginDreamTeamTabShowView", package.seeall)

local OriginDreamTeamTabShowView = class("OriginDreamTeamTabShowView", TabFrameWorkShowMainView)

function OriginDreamTeamTabShowView:ctor()
	OriginDreamTeamTabShowView.super.ctor(self)

	self._sktTabExt = OriginDreamTeamSaintKnightTabExt.New(self)
end

function OriginDreamTeamTabShowView:buildUI()
	OriginDreamTeamTabShowView.super.buildUI(self)
	self._sktTabExt:buildUI()
	self._tabFrameWorkShow:setUpdateCellExtCallBack(GameUtil.handler(self._sktTabExt.onUpdateTabCellEx, self._sktTabExt))
	self._tabFrameWorkShow:setUpdateRightExtCallBack(GameUtil.handler(self._sktTabExt.onUpdateRightEx, self._sktTabExt))
end

function OriginDreamTeamTabShowView:bindEvents()
	OriginDreamTeamTabShowView.super.bindEvents(self)
	self._sktTabExt:bindEvents()
end

function OriginDreamTeamTabShowView:unbindEvents()
	OriginDreamTeamTabShowView.super.unbindEvents(self)
	self._sktTabExt:unbindEvents()
end

function OriginDreamTeamTabShowView:_getDefaultFrameId()
	return TabFrameWorkEnum.FrameIds_OriginDreamTeam
end

function OriginDreamTeamTabShowView:_onAfterEnterFrame()
	self._sktTabExt:onAfterEnterFrame()
end

return OriginDreamTeamTabShowView
