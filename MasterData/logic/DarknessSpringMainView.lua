-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/view/DarknessSpringMainView.lua

module("logic.extensions.darknessspring.view.DarknessSpringMainView", package.seeall)

local DarknessSpringMainView = class("DarknessSpringMainView", ViewComponent)

function DarknessSpringMainView:ctor()
	DarknessSpringMainView.super.ctor(self)
end

function DarknessSpringMainView:buildUI()
	DarknessSpringMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnGame = self:getGo("btnGame")
	self._btnTask = self:getGo("btnTask")
	self._bg = self:getGo("bg")
	self._txtTime = self:getTxt("time/txt")
	self._txtTip = self:getTxt("tip/txt")
	self._stage1 = self:getGo("stage1")
	self._itemCount = self:getGo("itemCount")
	self._txtItemCount = self:getTxt("itemCount/txt")
	self._iconItemCount = self:getGo("itemCount/icon")
	self._goSilkEffect = self:getGo("silkEffect")
	self._silkList = {}

	for i = 1, 5 do
		local silk = {}

		silk.node = self:getGo("stage1/silk_" .. i)
		silk.iconBubble = self:getGo("stage1/silk_" .. i .. "/bubble/icon")
		silk.txtBubble = self:getTxt("stage1/silk_" .. i .. "/bubble/num")
		silk.iconCost = self:getGo("stage1/silk_" .. i .. "/cost/icon")
		silk.txtCost = self:getTxt("stage1/silk_" .. i .. "/cost/txt")
		silk.btn = self:getGo("stage1/silk_" .. i .. "/btn")

		table.insert(self._silkList, silk)
	end

	self._stage2 = self:getGo("stage2")
	self._ch = self:getGo("stage2/character")
	self._progBar = self:getGo("progress/tableview/viewport/content/slider"):GetComponent("Slider")
	self._progText = self:getTxt("progress/total/txt")
	self._tableview = self:getGo("progress/tableview")
	self._tablecell = self:getGo("progress/tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rectTrans = self._tableview:GetComponent(typeof(UnityEngine.RectTransform))
end

function DarknessSpringMainView:bindEvents()
	DarknessSpringMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function DarknessSpringMainView:unbindEvents()
	DarknessSpringMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGame)
	GameUtil.rmClickHandler(self._btnTask)
end

function DarknessSpringMainView:onExit()
	DarknessSpringMainView.super.onExit(self)
	ViewBlockMgr.instance:blockClick(false, self)

	if self._silkEffect then
		self:_unloadEffect(self._silkEffect)
	end

	removetimer(self._showPrizeWin)
	uGuiUtil.clearImage(self._bg)
	MaterialMgr.resetAll(self._iconItemCount)
	self:_clearSilkList()
	self._scrollerList:dispose()
end

function DarknessSpringMainView:onEnter()
	DarknessSpringMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DarknessSpringGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.DarknessSpringUnlockRes, self._onUnlockRes, self)
	self.addGEvent(self, GlobalNotify.DarknessSpringGainStage1PrizeRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._refreshItemCount, self)
	self:_initActivityId()
	self:_initActivityTime()

	self._lastStage = -1
	self._prizeBtnMap = {}
	self._effectMap = {}

	self:_getViewConfigs()
	self:_loadBg()
	DarknessSpringAgent.instance:sendPM_DarknessSpringGetInfoReq(self._activityId)
end

function DarknessSpringMainView:_initActivityId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DarknessSpring)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end
end

function DarknessSpringMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DarknessSpringMainView:_getViewConfigs()
	self._actCfg = DarknessSpringConfig.instance:getActivityCfgByActId(self._activityId)
	self._stage1unlockCfg = DarknessSpringConfig.instance:getStageOneUnlockCfgByActId(self._activityId) or {}
end

function DarknessSpringMainView:_refreshProgCfg()
	if self._info then
		self._stage1UnlockItemIds = self._info.stage1UnlockItemIds or {}
	end

	self._lastStage = checknumber(self._lastStage)
	self._curStage = #self._stage1UnlockItemIds < #self._stage1unlockCfg and 1 or 2

	if self._curStage ~= self._lastStage then
		self:_loadBg()
	end

	if self._curStage == 1 then
		goutil.setActive(self._stage1, true)
		goutil.setActive(self._stage2, false)

		self._progCfg = DarknessSpringConfig.instance:getStageOnePrizeCfgByActivityId(self._activityId) or {}
		self._lastStage = self._curStage
	elseif self._curStage == 2 then
		goutil.setActive(self._stage2, true)
		goutil.setActive(self._stage1, false)

		self._progCfg = DarknessSpringConfig.instance:getStageTwoProgressCfgByActId(self._activityId) or {}
		self._lastStage = self._curStage
	end
end

