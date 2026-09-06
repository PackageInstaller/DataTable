-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialadvancedView.lua

module("logic.extensions.dragontrial.view.DragontrialadvancedView", package.seeall)

local DragontrialadvancedView = class("DragontrialadvancedView", ViewComponent)

function DragontrialadvancedView:ctor()
	DragontrialadvancedView.super.ctor(self)

	self._tempVector2 = Vector2.New(0, 0)
end

function DragontrialadvancedView:unbindEvents()
	DragontrialadvancedView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnRaiders:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnAddDragon:RemoveClickListener()
	self._btnAddDreamTeam:RemoveClickListener()
	self._customInput:RemoveListener()
	self._btnChallengeDragon:RemoveClickListener()
	self._btnChallengeDream:RemoveClickListener()
	self._btnBuffTip:RemoveClickListener()
end

function DragontrialadvancedView:bindEvents()
	DragontrialadvancedView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnRaiders:AddClickListener(self._onClickbtnRaiders, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnAddDreamTeam:AddClickListener(self._onClickbtnAddDreamTeam, self)
	self._btnAddDragon:AddClickListener(self._onClickbtnAddDragon, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnChallengeDream:AddClickListener(self._onClickbtnChallengeDream, self)
	self._btnChallengeDragon:AddClickListener(self._onClickbtnChallengeDragon, self)
	self._btnBuffTip:AddClickListener(self._onClickbtnBuffTip, self)
end

function DragontrialadvancedView:buildUI()
	DragontrialadvancedView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnRaiders = self:getBtn("btnRaiders")
	self._btnAddDreamTeam = self:getBtn("dreamTeamRemain/btnAdd")
	self._btnRank = self:getBtn("btnRank")
	self._btnClose = self:getBtn("btnClose")
	self._btnAddDragon = self:getBtn("dragonRemain/btnAdd")
	self._infoGo = self:getGo("stage/tableview/Viewport/Content/info")
	self._customInput = UICustomInput.Get(self._infoGo)
	self._txtDescDragon = goutil.findChildTextComponent(self.mainGO, "stage/tableview/Viewport/Content/info/dragon/txtDesc")
	self._txtDescDream = goutil.findChildTextComponent(self.mainGO, "stage/tableview/Viewport/Content/info/dreamteam/txtDesc")
	self._btnChallengeDragon = self:getBtn("stage/tableview/Viewport/Content/info/dragon/btnChallenge")
	self._btnChallengeDream = self:getBtn("stage/tableview/Viewport/Content/info/dreamteam/btnChallenge")
	self._txtDragonRemain = goutil.findChildTextComponent(self.mainGO, "dragonRemain")
	self._txtDreamTeamRemain = goutil.findChildTextComponent(self.mainGO, "dreamTeamRemain")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txt")
	self._infoTweenScale = self._infoGo:GetComponent(UnityTweensType.TweenScale)
	self._infoSizeX = self._infoGo.transform.sizeDelta.x

	local contentGo = self:getGo("stage/tableview/Viewport/Content")

	self._conteneTr = contentGo.transform
	self._contentTweenPos = contentGo:GetComponent(UnityTweensType.TweenPosition)
	self._viewportSizeX = self:getGo("stage").transform.sizeDelta.x
	self._goldBarConGo = self:getGo("goldBarCon")

	local infoItemCon = self:getGo("stage/tableview/Viewport/Content/info/itemcon")
	local infoItemcell = self:getGo("stage/tableview/Viewport/Content/info/item")

	self._itemGroup = ItemGroup.New(infoItemCon, infoItemcell, nil, nil, true)
	self._btnBuffTip = self:getBtn("btnBuffTip")

	goutil.setActive(self._infoGo, false)
	self:_buildStageItems()
end

function DragontrialadvancedView:_buildStageItems()
	local activityId = DragontrialModel.instance:getCurrActivityId()
	local acfg = DragontrialConfig.instance:getActCfg(activityId)
	local stageCfgs = DragontrialConfig.instance:getStageCfgs(acfg.dreamTrialId)

	self._stageItems = {}

	local contentGo = self:getGo("stage/tableview/Viewport/Content")
	local contentCellGo = self:getGo("stage/tableview/Viewport/Content/btn")

	goutil.setActive(contentCellGo, false)

	local len = #stageCfgs

	for i = 1, len do
		local cellP = goutil.cloneAndSetParent(contentCellGo, contentGo.transform)

		Framework.TransformUtil.SetAnchoredPos(cellP.transform, self:_getItemSpace() * (i - 1) + self:_getOffsetX(), 0)
		goutil.setActive(cellP, true)

		local cell = goutil.findChild(cellP, "root")
		local infoRoot = goutil.findChild(cellP, "object").transform
		local goIcon = goutil.findChild(cell, "txtNum/icon")
		local goLock = goutil.findChild(cell, "lock")
		local goPass = goutil.findChild(cell, "pass")
		local goLock = goutil.findChild(cell, "lock")
		local txtName = goutil.findChildTextComponent(cell, "txtName")
		local txtNum = goutil.findChildTextComponent(cell, "txtNum")
		local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
		local btn = Framework.ButtonAdapter.Get(cell)
		local bgChange = goutil.findChild(cell, "bg"):GetComponent(ComponentType.UIImageSpriteChange)

		self._stageItems[i] = {
			transform = cellP.transform,
			goPass = goPass,
			txtName = txtName,
			txtNum = txtNum,
			goIcon = goIcon,
			goLock = goLock,
			btn = btn,
			txtLock = txtLock,
			infoRoot = infoRoot,
			bgChange = bgChange
		}
	end

	self._tempVector2.x = len * self:_getItemSpace() + self:_getOffsetX()
	self._tempVector2.y = 400
	self._conteneTr.sizeDelta = self._tempVector2
end

function DragontrialadvancedView:onExit()
	DragontrialadvancedView.super.onExit(self)
	self._contentTweenPos:Stop()
	self._infoTweenScale:Stop()
	removetimer(self._updateTimer, self)
	removetimer(self._updateMove, self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialBuyTimesRes, self._PM_DragonTrialBuyTimesRes, self)

	self._ismoving = false
	self._ismoving_back = false

	goutil.setActive(self._infoGo, false)
	self._itemGroup:dispose(function(item)
		local icon = goutil.findChild(item.mainGO, "icon")

		MaterialMgr.resetAll(icon)
	end)
end

function DragontrialadvancedView:onEnter()
	DragontrialadvancedView.super.onEnter(self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialBuyTimesRes, self._PM_DragonTrialBuyTimesRes, self)

	self._stageId = 0
	self._activityId = DragontrialModel.instance:getCurrActivityId()
	self._actCfg = DragontrialConfig.instance:getActCfg(self._activityId)

	self:_setStageItems()
	self:_setFightTime()
	self:_setActLeftTime()
	self:_setGetCoinDesc()
	self:_setTopGoldBar()
end

function DragontrialadvancedView:_onClickbtnChallengeDream()
	local leftTime = DragontrialModel.instance:getDreamFightLeftTime()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("试炼次数不足")

		return
	end

	local planId = self._actCfg.dreamTrialId
	local dreamTrialPetPlan = self._actCfg.dreamTrialPetPlan

	if self._stageId > 0 then
		DragontrialModel.instance:setFirstTrialStageId(-1)
		UIStateManager.instance:push(ViewName.DragontrailMission, planId, self._stageId, dreamTrialPetPlan)
	end
end

function DragontrialadvancedView:_onClickbtnChallengeDragon()
	local leftTime = DragontrialModel.instance:getDragonFightLeftTime()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("试炼次数不足")

		return
	end

	local planId = self._actCfg.dragonTrialId

	if self._stageId > 0 then
		DragontrialModel.instance:setFirstTrialStageId(-1)
		UIStateManager.instance:push(ViewName.DragontrailMission, planId, self._stageId)
	end
end

function DragontrialadvancedView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("dragontrialadvanced")
end

function DragontrialadvancedView:_onClickbtnRaiders()
	UIStateManager.instance:push(ViewName.DragontrailstrategyView, false)
end

function DragontrialadvancedView:_onClickbtnAddDreamTeam()
	local buyCfgs = DragontrialConfig.instance:getBuyTimeCfgs(self._actCfg.dreamTrialBuyTimesPlan)
	local buyTime = DragontrialModel.instance:getDreamBuyTime()
	local totalCanBuyTimes = #buyCfgs
	local leftBuyCnt = totalCanBuyTimes - buyTime
	local leftTime = DragontrialModel.instance:getDreamFightLeftTime()

	if leftTime > 0 then
		FloatWordMgr.instance:show("还有剩余挑战次数")

		return
	end

	local buyCfg = buyCfgs[buyTime + 1]

	if buyCfg then
		local type, id, count = MaterialMgr.getMatParams(buyCfg.cost)
		local content = string.format("确定花费<color=#d44c28>%s%s</color>购买挑战次数吗？\n<size=20>每天最多可购买%s次，还能购买%s次</size>", count, MaterialMgr.getMaterialsName(type, id), totalCanBuyTimes, leftBuyCnt)

		TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
			DragontrialController.instance:recordBuyDragonOrDreamTime(false)
			DragonTrialAgent.instance:sendPM_DragonTrialBuyTimesReq(self._activityId, false)
		end)
	else
		FloatWordMgr.instance:show("购买次数不足")
	end
end

function DragontrialadvancedView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.DragontrialrankView)
end

