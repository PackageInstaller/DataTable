-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamInviteView.lua

module("logic.extensions.formteam.view.FormTeamInviteView", package.seeall)

local FormTeamInviteView = class("FormTeamInviteView", ViewComponent)

function FormTeamInviteView:buildUI()
	FormTeamInviteView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnFamily = self:getGo("btnFamily")
	self._btnFriend = self:getGo("btnFriend")
	self._goEmpty = self:getGo("empty")
	self._changeFamily = self._btnFamily:GetComponent("UIChangeGroup")
	self._changeFriend = self._btnFriend:GetComponent("UIChangeGroup")
	self._goCell = self:getGo("rightInfo/cell")
	self._goTableView = self:getGo("rightInfo/tableview")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FormTeamInviteView:bindEvents()
	FormTeamInviteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnFamily, self._onClickFamily, self)
	GameUtil.addClickHandler(self._btnFriend, self._onClickFriend, self)
end

function FormTeamInviteView:unbindEvents()
	FormTeamInviteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnFamily)
	GameUtil.rmClickHandler(self._btnFriend)
end

function FormTeamInviteView:onEnter()
	FormTeamInviteView.super.onEnter(self)

	self._curShowFamily = false

	goutil.setActive(self._btnFamily, FamilyModel.instance:isInFamily())
	self:_refreshviewBySendInfo()
	GlobalDispatcher:addListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamGetOnlineFamilyList, self._refreshInfoList, self)
end

function FormTeamInviteView:onExit()
	FormTeamInviteView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamGetOnlineFamilyList, self._refreshInfoList, self)
end

function FormTeamInviteView:_onError(staus)
	return
end

function FormTeamInviteView:_onClickFriend()
	self._curShowFamily = false

	self:_refreshviewBySendInfo()
end

function FormTeamInviteView:_onClickFamily()
	self._curShowFamily = true

	self:_refreshviewBySendInfo()
end

function FormTeamInviteView:_refreshviewBySendInfo()
	self._hasInviteData = FormTeamModel.instance:getCurTeamInfo().hasInvitedUserIds

	if self._curShowFamily then
		self._changeFamily:SetState(1)
		self._changeFriend:SetState(0)
		FormTeamController.instance:getOnlineFamilyList()
	else
		self._changeFamily:SetState(0)
		self._changeFriend:SetState(1)
		FormTeamController.instance:getOnlineBuddiesZdl()
		self:_refreshInfoList()
	end
end

function FormTeamInviteView:_getCurDataList()
	local dataList = {}
	local teamDataList = {}
	local curTeamInfo = FormTeamModel.instance:getCurTeamInfo()

	teamDataList = FormTeamModel.instance:getCurOnlineFailyMemberList()

	for k, v in ipairs(self._curShowFamily and FormTeamModel.instance:getCurOnlineFailyMemberList() or FormTeamModel.instance:getCurOnlineBuddiesList()) do
		if not curTeamInfo:getTeammateInfoByUserId(v.headInfo.userId) then
			table.insert(dataList, v)
		end
	end

	return dataList
end

function FormTeamInviteView:_refreshInfoList()
	local dataList = self:_getCurDataList()

	self._tableView:reloadData(dataList)
	goutil.setActive(self._goEmpty, #dataList <= 0)
end

function FormTeamInviteView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local headInfo = data.headInfo

	cell.txtPower.text = data.zdl

	HeadItemController.instance:setHeadCellByInfo(cell.headItem, headInfo)

	cell.txtArea.text = headInfo.areaName
	cell.txtLevel.text = langPara("Lv.%s", headInfo.playerLv)
	cell.txtName.text = headInfo.userName

	GameUtil.addClickHandler(cell.btnInvite, GameUtil.handler(self._onClickInvite, self, data))

	cell.txtInvite.text = table.keyof(self._hasInviteData, headInfo.userId) and lang("已邀请") or lang("邀请")
end

function FormTeamInviteView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.headItem = goutil.findChild(cell.go, "headItem")
	cell.btnInvite = goutil.findChild(cell.go, "btnInvite")
	cell.txtInvite = goutil.findChildTextComponent(cell.btnInvite, "txt")
	cell.txtArea = goutil.findChildTextComponent(cell.go, "txtName/area/txt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtPower = goutil.findChildTextComponent(cell.go, "txtPower")
	cell.txtLevel = goutil.findChildTextComponent(cell.go, "txtLevel")

	HeadItemController.instance:resetHeadCell(cell.headItem)
	GameUtil.rmClickHandler(cell.btnInvite)

	return cell
end

function FormTeamInviteView:_onClickInvite(data)
	local userId = tostring(data.headInfo.userId)

	if table.keyof(self._hasInviteData, userId) then
		FloatWordMgr.instance:show(lang("已邀请该玩家"))
	else
		table.insert(self._hasInviteData, userId)
		self._tableView:refresh()
		FormTeamController.instance:inviteJoinTeam(userId)
	end
end

return FormTeamInviteView
