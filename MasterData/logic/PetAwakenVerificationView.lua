-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petawakenverification/view/PetAwakenVerificationView.lua

module("logic.extensions.petawakenverification.view.PetAwakenVerificationView", package.seeall)

local PetAwakenVerificationView = class("PetAwakenVerificationView", ViewComponent)

function PetAwakenVerificationView:ctor()
	PetAwakenVerificationView.super.ctor(self)
end

function PetAwakenVerificationView:buildUI()
	PetAwakenVerificationView.super.buildUI(self)

	self._bg = goutil.findChild(self.mainGO, "bg")
	self._bgEffect = goutil.findChild(self.mainGO, "bgEffect")
	self._btnSkill = goutil.findChild(self.mainGO, "btnSkill")
	self._btnBook = goutil.findChild(self.mainGO, "btnBook")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._timeTxt = goutil.findChildTextComponent(self.mainGO, "timeGo/timeTxt")
	self._exCol = goutil.findChild(self.mainGO, "exCol")
	self._goToCellList = {}
	self._txtNamePetInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._rare = goutil.findChild(self.mainGO, "petInfo/rare")
	self._petCol = goutil.findChild(self.mainGO, "petCol")
	self._petCon = goutil.findChild(self.mainGO, "petCol/petPos/petCon")
	self._petCell = goutil.findChild(self.mainGO, "petCol/petCell")

	GameUtil.SetActive(self._petCell, false)

	self._petCellList = {}
	self._petEff = nil
	self._prizeScrollView = goutil.findChild(self.mainGO, "prizeCol/prizeScrollView")
	self._prizeScrollCell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollCell")

	local updateCellCallBack, clearCellCallBack = GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self)

	self._prizeScrollList = ScrollerList.create(self._prizeScrollView, self._prizeScrollCell, updateCellCallBack, clearCellCallBack)
end

function PetAwakenVerificationView:bindEvents()
	PetAwakenVerificationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBtnBook, self)
end

function PetAwakenVerificationView:unbindEvents()
	PetAwakenVerificationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnBook)
end

function PetAwakenVerificationView:destroyUI()
	PetAwakenVerificationView.super.destroyUI(self)
end

function PetAwakenVerificationView:onEnter()
	PetAwakenVerificationView.super.onEnter(self)

	local params = self:getOpenParam()

	if params then
		self._activityId = params[1] and checknumber(params[1]) or self._activityId
		self._id = params[2] and checknumber(params[2]) or self._id
	end

	self._activityId, self._id = self:_checkActivityIdAndId(self._activityId, self._id)

	if self._activityId == nil or self._id == nil then
		FloatWordMgr.instance:show("该精灵未开放觉醒验证")
		printError("错误,不在活动期内的界面被打开,快检查配置并矫正")
		self:_onClickBtnClose()

		return
	end

	SurveyController.instance:reportBehavior(200791)
	PetAwakenVerificationController.instance:setPetAwakenVerificationDayFirstClickRedPoint(self._activityId, false)
	PetAwakenVerificationController.instance:setPetAwakenVerificationActFirstClickRedPoint(self._activityId, false)

	self._verCfg = PetAwakenVerificationConfig.instance:getPetAwakenVerCfg(self._activityId)
	self._verPetCfgs = PetAwakenVerificationConfig.instance:getPetAwakenVerPetCfgs(self._activityId)
	self._verGoToCfgs = PetAwakenVerificationConfig.instance:getPetAwakenVerGoToCfgs(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.PetAwakenVerificationOnUpdate, self._onUpdateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PetAwakenVerificationGainPrize, self._onUpdateUI, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyRefresh, self)
	PetAwakenVerificationController.instance:onSendPetAwakenVerificationGetInfoReq(self._activityId)
end

function PetAwakenVerificationView:onExit()
	PetAwakenVerificationView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetAwakenVerificationOnUpdate, self._onUpdateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetAwakenVerificationGainPrize, self._onUpdateUI, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyRefresh, self)

	if self._petEff then
		self._petEff:clear()

		self._petEff = nil
	end

	MaterialMgr.resetAll(self._rare)
	self:_onClearPetCell()
	self._prizeScrollList:dispose()
	self:_clearGoToCell()
end

function PetAwakenVerificationView:_onUpdateUI()
	self._activityId, self._id = self:_checkActivityIdAndId(self._activityId, self._id)

	if self._activityId == nil or self._id == nil then
		FloatWordMgr.instance:show("活动已结束")
		self:_onClickBtnClose()

		return
	end

	self:_onUpdatePrizeDataMo()
	self:_onUpdatePlaneUI()
	self:_onUpdateGoToCell()
	self:_onUpdatePetCell()
	self:_onUpdatePrizeScroller()
