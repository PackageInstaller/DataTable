-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardDrawView.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardDrawView", package.seeall)

local FreeScuffleCardDrawView = class("FreeScuffleCardDrawView", ViewComponent)

function FreeScuffleCardDrawView:ctor()
	FreeScuffleCardDrawView.super.ctor(self)

	self._defaultScales = {}
	self._tweenPool = {}
end

function FreeScuffleCardDrawView:buildUI()
	FreeScuffleCardDrawView.super.buildUI(self)

	self._uiRoot = self:getGo("uiRoot")
	self._prizeView = self:getGo("uiRoot/prizeView")
	self._prizeCell = self:getGo("uiRoot/prizeCell")
	self._btnStart = self:getGo("uiRoot/btnStart")
	self._box = self:getGo("uiRoot/box")
	self._boxEffRoot = self:getGo("boxEffRoot")
	self._btnContinue = self:getGo("uiRoot/btnContinue")

	GameUtil.SetActive(self._prizeCell, false)
end

function FreeScuffleCardDrawView:bindEvents()
	FreeScuffleCardDrawView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnContinue, self._onClickBtnContinue, self)
end

function FreeScuffleCardDrawView:unbindEvents()
	FreeScuffleCardDrawView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnContinue)
end

function FreeScuffleCardDrawView:onEnter()
	FreeScuffleCardDrawView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._poolId = 0

	GameUtil.SetActive(self._uiRoot, false)
	GameUtil.SetActive(self._btnStart, false)
	GameUtil.SetActive(self._box, true)
	GameUtil.SetActive(self._boxEffRoot, false)
	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleRandomEventLotteryRes, self._handlePM_FreeScuffleRandomEventLotteryRes, self)
	self:addGEvent(GlobalNotify.ItemGetViewDoClosed, self._itemGetViewDoClosed)

	local function finishHandle(handlerTarget, eff)
		GameUtil.SetActive(self._uiRoot, true)
		FreeScuffleController.instance:sendPM_FreeScuffleRandomEventLotteryReq(self._activityId)
	end

	self:playViewEffectUniGo("20250627/ziyouluandou/fx_ui_zyld_xingdong.prefab", self._lotteryEffRoot, nil, false, finishHandle, nil)
end

function FreeScuffleCardDrawView:onExit()
	FreeScuffleCardDrawView.super.onExit(self)
	self:_clearAlphaAnimPool()
	self:_onClearPrizeColUI()
	removetimer(self._updateTime, self)
	removetimer(self._lightCell, self)
	GlobalDispatcher:dispatch(GlobalNotify.FreeScuffleFinishLotteryEvent)
end

function FreeScuffleCardDrawView:_handlePM_FreeScuffleRandomEventLotteryRes(status, msg)
	if status ~= 0 then
		self:close()

		return
	end

	self._poolId = msg.poolId
	self._changeSetId = nil

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		self._changeSetId = msg.changeSetId
	end

	self:_onUpdatePrizeColUI()
	GameUtil.SetActive(self._btnStart, true)
end

function FreeScuffleCardDrawView:_itemGetViewDoClosed()
	self:close()
end

function FreeScuffleCardDrawView:_onUpdatePrizeColUI()
	local cfg = FreeScuffleConfig.instance:getPoolCfg(self._activityId) or {}

	self._prizeCellGoList = GameUtil.updateCellsList(self._prizeView, self._prizeCell, cfg, self._updatePrizeCell, self)
end

function FreeScuffleCardDrawView:_onClearPrizeColUI()
	GameUtil.clearCells(self._prizeView, self._clearPrizeCell, self)
end

function FreeScuffleCardDrawView:_updatePrizeCell(mainGo, data, tabIdx)
	local selectGo = goutil.findChild(mainGo, "selectGo")
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.setUIImageSpriteIdx(icon, data.quality - 1)
	GameUtil.SetActive(selectGo, false)

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pos[3])

			self._defaultScales[mainGo] = data.pos[3]
		end
	end
end

function FreeScuffleCardDrawView:_clearPrizeCell(mainGo)
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)

	self._defaultScales[mainGo] = nil
end

function FreeScuffleCardDrawView:_playExplodeAnim(go, duration)
	self:_clearAnimByObj(go)

	if not self._defaultScales[go] then
		GameUtil.setLocalScale(go, self._defaultScales[go])

		self._tweenPool[go] = go.transform:DOScale(1.4, duration):SetEase(DG.Tweening.Ease.OutBounce)
	end
