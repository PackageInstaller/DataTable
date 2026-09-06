-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilMainView.lua

module("logic.extensions.destroyevil.view.DestroyEvilMainView", package.seeall)

local DestroyEvilMainView = class("DestroyEvilMainView", ViewComponent)

function DestroyEvilMainView:ctor()
	DestroyEvilMainView.super.ctor(self)

	self._powerPetMo = FightingPowerPetMo.New()
end

function DestroyEvilMainView:buildUI()
	DestroyEvilMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnGuard = self:getBtn("btnGuard")
	self._btnRward = self:getBtn("btnReward")
	self._btnWarorder = self:getBtn("btnWarorder")
	self._btnRank = self:getBtn("btnRank")
	self._btnShop = self:getBtn("btnShop")
	self._goldBarCon = self:getGo("scoreBarCon")
	self._txtPetBuff = self:getTxt("pet/txtDesc")
	self._petCell = self:getGo("pet/petTransform/petCell")
	self._petView = self:getGo("pet/petTransform")
	self._petGourp = ItemGroup.New(self._petView, self._petCell)
	self._txtCost = self:getTxt("goldBarCon/costTabCell/TxtC_Num")
	self._btnAddCost = Framework.ButtonAdapter.Get(self:getGo("goldBarCon/costTabCell/Btn_Add"))
	self._txtCostTip = self:getTxt("goldBarCon/costTip/txtTip")
	self._btnShowCostTip = Framework.ButtonAdapter.Get(self:getGo("goldBarCon/costTabCell/showTipRaycast"))
	self._costTip = self:getGo("goldBarCon/costTip")
	self._customInput = UICustomInput.Get(self._costTip)
	self._txtTime = self:getTxt("time/txtTime")
	self._petCon = self:getGo("petCon")
	self._redPointReward = self:getGo("btnReward/redpoint")
	self._redPointWarorder = self:getGo("btnWarorder/redpoint")
	self._myIcon = self:getGo("monsterInfo/myself/headIcon/icon")
	self._myTxtLv = self:getTxt("monsterInfo/myself/headIcon/txtLv")
	self._myTxtStar = self:getTxt("monsterInfo/myself/headIcon/star/txt")
	self._myTxtHp = self:getTxt("monsterInfo/myself/headIcon/txtHp")
	self._myTxtShareNum = self:getTxt("monsterInfo/myself/headIcon/shareNum/txt")
	self._myPass = self:getGo("monsterInfo/myself/headIcon/pass")
	self._btnFriend = self:getBtn("monsterInfo/btnFriend")
	self._friendMonsterList = {}

	for i = 1, DestroyEvilModel.ShowFriendMonsterCount do
		local cell = {}
		local go = self:getGo("monsterInfo/friend/headIcon" .. i)

		cell.go = go
		cell.icon = goutil.findChild(go, "icon")
		cell.txtLv = goutil.findChildTextComponent(go, "txtLv")
		cell.txtStar = goutil.findChildTextComponent(go, "star/txt")
		cell.txtHp = goutil.findChildTextComponent(go, "txtHp")
		cell.txtTime = goutil.findChildTextComponent(go, "txtTime")
		self._friendMonsterList[i] = cell
	end

	self._headIconGo = self:getGo("monsterInfo/myself/headIcon")
	self._emptyGo = self:getGo("monsterInfo/myself/empty")
end

function DestroyEvilMainView:bindEvents()
	DestroyEvilMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnGuard, self._onClickGuard, self)
	GameUtil.addClickHandler(self._btnRward, self._onClickRward, self)
	GameUtil.addClickHandler(self._btnWarorder, self._onClickWarorder, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnAddCost, self._onClickAddCost, self)
	GameUtil.addClickHandler(self._btnShowCostTip, self._onClickShowCostTip, self)
	self._customInput:AddListener(self._onCustomInputCostTip, self)
	GameUtil.addClickHandler(self._btnFriend, self._onClickFriend, self)
end

function DestroyEvilMainView:unbindEvents()
	DestroyEvilMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGuard)
	GameUtil.rmClickHandler(self._btnRward)
	GameUtil.rmClickHandler(self._btnWarorder)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnAddCost)
	GameUtil.rmClickHandler(self._btnShowCostTip)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnFriend)
end

