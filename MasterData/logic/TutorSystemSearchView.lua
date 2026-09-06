-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemSearchView.lua

module("logic.extensions.tutorsystem.view.TutorSystemSearchView", package.seeall)

local TutorSystemSearchView = class("TutorSystemSearchView", ViewComponent)
local ViewUser = {
	Tourist = 3,
	Student = 1,
	Teacher = 2
}
local ViewState = {
	Searching = 2,
	Normal = 1
}
local ViewPower = {
	Nothing = 1,
	Medium = 3,
	Low = 2,
	High = 4
}
local InfoType = {
	Recommend = 2,
	Search = 3,
	Request = 1
}

function TutorSystemSearchView:buildUI()
	TutorSystemSearchView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnRefresh = goutil.findChild(self.mainGO, "btnRefresh")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._InputField = goutil.findChild(self.mainGO, "InputField")
	self._InputFieldAdapter = self:getInput("InputField")
	self._btnCancel = goutil.findChild(self.mainGO, "InputField/btnCancel")
	self._btnSearch = goutil.findChild(self.mainGO, "InputField/btnSearch")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "InputField/txtTip")
	self._nameCol = goutil.findChild(self.mainGO, "contentCol/nameCol")
	self._nameScrollercell = goutil.findChild(self.mainGO, "contentCol/nameCol/nameScrollercell")
	self._nameScrollerview = goutil.findChild(self.mainGO, "contentCol/nameCol/nameScrollerview")
	self._nameContent = goutil.findChild(self.mainGO, "contentCol/nameCol/nameScrollerview/Viewport/Content")
	self._searchCol = goutil.findChild(self.mainGO, "contentCol/searchCol")
	self._searchScrollercell = goutil.findChild(self.mainGO, "contentCol/searchCol/searchScrollercell")
	self._searchScrollerview = goutil.findChild(self.mainGO, "contentCol/searchCol/searchScrollerview")
	self._imgEmptyInSearchCol = goutil.findChild(self.mainGO, "contentCol/searchCol/topCol/imgEmpty")
	self._btnBackInSearchCol = goutil.findChild(self.mainGO, "contentCol/searchCol/topCol/btnBack")

	GameUtil.SetActive(self._nameScrollercell, false)
	GameUtil.SetActive(self._nameCol, false)
	GameUtil.SetActive(self._searchCol, false)

	self._searchScrollList = ScrollerList.create(self._searchScrollerview, self._searchScrollercell, GameUtil.handler(self._updateSearchCell, self), GameUtil.handler(self._clearSearchCell, self))
end

function TutorSystemSearchView:bindEvents()
	TutorSystemSearchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickBtnRefresh, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSearch, self._onClickBtnSearch, self)
	GameUtil.addClickHandler(self._btnBackInSearchCol, self._onClickBtnBack, self)
	self._InputFieldAdapter:AddOnValueChanged(self._onValueChanged, self)
end

function TutorSystemSearchView:unbindEvents()
	TutorSystemSearchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSearch)
	GameUtil.rmClickHandler(self._btnBackInSearchCol)
	self._InputFieldAdapter:RemoveOnValueChanged()
end

function TutorSystemSearchView:onEnter()
	TutorSystemSearchView.super.onEnter(self)
	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.TutorMainInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorRecommendRes, self._handleRequestAndRecommendListRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorReceivedRequestRes, self._handleRequestAndRecommendListRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorSearchRes, self._handleSearchListRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorHandleRequestRes, self._handleRequestRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorSendRequestRes, self._handleSendRequestRes, self)
	self:_sendRecommendListReq()
	self:_sendRequestListReq()
end

function TutorSystemSearchView:onExit()
	TutorSystemSearchView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorMainInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorRecommendRes, self._handleRequestAndRecommendListRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorReceivedRequestRes, self._handleRequestAndRecommendListRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorSearchRes, self._handleSearchListRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorHandleRequestRes, self._handleRequestRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorSendRequestRes, self._handleSendRequestRes, self)
	self:_clearNameCol()
	self:_clearSearchCol()
end

function TutorSystemSearchView:_sendRequestListReq()
	self:_onUpdateViewInfo()

	if not self:_isCanReceivedRequest() then
		return
	end

	TutorSystemController.instance:sendTutorReceivedRequestReq(self._curViewUser)
end

