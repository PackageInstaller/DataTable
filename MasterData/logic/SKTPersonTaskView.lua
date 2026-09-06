-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTPersonTaskView.lua

module("logic.extensions.saintknighttask.view.SKTPersonTaskView", package.seeall)

local SKTPersonTaskView = class("SKTPersonTaskView", ViewComponent)

function SKTPersonTaskView:ctor()
	SKTPersonTaskView.super.ctor(self)
end

function SKTPersonTaskView:buildUI()
	SKTPersonTaskView.super.buildUI(self)

	self._bg = goutil.findChild(self.mainGO, "bg")
	self._bgEffect = goutil.findChild(self.mainGO, "bgEffect")
	self._petCol = goutil.findChild(self.mainGO, "petCol")
	self._petCon = goutil.findChild(self.mainGO, "petCol/petPos/petCon")
	self._petCell = goutil.findChild(self.mainGO, "petCol/petCell")
	self._petView = goutil.findChild(self.mainGO, "petCol/petView")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._prizeScrollView = goutil.findChild(self.mainGO, "prizeCol/prizeScrollView")
	self._prizeScrollCell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollCell")
	self._teamCol = goutil.findChild(self.mainGO, "teamCol")
	self._teamScrView = goutil.findChild(self.mainGO, "teamCol/scrView")
	self._teamScrCell = goutil.findChild(self.mainGO, "teamCol/scrCell")
	self._txtTeamCount = goutil.findChildTextComponent(self.mainGO, "teamCol/txtCount")
	self._txtTeamProgress = goutil.findChildTextComponent(self.mainGO, "teamCol/txtProgress")
	self._teamCountFormat = self._txtTeamCount.text
	self._teamProgressFormat = self._txtTeamProgress.text
	self._btnInvite = goutil.findChild(self.mainGO, "teamCol/btnInvite")
	self._progressCol = goutil.findChild(self.mainGO, "progressCol")
	self._teamProgressScrView = goutil.findChild(self.mainGO, "progressCol/scrView")
	self._teamProgressBar = goutil.findChild(self.mainGO, "progressCol/scrView/Viewport/Content/progressBar")
	self._teamProgressSlider = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._teamProgressScrCell = goutil.findChild(self.mainGO, "progressCol/scrCell")
	self._txtTeamTotalScore = goutil.findChildTextComponent(self.mainGO, "progressCol/total/txtScore")
	self._teamTotalIcon = goutil.findChild(self.mainGO, "progressCol/total/icon")
	self._prizeScrollList = ScrollerList.create(self._prizeScrollView, self._prizeScrollCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._teamScrollList = ScrollerList.create(self._teamScrView, self._teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._teamPrizeScrollList = ScrollerList.create(self._teamProgressScrView, self._teamProgressScrCell, GameUtil.handler(self._updateTeamPrizeCell, self), GameUtil.handler(self._clearTeamPrizeCell, self))

	GameUtil.SetActive(self._petCell, false)

	self._petCellList = {}
	self._itemScrollLists = {}
	self._petEff = nil
end

function SKTPersonTaskView:bindEvents()
	SKTPersonTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnInvite, self._onClickBtnInvite, self)
end

function SKTPersonTaskView:unbindEvents()
	SKTPersonTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnInvite)
end

function SKTPersonTaskView:destroyUI()
	SKTPersonTaskView.super.destroyUI(self)
end

function SKTPersonTaskView:onEnter()
	SKTPersonTaskView.super.onEnter(self)

	self._activityId = SaintKnightTaskController.instance:getActivityId()

	local isInTime = SaintKnightTaskController.instance:isInActivityTimeAsSkt(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._actData = SaintKnightTaskConfig.instance:getSktActData(self._activityId)

	local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(activityType, self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.SKTaskGetPersonTaskRes, self._handleGetPersonTaskRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SKTaskGainPersonTaskPrizeRes, self.handleGainPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SKTaskGainTeamPrizeRes, self.handleGainTeamPrizeRes, self)
	SaintKnightTaskController.instance:sendSK_GetPersonTaskReq(self._activityId)
end

function SKTPersonTaskView:onExit()
	SKTPersonTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskGetPersonTaskRes, self._handleGetPersonTaskRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskGainPersonTaskPrizeRes, self.handleGainPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskGainTeamPrizeRes, self.handleGainTeamPrizeRes, self)

	if self._petEff then
		self._petEff:clear()

		self._petEff = nil
	end

	self:_onClearPetCol()
	self:_onClearPrizeColUI()
	self:_onClearTeamColUI()
	self:_onClearTeamProgressColUI()
