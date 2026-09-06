-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/mainview/TutorSystemMainView.lua

module("logic.extensions.tutorsystem.view.mainview.TutorSystemMainView", package.seeall)

local TutorSystemMainView = class("TutorSystemMainView", ViewComponent)

function TutorSystemMainView:buildUI()
	TutorSystemMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._btnTeaTask = goutil.findChild(self.mainGO, "leftBtns/btnTeaTask")
	self._redBtnTeaTask = goutil.findChild(self.mainGO, "leftBtns/btnTeaTask/redPoint")
	self._btnShop = goutil.findChild(self.mainGO, "leftBtns/btnShop")
	self._redBtnShop = goutil.findChild(self.mainGO, "leftBtns/btnShop/redPoint")
	self._btnRank = goutil.findChild(self.mainGO, "leftBtns/btnRank")
	self._redBtnRank = goutil.findChild(self.mainGO, "leftBtns/btnRank/redPoint")
	self._btnHall = goutil.findChild(self.mainGO, "leftBtns/btnHall")
	self._btnStuSignIn = goutil.findChild(self.mainGO, "leftBtns/btnStuSignIn")
	self._redBtnStuSignIn = goutil.findChild(self.mainGO, "leftBtns/btnStuSignIn/redPoint")
	self._btnStuTask = goutil.findChild(self.mainGO, "leftBtns/btnStuTask")
	self._redBtnStuTask = goutil.findChild(self.mainGO, "leftBtns/btnStuTask/redPoint")
	self._btnRelieve = goutil.findChild(self.mainGO, "rightBtns/btnRelieve")
	self._redBtnStuRelieve = goutil.findChild(self.mainGO, "rightBtns/btnRelieve/redPoint")
	self._btnLease = goutil.findChild(self.mainGO, "rightBtns/btnLease")
	self._redBtnLease = goutil.findChild(self.mainGO, "rightBtns/btnLease/redPoint")
	self._redGoList = {
		self._redBtnTeaTask,
		self._redBtnShop,
		self._redBtnRank,
		self._redBtnStuSignIn,
		self._redBtnStuTask,
		self._redBtnStuRelieve,
		self._redBtnLease
	}
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._posList = goutil.findChild(self.mainGO, "modelCam/posList")
	self._teacherCol = goutil.findChild(self.mainGO, "teacherCol")
	self._teacherCellGo = goutil.findChild(self.mainGO, "teacherCol/teacherCell")
	self._studentCol = goutil.findChild(self.mainGO, "studentCol")

	GameUtil.SetActive(self._gameCell, false)

	self._studentCellList = {}
	self._avatarPool = {}
	self._seatEffList = {}
end

function TutorSystemMainView:bindEvents()
	TutorSystemMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTeaTask, self._onClickBtnTeaTask, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnHall, function()
		GotoMgr.gotoByString("func#1137#6")
	end, self)
	GameUtil.addClickHandler(self._btnStuSignIn, self._onClickBtnStuSignIn, self)
	GameUtil.addClickHandler(self._btnStuTask, self._onClickBtnStuTask, self)
	GameUtil.addClickHandler(self._btnRelieve, self._onClickBtnRelieve, self)
	GameUtil.addClickHandler(self._btnLease, self._onClickBtnLease, self)
end

function TutorSystemMainView:unbindEvents()
	TutorSystemMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTeaTask)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnHall)
	GameUtil.rmClickHandler(self._btnStuSignIn)
	GameUtil.rmClickHandler(self._btnStuTask)
	GameUtil.rmClickHandler(self._btnRelieve)
	GameUtil.rmClickHandler(self._btnLease)
end

