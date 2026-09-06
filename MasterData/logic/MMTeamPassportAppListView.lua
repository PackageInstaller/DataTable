-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportAppListView.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportAppListView", package.seeall)

local MMTeamPassportAppListView = class("MMTeamPassportAppListView", ViewComponent)
local MAX_APPLY_COUNT = 20

function MMTeamPassportAppListView:buildUI()
	MMTeamPassportAppListView.super.buildUI(self)

	self._scrView = self:getGo("playerCol/scrView")
	self._scrCell = self:getGo("playerCol/scrCell")
	self._scrollerList = ScrollerList.create(self._scrView, self._scrCell, GameUtil.handler(self._updateApplyCell, self), GameUtil.handler(self._clearApplyCell, self))
	self._tagEmpty = self:getGo("playerCol/tagEmpty")
	self._inputSearch = self:getInput("InputField")
	self._btnSearchSure = self:getGo("InputField/btnSure")
	self._btnClose = self:getGo("btnClose")
end

function MMTeamPassportAppListView:bindEvents()
	MMTeamPassportAppListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSearchSure, self._onClickBtnSearchSure, self)
end

function MMTeamPassportAppListView:unbindEvents()
	MMTeamPassportAppListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSearchSure)
end

function MMTeamPassportAppListView:onEnter()
	MMTeamPassportAppListView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动信息异常")
		self:close()

		return
	end

	self._subMo = MMTeamPassportController.instance:getSubMo(self._activityId)
	self._searchText = ""

	self._inputSearch:SetText("")

	self._agreedApplyUserIdMap = {}
	self._rejectedApplyUserIdMap = {}
	self._removedApplyUserIdMap = {}
	self._pendingApplyUserIdMap = {}
	self._lastApproveApplyUserIdKey = nil

	self:_refreshApplyList()
	self.addGEvent(self, GlobalNotify.HandlePM_MMTeamPassportOpenApplyListRes, self._onApplyListUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MMTeamPassportApproveApplyRes, self._onApproveApplyRes, self)
	MMTeamPassportController.instance:sendPM_MMTeamPassportOpenApplyListReq(self._activityId)
end

function MMTeamPassportAppListView:onExit()
	MMTeamPassportAppListView.super.onExit(self)
	self._scrollerList:dispose()
end

function MMTeamPassportAppListView:_onApplyListUpdate()
	self:_refreshApplyList()
end

function MMTeamPassportAppListView:_onApproveApplyRes(status, msg)
	local applyUserIdKey = self:_getApproveApplyUserIdKey(msg)

	if string.nilorempty(applyUserIdKey) then
		return
	end

	self._pendingApplyUserIdMap[applyUserIdKey] = nil

	if self._lastApproveApplyUserIdKey == applyUserIdKey then
		self._lastApproveApplyUserIdKey = nil
	end

	if status ~= 0 then
		self._removedApplyUserIdMap[applyUserIdKey] = true

		self:_refreshApplyList()

		return
	end

	if msg.agree then
		self._agreedApplyUserIdMap[applyUserIdKey] = true

		FloatWordMgr.instance:show("已同意该申请。")
	else
		self._rejectedApplyUserIdMap[applyUserIdKey] = true

		FloatWordMgr.instance:show("已拒绝该申请")
	end

	self:_refreshApplyList()
end

function MMTeamPassportAppListView:_refreshApplyList()
	local dataList = {}
	local applyList = self._subMo:getApplyList()

	if not self._searchText then
		for index, applyInfo in ipairs(applyList or {}) do
			if index > MAX_APPLY_COUNT then
				break
			end

			if self:_canShowApplyInfo(applyInfo, self._searchText) then
				table.insert(dataList, applyInfo)
			end
		end

		self._scrollerList:reloadData(dataList)
		GameUtil.SetActive(self._tagEmpty, #dataList <= 0)
	end
end

function MMTeamPassportAppListView:_updateApplyCell(view, cell, applyInfo, tag)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtActiveDay = goutil.findChildTextComponent(mainGo, "txtActiveDay")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local btnCancel = goutil.findChild(mainGo, "btnCancel")
	local headInfo = applyInfo.headInfo

	HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)

	if headInfo then
		txtName.text = headInfo.userName or ""
	end

	txtActiveDay.text = string.format("近期活跃天数：%s", self._subMo:getMemberActiveDay(applyInfo))
	txtProgress.text = string.format("通行证进度：%s", applyInfo.progress)

	GameUtil.SetActive(btnSure, true)
	GameUtil.SetActive(btnCancel, true)
	GameUtil.addClickHandler(btnSure, GameUtil.handler(self._onClickBtnSure, self, applyInfo))
	GameUtil.addClickHandler(btnCancel, GameUtil.handler(self._onClickBtnCancel, self, applyInfo))
end

function MMTeamPassportAppListView:_clearApplyCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local btnCancel = goutil.findChild(mainGo, "btnCancel")

	HeadItemController.instance:resetHeadCell(head)
	GameUtil.SetActive(btnSure, true)
	GameUtil.SetActive(btnCancel, true)
	GameUtil.rmClickHandler(btnSure)
	GameUtil.rmClickHandler(btnCancel)
end

function MMTeamPassportAppListView:_onClickBtnSearchSure()
	self._searchText = self:_getSearchText()

	self:_refreshApplyList()
end