end

function SKTPersonTaskView:handleGainPrizeRes()
	SaintKnightTaskController.instance:sendSK_GetPersonTaskReq(self._activityId)
end

function SKTPersonTaskView:handleGainTeamPrizeRes()
	SaintKnightTaskController.instance:sendSK_GetPersonTaskReq(self._activityId)
end

function SKTPersonTaskView:_handleGetPersonTaskRes(status)
	if status ~= nil and status ~= 0 then
		return
	end

	self:_onUpdate()
end

function SKTPersonTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateRed()
	self:_onUpdateUI()
end

function SKTPersonTaskView:_onUpdateData()
	self:_checkCurPersonTaskPlanId()
	self:_onUpdatePetColData()
	self:_onUpdatePrizeColData()
	self:_onUpdateTeamColData()
end

function SKTPersonTaskView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePetColUI()
	self:_onUpdatePrizeColUI()
	self:_onUpdateTeamColUI()
	self:_onUpdateTeamProgressColUI()
end

function SKTPersonTaskView:_checkCurPersonTaskPlanId()
	if checknumber(self._curPersonTaskPlanId) ~= 0 and SaintKnightTaskController.instance:isUnlockByTimeAsPersonTasksPlan(self._curPersonTaskPlanId) then
		return
	end

	local curPersonTaskPlanId = 0

	for _, personTaskPlanId in ipairs(self._actData.personTaskPlanIdArray) do
		if SaintKnightTaskController.instance:isUnlockByTimeAsPersonTasksPlan(personTaskPlanId) then
			curPersonTaskPlanId = personTaskPlanId

			break
		end
	end

	self._curPersonTaskPlanId = curPersonTaskPlanId
end

function SKTPersonTaskView:_onUpdatePlaneUI()
	if self._curWorldTaskPlanId == 0 then
		return
	end

	local data = SaintKnightTaskConfig.instance:getSktPersonTaskPlanData(self._curPersonTaskPlanId)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	if data.skinId == 0 then
		printError("skinId未正确，无法展现精灵动图")
	elseif self._petCon == nil then
		printError("动图挂载点为空")
	else
		local x, y, scaleX = data.rolePos[1], data.rolePos[2], data.rolePos[3]

		self._petEff = self._petEff or PetPhotoShow.Get(self._petCon)

		self._petEff:showPetEffect(data.skinId, true, 3)
		self._petEff:setPetLocalPosAndScale(x, y, scaleX)
	end
end

function SKTPersonTaskView:_onUpdateRed()
	SaintKnightTaskController.instance:setFirstRedAsPersonTasksPlan(self._activityId, self._curPersonTaskPlanId)
	SaintKnightTaskController.instance:updateSKTPersonTaskFirstRed()
end

function SKTPersonTaskView:_onUpdatePetColData()
	local planInfoList = {}

	for _, personTaskPlanId in ipairs(self._actData.personTaskPlanIdArray) do
		local data = SaintKnightTaskConfig.instance:getSktPersonTaskPlanData(personTaskPlanId)
		local isCanGetPrize = SaintKnightTaskController.instance:isCanGetPrizeAsPersonTasksPlan(personTaskPlanId)
		local isUnlock = SaintKnightTaskController.instance:isUnlockByTimeAsPersonTasksPlan(personTaskPlanId)
		local info = {
			data = data,
			isCanGetPrize = isCanGetPrize,
			isUnlock = isUnlock
		}

		table.insert(planInfoList, info)
	end

	self._planInfoList = planInfoList
end

