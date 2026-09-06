-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjimixView.lua

module("logic.extensions.kingjichallenge.view.KingjimixView", package.seeall)

local KingjimixView = class("KingjimixView", ViewComponent)

function KingjimixView:ctor()
	KingjimixView.super.ctor(self)
end

function KingjimixView:unbindEvents()
	KingjimixView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()

	for i, v in ipairs(self._formations) do
		GameUtil.rmClickHandler(v.btnCollect)
		GameUtil.rmClickHandler(v.btnEnter)
	end
end

function KingjimixView:bindEvents()
	KingjimixView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
end

function KingjimixView:buildUI()
	KingjimixView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._tabcellGo = self:getGo("left/tabcell")
	self._tableviewGo = self:getGo("left/tableview")
	self._tabScrollerList = ScrollerList.create(self._tableviewGo, self._tabcellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self:_buildFormations()

	self._txtCollect = self:getTxt("rule/txtCollect")
	self._txtDesc = self:getTxt("rule/txtDesc")
	self._rewardconGo = self:getGo("rule/rewardcon")
	self._singleLine = self:getGo("rule/rewardcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._rewardcellGo = self:getGo("rule/rewardcell")

	goutil.setActive(self._rewardcellGo, false)

	self._itemGroup = ItemGroup.New(self._rewardconGo, self._rewardcellGo, nil, nil, true, self._disposeRewardCell, self)
	self._levelRewardBg = self:getGo("rule/img_clone4")
	self._levelRewardBg2 = self:getGo("rule/img")
	self._txtLevelGo = self:getGo("rule/txt")
end

function KingjimixView:_buildFormations()
	self._formations = {}

	local root = self:getGo("formation")

	for i = 1, 3 do
		local go = goutil.findChild(root, "formation" .. i)

		self._formations[i] = {
			cformation = CFormation.New(go),
			cformationMo = CFormationMo.New(),
			passGo = goutil.findChild(go, "pass"),
			btnCollect = goutil.findChild(go, "btnCollect"),
			btnEnter = goutil.findChild(go, "btnEnter")
		}
	end
end

function KingjimixView:onExit()
	KingjimixView.super.onExit(self)
	self._tabScrollerList:dispose()

	for i, v in ipairs(self._formations) do
		v.cformation:onExit()
	end

	MaterialMgr.resetAll(self._rewardconGo)

	if not self._isAoqiGodProcessType then
		self._itemGroup:dispose()
	end
end

function KingjimixView:onEnter()
	KingjimixView.super.onEnter(self)
	self.addGEvent(self, KingJiChallengeAgent.KingJiChallengeResetRes, self._updateLeft, self)
	self.addGEvent(self, KingJiChallengeAgent.KingJiChallengeGainPrizeRes, self._gainRes, self)
	self.addGEvent(self, KingJiChallengeAgent.KingJiChallengeSaveResultRes, self._saveResultRes, self)

	self._activityId = KingjichallengeModel.instance:getActivityId()
	self._activityCfg = KingjichallengeConfig.instance:getActivityCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_setStageId()
	self:_updateUI()
	self:_checkSaveOp()
end

function KingjimixView:_onClickbtnClose()
	self:close()
end

function KingjimixView:_onClickbtnTip()
	local key = self._activityCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function KingjimixView:_onClickbtnReset()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local isPass = KingjichallengeController.instance:isMixStagePass(self._stageId)

	if isPass then
		FloatWordMgr.instance:show("已完成本关挑战，不需要重置")

		return
	end

	local info = KingjichallengeModel.instance:getInfo()

	if not info then
		return
	end

	for i, v in ipairs(info.mixInfo.stageList) do
		print(i, v)
	end

	local content = "是否将所有关卡重置为未挑战状态，解锁被锁定的精灵？"

	TipsFacade.instance:openPopupWindow("提示", content, function()
		KingJiChallengeAgent.instance:sendPM_KingJiChallengeResetReq(self._activityId, self._stageId)
	end)
end

function KingjimixView:_updateUI()
	self:_updateLeft()
	self:_updateAoqiUI()
end

function KingjimixView:_updateLeft()
	local cfgs = KingjichallengeConfig.instance:getMixStageCfgs(self._activityId)

	self._tabScrollerList:reloadData(cfgs)
	self:_updateFormations()
	self:_updateBottom()
end

function KingjimixView:_updateAoqiUI()
	GameUtil.SetActive(self._levelRewardBg, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._levelRewardBg2, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._txtLevelGo, not self._isAoqiGodProcessType)
end

function KingjimixView:_updateTabCell(view, cell, data, tag)
	local text = goutil.findChildTextComponent(cell, "text")
	local changeGroup = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local passGo = goutil.findChild(cell, "pass")
	local isPass = KingjichallengeController.instance:isMixStagePass(data.stageId)
	local isGainPrize = KingjichallengeController.instance:isGainPrize(data.stageId, GameEnum.KingjiChallengeType.Ronghe)

	goutil.setActive(passGo, isPass and isGainPrize)

	text.text = string.format("第%s战", data.stageId)

	changeGroup:SetState(self._stageId == data.stageId and 0 or 1)
end

function KingjimixView:_clearTabCell(cell)
	return
end

function KingjimixView:_updateBottom()
	self:_updateRule()

	if not self._isAoqiGodProcessType then
		self:_updateReward()
	end

	self:_updateCollect()
end

function KingjimixView:_updateRule()
	local cfg = KingjichallengeConfig.instance:getMixStageCfg(self._activityId, self._stageId)

	self._txtDesc.text = cfg.rule
end

function KingjimixView:_updateReward()
	local cfg = KingjichallengeConfig.instance:getMixStageCfg(self._activityId, self._stageId)
	local rewards = string.split(cfg.stagePrize, "#")
	local isCanGain = KingjichallengeController.instance:isCanGet(self._stageId, GameEnum.KingjiChallengeType.Ronghe)
	local isGain = KingjichallengeController.instance:isGainPrize(self._stageId, GameEnum.KingjiChallengeType.Ronghe)

	self._itemGroup:updateWithMoArray(rewards, function(item, cfgStr)
		local con = goutil.findChild(item.mainGO, "con")
		local effectGo = goutil.findChild(item.mainGO, "effect")
		local receiveGo = goutil.findChild(item.mainGO, "receive")

		goutil.setActive(receiveGo, isGain)
		self:_clearEffect(effectGo)
		MaterialMgr.resetAll(con)

		local proxy = MaterialMgr.setCellByCfg(cfgStr, con)

		proxy.binder:setAutoTips(not isCanGain)

		if isCanGain then
			proxy.binder:setCallBack(function()
				if self._isAoqiGodProcessType then
					local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

					if result ~= GameEnum.ResultCode.Success then
						return
					end
				end

				KingJiChallengeAgent.instance:sendPM_KingJiChallengeGainPrizeReq(self._activityId, GameEnum.KingjiChallengeType.Ronghe, self._stageId)
			end)
			self:_playEffect(effectGo)
		else
			proxy.binder:setCallBack(nil)
		end
	end)
	self._singleLine:Layout()
end

function KingjimixView:_disposeRewardCell(item)
	local con = goutil.findChild(item.mainGO, "con")
	local effectGo = goutil.findChild(item.mainGO, "effect")

	MaterialMgr.resetAll(con)
	self:_clearEffect(effectGo)
end

function KingjimixView:_updateCollect()
	local cfgs = KingjichallengeConfig.instance:getMixStagePlanCfgs(self._activityId, self._stageId)
	local data = {}

	for i, cfg in ipairs(cfgs) do
		local num = KingjichallengeController.instance:getMixCollectNum(self._stageId, cfg.attribute)

		if num >= cfg.needCount then
			if not GameEnum.ColorConst.Green then
				local color = GameEnum.ColorConst.Red
				local str = string.format("收集:%s个 <color=#FFF3ADFF>%s元素</color>  （<color=%s>%s</color>/%s）", cfg.needCount, cfg.attribute, color, num, cfg.needCount)

				table.insert(data, str)
			end
		end
	end

	self._txtCollect.text = table.concat(data, "\n")
end

function KingjimixView:_updateFormations()
	local masterIds = KingjichallengeConfig.instance:getMixStageCreepsMasterIds(self._activityId, self._stageId)

	for i, creepsMasterId in ipairs(masterIds) do
		local formation = self._formations[i]
		local cfgs = KingjichallengeConfig.instance:getCreepMonstersCfgs(creepsMasterId)
		local mo = formation.cformationMo

		mo:setRaceIdByCreepsCfgs(cfgs)
		formation.cformation:onEnter(mo)

		local isPass = KingjichallengeController.instance:isMixCreepPass(self._stageId, creepsMasterId)

		goutil.setActive(formation.passGo, isPass)
		GameUtil.addClickHandler(formation.btnCollect, GameUtil.handler(self._onClickBtnCollect, self, creepsMasterId))
		GameUtil.addClickHandler(formation.btnEnter, GameUtil.handler(self._onClickBtnEnter, self, creepsMasterId, isPass))
	end
end

function KingjimixView:_onClickBtnCollect(creepsMasterId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.KingjimixcollectView, self._stageId, creepsMasterId)
end

function KingjimixView:_onClickBtnEnter(creepsMasterId, isPass)
	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	KingjichallengeController.instance:enterMission(GameEnum.KingjiChallengeType.Ronghe, self._stageId, creepsMasterId)
end

function KingjimixView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect

	uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function()
		uiEffect:setClipping(self.mainGO.transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function KingjimixView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function KingjimixView:_gainRes()
	local nextStageId = self._stageId + 1
	local autoNext = false
	local cfg = KingjichallengeConfig.instance:getMixStageCfg(self._activityId, nextStageId)

	if cfg then
		local isPass = KingjichallengeController.instance:isMixStagePass(nextStageId)

		if not isPass then
			autoNext = true
		end
	end

	if autoNext then
		self:_setStageId(true)
		self:_updateLeft()
	else
		self:_updateBottom()
	end
end

function KingjimixView:_checkSaveOp()
	local data = KingjichallengeController.instance:getMixSaveMsg()

	if not data then
		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if data.stageId == self._stageId then
		UIStateManager.instance:push(ViewName.KingjimixcollectView, data.stageId, data.passCreepsMasterIds, true)
	end
end

function KingjimixView:_setStageId(force)
	if force then
		self._stageId = nil
	end

	if not self._isAoqiGodProcessType then
		if not self._stageId then
			local cfgs = KingjichallengeConfig.instance:getMixStageCfgs(self._activityId)

			for i, cfg in ipairs(cfgs) do
				if not KingjichallengeController.instance:isGainPrize(cfg.stageId, GameEnum.KingjiChallengeType.Ronghe) then
					local openTime = GameUtil.string2time(cfg.openTime)

					if openTime <= ServerTime.now() then
						self._stageId = cfg.stageId

						break
					end

					self._stageId = cfg.stageId - 1

					break
				end
			end

			if not self._stageId then
				self._stageId = cfgs[#cfgs].stageId
			elseif self._stageId <= 0 then
				self._stageId = 1
			end
		end
	else
		local cfgs = KingjichallengeConfig.instance:getMixStageCfgs(self._activityId)

		self._stageId = 1

		for i = 1, #cfgs do
			local pass = KingjichallengeController.instance:isMixStagePass(self._stageId)

			if not pass then
				break
			end

			if self._stageId + 1 <= #cfgs then
				self._stageId = self._stageId + 1 or #cfgs
			end
		end
	end
end

function KingjimixView:_saveResultRes()
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		local ronghePass = KingjichallengeController.instance:isChallengePass(GameEnum.KingjiChallengeType.Ronghe)

		if ronghePass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.KingJiChallenge, self._activityId)
		end
	end

	self:_setStageId(true)
	self:_updateUI()
end

return KingjimixView
