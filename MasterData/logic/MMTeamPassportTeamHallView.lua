-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportTeamHallView.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportTeamHallView", package.seeall)

local MMTeamPassportTeamHallView = class("MMTeamPassportTeamHallView", ViewComponent)
local REFRESH_CD = 10

function MMTeamPassportTeamHallView:buildUI()
	MMTeamPassportTeamHallView.super.buildUI(self)

	self._scrView = self:getGo("teamCol/scrView")
	self._scrCell = self:getGo("teamCol/scrCell")
	self._scrollerList = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._tagEmpty = self:getGo("teamCol/tagEmpty")
	self._inputSearch = self:getInput("InputField")
	self._btnSearchSure = self:getGo("InputField/btnSure")
	self._btnRefresh = self:getGo("btnRefesh")
	self._txtRefresh = self:getTxt("btnRefesh/txt")
	self._btnClose = self:getGo("btnClose")
	self._memberScrollerListMap = {}
end

function MMTeamPassportTeamHallView:bindEvents()
	MMTeamPassportTeamHallView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSearchSure, self._onClickBtnSearchSure, self)
end

function MMTeamPassportTeamHallView:unbindEvents()
	MMTeamPassportTeamHallView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSearchSure)
end

function MMTeamPassportTeamHallView:onEnter()
	MMTeamPassportTeamHallView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动信息异常")
		self:close()

		return
	end

	self._subMo = MMTeamPassportController.instance:getSubMo(self._activityId)
	self._appliedCaptainIdMap = {}
	self._refreshLeftTime = 0

	self:_updateRefreshButton()
	self:_refreshTeamList()
	self.addGEvent(self, GlobalNotify.HandlePM_MMTeamPassportGetTeamHallInfoRes, self._onTeamHallInfoUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MMTeamPassportApplyJoinTeamRes, self._onApplyJoinTeamRes, self)

	if #self._subMo:getTeamHallList() <= 0 then
		self:_requestTeamHallList(0)
	end
end

function MMTeamPassportTeamHallView:onExit()
	MMTeamPassportTeamHallView.super.onExit(self)
	removetimer(self._onRefreshCoolDownTick, self)
	self._scrollerList:dispose()
	self:_disposeMemberScrollerLists()
end

function MMTeamPassportTeamHallView:_onTeamHallInfoUpdate()
	MMTeamPassportController.instance:clearApplyJoinFailedCaptains(self._activityId)
	self:_refreshTeamList()
end

function MMTeamPassportTeamHallView:_onApplyJoinTeamRes(status, msg)
	if status ~= 0 then
		return
	end

	FloatWordMgr.instance:show("申请成功！")
	self:_setAppliedTeam(msg and msg.captainId)
	self:_refreshTeamList()
	MMTeamPassportController.instance:sendPM_MMTeamPassportGetInfoReq(self._activityId)
end