function SKTPersonTaskView:_onUpdatePetColUI()
	local parentTran = self._petView.transform
	local children = GameUtil.getChildren(parentTran)

	for index, info in ipairs(self._planInfoList) do
		local data = info.data
		local isCanGetPrize = info.isCanGetPrize
		local isUnlock = info.isUnlock

		if not children[index] then
			local mainGo = goutil.cloneAndSetParent(self._petCell, parentTran)
			local iconGo = goutil.findChild(mainGo, "icon")
			local selectGo = goutil.findChild(mainGo, "select")
			local lock = goutil.findChild(mainGo, "lock")
			local redPoint = goutil.findChild(mainGo, "redPoint")

			mainGo.name = "petCell_" .. data.personTaskPlanId

			GameUtil.setLocalPos(mainGo, data.headPos[1] or 0, data.headPos[2] or 0, 0)
			GameUtil.SetActive(lock, not isUnlock)
			MaterialMgr.setIcon(iconGo, MatType.Pet, data.skinId, nil, nil)
			GameUtil.SetActive(redPoint, false)
			RedPointController.instance:unregRedPoint(redPoint)

			if SaintKnightTaskController.instance:isNeedFirstRedAsPersonTasksPlan(self._activityId, data.personTaskPlanId) then
				RedPointController.instance:regRedPoint(redPoint, SaintKnightTaskConfig.instance:getSktPersonTaskFirstRed())
			elseif isCanGetPrize then
				GameUtil.SetActive(redPoint, true)
			end

			GameUtil.SetActive(selectGo, data.personTaskPlanId == self._curPersonTaskPlanId)
			GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPetCell, self, info))
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #self._planInfoList)
	end
end

function SKTPersonTaskView:_onClearPetCol()
	local parentTran = self._petView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		local iconGo = goutil.findChild(mainGo, "icon")
		local redPoint = goutil.findChild(mainGo, "redPoint")

		uGuiUtil.clearImage(iconGo)
		RedPointController.instance:unregRedPoint(redPoint)
	end
end

function SKTPersonTaskView:_onClickPetCell(info)
	if info.isUnlock == false then
		local startDate = GameUtil.string2date(info.data.openTime)
		local str = string.format(" %s月%s日%s:00开放", startDate.month, startDate.day, startDate.hour)

		FloatWordMgr.instance:show(str)

		return
	end

	self._curPersonTaskPlanId = info.data.personTaskPlanId

	self:_onUpdate()
end

function SKTPersonTaskView:_onUpdatePrizeColData()
	local taskDataQueue = {}
	local queue = SaintKnightTaskConfig.instance:getSktPersonTaskQueue(self._curPersonTaskPlanId)

	for showType, taskList in ipairs(queue) do
		local list = {}

		for idx, data in ipairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = self:_calcTaskState(data)

			table.insert(list, tab)
		end

		table.sort(list, function(a, b)
			if a.state == b.state then
				if a.data.personTaskId < b.data.personTaskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)

		taskDataQueue[showType] = list
	end

	table.sort(taskDataQueue, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.data.personTaskId < b.data.personTaskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)

	self._taskDataQueue = taskDataQueue
end

function SKTPersonTaskView:_calcTaskState(data)
	if SaintKnightTaskController.instance:isHasGainPrizeAsPersonTask(data.personTaskId) then
		return GameEnum.PrizeState.IsHasGain
	end

	if not SaintKnightTaskController.instance:isEnoughGetPrizeAsPersonTask(data.personTaskId) then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function SKTPersonTaskView:_onUpdatePrizeColUI()
	local list = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == GameEnum.PrizeState.IsHasGain then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._prizeScrollList:reloadData(list)
end

function SKTPersonTaskView:_onClearPrizeColUI()
	self._prizeScrollList:dispose()
end

