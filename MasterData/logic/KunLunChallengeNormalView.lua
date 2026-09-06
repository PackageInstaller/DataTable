-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/view/KunLunChallengeNormalView.lua

module("logic.extensions.kunlunchallenge.view.KunLunChallengeNormalView", package.seeall)

local KunLunChallengeNormalView = class("KunLunChallengeNormalView", ViewComponent)

function KunLunChallengeNormalView:buildUI()
	KunLunChallengeNormalView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._con = goutil.findChild(self.mainGO, "con")
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._btnClg_btn = goutil.findChild(self.mainGO, "btnClg/btn")
	self._btnClg_btn_redpoint = goutil.findChild(self.mainGO, "btnClg/btn/redpoint")
	self._btnClg_txtLeftClgTimes = goutil.findChildTextComponent(self.mainGO, "btnClg/txtLeftClgTimes")

	local worldRoot = self:getGo("worldRoot")

	self._worldSliderMo = WorldSliderMo.New(worldRoot)
	self._txtWorldScore = goutil.findChildTextComponent(self.mainGO, "worldRoot/worldPrize/score/txtScore")
end

function KunLunChallengeNormalView:bindEvents()
	KunLunChallengeNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg_btn, self._onClickBtnClg, self)
	self._worldSliderMo:bindEvents()
end

function KunLunChallengeNormalView:unbindEvents()
	KunLunChallengeNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg_btn)
	self._worldSliderMo:unbindEvents()
end

function KunLunChallengeNormalView:onEnter()
	KunLunChallengeNormalView.super.onEnter(self)

	self._activityId = KunLunChallengeController.instance:getActivityId()
	self._activityType = KunLunChallengeController.instance:getActivityType()

	local isInTime = KunLunChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	self._actData = KunLunChallengeConfig.instance:getKlActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.KunLunCommonClgInfoRes, self._onUpdate, self)
	self:_sendInfoReq()
end

function KunLunChallengeNormalView:onExit()
	KunLunChallengeNormalView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClearSliderCol()
end

function KunLunChallengeNormalView:_sendInfoReq()
	KunLunChallengeController.instance:sendPM_KunLunCommonClgInfoReq(self._activityId)
end

function KunLunChallengeNormalView:_onSetUI()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	self:_initScoreSlider()
end

function KunLunChallengeNormalView:_onUpdate()
	self:_onUpdatePlaneUI()
	self:_onUpdateSliderColUI()
end

function KunLunChallengeNormalView:_onUpdatePlaneUI()
	local isPass = KunLunChallengeController.instance:isPassOfNorClg()

	if isPass then
		self._btnClg_txtLeftClgTimes.text = string.format("已通关")
	else
		local leftTimes = KunLunChallengeController.instance:getLeftDailyTimesOfNorClg(self._activityId)
		local maxTimes = KunLunChallengeController.instance:getMaxDailyTimesOfNorClg(self._activityId)

		self._btnClg_txtLeftClgTimes.text = string.format("今日挑战次数：%s/%s", leftTimes, maxTimes)
	end
end

function KunLunChallengeNormalView:_getSkinId()
	return KunLunChallengeController.instance:getSkinId(self._activityId)
end

function KunLunChallengeNormalView:_onUpdateSliderColUI()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function KunLunChallengeNormalView:_onClearSliderCol()
	self._worldSliderMo:onExit()
end

function KunLunChallengeNormalView:_initScoreSlider()
	local worldParam = {}

	worldParam.view = self
	worldParam.isShowDefaultPos = true
	worldParam.elementSpacing = 90
	worldParam.isUpToBottom = true
	worldParam.prizeCfgs = KunLunChallengeConfig.instance:getKlDamageDataList(self._activityId)

	function worldParam.getWorldProgress()
		return KunLunChallengeController.instance:getBossLeftHpOfNorClg()
	end

	function worldParam.getNeedScoreByRewardCfg(data)
		return data.bossLeftHp
	end

	function worldParam.isWorldRewardCanGet(data)
		return false
	end

	function worldParam.isWorldRewardGeted(data)
		return KunLunChallengeController:isHasGainPrizeInProgressOfNorClg(data.activityId, data.prizeId)
	end

	function worldParam.sendGainWorldPrizeReq(data)
		return
	end

	function worldParam.getPrizeText(rewardCfg)
		return string.format("%d%%", KunLunChallengeController.instance:getBossLeftHpOfNorClg() / 100)
	end

	function worldParam.getScoreTxtByCfg(data)
		return string.format("%d%%", data.bossLeftHp / 100)
	end

	worldParam.txtWorldScore = self._txtWorldScore
	worldParam.worldSliderEndOffset = 10

	self._worldSliderMo:initParam(worldParam)
	self._worldSliderMo:onEnter()
	self._worldSliderMo:updateWorldReward()
	self._worldSliderMo:relocation()
end

function KunLunChallengeNormalView:_onClickBtnTip()
	local key = KunLunChallengeConfig.instance:getClientCommonValue(self._activityId, "KUNLUNCHALLENGE_RULE_NORMAL_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

function KunLunChallengeNormalView:_onClickBtnClg()
	local result, tips = KunLunChallengeController.instance:getTryFightOfNorClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	KunLunChallengeController.instance:enterBattleOfNorClg(self._activityId)
end

return KunLunChallengeNormalView
