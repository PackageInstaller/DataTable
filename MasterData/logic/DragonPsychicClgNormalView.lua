-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalView.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalView", package.seeall)

local DragonPsychicClgNormalView = class("DragonPsychicClgNormalView", ViewComponent)

function DragonPsychicClgNormalView:buildUI()
	DragonPsychicClgNormalView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._redPointBtnShop = goutil.findChild(self.mainGO, "btnShop/redPoint")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._tabScrollList:extendCircleWithOffset(80, "btn")

	self._btnClg = goutil.findChild(self.mainGO, "ruleCol/btnClg")
	self._txtStage = goutil.findChildTextComponent(self.mainGO, "ruleCol/stage/txt")
	self._petScrView = goutil.findChild(self.mainGO, "ruleCol/petCol/scrView")
	self._petScrCell = goutil.findChild(self.mainGO, "ruleCol/petCol/scrCell")
	self._imgEmptyPet = goutil.findChild(self.mainGO, "ruleCol/petCol/imgEmpty")
	self._prizeScrView = goutil.findChild(self.mainGO, "ruleCol/prizeCol/scrView")
	self._prizeScrCell = goutil.findChild(self.mainGO, "ruleCol/prizeCol/scrCell")
	self._imgEmptyPrize = goutil.findChild(self.mainGO, "ruleCol/prizeCol/imgEmpty")
	self._petScrollerList = ScrollerList.create(self._petScrView, self._petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._prizeScrollerList = ScrollerList.create(self._prizeScrView, self._prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function DragonPsychicClgNormalView:bindEvents()
	DragonPsychicClgNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
end

function DragonPsychicClgNormalView:unbindEvents()
	DragonPsychicClgNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnShop)
end

function DragonPsychicClgNormalView:onEnter()
	DragonPsychicClgNormalView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = DragonPsychicClgController.instance:getActivityType()

	local isInTime = DragonPsychicClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = DragonPsychicClgConfig.instance:getDpcData(self._activityId)

	self.addGEvent(self, GlobalNotify.handlePM_DPClgGetUniversalInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgHatchRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgDecHatchTimeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgGainHatchPetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_DPClgSelectPetRes, self._onUpdate, self)
	DragonPsychicClgController.instance:sendPM_DPClgGetUniversalInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redPointBtnShop, RedPointModel.ID_DRAGONPSYCHICCLG_EGG)
end

function DragonPsychicClgNormalView:onExit()
	DragonPsychicClgNormalView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointBtnShop)
	self:_onClear()
end

function DragonPsychicClgNormalView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function DragonPsychicClgNormalView:_onClear()
	self:_onClearTabColUI()
	self:_onClearRuleColUI()
end

function DragonPsychicClgNormalView:_onUpdateData()
	self._tabInfoList = {}

	local cfg = DragonPsychicClgConfig.instance:getDpcUniversalStageCfg(self._activityId)

	for idx, data in ipairs(cfg or {}) do
		local info = {}

		info.data = data
		info.stageId = data.stageId

		table.insert(self._tabInfoList, info)
	end

	local curStageId = DragonPsychicClgController.instance:getCurStageIdOfNor(self._activityId)

	self._curTabIdx = Mathf.Clamp(curStageId + 1, 0, #self._tabInfoList)
end

function DragonPsychicClgNormalView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRuleColUI()
end

function DragonPsychicClgNormalView:_getCurStageId()
	local info = self:_getCurTabInfo()

	return (info or nil) and (info.stageId or 0)
end

function DragonPsychicClgNormalView:_getCurData()
	local info = self:_getCurTabInfo()

	return info and info.data
end

function DragonPsychicClgNormalView:_getCurTabInfo()
	return self._tabInfoList[self._curTabIdx]
end

function DragonPsychicClgNormalView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)

	if #self._tabInfoList > 0 then
		local index = self._curTabIdx - 1

		self._tabScrollList:MoveCellToCenter(index, true)
	end
end

