-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilHelpView.lua

module("logic.extensions.destroyevil.view.DestroyEvilHelpView", package.seeall)

local DestroyEvilHelpView = class("DestroyEvilHelpView", ViewComponent)

DestroyEvilHelpView.ChallengeMode_None = 0
DestroyEvilHelpView.ChallengeMode_Nomal = 1
DestroyEvilHelpView.ChallengeMode_Powerful = 2

function DestroyEvilHelpView:buildUI()
	DestroyEvilHelpView.super.buildUI(self)

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
	self._btnHelp = self:getBtn("listBg/btnHelp")
	self._btnRec = self:getBtn("listBg/btnRec")
	self._helpBtnSpriteChange = self._btnHelp.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._recBtnSpriteChange = self._btnRec.gameObject:GetComponent(ComponentType.UIChangeGroup)
	self._btnReset = self:getBtn("btnReset")
end

function DestroyEvilHelpView:bindEvents()
	DestroyEvilHelpView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnNomal, self._onClickNomal, self)
	GameUtil.addClickHandler(self._btnPowerful, self._onClickPowerful, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnAddCost, self._onClickAddCost, self)
	GameUtil.addClickHandler(self._btnShowCostTip, self._onClickShowCostTip, self)
	GameUtil.addClickHandler(self._btnList, self._onClickList, self)
	self._customInput:AddListener(self._onCustomInputCostTip, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnRec, self._onClickRec, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function DestroyEvilHelpView:unbindEvents()
	DestroyEvilHelpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnNomal)
	GameUtil.rmClickHandler(self._btnPowerful)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnAddCost)
	GameUtil.rmClickHandler(self._btnShowCostTip)
	GameUtil.rmClickHandler(self._btnList)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnRec)
	GameUtil.rmClickHandler(self._btnReset)
end

function DestroyEvilHelpView:onEnter()
	DestroyEvilHelpView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilBuyStrengthRes, self._onBuyStrengthRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilMasterDeadByOther, self._onMasterDeadByOther, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilCostChange, self._onCostChange, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilGetRecommendListRes, self._onGetRecommendListRes, self)

	self._helpScrollList = ScrollerList.create(self._helpInfoViewsGo, self._helpInfoGo, GameUtil.handler(self._updateHelpInfoCell, self), GameUtil.handler(self._clearHelpInfoCell, self))
	self._rewardScrollList = ScrollerList.create(self._rewardViewsGo, self._rewardGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._winRewardScrollList = ScrollerList.create(self._winRewardViewsGo, self._winRewardItemGo, GameUtil.handler(self._updateWinRewardCell, self), GameUtil.handler(self._clearWinRewardCell, self))

	local params = self:getOpenParam()

	self._isFromFriend = true
	self._needShowMasterUniqueId = nil
	self._needShowFriendId = nil
	self._isRecommend = DestroyEvilModel.instance.lastIsRecommend

	if params then
		self._isFromFriend = params[1]
		self._needShowFriendId = params[2]
		self._needShowMasterUniqueId = params[3]
	end

	self._activityId = DestroyEvilModel.instance:getActivityId()

	if self._activityId == nil then
		FloatWordMgr.instance:show(lang("不在活动时间内"))
		self:close()

		return
	end

	self._actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)
	self._curSelectTab = 1

	self:_setTopGoldBar()

	self._timeClockTxt = self._timeClockTxt or {}

	self:_onTimeClock()
	settimer(1, self._onTimeClock, self, true)
	GameUtil.SetActive(self._costTip, false)

	if self._isRecommend then
		self:_onClickRec()
	else
		self:_onClickHelp()
	end

	DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)
	DestroyEvilAgent.instance:sendPM_DestroyEvilGetRecommendListReq(self._activityId)
end

function DestroyEvilHelpView:onExit()
	DestroyEvilHelpView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilBuyStrengthRes, self._onBuyStrengthRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilMasterDeadByOther, self._onMasterDeadByOther, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilCostChange, self._onCostChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilGetRecommendListRes, self._onGetRecommendListRes, self)
	self._helpScrollList:dispose()
	self._rewardScrollList:dispose()
	self._winRewardScrollList:dispose()

	self._timeClockTxt = self._timeClockTxt or {}

	removetimer(self._onTimeClock, self)
	removetimer(self._onClockCost, self)

	DestroyEvilModel.instance.lastIsRecommend = self._isRecommend
end

