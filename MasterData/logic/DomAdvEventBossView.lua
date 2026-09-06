-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventBossView.lua

module("logic.extensions.domainadventure.view.DomAdvEventBossView", package.seeall)

local DomAdvEventBossView = class("DomAdvEventBossView", ViewComponent)

function DomAdvEventBossView:ctor()
	DomAdvEventBossView.super.ctor(self)
end

function DomAdvEventBossView:buildUI()
	DomAdvEventBossView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._con = goutil.findChild(self.mainGO, "con")
	self._txtDamageTips = goutil.findChildTextComponent(self.mainGO, "damageTips/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._btnPrizeDetail = goutil.findChild(self.mainGO, "infoCol/btnPrizeDetail")
	self._txtUnlockCond = goutil.findChildTextComponent(self.mainGO, "infoCol/txtUnlockCond")

	local prizeScrView = goutil.findChild(self.mainGO, "infoCol/prizeScrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "infoCol/prizeScrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._btnClg = goutil.findChild(self.mainGO, "btnClg/btn")
	self._descIcon = goutil.findChild(self.mainGO, "btnClg/desc/icon")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "btnClg/desc/txt")
	self._txtTimes = goutil.findChildTextComponent(self.mainGO, "btnClg/times/txt")
	self._btnExercise = goutil.findChild(self.mainGO, "btnExercise")
	self._slider = self:getSlider("slider")
	self._txtSlider = goutil.findChildTextComponent(self.mainGO, "slider/txtSlider")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnPort = goutil.findChild(self.mainGO, "btnPort")
	self._redBtnPort = goutil.findChild(self.mainGO, "btnPort/redPoint")
end

function DomAdvEventBossView:bindEvents()
	DomAdvEventBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnClg, GameUtil.handler(self._onClickBtnClg, self, DomAdvEnum.BossFightMode_Normal))
	GameUtil.addClickHandler(self._btnExercise, GameUtil.handler(self._onClickBtnClg, self, DomAdvEnum.BossFightMode_Exercise))
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnPort, self._onClickBtnPort, self)
	GameUtil.addClickHandler(self._btnPrizeDetail, function()
		UIStateManager.instance:push(ViewName.DomAdvNormalEventPrizeView, self._activityId, self._blockId)
	end, self)
end

function DomAdvEventBossView:unbindEvents()
	DomAdvEventBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnExercise)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPort)
	GameUtil.rmClickHandler(self._btnPrizeDetail)
end

function DomAdvEventBossView:onEnter()
	DomAdvEventBossView.super.onEnter(self)

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
	self._eventData = DomainAdventureConfig.instance:getBossEventData(self._activityId, self._eventId)
	self._prizePlanId = self._eventData.prizePlanId
	self._prizeCfg = DomainAdventureConfig.instance:getValuePrizeCfg(self._prizePlanId)
	self._skinId = self._eventData.skinId
	self._raceId = PetSkinConfig.instance:getPetSkinRaceId(self._skinId)

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)

	local storyId = self._actData.firstBossStoryId

	if storyId > 0 then
		local key = string.format("DomainAdventure_First_Boss_Story_%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_onSetUI()
	self:_onUpdate()
end

function DomAdvEventBossView:onExit()
	DomAdvEventBossView.super.onExit(self)
	MaterialMgr.clearIcon(self._descIcon)
	MaterialMgr.resetAll(self._pointRare)
	self._prizeScrollerList:dispose()
	RedPointController.instance:unregRedPoint(self._redBtnPort)

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function DomAdvEventBossView:_onSetUI()
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
	RedPointController.instance:regRedPoint(self._redBtnPort, RedPointModel.ID_PASSPORT_DOMADV)
end

function DomAdvEventBossView:_onUpdate()
	local result, _ = self._scene:getTryStartEventBossResultAndTips(self._blockId, DomAdvEnum.BossFightMode_Normal)

	GameUtil.SetGray(self._btnClg, result ~= GameEnum.ResultCode.Success)

	local percentage = self._domAdvMo:getCurPercentageInBlock(self._blockId)

	percentage = Mathf.Clamp(1 - percentage, 0, 1)

	self._slider:SetValue(percentage)

	self._txtSlider.text = string.format("%.2f%%", percentage * 100)
	self._txtDamageTips.text = self._domAdvMo:getHistoryMaxDamageInBoss()

	if self._txtTimes then
		local cur = self._domAdvMo:getDailyFightBossTimesInBoss()
		local max = self._domAdvMo:getMaxBossFightTimes(self._blockId)
		local left = Mathf.Max(max - cur, 0)

		self._txtTimes.text = left > 0 and string.format("<color=#20b376>%s</color>/%s", left, max) or string.format("%s/%s", left, max)
	end

	if self._txtUnlockCond then
		local cur = self._domAdvMo:getOccupiedGlobalBlockNum(self._blockId)
		local max = self._domAdvMo:getMaxBossUnlockCount(self._blockId)

		self._txtUnlockCond.text = max <= cur and string.format("占领地块（<color=#20b376>%s</color>/%s）解锁", Mathf.Min(cur, max), max) or string.format("占领地块（%s/%s）解锁", Mathf.Min(cur, max), max)
	end
end

function DomAdvEventBossView:_updatePrizeCell(view, cell, prize, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prize, item)
end

function DomAdvEventBossView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DomAdvEventBossView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(key)
end

function DomAdvEventBossView:_onClickBtnSkill()
	local raceId = self._raceId
	local skinId = self._skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DomAdvEventBossView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DomAdvEventBossView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.DomAdvRankTabFrameView, self._activityId, 2)
end

function DomAdvEventBossView:_onClickBtnPort()
	UIStateManager.instance:push(ViewName.PassportDomAdvView, self._activityId)
end

function DomAdvEventBossView:_onClickBtnClg(mode)
	local result, tips = self._scene:getTryStartEventBossResultAndTips(self._blockId, mode)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DomainAdventureController.instance:enterBattleWithBoss(self._activityId, self._blockId, mode)
end

return DomAdvEventBossView