function TutorSystemMainView:onEnter()
	TutorSystemMainView.super.onEnter(self)
	TutorSystemModel.instance:accessTutorSystem(true)
	self:_setAvatarCameraEnv(true)
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.TutorMainInfoRes, self._handleTutorMainInfoRes, self)
	self.addGEvent(self, GlobalNotify.NotifyTutorRelationShipChange, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function TutorSystemMainView:onExit()
	TutorSystemMainView.super.onExit(self)
	self:_setAvatarCameraEnv(false)

	for _, redGo in pairs(self._redGoList) do
		RedPointController.instance:unregRedPoint(redGo)
	end

	self:_removeAvatarPool()
	self:_clearTeacherCol()
	self:_clearStudentCol()
	TutorSystemModel.instance:accessTutorSystem(false)
end

function TutorSystemMainView:destroyUI()
	TutorSystemMainView.super.destroyUI(self)
	self:_destroyAvatarPool()
end

function TutorSystemMainView:_handleTutorMainInfoRes()
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()

	if myIdentityType == GameEnum.IdentityType.Teacher then
		local stuInfoList = TutorSystemModel.instance:getStuInfoListAsTea() or {}

		for _, info in ipairs(stuInfoList) do
			local userId = info.headInfo.headInfo.userId

			if not string.nilorempty(userId) then
				TutorSystemController.instance:sendTutorTeacherPetHireInfoReq(userId)
			end
		end
	end

	self:_onUpdate()
end

function TutorSystemMainView:_sendInfoReq()
	TutorSystemController.instance:sendTutorMainInfoReq()
end

function TutorSystemMainView:_onSetUI()
	return
end

function TutorSystemMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TutorSystemMainView:_onUpdateData()
	self:_onUpdateStudentColData()
end

function TutorSystemMainView:_onUpdateUI()
	local myUserTutorState = TutorSystemModel.instance:getMyUserTutorState()
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()
	local myIdentityState = TutorSystemModel.instance:getMyIdentityState()
	local newPuzzleFinishTutorFlag = TutorSystemModel.instance:getNewPuzzleFinishTutorFlag()

	GameUtil.SetActive(self._btnStuSignIn, myIdentityType == GameEnum.IdentityType.Student or newPuzzleFinishTutorFlag and myUserTutorState.studyState == 2)
	GameUtil.SetActive(self._btnStuTask, myIdentityType == GameEnum.IdentityType.Student)

	if myIdentityType == GameEnum.IdentityType.Teacher then
		if self._studentDataList then
			local isHaveStu = #self._studentDataList > 0

			GameUtil.SetActive(self._btnRelieve, isHaveStu)
			GameUtil.SetActive(self._btnLease, isHaveStu)
		end
	else
		GameUtil.SetActive(self._btnRelieve, myIdentityType == GameEnum.IdentityType.Student)
		GameUtil.SetActive(self._btnLease, myIdentityType == GameEnum.IdentityType.Student)
	end

	if not goutil.isNil(self._redBtnLease) then
		local redIdList = {}

		if myIdentityType == GameEnum.IdentityType.Teacher then
			local stuMaxCount = TutorSystemConfig.instance:getTsTeachStudentLimit()

			for posIdx = 1, stuMaxCount do
				local stuUserId = self:_getStuPosUserId(posIdx)

				table.insert(redIdList, TutorSystemModel.instance:getTutorServantRedId(4, stuUserId))
			end

			table.insert(redIdList, RedPointModel.ID_TUTORSYSTEM_TEACHER_LEASE)
		end

		RedPointController.instance:regRedPoint(self._redBtnLease, unpack(redIdList))
	end

	if not goutil.isNil(self._redBtnTeaTask) then
		local redIdList = {}

		if myIdentityType == GameEnum.IdentityType.Teacher then
			local gaActivityType = TutorSystemConfig.instance:getTsTeacherGradAwardTaskActivityType()
			local achActivityType = TutorSystemConfig.instance:getTsTeacherAchTaskActivityType()

			table.insert(redIdList, EventTaskSummaryController.instance:getCurRedIdByActivityType(gaActivityType))
			table.insert(redIdList, EventTaskSummaryController.instance:getCurRedIdByActivityType(achActivityType))
		end

		RedPointController.instance:regRedPoint(self._redBtnTeaTask, unpack(redIdList))
	end

	if not goutil.isNil(self._redBtnStuTask) then
		local redIdList = {}

		if myIdentityType == GameEnum.IdentityType.Student then
			table.insert(redIdList, RedPointModel.ID_TUTORSYSTEM_ZDLTASKRED)
		end

		RedPointController.instance:regRedPoint(self._redBtnStuTask, unpack(redIdList))
	end

	if not goutil.isNil(self._redBtnStuSignIn) then
		local redIdList = {}

		if myIdentityType == GameEnum.IdentityType.Student then
			table.insert(redIdList, RedPointModel.ID_TUTORSYSTEM_STUDENT_PUZZLE_TIMES)
		end

		RedPointController.instance:regRedPoint(self._redBtnStuSignIn, unpack(redIdList))
	end

	self:_onUpdateTeacherCol()
	self:_onUpdateStudentCol()
	TutorSystemController.instance:ifHaveLetterThenOpenIt()
end

function TutorSystemMainView:_getBtnData(name, redIdList, callBack, ...)
	return {
		name = name,
		redIdList = redIdList,
		callBack = callBack,
		params = {
			...
		}
	}
end

function TutorSystemMainView:_onUpdateTeacherCol()
	self:_updateTeacherCell()
end

function TutorSystemMainView:_clearTeacherCol()
	self:_clearTeacherCell()
end

function TutorSystemMainView:_updateTeacherCell()
	if not self._teacherCell then
		local cell = self:_buildTeacherCell()

		self._teacherCell = self._teacherCell

		local parentGo = goutil.findChild(self._posList, "tea_pos")
		local myIdentityType = TutorSystemModel.instance:getMyIdentityType()
		local myIdentityState = TutorSystemModel.instance:getMyIdentityState()
		local myTeaUserId = TutorSystemModel.instance:getMyTeaUserIdAsStu()

		self:_stopSeatEff(self._teacherCell._effParent)

		if myIdentityType == GameEnum.IdentityType.Student then
			local gender = TutorSystemModel.instance:getMyTeaGenderAsStu()
			local clothes = TutorSystemModel.instance:getMyTeaClothesAsStu()

			self:_showAvatar(parentGo, gender, clothes)
		elseif myIdentityType == GameEnum.IdentityType.Teacher then
			local gender = RoleModel.instance:getGender()
			local clothes = RoleModel.instance:getClothes()

			self:_showAvatar(parentGo, gender, clothes)
			self:_showSeatEff(self._teacherCell._effParent)
		elseif myIdentityType == GameEnum.IdentityType.FreeMan then
			if myIdentityState == GameEnum.IdentityState.TeaQuals or myIdentityState == GameEnum.IdentityState.StuHasFinish then
				local gender = RoleModel.instance:getGender()
				local clothes = RoleModel.instance:getClothes()

				self:_showAvatar(parentGo, gender, clothes)
				self:_showSeatEff(self._teacherCell._effParent)
			else
				self:_hideAvatar(parentGo)
			end
		end

		local userName = ""

		if myIdentityType == GameEnum.IdentityType.Student then
			userName = TutorSystemModel.instance:getMyTeaUserNameAsStu()
		elseif myIdentityType == GameEnum.IdentityType.Teacher then
			userName = RoleModel.instance:getUserName()
		end

		local isNeedName = not string.nilorempty(userName)

		if isNeedName then
			self._teacherCell._txtName.text = userName
		end

		GameUtil.SetActive(self._teacherCell._txtNameGo, isNeedName)
		GameUtil.SetActive(self._teacherCell._txtNameRed, false)
		RedPointController.instance:regRedPoint(self._teacherCell._imgAddRed, TutorSystemConfig.instance:getRedRequestFromTea())
		GameUtil.SetActive(self._teacherCell._imgAdd, not isNeedName and myIdentityState == GameEnum.IdentityState.StuQuals)
		GameUtil.SetActive(self._teacherCell._btnAdd, GameUtil.GetActive(self._teacherCell._imgAdd) or isNeedName)
		GameUtil.addClickHandler(self._teacherCell._btnAdd, function()
			if myIdentityType == GameEnum.IdentityType.Student then
				local myTeaUserId = TutorSystemModel.instance:getMyTeaUserIdAsStu()

				FriendController.instance:showInfoView(myTeaUserId, cell._mainGo)
			elseif myIdentityType == GameEnum.IdentityType.Teacher then
				RoleController.instance:openMyInfoCard()
			elseif myIdentityType == GameEnum.IdentityType.FreeMan then
				if myIdentityState == GameEnum.IdentityState.TeaQuals or myIdentityState == GameEnum.IdentityState.StuQuals then
					self:_goToSearchView()
				elseif myIdentityState == GameEnum.IdentityState.StuHasFinish then
					local zdl = TutorSystemConfig.instance:getTsTeacherZdlLimit()

					FloatWordMgr.instance:show(string.format("%d万战力以上才能收徒", Mathf.Floor(zdl / 10000)))
				else
					FloatWordMgr.instance:show("未满足成为老师or学生的资格")
				end
			end
		end)
	end
end

function TutorSystemMainView:_buildTeacherCell()
	local cell = {}

	cell._mainGo = self._teacherCellGo
	cell._roleCon = goutil.findChild(cell._mainGo, "roleCon")
	cell._btnAdd = goutil.findChild(cell._mainGo, "btnAdd")
	cell._root = goutil.findChild(cell._mainGo, "root")
	cell._txtNameGo = goutil.findChild(cell._mainGo, "txtName")
	cell._imgAdd = goutil.findChild(cell._mainGo, "imgAdd")
	cell._effParent = goutil.findChild(cell._mainGo, "effParent")
	cell._txtName = goutil.findChildTextComponent(cell._mainGo, "txtName/txt")
	cell._txtNameRed = goutil.findChild(cell._mainGo, "txtName/redPoint")
	cell._imgAddRed = goutil.findChild(cell._mainGo, "imgAdd/redPoint")

	return cell
end

function TutorSystemMainView:_clearTeacherCell()
	if self._teacherCell then
		GameUtil.rmClickHandler(self._teacherCell._btnAdd)
		self:_stopSeatEff(self._teacherCell._effParent)
		RedPointController.instance:unregRedPoint(self._teacherCell._txtNameRed)
		RedPointController.instance:unregRedPoint(self._teacherCell._imgAddRed)
	end
end

function TutorSystemMainView:_onUpdateStudentColData()
	local dataList = {}
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()

	if myIdentityType == GameEnum.IdentityType.Student then
		local myShowInfo = self:_makeStuPosShowInfo(RoleModel.instance:getUserId(), RoleModel.instance:getUserName(), RoleModel.instance:getGender(), RoleModel.instance:getClothes(), RoleModel.instance:getMaxPower())

		table.insert(dataList, myShowInfo)

		local broShowInfo = TutorSystemModel.instance:getMyBrotherHeadInfoAsStu()

		for _, showInfo in ipairs(broShowInfo) do
			local userId = showInfo.headInfo.userId
			local userName = showInfo.headInfo.userName
			local gender = showInfo.gender
			local clothes = showInfo.clothes
			local zdl = showInfo.maxZdl

			table.insert(dataList, self:_makeStuPosShowInfo(userId, userName, gender, clothes, zdl))
		end
	elseif myIdentityType == GameEnum.IdentityType.Teacher then
		local infoList = TutorSystemModel.instance:getStuInfoListAsTea()

		for _, baseInfo in ipairs(infoList) do
			local userId = baseInfo.headInfo.headInfo.userId
			local userName = baseInfo.headInfo.headInfo.userName
			local gender = baseInfo.headInfo.gender
			local clothes = baseInfo.headInfo.clothes
			local zdl = baseInfo.headInfo.maxZdl

			table.insert(dataList, self:_makeStuPosShowInfo(userId, userName, gender, clothes, zdl))
		end
	elseif myIdentityType == GameEnum.IdentityType.FreeMan then
		-- block empty
	end

	self._studentDataList = dataList
end

function TutorSystemMainView:_makeStuPosShowInfo(userId, userName, gender, clothes, zdl)
	return {
		userId = userId,
		userName = userName,
		gender = gender,
		clothes = clothes,
		zdl = zdl
	}
end

function TutorSystemMainView:_getStuPosShowInfo(posIdx)
	return self._studentDataList[posIdx]
end

function TutorSystemMainView:_isStuPosHaveStu(posIdx)
	return self:_getStuPosShowInfo(posIdx) ~= nil
end

function TutorSystemMainView:_getStuPosUserId(posIdx)
	local showInfo = self:_getStuPosShowInfo(posIdx)

	return (showInfo or nil) and (showInfo.userId or 0)
end

function TutorSystemMainView:_getStuPosUserName(posIdx)
	local showInfo = self:_getStuPosShowInfo(posIdx)

	return (showInfo or nil) and (showInfo.userName or "")
end

function TutorSystemMainView:_getStuPosZdl(posIdx)
	local showInfo = self:_getStuPosShowInfo(posIdx)

	return (showInfo or nil) and (showInfo.zdl or 0)
end

function TutorSystemMainView:_getStuPosGender(posIdx)
	local showInfo = self:_getStuPosShowInfo(posIdx)

	return (showInfo or nil) and (showInfo.gender or 0)
end

function TutorSystemMainView:_getStuPosClohes(posIdx)
	local showInfo = self:_getStuPosShowInfo(posIdx)

	return (showInfo or nil) and (showInfo.clothes or 0)
end

function TutorSystemMainView:_isStuPosIsMe(posIdx)
	local posUserId = self:_getStuPosUserId(posIdx)
	local myUserId = RoleModel.instance:getUserId()

	return posUserId == myUserId
end

function TutorSystemMainView:_buildStudentCell(idx)
	local mainGo = goutil.findChild(self._studentCol, "studentCell_" .. idx)

	if mainGo == nil then
		printError("预设数量不足,请检查预制体及配置")

		return
	end

	local cell = {}

	cell._mainGo = mainGo
	cell._roleCon = goutil.findChild(mainGo, "roleCon")
	cell._btnAdd = goutil.findChild(mainGo, "btnAdd")
	cell._root = goutil.findChild(mainGo, "root")
	cell._txtName = goutil.findChildTextComponent(mainGo, "txtName/txt")
	cell._txtNameGo = goutil.findChild(mainGo, "txtName")
	cell._txtZdl = goutil.findChildTextComponent(mainGo, "zdl/txt")
	cell._zdlGo = goutil.findChild(mainGo, "zdl")
	cell._imgAdd = goutil.findChild(cell._mainGo, "imgAdd")
	cell._effParent = goutil.findChild(cell._mainGo, "effParent")
	cell._txtNameRed = goutil.findChild(cell._mainGo, "txtName/redPoint")
	cell._imgAddRed = goutil.findChild(cell._mainGo, "imgAdd/redPoint")

	return cell
end

function TutorSystemMainView:_onUpdateStudentCol()
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()
	local myIdentityState = TutorSystemModel.instance:getMyIdentityState()
	local stuMaxCount = TutorSystemConfig.instance:getTsTeachStudentLimit()

	for posIdx = 1, stuMaxCount do
		if not self._studentCellList[posIdx] then
			local cell = self:_buildStudentCell(posIdx)

			if cell == nil then
				break
			else
				self._studentCellList[posIdx] = cell
			end

			local parentGo = goutil.findChild(self._posList, string.format("stu_pos_%s", posIdx))
			local isStuPosHaveStu = self:_isStuPosHaveStu(posIdx)
			local stuUserId = self:_getStuPosUserId(posIdx)

			if isStuPosHaveStu then
				local gender = self:_getStuPosGender(posIdx)
				local clothes = self:_getStuPosClohes(posIdx)

				self:_showAvatar(parentGo, gender, clothes)
			else
				self:_hideAvatar(parentGo)
			end

			if self:_isStuPosIsMe(posIdx) then
				self:_showSeatEff(cell._effParent)
			else
				self:_stopSeatEff(cell._effParent)
			end

			if isStuPosHaveStu then
				cell._txtName.text = self:_getStuPosUserName(posIdx)

				local cur = self:_getStuPosZdl(posIdx)
				local max = TutorSystemConfig.instance:getMaxZdlInPrize()

				cell._txtZdl.text = max <= cur and string.format("<color=#20b376>%s</color>/%s", cur, max) or string.format("<color=#eb4624>%s</color>/%s", cur, max)
			end

			GameUtil.SetActive(cell._txtNameGo, isStuPosHaveStu)
			GameUtil.SetActive(cell._zdlGo, isStuPosHaveStu)
			GameUtil.SetActive(cell._txtNameRed, false)

			if myIdentityType == GameEnum.IdentityType.Student then
				GameUtil.SetActive(cell._imgAdd, false)
			elseif myIdentityType == GameEnum.IdentityType.Teacher then
				GameUtil.SetActive(cell._imgAdd, not isStuPosHaveStu)
			elseif myIdentityType == GameEnum.IdentityType.FreeMan then
				GameUtil.SetActive(cell._imgAdd, not isStuPosHaveStu and myIdentityState ~= GameEnum.IdentityState.StuQuals)
			end

			RedPointController.instance:regRedPoint(cell._imgAddRed, TutorSystemConfig.instance:getRedRequestFromStu())

			if isStuPosHaveStu then
				GameUtil.SetActive(cell._btnAdd, true)
			else
				GameUtil.SetActive(cell._btnAdd, GameUtil.GetActive(cell._imgAdd))
			end

			GameUtil.addClickHandler(cell._btnAdd, GameUtil.handler(self._onClickStudentBtnAdd, self, cell, posIdx))
		end
	end
end

function TutorSystemMainView:_clearStudentCol()
	for idx, cell in ipairs(self._studentCellList) do
		GameUtil.rmClickHandler(cell._btnAdd)
		self:_stopSeatEff(cell._effParent)
		RedPointController.instance:unregRedPoint(cell._txtNameRed)
		RedPointController.instance:unregRedPoint(cell._imgAddRed)
	end
end

function TutorSystemMainView:_onClickStudentBtnAdd(cell, posIdx)
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()
	local myIdentityState = TutorSystemModel.instance:getMyIdentityState()

	if myIdentityType == GameEnum.IdentityType.Student then
		local userId = self:_getStuPosUserId(posIdx)

		if self:_isStuPosIsMe(posIdx) then
			self:_goToOpenCard(userId)
		else
			FriendController.instance:showInfoView(userId, cell._mainGo)
		end
	elseif myIdentityType == GameEnum.IdentityType.Teacher then
		if self:_isStuPosHaveStu(posIdx) then
			FriendController.instance:showInfoView(self:_getStuPosUserId(posIdx), cell._mainGo)
		elseif myIdentityState == GameEnum.IdentityState.Recruiting then
			self:_goToSearchView()
		elseif myIdentityState == GameEnum.IdentityState.NotRecruiting then
			FloatWordMgr.instance:show("学生已满")
		end
	elseif myIdentityType == GameEnum.IdentityType.FreeMan then
		if myIdentityState == GameEnum.IdentityState.TeaQuals or myIdentityState == GameEnum.IdentityState.StuQuals then
			self:_goToSearchView()
		elseif myIdentityState == GameEnum.IdentityState.StuHasFinish then
			local zdl = TutorSystemConfig.instance:getTsTeacherZdlLimit()

			FloatWordMgr.instance:show(string.format("%d万战力以上才能收徒", Mathf.Floor(zdl / 10000)))
		else
			FloatWordMgr.instance:show("未满足成为老师or学生的资格")
		end
	end
end

function TutorSystemMainView:_goToStudentFloorView()
	UIStateManager.instance:push(ViewName.StudentFloorView)
end

function TutorSystemMainView:_goToTeacherPlanGrowTaskView(stuUserId)
	UIStateManager.instance:push(ViewName.TeacherPlanGrowTaskView, stuUserId)
end

function TutorSystemMainView:_goToPuzzleView(identity, userId)
	UIStateManager.instance:push(ViewName.TutorSystemPuzzleView, identity, userId)
end

function TutorSystemMainView:_goToStudentLeaseView()
	UIStateManager.instance:push(ViewName.StudentLeaseView)
end

function TutorSystemMainView:_goToTeacherLeaseView(stuUserId)
	UIStateManager.instance:push(ViewName.TeacherLeaseView, stuUserId)
end

function TutorSystemMainView:_goToRemoveRelationship(userId)
	local startTimes = 0
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()

	if myIdentityType == GameEnum.IdentityType.Student then
		startTimes = TutorSystemModel.instance:getMyStartTimesAsStu()
	elseif myIdentityType == GameEnum.IdentityType.Teacher then
		startTimes = TutorSystemModel.instance:getMyStudentStartTimesAsTea(userId)
	else
		return
	end

	if not TutorSystemController.instance:isEnoughRelieveCd(startTimes) then
		FloatWordMgr.instance:show(TutorSystemConfig.instance:getTsTipsValue(-29913))

		return
	end

	local tipsContent = "解除关系后，双方将不再是师徒关系"

	local function okFunc()
		local myIdentityType = TutorSystemModel.instance:getMyIdentityType()

		if myIdentityType > GameEnum.IdentityType.Teacher then
			return
		end

		TutorSystemController.instance:sendTutorRelieveReq(myIdentityType, userId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function TutorSystemMainView:_goToSearchView()
	TutorSystemController.instance:openSearchView(true)
end

function TutorSystemMainView:_goToOpenCard(userId)
	RoleController.instance:openCardByUserId(userId)
end

function TutorSystemMainView:_goToOpenFriendView(userId)
	FriendController.instance:setCurSelctedId(userId)
	FriendController.instance:OpenFriendView(userId)
end

function TutorSystemMainView:_goToOpenScheduleView(userId)
	UIStateManager.instance:push(ViewName.TeacherScheduleFloorView, userId)
end

function TutorSystemMainView:_showSeatEff(effParent)
	self:_stopSeatEff(effParent)

	local effGo = effParent
	local effPath = "20220701/shitu/fx_ui_shitujiaodi.prefab"

	local function func(_, eff)
		eff:setParent(effGo.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
	end

	self._seatEffList[effParent] = UIEffectManager.instance:playEffect(self, effPath, effGo, 0, 0, true, false, nil, func, nil)
end

function TutorSystemMainView:_stopSeatEff(effParent)
	UIEffectManager.instance:stopEffect(self._seatEffList[effParent])

	self._seatEffList[effParent] = nil
end

function TutorSystemMainView:_showAvatar(parentGo, gender, clothes)
	if not self._avatarPool[parentGo] then
		local avatar = PalyerAvatarCtrl.AddOnce(parentGo)

		self._avatarPool[parentGo] = self._avatarPool[parentGo]

		local data = {
			gender = gender,
			clothes = clothes
		}

		self._avatarPool[parentGo]:initAvatar(data)
		self._avatarPool[parentGo]:setAvatarActive(true)
	end
end

function TutorSystemMainView:_hideAvatar(parentGo)
	if self._avatarPool[parentGo] then
		self._avatarPool[parentGo]:setAvatarActive(false)
	end
end

function TutorSystemMainView:_removeAvatarPool()
	for _, avatar in pairs(self._avatarPool) do
		avatar:_removeAvatar()
	end
end

function TutorSystemMainView:_destroyAvatarPool()
	for _, avatar in pairs(self._avatarPool) do
		avatar:destroy()
	end

	table.clear(self._avatarPool)
end

function TutorSystemMainView:_setAvatarCameraEnv(isOnEnter)
	if isOnEnter then
		goutil.addChildToParent(self._modelCam)
		LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	else
		goutil.addChildToParent(self._modelCam, self.mainGO)
		LightMgr.instance:setLightForNormalScene()
	end

	LightMgr.instance:setUseModelLight(isOnEnter)
	GlobalModel.instance:visibleSceneHUDs(not isOnEnter)
end

function TutorSystemMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(TutorSystemConfig.instance:getTutorSystemRuleKey())
end

function TutorSystemMainView:_onClickBtnTeaTask()
	UIStateManager.instance:push(ViewName.TeacherFloorView)
end

function TutorSystemMainView:_onClickBtnShop()
	GotoMgr.gotoByString("func#470#ExchangeTutorSystem")
end

function TutorSystemMainView:_onClickBtnRank()
	local params = CommonTabRankParams.New()

	params:addTabData(ViewName.TutorSystemMoonRankChildView, ViewName.TutorSystemMoonRankChildView, "每月排行")
	params:addTabData(ViewName.TutorSystemTotalRankChildView, ViewName.TutorSystemTotalRankChildView, "总排行")
	UIStateManager.instance:push(ViewName.CommonTabRankFatherView, params)
end

function TutorSystemMainView:_onClickBtnStuSignIn()
	UIStateManager.instance:push(ViewName.TutorSystemPuzzleView)
end

function TutorSystemMainView:_onClickBtnStuTask()
	UIStateManager.instance:push(ViewName.TutorSystemStudentZdlPrizeView)
end

function TutorSystemMainView:_onClickBtnRelieve()
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()
	local myIdentityState = TutorSystemModel.instance:getMyIdentityState()

	if myIdentityType == GameEnum.IdentityType.Student then
		local myTeaUserId = TutorSystemModel.instance:getMyTeaUserIdAsStu()

		TutorSystemController.instance:goToRemoveRelationship(myTeaUserId)
	elseif myIdentityType == GameEnum.IdentityType.Teacher then
		UIStateManager.instance:push(ViewName.TutorSystemRelieveView)
	elseif myIdentityType == GameEnum.IdentityType.FreeMan then
		-- block empty
	end
end

function TutorSystemMainView:_onClickBtnLease()
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()
	local myIdentityState = TutorSystemModel.instance:getMyIdentityState()

	if myIdentityType == GameEnum.IdentityType.Student then
		UIStateManager.instance:push(ViewName.StudentLeaseView)
	elseif myIdentityType == GameEnum.IdentityType.Teacher then
		UIStateManager.instance:push(ViewName.TeacherLeaseView)
	elseif myIdentityType == GameEnum.IdentityType.FreeMan then
		-- block empty
	end
end

return TutorSystemMainView
