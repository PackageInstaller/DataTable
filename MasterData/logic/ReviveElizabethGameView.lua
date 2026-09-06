-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethGameView.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethGameView", package.seeall)

local ReviveElizabethGameView = class("ReviveElizabethGameView", ViewComponent)

function ReviveElizabethGameView:ctor()
	ReviveElizabethGameView.super.ctor(self)

	self.clickTimer = 0
end

function ReviveElizabethGameView:unbindEvents()
	ReviveElizabethGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGainSeed)
	GameUtil.rmClickHandler(self._btnBack)
end

function ReviveElizabethGameView:bindEvents()
	ReviveElizabethGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnGainSeed, self._onClickBtnGainSeed, self)
	GameUtil.addClickHandler(self._btnBack, self._onClickBtnBack, self)
end

function ReviveElizabethGameView:buildUI()
	ReviveElizabethGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnGainSeed = self:getGo("btnGainSeed")
	self._btnBack = self:getGo("btnBack")
	self._btnGainSeedRp = self:getGo("btnGainSeed/redpoint")
	self._txtdailyFlower = self:getGo("dailyFlower/txt"):GetComponent(typeof(UnityEngine.UI.Text))
	self._txtdailyField = self:getGo("dailyField/txt"):GetComponent(typeof(UnityEngine.UI.Text))
	self._txtTarget = self:getGo("target/txt"):GetComponent(typeof(UnityEngine.UI.Text))
	self._seedIcon = self:getGo("seedItem/icon")
	self._seedNum = self:getTxt("seedItem/txt")
	self._fields = {}

	for i = 1, 9 do
		local cell = {}

		cell.field = self:getGo("fieldRoot/field_" .. i .. "/img")
		cell.seed = self:getGo("fieldRoot/field_" .. i .. "/seed")
		cell.water = self:getGo("fieldRoot/field_" .. i .. "/water")
		cell.weed = self:getGo("fieldRoot/field_" .. i .. "/weed")
		cell.tipSeed = self:getGo("fieldRoot/field_" .. i .. "/seed/tip/txt"):GetComponent(typeof(UnityEngine.UI.Text))
		cell.tipWater = self:getGo("fieldRoot/field_" .. i .. "/water/tip/txt"):GetComponent(typeof(UnityEngine.UI.Text))
		cell.tipWeed = self:getGo("fieldRoot/field_" .. i .. "/weed/tip/txt"):GetComponent(typeof(UnityEngine.UI.Text))
		cell.timesWater = self:getGo("fieldRoot/field_" .. i .. "/water/times/txt"):GetComponent(typeof(UnityEngine.UI.Text))
		cell.timesWeed = self:getGo("fieldRoot/field_" .. i .. "/weed/times/txt"):GetComponent(typeof(UnityEngine.UI.Text))
		cell.effectSeed = self:getGo("fieldRoot/field_" .. i .. "/effectSeed")
		cell.effectWater = self:getGo("fieldRoot/field_" .. i .. "/effectWater")
		cell.effectWeed = self:getGo("fieldRoot/field_" .. i .. "/effectWeed")

		table.insert(self._fields, cell)
	end
end

function ReviveElizabethGameView:onExit()
	ReviveElizabethGameView.super.onExit(self)

	if self._fields[self._curSeedFieldId] then
		GameUtil.rmClickHandler(self._fields[self._curSeedFieldId].seed)
	end

	MaterialMgr.resetAll(self._seedIcon)
	RedPointController.instance:unregRedPoint(self._btnGainSeedRp)
end

function ReviveElizabethGameView:onEnter()
	ReviveElizabethGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ReviveElizabethGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._refreshSeedNum, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		printError("界面打开失败，请检查传递的参数是否正确。")
		self:close()
	end

	self._cfg = ReviveElizabethConfig.instance:getActivityCfg(self._activityId)

	RedPointController.instance:regRedPoint(self._btnGainSeedRp, "c35")

	local matType, matId, _ = MaterialMgr.getMatParams(self._cfg.seedingMp)

	self._matType = matType
	self._matId = matId

	MaterialMgr.setIcon(self._seedIcon, self._matType, self._matId)
	self:_refreshSeedNum()
	self:_refresh()
