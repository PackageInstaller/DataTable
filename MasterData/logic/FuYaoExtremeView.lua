-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/view/FuYaoExtremeView.lua

module("logic.extensions.fuyao.view.FuYaoExtremeView", package.seeall)

local FuYaoExtremeView = class("FuYaoExtremeView", ViewComponent)

function FuYaoExtremeView:ctor()
	FuYaoExtremeView.super.ctor(self)
end

function FuYaoExtremeView:unbindEvents()
	FuYaoExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, #self._challengeList do
		GameUtil.rmClickHandler(self._challengeList[i].go)
	end
end

function FuYaoExtremeView:bindEvents()
	FuYaoExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	for i = 1, #self._challengeList do
		GameUtil.addClickHandler(self._challengeList[i].go, GameUtil.handler(self._onClickChallenge, self, i))
	end
end

function FuYaoExtremeView:buildUI()
	FuYaoExtremeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtScore = self:getTxt("txtScore")
	self._progressSlider = self:getSlider("progress")
	self._rewardGo = self:getGo("reward")
	self._reward = self:getGo("reward/con")
	self._receive = self:getGo("reward/receive")
	self._petCon = self:getGo("con")
	self._tipGo = self:getGo("tip")

	local challengeParent = self:getGo("challenge")

	self._challengeList = {}

	for i = 1, challengeParent.transform.childCount do
		local challenge = {}

		challenge.go = goutil.findChild(challengeParent, "btnChallenge_" .. i)
		challenge.score = goutil.findChild(challenge.go, "score")
		challenge.txtScore = goutil.findChildTextComponent(challenge.go, "score/txtScore")
		challenge.noPass = goutil.findChild(challenge.go, "noPass")
		challenge.select = goutil.findChild(challenge.go, "select")
		self._challengeList[i] = challenge

		GameUtil.SetActive(challenge.select, false)
	end
end

function FuYaoExtremeView:onExit()
	FuYaoExtremeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FuyaoGetInfoRes, self._refreshUI, self)
	MaterialMgr.resetAll(self._reward)
	RoleObjectPool.instance:removeRole(self._loader)
end

function FuYaoExtremeView:onEnter()
	FuYaoExtremeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = FuYaoController.instance:getActivityType()

	local isInTime = FuYaoController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._challengeCfg = FuYaoConfig.instance:getFuyaoChallengeCfg(self._activityId)
	self._extremeCfg = FuYaoConfig.instance:getFuyaoExtremeCfg(self._activityId)
	self._selectId = FuYaoModel.instance:getExtremeSelectId()

	self:_initUI()
	self:_refreshUI()
	GlobalDispatcher:addListener(GlobalNotify.FuyaoGetInfoRes, self._refreshUI, self)
	FuYaoController.instance:sendPM_FuyaoGetInfoReq(self._activityId)
end

function FuYaoExtremeView:_initUI()
	for i = 1, #self._challengeList do
		local cfg = self._extremeCfg[i]

		GameUtil.SetActive(self._challengeList[i].go, cfg)
	end

	GameUtil.SetActive(self._challengeList[1].select, true)

	local totalScore = self._challengeCfg.extremePassScore
	local curScore = FuYaoModel.instance:getCurScore()

	self._txtScore.text = string.format("%s/%s", curScore, totalScore)

	self._progressSlider:SetValue(curScore / totalScore)

	local x, y, scale = 0, 0, 1

	self._raceId = self._challengeCfg.raceId
	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._petCon, scale, nil, true, x, y)

	GameUtil.SetActive(self._tipGo, not self._isAoqiGodProcessType)
end

function FuYaoExtremeView:_refreshUI()
	local extremeScores = FuYaoModel.instance:getExtremeScores()

	for i = 1, #extremeScores do
		local score = extremeScores[i]

		GameUtil.SetActive(self._challengeList[i].score, score >= 0)
		GameUtil.SetActive(self._challengeList[i].noPass, score < 0)
		GameUtil.SetActive(self._challengeList[i].select, i == self._selectId)

		if score >= 0 then
			self._challengeList[i].txtScore.text = extremeScores[i]
		end
	end

	local proxy = MaterialMgr.setCellByCfg(self._challengeCfg.extremePrize, self._reward)

	if not FuYaoController.instance:isClearanceExtreme() and proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			FloatWordMgr.instance:show("需要通关所有关卡后领取")
		end)
	end

	GameUtil.SetActive(self._receive, FuYaoController.instance:isClearanceExtreme())
	GameUtil.SetActive(self._rewardGo, not self._isAoqiGodProcessType)

	local totalScore = self._challengeCfg.extremePassScore
	local curScore = FuYaoModel.instance:getCurScore()

	self._txtScore.text = string.format("%s/%s", curScore, totalScore)
end

function FuYaoExtremeView:_onClickChallenge(stageId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if FuYaoController.instance:isClearanceExtreme() then
		FloatWordMgr.instance:show("您已通关哦~")

		return
	end

	FuYaoModel.instance:setExtremeSelectId(stageId)
	FuYaoController.instance:openChallengeForm(self._activityId, stageId, self._extremeCfg[stageId].creepsMasterId, true)
end

function FuYaoExtremeView:_onClickClose()
	FuYaoModel.instance:setExtremeSelectId(1)
	self:close()
end

return FuYaoExtremeView
