-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarMainView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarMainView", package.seeall)

local GodStatuesWarMainView = class("GodStatuesWarMainView", ViewComponent)

function GodStatuesWarMainView:ctor()
	GodStatuesWarMainView.super.ctor(self)

	self._effPool = {}
end

function GodStatuesWarMainView:buildUI()
	GodStatuesWarMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._cannotFightTag = goutil.findChild(self.mainGO, "cannotFightTag")
	self._cannotFightTag_txtTime = goutil.findChildTextComponent(self.mainGO, "cannotFightTag/txtTime")
	self._goldCell_energy = goutil.findChild(self.mainGO, "goldCol/goldCell_energy")
	self._goldCell_energy_txt = goutil.findChildTextComponent(self.mainGO, "goldCol/goldCell_energy/txt")
	self._goldCell_tier = goutil.findChild(self.mainGO, "goldCol/goldCell_tier")
	self._goldCell_tier_txt = goutil.findChildTextComponent(self.mainGO, "goldCol/goldCell_tier/txt")
	self._goldCell_pillar = goutil.findChild(self.mainGO, "goldCol/goldCell_pillar")
	self._goldCell_pillar_txt = goutil.findChildTextComponent(self.mainGO, "goldCol/goldCell_pillar/txt")
	self._goldCell_nest = goutil.findChild(self.mainGO, "goldCol/goldCell_nest")
	self._goldCell_nest_txt = goutil.findChildTextComponent(self.mainGO, "goldCol/goldCell_nest/txt")
	self._pillarCol = goutil.findChild(self.mainGO, "pillarCol")
	self._pillarView = goutil.findChild(self.mainGO, "pillarCol/pillarView")
	self._pillarCell = goutil.findChild(self.mainGO, "pillarCol/pillarCell")

	GameUtil.SetActive(self._pillarCell, false)

	self._nestCol = goutil.findChild(self.mainGO, "nestCol")
	self._nestView = goutil.findChild(self.mainGO, "nestCol/nestView")
	self._nestCell = goutil.findChild(self.mainGO, "nestCol/nestCell")

	GameUtil.SetActive(self._nestCell, false)

	self._btnRank = goutil.findChild(self.mainGO, "leftBtnCol/btnRank")
	self._btnReport = goutil.findChild(self.mainGO, "leftBtnCol/btnReport")
	self._btnFmt = goutil.findChild(self.mainGO, "leftBtnCol/btnFmt")
	self._btnAdjust = goutil.findChild(self.mainGO, "leftBtnCol/btnAdjust")
	self._btnSeason = goutil.findChild(self.mainGO, "rightBtnCol/btnSeason")
	self._btnSign = goutil.findChild(self.mainGO, "rightBtnCol/btnSign")
end

function GodStatuesWarMainView:bindEvents()
	GodStatuesWarMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickBtnReport, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._btnAdjust, self._onClickBtnAdjust, self)
	GameUtil.addClickHandler(self._btnSeason, self._onClickBtnSeason, self)
	GameUtil.addClickHandler(self._btnSign, self._onClickBtnSign, self)
end

function GodStatuesWarMainView:unbindEvents()
	GodStatuesWarMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnSeason)
	GameUtil.rmClickHandler(self._btnSign)
end

function GodStatuesWarMainView:onEnter()
	GodStatuesWarMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		local text = string.format("不在开启期限内( seasonId = %d )", self._seasonId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._stepMgr = GodStatuesWarController.instance:gswStepMgrOnEnter(self._seasonId)
	self._isFamilyChief = GodStatuesWarController.instance:isFamilyChief()

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._updateMsgData, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleSetFlagRes, self._onUpdate, self)
	self:_onSetUI()
	self:_updateMsgData()
end

function GodStatuesWarMainView:onExit()
	GodStatuesWarMainView.super.onExit(self)
	self:_clearAllEff()
	self:_onClear()

	if self._stepMgr then
		GodStatuesWarController.instance:gswStepMgrOnExit(self._seasonId)

		self._stepMgr = nil
	end
end

function GodStatuesWarMainView:_updateMsgData()
	self._curStep = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	self._curStepInterval = GodStatuesWarController.instance:getStepInterval(self._seasonId, self._curStep)

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		GodStatuesWarController.instance:sendPM_NewFamilyBattleGetDivinePillarMapReq(self._seasonId)
	else
		self:_onUpdate()
	end
end

function GodStatuesWarMainView:_onSetUI()
	local array = string.split(self._seasonData.cannotFightTime, "#")
	local timeStartStr = string.split(array[1], ":")
	local timeEndStr = string.split(array[2], ":")

	self._cannotFightTag_txtTime.text = string.format("%s:%s-%s:%s", timeStartStr[1], timeStartStr[2], timeEndStr[1], timeEndStr[2])
