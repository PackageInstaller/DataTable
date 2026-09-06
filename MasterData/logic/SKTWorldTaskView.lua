-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTWorldTaskView.lua

module("logic.extensions.saintknighttask.view.SKTWorldTaskView", package.seeall)

local SKTWorldTaskView = class("SKTWorldTaskView", ViewComponent)

function SKTWorldTaskView:ctor()
	SKTWorldTaskView.super.ctor(self)
end

function SKTWorldTaskView:buildUI()
	SKTWorldTaskView.super.buildUI(self)

	self._bg = goutil.findChild(self.mainGO, "bg")
	self._bgEffect = goutil.findChild(self.mainGO, "bgEffect")
	self._txtShowNum = goutil.findChildTextComponent(self.mainGO, "showNum/txt")
	self._txtTipsTitle = goutil.findChildTextComponent(self.mainGO, "tip/txtTitle")
	self._petCol = goutil.findChild(self.mainGO, "petCol")
	self._petCon = goutil.findChild(self.mainGO, "petCol/petPos/petCon")
	self._petCell = goutil.findChild(self.mainGO, "petCol/petCell")
	self._petView = goutil.findChild(self.mainGO, "petCol/petView")
	self._prizeScrollView = goutil.findChild(self.mainGO, "prizeCol/prizeScrollView")
	self._prizeScrollCell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollCell")
	self._prizeScrollList = ScrollerList.create(self._prizeScrollView, self._prizeScrollCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	GameUtil.SetActive(self._petCell, false)

	self._petCellList = {}
	self._itemScrollLists = {}
	self._petEff = nil
end

function SKTWorldTaskView:bindEvents()
	SKTWorldTaskView.super.bindEvents(self)
end

function SKTWorldTaskView:unbindEvents()
	SKTWorldTaskView.super.unbindEvents(self)
end

function SKTWorldTaskView:destroyUI()
	SKTWorldTaskView.super.destroyUI(self)
end

function SKTWorldTaskView:onEnter()
	SKTWorldTaskView.super.onEnter(self)

	self._activityId = SaintKnightTaskController.instance:getActivityId()

	local isInTime = SaintKnightTaskController.instance:isInActivityTimeAsSkt(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._actData = SaintKnightTaskConfig.instance:getSktActData(self._activityId)
	self._curWorldTaskPlanId = self._curWorldTaskPlanId or 0

	GlobalDispatcher:addListener(GlobalNotify.SKTaskWorldTasksGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SKTaskWorldTasksGainPrizeRes, self.handleGainPrizeRes, self)
	SaintKnightTaskController.instance:sendWorldTasksGetInfoReq(self._activityId)
end

function SKTWorldTaskView:onExit()
	SKTWorldTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskWorldTasksGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTaskWorldTasksGainPrizeRes, self.handleGainPrizeRes, self)

	if self._petEff then
		self._petEff:clear()

		self._petEff = nil
	end

	self:_onClearPetCol()
	self:_onClearPrizeColUI()
end

function SKTWorldTaskView:handleGainPrizeRes()
	SaintKnightTaskController.instance:sendWorldTasksGetInfoReq(self._activityId)
end

function SKTWorldTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateRed()
	self:_onUpdateUI()
end

function SKTWorldTaskView:_onUpdateData()
	self:_checkCurWorldTaskPlanId()
	self:_onUpdatePetColData()
	self:_onUpdatePrizeColData()
end

function SKTWorldTaskView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePetColUI()
	self:_onUpdatePrizeColUI()
end

function SKTWorldTaskView:_checkCurWorldTaskPlanId()
	local isUnlockCurPlan = checknumber(self._curWorldTaskPlanId) ~= 0 and SaintKnightTaskController.instance:isUnlockByTimeAsWorldTasksPlan(self._curWorldTaskPlanId)

	if isUnlockCurPlan then
		return
	end

	local curWorldTaskPlanId = 0

	for _, worldTaskPlanId in ipairs(self._actData.worldTaskPlanIdArray) do
		if SaintKnightTaskController.instance:isUnlockByTimeAsWorldTasksPlan(worldTaskPlanId) then
			curWorldTaskPlanId = worldTaskPlanId

			break
		end
	end

	self._curWorldTaskPlanId = curWorldTaskPlanId
end

function SKTWorldTaskView:_onUpdatePlaneUI()
	if self._curWorldTaskPlanId == 0 then
		return
	end

	local data = SaintKnightTaskConfig.instance:getSktWorldTaskPlanData(self._curWorldTaskPlanId)

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

	local progress = SaintKnightTaskModel.instance:getWorldTasksGainUserNum(self._curWorldTaskPlanId)

	self._txtShowNum.text = string.format("当前全服共有<color=#8AF8FFFF>%s</color>人获得%s", progress, data.planName)
	self._txtTipsTitle.text = string.format("成功获得%s后，即可领取进度奖励", data.planName)
end

function SKTWorldTaskView:_onUpdateRed()
	SaintKnightTaskController.instance:setFirstRedAsWorldTasksPlan(self._activityId, self._curWorldTaskPlanId)
	SaintKnightTaskController.instance:updateSKTWorldTaskFirstRed()
end

function SKTWorldTaskView:_onUpdatePetColData()
	local planInfoList = {}

	for _, worldTaskPlanId in ipairs(self._actData.worldTaskPlanIdArray) do
		local data = SaintKnightTaskConfig.instance:getSktWorldTaskPlanData(worldTaskPlanId)
		local isCanGetPrize = SaintKnightTaskController.instance:isCanGetPrizeInWorldTasksPlan(worldTaskPlanId)
		local isUnlock = SaintKnightTaskController.instance:isUnlockByTimeAsWorldTasksPlan(worldTaskPlanId)
		local info = {
			data = data,
			isCanGetPrize = isCanGetPrize,
			isUnlock = isUnlock
		}

		table.insert(planInfoList, info)
	end

	self._planInfoList = planInfoList
end

function SKTWorldTaskView:_onUpdatePetColUI()
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

			mainGo.name = "petCell_" .. data.worldTaskPlanId

			GameUtil.setLocalPos(mainGo, data.headPos[1] or 0, data.headPos[2] or 0, 0)
			GameUtil.SetActive(lock, not isUnlock)
			MaterialMgr.setIcon(iconGo, MatType.Pet, data.skinId, nil, nil)
			GameUtil.SetActive(redPoint, false)
			RedPointController.instance:unregRedPoint(redPoint)

			if SaintKnightTaskController.instance:isNeedFirstRedAsWorldTasksPlan(self._activityId, data.worldTaskPlanId) then
				RedPointController.instance:regRedPoint(redPoint, SaintKnightTaskConfig.instance:getSktWorldTaskFirstRed())
			elseif isCanGetPrize then
				GameUtil.SetActive(redPoint, true)
			end

			GameUtil.SetActive(selectGo, data.worldTaskPlanId == self._curWorldTaskPlanId)
			GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPetCell, self, info))
		end
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #self._planInfoList)
	end
