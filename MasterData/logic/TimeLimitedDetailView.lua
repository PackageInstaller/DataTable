-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimeLimitedDetailView.lua

module("logic.extensions.timelimitedchallenge.view.TimeLimitedDetailView", package.seeall)

local TimeLimitedDetailView = class("TimeLimitedDetailView", ViewComponent)

function TimeLimitedDetailView:unbindEvents()
	TimeLimitedDetailView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnFinish:RemoveClickListener()
end

function TimeLimitedDetailView:bindEvents()
	TimeLimitedDetailView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnFinish:AddClickListener(self._onClickFinish, self)
end

function TimeLimitedDetailView:onExit()
	TimeLimitedDetailView.super.onExit(self)
end

function TimeLimitedDetailView:buildUI()
	TimeLimitedDetailView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtRule = goutil.findChildTextComponent(self.mainGO, "txtRule")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._progressBar = goutil.findChildComponent(self.mainGO, "progressBar", typeof(UnityEngine.UI.Slider))
	self._btnStart = self:getBtn("btnStart")
	self._btnFinish = self:getBtn("btnFinish")
	self._rewards = self:getGo("rewards")
	self._rounds = self:getGo("rounds")
	self._txtTotalDamage = goutil.findChildTextComponent(self.mainGO, "txtTotalDamage")
	self._finishText = goutil.findChildTextComponent(self._btnFinish.gameObject, "Text")
end

function TimeLimitedDetailView:onEnter()
	TimeLimitedDetailView.super.onEnter(self)
	self:_updateUI()
end

local showValue = {
	[0] = 0,
	0.2,
	0.4,
	0.6,
	0.8,
	1
}

function TimeLimitedDetailView:_updateUI()
	self._info = TLChallengeModel.instance:getFightInfo(self._challengeId)

	if not self._info then
		FloatWordMgr.instance:show("暂无数据，请稍后再试")
		self:close()

		return
	end

	self._curRound = self._info.curRound + 1
	self._totalDamage = self._info.totalDamage
	self._maxDamage = self._info.maxProgress
	self._txtTitle.text = string.format("本日第%s次挑战", self._info.hasChallengeCircle + 1)
	self._cfgs = TimeLimitedConfig.instance:getCircleProgressCfgs(self._challengeId)

	GameUtil.updateCellsWithCreate(self._rewards, self._cfgs, self._updateOneRewardCell, self)
	GameUtil.updateCellsWithCreate(self._rounds, self._cfgs, self._updateOneRoundCell, self)

	local value = self._totalDamage / self._maxDamage

	value = math.max(0, value)
	value = math.min(1, value)

	local high, highValue

	for k, v in ipairs(self._cfgs) do
		local threshold = v.progressPercent / 10000

		if value <= threshold then
			high = k
			highValue = threshold

			break
		end
	end

	local low = high - 1

	lowValue = low > 0 and self._cfgs[low].progressPercent / 10000 or 0
	self._progressBar.value = low == high and showValue[low] or showValue[low] + (value - lowValue) / (highValue - lowValue) * (showValue[high] - showValue[low])
	self._txtTotalDamage.text = self._totalDamage
	self._everTotalMaxDamage = checknumber(self._info.everTotalMaxDamage)

	if self._everTotalMaxDamage > 0 and self._curRound <= 1 then
		self._finishText.text = "扫荡五关"

		self._btnFinish:AddClickListener(self._onClickSweep, self)
	else
		self._finishText.text = "结束挑战"

		self._btnFinish:AddClickListener(self._onClickFinish, self)
	end
end

function TimeLimitedDetailView:_updateOneRewardCell(cell, data)
	local items = goutil.findChild(cell, "items")
	local txtDamage = goutil.findChildTextComponent(cell, "txtDamage")
	local imgDotChange = goutil.findChildComponent(cell, "dot", typeof(UIImageSpriteChange))
	local damage = data.progressPercent * self._maxDamage / 10000

	txtDamage.text = damage

	local mats = string.split(data.prize, "#")

	GameUtil.updateCells(items, mats, function(cell, matStr)
		MaterialMgr.setCellByCfg(matStr, cell)
	end, nil, true)
	imgDotChange:SetState(damage > self._totalDamage and 0 or 1)
end

