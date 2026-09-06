-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityHelpView.lua

module("logic.extensions.guardcity.view.GuardCityHelpView", package.seeall)

local GuardCityHelpView = class("GuardCityHelpView", ViewComponent)

GuardCityHelpView.ChallengeMode_None = 0
GuardCityHelpView.ChallengeMode_Nomal = 1
GuardCityHelpView.ChallengeMode_Powerful = 2

function GuardCityHelpView:ctor()
	GuardCityHelpView.super.ctor(self)
end

function GuardCityHelpView:buildUI()
	GuardCityHelpView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnTip")
	self._btnList = self:getBtn("scoreReward/btnList")
	self._helpInfoViewsGo = self:getGo("tabScrollview")
	self._helpInfoGo = self:getGo("tabcell")
	self._rewardViewsGo = self:getGo("scoreReward/tableview")
	self._rewardGo = self:getGo("scoreReward/item")
	self._winRewardViewsGo = self:getGo("winReward/tableview")
	self._winRewardItemGo = self:getGo("winReward/item")
	self._emptyGo = self:getGo("emptyGo")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnNomal = self:getBtn("btnNomal")
	self._btnPowerful = self:getBtn("btnPowerful")
	self._uiChangeNomalMode = goutil.findChildComponent(self.mainGO, "btnNomal/select", "UIImageSpriteChange")
	self._uiChangePowerfulMode = goutil.findChildComponent(self.mainGO, "btnPowerful/select", "UIImageSpriteChange")
	self._txtTili = self:getTxt("btnChallenge/limit/txtCost")
	self._txtWinCondition = self:getTxt("txtWinCondition")
	self._enemyList = {}

	for i = 1, 9 do
		local enemyCon = {
			go = self:getGo("teamEnemy/cell_" .. i),
			icon = self:getGo("teamEnemy/cell_" .. i .. "/icon")
		}

		table.insert(self._enemyList, enemyCon)
	end

	self._fmtList = {}

	for i = 1, 9 do
		local fmtCon = {
			seat = self:getGo("FmtRight/Nego_Seats/Item_Seat_" .. i),
			layerBg = self:getGo("FmtRight/layerBg/item" .. i .. "/ImgC_Forbid"),
			layerRole = self:getGo("FmtRight/layerRole/item" .. i .. "Nego_Character"),
			layerUI = self:getGo("FmtRight/layerUI/item" .. i),
			txtLevel = self:getTxt("FmtRight/layerUI/item" .. i .. "/txtLv"),
			type = goutil.findChildComponent(self.mainGO, "FmtRight/layerUI/item" .. i .. "/ImgC_Info", "UIImageSpriteChange")
		}

		table.insert(self._fmtList, fmtCon)
	end

	self._txtCost = self:getTxt("goldBarCon/costTabCell/TxtC_Num")
	self._btnAddCost = GameUtil.asBtn(self:getGo("goldBarCon/costTabCell/Btn_Add"))
	self._txtCostTip = self:getTxt("goldBarCon/costTip/txtTip")
	self._btnShowCostTip = GameUtil.asBtn(self:getGo("goldBarCon/costTabCell/showTipRaycast"))
	self._costTip = self:getGo("goldBarCon/costTip")
	self._customInput = UICustomInput.Get(self._costTip)
	self._goldBarCon = self:getGo("scoreBarCon")
	self._titleGo = self:getGo("conditionTitle")
	self._scrollRewardGo = self:getGo("scoreReward")
	self._winRewardGo = self:getGo("winReward")
	self._costTitleGo = self:getGo("btnChallenge/limit")
end

function GuardCityHelpView:bindEvents()
	GuardCityHelpView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNomal, self._onClickNomal, self)
	GameUtil.addClickHandler(self._btnPowerful, self._onClickPowerful, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnAddCost, self._onClickAddCost, self)
	GameUtil.addClickHandler(self._btnShowCostTip, self._onClickShowCostTip, self)
	GameUtil.addClickHandler(self._btnList, self._onClickList, self)
	self._customInput:AddListener(self._onCustomInputCostTip, self)
end

function GuardCityHelpView:unbindEvents()
	GuardCityHelpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNomal)
	GameUtil.rmClickHandler(self._btnPowerful)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnAddCost)
	GameUtil.rmClickHandler(self._btnShowCostTip)
	GameUtil.rmClickHandler(self._btnList)
	self._customInput:RemoveListener()