function TutorSystemSearchView:_sendRecommendListReq()
	self:_onUpdateViewInfo()

	if not self:_isCanReceivedRecommend() then
		return
	end

	TutorSystemController.instance:sendTutorRecommendReq(self._curViewUser)
end

function TutorSystemSearchView:_onSetUI()
	self:_setInputField("")
end

function TutorSystemSearchView:_onUpdate()
	self:_onUpdateViewInfo()
	self:_checkUserQuals()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TutorSystemSearchView:_onUpdateData()
	self:_onUpdatePlayInfoList()
	self:_onUpdateNameColData()
	self:_onUpdateSearchColData()
end

function TutorSystemSearchView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateNameCol()
	self:_onUpdateSearchCol()
end

function TutorSystemSearchView:_onUpdatePlaneUI()
	local titleStr = ""
	local searchTipsStr = ""

	if self._curViewUser == ViewUser.Student then
		titleStr = "老师名单"
		searchTipsStr = "搜索老师"
	elseif self._curViewUser == ViewUser.Teacher then
		titleStr = "学生名单"
		searchTipsStr = "搜索学生"
	elseif self._curViewUser == ViewUser.Tourist then
		titleStr = "搜索终端"
		searchTipsStr = "无权搜索"
	end

	self._txtTitle.text = titleStr
	self._txtTip.text = searchTipsStr

	if self._curViewState == ViewState.Normal then
		GameUtil.SetActive(self._nameCol, true)
		GameUtil.SetActive(self._searchCol, false)
	elseif self._curViewState == ViewState.Searching then
		GameUtil.SetActive(self._nameCol, false)
		GameUtil.SetActive(self._searchCol, true)
	end
end

function TutorSystemSearchView:_checkUserQuals()
	if self._curViewUser == ViewUser.Tourist or self._curViewPower <= ViewPower.Medium then
		self:close()

		return
	end
end

function TutorSystemSearchView:_onUpdateViewInfo()
	local curViewUser = ViewUser.Tourist
	local curViewPower = ViewPower.Nothing

	if not self._curViewState then
		local curViewState = ViewState.Normal
		local myIdentityType = TutorSystemModel.instance:getMyIdentityType()
		local myIdentityState = TutorSystemModel.instance:getMyIdentityState()

		if myIdentityType == GameEnum.IdentityType.Student then
			curViewUser = ViewUser.Student

			if myIdentityState == GameEnum.IdentityState.IsStudying then
				curViewPower = ViewPower.Low
			end
		elseif myIdentityType == GameEnum.IdentityType.Teacher then
			curViewUser = ViewUser.Teacher

			if myIdentityState == GameEnum.IdentityState.Recruiting then
				curViewPower = ViewPower.High
			elseif myIdentityState == GameEnum.IdentityState.NotRecruiting then
				curViewPower = ViewPower.Low
			end
		elseif myIdentityType == GameEnum.IdentityType.FreeMan then
			if myIdentityState == GameEnum.IdentityState.TeaQuals then
				curViewUser = ViewUser.Teacher
				curViewPower = ViewPower.High
			elseif myIdentityState == GameEnum.IdentityState.StuQuals then
				curViewUser = ViewUser.Student
				curViewPower = ViewPower.High
			elseif myIdentityState == GameEnum.IdentityState.NoStuTeaQuals then
				curViewUser = ViewUser.Tourist
				curViewPower = ViewPower.Nothing
			end
		end

		self._curViewUser = curViewUser
		self._curViewPower = curViewPower
		self._curViewState = curViewState
	end
end

function TutorSystemSearchView:_isCanReceivedRequest()
	return self._curViewPower >= ViewPower.Low and self._curViewUser <= ViewUser.Teacher
end

function TutorSystemSearchView:_isCanReceivedRecommend()
	return self._curViewPower >= ViewPower.Medium and self._curViewUser <= ViewUser.Teacher
end

function TutorSystemSearchView:_isCanSearch()
	return self._curViewPower >= ViewPower.High and self._curViewUser <= ViewUser.Teacher
end