function DestroyEvilHelpView:_refreshView()
	self._curHelpData = {}

	if self._isRecommend then
		local var_6_0 = DestroyEvilModel.instance:getRecommendList()

		if not var_6_0 then
			var_6_0 = DestroyEvilModel.instance:getHelpInfo()

			local helpInfo = var_6_0

			for i, v in ipairs(helpInfo) do
				if not self._isRecommend and self._needShowFriendId and checknumber(self._needShowFriendId) == checknumber(v.monster.headInfo.userId) and self._needShowMasterUniqueId and checknumber(self._needShowMasterUniqueId) == checknumber(v.monster.masterUniqueId) then
					self._curSelectTab = i
					self._needShowFriendId = nil
					self._needShowMasterUniqueId = nil
				end

				local cell = self._isRecommend and {
					info = v,
					index = i
				} or {
					info = v.monster,
					index = i,
					deadLine = v.deadLine
				}

				table.insert(self._curHelpData, cell)
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

			ArraySort.sortOn(self._curHelpData, {
				function(a)
					local monsterCfg = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, a.info.monsterId)
					local masterCfg = DestroyEvilConfig.instance:getMaster(monsterCfg.creepsMasterId)

					return monsterCfg.star
				end,
				function(a)
					local monsterCfg = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, a.info.monsterId)
					local masterCfg = DestroyEvilConfig.instance:getMaster(monsterCfg.creepsMasterId)

					return monsterCfg.level
				end,
				function(a)
					return checknumber(a.info.monsterLeftHp)
				end,
				"index"
			}, {
				ArraySort.DESCENDING,
				ArraySort.DESCENDING,
				ArraySort.DESCENDING,
				ArraySort.NUMERIC
			})
			self._helpScrollList:reloadData(self._curHelpData)

			if #self._curHelpData > 0 then
				self._helpScrollList:MoveCellToBegin(self._curSelectTab - 1, false)
				GameUtil.SetActive(self._emptyGo, false)
				self:_refreshRight(self._curHelpData[self._curSelectTab].info.monsterId)

				if self._challengeMode == DestroyEvilHelpView.ChallengeMode_Nomal then
					GameUtil.SetActive(self._titleGo, true)
					GameUtil.SetActive(self._scrollRewardGo, true)
					GameUtil.SetActive(self._winRewardGo, true)
					GameUtil.SetActive(self._txtWinCondition, true)
				else
					GameUtil.SetActive(self._titleGo, false)
					GameUtil.SetActive(self._scrollRewardGo, false)
					GameUtil.SetActive(self._winRewardGo, false)
					GameUtil.SetActive(self._txtWinCondition, false)
				end

				GameUtil.SetActive(self._costTitleGo, self._challengeMode ~= DestroyEvilHelpView.ChallengeMode_None)
			else
				self:_refreshRight()
				GameUtil.SetActive(self._emptyGo, true)
				GameUtil.SetActive(self._titleGo, false)
				GameUtil.SetActive(self._scrollRewardGo, false)
				GameUtil.SetActive(self._winRewardGo, false)
				GameUtil.SetActive(self._costTitleGo, false)
				GameUtil.SetActive(self._txtWinCondition, false)
			end

			self:_onClockCost()
			removetimer(self._onClockCost, self)
			settimer(1, self._onClockCost, self, true)
			self:_refreshCostView()
		end
	end
end

function DestroyEvilHelpView:_refreshRewardShow()
	if #self._curHelpData > 0 then
		GameUtil.SetActive(self._emptyGo, false)

		if self._challengeMode == DestroyEvilHelpView.ChallengeMode_Nomal then
			GameUtil.SetActive(self._titleGo, true)
			GameUtil.SetActive(self._scrollRewardGo, true)
			GameUtil.SetActive(self._winRewardGo, true)
			GameUtil.SetActive(self._txtWinCondition, true)
		else
			GameUtil.SetActive(self._titleGo, false)
			GameUtil.SetActive(self._scrollRewardGo, false)
			GameUtil.SetActive(self._winRewardGo, false)
			GameUtil.SetActive(self._txtWinCondition, false)
		end

		GameUtil.SetActive(self._costTitleGo, self._challengeMode ~= DestroyEvilHelpView.ChallengeMode_None)
	else
		GameUtil.SetActive(self._emptyGo, true)
		GameUtil.SetActive(self._titleGo, false)
		GameUtil.SetActive(self._scrollRewardGo, false)
		GameUtil.SetActive(self._winRewardGo, false)
		GameUtil.SetActive(self._costTitleGo, false)
		GameUtil.SetActive(self._txtWinCondition, false)
	end
end

