-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/view/SaintKnightCardDrawView.lua

module("logic.extensions.saintknightcard.view.SaintKnightCardDrawView", package.seeall)

local SaintKnightCardDrawView = class("SaintKnightCardDrawView", ViewComponent)

function SaintKnightCardDrawView:buildUI()
	SaintKnightCardDrawView.super.buildUI(self)

	self._prizeCol = goutil.findChild(self.mainGO, "NormalUICol/prizeCol")
	self._normalPrizeView = goutil.findChild(self.mainGO, "NormalUICol/prizeCol/normalPrizeView")
	self._supperPrizeView = goutil.findChild(self.mainGO, "NormalUICol/prizeCol/supperPrizeView")
	self._bgEffParent = goutil.findChild(self.mainGO, "bgEffParent")
end

function SaintKnightCardDrawView:bindEvents()
	SaintKnightCardDrawView.super.bindEvents(self)
end

function SaintKnightCardDrawView:unbindEvents()
	SaintKnightCardDrawView.super.unbindEvents(self)
end

function SaintKnightCardDrawView:onEnter()
	SaintKnightCardDrawView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._drawPlanId = checknumber(params[2])
	self._groupId = checknumber(params[3])

	if self._activityId == 0 or self._drawPlanId == 0 or self._groupId == 0 then
		FloatWordMgr.instance:show("参数错误")
		self:close()

		return
	end

	ViewBlockMgr.instance:blockClick(true, self)
	self:_clearAlphaAnimPool()
	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightCardDrawRes, self._handleCardDrawRes, self)
	SaintKnightCardController.instance:sendSaintKnightCardDrawReq(self._activityId, self._drawPlanId, self._groupId)
end

function SaintKnightCardDrawView:onExit()
	SaintKnightCardDrawView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightCardDrawRes, self._handleCardDrawRes, self)
	self:_onClearPrizeColUI()
	UIEffectManager.instance:stopEffect(self._bgEff)
	removetimer(self._updateTime, self)
	removetimer(self._lightCell, self)
	ViewBlockMgr.instance:blockClick(false, self)
end

function SaintKnightCardDrawView:_handleCardDrawRes(status, msg)
	if status ~= 0 then
		self:close()

		return
	end

	self._isRatePrize = msg.isRatePrize == true

	self:_onUpdate()
	self:_playPrizeColAnim()
end

function SaintKnightCardDrawView:_onSetUI()
	local effParent = self._bgEffParent
	local pathName = "20220729/ui_shengqikaichoujiang_spine/ui_shengqikaichoujiang-ui_p"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function SaintKnightCardDrawView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SaintKnightCardDrawView:_onUpdateData()
	self:_onUpdatePrizeColData()
end

function SaintKnightCardDrawView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePrizeColUI()
end

function SaintKnightCardDrawView:_onUpdatePlaneUI()
	return
end

function SaintKnightCardDrawView:_onUpdatePrizeColData()
	local prizeData = SaintKnightCardConfig.instance:getSkcPrizeDataById(self._drawPlanId, self._groupId)
	local normalPrizeArray = string.split(prizeData.prize, "#")

	self._normalDataList = {}

	for _, prizeStr in ipairs(normalPrizeArray) do
		local data = {
			prizeStr = prizeStr
		}

		table.insert(self._normalDataList, data)
	end

	local supperPrizeArray = string.split(prizeData.ratePrize, "#")

	self._supperDataList = {}

	for _, prizeStr in ipairs(supperPrizeArray) do
		local data = {
			prizeStr = prizeStr
		}

		table.insert(self._supperDataList, data)
	end
end

function SaintKnightCardDrawView:_onUpdatePrizeColUI()
	self._normalCellGoList = self._updatePrizeView(self, self._normalPrizeView, self._normalDataList, self._updateNormalPrizeCell, self)
	self._supperCellGoList = self._updatePrizeView(self, self._supperPrizeView, self._supperDataList, self._updateSupperPrizeCell, self)
end

function SaintKnightCardDrawView:_updatePrizeView(viewGo, dataList, callBack, target, ...)
	local params = {
		...
	}
	local parent = viewGo.transform
	local cellGoList = {}

	for idx = 1, parent.childCount do
		local trans = parent:GetChild(idx - 1)
		local data = dataList[idx]

		if trans == nil then
			printError(string.format("预制不足( idx=%d, count=%d )", idx, #dataList))

			break
		end

		if data then
			callBack(target, trans.gameObject, data, unpack(params))
			table.insert(cellGoList, trans.gameObject)
		end

		GameUtil.SetActive(trans.gameObject, data ~= nil)
	end

	return cellGoList
end

function SaintKnightCardDrawView:_onClearPrizeColUI()
	self._clearPrizeView(self, self._normalPrizeView, self._clearNormalPrizeCell, self)
	self._clearPrizeView(self, self._supperPrizeView, self._clearSupperPrizeCell, self)
end

function SaintKnightCardDrawView:_clearPrizeView(viewGo, callBack, target)
	local parent = viewGo.transform

	for idx = 1, parent.childCount do
		local trans = parent:GetChild(idx - 1)

		if trans == nil then
			break
		end

		callBack(target, trans.gameObject)
	end
end

function SaintKnightCardDrawView:_updateNormalPrizeCell(mainGo, data)
	local selectGo = goutil.findChild(mainGo, "selectGo")
	local prizeIcon = goutil.findChild(mainGo, "prizeIcon")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prizeStr)

	MaterialMgr.setIcon(prizeIcon, matType, matId, nil, nil)
	GameUtil.setLocalScale(mainGo, 1, 1, 1)
	GameUtil.SetActive(selectGo, false)
end

function SaintKnightCardDrawView:_clearNormalPrizeCell(mainGo)
	local prizeIcon = goutil.findChild(mainGo, "prizeIcon")

	MaterialMgr.clearIcon(prizeIcon)
end

function SaintKnightCardDrawView:_updateSupperPrizeCell(mainGo, data)
	local selectGo = goutil.findChild(mainGo, "selectGo")
	local prizeIcon = goutil.findChild(mainGo, "prizeIcon")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prizeStr)

	MaterialMgr.setIcon(prizeIcon, matType, matId, nil, nil)
	GameUtil.setLocalScale(mainGo, 1, 1, 1)
	GameUtil.SetActive(selectGo, false)