function DestroyEvilMainView:onEnter()
	DestroyEvilMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilViewBuddyScoreRes, self._refreshRedPoint, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilBuyStrengthRes, self._onBuyStrengthRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilCostChange, self._onCostChange, self)
	RedPointController.instance:regRedPoint(self._redPointWarorder, RedPointModel.ID_PASSPORT_DESTROYEVIL)

	self._activityId = DestroyEvilModel.instance:getActivityId()
	self._activityType = DestroyEvilModel.instance:getActivityType()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)
	self._timeCfg = ActivityDefineConfig.instance:getCfgById(self._activityType, self._activityId)
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local day = GameUtil.getDaysByTimestamp(GameUtil.string2time(self._timeCfg.startTime), ServerTime.now())
	local buffCfgs = DestroyEvilConfig.instance:getBuffCfgs(self._actCfg.buffPlanId)

	if not buffCfgs then
		return
	end

	if day > #buffCfgs then
		day = #buffCfgs
	end

	local buffCfg = DestroyEvilConfig.instance:getBuffCfg(self._actCfg.buffPlanId, day)

	self._txtPetBuff.text = langPara("效果：上阵以上精灵将%s", buffCfg.des[2])

	local petList = string.split(buffCfg.des[1], ",")

	GameUtil.SetActive(self._costTip, false)
	self._petGourp:updateWithMoArray(petList, self._updateCell, self)
	self:_setTopGoldBar()
	self:_initGameObjects()
	DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)
	DestroyEvilAgent.instance:sendPM_DestroyEvilViewBuddyScoreReq(self._activityId)

	self._isGetInfoReq = false
	self._friendInfos = {}

	settimer(1, self._onSecond, self)
end

function DestroyEvilMainView:onExit()
	DestroyEvilMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilViewBuddyScoreRes, self._refreshRedPoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilBuyStrengthRes, self._onBuyStrengthRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilCostChange, self._onCostChange, self)
	RedPointController.instance:unregRedPoint(self._redPointWarorder)
	self._petGourp:dispose(self._clearCell, self)
	removetimer(self._onSecond, self)
	removetimer(self._onClockCost, self)
	self:_clearMyMonsterInfo()
	self:_clearFriendMonsterInfo()
end

function DestroyEvilMainView:_updateCell(cell, data, index)
	local go = cell.mainGO
	local raceId = checknumber(data)
	local headIcon = goutil.findChild(go, "head/headIcon")

	MaterialMgr.setCell(MatType.Pet, raceId, headIcon)
end

function DestroyEvilMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = self._actCfg.itemKey
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function DestroyEvilMainView:_refreshView()
	self._isGetInfoReq = true
	self._txtCost.text = langPara("%d/%d", DestroyEvilModel.instance:getCurStrength(), self._actCfg.strengthLimit)

	self:_onClockCost()
	removetimer(self._onClockCost, self)
	settimer(1, self._onClockCost, self, true)
	self:_refreshMonsterInfo()
	self:_refreshRedPoint()
end

function DestroyEvilMainView:_onClockCost()
	if DestroyEvilModel.instance:getCurStrength() >= self._actCfg.strengthLimit then
		if self._txtCostTip then
			self._txtCostTip.text = langPara("每<color=#FFD87CFF>%dmin</color>恢复<color=#FFD87CFF>1</color>点\n疲劳已经达到上限", self._actCfg.timeGap / 60)
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

function DestroyEvilMainView:_refreshRedPoint()
	GameUtil.SetActive(self._redPointReward, DestroyEvilModel.instance:haveFriendScorePrize() == true)
end

function DestroyEvilMainView:_onBuyStrengthRes()
	self:_refreshView()
end

function DestroyEvilMainView:_onCostChange()
	if self._txtCost then
		self._txtCost.text = langPara("%d/%d", DestroyEvilModel.instance:getCurStrength(), self._actCfg.strengthLimit)
	end
end

function DestroyEvilMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "destroyevilmainview_rule")
end

function DestroyEvilMainView:_onClickGuard()
	if not self._isGetInfoReq then
		return
	end

	UIStateManager.instance:push(ViewName.DestroyEvilMyView, self._activityId)
end

function DestroyEvilMainView:_onClickRward()
	UIStateManager.instance:push(ViewName.DestroyEvilRewardTabView, self._activityId)
end

function DestroyEvilMainView:_onClickWarorder()
	UIStateManager.instance:push(ViewName.PassportDestroyEvilView)
end

function DestroyEvilMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.DestroyEvilRankView, self._activityId)
end

function DestroyEvilMainView:_onClickShop()
	GotoMgr.gotoByString(self._actCfg.jumpTo1)
end

function DestroyEvilMainView:_onClickAddCost()
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

function DestroyEvilMainView:_onClickShowCostTip()
	GameUtil.SetActive(self._costTip, true)
end

function DestroyEvilMainView:_onCustomInputCostTip(hover)
	if not hover then
		GameUtil.SetActive(self._costTip, false)
	end
end

function DestroyEvilMainView:_onSecond()
	self:_updateFriendMonsterInfo()
end

function DestroyEvilMainView:_refreshMonsterInfo()
	self:_refreshMyMonsterInfo()
	self:_refreshFriendMonsterInfo()
end

