-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilMyView.lua

module("logic.extensions.destroyevil.view.DestroyEvilMyView", package.seeall)

local DestroyEvilMyView = class("DestroyEvilMyView", ViewComponent)

function DestroyEvilMyView:ctor()
	DestroyEvilMyView.super.ctor(self)
end

function DestroyEvilMyView:buildUI()
	DestroyEvilMyView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._uiChangeNomalMode = goutil.findChildComponent(self.mainGO, "btnNomal/select", "UIImageSpriteChange")
	self._uiChangePowerfulMode = goutil.findChildComponent(self.mainGO, "btnPowerful/select", "UIImageSpriteChange")
	self._txtTili = self:getTxt("btnChallenge/txtTili")
	self._btnNomal = self:getBtn("btnNomal")
	self._btnPowerful = self:getBtn("btnPowerful")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnCall = self:getBtn("btnCall")
	self._btnWarorder = self:getBtn("btnWarorder")
	self._btnSeek = self:getBtn("btnSeek")
	self._goldBarCon = self:getGo("scoreBarCon")
	self._txtCost = self:getTxt("goldBarCon/costTabCell/TxtC_Num")
	self._btnAddCost = Framework.ButtonAdapter.Get(self:getGo("goldBarCon/costTabCell/Btn_Add"))
	self._txtCostTip = self:getTxt("goldBarCon/costTip/txtTip")
	self._btnShowCostTip = Framework.ButtonAdapter.Get(self:getGo("goldBarCon/costTabCell/showTipRaycast"))
	self._costTip = self:getGo("goldBarCon/costTip")
	self._customInput = UICustomInput.Get(self._costTip)
	self._con = self:getGo("showInfo/con")
	self._txtName = self:getTxt("showInfo/petInfo/txtName")
	self._txtStar = self:getTxt("showInfo/petInfo/star/txt")
	self._txtLv = self:getTxt("showInfo/petInfo/txtLv")
	self._txtHp = self:getTxt("showInfo/hpSlider/txtHp")
	self._hpSlider = self:getSlider("showInfo/hpSlider")
	self._btnFmt = self:getBtn("showInfo/btnFmt")
	self._btnOpen = self:getBtn("showInfo/btnOpen")
	self._openSelect = self:getGo("showInfo/btnOpen/select")
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

	self._btnDifficult = self:getBtn("btnDifficult")
	self._headIconGo = self:getGo("monsterInfo/myself/headIcon")
	self._emptyGo = self:getGo("monsterInfo/myself/empty")
	self._txtBtnOpen = self:getTxt("showInfo/btnOpen/txt")
	self._warorderRedpointGo = self:getGo("btnWarorder/redpoint")
end

function DestroyEvilMyView:bindEvents()
	DestroyEvilMyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnNomal, self._onClickNomal, self)
	GameUtil.addClickHandler(self._btnPowerful, self._onClickPowerful, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnWarorder, self._onClickWarorder, self)
	GameUtil.addClickHandler(self._btnSeek, self._onClickSeek, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickFmt, self)
	GameUtil.addClickHandler(self._btnOpen, self._onClickOpen, self)
	GameUtil.addClickHandler(self._btnAddCost, self._onClickAddCost, self)
	GameUtil.addClickHandler(self._btnShowCostTip, self._onClickShowCostTip, self)
	self._customInput:AddListener(self._onCustomInputCostTip, self)
	GameUtil.addClickHandler(self._btnFriend, self._onClickFriend, self)
	self._btnDifficult:AddClickListener(self._onClickbtnDifficult, self)
end

function DestroyEvilMyView:unbindEvents()
	DestroyEvilMyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnNomal)
	GameUtil.rmClickHandler(self._btnPowerful)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnWarorder)
	GameUtil.rmClickHandler(self._btnSeek)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnOpen)
	GameUtil.rmClickHandler(self._btnAddCost)
	GameUtil.rmClickHandler(self._btnShowCostTip)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnFriend)
	self._btnDifficult:RemoveClickListener()
end