end

function PetAwakenVerificationView:_onUpdatePlaneUI()
	local verPetCfg = PetAwakenVerificationConfig.instance:getPetAwakenVerPetCfgById(self._activityId, self._id)

	if verPetCfg.skinId == 0 then
		printError("skinId未正确，无法展现精灵动图")
	elseif self._petCon == nil then
		printError("动图挂载点为空")
	else
		local x, y, scaleX = verPetCfg.rolePos[1], verPetCfg.rolePos[2], verPetCfg.rolePos[3]

		self._petEff = self._petEff or PetPhotoShow.Get(self._petCon)

		self._petEff:showPetEffect(verPetCfg.skinId, true, 3)
		GameUtil.setLocalPos(self._petCon, x, y, 0)
		GameUtil.setLocalScale(self._petCon, scaleX, math.abs(scaleX), 1)
	end

	local isNeedPetName = not string.nilorempty(verPetCfg.petName) and self._txtNamePetInfo ~= nil

	if isNeedPetName then
		self._txtNamePetInfo.text = verPetCfg.petName
	end

	if self._timeTxt then
		local startTime, endTime = GameUtil.string2time(verPetCfg.startTime), GameUtil.string2time(verPetCfg.endTime)
		local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

		self._timeTxt.text = string.format("活动时间：%s月%s日%s:00 - %s月%s日%s:00", startDate.month, startDate.day, startDate.hour, endDate.month, endDate.day, endDate.hour)
	end

	MaterialMgr.setCell(MatType.Rare, verPetCfg.raceId, self._rare)
end

function PetAwakenVerificationView:_checkActivityIdAndId(_activityId, _id)
	local activityId, id = checknumber(_activityId), checknumber(_id)
	local isInActTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PetAwakenVer, activityId)

	if isInActTime == false then
		local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.PetAwakenVer)

		if actCfg then
			activityId = actCfg.activityId
		else
			printError(string.format("活动可能已结束，y-活动时间表内无法找到符合的版本( activityId=%s, id=%s )", activityId, id))

			return nil, nil
		end
	end

	local petTimeType = PetAwakenVerificationController.instance:getOnePetActTimeType(activityId, id)

	if petTimeType ~= GameUtil.inTimePeriod then
		local verPetCfgs = PetAwakenVerificationConfig.instance:getPetAwakenVerPetCfgs(activityId)
		local isHaveFit = false

		for _, data in ipairs(verPetCfgs) do
			local timeType = PetAwakenVerificationController.instance:getOnePetActTimeType(activityId, data.id)

			if timeType == GameUtil.inTimePeriod then
				id = data.id
				isHaveFit = true

				break
			end
		end

		if isHaveFit == false then
			printError(string.format("请检查“j精灵觉醒验证”配置表，没有在活动期内的精灵配置( activityId=%s, id=%s )", activityId, id))

			return nil, nil
		end
	end

	return activityId, id
end

function PetAwakenVerificationView:_dailyRefresh()
	PetAwakenVerificationController.instance:onSendPetAwakenVerificationGetInfoReq(self._activityId)
end

function PetAwakenVerificationView:_onUpdatePrizeDataMo()
	self._prizeDataMo = {}

	for _, verPetData in ipairs(self._verPetCfgs) do
		local id = verPetData.id
		local verPrizeCfgs = PetAwakenVerificationConfig.instance:getPetAwakenVerPrizeCfgs(self._activityId, id)
		local petId, awakenLv = PetAwakenVerificationController.instance:getPetAwakenAndPetIdByRaceId(verPetData.raceId)
		local prizeList = {}

		for _, verPrizeData in ipairs(verPrizeCfgs) do
			local tab = {}

			tab.state = self:_calcPrizeState(verPrizeData, id, awakenLv)
			tab.data = verPrizeData
			prizeList[verPrizeData.prizeId] = tab
		end

		local mo = {}

		mo.prizeList = prizeList
		mo.petId = petId
		mo.awakenLv = awakenLv
		mo.petTimeType = PetAwakenVerificationController.instance:getOnePetActTimeType(self._activityId, id)
		self._prizeDataMo[id] = mo
	end
end

function PetAwakenVerificationView:_calcPrizeState(data, id, awakenLv)
	local state = 2
	local gainedPrizeIds = PetAwakenVerificationModel.instance:getGainedPrizeIdsById(id)
	local isHasGain = table.indexof(gainedPrizeIds, data.prizeId) ~= false

	if isHasGain then
		state = 3
	else
		local isEnoughLv = awakenLv >= data.needAwakenLv

		state = isEnoughLv and 1 or 2
	end

	return state
end