end

function GodStatuesWarMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarMainView:_onUpdateData()
	return
end

function GodStatuesWarMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePillarColUI()
	self:_onUpdateNestColUI()
end

function GodStatuesWarMainView:_onClear()
	self:_onClearPillarCol()
	self:_onClearNestCol()
end

function GodStatuesWarMainView:_onUpdatePlaneUI()
	local maxTierCount = GodStatuesWarController.instance:getTierCount(self._seasonId)
	local curTierOfMy = GodStatuesWarController.instance:getMyFamilyCurTierInMap(self._seasonId)
	local leftTierOfMy = Mathf.Max(maxTierCount - curTierOfMy + 1, 0)

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		local rate = GodStatuesWarConfig.instance:getNfbParamsValue("ENERGY_INCREASE_RATE", true)
		local value = rate * leftTierOfMy

		self._goldCell_energy_txt.text = string.format("总生存能量：%s/分钟", value)

		GameUtil.SetActive(self._goldCell_energy, true)
	else
		GameUtil.SetActive(self._goldCell_energy, false)
	end

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		self._goldCell_tier_txt.text = leftTierOfMy > 0 and string.format("我方神柱：剩%s层", leftTierOfMy) or string.format("我方神柱：剩<color=#eb4624>%s</color>层", leftTierOfMy)

		GameUtil.SetActive(self._goldCell_tier, true)
	else
		GameUtil.SetActive(self._goldCell_tier, false)
	end

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		local left = GodStatuesWarController.instance:getLeftDivinePillarFightTime(self._seasonId, self._curStep)
		local max = GodStatuesWarController.instance:getMaxDivinePillarFightTime(self._seasonId, self._curStep)

		self._goldCell_pillar_txt.text = left > 0 and string.format("挑战神柱：<color=#20b376>%s</color>/%s", left, max) or string.format("挑战神柱：<color=#eb4624>%s</color>/%s", left, max)

		GameUtil.SetActive(self._goldCell_pillar, true)
	else
		GameUtil.SetActive(self._goldCell_pillar, false)
	end

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		local left = GodStatuesWarController.instance:getNestLeftFightTime(self._seasonId)
		local max = GodStatuesWarController.instance:getNestMaxFightTime(self._seasonId, self._curStep)

		self._goldCell_nest_txt.text = left > 0 and string.format("挑战巢穴：<color=#20b376>%s</color>/%s", left, max) or string.format("挑战巢穴：<color=#eb4624>%s</color>/%s", left, max)

		GameUtil.SetActive(self._goldCell_nest, true)
	else
		GameUtil.SetActive(self._goldCell_nest, false)
	end

	GameUtil.SetActive(self._btnAdjust, self._curStepInterval == GswEnum.StepInterval_Adj and self._isFamilyChief)
	GameUtil.SetActive(self._btnSign, self._isFamilyChief)

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		local isNotFightTime = GodStatuesWarController.instance:isNotFightTime(self._seasonId)

		GameUtil.SetActive(self._cannotFightTag, isNotFightTime)
	else
		GameUtil.SetActive(self._cannotFightTag, false)
	end
end

function GodStatuesWarMainView:_onUpdatePillarColUI()
	local cfg = GodStatuesWarConfig.instance:getNfbPillarEntryCfg(self._seasonId)

	GameUtil.updateCellsList(self._pillarView, self._pillarCell, cfg, self._updatePillarCell, self)
end

function GodStatuesWarMainView:_onClearPillarCol()
	GameUtil.clearCells(self._pillarView, self._clearPillarCell, self)
end