end

function GuardCityHelpView:onEnter()
	GuardCityHelpView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityViewSeekHelpRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGetInfoRes, self._refreshCostView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityBuyStrengthRes, self._PM_GuardCityBuyStrengthRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityMasterDeadByOther, self._onMasterDeadByOther, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityCostChange, self._onCostChange, self)

	self._helpScrollList = ScrollerList.create(self._helpInfoViewsGo, self._helpInfoGo, GameUtil.handler(self._updateHelpInfoCell, self), GameUtil.handler(self._clearHelpInfoCell, self))
	self._rewardScrollList = ScrollerList.create(self._rewardViewsGo, self._rewardGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._winRewardScrollList = ScrollerList.create(self._winRewardViewsGo, self._winRewardItemGo, GameUtil.handler(self._updateWinRewardCell, self), GameUtil.handler(self._clearWinRewardCell, self))

	local params = self:getOpenParam()

	self._isFromFriend = true
	self._needShowMasterUniqueId = nil
	self._needShowFriendId = nil

	if params then
		self._isFromFriend = params[1]
		self._needShowFriendId = params[2]
		self._needShowMasterUniqueId = params[3]
	end

	self._activityId = GuardCiytModel.instance:getCurActId()

	if self._activityId == nil then
		FloatWordMgr.instance:show(lang("不在活动时间内"))
		self:close()

		return
	end

	self._actCfg = GuardCityConfig.instance:getActivityCfg(self._activityId)
	self._curSelectTab = 1

	self:_setTopGoldBar()

	self._timeClockTxt = self._timeClockTxt or {}

	self:_onTimeClock()
	settimer(1, self._onTimeClock, self, true)
	GameUtil.SetActive(self._costTip, false)
	GuardCityAgent.instance:sendPM_GuardCityViewSeekHelpReq(self._activityId)
	GuardCityAgent.instance:sendPM_GuardCityGetInfoReq(self._activityId)
	GuardCityController.instance:onEndBattleAnim()
end

function GuardCityHelpView:onExit()
	GuardCityHelpView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityViewSeekHelpRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGetInfoRes, self._refreshCostView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityBuyStrengthRes, self._PM_GuardCityBuyStrengthRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityMasterDeadByOther, self._onMasterDeadByOther, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityCostChange, self._onCostChange, self)
	self._helpScrollList:dispose()
	self._rewardScrollList:dispose()
	self._winRewardScrollList:dispose()

	self._timeClockTxt = self._timeClockTxt or {}

	removetimer(self._onTimeClock, self)
end

function GuardCityHelpView:_refreshView()
	self._curHelpData = {}

	for i, v in ipairs(GuardCiytModel.instance:getHelpInfo()) do
		if self._needShowFriendId and checknumber(self._needShowFriendId) == checknumber(v.playerId) and self._needShowMasterUniqueId and checknumber(self._needShowMasterUniqueId) == checknumber(v.masterInfo.masterUniqueId) then
			self._curSelectTab = i
			self._needShowFriendId = nil
			self._needShowMasterUniqueId = nil
		end

		table.insert(self._curHelpData, {
			info = v,
			index = i
		})
	end

	if self._isFromFriend == true then
		if self._needShowFriendId or self._needShowMasterUniqueId then
			FloatWordMgr.instance:show(lang("怪物已消失"))
		end

		self._isFromFriend = false
		self._needShowFriendId = nil
		self._needShowMasterUniqueId = nil
	end

	if self._curSelectTab > #self._curHelpData then
		self._curSelectTab = 1
	end

	self._helpScrollList:reloadData(self._curHelpData)

	if #self._curHelpData > 0 then
		self._helpScrollList:MoveCellToBegin(self._curSelectTab - 1, false)
		GameUtil.SetActive(self._emptyGo, false)
		GameUtil.SetActive(self._titleGo, true)
		GameUtil.SetActive(self._scrollRewardGo, true)
		GameUtil.SetActive(self._winRewardGo, true)
		GameUtil.SetActive(self._costTitleGo, true)
		self:_refreshRight(self._curHelpData[self._curSelectTab].info.masterInfo)
	else
		self:_refreshRight()
		GameUtil.SetActive(self._emptyGo, true)
		GameUtil.SetActive(self._titleGo, false)
		GameUtil.SetActive(self._scrollRewardGo, false)
		GameUtil.SetActive(self._winRewardGo, false)
		GameUtil.SetActive(self._costTitleGo, false)
	end

	self:_onClockCost()
	removetimer(self._onClockCost, self)
	settimer(1, self._onClockCost, self, true)