function SKTPersonTaskView:_updatePrizeCell(view, cell, info, tag)
	local state = info.state
	local data = info.data
	local mainGo = cell.gameObject
	local btnGet = goutil.findChild(mainGo, "btns/btnGet")
	local btnGoto = goutil.findChild(mainGo, "btns/btnGoto")
	local receivedGo = goutil.findChild(mainGo, "btns/receivedGo")
	local noFinishGo = goutil.findChild(mainGo, "btns/noFinishGo")
	local receivedGo = goutil.findChild(mainGo, "btns/receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtProg = goutil.findChildTextComponent(mainGo, "txtProg")
	local itemScrollView = goutil.findChild(mainGo, "items/itemScrollView")
	local itemCell = goutil.findChild(mainGo, "items/itemCell")

	if self._itemScrollLists[mainGo] == nil then
		self._itemScrollLists[mainGo] = ScrollerList.create(itemScrollView, itemCell, GameUtil.handler(self._updatePrizeItemCell, self), GameUtil.handler(self._clearPrizeItemCell, self))
	end

	if not string.nilorempty(data.prize) then
		local prizeStrList = string.split(data.prize, "#")

		self._itemScrollLists[mainGo]:reloadData(prizeStrList)
		self._itemScrollLists[mainGo]:dragNotifyParent()
	end

	if txtTitle then
		txtTitle.text = data.desc
	end

	if txtProg then
		local curProgress = SaintKnightTaskModel.instance:getProgressAsPersonTask(data.personTaskId)
		local maxProgress = data.maxProgress

		txtProg.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

		GameUtil.SetActive(txtProg.gameObject, state ~= GameEnum.PrizeState.IsHasGain)
	end

	GameUtil.SetActive(btnGet, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(noFinishGo, state == GameEnum.PrizeState.IsNotEnough and string.nilorempty(data.jumpTo))
	GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.SetActive(btnGoto, state == GameEnum.PrizeState.IsNotEnough and not string.nilorempty(data.jumpTo))
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickBtnGetPrize, self, info))
end

function SKTPersonTaskView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local btnGet = goutil.findChild(mainGo, "btns/btnGet")
	local btnGoto = goutil.findChild(mainGo, "btns/btnGoto")

	GameUtil.rmClickHandler(btnGet)
	GameUtil.rmClickHandler(btnGoto)

	if self._itemScrollLists[mainGo] then
		self._itemScrollLists[mainGo]:dispose()
	end
end

function SKTPersonTaskView:_updatePrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function SKTPersonTaskView:_clearPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function SKTPersonTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function SKTPersonTaskView:_onClickBtnGetPrize(info)
	if info.state ~= GameEnum.PrizeState.IsCanGet then
		return
	end

	SaintKnightTaskController.instance:sendSK_GainPersonTaskPrizeReq(self._activityId, info.data.personTaskId)
end

function SKTPersonTaskView:_onUpdateTeamColData()
	self._teamMemberList = {}

	local teamMemberCount = SaintKnightTaskConfig.instance:getSktTeamMemberCount(self._activityId)

	for index = 1, teamMemberCount do
		table.insert(self._teamMemberList, index)
	end
end