end

function SaintKnightCardDrawView:_clearSupperPrizeCell(mainGo)
	local prizeIcon = goutil.findChild(mainGo, "prizeIcon")

	MaterialMgr.clearIcon(prizeIcon)
end

function SaintKnightCardDrawView:_playFloatAnim(go)
	self:_clearAnimByObj(go)

	self._tweenPool[go] = go.transform:DOShakePosition(2, Vector3.New(60, 60, 60), 1, 45, true):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
end

function SaintKnightCardDrawView:_playExplodeAnim(go, duration)
	self:_clearAnimByObj(go)
	GameUtil.setLocalScale(go, 1, 1, 1)

	self._tweenPool[go] = go.transform:DOScale(1.4, duration):SetEase(DG.Tweening.Ease.OutBounce)
end

function SaintKnightCardDrawView:_clearAlphaAnimPool()
	if self._tweenPool ~= nil then
		for _, tween in pairs(self._tweenPool) do
			self:_clearAnimByTween(tween)
		end
	end

	self._tweenPool = {}
end

function SaintKnightCardDrawView:_clearAnimByTween(tween)
	if tween == nil then
		return
	end

	tween:Kill(true)
end

function SaintKnightCardDrawView:_clearAnimByObj(obj)
	self:_clearAnimByTween(self._tweenPool[obj])
end

function SaintKnightCardDrawView:_playPrizeColAnim()
	ViewBlockMgr.instance:blockClick(true, self)

	self._normalCellList = {}
	self._supperCellList = {}
	self._allCellList = {}

	for _, go in ipairs(self._normalCellGoList) do
		local cell = {}

		cell._mainGo = go
		cell._selectGo = goutil.findChild(go, "selectGo")

		table.insert(self._normalCellList, cell)
		table.insert(self._allCellList, cell)
	end

	for _, go in ipairs(self._supperCellGoList) do
		local cell = {}

		cell._mainGo = go
		cell._selectGo = goutil.findChild(go, "selectGo")

		table.insert(self._supperCellList, cell)
		table.insert(self._allCellList, cell)
	end

	self._interval = 0.01
	self._sumInr = 0
	self._startInr = 0.05
	self._endInr = 0.35
	self._limitInr = 0
	self._cellCount = #self._allCellList
	self._curStepCount = -1

	local targetIdx = 0

	targetIdx = self._isRatePrize and #self._normalCellGoList + #self._supperCellGoList or Mathf.Random(1, #self._normalCellGoList)

	if self._cellCount > 0 then
		if not (20 % self._cellCount) then
			local j = 0

			self._totalStepCount = 20 - j + targetIdx - 1

			removetimer(self._updateTime, self)
			settimer(self._interval, self._updateTime, self, true)
		end
	end
end

function SaintKnightCardDrawView:_updateTime()
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

function SaintKnightCardDrawView:_playEndAnim()
	self._lightTimes = 0
	self._totalLightTimes = 4
	self._isLight = false

	local deltaTime = 0.5

	self._endCellList = nil
	self._endCellList = self._isRatePrize and self._supperCellList or self._normalCellList

	self:_clearAlphaAnimPool()

	for _, cell in ipairs(self._endCellList) do
		self:_playExplodeAnim(cell._mainGo, self._totalLightTimes * deltaTime)
	end

	removetimer(self._lightCell, self)
	settimer(deltaTime, self._lightCell, self, true)
end

function SaintKnightCardDrawView:_lightCell()
	for _, cell in ipairs(self._endCellList) do
		GameUtil.SetActive(cell._selectGo, self._isLight)
	end

	self._isLight = not self._isLight
	self._lightTimes = self._lightTimes + 1

	if self._lightTimes > self._totalLightTimes then
		removetimer(self._lightCell, self)
		self:_endDraw()
	end
end

function SaintKnightCardDrawView:_endDraw()
	ViewBlockMgr.instance:blockClick(false, self)

	if self._isRatePrize then
		FloatWordMgr.instance:show("恭喜您抽中大奖！")
	end

	local changeSetId = SaintKnightCardModel.instance:getDrawChangeSetId()

	MaterialController.instance:showChangeSetInTemp(changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.SaintKnightCardDrawAnimEnd)
	self:close()
end

return SaintKnightCardDrawView