function DragontrialadvancedView:_onClickbtnClose()
	if self:_isMoving() then
		return
	end

	self:close()
end

function DragontrialadvancedView:_onClickbtnAddDragon()
	local buyCfgs = DragontrialConfig.instance:getBuyTimeCfgs(self._actCfg.dragonTrialBuyTimesPlan)
	local buyTime = DragontrialModel.instance:getDragonBuyTime()
	local totalCanBuyTimes = #buyCfgs
	local leftBuyCnt = totalCanBuyTimes - buyTime
	local leftTime = DragontrialModel.instance:getDragonFightLeftTime()

	if leftTime > 0 then
		FloatWordMgr.instance:show("还有剩余挑战次数")

		return
	end

	local buyCfg = buyCfgs[buyTime + 1]

	if buyCfg then
		local type, id, count = MaterialMgr.getMatParams(buyCfg.cost)
		local content = string.format("确定花费<color=#d44c28>%s%s</color>购买挑战次数吗？\n<size=20>每天最多可购买%s次，还能购买%s次</size>", count, MaterialMgr.getMaterialsName(type, id), totalCanBuyTimes, leftBuyCnt)

		TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
			DragontrialController.instance:recordBuyDragonOrDreamTime(true)
			DragonTrialAgent.instance:sendPM_DragonTrialBuyTimesReq(self._activityId, true)
		end)
	else
		FloatWordMgr.instance:show("购买次数不足")
	end
