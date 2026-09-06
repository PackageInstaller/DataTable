-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeStageView.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeStageView", package.seeall)

local KdChallengeStageView = class("KdChallengeStageView", ViewComponent)

function KdChallengeStageView:buildUI()
	KdChallengeStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._challengeView = goutil.findChild(self.mainGO, "challengeView")
	self._txatCostIcon = goutil.findChild(self.mainGO, "txtCost/icon")
	self._txtCost = goutil.findChildTextComponent(self.mainGO, "txtCost")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._ruleDesc = goutil.findChildTextComponent(self.mainGO, "rule/txtDesc")
end

function KdChallengeStageView:bindEvents()
	KdChallengeStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function KdChallengeStageView:unbindEvents()
	KdChallengeStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnSure)
end

function KdChallengeStageView:onEnter()
	KdChallengeStageView.super.onEnter(self)

	self._challengeId = KdChallengeConfig.instance:getKdCurChallengeId()

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeStageResetRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeStageForcePrizeRes, self._onUpdate, self)
	self:_sendGetInfoReq()

	local redId = RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_STAGE

	KdChallengeController.instance:saveRedAsLandingOnce(redId, true)
end

function KdChallengeStageView:onExit()
	KdChallengeStageView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeStageResetRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeStageForcePrizeRes, self._onUpdate, self)
	MaterialMgr.resetAll(self._txatCostIcon)
	self:_clearChallengeView()
end

function KdChallengeStageView:_sendGetInfoReq()
	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(self._challengeId)
end

function KdChallengeStageView:_onSetUI()
	local itemsStr = KdChallengeConfig.instance:getKdShowResource()

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

	local ruleData = RulesConfig.instance:getRuleCo("KingofTheDragon_rule_2_1")

	if ruleData then
		self._ruleDesc.text = ruleData.rules
	end

	if ruleData then
		self._txtTitle.text = ruleData.title
	end
end

function KdChallengeStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KdChallengeStageView:_onUpdateData()
	self:_onUpdateChallengeViewData()
end

function KdChallengeStageView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateChallengeViewUI()
end

function KdChallengeStageView:_onUpdatePlaneUI()
	local isPassAll = KdChallengeController.instance:isPassAllStageAsStage()

	GameUtil.SetActive(self._btnReset, not isPassAll)

	local info = self._challengeInfoList[1]

	if info and info.data.prize then
		local matType, matId, matNum = MaterialMgr.getMatParams(info.data.prize)

		MaterialMgr.setIcon(self._txatCostIcon, matType, matId, nil, nil)
	end

	local remainPrizeNum = KdChallengeController.instance:getRemainPrizeNumAsStage()

	self._txtCost.text = string.format("x%s", remainPrizeNum)
end

function KdChallengeStageView:_onUpdateChallengeViewData()
	local infoList = {}
	local stageIdList = KdChallengeModel.instance:getStageIdListAsStage()

	for _, stageId in ipairs(stageIdList) do
		local info = {
			data = KdChallengeConfig.instance:getKdStageDataByCId(self._challengeId, stageId),
			isPass = KdChallengeModel.instance:isPassStageAsStage(stageId)
		}

		table.insert(infoList, info)
	end

	self._challengeInfoList = infoList
end

function KdChallengeStageView:_onUpdateChallengeViewUI()
	local parentTran = self._challengeView.transform

	for idx, info in ipairs(self._challengeInfoList) do
		local mainGo = parentTran:GetChild(idx - 1)

		self:_updateChallengeCell(mainGo, info, idx)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= #self._challengeInfoList)
	end
end

function KdChallengeStageView:_clearChallengeView()
	local parentTran = self._challengeView.transform

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)
		local prizeIcon = goutil.findChild(mainGo, "txtNum/prizeIcon")
		local btnFormation = goutil.findChild(mainGo, "btnFormation")

		for posId = 1, btnFormation.transform.childCount do
			local go = btnFormation.transform:GetChild(posId - 1)
			local icon = goutil.findChild(go, "icon")

			MaterialMgr.resetAll(icon)
		end

		MaterialMgr.resetAll(prizeIcon)
		GameUtil.rmClickHandler(btnFormation)
	end
end

function KdChallengeStageView:_updateChallengeCell(mainGo, info, idx)
	local data = info.data
	local isPass = info.isPass
	local pass = goutil.findChild(mainGo, "pass")
	local btnFormation = goutil.findChild(mainGo, "btnFormation")
	local btnView = goutil.findChild(mainGo, "btnFormation/btnView")
	local prizeIcon = goutil.findChild(mainGo, "txtNum/prizeIcon")
	local txtLevel = goutil.findChildTextComponent(mainGo, "bgLevel/txtLevel")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	txtLevel.text = string.format("第%d阵", idx)

	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)

	txtNum.text = string.format("x%d", matNum)

	MaterialMgr.setIcon(prizeIcon, matType, matId, nil, nil)

	local creepsCfg = KdChallengeConfig.instance:getKdChallengeCreepsCfg(data.creepsMasterId)

	for posId = 1, btnView.transform.childCount do
		local go = btnView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				proxy.binder:setClickCallBack(nil)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.SetActive(pass, isPass)
	GameUtil.addClickHandler(btnFormation, GameUtil.handler(self._onClickChallengeCell, self, info))
end

function KdChallengeStageView:_onClickChallengeCell(info)
	if info.isPass then
		FloatWordMgr.instance:show("该阵已通关")
	else
		KdChallengeModel.instance:clearViewInfos()
		KdChallengeModel.instance:addViewInfo(ViewName.KdChallengeMainView)
		KdChallengeModel.instance:addViewInfo(self._viewPresentor.viewName)
		KdChallengeController.instance:enterBattleAsKd(GameEnum.KingDragonType.Stage, info.data.stageId)
	end
end

function KdChallengeStageView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("KingofTheDragon_rule_2")
end

function KdChallengeStageView:_onClickBtnReset()
	local result = KdChallengeController.instance:getResetResultAsStage()

	if result ~= GameEnum.ResultCode.Success then
		if result == GameEnum.ResultCode.NotEnoughNum then
			FloatWordMgr.instance:show("没有需要重置的关卡")
		elseif result == GameEnum.ResultCode.HasSure then
			FloatWordMgr.instance:show("您已结算,结算后无法重置关卡")
		elseif result == GameEnum.ResultCode.AllPass then
			FloatWordMgr.instance:show("所有关卡已通关，无需进行重置")
		end

		return
	end

	local tipsContent = "是否确认重置关卡？"

	local function okFunc()
		KdChallengeController.instance:sendPM_TQKingDragonStageResetReq(self._challengeId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function KdChallengeStageView:_onClickBtnSure()
	local result = KdChallengeController.instance:getForceSurePrizeResultAsStage()

	if result ~= GameEnum.ResultCode.Success then
		if result == GameEnum.ResultCode.HasSure then
			FloatWordMgr.instance:show("您已结算")
		elseif result == GameEnum.ResultCode.NotPrizeCanGet then
			FloatWordMgr.instance:show("没有需要结算的关卡")
		elseif result == GameEnum.ResultCode.AllPass then
			FloatWordMgr.instance:show("所有关卡已通关，无需进行结算")
		end

		return
	end

	local tipsContent = "结算奖励后，当天无法再重置关卡，剩余关卡可以继续挑战。是否立即结算？"

	local function okFunc()
		KdChallengeController.instance:sendPM_TQKingDragonStageForcePrizeReq(self._challengeId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

return KdChallengeStageView