function GodStatuesWarMainView:_updatePillarCell(mainGo, data, index)
	local pillarId = data.pillarId
	local familyId = GodStatuesWarController.instance:getFamilyIdInGroup(self._seasonId, pillarId)
	local energyValue = GodStatuesWarController.instance:getEnergyInGroup(self._seasonId, pillarId)
	local familyName = GodStatuesWarController.instance:getFamilyNameInGroup(self._seasonId, pillarId)
	local isAttack = GodStatuesWarController.instance:isAttackFlagOfFamily(self._seasonId, familyId)
	local isNoAttack = GodStatuesWarController.instance:isNoAttackFlagOfFamily(self._seasonId, familyId)
	local isHaveFamily = not GodStatuesWarController.instance:isEmptyPillar(self._seasonId, pillarId)
	local imgPillar = goutil.findChild(mainGo, "imgPillar")
	local name = goutil.findChild(mainGo, "name")
	local name_txt = goutil.findChildTextComponent(mainGo, "name/txt")
	local energy = goutil.findChild(mainGo, "energy")
	local energy_txt = goutil.findChildTextComponent(mainGo, "energy/txt")
	local tagAttack = goutil.findChild(mainGo, "tagAttack")
	local tagNoAttack = goutil.findChild(mainGo, "tagNoAttack")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	if data.pos then
		local pos = data.pos

		if not pos[3] then
			local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, scale, scale, scale)
		end
	end

	if data.posParams and data.posParams.params then
		for _, v in ipairs(data.posParams.params) do
			local obj = goutil.findChild(mainGo, v.obj)
			local pos = v.pos

			if not pos[3] then
				local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

				GameUtil.setLocalPos(obj, x, y, 0)
				GameUtil.setLocalScale(obj, pos[3], pos[3], pos[3])
			end
		end
	end

	local path = "ui/bigbg/" .. data.smallIcon

	self:_loadBigBg(imgPillar, path, true)

	name_txt.text = self._curStepInterval == GswEnum.StepInterval_Bat and isHaveFamily and familyName or data.name

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		GameUtil.SetActive(name, isHaveFamily)
	else
		GameUtil.SetActive(name, true)
	end

	if self._curStepInterval == GswEnum.StepInterval_Bat and isHaveFamily then
		energy_txt.text = string.format("获取能量：%s", energyValue)

		GameUtil.SetActive(energy, true)
	else
		GameUtil.SetActive(energy, false)
	end

	if self._curStepInterval == GswEnum.StepInterval_Bat and isHaveFamily then
		local curEnergyStep = 0
		local pillarEnergySteps = GodStatuesWarConfig.instance:getNfbClientCommonValue(self._seasonId, "pillarEnergySteps")

		for idx, value in ipairs(pillarEnergySteps) do
			if checknumber(energyValue) >= checknumber(value) then
				curEnergyStep = idx
			else
				break
			end
		end

		local pathName = data.energyEffPaths[curEnergyStep]

		self:_loadEff(effRoot, pathName, true)
	else
		self:_unLoadEff(effRoot)
	end

	GameUtil.SetActive(tagAttack, isHaveFamily and isAttack)
	GameUtil.SetActive(tagNoAttack, isHaveFamily and isNoAttack)

	local img = imgPillar:GetComponent(ComponentType.Image)

	if img then
		img.raycastTarget = isHaveFamily
	end

	GameUtil.addClickHandler(imgPillar, GameUtil.handler(self._onClickPillarCell, self, pillarId))
end

function GodStatuesWarMainView:_clearPillarCell(mainGo)
	local imgPillar = goutil.findChild(mainGo, "imgPillar")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	GameUtil.rmClickHandler(imgPillar)
	self:_unLoadBigBg(imgPillar)
	self:_unLoadEff(effRoot)
end

function GodStatuesWarMainView:_onClickPillarCell(pillarId)
	local result, tips = GodStatuesWarController.instance:getTryEnterPillarInGswResultAndTips(self._seasonId, pillarId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarTowerView, self._seasonId, pillarId)
end

function GodStatuesWarMainView:_onUpdateNestColUI()
	local parentTran = self._nestView.transform
	local childGo = self._nestCell
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, self._curStep)
	local cfg = GodStatuesWarConfig.instance:getNfbNestCfg(stepData and stepData.nestPlanId)

	if cfg then
		if not #cfg then
			local length = 0

			if cfg then
				for idx, data in ipairs(cfg) do
					local mainGo = idx > parentTran.childCount and goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx)) or parentTran:GetChild(idx - 1)
					local pos = data.pos

					if not pos[3] then
						local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

						GameUtil.setLocalPos(mainGo, x, y, 0)
						GameUtil.setLocalScale(mainGo, pos[3], pos[3], pos[3])
						self:_updateNestCell(mainGo, stepData.nestPlanId, data.nestId)
					end
				end
			end

			for idx = 1, parentTran.childCount do
				local mainGo = parentTran:GetChild(idx - 1)

				if idx <= length then
					GameUtil.SetActive(mainGo, true)
				else
					self:_clearPartCell(mainGo)
					GameUtil.SetActive(mainGo, false)
				end
			end
		end
	end
end

function GodStatuesWarMainView:_onClearNestCol()
	local parentTran = self._nestView.transform

	for i = 1, parentTran.childCount do
		local trans = parentTran:GetChild(i - 1)

		self:_clearNestCell(trans.gameObject)
	end
end