function DestroyEvilMyView:onEnter()
	DestroyEvilMyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FriendSelected, self._onSelectFriend, self)
	self.addGEvent(self, GlobalNotify.DestroyEvilRefreshMonsterRes, self._onRefreshMonsterRes, self)
	self.addGEvent(self, GlobalNotify.DestroyEvilSetPublicBossRes, self._onSetPublicBossRes, self)
	self.addGEvent(self, GlobalNotify.DestroyEvilGetInfoRes, self._onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.DestroyEvilCostChange, self._onCostChange, self)
	self.addGEvent(self, GlobalNotify.DestroyEvilBuyStrengthRes, self._onBuyStrengthRes, self)
	self.addGEvent(self, GlobalNotify.DestroyEvilSelectDifficultyRes, self._onDestroyEvilSelectDifficultyRes, self)

	self._activityId = self:getFirstParam()
	self._isReadySend = false
	self._actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)
	self._isPowerful = false
	self._challengeMode = DestroyEvilModel.ChallengeMode_Nomal

	self:_initGameObjects()
	self:_refreshBtn()
	self:_initBtnOpen()
	self:_refreshIds()
	self:_refreshShowInfo()
	self:_refreshCallState()
	self:_setTopGoldBar()

	self._friendInfos = {}

	self:_refreshMonsterInfo()
	settimer(1, self._onSecond, self)
	self:_selectDifficult()
	RedPointController.instance:regRedPoint(self._warorderRedpointGo, 533)
end

function DestroyEvilMyView:onExit()
	DestroyEvilMyView.super.onExit(self)
	self:_resetRoleModel()
	self:_clearRefreshEffect()
	removetimer(self._onSecond, self)
	removetimer(self._onClockCost, self)
	self:_clearMyMonsterInfo()
	self:_clearFriendMonsterInfo()

	self._challengeOp = false

	RedPointController.instance:unregRedPoint(self._warorderRedpointGo)
end

function DestroyEvilMyView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = self._actCfg.itemKey
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
	self:_onCostChange()
end

function DestroyEvilMyView:_onCostChange()
	self._txtCost.text = langPara("%d/%d", DestroyEvilModel.instance:getCurStrength(), self._actCfg.strengthLimit)
end

function DestroyEvilMyView:_onClickAddCost()
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

function DestroyEvilMyView:_onClickShowCostTip()
	GameUtil.SetActive(self._costTip, true)
end

function DestroyEvilMyView:_onCustomInputCostTip(hover)
	if not hover then
		GameUtil.SetActive(self._costTip, false)
	end
end

function DestroyEvilMyView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "destroyevilmyview_rule")
end

function DestroyEvilMyView:_onClickNomal()
	self._challengeMode = DestroyEvilModel.ChallengeMode_Nomal

	self:_refreshBtn()
end

function DestroyEvilMyView:_onClickPowerful()
	self._challengeMode = DestroyEvilModel.ChallengeMode_Powerful

	self:_refreshBtn()
end

function DestroyEvilMyView:_refreshBtn()
	local cost = self._actCfg.strengthCost

	if self._challengeMode == DestroyEvilModel.ChallengeMode_Nomal then
		self._uiChangeNomalMode:SetState(1)
	else
		self._uiChangeNomalMode:SetState(0)
	end

	if self._challengeMode == DestroyEvilModel.ChallengeMode_Powerful then
		cost = self._actCfg.strongChallengeStrengthCost

		self._uiChangePowerfulMode:SetState(1)
	else
		self._uiChangePowerfulMode:SetState(0)
	end

	self._txtTili.text = langPara("%d", cost)
end

function DestroyEvilMyView:_onDefeatBossWhenClickChallenge()
	local isToggle = DestroyEvilController.instance:getAutoCostTicket(self._activityId)

	if isToggle then
		local ticketId = DestroyEvilController.instance:getSelectTicketId(self._activityId)

		if ticketId > 0 then
			local isHaveTicket = DestroyEvilController.instance:isExistTicket(self._activityId, ticketId)

			if isHaveTicket then
				self._isDoAutoCost = true

				DestroyEvilAgent.instance:sendPM_DestroyEvilRefreshMonsterReq(self._activityId, ticketId)
			else
				UIStateManager.instance:push(ViewName.DestroyEvilSelectView, self._activityId)
			end
		else
			UIStateManager.instance:push(ViewName.DestroyEvilSelectView, self._activityId)
		end
	else
		UIStateManager.instance:push(ViewName.DestroyEvilSelectView, self._activityId)
	end
