-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingBossView.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingBossView", package.seeall)

local OriginMoonShadowKingBossView = class("OriginMoonShadowKingBossView", ShenJiBossView)

function OriginMoonShadowKingBossView:buildUI()
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnPredict = self:getBtn("btnPredict")
	self._txtPredict = self:getTxt("btnPredict/txtName")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._con = self:getGo("con")
	self._bossHpImgSlider = self:getSlider("bossHp/slider")
	self._txtBossHp = self:getTxt("bossHp/txtHp")
	self._rewardRect = self:getGo("reward"):GetComponent(goutil.Type_RectTransform)
	self.scrollerGo = self:getGo("reward/tableview")
	self.cellGo = self:getGo("reward/tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.scrollerGo2 = self:getGo("stageInfo/tableview")
	self.cellGo2 = self:getGo("stageInfo/tablecell")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
	self._txtTitle = self:getTxt("stageInfo/txtTitle")
	self._txtDesc2 = self:getTxt("stageInfo/txtDesc2")
	self._txtDesc3 = self:getTxt("stageInfo/scrView/Viewport/txtDesc3")
	self._toggleList = {}

	for i = 1, 3 do
		local go = goutil.findChild(self.mainGO, "clgProgress/clg" .. i)

		self._toggleList[i] = goutil.findChild(go, "toggle")
	end

	self._txtClgDesc1 = self:getTxt("clgProgress/txtClgDesc1")
	self._txtClgDesc2 = self:getTxt("clgProgress/txtClgDesc2")
	self._rewardFill = self:getImg("reward/tableview/viewport/content/slider")
end

function OriginMoonShadowKingBossView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeGainPrizeRes, self._onGainPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeResetBossStageRes, self._onResetBossStageRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onChangeDay, self)

	self._activityId = self:getFirstParam()
	self._bossCfgs = ShenJiChallengeConfig.instance:getBossList(self._activityId)
	self._cfgActivity = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._fightBossTimes = self._cfgActivity.fightBossTimes
	self._challengeId = self._cfgActivity.challengeId

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self._txtPredict.text = ShenJiChallengeConfig.instance:getCommonValue(self._activityId, "practiceTitle")

	self:_refreshView()
	settimer(1, self._onSecond, self)
	self:_onSecond()
	self:_popupTipViewFirst()
	self:_showRoleModel()
end

function OriginMoonShadowKingBossView:_onClickTip()
	local actCfg = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	local ruleTip = actCfg.ruleTip

	if ruleTip then
		UIStateManager.instance:push(ViewName.RulesView, ruleTip)
	end
end

function OriginMoonShadowKingBossView:_onClickChallenge()
	if ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId) then
		FloatWordMgr.instance:show("您已挑战完成，无需再战")

		return
	end

	local maxNum = self._fightBossTimes
	local curNum = ShenJiChallengeModel.instance:getBossChallengeTimes()
	local leftNum = Mathf.Max(maxNum - curNum, 0)

	if leftNum <= 0 then
		local text = string.format("本轮挑战失败，请重置挑战\n<color=#%s>提示：适合的阵型和赐福buff能提高破阵概率</color>", ColorConst.Green)

		TipsFacade.instance:openTipWindowNoX(lang("tip"), text, nil, nil, UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	local isEmulate = false

	ShenJiChallengeController.instance:openBossMissionView(self._activityId, self._bossId, isEmulate)
end

function OriginMoonShadowKingBossView:_updateCell2(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local fightPetMo = FightingPowerPetMo.New()

	fightPetMo:fromChallengeCreepCo(data)

	local bagPetMo = fightPetMo:toBaseBagPetMo()
	local proxy = MaterialMgr.setCellByMo(bagPetMo, node)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end)
end

function OriginMoonShadowKingBossView:_updateChallengeProgress()
	local maxNum = self._fightBossTimes
	local curNum = ShenJiChallengeModel.instance:getBossChallengeTimes()
	local leftNum = Mathf.Max(maxNum - curNum, 0)

	for i, v in ipairs(self._toggleList) do
		goutil.setActive(v, i <= leftNum)
	end

	self._txtClgDesc1.text = "本轮次数"

	if leftNum > 0 then
		if not ColorConst.Green then
			local colorStr = ColorConst.Red

			self._txtClgDesc2.text = string.format("<color=#%s>%d</color>/%d", colorStr, leftNum, maxNum)
			self._isShowSec = false
		end
	end
end

function OriginMoonShadowKingBossView:_onClickReset()
	if ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId) then
		FloatWordMgr.instance:show("您已挑战完成，无需再战")

		return
	end

	local text = string.format("即将重置BOSS血量、挑战限制和挑战次数\n<color=#%s>请确认是否重置？</color>", ColorConst.Red)

	local function okFunc()
		ShenJiChallengeAgent.instance:sendPM_ShenJiChallengeResetBossStageReq(self._activityId, self._bossId)
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
end

return OriginMoonShadowKingBossView