function TutorSystemSearchView:_handleRequestRes(msg)
	if msg.result == 0 then
		if msg.action == 1 then
			if self._curViewUser == ViewUser.Student then
				TutorSystemController.instance:popTipByKey(GameEnum.TsNotifyKey.RecruitTea)
			elseif self._curViewUser == ViewUser.Teacher then
				TutorSystemController.instance:popTipByKey(GameEnum.TsNotifyKey.RecruitStu)
			end

			self:close()
		elseif msg.action == 2 then
			self:_sendRequestListReq()
		end
	elseif msg.result ~= 0 then
		local tipsStr = ""

		if msg.result == -29907 then
			if self._curViewUser == ViewUser.Student then
				tipsStr = "对方不满足条件，拜师失败"
			elseif self._curViewUser == ViewUser.Teacher then
				tipsStr = "对方不满足条件，收徒失败"
			end
		else
			tipsStr = TutorSystemConfig.instance:getTsTipsValue(msg.result)
		end

		if not string.nilorempty(tipsStr) then
			FloatWordMgr.instance:show(tipsStr)
		end

		self:_sendRequestListReq()

		return
	end
end

function TutorSystemSearchView:_handleSendRequestRes(msg)
	local userId = msg.userId
	local resultTips = TutorSystemConfig.instance:getTsTipsValue(msg.result)

	self:_setAboutInfoList(InfoType.Recommend, resultTips, userId)
	self:_setAboutInfoList(InfoType.Search, resultTips, userId)
	self:_onUpdateViewInfo()
	self:_onUpdateUI()
end

function TutorSystemSearchView:_handleRequestAndRecommendListRes()
	self._curViewState = ViewState.Normal

	self:_onUpdate()
end

function TutorSystemSearchView:_handleSearchListRes()
	self._curViewState = ViewState.Searching

	self:_onUpdate()
end

function TutorSystemSearchView:_setAboutInfoList(infoType, resultTips, targetUserId)
	local infoList = self:_getPlayInfoList(infoType)

	if infoList == nil then
		printError("错误,目标为nil")

		return
	end

	for index, info in ipairs(infoList) do
		if self:_getPlayInfoUserId(infoType, index) == targetUserId then
			self:_setPlayInfoResultTips(infoType, index, resultTips)
		end
	end
end

function TutorSystemSearchView:_onUpdatePlayInfoList()
	self._playInfoList = {}

	local infoList = {}
	local requestList = TutorSystemModel.instance:getRequestList()

	for _, data in ipairs(requestList) do
		local info = {
			infoType = InfoType.Request,
			infoIndex = #infoList + 1,
			resultTips = TutorSystemConfig.instance:getTsTipsValue(1),
			data = data
		}

		table.insert(infoList, info)
	end

	self._playInfoList[InfoType.Request] = infoList
	infoList = {}

	local recommendList = TutorSystemModel.instance:getRecommendList()

	for _, data in ipairs(recommendList) do
		local info = {
			infoType = InfoType.Recommend,
			infoIndex = #infoList + 1,
			resultTips = TutorSystemConfig.instance:getTsTipsValue(1),
			data = data
		}

		table.insert(infoList, info)
	end

	self._playInfoList[InfoType.Recommend] = infoList
	infoList = {}

	local searchList = TutorSystemModel.instance:getSearchList()

	for _, data in ipairs(searchList) do
		local info = {
			infoType = InfoType.Search,
			infoIndex = #infoList + 1,
			resultTips = TutorSystemConfig.instance:getTsTipsValue(1),
			data = data
		}

		table.insert(infoList, info)
	end

	self._playInfoList[InfoType.Search] = infoList
end

function TutorSystemSearchView:_getPlayInfoList(type)
	return self._playInfoList[type]
end

function TutorSystemSearchView:_getPlayInfo(type, index)
	return self._playInfoList[type][index]
end

function TutorSystemSearchView:_getPlayInfoData(type, index)
	return self._playInfoList[type][index].data
end

function TutorSystemSearchView:_getPlayInfoUserId(type, index)
	return self._playInfoList[type][index].data.headInfo.userId
end

function TutorSystemSearchView:_getPlayInfoType(type, index)
	return self._playInfoList[type][index].infoType
end

function TutorSystemSearchView:_isPlayInfoHasSend(type, index)
	local resultTips = self:_getPlayInfoResultTips(type, index)

	return resultTips ~= TutorSystemConfig.instance:getTsTipsValue(1)
end

function TutorSystemSearchView:_setPlayInfoResultTips(type, index, resultTips)
	self._playInfoList[type][index].resultTips = resultTips
end

function TutorSystemSearchView:_getPlayInfoResultTips(type, index)
	return self._playInfoList[type][index].resultTips
end

function TutorSystemSearchView:_onUpdateNameColData()
	return
end