end

function SKTWorldTaskView:_onClearPetCol()
	local parentTran = self._petView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		local iconGo = goutil.findChild(mainGo, "icon")
		local redPoint = goutil.findChild(mainGo, "redPoint")

		uGuiUtil.clearImage(iconGo)
		RedPointController.instance:unregRedPoint(redPoint)
	end
end

function SKTWorldTaskView:_onClickPetCell(info)
	if info.isUnlock == false then
		local startDate = GameUtil.string2date(info.data.openTime)
		local str = string.format(" %s月%s日%s:00开放", startDate.month, startDate.day, startDate.hour)

		FloatWordMgr.instance:show(str)

		return
	end

	self._curWorldTaskPlanId = info.data.worldTaskPlanId

	self:_onUpdate()
end

function SKTWorldTaskView:_onUpdatePrizeColData()
	local infoListPool = {}

	for _, worldTaskPlanId in ipairs(self._actData.worldTaskPlanIdArray) do
		local infoList = {}
		local cfg = SaintKnightTaskConfig.instance:getSktWorldTaskPrizeCfgById(worldTaskPlanId)

		for _, data in ipairs(cfg) do
			local tab = {}

			tab.data = data
			tab.state = self:_calcTaskState(worldTaskPlanId, data)

			table.insert(infoList, tab)
		end

		table.sort(infoList, function(a, b)
			if a.state == b.state then
				if a.data.index < b.data.index then
					return true
				end

				return false
			end

			return a.state < b.state
		end)

		infoListPool[worldTaskPlanId] = infoList
	end

	self._infoListPool = infoListPool