function MMTeamPassportAppListView:_onClickBtnSure(applyInfo)
	if not self:_checkCanAgreeApply(applyInfo) then
		return
	end

	local userName = applyInfo.headInfo.userName
	local content = string.format("是否同意【%s】的加入申请？\n注：该操作无法撤销", userName)

	local function sureFunc()
		if not self:_checkCanAgreeApply(applyInfo) then
			return
		end

		self:_sendApproveApplyReq(applyInfo, true)
	end

	TipsFacade.instance:openPopupWindow("提示", content, sureFunc, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function MMTeamPassportAppListView:_onClickBtnCancel(applyInfo)
	if not self:_checkCanHandleApply(applyInfo) then
		return
	end

	self:_sendApproveApplyReq(applyInfo, false)
end

function MMTeamPassportAppListView:_getSearchText()
	return string.trim(self._inputSearch:GetText() or "")
end

function MMTeamPassportAppListView:_canShowApplyInfo(applyInfo, searchText)
	local applyUserIdKey = self:_getApplyUserIdKey(applyInfo)
	local var_16_0 = self._agreedApplyUserIdMap[applyUserIdKey]

	if not self._agreedApplyUserIdMap[applyUserIdKey] then
		var_16_0 = self._rejectedApplyUserIdMap[applyUserIdKey]

		if not self._rejectedApplyUserIdMap[applyUserIdKey] then
			local isHandled = self._removedApplyUserIdMap[applyUserIdKey]

			return not isHandled and self:_isApplyInfoMatchSearchText(applyInfo, searchText)
		end
	end
end

function MMTeamPassportAppListView:_sendApproveApplyReq(applyInfo, agree)
	local applyUserId = applyInfo.headInfo.userId
	local applyUserIdKey = self:_getApplyUserIdKeyByUserId(applyUserId)

	self._pendingApplyUserIdMap[applyUserIdKey] = true
	self._lastApproveApplyUserIdKey = applyUserIdKey

	MMTeamPassportController.instance:sendPM_MMTeamPassportApproveApplyReq(self._activityId, applyUserId, agree)
end

function MMTeamPassportAppListView:_checkCanAgreeApply(applyInfo)
	if not self:_checkCanHandleApply(applyInfo) then
		return false
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		FloatWordMgr.instance:show("活动已过期")

		return false
	end

	if self._subMo == nil or not self._subMo:isInfoLoaded() or not self._subMo:hasTeamInfo() then
		FloatWordMgr.instance:show("队伍信息已失效")

		return false
	end

	if not self:_isSelfCaptain() then
		FloatWordMgr.instance:show("你已不是队长，无法审批申请")

		return false
	end

	if self._subMo:isTeamFull() then
		FloatWordMgr.instance:show("队伍成员已满，无法同意申请")

		return false
	end

	return true
end

function MMTeamPassportAppListView:_checkCanHandleApply(applyInfo)
	local applyUserIdKey = self:_getApplyUserIdKey(applyInfo)

	if self._agreedApplyUserIdMap[applyUserIdKey] or self._rejectedApplyUserIdMap[applyUserIdKey] then
		FloatWordMgr.instance:show("该申请已处理")

		return false
	end

	if self._pendingApplyUserIdMap[applyUserIdKey] then
		FloatWordMgr.instance:show("该申请正在处理")

		return false
	end

	return true
end

function MMTeamPassportAppListView:_isSelfCaptain()
	if self._subMo then
		local teamInfo = self._subMo:getTeamInfo()

		if self._subMo == nil then
			return false
		end

		return tostring(self._subMo.captainId) == tostring(RoleModel.instance:getUserId())
	end
end

function MMTeamPassportAppListView:_getApplyUserIdKey(applyInfo)
	return self:_getApplyUserIdKeyByUserId(applyInfo.headInfo.userId)
end

function MMTeamPassportAppListView:_getApplyUserIdKeyByUserId(userId)
	return tostring(userId)
end

function MMTeamPassportAppListView:_getApproveApplyUserIdKey(msg)
	local applyUserIdKey = msg and self:_getApplyUserIdKeyByUserId(msg.applyUserId) or ""

	if not string.nilorempty(applyUserIdKey) and applyUserIdKey ~= "0" then
		return applyUserIdKey
	end

	if not string.nilorempty(self._lastApproveApplyUserIdKey) then
		return self._lastApproveApplyUserIdKey
	end

	for applyUserIdKey, _ in pairs(self._pendingApplyUserIdMap or {}) do
		return applyUserIdKey
	end

	return ""
end

function MMTeamPassportAppListView:_isApplyInfoMatchSearchText(applyInfo, searchText)
	local isMatched = self:_isSearchEmpty(searchText)

	if not isMatched then
		local headInfo = applyInfo.headInfo

		isMatched = self:_isUserIdMatchSearchText(headInfo.userId, searchText) or self:_isUserNameMatchSearchText(headInfo.userName, searchText)
	end

	return isMatched
end

function MMTeamPassportAppListView:_isSearchEmpty(searchText)
	return string.nilorempty(searchText)
end

function MMTeamPassportAppListView:_isUserIdMatchSearchText(userId, searchText)
	return MmUtil.isPlainSearchMatch(userId, searchText)
end

function MMTeamPassportAppListView:_isUserNameMatchSearchText(userName, searchText)
	return MmUtil.isSequentialFuzzySearchMatch(userName, searchText)
end

return MMTeamPassportAppListView