end

function ReviveElizabethGameView:_refresh()
	self._info = ReviveElizabethModel.instance:getInfo(self._activityId)
	self._todayWaterTimes = checknumber(self._info.todayWaterTimes)
	self._todayWeedTimes = checknumber(self._info.todayWeedTimes)

	local seededCount = checknumber(self._info.seededCount)

	self._fieldWaterMaxTimes = self._cfg.fieldWaterMaxTimes
	self._fieldWeedMaxTimes = self._cfg.fieldWeedMaxTimes
	self._seedAddProgress = self._cfg.seedAddProgress
	self._waterAddProgress = self._cfg.waterAddProgress
	self._weedAddProgress = self._cfg.weedAddProgress
	self._needWater = false
	self._needWeed = false
	self._curFieldId = 1

	local flowerCount = 0

	if seededCount > 0 then
		for i = 1, seededCount do
			local fieldWaterTime = self._info.fieldWaterTimes[i]
			local fieldWeedTime = self._info.fieldWeedTimes[i]

			if fieldWaterTime >= self._fieldWaterMaxTimes and fieldWeedTime >= self._fieldWeedMaxTimes then
				if seededCount < self._curFieldId + 1 then
					self._curFieldId = self._curFieldId or self._curFieldId + 1
				end
			end

			flowerCount = flowerCount + self._seedAddProgress + self._waterAddProgress * fieldWaterTime + self._weedAddProgress * fieldWeedTime
		end

		self._needWater = self._info.fieldWaterTimes[self._curFieldId] < self._fieldWaterMaxTimes
		self._needWeed = self._info.fieldWeedTimes[self._curFieldId] < self._fieldWeedMaxTimes

		if not self._needWater and not self._needWeed then
			self._curFieldId = self._curFieldId + 1
		end
	end

	self._curSeedFieldId = seededCount + 1
	self._txtdailyFlower.text = string.format("花海每天可产出：<color=#F8D200FF>%d</color>/%d朵鲜花", flowerCount, self._cfg.flowerMaxProgress)
	self._txtdailyField.text = string.format("今日浇水次数：%d/%d，除草次数：%d/%d", self._todayWaterTimes, self._cfg.dailyWaterTimes, self._todayWeedTimes, self._cfg.dailyWeedTimes)
	self._txtTarget.text = string.format("每片花田在经过%d次浇水、%d次除草后达到最大产量", self._fieldWaterMaxTimes, self._fieldWeedMaxTimes)

	self:_refreshField()
	print("[YuTestPrint] =====>\t refresh finish! self._curFieldId = ", self._curFieldId)
end

function ReviveElizabethGameView:_refreshField()
	self:clearField()

	for fieldId, cell in ipairs(self._fields) do
		if fieldId < self._curFieldId then
			goutil.setActive(cell.field, true)
		elseif fieldId == self._curFieldId then
			goutil.setActive(cell.water, self._needWater)
			goutil.setActive(cell.weed, self._needWeed)
			GameUtil.addClickHandler(cell.water, self._onClickBtnWater, self)
			GameUtil.addClickHandler(cell.weed, self._onClickBtnWeed, self)

			local fieldWaterTime = checknumber(self._info.fieldWaterTimes[fieldId])
			local fieldWeedTime = checknumber(self._info.fieldWeedTimes[fieldId])

			cell.tipWater.text = string.format("+%d鲜花", self._waterAddProgress)
			cell.tipWeed.text = string.format("+%d鲜花", self._weedAddProgress)
			cell.timesWater.text = string.format("%d/%d", fieldWaterTime, self._fieldWaterMaxTimes)
			cell.timesWeed.text = string.format("%d/%d", fieldWeedTime, self._fieldWeedMaxTimes)
		end

		if fieldId == self._curSeedFieldId then
			goutil.setActive(cell.seed, true)
			GameUtil.addClickHandler(cell.seed, self._onClickBtnSeed, self)

			cell.tipSeed.text = string.format("+%d鲜花", self._seedAddProgress)
		end
	end

	if self._curFieldId > #self._fields then
		GameUtil.saveUserData(ReviveElizabethController.DataKey .. "AllFieldPass", true)
	end