function DestroyEvilHelpView:_refreshCostView()
	self._txtCost.text = langPara("%d/%d", DestroyEvilModel.instance:getCurStrength(), self._actCfg.strengthLimit)
end

function DestroyEvilHelpView:_refreshRight(monsterId)
	GameUtil.SetActive(self._rewardViewsGo, false)
	GameUtil.SetActive(self._winRewardViewsGo, false)

	for i, v in ipairs(self._enemyList) do
		MaterialMgr.resetAll(self._enemyList[i].icon)
	end

	self._challengeMode = DestroyEvilHelpView.ChallengeMode_None

	self:_refreshBtn()

	self._txtWinCondition.text = ""

	if not monsterId then
		return
	end

	GameUtil.SetActive(self._rewardViewsGo, true)
	GameUtil.SetActive(self._winRewardViewsGo, true)

	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, monsterId)
	local creeps = DestroyEvilConfig.instance:getCreeps(cfgMonster.creepsMasterId)

	for i, v in ipairs(creeps) do
		local proxy = MaterialMgr.setCell(MatType.Pet, v.raceId, self._enemyList[v.posId].icon)

		if proxy then
			proxy.binder:setAutoTips(false)
		end
	end

	local attrRes = {}

	for i, v in ipairs(creeps) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(v.extproperties) or {}

		attrRes = AttrMo.addSameAttrs(attrs, attrRes)
	end

	local bossMaxHp = checknumber(attrRes[FightingPowerFormula.instance:getAttrTypeByName("生命")])
	local damagePrizeCfg = DestroyEvilConfig.instance:getScoreCfg(cfgMonster.scorePlanId)

	if damagePrizeCfg then
		local str = self._actCfg.itemKey .. ":" .. damagePrizeCfg.itemCount
		local damagePrizeList = {}

		table.insert(damagePrizeList, str)
		self._rewardScrollList:reloadData(damagePrizeList)
	end

	local str = self._actCfg.itemKey .. ":" .. cfgMonster.killAddItemCount
	local winPrizeList = {}

	table.insert(winPrizeList, str)
	self._winRewardScrollList:reloadData(winPrizeList)

	local cfgMaster = DestroyEvilConfig.instance:getMaster(cfgMonster.creepsMasterId)

	self._txtWinCondition.text = cfgMaster.ruleDesc
	self._challengeMode = DestroyEvilHelpView.ChallengeMode_Nomal

	self:_refreshBtn()
end

function DestroyEvilHelpView:_updateHelpInfoCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
	local select = goutil.findChild(go, "select")
	local txtPlayerName = goutil.findChildTextComponent(go, "txtPlayerName")
	local txtEnemy = goutil.findChildTextComponent(go, "txtEnemy")
	local battleDoneGo = goutil.findChild(go, "battleDone")
	local petCon = goutil.findChild(go, "pet/con")
	local txtPetStar = goutil.findChildTextComponent(go, "pet/star/txt")
	local txtHp = goutil.findChildTextComponent(go, "txtHp/txtNum")
	local txtTimeGo = goutil.findChild(go, "txtTime")
	local txtTime = goutil.findChildTextComponent(go, "txtTime/txtNum")
	local txtLv = goutil.findChildTextComponent(go, "pet/txtLv")
	local monsterCfg = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, data.info.monsterId)
	local masterCfg = DestroyEvilConfig.instance:getMaster(monsterCfg.creepsMasterId)

	txtPetStar.text = monsterCfg.star
	txtLv.text = "Lv." .. monsterCfg.level

	local value = Mathf.Clamp01(checknumber(data.info.monsterLeftHp) / checknumber(data.info.monsterTotalHp)) * 100

	if value > 0 and value <= 1 then
		value = 1
	end

	if value >= 30 then
		if not ColorConst.Green2 then
			local colorStr = ColorConst.Red

			txtHp.text = langPara("<color=#%s>%d%%</color>", colorStr, value)
			txtEnemy.text = langPara("%s发现者", masterCfg.name)

			if self._curSelectTab == data.index then
				GameUtil.SetActive(select, true)
			else
				GameUtil.SetActive(select, false)
			end

			GameUtil.SetActive(battleDoneGo, false)

			txtPlayerName.text = data.info.headInfo.userName

			if not self._isRecommend then
				goutil.setActive(txtTimeGo, true)
				self:_registerTimeClock(txtTime, data.deadLine / 1000)
			else
				self:_unRegisterTimeClock(txtTime)
				goutil.setActive(txtTimeGo, false)
			end

			btn:RemoveClickListener()
			btn:AddClickListener(function()
				self:_onClickTab(data.index)
			end)

			local cfgCreep = DestroyEvilController.instance:getFirstPetCfgByCreeps(self._activityId, data.info.monsterId)

			if cfgCreep then
				MaterialMgr.setIcon(petCon, MatType.PET_SKIN, cfgCreep.raceId)
			end
		end
	end
