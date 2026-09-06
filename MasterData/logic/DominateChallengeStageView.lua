-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeStageView.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeStageView", package.seeall)

local DominateChallengeStageView = class("DominateChallengeStageView", KdChallengeStageView)

function DominateChallengeStageView:ctor()
	DominateChallengeStageView.super.ctor(self)
end

function DominateChallengeStageView:unbindEvents()
	DominateChallengeStageView.super.unbindEvents(self)
end

function DominateChallengeStageView:bindEvents()
	DominateChallengeStageView.super.bindEvents(self)
end

function DominateChallengeStageView:onExit()
	DominateChallengeStageView.super.onExit(self)
end

function DominateChallengeStageView:buildUI()
	DominateChallengeStageView.super.buildUI(self)

	self._txtGoldNum = self:getTxt("txtCost")
	self._ruleDesc = goutil.findChildTextComponent(self.mainGO, "rule/txtDesc/Viewport/Content")
end

function DominateChallengeStageView:onEnter()
	self._challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeStageResetRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeStageForcePrizeRes, self._onUpdate, self)
	self:_sendGetInfoReq()

	local redId = RedPointModel.ID_NUOYA_LANDINGONCE_RED_STAGE

	KdChallengeController.instance:saveRedAsLandingOnce(redId, true)
end

function DominateChallengeStageView:_onClickChallengeCell(info)
	if info.isPass then
		FloatWordMgr.instance:show("该阵已通关")
	else
		KdChallengeModel.instance:clearViewInfos()
		KdChallengeModel.instance:addViewInfo(ViewName.DominateChallengeMainView)
		KdChallengeModel.instance:addViewInfo(self._viewPresentor.viewName)
		KdChallengeController.instance:enterBattleAsKd(GameEnum.KingDragonType.Stage, info.data.stageId)
	end
end

function DominateChallengeStageView:_onUpdate()
	DominateChallengeStageView.super._onUpdate(self)
	self:updateGoldNumText()
end

function DominateChallengeStageView:updateGoldNumText()
	local result = KdChallengeController.instance:getResetResultAsStage()
	local dailyNum = 0
	local curNum = 0
	local hasSureNum = 0

	for k, v in pairs(self._challengeInfoList) do
		local matType, matId, matNum = MaterialMgr.getMatParams(v.data.prize)

		if v.isPass and result ~= GameEnum.ResultCode.HasSure then
			curNum = curNum + matNum
		end

		if v.isPass and result == GameEnum.ResultCode.HasSure then
			hasSureNum = hasSureNum + matNum
		end

		dailyNum = dailyNum + matNum
	end

	self._txtGoldNum.text = string.format(KdChallengeConfig.instance:getNuoyaCommonValue("STAGE_TEXT"), hasSureNum, dailyNum, curNum)
end

function DominateChallengeStageView:_onSetUI()
	local itemsStr = KdChallengeConfig.instance:getNuoyaShowResource()

	if not string.nilorempty(itemsStr) then
		local itemsStrArray = string.split(itemsStr, "#")
		local list = {}

		for _, itemStr in ipairs(itemsStrArray) do
			t = {
				showAdd = true,
				id = itemStr
			}

			table.insert(list, t)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local ruleData = RulesConfig.instance:getRuleCo("zhuzainuoya_rule_2_1")

	if ruleData then
		self._ruleDesc.text = ruleData.rules
	end

	if ruleData then
		self._txtTitle.text = ruleData.title
	end
end

function DominateChallengeStageView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("zhuzainuoya_rule_2")
end

function DominateChallengeStageView:_onUpdatePlaneUI()
	local isPassAll = KdChallengeController.instance:isPassAllStageAsStage()

	GameUtil.SetActive(self._btnReset, not isPassAll)

	local info = self._challengeInfoList[1]

	if info and info.data.prize then
		local matType, matId, matNum = MaterialMgr.getMatParams(info.data.prize)

		MaterialMgr.setIcon(self._txatCostIcon, matType, matId, nil, nil)
	end

	local remainPrizeNum = KdChallengeController.instance:getNuoyaRemainPrizeNumAsStage()

	self._txtCost.text = string.format("x%s", remainPrizeNum)
end

return DominateChallengeStageView
