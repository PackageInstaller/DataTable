-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalkingsignin/view/SurvivalKingSignInView.lua

module("logic.extensions.survivalkingsignin.view.SurvivalKingSignInView", package.seeall)

local SurvivalKingSignInView = class("SurvivalKingSignInView", ViewComponent)

function SurvivalKingSignInView:ctor()
	SurvivalKingSignInView.super.ctor(self)
end

function SurvivalKingSignInView:unbindEvents()
	SurvivalKingSignInView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)

	for i, btn in ipairs(self._btnSignIns) do
		GameUtil.rmClickHandler(btn)
	end
end

function SurvivalKingSignInView:bindEvents()
	SurvivalKingSignInView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, btn in ipairs(self._btnSignIns) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickSignIn, self, i))
	end
end

function SurvivalKingSignInView:buildUI()
	SurvivalKingSignInView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtProgress = self:getTxt("progress/txtProgress")

	local goCellDaily = self:getGo("progress/dailyprize/cell")
	local goTableviewDaily = self:getGo("progress/dailyprize/tableview")

	self._tableviewDaily = ScrollerList.create(goTableviewDaily, goCellDaily, GameUtil.handler(self._updateCellDaily, self), GameUtil.handler(self._clearCellDaily, self))

	local goCellFinal = self:getGo("finalprize/cell")
	local goTableviewFinal = self:getGo("finalprize/tableview")

	self._tableviewFinal = ScrollerList.create(goTableviewFinal, goCellFinal, GameUtil.handler(self._updateCellFinal, self), GameUtil.handler(self._clearCellFinal, self))
	self._btnSignIns = {}
	self._showMaps = {}

	for i = 1, 7 do
		self._btnSignIns[i] = self:getGo(string.format("btnSignIns/btn_%d", i))
		self._showMaps[i] = self:getGo(string.format("progress/showMaps/map%d", i))
	end
end

function SurvivalKingSignInView:onExit()
	SurvivalKingSignInView.super.onExit(self)
	self._tableviewDaily:dispose()
	self._tableviewFinal:dispose()
end

function SurvivalKingSignInView:onEnter()
	SurvivalKingSignInView.super.onEnter(self)

	self._activityId = 530001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self.addGEvent(self, GlobalNotify.PM_SurvivalKingSignInInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_SurvivalKingSignInRes, self._handleSignIn, self)
	self.addGEvent(self, GlobalNotify.PM_SurvivalKingSignInGainPrizeRes, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SurvivalKingSignInController.instance:getInfo(self._activityId)
end

function SurvivalKingSignInView:_updateUIByCfg()
	self._prizeItemStrsDaily = {}
	self._prizeItemsStrFinal = {}
	self._actCfg = SurvivalKingSignInConfig.instance:getSignInActivityCfg(self._activityId)
	self._zoneCfgs = SurvivalKingSignInConfig.instance:getAllZoneCfgs(self._activityId) or {}

	if self._actCfg then
		local firstZoneCfg = self._zoneCfgs[1]

		if firstZoneCfg then
			if not firstZoneCfg.prize then
				local signInPrize = ""

				self._prizeItemStrsDaily = string.split(signInPrize, "#")

				if not self._actCfg.finishPrize then
					self._prizeItemsStrFinal = string.split(self._actCfg.finishPrize, "#")
				end
			end
		end
	end

	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function SurvivalKingSignInView:_updateUIByInfo()
	self._isDailySignIn = false
	self._curProgress = 0
	self._gainedPrize = false
	self._hasSignZoneIds = {}

	local info = SurvivalKingSignInModel.instance:getBaseInfo(self._activityId)

	if info then
		self._isDailySignIn = info.dailySignIn or false
		self._gainedPrize = info.gainedPrize or false

		if not info.zoneIds then
			local zoneIds = {}

			for _, id in ipairs(zoneIds) do
				self._hasSignZoneIds[id] = true
			end

			self._curProgress = #zoneIds
		end
	end

	self._txtProgress.text = string.format("当前已收集：<color=#ffbf7d>%d</color>/%d", self._curProgress, #self._zoneCfgs)

	self._tableviewDaily:reloadData(self._prizeItemStrsDaily)
	self._tableviewFinal:reloadData(self._prizeItemsStrFinal)

	for i, btn in ipairs(self._btnSignIns) do
		goutil.setActive(btn, not self._hasSignZoneIds[i])
	end

	for i, map in ipairs(self._showMaps) do
		goutil.setActive(map, not self._hasSignZoneIds[i])
	end
end

function SurvivalKingSignInView:_onClickTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function SurvivalKingSignInView:_onClickSignIn(id)
	if self._isDailySignIn then
		TipsFacade.instance:openCommonTips("今日已签到")

		return
	end

	if self._hasSignZoneIds[id] then
		TipsFacade.instance:openCommonTips("该区域已签到")

		return
	end

	if self._curProgress >= #self._zoneCfgs then
		TipsFacade.instance:openCommonTips("已完成全部签到")

		return
	end

	SurvivalKingSignInController.instance:signIn(self._activityId, id)
end

function SurvivalKingSignInView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("finalprize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function SurvivalKingSignInView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function SurvivalKingSignInView:_updateCellDaily(view, cell, data)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local geted = goutil.findChild(go, "geted")

	goutil.setActive(geted, self._isDailySignIn)
	MaterialMgr.setCellByCfg(data, item)
end

function SurvivalKingSignInView:_clearCellDaily(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	MaterialMgr.resetAll(item)
end

function SurvivalKingSignInView:_updateCellFinal(view, cell, data)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local geted = goutil.findChild(go, "geted")
	local effect = goutil.findChild(go, "effect")
	local btnGet = goutil.findChild(go, "btnGet")

	goutil.setActive(geted, false)
	goutil.setActive(btnGet, false)
	self:_clearCellEffect(effect)

	if self._gainedPrize then
		goutil.setActive(geted, true)
	elseif self._curProgress >= #self._zoneCfgs then
		goutil.setActive(btnGet, true)
		self:_playCellEffect(effect)
		GameUtil.addClickHandler(btnGet, function()
			SurvivalKingSignInController.instance:gainPrize(self._activityId)
		end, self)
	else
		self:_clearCellEffect(goutil.findChild(go, "effect"))
	end

	MaterialMgr.setCellByCfg(data, item)
end

function SurvivalKingSignInView:_clearCellFinal(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local btnGet = goutil.findChild(go, "btnGet")
	local effect = goutil.findChild(go, "effect")

	GameUtil.rmClickHandler(btnGet)
	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
end

function SurvivalKingSignInView:_handleSignIn()
	self:_updateUIByInfo()
end

return SurvivalKingSignInView