end

function DragontrialadvancedView:_onClickbtnBuffTip()
	local content = DragontrialConfig.instance:getCommonValue("BUFF_DESC")

	TipsFacade.instance:openTipWindowNoX(lang("tip"), content)
end

function DragontrialadvancedView:_setStageItems()
	local activityId = DragontrialModel.instance:getCurrActivityId()
	local stageCfgs = DragontrialConfig.instance:getStageCfgs(self._actCfg.dreamTrialId)
	local len = #stageCfgs

	self._tempVector2.x = len * self:_getItemSpace() + self:_getOffsetX()
	self._tempVector2.y = 400
	self._conteneTr.sizeDelta = self._tempVector2

	for i, cfg in ipairs(stageCfgs) do
		local item = self._stageItems[i]

		item.txtName.text = cfg.showName

		goutil.setActive(item.txtNum.gameObject, false)
		goutil.setActive(item.goPass, false)
		item.bgChange:ChangeSprite(cfg.iconName)

		local baseX = (i - 1) * self:_getItemSpace() + self:_getOffsetX()

		Framework.TransformUtil.SetAnchoredPos(item.transform, baseX, 0)

		local isOpen = DragontrialModel.instance:isDreamFightOpen(i)

		goutil.setActive(item.goLock, not isOpen)

		if not isOpen then
			local openStageId = DragontrialModel.instance:getCurrSecondOpenStageId()

			item.txtLock.text = i < openStageId and string.format("%s天后开启", i + len - openStageId) or string.format("%s天后开启", i - openStageId)
		end

		item.btn:AddClickListener(function()
			self:_onClickStageItem(i)
		end)
	end
end

function DragontrialadvancedView:_onClickStageItem(stageId)
	local isOpen = DragontrialModel.instance:isDreamFightOpen(stageId)

	if not isOpen then
		FloatWordMgr.instance:show("关卡未在开启时间")

		return
	end

	if self:_isMoving() or self:_isMovingBack() then
		return
	end

	self._stageId = stageId
	self._moveBackOpr = false

	self:_setMaxDamage()
	self:_doMoveItems()
end

function DragontrialadvancedView:_onCustomInputCallback(hover)
	if not hover then
		self:_doMoveItemsBack()
	end
end

function DragontrialadvancedView:_isMoving()
	return self._ismoving
end

function DragontrialadvancedView:_isMovingBack()
	return self._ismoving_back
end

function DragontrialadvancedView:_getMoveDuration()
	return 0.2
end

function DragontrialadvancedView:_getItemSpace()
	return 250
end

function DragontrialadvancedView:_getOffsetX()
	return 6
end

function DragontrialadvancedView:_getInfoPanelSizeX()
	return self._infoSizeX