end

function GuardCityHelpView:_refreshCostView()
	self._txtCost.text = langPara("%d/%d", GuardCiytModel.instance:getCurStrength(), GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true))
end

function GuardCityHelpView:_refreshRight(masterInfo)
	self._masterInfo = masterInfo

	GameUtil.SetActive(self._rewardViewsGo, false)
	GameUtil.SetActive(self._winRewardViewsGo, false)

	for i, v in ipairs(self._enemyList) do
		MaterialMgr.resetAll(self._enemyList[i].icon)
	end

	self._challengeMode = GuardCityHelpView.ChallengeMode_None

	self:_refreshBtn()

	self._txtWinCondition.text = ""

	if not self._masterInfo then
		return
	end

	GameUtil.SetActive(self._rewardViewsGo, true)
	GameUtil.SetActive(self._winRewardViewsGo, true)

	local creeps = GuardCityConfig.instance:getCreepsCfg(self._masterInfo.creepsMasterId)

	for i, v in ipairs(creeps) do
		local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].icon)

		if proxy then
			proxy.binder:setAutoTips(false)

			if not self._masterInfo.enemyStage[v.creepsId] or self._masterInfo.enemyStage[v.creepsId] > 0 then
				proxy.binder:SetGray(false)
			else
				proxy.binder:SetGray(true)
			end
		end
	end

	local attrRes = {}

	for i, v in ipairs(creeps) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(v.extproperties) or {}

		attrRes = AttrMo.addSameAttrs(attrs, attrRes)
	end

	local bossMaxHp = checknumber(attrRes[FightingPowerFormula.instance:getAttrTypeByName("生命")])
	local damagePrizeCfg

	for i, v in ipairs(GuardCityConfig.instance:getDamagePrizeCfgs(self._actCfg.damagePrizePlanId)) do
		if bossMaxHp > v.damage then
			damagePrizeCfg = v
		end
	end

	if damagePrizeCfg then
		damagePrizeList = string.split(damagePrizeCfg.prize, "#")

		self._rewardScrollList:reloadData(damagePrizeList)
	end

	local masterCfg = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, self._masterInfo.creepsMasterId)
	local starCfg = GuardCityConfig.instance:getStarCfg(self._actCfg.starPlanId, masterCfg.star)

	if starCfg then
		winPrizeList = string.split(starCfg.defeatPrize, "#")

		self._winRewardScrollList:reloadData(winPrizeList)
	end

	self._txtWinCondition.text = masterCfg.ruleDesc
	self._challengeMode = GuardCityHelpView.ChallengeMode_Nomal

	self:_refreshBtn()
end

function GuardCityHelpView:_updateHelpInfoCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
	local select = goutil.findChild(go, "select")
	local txtPlayerName = goutil.findChildTextComponent(go, "txtPlayerName")
	local txtEnemy = goutil.findChildTextComponent(go, "txtEnemy")
	local battleDoneGo = goutil.findChild(go, "battleDone")
	local petCon = goutil.findChild(go, "pet/con")
	local txtPetStar = goutil.findChildTextComponent(go, "pet/star/txtStar")
	local txtHp = goutil.findChildTextComponent(go, "txtHp/txtNum")
	local txtTime = goutil.findChildTextComponent(go, "txtTime/txtNum")
	local monsterCfg = GuardCityConfig.instance:getMonsterCfg(self._actCfg.masterPlanId, data.info.masterInfo.creepsMasterId)
	local creepsCfg = GuardCityConfig.instance:getCreepsCfg(data.info.masterInfo.creepsMasterId)

	uGuiUtil.setSpriteToImage(petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(monsterCfg.headIcon))

	txtPetStar.text = monsterCfg.star
	txtEnemy.text = langPara("%s发现者", monsterCfg.name)

	local bossMaxHp = 0
	local bossCurHp = 0

	for i, v in pairs(creepsCfg) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(v.extproperties) or {}
		local monsterHp = checknumber(attrs[FightingPowerFormula.instance:getAttrTypeByName("生命")])

		bossMaxHp = bossMaxHp + monsterHp
		bossCurHp = not data.info.masterInfo.enemyStage[v.creepsId] and bossCurHp + monsterHp or bossCurHp + data.info.masterInfo.enemyStage[v.creepsId] * 0.0001 * monsterHp
	end

	txtHp.text = langPara("%d%%", math.ceil(bossCurHp / bossMaxHp * 100))

	if self._curSelectTab == data.index then
		GameUtil.SetActive(select, true)
	else
		GameUtil.SetActive(select, false)
	end

	GameUtil.SetActive(battleDoneGo, data.info.challenge)

	txtPlayerName.text = data.info.playName

	self:_registerTimeClock(txtTime, data.info.time / 1000)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickTab(data.index)
	end)