function PetAwakenVerificationView:_getAwakenLvFromMo(id)
	if self._prizeDataMo[id] == nil then
		printError(string.format("self._prizeDataMo[ %s ] == nil", id))

		return nil
	end

	return self._prizeDataMo[id].awakenLv
end

function PetAwakenVerificationView:_getPetIdFromMo(id)
	if self._prizeDataMo[id] == nil then
		printError(string.format("self._prizeDataMo[ %s ] == nil", id))

		return nil
	end

	return self._prizeDataMo[id].petId
end

function PetAwakenVerificationView:_getPetTimeTypeFromMo(id)
	if self._prizeDataMo[id] == nil then
		printError(string.format("self._prizeDataMo[ %s ] == nil", id))

		return nil
	end

	return self._prizeDataMo[id].petTimeType
end

function PetAwakenVerificationView:_getPrizeListFromMo(id)
	if self._prizeDataMo[id] == nil then
		printError(string.format("self._prizeDataMo[ %s ] == nil", id))

		return nil
	end

	return self._prizeDataMo[id].prizeList or {}
end

function PetAwakenVerificationView:_getPrizeStateFromMo(id, prizeId)
	if self._prizeDataMo[id] == nil then
		printError(string.format("self._prizeDataMo[ %s ] == nil", id))

		return nil
	end

	if self._prizeDataMo[id].prizeList[prizeId] == nil then
		printError(string.format("self._prizeDataMo[ %s ].prizeList[ %s ] == nil", id, prizeId))
	end

	return self._prizeDataMo[id].prizeList[prizeId].state
end

function PetAwakenVerificationView:_isPrizeListHavePrizeCanGet(id)
	local prizeList = self._prizeDataMo[id].prizeList
	local isHave = false

	for _, v in ipairs(prizeList) do
		isHave = isHave or v.state == 1
	end

	return isHave
end

function PetAwakenVerificationView:_onUpdatePetCell()
	for _, data in ipairs(self._verPetCfgs) do
		self._petCellList[data.id] = self._petCellList[data.id] or self:_creatPetCell()

		local cell = self._petCellList[data.id]

		cell._mainGo.name = "petCell_" .. data.skinId

		GameUtil.setLocalPos(cell._mainGo, data.headPos[1] or 0, data.headPos[2] or 0, 0)

		local petTimeType = self:_getPetTimeTypeFromMo(data.id)
		local isInShowTime = petTimeType == GameUtil.inTimePeriod

		GameUtil.SetActive(cell._mainGo, isInShowTime)
		MaterialMgr.setIcon(cell._iconGo, MatType.Pet, data.skinId, nil, nil)

		local isNeedTitle = not string.nilorempty(data.title) and cell._txtTitle ~= nil

		GameUtil.SetActive(cell._txtTitle, isNeedTitle)

		if isNeedTitle then
			cell._txtTitle.text = data.title
		end

		local isHaveCanGet = self:_isPrizeListHavePrizeCanGet(data.id)

		GameUtil.SetActive(cell._redPoint, isHaveCanGet)

		local isSelect = data.id == self._id

		GameUtil.SetActive(cell._select, isSelect)

		local handler = GameUtil.handler(self._onClickBtnPetCell, self, data)

		GameUtil.addClickHandler(cell._mainGo, handler)
	end
end

function PetAwakenVerificationView:_creatPetCell()
	local mainGo = goutil.cloneAndSetParent(self._petCell, self._petCol.transform, "petCell")
	local cell = {}

	cell._mainGo = mainGo
	cell._iconGo = goutil.findChild(mainGo, "icon")
	cell._select = goutil.findChild(mainGo, "select")
	cell._redPoint = goutil.findChild(mainGo, "redPoint")
	cell._txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")

	return cell
end

function PetAwakenVerificationView:_onClearPetCell()
	for _, cell in ipairs(self._petCellList) do
		uGuiUtil.clearImage(cell._iconGo)
	end
end

function PetAwakenVerificationView:_onClickBtnPetCell(data)
	self._id = data.id

	self:_onUpdateUI()
end

function PetAwakenVerificationView:_onUpdatePrizeScroller()
	local dataList = {}
	local prizeList = self:_getPrizeListFromMo(self._id)

	for _, tab in ipairs(prizeList) do
		table.insert(dataList, tab.data)
	end

	self._prizeScrollList:reloadData(dataList)
end