end

function DestroyEvilMyView:_onClickChallenge(fromServer)
	local monId = DestroyEvilModel.instance:getMonsterId()

	printInfo("test DestroyEvilMyView:_onClickChallenge")

	self._isDoAutoCost = false

	if DestroyEvilModel.instance:isDefeatBoss() then
		printInfo("test 走击败boss流程")
		self:_onDefeatBossWhenClickChallenge()

		return
	end

	if not fromServer then
		self._challengeOp = true

		DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)

		return
	end

	self._isPowerful = self._challengeMode == DestroyEvilModel.ChallengeMode_Powerful

	if monId <= 0 then
		FloatWordMgr.instance:show("暂时未发现恶敌")

		return
	end

	if ((self._isPowerful == true or nil) and self._actCfg.strongChallengeStrengthCost) <= DestroyEvilModel.instance:getCurStrength() then
		DestroyEvilController.instance:openMyMissionView(self._activityId, self._userId, self._monsterId, self._monsterUniqueId, self._isPowerful, false)
	else
		FloatWordMgr.instance:show(lang("疲劳不足"))
	end
end

function DestroyEvilMyView:_onClickCall()
	if not DestroyEvilModel.instance:isFightedSelfBoss() then
		FloatWordMgr.instance:show("挑战过至少1次此BOSS，可好友召集")

		return
	end

	if DestroyEvilModel.instance:isDefeatBoss() then
		FloatWordMgr.instance:show("恶敌已被击败 仅可求助未被击败的怪物")

		return
	end

	self._isReadySend = true

	ViewMgr.instance:open(ViewName.FriendSelect, 0, 0, lang("请选择好友发起求助"))
end

function DestroyEvilMyView:_onClickWarorder()
	UIStateManager.instance:push(ViewName.PassportDestroyEvilView)
end

function DestroyEvilMyView:_onClickSeek()
	UIStateManager.instance:push(ViewName.DestroyEvilSelectView, self._activityId)
end

function DestroyEvilMyView:_onClickFmt()
	return
end

function DestroyEvilMyView:_onClickOpen()
	local monId = checknumber(DestroyEvilModel.instance:getMonsterId())

	if monId <= 0 then
		FloatWordMgr.instance:show("不存在恶敌")

		return
	end

	if DestroyEvilModel.instance:isDefeatBoss() then
		FloatWordMgr.instance:show("恶敌已被击败 仅可求助未被击败的怪物")

		return
	end

	if DestroyEvilModel.instance:isFixedPublicBoss(self._activityId) then
		goutil.setActive(self._openSelect, true)
		FloatWordMgr.instance:show("怪物已向全服公开 不可修改")

		return
	end

	goutil.setActive(self._openSelect, false)
	TipsFacade.instance:openPopupWindow("提示", "是否公开该怪物给本服所有玩家，公开后不可修改状态", function()
		DestroyEvilAgent.instance:sendPM_DestroyEvilSetPublicBossReq(self._activityId)
	end)
end

function DestroyEvilMyView:_resetPublicBoss()
	local timeMs = DestroyEvilModel.instance:getAutoPublicTimeMillis()

	if timeMs == -1 or timeMs <= ServerTime.nowMs() then
		goutil.setActive(self._openSelect, true)

		return
	end

	local monId = checknumber(DestroyEvilModel.instance:getMonsterId())

	if monId <= 0 then
		goutil.setActive(self._openSelect, false)

		return
	end

	if DestroyEvilModel.instance:isFixedPublicBoss(self._activityId) then
		goutil.setActive(self._openSelect, true)

		return
	end

	goutil.setActive(self._openSelect, false)
end

function DestroyEvilMyView:_onSelectFriend(ids)
	if self._isReadySend and #ids > 0 then
		FloatWordMgr.instance:show("好友已召集")
		DestroyEvilAgent.instance:sendPM_DestroyEvilConveneBuddyReq(self._activityId, ids)

		self._isReadySend = nil
	end