function MMTeamPassportTeamHallView:_refreshTeamList()
	local teamList = self:_buildTeamDataList(self._subMo:getTeamHallList())

	self._scrollerList:reloadData(teamList)
	GameUtil.SetActive(self._tagEmpty, #teamList <= 0)
end

function MMTeamPassportTeamHallView:_requestTeamHallList(searchCaptainId)
	if string.nilorempty(searchCaptainId) then
		return false
	end

	MMTeamPassportController.instance:sendPM_MMTeamPassportGetTeamHallInfoReq(self._activityId, searchCaptainId)
	MMTeamPassportController.instance:clearApplyJoinFailedCaptains(self._activityId)

	return true
end

function MMTeamPassportTeamHallView:_getSearchCaptainId()
	local searchText = string.trim(self._inputSearch:GetText() or "")

	if string.nilorempty(searchText) then
		return 0
	end

	if not string.match(searchText, "^%d+$") then
		FloatWordMgr.instance:show("请输入正确的队长ID")

		return nil
	end

	return searchText
end

function MMTeamPassportTeamHallView:_updateTeamCell(view, cell, teamData, tag)
	local mainGo = cell.gameObject
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local btnJoin = goutil.findChild(mainGo, "btnJoin")
	local txtJoin = goutil.findChildTextComponent(mainGo, "btnJoin/txt")
	local memberScrView = goutil.findChild(mainGo, "member/scrView")
	local memberScrCell = goutil.findChild(mainGo, "member/scrCell")
	local memberScrollerList = self:_getMemberScrollerList(mainGo, memberScrView, memberScrCell)
	local maxMemberCount = MMTeamPassportController.instance:getTeamMaxMemberCount()
	local isApplied = self:_isAppliedTeam(teamData.captainId)

	txtCount.text = string.format("队伍人数：%s/%s", teamData.memberCount, maxMemberCount)
	txtScore.text = string.format("通行证进度：%s", teamData.totalProgress)
	txtJoin.text = isApplied and "已申请" or "申请加入"

	GameUtil.SetGray(btnJoin, isApplied)
	GameUtil.addClickHandler(btnJoin, GameUtil.handler(self._onClickBtnJoinTeam, self, teamData))
	memberScrollerList:reloadData(teamData.memberSlotList)
end

function MMTeamPassportTeamHallView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local btnJoin = goutil.findChild(mainGo, "btnJoin")

	GameUtil.rmClickHandler(btnJoin)
	GameUtil.SetGray(btnJoin, false)
	self:_disposeMemberScrollerList(mainGo)
end

function MMTeamPassportTeamHallView:_updateMemberCell(view, cell, slotData, tag)
	local mainGo = cell.gameObject
	local content = goutil.findChild(mainGo, "content")
	local empty = goutil.findChild(mainGo, "empty")
	local head = goutil.findChild(content, "head")
	local txtName = goutil.findChildTextComponent(content, "txtName")

	self:_clearMemberCell(cell)

	local memberInfo = slotData.memberInfo
	local hasMember = memberInfo ~= nil

	GameUtil.SetActive(content, hasMember)
	GameUtil.SetActive(empty, not hasMember)

	if hasMember then
		local headInfo = memberInfo.headInfo

		HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)

		if headInfo then
			txtName.text = headInfo.userName or ""
		end
	end
end

function MMTeamPassportTeamHallView:_clearMemberCell(cell)
	local mainGo = cell.gameObject
	local content = goutil.findChild(mainGo, "content")
	local head = goutil.findChild(content, "head")
	local txtName = goutil.findChildTextComponent(content, "txtName")

	HeadItemController.instance:resetHeadCell(head)

	txtName.text = ""
end

function MMTeamPassportTeamHallView:_onClickBtnJoinTeam(teamData)
	local captainId = teamData.captainId

	if not MMTeamPassportController.instance:checkCanApplyJoinOtherTeam(self._activityId) then
		return
	end

	if self:_isAppliedTeam(captainId) then
		return
	end

	if string.nilorempty(captainId) then
		FloatWordMgr.instance:show("队伍信息已失效")

		return
	end

	if captainId == tostring(RoleModel.instance:getUserId()) then
		FloatWordMgr.instance:show("无法加入自己的队伍")

		return
	end

	if teamData.memberCount >= MMTeamPassportController.instance:getTeamMaxMemberCount() then
		FloatWordMgr.instance:show("队伍成员已满，无需加入/邀请")

		return
	end

	MMTeamPassportController.instance:trySendPM_MMTeamPassportApplyJoinTeamReq(self._activityId, captainId)
end

function MMTeamPassportTeamHallView:_onClickBtnRefresh()
	if self._refreshLeftTime > 0 then
		FloatWordMgr.instance:show("请稍后再刷新")

		return
	end

	if self:_requestTeamHallList(0) then
		self:_startRefreshCoolDown()
	end
end

function MMTeamPassportTeamHallView:_onClickBtnSearchSure()
	self:_requestTeamHallList(self:_getSearchCaptainId())
end