function TutorSystemSearchView:_onUpdateNameCol()
	local moList = {}

	for _, info in ipairs(self:_getPlayInfoList(InfoType.Request)) do
		if info.resultTips == TutorSystemConfig.instance:getTsTipsValue(1) then
			local mo = {
				isNeedShowTag = false,
				infoType = info.infoType,
				infoIndex = info.infoIndex
			}

			table.insert(moList, mo)
		end
	end

	for _, info in ipairs(self:_getPlayInfoList(InfoType.Recommend)) do
		local mo = {
			isNeedShowTag = false,
			infoType = info.infoType,
			infoIndex = info.infoIndex
		}

		table.insert(moList, mo)
	end

	local requestListLength = #self:_getPlayInfoList(InfoType.Request)
	local recommendListLength = #self:_getPlayInfoList(InfoType.Recommend)

	if #moList > 0 then
		moList[1].isNeedShowTag = true
	end

	if recommendListLength > 0 then
		moList[requestListLength + 1].isNeedShowTag = true
	end

	local childList = GameUtil.getChildren(self._nameContent)

	for idx, go in ipairs(childList) do
		if idx > #moList then
			GameUtil.SetActive(go, false)
		end
	end

	for idx = 1, #moList do
		local mo = moList[idx]

		if not childList[idx] then
			local mainGo = goutil.cloneAndSetParent(self._nameScrollercell, self._nameContent.transform)

			childList[idx].name = string.format("nameScrollercell_%d", idx)

			self:_updateNameCell(childList[idx], mo)
			GameUtil.SetActive(childList[idx], true)
		end
	end
end

function TutorSystemSearchView:_clearNameCol()
	local childList = GameUtil.getChildren(self._nameContent)

	for _, mainGo in pairs(childList) do
		self:_clearNameCell(mainGo)
	end
end

function TutorSystemSearchView:_updateNameCell(cell, mo)
	local infoType = mo.infoType
	local infoIndex = mo.infoIndex
	local data = self:_getPlayInfoData(infoType, infoIndex)
	local isHasSend = self:_isPlayInfoHasSend(infoType, infoIndex)
	local mainGo = cell.gameObject
	local txtTagGo = goutil.findChild(mainGo, "txtTag")
	local txtTag = goutil.findChildTextComponent(mainGo, "txtTag/txt")
	local headCon = goutil.findChild(mainGo, "info/headCon")
	local btnCancel = goutil.findChild(mainGo, "info/btnCancel")
	local btnSure = goutil.findChild(mainGo, "info/btnSure")
	local btnInvite = goutil.findChild(mainGo, "info/btnInvite")
	local txtName = goutil.findChildTextComponent(mainGo, "info/txtName")
	local txtPower = goutil.findChildTextComponent(mainGo, "info/txtPower")
	local txtTips = goutil.findChildTextComponent(mainGo, "info/txtTips")

	txtPower.text = data.zdl
	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(headCon, data.headInfo)

	local tabNameStr = ""

	if infoType == InfoType.Request then
		tabNameStr = "申请列表"
	elseif infoType == InfoType.Recommend then
		if self._curViewUser == ViewUser.Student then
			tabNameStr = "推荐老师"
		elseif self._curViewUser == ViewUser.Teacher then
			tabNameStr = "推荐学生"
		end
	end

	txtTag.text = tabNameStr

	GameUtil.SetActive(txtTagGo, mo.isNeedShowTag)

	txtTips.text = self:_getPlayInfoResultTips(infoType, infoIndex)

	GameUtil.SetActive(btnCancel, infoType == InfoType.Request and not isHasSend)
	GameUtil.SetActive(btnSure, infoType == InfoType.Request and not isHasSend)
	GameUtil.SetActive(btnInvite, infoType == InfoType.Recommend and not isHasSend)
	GameUtil.SetActive(txtTips.gameObject, isHasSend)
	GameUtil.addClickHandler(btnCancel, GameUtil.handler(self._onClickNameCellBtnCancelorSure, self, cell, infoType, infoIndex, 2))
	GameUtil.addClickHandler(btnSure, GameUtil.handler(self._onClickNameCellBtnCancelorSure, self, cell, infoType, infoIndex, 1))
	GameUtil.addClickHandler(btnInvite, GameUtil.handler(self._onClickNameCellBtnInvite, self, cell, infoType, infoIndex))
end