function PetAwakenVerificationView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell
	local btnGet = goutil.findChild(mainGo, "btns/btnGet")
	local receivedGo = goutil.findChild(mainGo, "btns/receivedGo")
	local noFinishGo = goutil.findChild(mainGo, "btns/noFinishGo")
	local receivedGo = goutil.findChild(mainGo, "btns/receivedGo")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local itemScrollView = goutil.findChild(mainGo, "items/itemScrollView")
	local itemCell = goutil.findChild(mainGo, "items/itemCell")
	local updateCellCallBack, clearCellCallBack = GameUtil.handler(self._updatePrizeItemCell, self), GameUtil.handler(self._clearPrizeItemCell, self)

	self._itemScrollLists = self._itemScrollLists or {}
	self._itemScrollLists[mainGo] = self._itemScrollLists[mainGo] or ScrollerList.create(itemScrollView, itemCell, updateCellCallBack, clearCellCallBack)

	local itemScrollList = self._itemScrollLists[mainGo]
	local prizeStrList = string.split(data.prize, "#")

	itemScrollList:reloadData(prizeStrList)

	local state = self:_getPrizeStateFromMo(self._id, data.prizeId)

	GameUtil.SetActive(btnGet, state == 1)
	GameUtil.SetActive(noFinishGo, state == 2)
	GameUtil.SetActive(receivedGo, state == 3)

	local handler = GameUtil.handler(self._onClickBtnGetPrize, self, data.prizeId)

	GameUtil.addClickHandler(btnGet, handler)

	if txtTitle then
		txtTitle.text = data.title
	end
end

function PetAwakenVerificationView:_clearPrizeCell(cell)
	local mainGo = cell
	local btnGet = goutil.findChild(mainGo, "btns/btnGet")

	GameUtil.rmClickHandler(btnGet)

	local itemScrollList = self._itemScrollLists[mainGo]

	itemScrollList:dispose()
end

function PetAwakenVerificationView:_updatePrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell

	if mainGo then
		MaterialMgr.setCellByCfg(prizeStr, mainGo)
	end
end

function PetAwakenVerificationView:_clearPrizeItemCell(cell)
	local mainGo = cell

	MaterialMgr.resetAll(mainGo)
end

function PetAwakenVerificationView:_onClickBtnGetPrize(prizeId)
	local petId = self:_getPetIdFromMo(self._id)

	PetAwakenVerificationController.instance:onSendPetAwakenVerificationGainPrizeReq(self._activityId, self._id, prizeId, petId)
end

function PetAwakenVerificationView:_onUpdateGoToCell()
	for idx, data in ipairs(self._verGoToCfgs) do
		self._goToCellList[idx] = self._goToCellList[idx] or self:_buildGoToCell(idx)

		local cell = self._goToCellList[idx]

		if cell == nil then
			printError("配置的跳转按钮，超过了预制体中按钮数量，请联系策划或程序修正")

			break
		end

		if cell._redPoint then
			RedPointController.instance:unregRedPoint(cell._redPoint)
			RedPointController.instance:regRedPoint(cell._redPoint, unpack(string.split(data.redId, "#")))
		end

		if cell._txtTitle then
			cell._txtTitle.text = data.title
		end

		local handler = GameUtil.handler(self._onClickBtnGoToCell, self, data)

		GameUtil.addClickHandler(cell._mainGo, handler)
		GameUtil.SetActive(cell._mainGo, true)
	end
end

function PetAwakenVerificationView:_buildGoToCell(idx)
	local mainGo = goutil.findChild(self.mainGO, "exCol/btnGo" .. idx)

	if mainGo == nil then
		return nil
	end

	local cell = {}

	cell._mainGo = mainGo
	cell._redPoint = goutil.findChild(mainGo, "redPoint")
	cell._txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")

	return cell
end

function PetAwakenVerificationView:_clearGoToCell()
	for idx, cell in ipairs(self._goToCellList) do
		uGuiUtil.clearImage(cell._mainGo)
		GameUtil.rmClickHandler(cell._mainGo)
	end
end

function PetAwakenVerificationView:_onClickBtnGoToCell(data)
	GotoMgr.gotoByString(data.gotoStr)
end

function PetAwakenVerificationView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("jinglingjuexingRule")
end

function PetAwakenVerificationView:_onClickBtnClose()
	self:close()
end

function PetAwakenVerificationView:_onClickBtnSkill()
	local verPetCfg = PetAwakenVerificationConfig.instance:getPetAwakenVerPetCfgById(self._activityId, self._id)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(verPetCfg.skinId)

	if cfg == nil then
		printError("skinId 在 j-精灵皮肤配置表 中找不到配置")
	else
		PetbookController.instance:previewBattle(verPetCfg.raceId, verPetCfg.skinId, false)
	end
end

function PetAwakenVerificationView:_onClickBtnBook()
	local verPetCfg = PetAwakenVerificationConfig.instance:getPetAwakenVerPetCfgById(self._activityId, self._id)

	PetbookController.instance:openPetinfoView(verPetCfg.raceId)
end

return PetAwakenVerificationView
