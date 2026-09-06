-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/view/EventPreviewUnlockView.lua

module("logic.extensions.eventpreview.view.EventPreviewUnlockView", package.seeall)

local EventPreviewUnlockView = class("EventPreviewUnlockView", ViewComponent)

function EventPreviewUnlockView:ctor()
	EventPreviewUnlockView.super.ctor(self)

	self._lightEffPaths = {
		"20250430/shengqiyure/fx_ui_dianliang_lan.prefab",
		"20250430/shengqiyure/fx_ui_dianliang_lv.prefab",
		"20250430/shengqiyure/fx_ui_dianliang_zi.prefab",
		"20250430/shengqiyure/fx_ui_dianliang_huang.prefab",
		"20250430/shengqiyure/fx_ui_dianliang_cheng.prefab",
		"20250430/shengqiyure/fx_ui_dianliang_hong.prefab"
	}
	self._loopEffPaths = {
		"20250430/shengqiyure/fx_ui_loop_lan.prefab",
		"20250430/shengqiyure/fx_ui_loop_lv.prefab",
		"20250430/shengqiyure/fx_ui_loop_zi.prefab",
		"20250430/shengqiyure/fx_ui_loop_huang.prefab",
		"20250430/shengqiyure/fx_ui_loop_cheng.prefab",
		"20250430/shengqiyure/fx_ui_loop_hong.prefab"
	}
	self._chargeEffPath = "20250430/shengqiyure/fx_ui_chongneng.prefab"
end

function EventPreviewUnlockView:unbindEvents()
	EventPreviewUnlockView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnUnlock)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnWorldTog)

	for i, cell in ipairs(self._cellShowList) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function EventPreviewUnlockView:bindEvents()
	EventPreviewUnlockView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnUnlock, self._onClickUnlock, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
	GameUtil.addClickHandler(self._btnWorldTog, self._onClickSwitchWorld, self)

	for i, cell in ipairs(self._cellShowList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickShow, self, i))
	end
end

function EventPreviewUnlockView:buildUI()
	EventPreviewUnlockView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnGoto = self:getGo("btnGoto")
	self._rdBtnGoto = self:getGo("btnGoto/rd")
	self._txtNumPerson = self:getTxt("prize/progress/txtNum")

	local cellPerson = self:getGo("prize/cell")
	local tabPerson = self:getGo("prize/tableview")

	self._tableviewPerson = ScrollerList.create(tabPerson, cellPerson, GameUtil.handler(self._updatePersonCell, self), GameUtil.handler(self._clearPersonCell, self))
	self._progressBarPerson = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumWorld = self:getTxt("worldRectTrans/root/content/progress/txtNum")
	self._worldRoot = self:getGo("worldRectTrans/root")

	local tabWorld = self:getGo("worldRectTrans/root/content/tableview")
	local cellWorld = self:getGo("worldRectTrans/root/content/tableview/cell")

	self._tableviewWorld = ScrollerList.create(tabWorld, cellWorld, GameUtil.handler(self._updateWorldCell, self), GameUtil.handler(self._clearWorldCell, self))
	self._progBarWorld = self:getSlider("worldRectTrans/root/content/tableview/viewport/content/progBar")
	self._btnWorldTog = self:getGo("worldRectTrans/root/btn")
	self._arrowWorld = self:getGo("worldRectTrans/root/btn/arrow")
	self._goProgress = self:getGo("worldRectTrans/root/content/progress")
	self._goWorldTableview = self:getGo("worldRectTrans/root/content/tableview")
	self._unlock = self:getGo("unlock")
	self._btnUnlock = self:getGo("unlock/btn")
	self._txtUnlock = self:getTxt("unlock/cost/txt")
	self._iconUnlock = self:getGo("unlock/cost/txt/icon")
	self._chargeEffPos = self:getGo("unlock/eff")
	self._cellShowList = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("show/cell_" .. i)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.lock = goutil.findChild(cell.go, "lock")
		cell.unlock = goutil.findChild(cell.go, "unlock")
		cell.redpoint = goutil.findChild(cell.go, "redpoint")
		cell.effPos = goutil.findChild(cell.go, "eff")
		self._cellShowList[i] = cell
	end