end

function DestroyEvilMyView:_initGameObjects()
	for i, v in ipairs(self._friendMonsterList) do
		goutil.setActive(v.go, false)
	end
end

function DestroyEvilMyView:_initBtnOpen()
	local monId = checknumber(DestroyEvilModel.instance:getMonsterId())

	if monId <= 0 then
		goutil.setActive(self._openSelect, false)

		return
	end

	if DestroyEvilModel.instance:isFixedPublicBoss(self._activityId) then
		goutil.setActive(self._openSelect, true)

		return
	end

	goutil.setActive(self._openSelect, false)
end

function DestroyEvilMyView:_refreshIds()
	self._userId = RoleModel.instance:getUserId()
	self._monsterId = DestroyEvilModel.instance:getMonsterId()
	self._monsterUniqueId = DestroyEvilModel.instance:getMonsterUniqueId()
	self._monsterTotalHp = DestroyEvilModel.instance:getMonsterTotalHp()
	self._monsterLeftHp = DestroyEvilModel.instance:getMonsterLeftHp()
end

function DestroyEvilMyView:_refreshShowInfo()
	local cfgMonster = DestroyEvilConfig.instance:getMonsterCfg(self._activityId, self._monsterId)

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

		self:_showRoleModel(cfgTarget.raceId)

		self._txtLv.text = "Lv." .. cfgMonster.level
		self._txtStar.text = cfgMonster.star
		self._txtHp.text = string.format("%d/%d", self._monsterLeftHp, self._monsterTotalHp)

		self._hpSlider:SetValue(Mathf.Clamp01(self._monsterLeftHp / self._monsterTotalHp))

		self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, cfgTarget.raceId)
	end
end

function DestroyEvilMyView:_showRoleModel(raceId)
	local curFaceId = raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function DestroyEvilMyView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DestroyEvilMyView:_onRefreshMonsterRes(ticketId)
	local cfg = DestroyEvilConfig.instance:getTicket(self._activityId, ticketId)

	if cfg and cfg.itemKey then
		local matType, cfgId = MaterialMgr.getMatParams(cfg.itemKey)
		local name = MaterialMgr.getMaterialsName(matType, cfgId)

		FloatWordMgr.instance:show("已使用 " .. name)
	end

	local isAutoCost = self._isDoAutoCost

	self._isDoAutoCost = false

	self:_playRefreshEffect(isAutoCost)
	DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)
end

function DestroyEvilMyView:_onSetPublicBossRes(isSetSuccess)
	if not isSetSuccess then
		DestroyEvilAgent.instance:sendPM_DestroyEvilGetInfoReq(self._activityId)
	else
		goutil.setActive(self._openSelect, true)
	end
end

function DestroyEvilMyView:_onGetInfoRes()
	self:_refreshIds()
	self:_refreshShowInfo()
	self:_refreshMonsterInfo()
	self:_refreshCallState()
	self:_resetPublicBoss()
	self:_refreshCostShow()

	if self._challengeOp then
		self._challengeOp = false

		self:_onClickChallenge(true)
	end
end

function DestroyEvilMyView:_refreshCostShow()
	self._txtCost.text = langPara("%d/%d", DestroyEvilModel.instance:getCurStrength(), self._actCfg.strengthLimit)

	self:_onClockCost()
	removetimer(self._onClockCost, self)
	settimer(1, self._onClockCost, self, true)
end

function DestroyEvilMyView:_onBuyStrengthRes()
	self:_refreshCostShow()
end

function DestroyEvilMyView:_onClockCost()
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

function DestroyEvilMyView:_onSecond()
	self:_updateFriendMonsterInfo()
	self:_updateMyMonsterOpen()
end

function DestroyEvilMyView:_refreshMonsterInfo()
	self:_refreshMyMonsterInfo()
	self:_refreshFriendMonsterInfo()
end

function DestroyEvilMyView:_refreshMyMonsterInfo()
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

function DestroyEvilMyView:_clearMyMonsterInfo()
	MaterialMgr.clearIcon(self._myIcon)
end

