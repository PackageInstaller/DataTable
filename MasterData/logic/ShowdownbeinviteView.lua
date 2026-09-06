-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownbeinviteView.lua

module("logic.extensions.showdown.view.ShowdownbeinviteView", package.seeall)

local ShowdownbeinviteView = class("ShowdownbeinviteView", ViewComponent)

function ShowdownbeinviteView:ctor()
	ShowdownbeinviteView.super.ctor(self)
end

function ShowdownbeinviteView:unbindEvents()
	ShowdownbeinviteView.super.unbindEvents(self)
	self._btnRefresh:RemoveClickListener()
	self._btnJoin:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function ShowdownbeinviteView:bindEvents()
	ShowdownbeinviteView.super.bindEvents(self)
	self._btnRefresh:AddClickListener(self._onClickbtnRefresh, self)
	self._btnJoin:AddClickListener(self._onClickbtnJoin, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ShowdownbeinviteView:buildUI()
	ShowdownbeinviteView.super.buildUI(self)

	self._btnRefresh = self:getBtn("btnRefresh")
	self._btnJoin = self:getBtn("btnJoin")
	self._btnClose = self:getBtn("btnClose")
	self._cellGo = self:getGo("colInvite/cell")
	self._tableviewGo = self:getGo("colInvite/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ShowdownbeinviteView:onExit()
	ShowdownbeinviteView.super.onExit(self)
	self._scrollerList:dispose()
end

function ShowdownbeinviteView:onEnter()
	ShowdownbeinviteView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_GetOrRefreshTeamListRes, self._onGetInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_QuickJoinRes, self._onQuickJoin, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_JoinRes, self._onQuickJoin, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_NotifyJoinTeamRes, self.close, self)
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_GetOrRefreshTeamListReq(self._activityId)
end

function ShowdownbeinviteView:_onGetInfo()
	self._teamList = ShowDownController.instance:getShowDownMo(self._activityId):getTeamList()
	self._reqStateList = {}

	for idx = 1, #self._teamList do
		self._reqStateList[idx] = false
	end

	self:_updateUI()
end

function ShowdownbeinviteView:_onQuickJoin(teamId)
	if teamId > 0 then
		self:close()
	else
		self:_updateUI()
	end
end

function ShowdownbeinviteView:_updateUI()
	self._scrollerList:reloadData(self._teamList)
end

function ShowdownbeinviteView:_onClickbtnRefresh()
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_GetOrRefreshTeamListReq(self._activityId)
end

function ShowdownbeinviteView:_onClickbtnJoin()
	ShowDownQualifyAndTeamAgent.instance:sendPM_ShowDownTeam_QuickJoinReq(self._activityId)
end

function ShowdownbeinviteView:_onClickbtnClose()
	self:close()
end

function ShowdownbeinviteView:_updateCell(view, cellGo, teamSimpleViewMo)
	local index = cellGo.data
	local reqState = self._reqStateList[index]
	local teamName = teamSimpleViewMo:getTeamName()
	local teamIconId = teamSimpleViewMo:getTeamLogo()
	local leaderHeadInfo = teamSimpleViewMo:getLeaderHeadInfo()
	local heatValue = teamSimpleViewMo:getHeatValue()
	local cell = self:_clearCellInvite(cellGo)

	GameUtil.addClickHandler(cell.btnSure, GameUtil.handler(self._onClickHandleApply, self, index, teamSimpleViewMo, true))

	cell.txtName.text = teamSimpleViewMo:getTeamName()

	ShowDownController.instance:setTeamHeadCellRoot(cell.teamIcon, leaderHeadInfo, self._activityId, teamIconId)

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
	local spriteName = string.format("%s.png", heatIconPath)

	uGuiUtil.setSpriteToImage(cell.heatIcon, uGuiUtil.SpriteType.BigBg, spriteName)

	cell.txtHeat.text = heatValue

	GameUtil.SetActive(cell.tagReqing, reqState)
	GameUtil.SetActive(cell.btnSure, not reqState)
end

function ShowdownbeinviteView:_onClickHandleApply(index, teamSimpleViewMo)
	local teamId = teamSimpleViewMo:getTeamId()

	ShowDownController.instance:sendPM_ShowDownTeam_JoinReq(self._activityId, teamId)

	self._reqStateList[index] = true
end

function ShowdownbeinviteView:_clearCell(cell)
	self:_clearCellInvite(cell)
end

function ShowdownbeinviteView:_clearCellInvite(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnCancel = goutil.findChild(cell.go, "btnCancel")
	cell.btnSure = goutil.findChild(cell.go, "btnSure")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtHeat = goutil.findChildTextComponent(cell.go, "txtHeat")
	cell.heatIcon = goutil.findChild(cell.go, "heatIcon")
	cell.teamIcon = goutil.findChild(cell.go, "teamIcon")
	cell.tagReqing = goutil.findChild(cell.go, "tagReqing")

	GameUtil.rmClickHandler(cell.btnSure)
	GameUtil.rmClickHandler(cell.btnCancel)
	ShowDownController.instance:clearTeamHeadCellRoot(cell.teamIcon)
	uGuiUtil.clearImage(cell.heatIcon)

	return cell
end

return ShowdownbeinviteView