end

function GuardCityHelpView:_clearHelpInfoCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
	local txtTime = goutil.findChildTextComponent(go, "txtTime/txtNum")
	local petCon = goutil.findChild(go, "pet/con")

	uGuiUtil.clearImage(petCon)
	btn:RemoveClickListener()
	self:_unRegisterTimeClock(txtTime)
end

function GuardCityHelpView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GuardCityHelpView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GuardCityHelpView:_updateWinRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GuardCityHelpView:_clearWinRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GuardCityHelpView:_refreshBtn()
	local cost = GuardCityConfig.instance:getCommonValue("CHALLENGE_STRENGTH_COST", true)

	if self._challengeMode == GuardCityChallengeView.ChallengeMode_Nomal then
		self._uiChangeNomalMode:SetState(1)
	else
		self._uiChangeNomalMode:SetState(0)
	end

	if self._challengeMode == GuardCityChallengeView.ChallengeMode_Powerful then
		cost = cost * GuardCityConfig.instance:getCommonValue("STRONG_CHALLENGE_COST_MULTIPLE", true)

		self._uiChangePowerfulMode:SetState(1)
	else
		self._uiChangePowerfulMode:SetState(0)
	end

	self._txtTili.text = cost

	if self._challengeMode == GuardCityHelpView.ChallengeMode_None then
		GameUtil.SetActive(self._txtTili, false)
	else
		GameUtil.SetActive(self._txtTili, true)
	end
end

function GuardCityHelpView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, GuardCityConfig.instance:getCommonValue("HELP_RULE_KEY", false))
end

function GuardCityHelpView:_onClickNomal()
	self._challengeMode = GuardCityHelpView.ChallengeMode_Nomal

	self:_refreshBtn()
end

function GuardCityHelpView:_onClickPowerful()
	self._challengeMode = GuardCityHelpView.ChallengeMode_Powerful

	self:_refreshBtn()
end

function GuardCityHelpView:_onClickChallenge()
	if #self._curHelpData <= 0 then
		return
	end

	local isPowerful = self._challengeMode == GuardCityChallengeView.ChallengeMode_Powerful
	local cost = GuardCityConfig.instance:getCommonValue("CHALLENGE_STRENGTH_COST", true)

	if isPowerful == true then
		cost = cost * GuardCityConfig.instance:getCommonValue("STRONG_CHALLENGE_COST_MULTIPLE", true)
	end

	local curInfo = self._curHelpData[self._curSelectTab].info

	if cost <= GuardCiytModel.instance:getCurStrength() then
		local fmtMo = GuardCiytModel.instance:getFmtMo()

		fmtMo:initParams(self._activityId, curInfo.masterInfo, isPowerful, curInfo.playerId)
		CustomFmtController.instance:showMissionView(fmtMo)
	else
		FloatWordMgr.instance:show(lang("疲劳不足"))
	end
end

function GuardCityHelpView:_onClickTab(index)
	self._curSelectTab = index

	self:_refreshView()
end

function GuardCityHelpView:_registerTimeClock(txt, tagTime)
	self._timeClockTxt = self._timeClockTxt or {}
	self._timeClockTxt[txt] = {
		textCmp = txt,
		time = tagTime
	}
end

function GuardCityHelpView:_unRegisterTimeClock(txt)
	self._timeClockTxt = self._timeClockTxt or {}
	self._timeClockTxt[txt] = nil
end

function GuardCityHelpView:_onTimeClock()
	local haveEnd = false

	for i, v in pairs(self._timeClockTxt) do
		if v.time - ServerTime.now() > 0 then
			v.textCmp.text = GameUtil.FormatTimeSymbol(v.time - ServerTime.now())
		else
			haveEnd = true
			v.textCmp.text = "00:00:00"

			break
		end
	end

	if haveEnd == true then
		GuardCityAgent.instance:sendPM_GuardCityViewSeekHelpReq(self._activityId)
	end