end

function DestroyEvilHelpView:_clearHelpInfoCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
	local txtTime = goutil.findChildTextComponent(go, "txtTime/txtNum")
	local petCon = goutil.findChild(go, "pet/con")

	uGuiUtil.clearImage(petCon)
	btn:RemoveClickListener()
	self:_unRegisterTimeClock(txtTime)
end

function DestroyEvilHelpView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DestroyEvilHelpView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DestroyEvilHelpView:_updateWinRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DestroyEvilHelpView:_clearWinRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DestroyEvilHelpView:_refreshBtn()
	local cost = langPara("剩余：0次")

	if self._challengeMode == DestroyEvilHelpView.ChallengeMode_Nomal then
		cost = langPara("剩余：%d次", DestroyEvilController.instance:getLeftTodayHelpTimes(self._activityId))

		self._uiChangeNomalMode:SetState(1)
	else
		self._uiChangeNomalMode:SetState(0)
	end

	if self._challengeMode == DestroyEvilHelpView.ChallengeMode_Powerful then
		cost = langPara("剩余：%d次", DestroyEvilController.instance:getLeftTodayNoPaidHelpTimes(self._activityId))

		self._uiChangePowerfulMode:SetState(1)
	else
		self._uiChangePowerfulMode:SetState(0)
	end

	self._txtTili.text = cost

	if self._challengeMode == DestroyEvilHelpView.ChallengeMode_None then
		GameUtil.SetActive(self._txtTili, false)
	else
		GameUtil.SetActive(self._txtTili, true)
	end
end

function DestroyEvilHelpView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "destroyevilhelpview_rule")
end

function DestroyEvilHelpView:_onClickNomal()
	self._challengeMode = DestroyEvilHelpView.ChallengeMode_Nomal

	self:_refreshBtn()
	self:_refreshRewardShow()
end

function DestroyEvilHelpView:_onClickPowerful()
	self._challengeMode = DestroyEvilHelpView.ChallengeMode_Powerful

	self:_refreshBtn()
	self:_refreshRewardShow()
end

function DestroyEvilHelpView:_onClickChallenge()
	if #self._curHelpData <= 0 then
		FloatWordMgr.instance:show(langPara("无好友求助"))

		return
	end

	local curInfo = self._curHelpData[self._curSelectTab].info

	if checknumber(curInfo.monsterLeftHp) == 0 then
		FloatWordMgr.instance:show("BOSS已被击败")

		return
	end

	if self._challengeMode == DestroyEvilHelpView.ChallengeMode_Nomal then
		local leftNum = DestroyEvilController.instance:getLeftTodayHelpTimes(self._activityId)

		if leftNum > 0 then
			DestroyEvilController.instance:openMyMissionView(self._activityId, curInfo.headInfo.userId, curInfo.monsterId, curInfo.monsterUniqueId, false, false)
		else
			FloatWordMgr.instance:show("普通助战无挑战次数")

			return
		end
	elseif self._challengeMode == DestroyEvilHelpView.ChallengeMode_Powerful then
		local leftNum = DestroyEvilController.instance:getLeftTodayNoPaidHelpTimes(self._activityId)

		if leftNum > 0 then
			DestroyEvilController.instance:openMyMissionView(self._activityId, curInfo.headInfo.userId, curInfo.monsterId, curInfo.monsterUniqueId, true, true)
		else
			FloatWordMgr.instance:show("无偿助战无挑战次数")

			return
		end
	else
		FloatWordMgr.instance:show("请选择助战模式")
	end
end

function DestroyEvilHelpView:_onClickTab(index)
	self._curSelectTab = index

	self:_refreshView()
end

function DestroyEvilHelpView:_registerTimeClock(txt, tagTime)
	self._timeClockTxt = self._timeClockTxt or {}
	self._timeClockTxt[txt] = {
		textCmp = txt,
		time = tagTime
	}
end

function DestroyEvilHelpView:_unRegisterTimeClock(txt)
	self._timeClockTxt = self._timeClockTxt or {}
	self._timeClockTxt[txt] = nil
end

function DestroyEvilHelpView:_onTimeClock()
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
		DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)
	end
end