end

function FreeScuffleCardDrawView:_clearAlphaAnimPool()
	if self._tweenPool then
		for obj, tween in pairs(self._tweenPool) do
			self:_clearAnimByObj(obj)
		end
	end
end

function FreeScuffleCardDrawView:_clearAnimByObj(obj)
	local tween = self._tweenPool[obj]

	if tween then
		tween:Kill(true)

		self._tweenPool[obj] = nil
	end
end

function FreeScuffleCardDrawView:_playPrizeColAnim(targetIdx)
	self._targetIdx = targetIdx
	self._allCellList = {}

	for _, go in ipairs(self._prizeCellGoList) do
		local cell = {}

		cell._mainGo = go
		cell._selectGo = goutil.findChild(go, "selectGo")

		table.insert(self._allCellList, cell)
	end

	self._interval = 0.01
	self._sumInr = 0
	self._startInr = 0.05
	self._endInr = 0.35
	self._limitInr = 0
	self._cellCount = #self._allCellList
	self._curStepCount = -1

	if self._cellCount > 0 then
		if not (20 % self._cellCount) then
			local j = 0

			self._totalStepCount = 20 - j + self._targetIdx - 1

			removetimer(self._updateTime, self)
			settimer(self._interval, self._updateTime, self, true)
		end
	end
end

function FreeScuffleCardDrawView:_updateTime()
	self._sumInr = self._sumInr + self._interval

	if self._sumInr < self._limitInr then
		return
	end

	self._sumInr = 0
	self._curStepCount = self._curStepCount + 1

	local stepIdx = self._curStepCount % self._cellCount + 1
	local t = self._curStepCount / self._totalStepCount - 0.5

	self._limitInr = Mathf.SmoothStep(self._startInr, self._endInr, t)

	for idx, cell in ipairs(self._allCellList) do
		GameUtil.SetActive(cell._selectGo, stepIdx == idx)
	end

	if self._curStepCount >= self._totalStepCount then
		removetimer(self._updateTime, self)
		self:_playEndAnim()

		return
	end
end

function FreeScuffleCardDrawView:_playEndAnim()
	self._lightTimes = 0
	self._totalLightTimes = 4
	self._isLight = false

	local deltaTime = 0.5

	self._endCellList = {}

	table.insert(self._endCellList, self._allCellList[self._targetIdx])
	self:_clearAlphaAnimPool()

	for _, cell in ipairs(self._endCellList) do
		self:_playExplodeAnim(cell._mainGo, self._totalLightTimes * deltaTime)
	end

	removetimer(self._lightCell, self)
	settimer(deltaTime, self._lightCell, self, true)
end

function FreeScuffleCardDrawView:_lightCell()
	for _, cell in ipairs(self._endCellList) do
		GameUtil.SetActive(cell._selectGo, self._isLight)
	end

	self._isLight = not self._isLight
	self._lightTimes = self._lightTimes + 1

	if self._lightTimes > self._totalLightTimes then
		removetimer(self._lightCell, self)
		self:_showBoxOpenEff()
	end
end

function FreeScuffleCardDrawView:_showBoxOpenEff()
	GameUtil.SetActive(self._box, false)
	GameUtil.SetActive(self._boxEffRoot, true)

	local function finishHandle(handlerTarget, eff)
		self:_endDraw()
	end

	self:playViewEffectUniGo("20250627/ziyouluandou/fx_ui_zyld_choujiang.prefab", self._boxEffRoot, nil, false, finishHandle, nil)
end

function FreeScuffleCardDrawView:_endDraw()
	GameUtil.SetActive(self._uiRoot, false)
	GameUtil.SetActive(self._boxEffRoot, false)
	removetimer(self._updateTime, self)
	removetimer(self._lightCell, self)

	if self._changeSetId ~= nil then
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)
	else
		self:close()
	end
end

function FreeScuffleCardDrawView:_onClickBtnStart()
	self:_playPrizeColAnim(self._poolId)
	GameUtil.SetActive(self._btnStart, false)
end

function FreeScuffleCardDrawView:_onClickBtnContinue()
	self:_endDraw()
end

return FreeScuffleCardDrawView
