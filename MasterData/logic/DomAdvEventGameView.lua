-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventGameView.lua

module("logic.extensions.domainadventure.view.DomAdvEventGameView", package.seeall)

local DomAdvEventGameView = class("DomAdvEventGameView", ViewComponent)

function DomAdvEventGameView:ctor()
	DomAdvEventGameView.super.ctor(self)
end

function DomAdvEventGameView:buildUI()
	DomAdvEventGameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._con = goutil.findChild(self.mainGO, "con")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._btnPrizeDetail = goutil.findChild(self.mainGO, "infoCol/btnPrizeDetail")

	local prizeScrView = goutil.findChild(self.mainGO, "infoCol/prizeScrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "infoCol/prizeScrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnClg = goutil.findChild(self.mainGO, "btnClg/btn")
	self._descIcon = goutil.findChild(self.mainGO, "btnClg/desc/icon")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "btnClg/desc/txt")
	self._times = goutil.findChild(self.mainGO, "btnClg/times")
	self._txtTimes = goutil.findChildTextComponent(self.mainGO, "btnClg/times/txt")
	self._slider = self:getSlider("slider")
	self._txtSlider = goutil.findChildTextComponent(self.mainGO, "slider/txtSlider")
end

function DomAdvEventGameView:bindEvents()
	DomAdvEventGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnPrizeDetail, function()
		UIStateManager.instance:push(ViewName.DomAdvNormalEventPrizeView, self._activityId, self._blockId)
	end, self)
end

function DomAdvEventGameView:unbindEvents()
	DomAdvEventGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnPrizeDetail)
end

function DomAdvEventGameView:onEnter()
	DomAdvEventGameView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._blockId = checknumber(params[2])

	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._scene = SceneMgr.instance:getCurScene()
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._actData = DomainAdventureConfig.instance:getActData(self._activityId)
	self._mapData = DomainAdventureConfig.instance:getMapData(self._activityId, self._blockId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._blockId)
	self._eventData = DomainAdventureConfig.instance:getGameEventData(self._activityId, self._eventId)
	self._prizePlanId = self._eventData.prizePlanId
	self._maxGameTimes = DomainAdventureConfig.instance:getDailyGameTimes(self._activityId)
	self._skinId = self._eventData.skinId
	self._raceId = PetSkinConfig.instance:getPetSkinRaceId(self._skinId)

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function DomAdvEventGameView:onExit()
	DomAdvEventGameView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.clearIcon(self._descIcon)
	MaterialMgr.resetAll(self._pointRare)
	self._prizeScrollerList:dispose()

	self._activityId = 0
	self._blockId = 0
	self._scene = nil
	self._domAdvMo = nil
	self._mapData = nil
	self._eventId = 0
	self._eventData = nil
	self._maxGameTimes = 0
end

function DomAdvEventGameView:_onSetUI()
	local list = {}
	local tab = {
		showAdd = false,
		id = DomainAdventureConfig.instance:getCostItem(self._activityId)
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local costItem = DomainAdventureConfig.instance:getCostItem(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(costItem)

	MaterialMgr.setIcon(self._descIcon, matType, matId)

	self._txtDesc.text = self._mapData.costStrength

	local skinId = self._skinId
	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("display", skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	local maxPrizeData = DomainAdventureConfig.instance:getMaxValuePrizeData(self._prizePlanId)
	local prizeStrArr = string.split(maxPrizeData.prize, "#")

	self._prizeScrollerList:reloadData(prizeStrArr)

	self._txtDesc.text = self._mapData.costStrength
end

function DomAdvEventGameView:_onUpdate()
	local gridState = self._scene:getGridState(self._blockId)
	local result, _ = self:_getTryStartGameResultAndTips()

	GameUtil.SetGray(self._btnClg, result ~= GameEnum.ResultCode.Success)

	local percentage = self._domAdvMo:getCurPercentageInBlock(self._blockId)

	percentage = Mathf.Clamp(1 - percentage, 0, 1)

	self._slider:SetValue(percentage)

	self._txtSlider.text = string.format("%.2f%%", percentage * 100)

	local isOcc = gridState:isOccupied()

	GameUtil.SetActive(self._times, isOcc)

	if self._txtTimes then
		local cur = self:_getCurTimes()
		local max = self:_getMaxTimes()
		local left = Mathf.Max(max - cur, 0)

		self._txtTimes.text = left > 0 and string.format("<color=#20b376>%s</color>/%s", left, max) or string.format("%s/%s", left, max)
	end
end

function DomAdvEventGameView:_updatePrizeCell(view, cell, prize, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prize, item)
end

function DomAdvEventGameView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DomAdvEventGameView:_getTryStartGameResultAndTips()
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		result, tips = self._scene:getTryStartGridEventResultAndTips(self._activityId, self._blockId)
	end

	if result == GameEnum.ResultCode.Success then
		local gridState = self._scene:getGridState(self._blockId)
		local isOcc = gridState:isOccupied()

		if isOcc and not self:_isEnoughTimes() then
			result = GameEnum.ResultCode.Error
			tips = "剩余游玩次数不足"
		end
	end

	return result, tips
end

function DomAdvEventGameView:_isEnoughTimes()
	local cur = self:_getCurTimes()
	local max = self:_getMaxTimes()

	return cur < max
end

function DomAdvEventGameView:_getCurTimes()
	return self._domAdvMo:getTodayGameTimes()
end

function DomAdvEventGameView:_getMaxTimes()
	return self._maxGameTimes
end

function DomAdvEventGameView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(key)
end

function DomAdvEventGameView:_onClickBtnSkill()
	local raceId = self._raceId
	local skinId = self._skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DomAdvEventGameView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DomAdvEventGameView:_onClickBtnClg()
	local result, tips = self:_getTryStartGameResultAndTips()

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local stagePlanId = self._eventData.stagePlanId
	local cfg = PinGameConfig.instance:getStageCfg(stagePlanId)

	if cfg then
		local stageId = Mathf.Random(1, #cfg)

		PinGameController.instance:enterGameByMoInDomAdvCopy(self._activityId, self._blockId, stagePlanId, stageId)
	else
		printError(string.format("错误，见缝插针找不到关卡配置( stagePlanId=%s )", stagePlanId))
	end
end

return DomAdvEventGameView