function MMTeamPassportTeamHallView:_startRefreshCoolDown()
	self._refreshLeftTime = REFRESH_CD

	self:_updateRefreshButton()
	removetimer(self._onRefreshCoolDownTick, self)
	settimer(1, self._onRefreshCoolDownTick, self, true)
end

function MMTeamPassportTeamHallView:_onRefreshCoolDownTick()
	self._refreshLeftTime = math.max(0, self._refreshLeftTime - 1)

	self:_updateRefreshButton()

	if self._refreshLeftTime <= 0 then
		removetimer(self._onRefreshCoolDownTick, self)
	end
end

function MMTeamPassportTeamHallView:_updateRefreshButton()
	local isCoolDown = self._refreshLeftTime > 0

	GameUtil.SetGray(self._btnRefresh, isCoolDown)

	self._txtRefresh.text = isCoolDown and string.format("刷新%s", self._refreshLeftTime) or "刷新"
end

function MMTeamPassportTeamHallView:_buildTeamDataList(teamList)
	local dataList = {}

	for _, teamInfo in ipairs(teamList or {}) do
		local memberList = self:_buildMemberList(teamInfo)

		table.insert(dataList, {
			captainId = self:_getCaptainId(teamInfo),
			memberCount = #memberList,
			totalProgress = self:_getTeamTotalProgress(memberList),
			memberSlotList = self:_buildMemberSlotList(memberList)
		})
	end

	return dataList
end

function MMTeamPassportTeamHallView:_buildMemberSlotList(memberList)
	local slotList = {}

	for index = 1, MMTeamPassportController.instance:getTeamMaxMemberCount() do
		table.insert(slotList, {
			memberInfo = memberList[index]
		})
	end

	return slotList
end

function MMTeamPassportTeamHallView:_buildMemberList(teamInfo)
	local list = {}
	local captainId = self:_getCaptainId(teamInfo)
	local captainInfo

	for _, memberInfo in ipairs(teamInfo.memberList or {}) do
		if tostring(self:_getMemberUserId(memberInfo)) == captainId then
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

function MMTeamPassportTeamHallView:_getMemberScrollerList(mainGo, scrView, scrCell)
	local key = mainGo:GetInstanceID()
	local scrollerList = self._memberScrollerListMap[key]

	if scrollerList == nil then
		scrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateMemberCell, self), GameUtil.handler(self._clearMemberCell, self))

		scrollerList:dragNotifyParent()

		self._memberScrollerListMap[key] = scrollerList
	end

	return scrollerList
end

function MMTeamPassportTeamHallView:_disposeMemberScrollerList(mainGo)
	local key = mainGo:GetInstanceID()
	local scrollerList = self._memberScrollerListMap[key]

	if scrollerList then
		scrollerList:dispose()

		self._memberScrollerListMap[key] = nil
	end
end

function MMTeamPassportTeamHallView:_disposeMemberScrollerLists()
	for key, scrollerList in pairs(self._memberScrollerListMap or {}) do
		scrollerList:dispose()

		self._memberScrollerListMap[key] = nil
	end
end

function MMTeamPassportTeamHallView:_getTeamTotalProgress(memberList)
	local progress = 0

	for _, memberInfo in ipairs(memberList or {}) do
		progress = progress + checknumber(memberInfo.progress)
	end

	return progress
end

function MMTeamPassportTeamHallView:_getCaptainId(teamInfo)
	if teamInfo == nil or teamInfo.captainId == nil then
		return ""
	end

	return tostring(teamInfo.captainId)
end

function MMTeamPassportTeamHallView:_getMemberUserId(memberInfo)
	if memberInfo == nil or memberInfo.headInfo == nil then
		return nil
	end

	return memberInfo.headInfo.userId
end

function MMTeamPassportTeamHallView:_setAppliedTeam(captainId)
	if captainId == nil then
		return
	end

	self._appliedCaptainIdMap[tostring(captainId)] = true
end

function MMTeamPassportTeamHallView:_isAppliedTeam(captainId)
	return self._appliedCaptainIdMap[tostring(captainId)] == true
end

return MMTeamPassportTeamHallView