function DragonPsychicClgNormalView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function DragonPsychicClgNormalView:_updateTabCell(view, cell, info, tag)
	local tabIdx = cell.index + 1
	local data = info.data
	local stageId = info.stageId
	local isSelected = self._curTabIdx == tabIdx
	local result, _ = DragonPsychicClgController.instance:getTryStartDpcNormalClgResultAndTips(self._activityId, stageId)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
	local redPoint = goutil.findChild(mainGo, "btn/redPoint")
	local imgPass = goutil.findChild(mainGo, "btn/imgPass")
	local lock = goutil.findChild(mainGo, "btn/lock")
	local lock_txtPass = goutil.findChildTextComponent(mainGo, "btn/lock/txtPass")

	GameUtil.SetActive(imgPass, false)
	GameUtil.SetActive(imgSelected, false)
	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)

	txtName.text = data.name

	GameUtil.SetActive(imgPass, result == GameEnum.ResultCode.IsPass)
	GameUtil.SetActive(lock, result == GameEnum.ResultCode.NotPassLast)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._clickTabCell, self, tabIdx))
end

function DragonPsychicClgNormalView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")

	GameUtil.rmClickHandler(btn)
end

function DragonPsychicClgNormalView:_clickTabCell(tabIdx)
	local info = self._tabInfoList[tabIdx]
	local stageId = info.stageId
	local result, tips = DragonPsychicClgController.instance:getTryStartDpcNormalClgResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)
end

function DragonPsychicClgNormalView:_onUpdateRuleColUI()
	local stageId = self:_getCurStageId()

	if stageId <= 0 then
		self._txtStage.text = "第？关"

		GameUtil.SetActive(self._imgEmptyPet, true)
		GameUtil.SetActive(self._imgEmptyPrize, true)
		self:_onClearRuleColUI()

		return
	end

	local data = self:_getCurData()
	local creepsMasterId = data.creepsMasterId

	self._txtStage.text = data.name

	local creepsCfg = DragonPsychicClgConfig.instance:getDpcCreepsCfg(creepsMasterId) or {}

	self._petScrollerList:reloadData(creepsCfg)
	GameUtil.SetActive(self._imgEmptyPet, #creepsCfg <= 0)

	local prizeList = data.prize and string.split(data.prize, "#") or {}

	self._prizeScrollerList:reloadData(prizeList)
	GameUtil.SetActive(self._imgEmptyPrize, #prizeList <= 0)
end

function DragonPsychicClgNormalView:_onClearRuleColUI()
	self._petScrollerList:dispose()
	self._prizeScrollerList:dispose()
end

function DragonPsychicClgNormalView:_updatePetCell(view, cell, data, tag)
	local raceId = data.raceId
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setIcon(item, MatType.Pet, raceId, nil, nil)

	local function callBack()
		local level = data.lv
		local awakenLv = data.awakenLv
		local skinId = data.faceId
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function DragonPsychicClgNormalView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(mainGo)
end

function DragonPsychicClgNormalView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function DragonPsychicClgNormalView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function DragonPsychicClgNormalView:_onClickBtnClg()
	local stageId = self:_getCurStageId()
	local result, tips = DragonPsychicClgController.instance:getTryStartDpcNormalClgResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result == GameEnum.ResultCode.NotEnoughNum then
		UIStateManager.instance:push(ViewName.DragonPsychicClgNormalInitialShopView, self._activityId)
	elseif result == GameEnum.ResultCode.Success then
		DragonPsychicClgController.instance:enterBattle(self._activityId, stageId)
	end
end

function DragonPsychicClgNormalView:_onClickBtnShop()
	local isNeedSelect = DragonPsychicClgController.instance:isNeedSelectInitialPets(self._activityId)

	if isNeedSelect then
		UIStateManager.instance:push(ViewName.DragonPsychicClgNormalInitialShopView, self._activityId)
	else
		UIStateManager.instance:push(ViewName.DragonPsychicClgNormalEggView, self._activityId)
	end
end

function DragonPsychicClgNormalView:_onClickBtnTip()
	local key = DragonPsychicClgConfig.instance:getCommonValue(self._activityId, "ruleKeyNor")

	TipsFacade.instance:openRulesView(key)
end

return DragonPsychicClgNormalView
