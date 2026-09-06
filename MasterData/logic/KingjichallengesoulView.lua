-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjichallengesoulView.lua

module("logic.extensions.kingjichallenge.view.KingjichallengesoulView", package.seeall)

local KingjichallengesoulView = class("KingjichallengesoulView", ViewComponent)

function KingjichallengesoulView:ctor()
	KingjichallengesoulView.super.ctor(self)
end

function KingjichallengesoulView:unbindEvents()
	KingjichallengesoulView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for k, v in pairs(self._btnItems) do
		GameUtil.rmClickHandler(v.go)
	end
end

function KingjichallengesoulView:bindEvents()
	KingjichallengesoulView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)

	for k, v in pairs(self._btnItems) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self._onClickBtn, self, k))
	end
end

function KingjichallengesoulView:buildUI()
	KingjichallengesoulView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._tablecellGo = self:getGo("left/tablecell")
	self._tableviewGo = self:getGo("left/tableview")
	self._leftScrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))

	self:_buildBtns()

	self._progress = self:getGo("progress")
	self._rewardCellGo = self:getGo("progress/rewardCell")
	self._tableviewGo = self:getGo("progress/tableview")
	self._rewardScrollerList = ScrollerList.create(self._tableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("progress/total/txtProgress")
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")
	self._emptyGo = self:getGo("left/empty")
end

function KingjichallengesoulView:_buildBtns()
	local root = self:getGo("btns")

	self._btnItems = {}

	for i = 1, 5 do
		local go = goutil.findChild(root, "btn" .. i)
		local var_5_0 = {
			go = go,
			txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		}

		var_5_0.imgChange = goutil.findChild(go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		self._btnItems[i] = var_5_0
	end
end

function KingjichallengesoulView:onExit()
	KingjichallengesoulView.super.onExit(self)
	self._leftScrollerList:dispose()
	self._rewardScrollerList:dispose()
end

function KingjichallengesoulView:onEnter()
	KingjichallengesoulView.super.onEnter(self)
	self.addGEvent(self, KingJiChallengeAgent.KingJiChallengeGainPrizeRes, self._updateReward, self)

	self._activityId = KingjichallengeModel.instance:getActivityId()
	self._activityCfg = KingjichallengeConfig.instance:getActivityCfg(self._activityId)
	self._isCanFinishMoveReward = true
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_updateUI()
end

function KingjichallengesoulView:_onClickbtnTip()
	local key = self._activityCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function KingjichallengesoulView:_onClickbtnClose()
	self:close()
end

function KingjichallengesoulView:_onClickBtn(stageId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.KingjisoulsmallView, stageId)
end

function KingjichallengesoulView:_updateUI()
	local info = KingjichallengeModel.instance:getInfo()

	self._soulInfo = info and info.soulInfo

	self:_setAoqiGodUI()
	self:_updateLeft()
	self:_updateReward()
	self:_updateBtnStatus()
end

function KingjichallengesoulView:_setAoqiGodUI()
	GameUtil.SetActive(self._progress, not self._isAoqiGodProcessType)
end

function KingjichallengesoulView:_updateBtnStatus()
	if not self._soulInfo then
		return
	end

	local stages_kv = {}

	for i, v in ipairs(self._soulInfo.stageList) do
		stages_kv[v.stageId] = v
	end

	for stageId, v in ipairs(self._btnItems) do
		local info = stages_kv[stageId]
		local maxStageId = KingjichallengeConfig.instance:getSoulMaxSmallStageNum(self._activityId, stageId)

		v.txtDesc.text = string.format("%s/%s", info.passMaxSmallStageId, maxStageId)

		local name = KingjichallengeConfig.instance:getSoulBtnIconName(self._activityId, stageId)

		v.imgChange:ChangeSprite(name)
	end
end

function KingjichallengesoulView:_updateLeft()
	if not self._soulInfo then
		return
	end

	self._leftScrollerList:reloadData(self._soulInfo.stageList)
	goutil.setActive(self._emptyGo, #self._soulInfo.stageList <= 0)
end

function KingjichallengesoulView:_updateLeftCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtLv = goutil.findChildTextComponent(cell.gameObject, "txtLv")
	local imgChange = goutil.findChild(cell, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local buffDesc = ""

	buffDesc = data.passMaxSmallStageId <= 0 and "暂无加成" or KingjichallengeConfig.instance:getSoulSmallStageBuffDesc(self._activityId, data.stageId, data.passMaxSmallStageId)

	local name = KingjichallengeConfig.instance:getSoulBtnIconName(self._activityId, data.stageId)

	imgChange:ChangeSprite(name)

	txtLv.text = data.passMaxSmallStageId
	txtDesc.text = buffDesc
end

function KingjichallengesoulView:_clearLeftCell(cell)
	return
end

function KingjichallengesoulView:_updateReward()
	if self._isAoqiGodProcessType then
		return
	end

	local cfgs = KingjichallengeConfig.instance:getSoulPrizeCfgs(self._activityId)
	local passStages = KingjichallengeModel.instance:getSoulPassStages()

	self._rewardScrollerList:regReloadFinish(function()
		if self._isCanFinishMoveReward then
			local moveIndex = 1

			for i, v in ipairs(cfgs) do
				local isCanGet = KingjichallengeController.instance:isCanGet(v.prizeId, GameEnum.KingjiChallengeType.Hun)

				if isCanGet then
					moveIndex = i

					break
				end
			end

			self._rewardScrollerList:MoveCellToCenter(Mathf.Clamp(moveIndex, 1, #cfgs))

			self._isCanFinishMoveReward = false
		end

		local scoreList = KingjichallengeConfig.instance:getSoulPrizePassStages(self._activityId)

		self._rewardScrollerList:updateUnderSlider(self._progressBar, passStages, scoreList)
	end)
	self._rewardScrollerList:reloadData(cfgs)
	self:_updateProgressDesc(passStages)
end

function KingjichallengesoulView:_updateProgressDesc(passStages)
	self._txtProgress.text = passStages
end

function KingjichallengesoulView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")
	local received = goutil.findChild(cell, "received")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = KingjichallengeController.instance:isCanGet(data.prizeId, GameEnum.KingjiChallengeType.Hun)
	local isGainPrize = KingjichallengeController.instance:isGainPrize(data.prizeId, GameEnum.KingjiChallengeType.Hun)

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

function KingjichallengesoulView:_onClickGetPrize(prizeId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.KingJiChallenge, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	KingJiChallengeAgent.instance:sendPM_KingJiChallengeGainPrizeReq(self._activityId, GameEnum.KingjiChallengeType.Hun, prizeId)
end

function KingjichallengesoulView:_playEffect(effGo)
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

function KingjichallengesoulView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function KingjichallengesoulView:_clearRewardCell(cell)
	local effect = goutil.findChild(cell, "effect")
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

return KingjichallengesoulView
