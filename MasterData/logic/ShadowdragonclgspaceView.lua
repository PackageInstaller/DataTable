-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/view/ShadowdragonclgspaceView.lua

module("logic.extensions.shadowdragonclg.view.ShadowdragonclgspaceView", package.seeall)

local ShadowdragonclgspaceView = class("ShadowdragonclgspaceView", ViewComponent)

function ShadowdragonclgspaceView:ctor()
	ShadowdragonclgspaceView.super.ctor(self)
end

function ShadowdragonclgspaceView:unbindEvents()
	ShadowdragonclgspaceView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShadowdragonclgspaceView:bindEvents()
	ShadowdragonclgspaceView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ShadowdragonclgspaceView:buildUI()
	ShadowdragonclgspaceView.super.buildUI(self)

	self._tableviewrightGo = self:getGo("tableviewright")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewleftGo = self:getGo("tableviewleft")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerListLeft = ScrollerList.create(self._tableviewleftGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListRight = ScrollerList.create(self._tableviewrightGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyLeft = self:getGo("emptyLeft")
	self._emptyRight = self:getGo("emptyRight")
end

function ShadowdragonclgspaceView:onExit()
	ShadowdragonclgspaceView.super.onExit(self)
	self._scrollerListLeft:dispose()
	self._scrollerListRight:dispose()
end

function ShadowdragonclgspaceView:onEnter()
	ShadowdragonclgspaceView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_updateUI()
end

function ShadowdragonclgspaceView:_onClickbtnClose()
	self:close()
end

function ShadowdragonclgspaceView:_updateCell(view, cell, raceId, tag)
	MaterialMgr.setCell(MatType.Pet, raceId, cell.gameObject)
end

function ShadowdragonclgspaceView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function ShadowdragonclgspaceView:_updateUI()
	local leftPetList = ShadowdragonclgModel.instance:getPassFuturePetRaceIds(self._activityId, false)
	local rightPetList = ShadowdragonclgModel.instance:getPassFuturePetRaceIds(self._activityId, true)

	self._scrollerListLeft:reloadData(leftPetList)
	self._scrollerListRight:reloadData(rightPetList)
	goutil.setActive(self._emptyLeft, not leftPetList or #leftPetList <= 0)
	goutil.setActive(self._emptyRight, not rightPetList or #rightPetList <= 0)
end

return ShadowdragonclgspaceView