function DarknessSpringMainView:_refresh()
	self._info = DarknessSpringModel.instance:getActivityInfo(self._activityId)

	if not self._info then
		return
	end

	self:_refreshProgCfg()
	goutil.setActive(self._itemCount, self._curStage == 1)
	goutil.setActive(self._btnGame, self._curStage == 1)
	goutil.setActive(self._btnTask, self._curStage == 2)

	if self._curStage == 1 then
		self:_refreshStage1View()
	elseif self._curStage == 2 then
		self:_refreshStage2View()
	end

	DarknessSpringController.instance:setSliderValue(self._progBar, self._progText, self._progCfg, self._progress)

	self._progText.text = self._progText.text .. "条"
	self._progStep = 1

	local gainedAllCanGainPrz = true

	for i, v in ipairs(self._gainPrizeIds) do
		if i < v then
			gainedAllCanGainPrz = false
			self._progStep = i

			break
		end
	end

	if gainedAllCanGainPrz then
		self._progStep = #self._gainPrizeIds + 1 or self._progStep
	end

	print("[YuTestPrint] =====>\t self._progStep = " .. self._progStep)

	if self._curStage == 2 then
		self:_refreshImgCh()
	end

	self._scrollerList:reloadData(self._progCfg)
	self._scrollerList:MoveCellToCenter(self._progStep - 1)
end

function DarknessSpringMainView:_refreshStage1View()
	local gameCfg = DarknessSpringConfig.instance:getStageOneGameCfgByActivityId(self._activityId)

	self._dailyGameTimes = gameCfg.times or 0

	if self._info.stage1Info then
		self._progress = self._info.stage1Info.curScore or 0
	end

	if self._info.stage1Info then
		self._gainPrizeIds = self._info.stage1Info.gainPrizeIds or {}
	end

	if self._info then
		if not self._info.stage1Info.gameTimes then
			local gameTimes = 0
			local dailyTimes = self._dailyGameTimes

			self._txtTip.text = string.format("今日剩余次数:%d/%d", dailyTimes - gameTimes, dailyTimes)

			self:_refreshItemCount()
			self:_clearSilkList()

			for silkId, silk in ipairs(self._silkList) do
				local isUnlock = table.keyof(self._stage1UnlockItemIds, silkId) or false

				goutil.setActive(silk.node, not isUnlock)

				if not isUnlock then
					local przMatStr = self._stage1unlockCfg[silkId].prize
					local _, _, przMatNum = MaterialMgr.getMatParams(przMatStr)
					local proxyPrz = MaterialMgr.setCellByCfg(przMatStr, silk.iconBubble)

					proxyPrz.binder:setBgActive(false)
					proxyPrz.binder:setNum(0)

					silk.txtBubble.text = "x" .. przMatNum

					local costMatStr = self._stage1unlockCfg[silkId].cost
					local _, _, costMatNum = MaterialMgr.getMatParams(costMatStr)
					local proxyCost = MaterialMgr.setCellByCfg(costMatStr, silk.iconCost)

					proxyCost.binder:setBgActive(false)
					proxyCost.binder:setNum(0)

					silk.txtCost.text = "x" .. costMatNum

					GameUtil.addClickHandler(silk.btn, GameUtil.handler(self._unlockSilk, self, silkId), self)
				end
			end

			GameUtil.rmClickHandler(self._btnGame)
			GameUtil.addClickHandler(self._btnGame, self._onClickBtnGame, self)
		end
	end
end

function DarknessSpringMainView:_clearSilkList()
	for silkId, silk in ipairs(self._silkList) do
		GameUtil.rmClickHandler(silk.btn)
		MaterialMgr.resetAll(silk.iconBubble)
		MaterialMgr.resetAll(silk.iconCost)
		goutil.setActive(silk.node, true)
	end
end

function DarknessSpringMainView:_unlockSilk(silkId)
	DarknessSpringAgent.instance:sendPM_DarknessSpringUnlockReq(self._activityId, silkId)
end

function DarknessSpringMainView:_refreshItemCount()
	if self._curStage == 1 then
		MaterialMgr.resetAll(self._iconItemCount)

		local costMatStr = self._stage1unlockCfg[1].cost
		local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(costMatStr)
		local proxy = MaterialMgr.setCellByCfg(costMatStr, self._iconItemCount)

		proxy.binder:setBgActive(false)
		proxy.binder:setNum(0)

		self._txtItemCount.text = MaterialModel.instance:getMaterialsNumber(costMatType, costMatId)
	elseif self._curStage == 2 then
		self:_refresh()
	end
end

function DarknessSpringMainView:_refreshStage2View()
	self._matType, self._matId = MaterialMgr.getMatParams(self._actCfg.stage2ProgressMaterialKey)
	self._progress = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)
	self._gainPrizeIds = self._info.stage2GainPrizeIds or {}
	self._txtTip.text = "海报-古拉丝·白\n将在0124版本累消中产出"

	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function DarknessSpringMainView:_refreshImgCh()
	self._lihuiCfg = self._lihuiCfg or DarknessSpringConfig.instance:getStageTwoLiHuiCfgByActId(self._activityId) or {}

	local curStep = self._progStep - 1
	local characterPath = "bg_anshizhiquan_07"

	for i = 1, #self._lihuiCfg do
		local cfg = self._lihuiCfg[i]

		if curStep < cfg.prizeId then
			if i > 1 then
				cfg = self._lihuiCfg[i - 1]
			end

			characterPath = cfg.characterPath or characterPath

			break
		else
			characterPath = i == #self._lihuiCfg and cfg.characterPath or characterPath
		end
	end

	print("[YuTestPrint] =====>\t characterPath = " .. characterPath)
	DarknessSpringController.instance:setSpriteToImage(self._ch, DarknessSpringController.BgFloderUrl, characterPath)
