-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/TeamMountInviteView.lua

module("logic.extensions.mount.view.TeamMountInviteView", package.seeall)

local TeamMountInviteView = class("TeamMountInviteView", ViewComponent)

function TeamMountInviteView:ctor()
	TeamMountInviteView.super.ctor(self)
end

function TeamMountInviteView:unbindEvents()
	TeamMountInviteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function TeamMountInviteView:bindEvents()
	TeamMountInviteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
end

function TeamMountInviteView:buildUI()
	TeamMountInviteView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._goEmpty = self:getGo("empty")
	self._goCell = self:getGo("rightInfo/cell")
	self._goTableView = self:getGo("rightInfo/tableview")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TeamMountInviteView:onExit()
	TeamMountInviteView.super.onExit(self)
	self._tableView:dispose()
end

function TeamMountInviteView:onEnter()
	TeamMountInviteView.super.onEnter(self)
	FriendAgent.instance:sendGetBuddyInfoReq()
	self.addGEvent(self, GlobalNotify.FriendInfoGeted, self._onFriendInfoGeted, self)
	self.addGEvent(self, GlobalNotify.TeamMountStatusChanged, self._onTeamMountStatusChanged, self)
end

function TeamMountInviteView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local headItem = goutil.findChild(go, "headItem")
	local headInfo = data.headInfo

	HeadItemController.instance:setHeadCellByInfo(headItem, headInfo, true)

	local txtPower = goutil.findChildTextComponent(go, "txtPower")

	txtPower.text = data.simpleInfo.maxZdl or "0"

	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")

	txtLevel.text = langPara("Lv.%s", headInfo.playerLv)

	local btnInvite = goutil.findChild(go, "btnInvite")
	local txtInvite = goutil.findChildTextComponent(btnInvite, "txt")
	local txtName = goutil.findChildTextComponent(go, "txtName")

	txtName.text = headInfo.userName or ""

	local userId = checknumber(headInfo.userId)

	if self._invitedMap[userId] then
		txtInvite.text = lang("已邀请")

		GameUtil.rmClickHandler(btnInvite)
		GameUtil.SetGray(btnInvite, true)
	else
		txtInvite.text = lang("邀请")

		GameUtil.SetGray(btnInvite, false)
	end

	GameUtil.addClickHandler(btnInvite, GameUtil.handler(self._onClickInvite, self, userId))
end

function TeamMountInviteView:_clearCell(cell)
	local go = cell.gameObject
	local headItem = goutil.findChild(go, "headItem")
	local btnInvite = goutil.findChild(go, "btnInvite")

	HeadItemController.instance:resetHeadCell(headItem)
	GameUtil.rmClickHandler(btnInvite)
end

function TeamMountInviteView:_onFriendInfoGeted()
	self._curDataList = {}
	self._invitedMap = {}

	local areaId = RoleModel.instance:getAreaId()
	local mos = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	for k, v in ipairs(mos) do
		if v:getIsOnline() and v.headInfo.areaId == areaId then
			table.insert(self._curDataList, v)
		end
	end

	self._tableView:reloadData(self._curDataList)
	goutil.setActive(self._goEmpty, #self._curDataList == 0)
end

function TeamMountInviteView:_onClickInvite(userId)
	if self._invitedMap[userId] then
		FloatWordMgr.instance:show("已邀请该玩家")

		return
	end

	MountController.instance:sendMountInviteTeamReq(userId)

	self._invitedMap[userId] = true

	self._tableView:reloadData(self._curDataList)
end

function TeamMountInviteView:_onTeamMountStatusChanged()
	local isInState = MountModel.instance:getIsInTeamMount()

	if isInState then
		FloatWordMgr.instance:show("有玩家加入队伍，邀请结束")
		self:close()
	end
end

return TeamMountInviteView
