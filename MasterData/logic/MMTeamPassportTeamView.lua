-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportTeamView.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportTeamView", package.seeall)

local MMTeamPassportTeamView = class("MMTeamPassportTeamView", ViewComponent)
local SHARE_CD = 10

function MMTeamPassportTeamView:buildUI()
	MMTeamPassportTeamView.super.buildUI(self)

	self._teamCells = {}

	for index = 1, MMTeamPassportController.instance:getTeamMaxMemberCount() do
		local rootPath = string.format("teamCell%s", index)
		local root = self:getGo(rootPath)
		local content = goutil.findChild(root, "content")
		local cell = {}

		cell.root = root
		cell.content = content
		cell.empty = goutil.findChild(root, "empty")
		cell.head = goutil.findChild(content, "head")
		cell.txtName = goutil.findChildTextComponent(content, "txtName")
		cell.tagCaptain = goutil.findChild(content, "tagCaptain")
		cell.tagMember = goutil.findChild(content, "tagMember")
		cell.tagMe = goutil.findChild(content, "tagMe")
		cell.txtProgress = goutil.findChildTextComponent(content, "txtProgress")
		self._teamCells[index] = cell
	end

	self._txtTeamCount = self:getTxt("teamCount/txt")
	self._btns = self:getGo("btns")
	self._btnJoin = self:getGo("btns/btnJoin")
	self._btnShare = self:getGo("btns/btnShare")
	self._btnFriend = self:getGo("btns/btnFriend")
	self._btnApplyList = self:getGo("btns/btnApplyList")
	self._redApplyList = self:getGo("btns/btnApplyList/redpoint")
end

function MMTeamPassportTeamView:bindEvents()
	MMTeamPassportTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJoin, self._onClickBtnJoin, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._btnFriend, self._onClickBtnFriend, self)
	GameUtil.addClickHandler(self._btnApplyList, self._onClickBtnApplyList, self)
end

function MMTeamPassportTeamView:unbindEvents()
	MMTeamPassportTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJoin)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnFriend)
	GameUtil.rmClickHandler(self._btnApplyList)
end

function MMTeamPassportTeamView:onEnter()
	MMTeamPassportTeamView.super.onEnter(self)

	self._activityId = MMTeamPassportController.instance:getActivityId()
	self._subMo = MMTeamPassportController.instance:getSubMo(self._activityId)
	self._shareLeftTime = 0

	RedPointController.instance:regRedPoint(self._redApplyList, RedPointModel.ID_MMTEAM_PASSPORT_APPLY)
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_MMTeamPassportGetInfoRes, self._onTeamInfoUpdate, self)
	MMTeamPassportController.instance:sendPM_MMTeamPassportGetInfoReq(self._activityId)
end

function MMTeamPassportTeamView:onExit()
	MMTeamPassportTeamView.super.onExit(self)
	removetimer(self._onShareCoolDownTick, self)
	RedPointController.instance:unregRedPoint(self._redApplyList)
	self:_resetHeadCells()
end

function MMTeamPassportTeamView:_onTeamInfoUpdate()
	self:_onUpdate()
end

function MMTeamPassportTeamView:_onUpdate()
	self._memberList = self:_buildMemberList()

	for index, cell in ipairs(self._teamCells) do
		self:_updateTeamCell(cell, self._memberList[index], index)
	end

	self._txtTeamCount.text = string.format("队伍人数：%s/%s", #self._memberList, MMTeamPassportController.instance:getTeamMaxMemberCount())

	self:_updateButtonState()
end

function MMTeamPassportTeamView:_buildMemberList()
	if self._subMo then
		local teamInfo = self._subMo:getTeamInfo()
		local list = {}

		if teamInfo == nil then
			return list
		end

		local captainId = tostring(teamInfo.captainId)
		local captainInfo

		for _, memberInfo in ipairs(teamInfo.memberList or {}) do
			local userId = self:_getMemberUserId(memberInfo)

			if tostring(userId) == captainId then
				captainInfo = memberInfo
			else
				table.insert(list, memberInfo)
			end
		end

		if captainInfo then
			table.insert(list, 1, captainInfo)
		end

		return list
	end
end

function MMTeamPassportTeamView:_updateTeamCell(cell, memberInfo, index)
	HeadItemController.instance:resetHeadCell(cell.head)

	local hasMember = memberInfo ~= nil

	GameUtil.SetActive(cell.content, hasMember)
	GameUtil.SetActive(cell.empty, not hasMember)

	if hasMember then
		local headInfo = memberInfo.headInfo

		HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo, true)

		if headInfo then
			cell.txtName.text = headInfo.userName or ""
		end

		GameUtil.SetActive(cell.tagCaptain, index == 1)
		GameUtil.SetActive(cell.tagMember, index ~= 1)
		GameUtil.SetActive(cell.tagMe, tostring(self:_getMemberUserId(memberInfo)) == tostring(RoleModel.instance:getUserId()))

		cell.txtProgress.text = string.format("通行证进度：%s", memberInfo.progress)
	end