end

function DragontrialadvancedView:_getInfoPanelOffsetX()
	return -16
end

function DragontrialadvancedView:_doMoveItems()
	if self:_isMovingBack() and self._lastMoveStageId == self._stageId then
		return
	end

	if self:_isMoving() then
		return
	end

	print("向前运动")

	self._ismoving = true
	self._lastMoveStageId = self._stageId

	self:_commonMovePart()
end

function DragontrialadvancedView:_doMoveItemsBack()
	if self:_isMovingBack() or self:_isMoving() then
		return
	end

	print("往回运动")

	self._ismoving_back = true
	self._moveBackOpr = true

	self:_commonMovePart()
end

function DragontrialadvancedView:_commonMovePart()
	self:_calInfoPanelPos()
	self:_setInfoPanelScaleTweenParams()
	self:_calNeedMoveStageItems()
	self:_startMove()
end

function DragontrialadvancedView:_startMove()
	if not self._moveBackOpr then
		goutil.setActive(self._infoGo, true)
	end

	self._infoTweenScale:Begin()

	self._moveTime = 0

	settimer(0, self._updateMove, self, true)
	self:_updateMove()
end

function DragontrialadvancedView:_calNeedMoveStageItems()
	self._moveItems = {}

	for i = self._lastMoveStageId + 1, #self._stageItems do
		self._moveItems[i] = self._stageItems[i]
	end
end

function DragontrialadvancedView:_updateMove()
	self._moveTime = self._moveTime + Time.deltaTime

	if self._moveTime >= self:_getMoveDuration() + 0.2 then
		removetimer(self._updateMove, self)
		self:_calContentNewSize()
		self:_checkNeedMoveToCenter()
		self:_stopAllMove()

		return
	end

	self:_calStageItemMovePos()
end

function DragontrialadvancedView:_calInfoPanelPos()
	local item = self._stageItems[self._stageId]

	self._infoGo.transform:SetParent(item.infoRoot)
	Framework.TransformUtil.SetAnchoredPos(self._infoGo.transform, self:_getItemSpace() + self:_getInfoPanelOffsetX(), -420)
end

function DragontrialadvancedView:_calStageItemMovePos()
	local moveX = self:_getInfoPanelSizeX() + self:_getInfoPanelOffsetX()
	local movePosX = math.min(1, self._moveTime / self:_getMoveDuration()) * moveX

	if self._moveBackOpr then
		for idx, item in pairs(self._moveItems) do
			local baseX = (idx - 1) * self:_getItemSpace() + self:_getOffsetX() + moveX

			Framework.TransformUtil.SetAnchoredPos(item.transform, baseX - movePosX, 0)
		end
	else
		for idx, item in pairs(self._moveItems) do
			local baseX = (idx - 1) * self:_getItemSpace() + self:_getOffsetX()

			Framework.TransformUtil.SetAnchoredPos(item.transform, baseX + movePosX, 0)
		end
	end
end

function DragontrialadvancedView:_calContentNewSize()
	local baseX = #self._stageItems * self:_getItemSpace() + self:_getOffsetX()

	self._tempVector2.y = 440

	if self._moveBackOpr then
		self._tempVector2.x = baseX
		self._conteneTr.sizeDelta = self._tempVector2
	else
		self._tempVector2.x = baseX + self:_getInfoPanelSizeX() + self:_getInfoPanelOffsetX()
		self._conteneTr.sizeDelta = self._tempVector2
	end
end

function DragontrialadvancedView:_checkNeedMoveToCenter()
	if not self._moveBackOpr then
		local contenSizeX = self._conteneTr.sizeDelta.x

		if contenSizeX > self._viewportSizeX then
			local extraSize = contenSizeX - self._viewportSizeX
			local leftX = -self:_getItemSpace() * (self._lastMoveStageId - 1) + self:_getOffsetX()
			local rightX = -(self:_getItemSpace() * self._lastMoveStageId + self:_getOffsetX() + self:_getInfoPanelSizeX() + self:_getInfoPanelOffsetX() - self._viewportSizeX)

			leftX = math.max(-extraSize, leftX)
			rightX = math.min(0, rightX)

			local x, y = Framework.TransformUtil.GetAnchoredPos(self._conteneTr, 0, 0)

			self._tempVector2.x = x
			self._tempVector2.y = 0
			self._contentTweenPos.from = self._tempVector2

			if x < leftX and math.abs(x - leftX) > 10 then
				self._tempVector2.x = leftX
				self._tempVector2.y = 0
				self._contentTweenPos.to = self._tempVector2
				self._contentTweenPos.time = self:_getMoveContentTime(leftX)

				self._contentTweenPos:Begin()
			elseif rightX < x and math.abs(x - rightX) > 10 then
				self._tempVector2.x = rightX
				self._tempVector2.y = 0
				self._contentTweenPos.to = self._tempVector2
				self._contentTweenPos.time = self:_getMoveContentTime(rightX)

				self._contentTweenPos:Begin()
			end
		end
	end
