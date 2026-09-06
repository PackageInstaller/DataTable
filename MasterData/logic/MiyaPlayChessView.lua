-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaPlayChessView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaPlayChessView", package.seeall)

local MiyaPlayChessView = class("MiyaPlayChessView", ViewComponent)

function MiyaPlayChessView:unbindEvents()
	MiyaPlayChessView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function MiyaPlayChessView:bindEvents()
	MiyaPlayChessView.super.bindEvents(self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
end

function MiyaPlayChessView:onExit()
	MiyaPlayChessView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgRewardIcon)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = nil
end

function MiyaPlayChessView:buildUI()
	MiyaPlayChessView.super.buildUI(self)

	self._imgIconChange = goutil.findChildComponent(self.mainGO, "icon", typeof(UIImageSpriteChange))
	self._txtDifficulty = self:getTxt("mode/txtDifficulty")
	self._txtDesc = self:getTxt("mode/txtDesc")
	self._txtModeName = self:getTxt("txtModeName")
	self._imgRewardIcon = self:getGo("mode/reward/item")
	self._txtRewardNum = self:getTxt("mode/reward/txtCount")
	self._btnStart = self:getBtn("btnStart")
	self._btnReset = self:getBtn("btnReset")
	self._txtBubble = self:getTxt("bubble/Text")
	self._txtStart = self:getTxt("btnStart/Text")
	self._power = self:getGo("mode/power")
	self._imgPowerNum = goutil.findChildComponent(self._power, "imgNum", typeof(UIImgNumeralText))
end

function MiyaPlayChessView:onEnter()
	MiyaPlayChessView.super.onEnter(self)
	self:_setEffectUrls()
	self:_createEffs()
	self:_updateUI()
end

function MiyaPlayChessView:_createEffs()
	self._effs = {}

	for _, v in ipairs(self._effPaths) do
		local parent = self.mainGO

		if not string.nilorempty(v.goPath) then
			parent = self:getGo(v.goPath)
		end

		local eff = UIEffectManager.instance:playEffect(self, v.path, parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setLocalEulerAngle(0, 0, 0)
		table.insert(self._effs, eff)
	end
end

function MiyaPlayChessView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "btnStart",
			path = "fx_ui_miyatiaozhan/fx_ui_anniu_miyataiozhan.prefab"
		}
	}
end

function MiyaPlayChessView:_updateUI()
	self._curDifficulty = MiyaGameModel.instance:getCurDifficulty()

	local difficultyCfg = MiyaGameConfig.instance:getDifficultyCfg(self._curDifficulty)

	self._curModeId = MiyaGameModel.instance:getCurModeId()

	local gameTime, passNeedNum = MiyaGameController.instance:getModeBubbleParams(self._curModeId)

	self._imgIconChange:SetState(MathUtil.clamp(self._curModeId, 1, 5) - 1)

	local modeCfg = MiyaGameConfig.instance:getModeCfg(self._curModeId)

	self._txtModeName.text = modeCfg.modeName
	self._txtStart.text = modeCfg.btnText
	self._txtBubble.text = string.format(modeCfg.bigBubble, gameTime, passNeedNum)

	local hasParams = not string.nilorempty(modeCfg.smallBubble)

	self._txtDesc.gameObject:SetActive(hasParams)
	self._power:SetActive(not hasParams)

	if hasParams then
		self._txtDesc.text = string.format(modeCfg.smallBubble, gameTime, passNeedNum)
	else
		self._imgPowerNum:SetText(MiyaGameController.instance:getRecommendZdl(self._curDifficulty))
	end

	self._txtDifficulty.text = difficultyCfg.difficultyName .. "难度"

	self:_updateMat(self._imgRewardIcon, self._txtRewardNum, difficultyCfg.passPrize)
	self._btnReset.gameObject:SetActive(self._curModeId ~= GameEnum.MiyaModeType.DIRECT_SUCCESS)
end

function MiyaPlayChessView:_updateMat(uiImage, uiText, matStr)
	local matType, matId, matNum = unpack(string.splitToNumber(matStr, ":"))

	MaterialMgr.setIcon(uiImage, matType, matId)

	uiText.text = "x" .. matNum
end

function MiyaPlayChessView:_onClickStart()
	local rivalId = MiyaGameModel.instance:getRivalId()

	if self._curModeId == GameEnum.MiyaModeType.DIRECT_SUCCESS then
		MiyaGameController.instance:endGameReq()
	elseif rivalId > 0 then
		self:_jumpToGameView()
	else
		MiyaGameController.instance:startGameReq(self._jumpToGameView, self)
	end
end

function MiyaPlayChessView:_jumpToGameView()
	local rivalId = MiyaGameModel.instance:getRivalId()
	local challengeId = MiyaGameModel.instance:getChallengeId()

	if self._curModeId == GameEnum.MiyaModeType.NORMAL_MONSTER then
		TLChallengeController.instance:openMissionView(challengeId, MiyaGameConfig.instance:getNormalMonsterCfg(rivalId), MiyaGameConfig.instance:getNormalCreepsCfg(rivalId), true, false, false)
	elseif self._curModeId == GameEnum.MiyaModeType.BOSS_MONSTER then
		TLChallengeController.instance:openMissionView(challengeId, MiyaGameConfig.instance:getBossMonsterCfg(rivalId), MiyaGameConfig.instance:getBossCreepsCfg(rivalId), false, false)
	elseif self._curModeId == GameEnum.MiyaModeType.ANSWER_QUIZ then
		UIStateManager.instance:push(ViewName.MiyaQuizGameView, rivalId)
	elseif self._curModeId == GameEnum.MiyaModeType.FIND_DIFFERENCE then
		UIStateManager.instance:push(ViewName.MiyaFindFaultView, rivalId)
	end
end

function MiyaPlayChessView:_onClickReset()
	local resetCost = MiyaGameConfig.instance:getConstantValue("RE_RANDOM_MODE_COST")
	local graphicStr, isMatEnough, tip = TLChallengeController.instance:getMatParams(resetCost)
	local params = {}

	params.title = "重抽博弈模式"
	params.text = langPara("miya_reset_mode_tip", graphicStr)

	function params.okHandler()
		if not isMatEnough then
			FloatWordMgr.instance:show(tip)
		else
			MiyaGameController.instance:randomModeReq(self._curDifficulty, self._onResetModeRes, self, true)
		end
	end

	UIStateManager.instance:push(ViewName.MiyaResetModeView, params)
end

function MiyaPlayChessView:_onResetModeRes()
	FloatWordMgr.instance:show("重抽成功")
	self:_updateUI()
end

return MiyaPlayChessView
