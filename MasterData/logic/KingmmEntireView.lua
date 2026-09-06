-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmEntireView.lua

module("logic.extensions.kingmengmeng.view.KingmmEntireView", package.seeall)

local KingmmEntireView = class("KingmmEntireView", ViewComponent)

function KingmmEntireView:ctor()
	KingmmEntireView.super.ctor(self)
end

function KingmmEntireView:buildUI()
	KingmmEntireView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnReset = self:getBtn("info/btnReset")
	self._btnChallenge = self:getBtn("info/btnChallenge")
	self._txtTime = self:getTxt("time/txt")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._txtNum = self:getTxt("info/txtNum")
	self._txtScore = self:getTxt("info/txtDesc/txtScore")

	local worldRoot = self:getGo("worldRoot")

	self._worldSliderMo = WorldSliderMo.New(worldRoot)
	self._redPoint = self:getGo("info/btnChallenge/redPoint")
	self._fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("info/fmt/cell_%d", i))
		item.con = self:getGo(string.format("info/fmt/cell_%d/con", i))

		table.insert(self._fmtList, item)
	end
end

function KingmmEntireView:bindEvents()
	KingmmEntireView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._worldSliderMo:bindEvents()
end

function KingmmEntireView:unbindEvents()
	KingmmEntireView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._worldSliderMo:unbindEvents()
end

function KingmmEntireView:onEnter()
	KingmmEntireView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeGetCommonInfoRes, self._onGetCommonInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeResetRandomInfoRes, self._onResetRandomInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeGetSocrePrizeRes, self._onGetScorePrizeRes, self)

	self._activityId = self:getFirstParam()
	self._activityType = KingmmController.instance:getActivityType()

	local isInTime = KingmmController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._cfgActivity = KingmmConfig.instance:getActivityCfg(self._activityId)
	self._maxDailyChallengeTimes = self._cfgActivity.dailyChallengeTimes
	self._maxFeelNum = KingmmController.instance:getMaxFeelNum(self._activityId)

	self:_resetHeadActive()
	self:_initScoreSlider()
	self:_initActivityTime()
	self:_initScoreTxt()
	self:_onGetCommonInfoRes()
end

function KingmmEntireView:onExit()
	KingmmEntireView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeGetCommonInfoRes, self._onGetCommonInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeResetRandomInfoRes, self._onResetRandomInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeGetSocrePrizeRes, self._onGetScorePrizeRes, self)
	self._worldSliderMo:onExit()
	self:_clearHeadIcon()
end

function KingmmEntireView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "kingmmentireview_rule")
end

function KingmmEntireView:_onClickReset()
	KingmmController.instance:openFeelView(self._activityId)
end

function KingmmEntireView:_onClickChallenge()
	local leftNum = Mathf.Max(0, self._maxDailyChallengeTimes - KingmmModel.instance:getTodayChallengeTimes())

	if leftNum == 0 then
		FloatWordMgr.instance:show("今日剩余次数不足")

		return
	end

	local formId = KingmmModel.instance:getFormId()
	local conditionId = KingmmModel.instance:getConditionId()
	local formCheckId = KingmmModel.instance:getFormCheckId()

	KingmmController.instance:openMissionView(self._activityId, formId, conditionId, formCheckId)
end

function KingmmEntireView:_onGetCommonInfoRes()
	self:_updateRedPoint()
	self:_updateFmtHead()
	self:_updateDesc()
	self:_updateChallengeNum()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function KingmmEntireView:_onResetRandomInfoRes()
	self:_updateDesc()
	UIStateManager.instance:push(ViewName.KingmmEntireFeelView, self._activityId)
end

function KingmmEntireView:_onGetScorePrizeRes()
	self._worldSliderMo:updateWorldReward()
end

function KingmmEntireView:_initActivityTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function KingmmEntireView:_updateFmtHead()
	self:_resetHeadActive()

	local formId = KingmmModel.instance:getFormId()

	if formId > 0 then
		local cfgForm = KingmmConfig.instance:getFormCfg(self._activityId, formId)
		local cfgCreeps = KingmmConfig.instance:getCreepsCfgList(cfgForm.creepsMasterId)

		for i, cfgEnemy in ipairs(cfgCreeps) do
			local item = self._fmtList[cfgEnemy.posId]

			if item and item.go then
				goutil.setActive(item.go, true)
				GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
				MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, item.con)
			end
		end
	end
end

function KingmmEntireView:_clearHeadIcon()
	for i, v in ipairs(self._fmtList) do
		MaterialMgr.resetAll(v.con)
	end
end

function KingmmEntireView:_resetHeadActive()
	for i, v in ipairs(self._fmtList) do
		goutil.setActive(v.go, false)
	end
end

function KingmmEntireView:_initScoreSlider()
	local worldParam = {}

	worldParam.view = self
	worldParam.isShowDefaultPos = true
	worldParam.elementSpacing = 90
	worldParam.prizeCfgs = KingmmConfig.instance:getScorePrizeList(self._activityId)

	local maxScore = checknumber(worldParam.prizeCfgs[#worldParam.prizeCfgs].score)

	function worldParam.getWorldProgress()
		return KingmmModel.instance:getCurScore()
	end

	function worldParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.score
	end

	function worldParam.isWorldRewardCanGet(rewardCfg)
		return KingmmModel.instance:isRewardCanGet(rewardCfg.prizeId, rewardCfg.score)
	end

	function worldParam.isWorldRewardGeted(rewardCfg)
		return KingmmModel.instance:isRewardGeted(rewardCfg.prizeId)
	end

	function worldParam.sendGainWorldPrizeReq(rewardCfg)
		KingmmAgent.instance:sendPM_KMMChallengeGetSocrePrizeReq(self._activityId, rewardCfg.prizeId)
	end

	function worldParam.getPrizeText(rewardCfg)
		return string.format("当前积分:\n<color=#F8D200FF>%s</color>", KingmmModel.instance:getCurScore())
	end

	self._worldSliderMo:initParam(worldParam)
	self._worldSliderMo:onEnter()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function KingmmEntireView:_updateDesc()
	self._txtDesc.text = KingmmController.instance:getLevelDesc(self._activityId)
end

function KingmmEntireView:_updateChallengeNum()
	local leftNum = Mathf.Max(0, self._maxDailyChallengeTimes - KingmmModel.instance:getTodayChallengeTimes())

	if leftNum > 0 then
		if not ColorConst.Green then
			local colorStr = ColorConst.Red

			self._txtNum.text = string.format("今日剩余挑战次数：<color=#%s>%d</color>", colorStr, leftNum)
		end
	end
end

function KingmmEntireView:_initScoreTxt()
	self._txtScore.text = string.format("成功通关额外获得%d积分", self._cfgActivity.extScore)
end

function KingmmEntireView:_updateRedPoint()
	local isLeftTodayChallengeTimes = KingmmModel.instance:isLeftTodayChallengeTimes(self._activityId)

	goutil.setActive(self._redPoint, isLeftTodayChallengeTimes)
end

return KingmmEntireView