end

function EventPreviewUnlockView:onExit()
	EventPreviewUnlockView.super.onExit(self)
	self._tableviewPerson:dispose()
	self._tableviewWorld:dispose()
	MaterialMgr.resetAll(self._iconUnlock)

	for i, cell in ipairs(self._cellShowList) do
		if cell.lightEff then
			UIEffectManager.instance:stopEffect(cell.lightEff)
		end

		cell.lightEff = nil

		if cell.loopEff then
			UIEffectManager.instance:stopEffect(cell.loopEff)
		end

		cell.loopEff = nil
	end

	if self._chargeEff then
		UIEffectManager.instance:stopEffect(self._chargeEff)
	end

	self._chargeEff = nil

	RedPointController.instance:unregRedPoint(self._rdBtnGoto)
end

function EventPreviewUnlockView:onEnter()
	EventPreviewUnlockView.super.onEnter(self)

	self._isPlayAni = false
	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.UpcomingActivityGetUnlockInfo, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.UpcomingActivityGainPersonPrize, self._updatePersonPrize, self)
	self.addGEvent(self, GlobalNotify.UpcomingActivityGainWorldPrize, self._updateWorldPrize, self)
	self.addGEvent(self, GlobalNotify.UpcomingActivitySendUnlock, self._handleUnlock, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._handleUnlock, self)
	self:_updateUIByCfg()
	EventPreviewController.instance:getUnlockInfo(self._activityId)

	self._curShowWorld = true

	self:_onClickSwitchWorld()
	RedPointController.instance:regRedPoint(self._rdBtnGoto, 506)
end

function EventPreviewUnlockView:_updateUIByCfg()
	self._unLockCfgs = EventPreviewConfig.instance:getUnlockActCfgs(self._activityId) or {}
	self._showCfgs = EventPreviewConfig.instance:getUnlockShowCfgs(self._activityId) or {}
	self._personPrizeCfgs = EventPreviewConfig.instance:getUnlockPersonPrizeCfgs(self._activityId) or {}
	self._worldPrizeCfgs = EventPreviewConfig.instance:getUnlockWorldPrizeCfgs(self._activityId) or {}

	self:_updateUnlock()
end