end

function DragontrialadvancedView:_getMoveContentTime(distance)
	distance = math.abs(distance)

	if distance < self:_getItemSpace() then
		return 0.05
	else
		return 0.1
	end
end

function DragontrialadvancedView:_stopAllMove()
	self._infoTweenScale:Stop()

	if self._moveBackOpr then
		self._ismoving_back = false

		goutil.setActive(self._infoGo, false)
	else
		self._ismoving = false
	end
end

function DragontrialadvancedView:_setInfoPanelScaleTweenParams()
	self._tempVector2.x = 0
	self._tempVector2.y = 0
	self._infoTweenScale.from = self._tempVector2
	self._tempVector2.x = 1
	self._tempVector2.y = 1
	self._infoTweenScale.to = self._tempVector2

	if self._moveBackOpr then
		self._infoTweenScale.from, self._infoTweenScale.to = self._infoTweenScale.to, self._infoTweenScale.from
	end

	self._infoTweenScale.time = self:_getMoveDuration()
end

function DragontrialadvancedView:_setMaxDamage()
	self._txtDescDream.text = "最高伤害：" .. DragontrialModel.instance:getDreamMaxDamage(self._stageId)
	self._txtDescDragon.text = "最高伤害：" .. DragontrialModel.instance:getDragonMaxDamage(self._stageId)
end

function DragontrialadvancedView:_setFightTime()
	self:_setLongshenChallengeTime()
	self:_setDreamTeamChallengeTime()
end

function DragontrialadvancedView:_setLongshenChallengeTime()
	local totalTime = self._actCfg.dragonTrialFreeTimes
	local leftTime = DragontrialModel.instance:getDragonFightLeftTime()

	leftTime = math.max(leftTime, 0)
	self._txtDragonRemain.text = string.format("龙神试炼剩余次数：%s/%s", leftTime, totalTime)
end

function DragontrialadvancedView:_setDreamTeamChallengeTime()
	local totalTime = self._actCfg.dreamTrialFreeTimes
	local leftTime = DragontrialModel.instance:getDreamFightLeftTime()

	leftTime = math.max(leftTime, 0)
	self._txtDreamTeamRemain.text = string.format("梦之队试炼剩余次数：%s/%s", leftTime, totalTime)
end

function DragontrialadvancedView:_setActLeftTime()
	self._destTime = DragontrialModel.instance:getActEndTime()

	if self._destTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()
	else
		self:_actEndOp()
	end
end

function DragontrialadvancedView:_updateTimer()
	self._leftTime = self._destTime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		self._txtTime.text = self._leftTime > 86400 and string.format("时间剩余：%s", GameUtil.FormatTimeWordsNoSec(self._leftTime)) or string.format("时间剩余：%s", GameUtil.FormatTimeWords(self._leftTime))
	else
		self:_actEndOp()
	end
end

function DragontrialadvancedView:_actEndOp()
	self._txtTime.text = "活动已结束"

	removetimer(self._updateTimer, self)
end

function DragontrialadvancedView:_PM_DragonTrialBuyTimesRes(status)
	if status == 0 then
		self:_setFightTime()
	end
end

function DragontrialadvancedView:_setGetCoinDesc()
	local cfgs = DragontrialConfig.instance:getDamagePrizeShowCfgs()

	self._itemGroup:updateWithMoArray(cfgs, function(item, cfg)
		local txtDesc = goutil.findChildTextComponent(item.mainGO, "txtDesc")
		local txtNum = goutil.findChildTextComponent(item.mainGO, "txtNum")
		local icon = goutil.findChild(item.mainGO, "icon")
		local arr = string.split(cfg.prize, ":")
		local matType = arr[1]
		local matId = arr[2]

		MaterialMgr.setIcon(icon, matType, matId)

		txtDesc.text = cfg.damageDesc
		txtNum.text = checknumber(arr[#arr])
	end)
end

function DragontrialadvancedView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = "10:" .. self._activityId
	})
	MainUIController.instance:showGlodBar(self._goldBarConGo, self._viewPresentor, btn_list, false)
end

return DragontrialadvancedView