end

function GuardCityHelpView:_onClickAddCost()
	local times = GuardCiytModel.instance:getBuyStrengthTimesToday() + 1
	local buyCfgs = GuardCityConfig.instance:getBuyStrengthPlans(self._actCfg.strengthPurchasePlanId)

	if times > #buyCfgs then
		times = #buyCfgs
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(buyCfgs[times].cost)
	local privilege = MaterialModel.instance:IsEnough(MatType.ACTIVITY_ITEM, self._actCfg.privilegeMaterialId, 1)
	local privilegeTimes = GuardCityConfig.instance:getCommonValue("PRIVILEGE_FREE_TIMES", true)
	local usePrivilegeTimes = GuardCiytModel.instance:getPrivilegeBuyTimesToday()

	if privilege == true and usePrivilegeTimes < privilegeTimes then
		local content = langPara("每日前%d次恢复疲劳无需消耗\n（今日剩余次数：%d）", privilegeTimes, privilegeTimes - usePrivilegeTimes)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			GuardCityAgent.instance:sendPM_GuardCityBuyStrengthReq(self._activityId)
		end)

		return
	end

	local content = langPara("花费%d%s购买%d疲劳", matNum, MaterialMgr.getMaterialsName(matType, matId), GuardCityConfig.instance:getCommonValue("STRENGTH_PURCHASE_RECOVERY", false))

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		if GuardCiytModel.instance:getBuyStrengthTimesToday() >= #buyCfgs then
			FloatWordMgr.instance:show(lang("无剩余次数"))
		elseif MaterialModel.instance:IsEnough(matType, matId, matNum) == false then
			FloatWordMgr.instance:show(lang("所需材料不足"))
		else
			GuardCityAgent.instance:sendPM_GuardCityBuyStrengthReq(self._activityId)
		end
	end)
end

function GuardCityHelpView:_onClickShowCostTip()
	GameUtil.SetActive(self._costTip, true)
end

function GuardCityHelpView:_onCustomInputCostTip(hover)
	if not hover then
		GameUtil.SetActive(self._costTip, false)
	end
end

function GuardCityHelpView:_onClickList()
	UIStateManager.instance:push(ViewName.GuardCityChallengeRewardView, self._actCfg.damagePrizePlanId)
end

function GuardCityHelpView:_onClockCost()
	if GuardCiytModel.instance:getCurStrength() >= GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true) then
		if self._txtCostTip then
			self._txtCostTip.text = langPara("每<color=#FFD87CFF>%dmin</color>恢复<color=#FFD87CFF>1</color>点\n疲劳已经达到上限", checkint(GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) / 60))
		end
	else
		local lack = GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true) - GuardCiytModel.instance:getCurStrength()
		local needSec = lack * GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true)
		local targetTime = GuardCiytModel.instance:getStrengthStamp() + needSec - ServerTime.now()
		local nextTime = GuardCiytModel.instance:getStrengthStamp() + GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) - ServerTime.now()

		if nextTime <= 0 then
			GuardCityController.instance:onCostAutoChange()

			nextTime = GuardCiytModel.instance:getStrengthStamp() + GuardCityConfig.instance:getCommonValue("STRENGTH_RECOVERY_EFFICIENCY", true) - ServerTime.now()
		end

		local totalDate = GameUtil.FormatTimeWords(targetTime)
		local nextDate = GameUtil.FormatTimeWords(nextTime, isNotHour)

		if self._txtCostTip then
			self._txtCostTip.text = langPara("下次恢复疲劳:%s\n完全恢复疲劳:%s", nextDate, totalDate)
		end
	end
end

function GuardCityHelpView:_onMasterDeadByOther()
	GuardCityAgent.instance:sendPM_GuardCityViewSeekHelpReq(self._activityId)
end

function GuardCityHelpView:_onCostChange()
	if self._txtCost then
		self._txtCost.text = langPara("%d/%d", GuardCiytModel.instance:getCurStrength(), GuardCityConfig.instance:getCommonValue("STRENGTH_LIMIT", true))
	end
end

function GuardCityHelpView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = self._actCfg.scoreMaterials
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function GuardCityHelpView:_PM_GuardCityBuyStrengthRes()
	GuardCityAgent.instance:sendPM_GuardCityGetInfoReq(self._activityId)
end

return GuardCityHelpView