function DestroyEvilMyView:_refreshFriendMonsterInfo()
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

function DestroyEvilMyView:_clearFriendMonsterInfo()
	for i, v in ipairs(self._friendMonsterList) do
		MaterialMgr.clearIcon(v.icon)
	end
end

function DestroyEvilMyView:_updateFriendMonsterInfo()
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

function DestroyEvilMyView:_onClickFriend()
	UIStateManager.instance:push(ViewName.DestroyEvilHelpView, self._activityId)
end

function DestroyEvilMyView:_refreshCallState()
	local isFighted = DestroyEvilModel.instance:isFightedSelfBoss()

	GameUtil.SetGray(self._btnCall.gameObject, not isFighted)
end

function DestroyEvilMyView:_playRefreshEffect(isAutoCost)
	self:_clearRefreshEffect()

	local finishCallback

	if isAutoCost then
		function finishCallback()
			printInfo("test 特效结束", ServerTime.nowMs())
		end
	end

	printInfo("test 特效开始", ServerTime.nowMs())

	self._uiEffect = UIEffectManager.instance:playEffect(self, "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_yun.prefab", self.mainGO.transform, 0, 0, false, nil, finishCallback)

	self._uiEffect:setParent(self.mainGO.transform)
	self._uiEffect:setScale(1)
	self._uiEffect:setLocalPos(0, 0, 0)
end

function DestroyEvilMyView:_clearRefreshEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function DestroyEvilMyView:_selectDifficult()
	local star = DestroyEvilModel.instance:getDifficultyStar()

	if star <= 0 then
		UIStateManager.instance:push(ViewName.DestroyevilselectdifficltView, self._activityId)

		return true
	end

	return false
end

function DestroyEvilMyView:_onDestroyEvilSelectDifficultyRes()
	self:_refreshIds()
	self:_refreshShowInfo()
	self:_refreshMonsterInfo()
	self:_refreshCallState()
	self:_resetPublicBoss()
	self:_refreshCostShow()
end

function DestroyEvilMyView:_onClickbtnDifficult()
	local refreshCfgs = DestroyEvilConfig.instance:getResetDiffitcultCostCfgs(self._actCfg.resetDifficultyCostPlanId)
	local refreshTime = DestroyEvilModel.instance:getTodayResetDifficultyTimes()

	if refreshTime >= #refreshCfgs then
		FloatWordMgr.instance:show("刷新次数不足")

		return
	end

	local nextRefreshTime = refreshTime + 1
	local refreshCfg = refreshCfgs[nextRefreshTime]

	if not MaterialMgr.getMatEnough(refreshCfg.cost) then
		FloatWordMgr.instance:show("刷新消耗道具不足")

		return
	end

	UIStateManager.instance:push(ViewName.DestroyevilselectdifficltView, self._activityId)
end

function DestroyEvilMyView:_updateMyMonsterOpen()
	local monsterId = DestroyEvilModel.instance:getMonsterId()

	if monsterId <= 0 then
		goutil.setActive(self._btnOpen.gameObject, false)

		return
	end

	local leftHp = DestroyEvilModel.instance:getMonsterLeftHp()

	if leftHp <= 0 then
		goutil.setActive(self._btnOpen.gameObject, false)

		return
	end

	goutil.setActive(self._btnOpen.gameObject, true)

	local timeMs = DestroyEvilModel.instance:getAutoPublicTimeMillis()

	if timeMs == -1 or timeMs <= ServerTime.nowMs() then
		self._txtBtnOpen.text = "公开后可在好友求助-推荐列表中向全服玩家展示"

		goutil.setActive(self._openSelect, true)

		return
	end

	goutil.setActive(self._openSelect, false)

	local time = math.ceil(timeMs / 1000 - ServerTime.now())
	local hour, min, sec = GameUtil.getTimeHHMMSS(time)
	local hourStr = string.format("%02d", hour)
	local minStr = string.format("%02d", min)
	local secStr = string.format("%02d", sec)

	self._txtBtnOpen.text = string.format("%s:%s:%s后自动公开，公开到本服玩家", hourStr, minStr, secStr)
end

return DestroyEvilMyView