function SKTPersonTaskView:_onUpdateTeamColUI()
	local teamMembers = SaintKnightTaskModel.instance:getTeamMembers()
	local teamMemberCount = SaintKnightTaskConfig.instance:getSktTeamMemberCount(self._activityId)
	local curMemberCount = math.min(#teamMembers, teamMemberCount)
	local teamProgress = SaintKnightTaskModel.instance:getTeamProgress(self._activityId)
	local teamProgressMax = self:_getTeamProgressMax()

	self._txtTeamCount.text = string.format(self._teamCountFormat, curMemberCount, teamMemberCount)
	self._txtTeamProgress.text = string.format(self._teamProgressFormat, teamProgress, teamProgressMax)

	self._teamScrollList:reloadData(self._teamMemberList)
end

function SKTPersonTaskView:_getTeamProgressMax()
	local teamPrizeCfg = SaintKnightTaskConfig.instance:getSktTeamPrizeCfg(self._activityId) or {}
	local progressMax = 0

	for _, data in ipairs(teamPrizeCfg) do
		progressMax = math.max(progressMax, checknumber(data.progress))
	end

	return progressMax
end

function SKTPersonTaskView:_onClearTeamColUI()
	self._teamScrollList:dispose()
end

function SKTPersonTaskView:_updateTeamCell(view, cell, index, tag)
	local teamMembers = SaintKnightTaskModel.instance:getTeamMembers()
	local memberInfo = teamMembers[index]
	local headInfo = SaintKnightTaskModel.instance:getTeamMemberHeadInfo(memberInfo)
	local mainGo = cell.gameObject
	local headIcon = goutil.findChild(mainGo, "headIcon")
	local tagEmpty = goutil.findChild(mainGo, "tagEmpty")
	local isEmpty = headInfo == nil

	HeadItemController.instance:resetHeadCell(headIcon)
	GameUtil.SetActive(headIcon, not isEmpty)
	GameUtil.SetActive(tagEmpty, isEmpty)

	if not isEmpty then
		local proxy = HeadItemController.instance:setHeadCell(headIcon, headInfo.headIconId, 0, 0)

		if proxy then
			proxy:setAutoTips(false)
			proxy:setCallBack(function()
				FriendController.instance:showInfoView(headInfo.userId, headIcon)
			end)
		end
	end
end

function SKTPersonTaskView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local headIcon = goutil.findChild(mainGo, "headIcon")

	HeadItemController.instance:resetHeadCell(headIcon)
end

function SKTPersonTaskView:_onClickBtnInvite()
	UIStateManager.instance:push(ViewName.SKTPersonTaskTeamView, self._activityId)
end

function SKTPersonTaskView:_onUpdateTeamProgressColUI()
	local teamConfig = SaintKnightTaskConfig.instance:getSktTeamConfigData(self._activityId)
	local teamPrizeCfg = SaintKnightTaskConfig.instance:getSktTeamPrizeCfg(self._activityId)
	local teamProgress = SaintKnightTaskModel.instance:getTeamProgress(self._activityId)
	local scoreList = {}

	for _, data in ipairs(teamPrizeCfg) do
		table.insert(scoreList, data.progress)
	end

	self._txtTeamTotalScore.text = teamProgress

	MaterialMgr.setIcon(self._teamTotalIcon, MatType.ACTIVITY_ITEM, teamConfig.activityItemId)
	self._teamPrizeScrollList:reloadData(teamPrizeCfg)
	self._teamPrizeScrollList:updateUnderSlider(self._teamProgressSlider, teamProgress, scoreList)
	self._teamPrizeScrollList:MoveCellToCenter(self:_getTeamPrizeFocusIndex(teamPrizeCfg, scoreList, teamProgress))
end

function SKTPersonTaskView:_getTeamPrizeFocusIndex(teamPrizeCfg, scoreList, teamProgress)
	for idx, data in ipairs(teamPrizeCfg) do
		if SaintKnightTaskController.instance:isCanGetPrizeAsTeamTask(self._activityId, data.prizeId) then
			return idx - 1
		end
	end

	local index = 0

	for idx, progress in ipairs(scoreList) do
		if teamProgress < progress then
			break
		end

		index = idx - 1
	end

	return index
end

function SKTPersonTaskView:_onClearTeamProgressColUI()
	self._teamPrizeScrollList:dispose()
	uGuiUtil.clearImage(self._teamTotalIcon)
end

function SKTPersonTaskView:_updateTeamPrizeCell(view, cell, data, tag)
	local prizeId = data.prizeId
	local isHasGain = SaintKnightTaskController.instance:isHasGainPrizeAsTeamTask(prizeId)
	local isCanGet = SaintKnightTaskController.instance:isCanGetPrizeAsTeamTask(self._activityId, prizeId)
	local scrollRect = self._teamProgressScrView:GetComponent(ComponentType.ScrollRect)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickTeamPrizeGet, self, data))
end

function SKTPersonTaskView:_clearTeamPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function SKTPersonTaskView:_onClickTeamPrizeGet(data)
	local prizeId = data.prizeId

	if SaintKnightTaskController.instance:isHasGainPrizeAsTeamTask(prizeId) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not SaintKnightTaskController.instance:isEnoughGetPrizeAsTeamTask(self._activityId, prizeId) then
		FloatWordMgr.instance:show("积分不足")

		return
	end

	SaintKnightTaskController.instance:sendSK_GainTeamPrizeReq(self._activityId)
end

return SKTPersonTaskView
