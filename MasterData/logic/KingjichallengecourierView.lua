-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjichallengecourierView.lua

module("logic.extensions.kingjichallenge.view.KingjichallengecourierView", package.seeall)

local KingjichallengecourierView = class("KingjichallengecourierView", ViewComponent)

function KingjichallengecourierView:ctor()
	KingjichallengecourierView.super.ctor(self)
end

function KingjichallengecourierView:unbindEvents()
	KingjichallengecourierView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function KingjichallengecourierView:bindEvents()
	KingjichallengecourierView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function KingjichallengecourierView:buildUI()
	KingjichallengecourierView.super.buildUI(self)

	self._tableviewGo1 = self:getGo("tableview")
	self._tabelcellGo1 = self:getGo("tabelcell")
	self._stageScrollList = ScrollerList.create(self._tableviewGo1, self._tabelcellGo1, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._progress = self:getGo("progress")
	self._rewardCellGo = self:getGo("progress/rewardCell")
	self._tableviewGo = self:getGo("progress/tableview")
	self._rewardScrollerList = ScrollerList.create(self._tableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("progress/total/txtProgress")
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")
	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("txtTime")
end

function KingjichallengecourierView:onExit()
	KingjichallengecourierView.super.onExit(self)
	self._stageScrollList:dispose()
	self._rewardScrollerList:dispose()
end

function KingjichallengecourierView:onEnter()
	KingjichallengecourierView.super.onEnter(self)
	self.addGEvent(self, KingJiChallengeAgent.KingJiChallengeGainPrizeRes, self._updateReward, self)

	self._activityId = KingjichallengeModel.instance:getActivityId()
	self._activityCfg = KingjichallengeConfig.instance:getActivityCfg(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._isCanFinishMoveReward = true

	self:_updateUI()
	self:_checkIsBattleSceneRetrun()
end

function KingjichallengecourierView:_updateUI()
	self:_setAoqiGodTypeUI()
	self:_updateStage()
	self:_updateReward()
	self:_setChallengeTime()
	self:_setCurrDamage()
end

function KingjichallengecourierView:_updateStage()
	local cfgs = KingjichallengeConfig.instance:getCourierStageCfgs(self._activityId)

	self._stageScrollList:reloadData(cfgs)
end

function KingjichallengecourierView:_updateCell(view, parentCell, data, tag)
	local cell = goutil.findChild(parentCell, "root")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local goPass = goutil.findChild(cell.gameObject, "pass")
	local txtDamage = goutil.findChildTextComponent(cell.gameObject, "txtDamage")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local imgChange = goutil.findChild(cell.gameObject, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgRole = goutil.findChild(cell.gameObject, "imgRole")

	txtName.text = data.stageName
	txtDesc.text = data.desc
	txtDamage.text = KingjichallengeModel.instance:getCourierStageDamage(data.stageId)

	imgChange:ChangeSprite(data.iconName)

	local modelCo = CharacterConfig.instance:getModelCo(data.raceId)

	uGuiUtil.setSpriteToImage(imgRole, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local isPass = KingjichallengeController.instance:isCourierStagePass(data.stageId)

	goutil.setActive(goPass, isPass)
	btn:AddClickListener(function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		if not self:_checkTime() then
			FloatWordMgr.instance:show("今日挑战次数已用完")

			return
		end

		KingjichallengeController:enterMission(GameEnum.KingjiChallengeType.Shizhe, data.stageId, data.creepsMasterId)
	end)

	local y = math.abs(math.abs(parentCell.data - 3) - 2) * 20

	Framework.TransformUtil.SetAnchoredPos(cell.transform, 0, y)
end

function KingjichallengecourierView:_clearCell(parentCell)
	local cell = goutil.findChild(parentCell, "root")
	local imgRole = goutil.findChild(cell.gameObject, "imgRole")

	uGuiUtil.clearImage(imgRole)
end

function KingjichallengecourierView:_updateReward()
	if self._isAoqiGodProcessType then
		return
	end

	local cfgs = KingjichallengeConfig.instance:getCourierPrizeCfgs(self._activityId)
	local currDamage = KingjichallengeModel.instance:getCourierTotalDamage()

	self._rewardScrollerList:regReloadFinish(function()
		if self._isCanFinishMoveReward then
			local moveIndex = 1

			for i, v in ipairs(cfgs) do
				local isCanGet = KingjichallengeController.instance:isCanGet(v.prizeId, GameEnum.KingjiChallengeType.Shizhe)

				if isCanGet then
					moveIndex = i

					break
				end
			end

			self._rewardScrollerList:MoveCellToCenter(Mathf.Clamp(moveIndex, 1, #cfgs))

			self._isCanFinishMoveReward = false
		end

		local scoreList = KingjichallengeConfig.instance:getCourierPrizeDamages(self._activityId)

		self._rewardScrollerList:updateUnderSlider(self._progressBar, currDamage, scoreList)
	end)
	self._rewardScrollerList:reloadData(cfgs)
end

function KingjichallengecourierView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")
	local received = goutil.findChild(cell, "received")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.damage

	local isCanGet = KingjichallengeController.instance:isCanGet(data.prizeId, GameEnum.KingjiChallengeType.Shizhe)
	local isGainPrize = KingjichallengeController.instance:isGainPrize(data.prizeId, GameEnum.KingjiChallengeType.Shizhe)

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet then
		self:_playEffect(effect)

		self._curProgress = cell.index
	end

	if isGainPrize then
		self._curProgress = cell.index + 1
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.prizeId), self)
end

function KingjichallengecourierView:_onClickGetPrize(prizeId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	KingJiChallengeAgent.instance:sendPM_KingJiChallengeGainPrizeReq(self._activityId, GameEnum.KingjiChallengeType.Shizhe, prizeId)
end

function KingjichallengecourierView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progress/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function KingjichallengecourierView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function KingjichallengecourierView:_clearRewardCell(cell)
	local effect = goutil.findChild(cell, "effect")
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function KingjichallengecourierView:_onClickbtnTip()
	local key = self._activityCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function KingjichallengecourierView:_onClickbtnClose()
	self:close()
end

function KingjichallengecourierView:_setChallengeTime()
	local time = KingjichallengeModel.instance:getCourierChallengeTime()
	local totalTime = KingjichallengeConfig.instance:getCourierDailyChallengeTimes(self._activityId)

	self._txtTime.text = string.format("今日挑战次数：%s/%s", totalTime - time, totalTime)
end

function KingjichallengecourierView:_checkTime()
	local time = KingjichallengeModel.instance:getCourierChallengeTime()
	local totalTime = KingjichallengeConfig.instance:getCourierDailyChallengeTimes(self._activityId)

	return time < totalTime
end

function KingjichallengecourierView:_setCurrDamage()
	self._txtProgress.text = KingjichallengeModel.instance:getCourierTotalDamage()
end

function KingjichallengecourierView:_checkIsBattleSceneRetrun()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if KingjichallengeController.instance:getCourierLastDamageInfo() then
		UIStateManager.instance:push(ViewName.KingjicourierbattleresultView)
	end
end

function KingjichallengecourierView:_setAoqiGodTypeUI()
	GameUtil.SetActive(self._progress, not self._isAoqiGodProcessType)
end

return KingjichallengecourierView