function DestroyEvilHelpView:_onClickAddCost()
	local times = DestroyEvilModel.instance:getBuyStrengthTimesToday() + 1
	local buyCfgs = DestroyEvilConfig.instance:getBuyStrengthPlans(self._activityId)

	if times > #buyCfgs then
		times = #buyCfgs
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(buyCfgs[times].cost)
	local content = langPara("花费%d%s购买%d疲劳", matNum, MaterialMgr.getMaterialsName(matType, matId), self._actCfg.buyStrengthValue)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		if DestroyEvilModel.instance:getBuyStrengthTimesToday() >= #buyCfgs then
			FloatWordMgr.instance:show(lang("无剩余次数"))
		elseif MaterialModel.instance:IsEnough(matType, matId, matNum) == false then
			FloatWordMgr.instance:show(lang("所需材料不足"))
		else
			DestroyEvilAgent.instance:sendPM_DestroyEvilBuyStrengthReq(self._activityId)
		end
	end)
end

function DestroyEvilHelpView:_onClickShowCostTip()
	GameUtil.SetActive(self._costTip, true)
end

function DestroyEvilHelpView:_onCustomInputCostTip(hover)
	if not hover then
		GameUtil.SetActive(self._costTip, false)
	end
end

function DestroyEvilHelpView:_onClickList()
	if self._curHelpData and self._curHelpData[self._curSelectTab] then
		local monsterCfg = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, self._curHelpData[self._curSelectTab].info.monsterId)
		local scorePlanId = monsterCfg.scorePlanId

		UIStateManager.instance:push(ViewName.DestroyEvilChallengeRewardView, scorePlanId)
	end
end

function DestroyEvilHelpView:_onClickHelp()
	self._isRecommend = false

	self._helpBtnSpriteChange:SetState(1)
	self._recBtnSpriteChange:SetState(0)
	GameUtil.SetActive(self._btnReset, false)
	self:_refreshView()
end

function DestroyEvilHelpView:_onClickRec()
	self._isRecommend = true

	self._helpBtnSpriteChange:SetState(0)
	self._recBtnSpriteChange:SetState(1)
	GameUtil.SetActive(self._btnReset, true)
	self:_refreshView()
end

function DestroyEvilHelpView:_onClickReset()
	DestroyEvilAgent.instance:sendPM_DestroyEvilGetRecommendListReq(self._activityId)
end

function DestroyEvilHelpView:_onClockCost()
	if DestroyEvilModel.instance:getCurStrength() >= self._actCfg.strengthLimit then
		if self._txtCostTip then
			self._txtCostTip.text = langPara("每<color=#FFD87CFF>%dmin</color>恢复<color=#FFD87CFF>1</color>点\n疲劳已经达到上限", checkint(self._actCfg.timeGap / 60))
		end
	else
		local lack = self._actCfg.strengthLimit - DestroyEvilModel.instance:getCurStrength()
		local needSec = lack * self._actCfg.timeGap
		local targetTime = DestroyEvilModel.instance:getStrengthStamp() + needSec - ServerTime.now()
		local nextTime = DestroyEvilModel.instance:getStrengthStamp() + self._actCfg.timeGap - ServerTime.now()

		if nextTime <= 0 then
			DestroyEvilController.instance:onCostAutoChange()

			nextTime = DestroyEvilModel.instance:getStrengthStamp() + self._actCfg.timeGap - ServerTime.now()
		end

		local totalDate = GameUtil.FormatTimeWords(targetTime)
		local nextDate = GameUtil.FormatTimeWords(nextTime, isNotHour)

		if self._txtCostTip then
			self._txtCostTip.text = langPara("下次恢复疲劳:%s\n完全恢复疲劳:%s", nextDate, totalDate)
		end
	end
end

function DestroyEvilHelpView:_onMasterDeadByOther()
	if not self._isRecommend then
		DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)
	else
		DestroyEvilAgent.instance:sendPM_DestroyEvilGetRecommendListReq(self._activityId)
	end
end

function DestroyEvilHelpView:_onCostChange()
	if self._txtCost then
		self._txtCost.text = langPara("%d/%d", DestroyEvilModel.instance:getCurStrength(), self._actCfg.strengthLimit)
	end
end

function DestroyEvilHelpView:_onGetRecommendListRes()
	if self._isRecommend then
		self:_refreshView()
	end
end

function DestroyEvilHelpView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = self._actCfg.itemKey
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function DestroyEvilHelpView:_onBuyStrengthRes()
	if not self._isRecommend then
		DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)
	else
		DestroyEvilAgent.instance:sendPM_DestroyEvilGetRecommendListReq(self._activityId)
	end
end

return DestroyEvilHelpView
