-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/SenluowanxiangView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.SenluowanxiangView", package.seeall)

local SenluowanxiangView = class("SenluowanxiangView", ViewComponent)

function SenluowanxiangView:buildUI()
	SenluowanxiangView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._ruleBtn = self:getBtn("topleft/btnRule")
	self._stageCell = self:getGo("stageCell")
	self._stageView = ScrollerList.create(self:getGo("stageView"), self._stageCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._stageView:regGetCellSize(function()
		return 254, 456
	end)

	self._unLockText = self:getTxt("txtbg/Text")
	self._buyChallengeTimesBtn = self:getBtn("challengeNum/btnAdd")
	self._challengeNum = self:getTxt("challengeNum/Text")
	self._buffDesc = self:getTxt("buff/txtDesc")
end

function SenluowanxiangView:bindEvents()
	SenluowanxiangView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)
	self._buyChallengeTimesBtn:AddClickListener(self._onClickBuyTimes, self)
end

function SenluowanxiangView:unbindEvents()
	SenluowanxiangView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()
	self._buyChallengeTimesBtn:RemoveClickListener()
end

function SenluowanxiangView:onEnter()
	SenluowanxiangView.super.onEnter(self)
	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCGetSingleChallengeInfoRes, self._handlePM_TMWCGetSingleChallengeInfoRes, self)
	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCBuyChallengeTimesRes, self._handlePM_TMWCBuyChallengeTimesRes, self)
	TianManWangChallengeAgent.instance:sendPM_TMWCGetSingleChallengeInfoReq(2)

	if not TianmanKingModel.instance:isPassedStageAll() then
		TianManWangChallengeAgent.instance:sendPM_TMWCGetFormReq()
	end
end

function SenluowanxiangView:onExit()
	SenluowanxiangView.super.onExit(self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCGetSingleChallengeInfoRes, self._handlePM_TMWCGetSingleChallengeInfoRes, self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCBuyChallengeTimesRes, self._handlePM_TMWCBuyChallengeTimesRes, self)
	self._stageView:dispose()
end

function SenluowanxiangView:_handlePM_TMWCGetSingleChallengeInfoRes(msg)
	local linearChallengeInfo = msg.linearChallengeInfo
	local stageCo = TianmanKingConfig.instance:getStage()

	self._passedStage = linearChallengeInfo.passedStage
	self._unLockText.text = TianmanKingController.instance:getText("TEXT_9", self._passedStage, #stageCo[2])

	local typeCfg = TianmanKingConfig.instance:getTypeByType(2)

	self._todayChallengeTimes = linearChallengeInfo.todayChallengeTimes
	self._todayChallengeBuyTimes = linearChallengeInfo.todayChallengeBuyTimes
	self._dailyTimes = typeCfg.freeDailyTimes
	self._challengeNum.text = TianmanKingController.instance:getText("TEXT_13", self:_getGamingTimes(), self._dailyTimes)

	self._stageView:reloadData(stageCo[2])

	self._passedStage = math.max(0, self._passedStage)
	self._passedStage = math.min(self._passedStage, #stageCo[2])

	self._stageView:MoveCellToCenter(self._passedStage)

	local buffCfg = TianmanKingConfig.instance:getBuffByLevel(msg.buffLevel)

	self._buffDesc.text = buffCfg and TianmanKingController.instance:getText("TEXT_10", msg.buffLevel, buffCfg.des) or ""

	goutil.setActive(self._buyChallengeTimesBtn.gameObject, self:_getGamingTimes() == 0)
end

function SenluowanxiangView:_handlePM_TMWCBuyChallengeTimesRes()
	goutil.setActive(self._buyChallengeTimesBtn.gameObject, false)

	self._todayChallengeBuyTimes = self._todayChallengeBuyTimes + 1

	local typeCfg = TianmanKingConfig.instance:getTypeByType(2)

	self._dailyTimes = typeCfg.freeDailyTimes
	self._challengeNum.text = TianmanKingController.instance:getText("TEXT_13", self:_getGamingTimes(), self._dailyTimes)
end

function SenluowanxiangView:_updateCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "stageName").text = string.format(lang("tip_missionnum"), data.stage)

	local rare = goutil.findChild(cell.gameObject, "rare")

	uGuiUtil.setGoGrayState(rare, self._passedStage < data.stage)

	goutil.findChildTextComponent(rare, "Text").text = TianmanKingController.instance:getText("TEXT_12", data.level)

	local creepsCo = TianmanKingConfig.instance:getCreepByMasterId(data.creepsMasterId)
	local petCo = CharacterConfig.instance:getPetCo(creepsCo[1].raceId)
	local con = goutil.findChild(cell.gameObject, "pet/con")

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getLotteryPetImgUrl(petCo.raceId))
	uGuiUtil.setGoGrayState(con, self._passedStage + 1 < data.stage)

	local challengeBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "challengeBtn")

	challengeBtn:AddClickListener(function()
		if self:_getGamingTimes() > 0 then
			UIStateManager.instance:push(ViewName.TianmanKingMissionView, 2, data.stage)
		else
			self:_onClickBuyTimes()
		end
	end)
	goutil.setActive(challengeBtn.gameObject, self._passedStage + 1 == data.stage)
	goutil.setActive(goutil.findChild(cell.gameObject, "complete"), self._passedStage >= data.stage)

	local rewardText = goutil.findChildTextComponent(cell.gameObject, "reward")
	local matType, id, matNum = MaterialMgr.getMatParams(data.prize)

	rewardText.text = TianmanKingController.instance:getText("TEXT_16", matNum)

	MaterialMgr.setIcon(goutil.findChild(rewardText.gameObject, "icon"), matType, id)

	goutil.findChildTextComponent(cell.gameObject, "desc").text = data.missionCondition
end

function SenluowanxiangView:_getGamingTimes()
	return self._dailyTimes + self._todayChallengeBuyTimes - self._todayChallengeTimes
end

function SenluowanxiangView:_clearCell(cell)
	uGuiUtil.clearImage(goutil.findChild(cell.gameObject, "pet/con"))
end

function SenluowanxiangView:_onClickRule()
	local ruleKey = TianmanKingConfig.instance:getTypeByType(2).ruleKey

	UIStateManager.instance:push(ViewName.RulesView, ruleKey)
end

function SenluowanxiangView:_onClickBuyTimes()
	if self:_getGamingTimes() > 0 then
		FloatWordMgr.instance:show(TianmanKingController.instance:getText("TEXT_39"))

		return
	end

	local typeCfg = TianmanKingConfig.instance:getTypeByType(2)
	local buyTimesPlan = TianmanKingConfig.instance:getBuyTimesByPlan(typeCfg.buyTimesPlanId)

	if buyTimesPlan[self._todayChallengeBuyTimes + 1] then
		local consume = buyTimesPlan[self._todayChallengeBuyTimes + 1].consume
		local matType, matId, matNum = MaterialMgr.getMatParams(consume)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, TianmanKingController.instance:getText("TEXT_14", matNum, MaterialMgr.getContentMatStr(consume, 26, 0, true), #buyTimesPlan, #buyTimesPlan - self._todayChallengeBuyTimes), function()
			TianManWangChallengeAgent.instance:sendPM_TMWCBuyChallengeTimesReq(2)
		end)
	else
		TipsFacade.instance:openTipWindow(lang("tip"), TianmanKingController.instance:getText("TEXT_15"), nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

return SenluowanxiangView