end

function SKTWorldTaskView:_calcTaskState(worldTaskPlanId, data)
	if SaintKnightTaskController.instance:isHasGainPrizeInWorldTasks(worldTaskPlanId, data.index) then
		return GameEnum.PrizeState.IsHasGain
	end

	if not SaintKnightTaskController.instance:isEnoughGetPrizeInWorldTasks(worldTaskPlanId, data.index) then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function SKTWorldTaskView:_onUpdatePrizeColUI()
	self._prizeScrollList:reloadData(self._infoListPool[self._curWorldTaskPlanId] or {})
end

function SKTWorldTaskView:_onClearPrizeColUI()
	self._prizeScrollList:dispose()
end

function SKTWorldTaskView:_updatePrizeCell(view, cell, info, tag)
	local state = info.state
	local data = info.data
	local isEnoughGetProgress = SaintKnightTaskController.instance:isEnoughGetPrizeProgressInWorldTasks(self._curWorldTaskPlanId, data.index)
	local isEnoughGetCond = SaintKnightTaskController.instance:isEnoughGetPrizeCondInWorldTasks(self._curWorldTaskPlanId)
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
		local data = SaintKnightTaskConfig.instance:getSktWorldTaskPrizeDataById(self._curWorldTaskPlanId, data.index)
		local progress = SaintKnightTaskModel.instance:getWorldTasksGainUserNum(self._curWorldTaskPlanId)

		txtProg.text = string.format("%s/%s", progress, data.progress)

		GameUtil.SetActive(txtProg.gameObject, state ~= GameEnum.PrizeState.IsHasGain)
	end

	GameUtil.SetActive(btnGet, state == GameEnum.PrizeState.IsCanGet)

	if state == GameEnum.PrizeState.IsNotEnough and not isEnoughGetCond and isEnoughGetProgress then
		GameUtil.SetActive(btnGet, true)
	end

	GameUtil.SetActive(noFinishGo, state == GameEnum.PrizeState.IsNotEnough and not GameUtil.GetActive(btnGet) and string.nilorempty(data.jumpTo))
	GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.SetActive(btnGoto, state == GameEnum.PrizeState.IsNotEnough and not GameUtil.GetActive(btnGet) and not string.nilorempty(data.jumpTo))
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickBtnGetPrize, self, info))
end

function SKTWorldTaskView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local btnGet = goutil.findChild(mainGo, "btns/btnGet")

	GameUtil.rmClickHandler(btnGet)

	if self._itemScrollLists[mainGo] then
		self._itemScrollLists[mainGo]:dispose()
	end
end

function SKTWorldTaskView:_updatePrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function SKTWorldTaskView:_clearPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function SKTWorldTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function SKTWorldTaskView:_onClickBtnGetPrize(info)
	if not SaintKnightTaskController.instance:isEnoughGetPrizeCondInWorldTasks(self._curWorldTaskPlanId) then
		local planData = SaintKnightTaskConfig.instance:getSktWorldTaskPlanData(self._curWorldTaskPlanId)

		FloatWordMgr.instance:show(string.format("获得[%s]后可领取奖励哦~", planData.planName))

		return
	end

	if info.state ~= GameEnum.PrizeState.IsCanGet then
		return
	end

	SaintKnightTaskController.instance:sendWorldTasksGainPrizeReq(self._activityId, self._curWorldTaskPlanId, info.data.index)
end

return SKTWorldTaskView