end

function MMTeamPassportTeamView:_updateButtonState()
	local isTeamFull = self._subMo and self._subMo:isTeamFull() or false
	local isSelfCaptain = self:_isSelfCaptain()

	GameUtil.SetActive(self._btns, isSelfCaptain and not isTeamFull)
	GameUtil.SetGray(self._btnJoin, isTeamFull)
	self:_updateShareButtonState()
	GameUtil.SetGray(self._btnFriend, isTeamFull)
end

function MMTeamPassportTeamView:_resetHeadCells()
	for _, cell in ipairs(self._teamCells) do
		HeadItemController.instance:resetHeadCell(cell.head)
	end
end

function MMTeamPassportTeamView:_onClickBtnShare()
	if self:_checkTeamFullForInvite() then
		return
	end

	if checknumber(self._shareLeftTime) > 0 then
		FloatWordMgr.instance:show("请稍后再发送")

		return
	end

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Share, GameEnum.ChatType.System, GameUtil.jsonToString(MMTeamPassportController.instance:getTeamInviteDataT(self._activityId)))
	FloatWordMgr.instance:show("已发送至分享频道")
	self:_startShareCoolDown()
end

function MMTeamPassportTeamView:_onClickBtnFriend()
	if self:_checkTeamFullForInvite() then
		return
	end

	ShareController.instance:tryOpenFriendView(MMTeamPassportController.instance:getTeamInviteDataT(self._activityId))
end

function MMTeamPassportTeamView:_onClickBtnJoin()
	if self:_checkTeamFullForInvite() then
		return
	end

	UIStateManager.instance:push(ViewName.MMTeamPassportTeamHallView, self._activityId)
end

function MMTeamPassportTeamView:_onClickBtnApplyList()
	UIStateManager.instance:push(ViewName.MMTeamPassportAppListView, self._activityId)
end

function MMTeamPassportTeamView:_checkTeamFullForInvite()
	if self._subMo:isTeamFull() then
		FloatWordMgr.instance:show("队伍成员已满，无需加入/邀请")

		return true
	end

	return false
end

function MMTeamPassportTeamView:_startShareCoolDown()
	self._shareLeftTime = SHARE_CD

	self:_updateShareButtonState()
	removetimer(self._onShareCoolDownTick, self)
	settimer(1, self._onShareCoolDownTick, self, true)
end

function MMTeamPassportTeamView:_onShareCoolDownTick()
	self._shareLeftTime = math.max(0, self._shareLeftTime - 1)

	self:_updateShareButtonState()

	if self._shareLeftTime <= 0 then
		removetimer(self._onShareCoolDownTick, self)
	end
end

function MMTeamPassportTeamView:_updateShareButtonState()
	local isTeamFull = self._subMo and self._subMo:isTeamFull() or false
	local isCoolDown = checknumber(self._shareLeftTime) > 0

	GameUtil.SetGray(self._btnShare, isTeamFull or isCoolDown)
end

function MMTeamPassportTeamView:_isSelfCaptain()
	if self._subMo then
		local teamInfo = self._subMo:getTeamInfo()

		if self._subMo == nil then
			return false
		end

		return tostring(self._subMo.captainId) == tostring(RoleModel.instance:getUserId())
	end
end

function MMTeamPassportTeamView:_getMemberUserId(memberInfo)
	if memberInfo == nil or memberInfo.headInfo == nil then
		return nil
	end

	return memberInfo.headInfo.userId
end

return MMTeamPassportTeamView