end

function ReviveElizabethGameView:clearField()
	for i, cell in ipairs(self._fields) do
		goutil.setActive(cell.field, false)
		goutil.setActive(cell.seed, false)
		goutil.setActive(cell.water, false)
		goutil.setActive(cell.weed, false)
		GameUtil.rmClickHandler(cell.seed)
		GameUtil.rmClickHandler(cell.water)
		GameUtil.rmClickHandler(cell.weed)
	end
end

function ReviveElizabethGameView:_refreshSeedNum()
	local count = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)

	self._seedNum.text = string.format("%d", count)
end

function ReviveElizabethGameView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("reviveelizabethmainview_rule")
end

function ReviveElizabethGameView:_onClickBtnSeed()
	local matType, matId, needSeedCount = MaterialMgr.getMatParams(self._cfg.seedingMp)
	local seedCount = MaterialMgr.getMatCount(self._cfg.seedingMp)

	if seedCount < needSeedCount then
		FloatWordMgr.instance:show("花种数量不足，请前往获取")
		MaterialMgr.openGetSource(matType, matId)

		return
	end

	self:_unloadEffect(self._effectSeed)

	self._effectSeed = self:_loadEffect(self._fields[self._curSeedFieldId].effectSeed, ReviveElizabethController.SeedEffectUrl)

	ReviveElizabethAgent:sendPM_ReviveElizabethHandleFieldReq(self._activityId, self._curSeedFieldId, 1)
end

function ReviveElizabethGameView:_onClickBtnWater()
	if self._todayWaterTimes >= self._cfg.dailyWaterTimes then
		FloatWordMgr.instance:show("已达今日浇水上限")

		return
	end

	if not self._needWater then
		FloatWordMgr.instance:show("该花田已达浇水次数上限")

		return
	end

	if not self:PreventTooFastClick() then
		return
	end

	self:_unloadEffect(self._effectWater)

	self._effectWater = self:_loadEffect(self._fields[self._curFieldId].effectWater, ReviveElizabethController.WaterEffectUrl)

	ReviveElizabethAgent:sendPM_ReviveElizabethHandleFieldReq(self._activityId, self._curFieldId, 2)
end

function ReviveElizabethGameView:_onClickBtnWeed()
	if self._todayWeedTimes >= self._cfg.dailyWeedTimes then
		FloatWordMgr.instance:show("已达今日除草上限")

		return
	end

	if not self._needWeed then
		FloatWordMgr.instance:show("该花田已达除草次数上限")

		return
	end

	if not self:PreventTooFastClick() then
		return
	end

	self:_unloadEffect(self._effectWeed)

	self._effectWeed = self:_loadEffect(self._fields[self._curFieldId].effectWeed, ReviveElizabethController.WeedEffectUrl)

	ReviveElizabethAgent:sendPM_ReviveElizabethHandleFieldReq(self._activityId, self._curFieldId, 3)
end

function ReviveElizabethGameView:_onClickBtnGainSeed()
	local matType, matId, needSeedCount = MaterialMgr.getMatParams(self._cfg.seedingMp)

	if checknumber(matType) <= 0 or checknumber(matId) <= 0 then
		return
	end

	MaterialMgr.openGetSource(matType, matId)
	RedPointController.instance:saveUserDayRedPoint("c35")
end

function ReviveElizabethGameView:_onClickBtnBack()
	UIStateManager.instance:push(ViewName.ReviveElizabethMainView, self._viewPresentor.viewName, true)
end

function ReviveElizabethGameView:_loadEffect(root, effectPath, rectTrans)
	local effect = UIEffectManager.instance:playEffect(self, effectPath, root.transform, 0, 0, false, false)

	effect:setParent(root.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	return effect
end

function ReviveElizabethGameView:_unloadEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

function ReviveElizabethGameView:PreventTooFastClick(isTips)
	if self.clickTimer == 0 then
		self.clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self.clickTimer < 1 then
			return
		end

		self.clickTimer = now
	end

	return true
end

return ReviveElizabethGameView