function GodStatuesWarMainView:_updateNestCell(mainGo, nestPlanId, nestId)
	local nestData = GodStatuesWarConfig.instance:getNfbNestData(nestPlanId, nestId)
	local nestLeftFightTimes = GodStatuesWarController.instance:getNestLeftFightTime(self._seasonId)
	local imgNest = goutil.findChild(mainGo, "imgNest")
	local name = goutil.findChild(mainGo, "name")
	local name_txt = goutil.findChildTextComponent(mainGo, "name/txt")
	local clgTimes = goutil.findChild(mainGo, "clgTimes")
	local clgTimes_txt = goutil.findChildTextComponent(mainGo, "clgTimes/txt")

	self:_loadBigBg(imgNest, nestData.icon, true)

	name_txt.text = nestData.name

	if self._curStepInterval == GswEnum.StepInterval_Bat then
		clgTimes_txt.text = string.format("剩余次数：%s", nestLeftFightTimes)

		GameUtil.SetActive(clgTimes, true)
	else
		GameUtil.SetActive(clgTimes, false)
	end

	GameUtil.addClickHandler(imgNest, GameUtil.handler(self._onClickNestCell, self, nestPlanId, nestId))
end

function GodStatuesWarMainView:_clearNestCell(mainGo)
	local imgNest = goutil.findChild(mainGo, "imgNest")

	GameUtil.rmClickHandler(imgNest)
	self:_unLoadBigBg(imgNest)
end

function GodStatuesWarMainView:_onClickNestCell(nestPlanId, nestId)
	local result, tips = GodStatuesWarController.instance:getTryEnterNestInGswResultAndTips(self._seasonId, nestId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarNestView, self._seasonId, nestPlanId, nestId)
end

function GodStatuesWarMainView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function GodStatuesWarMainView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function GodStatuesWarMainView:_loadEff(effParent, pathName, isLoop, finishCallBack, loadedCallBack)
	self:_unLoadEff(effParent)

	if goutil.isNil(effParent) or string.nilorempty(pathName) then
		return
	end

	local path = pathName .. ".prefab"

	local function finishHandler(handlerTarget, eff)
		GameUtil.callBack(finishCallBack, handlerTarget, eff)
	end

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(effParent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true

		GameUtil.callBack(loadedCallBack, handlerTarget, eff)
	end

	local handlerTarget

	self._effPool[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, isLoop, false, finishHandler, loadedHandler, handlerTarget)
end

function GodStatuesWarMainView:_unLoadEff(effParent)
	UIEffectManager.instance:stopEffect(self._effPool[effParent])
end

function GodStatuesWarMainView:_clearAllEff()
	for k, v in pairs(self._effPool) do
		self:_unLoadEff(k)
	end
end

function GodStatuesWarMainView:_onClickBtnRank()
	local result, tips = GodStatuesWarController.instance:getTryOpenRankViewInGswResultAndTips(self._seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarTabFrameRankView, self._seasonId)
end

function GodStatuesWarMainView:_onClickBtnReport()
	local result, tips = GodStatuesWarController.instance:getTryOpenReportViewInGswResultAndTips(self._seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarReportView, self._seasonId)
end

function GodStatuesWarMainView:_onClickBtnFmt()
	local result, tips = GodStatuesWarController.instance:getTryOpenFmtViewInGswResultAndTips(self._seasonId)

	if result == GameEnum.ResultCode.Success then
		GodStatuesWarController.instance:enterGodStatuesWarAdvanceFmt(self._seasonId)
	elseif result == GameEnum.ResultCode.BeforeTime then
		local step = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
		local stepData = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, step)
		local fields = GodStatuesWarController.instance:getStepIntervalTimeFields(self._seasonId, step, GswEnum.StepInterval_Bat)
		local leftTime = GameUtil.FormatTimeSymbol(((fields or nil) and GameUtil.string2time(stepData[fields[1]])) - ServerTime.now())
		local text = string.format("距离开战剩余时间：%s", leftTime)

		local function func()
			return
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
	elseif result == GameEnum.ResultCode.AfterTime then
		FloatWordMgr.instance:show(tips)
	end
end

function GodStatuesWarMainView:_onClickBtnAdjust()
	local result, tips = GodStatuesWarController.instance:getTryOpenAdjustViewInGswResultAndTips(self._seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarTowerFmtAdjustView, self._seasonId)
end

function GodStatuesWarMainView:_onClickBtnSeason()
	GodStatuesWarController.instance:openCommonTabRankView(self._seasonId)
end

function GodStatuesWarMainView:_onClickBtnSign()
	local result, tips = GodStatuesWarController.instance:getTryOpenSignViewInGswResultAndTips(self._seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarTowerSignView, self._seasonId)
end

function GodStatuesWarMainView:_onClickBtnTip()
	UIStateManager.instance:push(ViewName.GodStatuesWarRuleView, self._seasonId)
end

return GodStatuesWarMainView
