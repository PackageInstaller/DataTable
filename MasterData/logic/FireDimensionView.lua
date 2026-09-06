-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/view/FireDimensionView.lua

module("logic.extensions.firedimension.view.FireDimensionView", package.seeall)

local FireDimensionView = class("FireDimensionView", ViewComponent)

function FireDimensionView:ctor()
	FireDimensionView.super.ctor(self)
end

function FireDimensionView:buildUI()
	FireDimensionView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")

	local sprintInfoGo = self:getGo("petInfo")

	self._sprintRareGo = goutil.findChild(sprintInfoGo, "pointRare")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "btnSkill")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "btnIntroduce")
	self._txtPetName = goutil.findChildTextComponent(sprintInfoGo, "txtName")
	self._txtTime = self:getTxt("time/txt")
	self._buffRoot = self:getGo("buffRoot")
	self._btnCultivate = self:getBtn("jumpButton/btnCultivate")
	self._btnExchange = self:getBtn("jumpButton/btnExchange")
	self._btnRank = self:getBtn("jumpButton/btnRank")
	self._btnShenYao = self:getBtn("jumpButton/btnShenYao")
	self._btns = {}
	self._items = {}

	for i = 1, 3 do
		self._btns[i] = self:getBtn("btn" .. tostring(i))

		local item = {}

		item.txtName = self:getTxt(string.format("btn%d/txtName", i))
		item.prizeGo = self:getGo(string.format("btn%d/layout/item", i))
		item.txtDesc = MaterialMgr.findGraphicText(self.mainGO, string.format("btn%d/layout/item/txt", i))
		item.lock = self:getGo(string.format("btn%d/lock", i))
		item.pass = self:getGo(string.format("btn%d/pass", i))
		item.redPoint = self:getGo(string.format("btn%d/redpoint", i))

		table.insert(self._items, item)
	end

	self._jumpButtonsGo = self:getGo("jumpButton")
	self._timeGo = self:getGo("time")
end

function FireDimensionView:bindEvents()
	FireDimensionView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._skillBtn:AddClickListener(self._onClickSkill, self)
	self._introduceBtn:AddClickListener(self._onClickIntroduce, self)
	self._btnCultivate:AddClickListener(self._onClickCultivate, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnShenYao:AddClickListener(self._onClickShenYao, self)

	for i = 1, 3 do
		self._btns[i]:AddClickListener(function()
			self:_onClickStage(i)
		end, self)
	end
end

function FireDimensionView:unbindEvents()
	FireDimensionView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	self._btnCultivate:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnShenYao:RemoveClickListener()

	for i = 1, 3 do
		self._btns[i]:RemoveClickListener()
	end
end

function FireDimensionView:onEnter()
	FireDimensionView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FireDimensionClgInfoRes, self._onFireDimensionClgInfoRes, self)
	FireDimensionController.instance:setCurRoot(self._viewPresentor.viewName)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 274001
	end

	self._activityType = FireDimensionModel.instance:getActivityType()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()

	self._cfgActivity = FireDimensionConfig.instance:getActivityCfg(self._activityId)
	self._raceId = self._cfgActivity.raceId

	FireDimensionChallengeAgent.instance:sendPM_FireDimensionClgInfoReq(self._activityId)
	self:_playEffect()
	self:_showPetInfo()
	self:_showActivityTime()
	self:_initBtnInfos()
end

function FireDimensionView:_initAoqiGodUI()
	GameUtil.SetActive(self._jumpButtonsGo, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._timeGo, not self._isAoqiGodProcessType)

	for i = 1, 3 do
		GameUtil.SetActive(self._items[i].prizeGo, not self._isAoqiGodProcessType)
	end
end

function FireDimensionView:onExit()
	FireDimensionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FireDimensionClgInfoRes, self._onFireDimensionClgInfoRes, self)
	self:_clearPetInfo()
	self:_clearEffect()
end

function FireDimensionView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._cfgActivity.ruleTip)
end

function FireDimensionView:_onClickSkill()
	PetbookController.instance:previewBattle(self._raceId)
end