end

function DarknessSpringMainView:_updateCell(view, cell, data)
	self:_clearCell(cell)

	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local got = goutil.findChild(cell, "got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	if self._curStage == 1 then
		if not data.id then
			local prizeId = data.prizeId
			local isGot = table.keyof(self._gainPrizeIds, prizeId) or false
			local canGet = not isGot and data.progress <= self._progress

			self._prizeBtnMap[cell] = self._prizeBtnMap[cell] or goutil.findChild(cell, "btn")

			local btn = self._prizeBtnMap[cell]

			if canGet then
				self._effectMap[cell] = self:_loadEffect(effect, self._rectTrans)

				GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtnPrize, self, prizeId), self)
			end

			progress.text = tostring(data.progress)

			goutil.setActive(got, isGot)
			goutil.setActive(btn, canGet)
		end
	end
end

function DarknessSpringMainView:_clearCell(cell)
	local got = goutil.findChild(cell, "got")
	local item = goutil.findChild(cell, "item")
	local rp = goutil.findChild(cell, "redpoint")

	if self._effectMap and self._effectMap[cell] then
		self:_unloadEffect(self._effectMap[cell])
	end

	GameUtil.rmClickHandler(self._prizeBtnMap[cell])
	goutil.setActive(rp, false)
	goutil.setActive(got, false)
	goutil.setActive(self._prizeBtnMap[cell], false)
	MaterialMgr.resetAll(item)
end

function DarknessSpringMainView:_reloadFinish()
	if self._progStep then
		self._scrollerList:MoveCellToCenter(self._progStep - 1)
	end
end

function DarknessSpringMainView:_loadBg()
	if not self._curStage then
		local curStage = 1
		local bgName = "bg_anshizhiquan_0" .. curStage

		DarknessSpringController.instance:setSpriteToImage(self._bg, DarknessSpringController.BgFloderUrl, bgName)
	end
end

function DarknessSpringMainView:_loadEffect(root, rectTrans)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local effect

	effect = UIEffectManager.instance:playEffect(self, effectPath, root.transform, 0, 0, true, false, nil, function()
		if rectTrans then
			effect:setClipping(rectTrans)
		end
	end)

	effect:setParent(root.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	return effect
end

function DarknessSpringMainView:_unloadEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

function DarknessSpringMainView:_playSilkEffect(effectPath)
	effectPath = effectPath .. ".prefab"

	local effect = UIEffectManager.instance:playEffect(self, effectPath, self._goSilkEffect.transform, 0, 0, false, false)

	effect:setParent(self._goSilkEffect.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	self._silkEffect = effect

	settimer(1.2, self._showPrizeWin, self, false)
end

function DarknessSpringMainView:_onUnlockRes(msg)
	ViewBlockMgr.instance:blockClick(true, self)

	self._changeSetId = msg.changeSetId

	if self._stage1unlockCfg then
		local cfg = self._stage1unlockCfg[msg.unlockItemId]
		local effectPath = cfg.effectPath

		self:_playSilkEffect(effectPath)
		DarknessSpringAgent.instance:sendPM_DarknessSpringGetInfoReq(self._activityId)
	end
end

function DarknessSpringMainView:_showPrizeWin()
	ViewBlockMgr.instance:blockClick(false, self)

	if self._silkEffect then
		self:_unloadEffect(self._silkEffect)
	end

	MaterialController.instance:showChangeSetInTemp(self._changeSetId)
	removetimer(self._showPrizeWin)
end

function DarknessSpringMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("darknessspring_rule")
end

function DarknessSpringMainView:_onClickBtnGame()
	DarknessSpringController.instance:playStageOneGame()
end

function DarknessSpringMainView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.DarknessSpringTaskView, self._activityId)
end

function DarknessSpringMainView:_onClickBtnPrize(prizeId)
	print("[YuTestPrint] =====>\t 领取奖励, prizeId = " .. prizeId)

	if self._curStage == 1 then
		if self._actCfg then
			if not self._actCfg.stage1ActId then
				local gameActId = 158007

				FirePowerContestAgent.instance:sendPM_FPCGainScorePrizeReq(gameActId, prizeId)
			end
		end
	elseif self._curStage == 2 then
		DarknessSpringAgent.instance:sendPM_DarknessSpringGainStage2PrizeReq(self._activityId, prizeId)
	end
end

function DarknessSpringMainView:_sendGetInfoReq()
	DarknessSpringAgent.instance:sendPM_DarknessSpringGetInfoReq(self._activityId)
end

return DarknessSpringMainView