function TutorSystemSearchView:_clearNameCell(cell)
	local mainGo = cell.gameObject
	local headCon = goutil.findChild(mainGo, "info/headCon")
	local btnCancel = goutil.findChild(mainGo, "info/btnCancel")
	local btnSure = goutil.findChild(mainGo, "info/btnSure")
	local btnInvite = goutil.findChild(mainGo, "info/btnInvite")

	HeadItemController.instance:resetHeadCell(headCon)
	GameUtil.rmClickHandler(btnCancel)
	GameUtil.rmClickHandler(btnSure)
	GameUtil.rmClickHandler(btnInvite)
end

function TutorSystemSearchView:_onClickNameCellBtnCancelorSure(cell, infoType, infoIndex, action)
	if not self:_isCanReceivedRequest() then
		return
	end

	local requestUserId = self:_getPlayInfoUserId(infoType, infoIndex)

	TutorSystemController.instance:sendTutorHandleRequestReq(self._curViewUser, requestUserId, action)
end

function TutorSystemSearchView:_onClickNameCellBtnInvite(cell, infoType, infoIndex)
	if not self:_isCanReceivedRecommend() then
		return
	end

	local requestUserId = self:_getPlayInfoUserId(infoType, infoIndex)

	TutorSystemController.instance:sendTutorSendRequestReq(self._curViewUser, requestUserId)
end

function TutorSystemSearchView:_onUpdateSearchColData()
	return
end

function TutorSystemSearchView:_onUpdateSearchCol()
	local moList = {}

	for _, info in ipairs(self:_getPlayInfoList(InfoType.Search)) do
		local mo = {
			infoType = info.infoType,
			infoIndex = info.infoIndex
		}

		table.insert(moList, mo)
	end

	self._searchScrollList:reloadData(moList)
	GameUtil.SetActive(self._imgEmptyInSearchCol, #moList == 0)
end

function TutorSystemSearchView:_clearSearchCol()
	self._searchScrollList:dispose()
end

function TutorSystemSearchView:_updateSearchCell(view, cell, mo, tag)
	local infoType = mo.infoType
	local infoIndex = mo.infoIndex
	local data = self:_getPlayInfoData(infoType, infoIndex)
	local isHasSend = self:_isPlayInfoHasSend(infoType, infoIndex)
	local mainGo = cell.gameObject
	local headCon = goutil.findChild(mainGo, "headCon")
	local btnInvite = goutil.findChild(mainGo, "btnInvite")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtPower = goutil.findChildTextComponent(mainGo, "txtPower")
	local txtTips = goutil.findChildTextComponent(mainGo, "txtTips")

	txtPower.text = data.zdl
	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(headCon, data.headInfo)

	txtTips.text = self:_getPlayInfoResultTips(infoType, infoIndex)

	GameUtil.SetActive(btnInvite, infoType == InfoType.Search and not isHasSend)
	GameUtil.SetActive(txtTips.gameObject, isHasSend)
	GameUtil.addClickHandler(btnInvite, GameUtil.handler(self._onClickSearchCell, self, cell, infoType, infoIndex))
end

function TutorSystemSearchView:_clearSearchCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function TutorSystemSearchView:_onClickSearchCell(cell, infoType, infoIndex)
	if not self:_isCanSearch() then
		return
	end

	local requestUserId = self:_getPlayInfoUserId(infoType, infoIndex)

	TutorSystemController.instance:sendTutorSendRequestReq(self._curViewUser, requestUserId)
end

function TutorSystemSearchView:_setInputField(str)
	self._InputFieldAdapter:SetText(str)
end

function TutorSystemSearchView:_getInputField()
	return self._InputFieldAdapter:GetText()
end

function TutorSystemSearchView:_onValueChanged(str)
	GameUtil.SetActive(self._btnCancel, not string.nilorempty(str))
end

function TutorSystemSearchView:_onClickBtnRefresh()
	self:_sendRecommendListReq()
	FloatWordMgr.instance:show("刷新成功")
end

function TutorSystemSearchView:_onClickBtnSearch()
	if not self:_isCanSearch() then
		return
	end

	local identity = self._curViewUser
	local searchInfo = self:_getInputField()
	local searchUserId

	if not string.nilorempty(searchInfo) then
		TutorSystemController.instance:sendTutorSearchReq(identity, searchInfo, searchUserId)
	end
end

function TutorSystemSearchView:_onClickBtnCancel()
	self:_setInputField("")
end

function TutorSystemSearchView:_onClickBtnBack()
	self._curViewState = ViewState.Normal

	self:_onUpdate()
end

return TutorSystemSearchView