function EventPreviewUnlockView:_updateWorldPrize()
	local baseInfo = EventPreviewModel.instance:getUnlockInfo(self._activityId)

	self._gainedWorldPrizeIds = baseInfo.gainedWorldPrizeIds or {}
	self._worldNum = checknumber(baseInfo.worldNum)

	self._tableviewWorld:reloadData(self._worldPrizeCfgs)

	if #self._worldPrizeCfgs > 0 then
		local septValue = checknumber(1 / #self._worldPrizeCfgs)
		local totalValue = 0
		local lastNum = 0

		for i, v in ipairs(self._worldPrizeCfgs) do
			if self._worldNum > v.num then
				totalValue = septValue + totalValue
				lastNum = v.num
			else
				totalValue = totalValue + septValue * (self._worldNum - lastNum) / (v.num - lastNum)

				break
			end
		end

		self._progBarWorld:SetValue(totalValue)
	else
		self._progBarWorld:SetValue(0)
	end

	self._txtNumWorld.text = self._worldNum
end

function EventPreviewUnlockView:_updatePersonPrize()
	local baseInfo = EventPreviewModel.instance:getUnlockInfo(self._activityId)

	if not baseInfo.unlockedIds then
		self._unlockedNum = #baseInfo.unlockedIds
		self._gainedPersonPrizeIds = baseInfo.gainedPersonPrizeIds or {}

		self._tableviewPerson:reloadData(self._personPrizeCfgs)

		local scoreList = {}

		for i, v in ipairs(self._personPrizeCfgs) do
			table.insert(scoreList, checknumber(v.num))
		end

		self._tableviewPerson:updateUnderSlider(self._progressBarPerson, self._unlockedNum, scoreList)

		self._txtNumPerson.text = self._unlockedNum
	end
end

function EventPreviewUnlockView:_updateUnlock()
	local baseInfo = EventPreviewModel.instance:getUnlockInfo(self._activityId)

	if baseInfo then
		self._unlockedIds = baseInfo.unlockedIds or {}
	end

	self._curUnlockId = #self._unlockedIds + 1

	goutil.setActive(self._unlock, self._curUnlockId <= #self._unLockCfgs)

	if self._curUnlockId <= #self._unLockCfgs then
		local curCostCfg = self._unLockCfgs[self._curUnlockId]

		if curCostCfg then
			local matType, cfgId, matNum = MaterialMgr.getMatParams(curCostCfg.cost)
			local num = MaterialModel.instance:getMaterialsNumber(matType, cfgId)

			self._txtUnlock.text = string.format("%s/<color=#6AFF48>%s</color>", num, matNum)

			MaterialMgr.setIcon(self._iconUnlock, matType, cfgId)
		end
	end

	for i, cell in ipairs(self._cellShowList) do
		if cell.loopEff then
			UIEffectManager.instance:stopEffect(cell.loopEff)
		end

		cell.loopEff = nil

		local cfg = self._showCfgs[i]

		if cfg then
			local isUnlock = i <= #self._unlockedIds

			if isUnlock then
				goutil.setActive(cell.unlock, true)
				goutil.setActive(cell.lock, false)

				local isFirstShowKey = string.format("eventpreviewunlockview_%s_%s", self._activityId, i)
				local isFirstShow = checknumber(GameUtil.getUserData(isFirstShowKey)) <= 0

				goutil.setActive(cell.redpoint, isFirstShow)

				cell.loopEff = UIEffectManager.instance:playEffect(self, self._loopEffPaths[i], nil, 0, 0, true, false, nil, function(target, eff)
					eff:setParent(cell.effPos.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1)

					eff.hideEffWhileNotOnTop = true
				end)
			else
				goutil.setActive(cell.unlock, false)
				goutil.setActive(cell.lock, true)
				goutil.setActive(cell.redpoint, false)
			end

			goutil.setActive(cell.go, true)
		else
			goutil.setActive(cell.go, false)
		end
	end
end

function EventPreviewUnlockView:_handleGetInfo()
	self:_updateWorldPrize()
	self:_updatePersonPrize()
	self:_updateUnlock()
end

function EventPreviewUnlockView:_handleUnlock()
	self._isPlayAni = true

	if self._chargeEff then
		UIEffectManager.instance:stopEffect(self._chargeEff)
	end

	self._chargeEff = nil
	self._chargeEff = UIEffectManager.instance:playEffect(self, self._chargeEffPath, nil, 0, 0, false, false, function()
		local cell = self._cellShowList[self._curUnlockId]

		if cell then
			if cell.lightEff then
				UIEffectManager.instance:stopEffect(cell.lightEff)
			end

			cell.lightEff = nil
			cell.lightEff = UIEffectManager.instance:playEffect(self, self._lightEffPaths[self._curUnlockId], nil, 0, 0, false, false, function()
				self._isPlayAni = false

				self:_handleGetInfo()
			end, function(target, eff)
				eff:setParent(cell.effPos.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)

				eff.hideEffWhileNotOnTop = true
			end)
		else
			self._isPlayAni = false

			self:_handleGetInfo()
		end
	end, function(target, eff)
		eff:setParent(self._chargeEffPos.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function EventPreviewUnlockView:_updatePersonCell(view, cellGo, data)
	local cell = self:_clearPersonCell(cellGo)

	cell.txtNum.text = data.damage

	MaterialMgr.setCellByCfg(data.prize, cell.item)

	local isGain = table.keyof(self._gainedPersonPrizeIds, data.prizeId)
	local isMatchGain = not isGain and self._unlockedNum >= checknumber(data.num)

	goutil.setActive(cell.btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(cell.effect, self:getGo("prize/tableview/viewport"))
		GameUtil.addClickHandler(cell.btnGet, self._onClickGainPersonPrize, self)
	end

	goutil.setActive(cell.geted, isGain)
end

function EventPreviewUnlockView:_clearPersonCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.effect = goutil.findChild(cell.go, "effect")
	cell.geted = goutil.findChild(cell.go, "geted")

	GameUtil.rmClickHandler(cell.btnGet)
	self:_clearCellEffect(cell.effect)

	return cell
end

function EventPreviewUnlockView:_updateWorldCell(view, cellGo, data)
	local cell = self:_clearWorldCell(cellGo)

	cell.txtNum.text = data.num

	MaterialMgr.setCellByCfg(data.prize, cell.item)

	local isGain = table.keyof(self._gainedWorldPrizeIds, data.prizeId)
	local isMatchGain = not isGain and self._worldNum >= checknumber(data.num)

	goutil.setActive(cell.btnGet, isMatchGain)

	if isMatchGain then
		self:_playCellEffect(cell.effect, self:getGo("worldRectTrans/root/content/tableview/viewport"))
		GameUtil.addClickHandler(cell.btnGet, self._onClickGainWorldPrize, self)
	end

	goutil.setActive(cell.geted, isGain)
end

function EventPreviewUnlockView:_clearWorldCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)

	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.effect = goutil.findChild(cell.go, "effect")
	cell.geted = goutil.findChild(cell.go, "geted")

	GameUtil.rmClickHandler(cell.btnGet)
	self:_clearCellEffect(cell.effect)

	return cell
end

function EventPreviewUnlockView:_playCellEffect(effGo, viewPortGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(viewPortGo.transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function EventPreviewUnlockView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function EventPreviewUnlockView:_onClickGainPersonPrize()
	if self._isPlayAni then
		return
	end

	EventPreviewController.instance:gainPersonPrize(self._activityId)
end

function EventPreviewUnlockView:_onClickGainWorldPrize()
	if self._isPlayAni then
		return
	end

	EventPreviewController.instance:gainWorldPrize(self._activityId)
end

function EventPreviewUnlockView:_onClickbtnTip()
	if self._isPlayAni then
		return
	end

	TipsFacade.instance:openRulesView("eventpreviewunlockview_rule")
end

function EventPreviewUnlockView:_onClickUnlock()
	if self._isPlayAni then
		return
	end

	local curCostCfg = self._unLockCfgs[self._curUnlockId]

	if curCostCfg then
		if MaterialMgr.getMatEnough(curCostCfg.cost) then
			EventPreviewController.instance:sendUnlock(self._activityId, self._curUnlockId)
		else
			local matName = MaterialMgr.getMaterialsNameByCfg(curCostCfg.cost)

			FloatWordMgr.instance:show(string.format("%s不足", matName))
		end
	end
end

function EventPreviewUnlockView:_onClickGoto()
	if self._isPlayAni then
		return
	end

	UIStateManager.instance:push(ViewName.WishTreeBottleTaskFrameView, self._activityId)
end

function EventPreviewUnlockView:_onClickSwitchWorld()
	if self._isPlayAni then
		return
	end

	self._curShowWorld = not self._curShowWorld

	goutil.setActive(self._goWorldTableview, self._curShowWorld)
	goutil.setActive(self._goProgress, self._curShowWorld)

	if self._curShowWorld then
		GameUtil.setAnchoredPos(self._worldRoot, -65, -380)
		GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 180)
		self._tableviewWorld:reloadData(self._worldPrizeCfgs or {})
	else
		GameUtil.setAnchoredPos(self._worldRoot, 136, -380)
		GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 0)
	end
end

function EventPreviewUnlockView:_onClickShow(id)
	if self._isPlayAni then
		return
	end

	local isUnlock = id <= #self._unlockedIds

	if isUnlock then
		local isFirstShowKey = string.format("eventpreviewunlockview_%s_%s", self._activityId, id)

		GameUtil.saveUserData(isFirstShowKey, 1)
		UIStateManager.instance:push(ViewName.EventPreviewInfoView, self._activityId, id)

		local cell = self._cellShowList[id]

		if cell then
			goutil.setActive(cell.redpoint, false)
		end
	else
		FloatWordMgr.instance:show("暂未解锁，无法查看噢")
	end
end

return EventPreviewUnlockView