function DestroyEvilMainView:_refreshMyMonsterInfo()
	local monsterId = DestroyEvilModel.instance:getMonsterId()
	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, monsterId)

	goutil.setActive(self._headIconGo, cfgMonster)
	goutil.setActive(self._emptyGo, not cfgMonster)

	if cfgMonster then
		local cfgCreeps = DestroyEvilConfig.instance:getCreeps(cfgMonster.creepsMasterId)
		local targetPosId = cfgCreeps[1].posId
		local cfgTarget = cfgCreeps[1]

		for i, v in ipairs(cfgCreeps) do
			if targetPosId > v.posId then
				targetPosId = v.posId
				cfgTarget = v
			end
		end

		MaterialMgr.setIcon(self._myIcon, MatType.Pet, cfgTarget.raceId)

		self._myTxtLv.text = "Lv." .. cfgMonster.level
		self._myTxtStar.text = cfgMonster.star

		local totalHp = DestroyEvilModel.instance:getMonsterTotalHp()
		local leftHp = DestroyEvilModel.instance:getMonsterLeftHp()
		local value = Mathf.Clamp01(leftHp / totalHp) * 100

		if value > 0 and value <= 1 then
			value = 1
		end

		if value >= 30 then
			if not ColorConst.Green2 then
				local colorStr = ColorConst.Red

				self._myTxtHp.text = string.format("剩余血量：<color=#%s>%d%%</color>", colorStr, value)

				goutil.setActive(self._myPass, leftHp == 0)

				self._myTxtShareNum.text = DestroyEvilModel.instance:getBuddyHelpCount()
			end
		end
	end
end

function DestroyEvilMainView:_clearMyMonsterInfo()
	MaterialMgr.clearIcon(self._myIcon)
end

function DestroyEvilMainView:_refreshFriendMonsterInfo()
	self._friendInfos = DestroyEvilModel.instance:getAvailableSeekHelpList()

	for i, v in ipairs(self._friendMonsterList) do
		if self._friendInfos[i] then
			local info = self._friendInfos[i]

			goutil.setActive(v.go, true)

			local monsterId = info.monster.monsterId
			local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, monsterId)

			if cfgMonster then
				local cfgCreeps = DestroyEvilConfig.instance:getCreeps(cfgMonster.creepsMasterId)
				local targetPosId = cfgCreeps[1].posId
				local cfgTarget = cfgCreeps[1]

				for i, v in ipairs(cfgCreeps) do
					if targetPosId > v.posId then
						targetPosId = v.posId
						cfgTarget = v
					end
				end

				MaterialMgr.setIcon(v.icon, MatType.Pet, cfgTarget.raceId)

				v.txtLv.text = "Lv." .. cfgMonster.level
				v.txtStar.text = cfgMonster.star

				local totalHp = checknumber(info.monster.monsterTotalHp)
				local leftHp = checknumber(info.monster.monsterLeftHp)
				local value = Mathf.Clamp01(leftHp / totalHp) * 100

				if value > 0 and value <= 1 then
					value = 1
				end

				if value >= 30 then
					if not ColorConst.Green2 then
						local colorStr = ColorConst.Red

						v.txtHp.text = string.format("剩余血量：<color=#%s>%d%%</color>", colorStr, value)

						local sec = Mathf.Max(0, Mathf.Round(checknumber(info.deadLine) / 1000 - ServerTime.now()))

						v.txtTime.text = GameUtil.FormatTimeSymbol(sec)
					end
				end
			end
		else
			goutil.setActive(v.go, false)
		end
	end
end

function DestroyEvilMainView:_clearFriendMonsterInfo()
	for i, v in ipairs(self._friendMonsterList) do
		MaterialMgr.clearIcon(v.icon)
	end
end

function DestroyEvilMainView:_updateFriendMonsterInfo()
	local isExistTimeOver = false
	local curTimestamp = ServerTime.now()

	if #self._friendInfos > 0 then
		for i, v in ipairs(self._friendInfos) do
			local endTimestamp = checknumber(v.deadLine) / 1000

			if endTimestamp <= curTimestamp then
				isExistTimeOver = true
			else
				local sec = Mathf.Max(0, Mathf.Round(endTimestamp - curTimestamp))

				self._friendMonsterList[i].txtTime.text = GameUtil.FormatTimeSymbol(sec)
			end
		end
	else
		isExistTimeOver = false
	end

	if isExistTimeOver then
		self:_refreshFriendMonsterInfo()
	end
end

function DestroyEvilMainView:_onClickFriend()
	UIStateManager.instance:push(ViewName.DestroyEvilHelpView, self._activityId)
end

function DestroyEvilMainView:_initGameObjects()
	for i, v in ipairs(self._friendMonsterList) do
		goutil.setActive(go, false)
	end
end

return DestroyEvilMainView
