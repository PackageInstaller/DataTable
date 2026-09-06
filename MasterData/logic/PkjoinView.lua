-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkjoinView.lua

module("logic.extensions.pk.view.PkjoinView", package.seeall)

local PkjoinView = class("PkjoinView", ViewComponent)

function PkjoinView:ctor()
	PkjoinView.super.ctor(self)
end

function PkjoinView:unbindEvents()
	PkjoinView.super.unbindEvents(self)
	self._btnCreateRoom:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnQuickJoin:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function PkjoinView:bindEvents()
	PkjoinView.super.bindEvents(self)
	self._btnCreateRoom:AddClickListener(self._onClickbtnCreateRoom, self)
	self._btnRefresh:AddClickListener(self._onClickbtnRefresh, self)
	self._btnQuickJoin:AddClickListener(self._onClickbtnQuickJoin, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function PkjoinView:buildUI()
	PkjoinView.super.buildUI(self)

	self._btnCreateRoom = self:getBtn("btnCreateRoom")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._btnQuickJoin = self:getBtn("btnQuickJoin")
	self._btnClose = self:getBtn("viewnode/btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtRefresh = self:getTxt("viewnode/btnRefresh/txt")
	self._emptyGo = self:getGo("empty")
end

function PkjoinView:onExit()
	PkjoinView.super.onExit(self)
	self._scrollerList:dispose()
end

function PkjoinView:onEnter()
	PkjoinView.super.onEnter(self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyQueryTeamsRes, self._updateUI, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyQuickJoinRes, self.close, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_NotifyJoinTeamRes, self._onJoin, self)

	self._lastRefreshTime = 0

	TrainCampQieCuoAgent.instance:sendPM_TC_QueryTeamsReq()
	self:_updateUI()
end

function PkjoinView:_onClickbtnCreateRoom()
	UIStateManager.instance:push(ViewName.PkcreateroomView)
	self:close()
end

function PkjoinView:_onClickbtnRefresh()
	if self._lastRefreshTime > 0 and ServerTime.now() - self._lastRefreshTime < 1 then
		FloatWordMgr.instance:show("刷新太频繁")

		return
	end

	self._lastRefreshTime = ServerTime.now()

	TrainCampQieCuoAgent.instance:sendPM_TC_QueryTeamsReq()
end

function PkjoinView:_onClickbtnQuickJoin()
	if #self._teamviews <= 0 then
		FloatWordMgr.instance:show("当前暂无房间可加入，请刷新试试")

		return
	end

	TrainCampQieCuoAgent.instance:sendPM_TC_QuickJoinReq()
end

function PkjoinView:_onClickbtnClose()
	self:close()
end

function PkjoinView:_updateCell(view, cell, data, tag)
	local btnSure = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSure")
	local goMyHead = goutil.findChild(cell.gameObject, "myHead")
	local goOtherHead = goutil.findChild(cell.gameObject, "otherHead")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtPower = goutil.findChildTextComponent(cell.gameObject, "txtPower")

	txtName.text = TraincampqiecuoConfig.instance:getRoomName(data.teamNameId)
	txtPower.text = string.format("战力PK：%s", data.zdl)

	HeadItemController.instance:resetHeadCell(goMyHead)
	HeadItemController.instance:resetHeadCell(goOtherHead)

	if data.users[1] then
		HeadItemController.instance:setHeadCellByInfo(goMyHead, data.users[1].headInfo)
	end

	if data.users[2] then
		HeadItemController.instance:setHeadCellByInfo(goOtherHead, data.users[2].headInfo)
	end

	btnSure:AddClickListener(function()
		TrainCampQieCuoAgent.instance:sendPM_TC_JoinTeamReq(data.teamId, "")
	end)
end

function PkjoinView:_clearCell(cell)
	local goMyHead = goutil.findChild(cell.gameObject, "myHead")
	local goOtherHead = goutil.findChild(cell.gameObject, "otherHead")

	HeadItemController.instance:resetHeadCell(goMyHead)
	HeadItemController.instance:resetHeadCell(goOtherHead)
end

function PkjoinView:_updateUI()
	local list = TraincampqiecuoModel.instance:getTeamViews() or {}

	self._teamviews = list

	self._scrollerList:reloadData(list)
	goutil.setActive(self._emptyGo, #list <= 0)
end

function PkjoinView:_onJoin()
	self:close()
end

return PkjoinView