function TimeLimitedDetailView:_updateOneRoundCell(cell, data)
	local idx = 0

	for k, v in ipairs(self._cfgs) do
		if v == data then
			idx = k

			break
		end
	end

	local txtTitle = goutil.findChildTextComponent(cell, "txt")

	txtTitle.text = string.format("第%d轮\n战斗", idx)

	local imgBgChange = goutil.findChildComponent(cell, "bg", typeof(UIImageSpriteChange))

	imgBgChange:SetState(idx > self._curRound and 0 or 1)

	local imgSelect = goutil.findChild(cell, "imgSelect")

	imgSelect:SetActive(self._curRound == idx)

	local imgState = goutil.findChild(cell, "imgState")

	imgState:SetActive(idx < self._curRound)

	local txtBattleState = goutil.findChildTextComponent(cell, "txtBattleState")
	local txtBattleStateChange = txtBattleState:GetComponent(typeof(UITextColorChange))

	txtBattleStateChange:SetState(self._curRound == idx and 0 or 1)
	txtBattleState.gameObject:SetActive(idx >= self._curRound)

	txtBattleState.text = self._curRound == idx and "正在战斗" or idx < self._curRound and "已战斗" or "未战斗"
end

function TimeLimitedDetailView:_onClickStart()
	local challengeId = self._challengeId
	local monsterCfg = TimeLimitedConfig.instance:getCircleMonsterCfg(self._challengeId, self._curRound)
	local creepCfg = TimeLimitedConfig.instance:getCircleCreeps(monsterCfg.creepsMasterId)

	self:close()
	TLChallengeController.instance:openMissionView(challengeId, monsterCfg, creepCfg, false, false)
end

function TimeLimitedDetailView:_onClickFinish()
	local text = string.format("你确定要结束当次挑战吗？\n还剩下%s次战斗轮数，\n一旦确定结束则根据当前累积总伤害结算奖励。", 5 - self._info.curRound)

	local function okHandler()
		TLChallengeController.instance:reqResetChallenge(self._challengeId, self._onResetChallengeRes, self)
	end

	TLChallengeController.instance:openTLCTip(nil, text, "结束挑战", okHandler, nil, self._challengeId, true)
end

function TimeLimitedDetailView:_onResetChallengeRes(msg)
	self:close()
	UIStateManager.instance:open(ViewName.TLCBattleResultView)
end

function TimeLimitedDetailView:getRewardByDamage(damage)
	local dict = {}

	for _, v in ipairs(self._cfgs) do
		local cfgDamage = v.progressPercent * self._maxDamage / 10000
		local mats = string.split(v.prize, "#")

		for _, v2 in ipairs(mats) do
			local matType, matId, matNum = unpack(string.splitToNumber(v2, ":"))
			local key = string.format("%d:%d", matType, matId)

			if dict[key] == nil then
				dict[key] = 0
			end

			if cfgDamage <= damage then
				dict[key] = dict[key] + matNum
			end
		end
	end

	return dict
end

function TimeLimitedDetailView:_onClickSweep()
	local dict = self:getRewardByDamage(self._everTotalMaxDamage)
	local graphicStr = ""

	for k, v in pairs(dict) do
		local matType, matId = unpack(string.splitToNumber(k, ":"))
		local matNum = v
		local iconStr = TipsFacade.instance:getContentMatStr(string.format("%s:%s", matType, matId), 40, -10, true)

		graphicStr = string.nilorempty(graphicStr) and string.format("%sX%d", iconStr, matNum) or string.format("%s %sX%d", graphicStr, iconStr, matNum)
	end

	local text = string.format("您的历史最高累计总伤害为：<color=#eb4642>%d</color>\n将获得：<color=#eb4642>%s</color>\n是否继续进行扫荡？", self._everTotalMaxDamage, graphicStr, matNum)

	TLChallengeController.instance:openTLCTip(nil, text, "确定", function()
		TimedChallengeCircleFightAgent.instance:sendPM_TimedChallengeCircleSweepReq(self._challengeId, self._onSweepRes, self)
	end, nil, self._challengeId, true)
end

function TimeLimitedDetailView:_onSweepRes()
	FloatWordMgr.instance:show("扫荡成功~")

	local fightInfo = TLChallengeModel.instance:getFightInfo(self._challengeId)

	if fightInfo then
		fightInfo.curRound = 0
		fightInfo.hasChallengeCircle = fightInfo.hasChallengeCircle + 1
		fightInfo.totalDamage = 0
	end

	GlobalDispatcher:dispatch(GlobalNotify.CircleChallengeReset)
	self:close()
end

return TimeLimitedDetailView
