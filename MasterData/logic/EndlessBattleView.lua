-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessBattleView.lua

module("logic.extensions.endlessbattle.view.EndlessBattleView", package.seeall)

local EndlessBattleView = class("EndlessBattleView", ViewComponent)

function EndlessBattleView:ctor()
	EndlessBattleView.super.ctor(self)

	self._degrees = {}
	self._txtDegrees = {}
end

function EndlessBattleView:unbindEvents()
	EndlessBattleView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnNormalExt:RemoveClickListener()
	self._btnFirstExt:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
end

function EndlessBattleView:bindEvents()
	EndlessBattleView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnNormalExt:AddClickListener(function()
		self:_onClickExt(true)
	end)
	self._btnFirstExt:AddClickListener(function()
		self:_onClickExt(false)
	end)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
end

function EndlessBattleView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "endlessbattle")
end

function EndlessBattleView:buildUI()
	EndlessBattleView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._arrow = self:getGo("arrow")

	goutil.setActive(self._arrow, false)

	self._btnRank = self:getBtn("btnRank")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "topCanvas/txtLeftTime")
	self._btnStart = self:getBtn("topCanvas/btnStart")
	self._txtStart = goutil.findChildTextComponent(self._btnStart.gameObject, "Text")
	self._btnNormalExt = self:getBtn("topCanvas/normalPrize/btnExt")
	self._btnFirstExt = self:getBtn("topCanvas/firstPrize/btnExt")
	self._rolePoint = self:getGo("rolePoint")
	self._gridFirstPrize = self:getGo("topCanvas/firstPrize/Grid")
	self._gridNormalPrize = self:getGo("topCanvas/normalPrize/Grid")
	self._txtLeftTime.text = ""
	self._btnRule = self:getBtn("topleft/btnRule")
	self._progress = self:getGo("progress"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._degrees = GameUtil.getChildren(self:getGo("degrees"))
	self._arrow = self:getGo("progress/handle/arrow")
	self._canvas = goutil.findChildComponent(self.mainGO, "topCanvas", typeof(UnityEngine.Canvas))

	local canvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._canvas.sortingOrder = canvas.sortingOrder + 10
	self._btnSweep = self:getBtn("topCanvas/btnSweep")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._doubleGo = self:getGo("topCanvas/btnStart/doubleGo")

	GameUtil.SetActive(self._doubleGo, false)
end

function EndlessBattleView:onEnter()
	EndlessBattleView.super.onEnter(self)
	EndlessBattleController.instance:infiniteFightInfoReq()

	self._txtLeftTime.text = ""

	self:_setEffectUrls()
	self:_createEffs()
	self._btnOneKey.gameObject:SetActive(false)
	self._btnSweep.gameObject:SetActive(true)
	GlobalDispatcher:addListener(GlobalNotify.InfiniteSweepRes, self._onSweepRes, self)
	GlobalDispatcher:addListener(GlobalNotify.InfiniteInfoRes, self._onInfoRes, self)
end

function EndlessBattleView:_onInfoRes()
	self:_updateUI()
	self:_updateOneKey()
end

function EndlessBattleView:_createEffs()
	self._effs = {}

	for _, v in ipairs(self._effPaths) do
		self:_playEffect(v.path, (not string.nilorempty(v.goPath) or nil) and self:getGo(v.goPath), true)
	end
end

function EndlessBattleView:_playEffect(url, parent, loop)
	local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, loop)

	eff:setParent(parent.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setLocalEulerAngle(0, 0, 0)
	table.insert(self._effs, eff)
end

function EndlessBattleView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "",
			path = "fx_ui_wujinshilian/fx_ui_wujinshilian_mianban.prefab"
		}
	}
end