function FireDimensionView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function FireDimensionView:_onClickCultivate()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function FireDimensionView:_onClickExchange()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function FireDimensionView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function FireDimensionView:_onClickShenYao()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo4)
end

function FireDimensionView:_onClickStage(index)
	local cfg = FireDimensionConfig.instance:getBigStageCfg(self._activityId, index)
	local openTimestamp = GameUtil.string2time(cfg.openTime)

	if openTimestamp > ServerTime.now() then
		local date = GameUtil.time2date(openTimestamp)

		FloatWordMgr.instance:show(string.format("%02d.%02d 05:00 开启", date.month, date.day))

		return
	end

	if FireDimensionModel.instance:isStageLock(self._activityId, index) then
		FloatWordMgr.instance:show("请先通过上一关卡")

		return
	end

	if FireDimensionModel.instance:isStagePass(self._activityId, index) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local stageId = index

	UIStateManager.instance:push(self:getLevelViewName(), self._activityId, stageId)
	GameUtil.saveUserDayData(self._viewPresentor.viewName .. self._activityId .. stageId, true)
end

function FireDimensionView:_onFireDimensionClgInfoRes()
	self:_updateBtnInfos()
end

function FireDimensionView:_showPetInfo()
	MaterialMgr.setCell(MatType.Rare, self._raceId, self._sprintRareGo)

	self._txtPetName.text = MaterialMgr.getMaterialsName(MatType.Rare, self._raceId)
end

function FireDimensionView:_clearPetInfo()
	MaterialMgr.resetAll(self._sprintRareGo)
end

function FireDimensionView:_showActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function FireDimensionView:_initBtnInfos()
	local curTimestamp = ServerTime.now()

	for stageId, v in ipairs(self._items) do
		local cfgStage = FireDimensionConfig.instance:getBigStageCfg(self._activityId, stageId)

		if cfgStage then
			v.txtName.text = cfgStage.stageName
			v.txtDesc.text = cfgStage.desc

			local cfg = FireDimensionConfig.instance:getBigStageCfg(self._activityId, stageId)
			local openTimestamp = GameUtil.string2time(cfg.openTime)
			local isLock = FireDimensionModel.instance:isStageLock(self._activityId, stageId) or curTimestamp < openTimestamp
			local isPass = FireDimensionModel.instance:isStagePass(self._activityId, stageId)

			goutil.setActive(v.lock, isLock)
			goutil.setActive(v.pass, isPass)

			local isMarked = GameUtil.getUserDayData(self._viewPresentor.viewName .. self._activityId .. stageId)

			goutil.setActive(v.redPoint, not isLock and not isPass and not isMarked)
		end
	end
end

function FireDimensionView:_updateBtnInfos()
	local curTimestamp = ServerTime.now()

	for stageId, v in ipairs(self._items) do
		local cfgStage = FireDimensionConfig.instance:getBigStageCfg(self._activityId, stageId)

		if cfgStage then
			local openTimestamp = GameUtil.string2time(cfgStage.openTime)
			local isLock = FireDimensionModel.instance:isStageLock(self._activityId, stageId) or curTimestamp < openTimestamp
			local isPass = FireDimensionModel.instance:isStagePass(self._activityId, stageId)

			goutil.setActive(v.lock, isLock)
			goutil.setActive(v.pass, isPass)

			local isMarked = GameUtil.getUserDayData(self._viewPresentor.viewName .. self._activityId .. stageId)

			goutil.setActive(v.redPoint, not isLock and not isPass and not isMarked)
		end
	end
end

function FireDimensionView:_playEffect()
	self._eff = UIEffectManager.instance:playEffect(self, self:_getMainEffect(), self.mainGO.transform, 0, 0, true)

	self._eff:setParent(self.mainGO.transform)
	self._eff:setLocalPos(243.5, -35.7, 0)
	self._eff:setScale(1)
end

function FireDimensionView:_clearEffect()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function FireDimensionView:getLevelViewName()
	return FireDimensionController.instance:getView("level")
end

function FireDimensionView:_getMainEffect()
	return FireDimensionViewPresentor.Effect1
end

return FireDimensionView