function EndlessBattleView:onExit()
	EndlessBattleView.super.onExit(self)

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)

		self._role = nil
	end

	removetimer(self._onTick, self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = nil

	GlobalDispatcher:removeListener(GlobalNotify.InfiniteSweepRes, self._onSweepRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.InfiniteInfoRes, self._onInfoRes, self)
end

function EndlessBattleView:_updateUI()
	self._dailyState = EndlessBattleModel.instance:getDailyState()

	local curWaveId = EndlessBattleModel.instance:getCurWaveId()
	local cfgs = EndlessBattleConfig.instance:getStageCfgsByWaveId(curWaveId)
	local maxStateId = EndlessBattleModel.instance:getDailyMaxStage()
	local stageId = EndlessBattleConfig.instance:getConstantValue("OPEN_SWEEP_STAGE_ID")
	local realMaxStage = EndlessBattleModel.instance:getMaxStageId()

	self._btnSweep.gameObject:SetActive(realMaxStage >= checknumber(stageId))

	self._txtStart.text = maxStateId > 0 and maxStateId >= cfgs[1].stageId and maxStateId < cfgs[#cfgs].stageId and "重新开始" or "开始"

	self:_setEndTime()
	self:_updateRole()
	self:_drawDegreeNew()
	self:_updatePrizes()
	self:_onTick()
	self:_isShowDoubleGo()
	settimer(1, self._onTick, self, true)
end

local startWaveId, endWaveId

function EndlessBattleView:_updateOneKey()
	self._btnOneKey.gameObject:SetActive(false)

	local myZdl = RoleModel.instance:getMaxPower()
	local curStageId = EndlessBattleModel.instance:getMaxStageId()
	local nextStageCfg = EndlessBattleConfig.instance:getStageCfgById(curStageId + 1)
	local isAllPassed = nextStageCfg == nil

	if isAllPassed then
		return
	end

	local curWaveId = EndlessBattleModel.instance:getCurWaveId()
	local waveCfg = EndlessBattleConfig.instance:getWaveCfg(curWaveId)

	startWaveId, endWaveId = nil

	while waveCfg do
		if myZdl >= waveCfg.oneKeyPassZdl then
			endWaveId = waveId
			startWaveId = startWaveId or curWaveId
			endWaveId = curWaveId
		end

		curWaveId = curWaveId + 1
		waveCfg = EndlessBattleConfig.instance:getWaveCfg(curWaveId)
	end

	print("startWaveId = " .. tostring(startWaveId) .. "endWaveId = " .. tostring(endWaveId))

	if startWaveId and EndlessBattleModel.instance:getNeedShowOneKey() then
		self:_onClickOneKey()
	end
end

function EndlessBattleView:_onClickStart()
	local stageId = checknumber(EndlessBattleConfig.instance:getConstantValue("OPEN_SWEEP_STAGE_ID"))
	local curStageId = EndlessBattleModel.instance:getMaxStageId()
	local canSweep = stageId <= curStageId

	self._dailyState = EndlessBattleModel.instance:getDailyState()

	if self._dailyState == 2 then
		FloatWordMgr.instance:show("今日已经扫荡过了哦，不能再战斗了~")
	elseif self._dailyState == 0 and canSweep then
		local title = lang("挑战")
		local text = lang("领取战斗奖励后，今日无法再使用扫荡，是否开始战斗？\n提示：提前退出战斗，仍可使用扫荡功能。")
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openPopupWindow(title, text, function()
			UIStateManager.instance:push(ViewName.EBMissionView)
		end, nil, nil, nil, alignment)
	else
		UIStateManager.instance:push(ViewName.EBMissionView)
	end
end

function EndlessBattleView:_onClickSweep()
	local stageId = EndlessBattleConfig.instance:getConstantValue("OPEN_SWEEP_STAGE_ID")
	local curStageId = EndlessBattleModel.instance:getMaxStageId()
	local stageCfg = EndlessBattleConfig.instance:getStageCfgById(checknumber(stageId))

	if stageCfg and curStageId < checknumber(stageId) then
		local cfgs = EndlessBattleConfig.instance:getStageCfgsByWaveId(stageCfg.waveId)
		local idx = 0

		for k, v in ipairs(cfgs) do
			if v.stageId == stageCfg.stageId then
				idx = k

				break
			end
		end

		local text = langPara("通关无尽试炼第%d波第%d场次开启扫荡功能", stageCfg.waveId, idx)

		FloatWordMgr.instance:show(text)

		return
	end

	self._dailyState = EndlessBattleModel.instance:getDailyState()

	if self._dailyState == 2 then
		FloatWordMgr.instance:show("今天已经扫荡过了哦~")
	elseif self._dailyState == 1 then
		FloatWordMgr.instance:show("今日已领取战斗奖励，无法再进行扫荡。")
	elseif self._dailyState == 0 then
		local title = lang("扫荡")
		local text = lang("可扫荡已通关的最高波数，使用扫荡后，今日将无法继续战斗，是否开始扫荡?\n提示：通关更高波数，可获得更高奖励。")
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openPopupWindow(title, text, function()
			EndlessBattleController.instance:sendSweepReq()
		end, nil, nil, nil, alignment)
	else
		print("invalid dailyState = " .. tostring(self._dailyState))
	end
end

function EndlessBattleView:_onSweepRes()
	FloatWordMgr.instance:show("扫荡成功~")
	self._btnOneKey.gameObject:SetActive(false)
end

function EndlessBattleView:_onClickOneKey()
	if not startWaveId then
		return
	end

	local needStageId = checknumber(EndlessBattleConfig.instance:getConstantValue("OPEN_ONE_KEY_PASS_STAGE_ID"))
	local maxStageId = EndlessBattleModel.instance:getMaxStageId()

	if maxStageId < needStageId then
		return
	end

	if self._dailyState == 2 then
		return
	end

	local text = "第" .. startWaveId

	if startWaveId ~= endWaveId then
		text = string.format("%d-%d", startWaveId, endWaveId)
	end

	SurveyController.instance:reportBehavior(200434)
	UIStateManager.instance:push(ViewName.EndlessPopView, text, self._onOneKeyRes, self)
end

function EndlessBattleView:_onOneKeyRes()
	self:_updateUI()
end

function EndlessBattleView:_setEndTime()
	local now = ServerTime.nowDateServerLook()
	local endDay = now.day

	if now.hour >= 5 then
		endDay = endDay + 1
	end

	self._endTime = GameUtil.date2time(now.year, now.month, endDay, 5, 0, 0)
end

function EndlessBattleView:_updateRole()
	local raceId = 10167
	local object = CharactorFacade.instance
	local displayBagOffset = self._showLihui and object:getHandbookLihuiModelUIPosAndScale(raceId) or object:getHandbookModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._rolePoint, scale, nil, true, x, y)
end

function EndlessBattleView:_updatePrizes()
	local curWaveId = EndlessBattleModel.instance:getCurWaveId()
	local waveCfg = EndlessBattleConfig.instance:getWaveCfg(curWaveId)
	local mats = {}

	if waveCfg and not string.nilorempty(waveCfg.firstPassPrize) then
		mats = string.split(waveCfg.firstPassPrize, "#")
	end

	self._firstPrizes = self._firstPrizes or {}

	self:_updateSinglePrize(self._firstPrizes, self._gridFirstPrize, mats)

	local stageCfgs = EndlessBattleConfig.instance:getStageCfgsByWaveId(curWaveId)
	local dic = {}

	for _, v in ipairs(stageCfgs) do
		local mats = string.split(v.dailyPrize, "#")

		for _, v2 in ipairs(mats) do
			local matType, matId, _ = unpack(string.splitToNumber(v2, ":"))
			local key = string.format("%d:%d", matType, matId)

			dic[key] = true
		end
	end

	local mats = {}

	for k, v in pairs(dic) do
		if v == true then
			table.insert(mats, k)
		end
	end

	self._normalPrizes = self._normalPrizes or {}

	self:_updateSinglePrize(self._normalPrizes, self._gridNormalPrize, mats)
end

function EndlessBattleView:_updateSinglePrize(cacheItemList, parent, mats)
	local i = 1

	while i <= #mats do
		local cell

		if i < #cacheItemList then
			cell = cacheItemList[i]
		else
			cell = goutil.create("cell")

			goutil.addChildToParent(cell, parent.transform)
			Framework.TransformUtil.SetLocalScale(cell.transform, 1, 1, 1)
			table.insert(cacheItemList, cell)
		end

		MaterialMgr.setCellByCfg(mats[i], cell)
		goutil.setActive(cell, true)

		i = i + 1
	end

	while i <= #cacheItemList do
		MaterialMgr.resetAll(cacheItemList[i])
		goutil.setActive(cacheItemList[i], false)

		i = i + 1
	end
end

local originProgress = {
	[0] = 0.02,
	0.052,
	0.082,
	0.112,
	0.142,
	0.176,
	0.212,
	0.242,
	0.272,
	0.302,
	0.336,
	0.371,
	0.401,
	0.431,
	0.461,
	0.494,
	0.528,
	0.558,
	0.588,
	0.618,
	0.652,
	0.687,
	0.717,
	0.747,
	0.777,
	0.811,
	0.845,
	0.875,
	0.905,
	0.935,
	1
}

function EndlessBattleView:_drawDegreeNew()
	local maxShowWaves = 6
	local curStageId = EndlessBattleModel.instance:getMaxStageId()
	local curWaveId = EndlessBattleModel.instance:getCurWaveId()
	local waveCfgList = EndlessBattleConfig.instance:getWaveCfgs()
	local maxCount = #waveCfgList
	local head = curWaveId - math.ceil(maxShowWaves / 2)
	local tail = curWaveId + math.ceil(maxShowWaves / 2) - 1

	if head < 1 then
		tail = math.min(maxCount, tail + 1 - head)
		head = 1
	end

	if maxCount < tail then
		head = math.max(1, head + maxCount - tail)
		tail = maxCount
	end

	for k, v in ipairs(self._degrees) do
		local textDegree = v:GetComponent(goutil.Type_UIText)
		local image = goutil.findChild(v, "Image")
		local waveId = head + k - 1

		goutil.setActive(v, waveId <= tail)

		textDegree.text = waveId

		goutil.setActive(image, k > 1 and waveId <= curWaveId)
	end

	local key = curStageId - (head - 1) * 5

	if key < 0 then
		key = 0
	elseif key > 30 then
		key = 30
	end

	if key % 5 == 0 then
		Framework.TransformUtil.SetLocalPos(self._arrow.transform, 0, 30, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._arrow.transform, 0, 0, 0)
	end

	self._progress.value = originProgress[key]

	local stageCfgList = EndlessBattleConfig.instance:getStageCfgs()

	goutil.setActive(self._arrow, curStageId ~= stageCfgList[#stageCfgList].stageId)
end

function EndlessBattleView:_getDegree()
	local degree = self._degrees[self._counter]

	self._counter = self._counter + 1

	if degree == nil then
		degree = goutil.cloneAndSetParent(self._cloneCell, self._cloneCell.transform.parent)

		table.insert(self._degrees, degree)
	end

	goutil.setActive(degree, true)

	return degree
end

function EndlessBattleView:_getTextDegree()
	local txtDegree = self._txtDegrees[self._counter2]

	self._counter2 = self._counter2 + 1

	if txtDegree == nil then
		txtDegree = goutil.clone(self._cloneTextDegree.gameObject, "TextDegree")
		txtDegree = txtDegree:GetComponent(goutil.Type_UIText)

		table.insert(self._txtDegrees, txtDegree)
	end

	goutil.setActive(txtDegree.gameObject, true)

	return txtDegree
end

function EndlessBattleView:_onTick()
	if self._endTime == nil then
		return
	end

	local leftTime = self._endTime - ServerTime.now()

	self._txtLeftTime.text = string.format("%02d:%02d:%02d后刷新", math.floor(leftTime / 3600), leftTime / 60 % 60, leftTime % 60)

	if leftTime <= 0 then
		leftTime = 0

		removetimer(self._onTick, self)
		EndlessBattleController.instance:infiniteFightInfoReq(function()
			self:_updateUI()
			FloatWordMgr.instance:show("5点刷新成功~")
		end)
	end
end

function EndlessBattleView:_onClickExt(isNormal)
	UIStateManager.instance:open(ViewName.EndlessPrize, isNormal)
end

function EndlessBattleView:_isShowDoubleGo()
	local isOpen = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.EndlessAttack)

	GameUtil.SetActive(self._doubleGo, isOpen)
end

return EndlessBattleView
