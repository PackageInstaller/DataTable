-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealMainView.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealMainView", package.seeall)

local LsqOrdealMainView = class("LsqOrdealMainView", ViewComponent)

function LsqOrdealMainView:ctor()
	LsqOrdealMainView.super.ctor(self)
end

function LsqOrdealMainView:buildUI()
	LsqOrdealMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnAdd = self:getBtn("btnAdd")
	self._btnRank = self:getBtn("btnRank")
	self._btnBox = self:getBtn("bigReward/btnBox")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtRemain = self:getTxt("txtRemain")
	self._txtGiftProgress = self:getTxt("bigReward/txtNum")
	self._slider = self:getSlider("bigReward/slider")

	local playerRoot = self:getGo("playerReward")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtPlayerScore = self:getTxt("playerReward/txtPlayerScore")
	self._bgEffectGo = self:getGo("bgEffect")
	self._boxEffectGo = self:getGo("bigReward/boxEffect")
	self._tipsRoot = self:getGo("tipsRoot")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
end

function LsqOrdealMainView:bindEvents()
	LsqOrdealMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnBox:AddClickListener(self._onClickBox, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function LsqOrdealMainView:unbindEvents()
	LsqOrdealMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnBox:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function LsqOrdealMainView:onEnter()
	LsqOrdealMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayBuyPlayNumRes, self._onBuyGameNum, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayGameProgressPrizeRes, self._onGameProgressPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayChangeActivity, self._onChangeActivity, self)

	self._activityId = LuoShiQiOrdealModel.instance:getActivityId()
	self._activityType = GameEnum.ActivityType.XiaoNuoBirthdayGift

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		local title = lang("tip")
		local text = lang("outtime")

		local function func()
			self:_onClickClose()
		end

		TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)

		return
	end

	self._cfgActivity = LuoShiQiOrdealConfig.instance:getActivityCfg(self._activityId)
	self._maxGameNum = self._cfgActivity.freeNum
	self._maxGiftProgress = self._cfgActivity.giftProgressMax
	self._maxBuyNum = self._cfgActivity.buyNum

	self:_initView()
	self:_loadBgEffect()
	XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayGetInfoReq(self._activityId)
end

function LsqOrdealMainView:onExit()
	LsqOrdealMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayBuyPlayNumRes, self._onBuyGameNum, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayGameProgressPrizeRes, self._onGameProgressPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayChangeActivity, self._onChangeActivity, self)
	self._playerSliderMo:onExit()
	self:_removeBgEffect()
	self:_removeBoxEffect()
end

function LsqOrdealMainView:_onClickClose()
	self:close()
end

function LsqOrdealMainView:_onClickChallenge()
	local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

	if curLeftNum > 0 then
		UIStateManager.instance:push(ViewName.LsqOrdealLevelView, self._activityId)
	else
		local curBoughtNum = LuoShiQiOrdealModel.instance:getBuyGameNum()

		if curBoughtNum < self._maxBuyNum then
			self:_onClickAdd()
		else
			FloatWordMgr.instance:show(lang("nogamenumber"))
		end
	end
end

function LsqOrdealMainView:_onClickAdd()
	local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

	if curLeftNum > 0 then
		FloatWordMgr.instance:show(lang("lsqordeal_desc1"))

		return
	end

	local curBoughtNum = LuoShiQiOrdealModel.instance:getBuyGameNum()

	if curBoughtNum < self._maxBuyNum then
		local title = lang("tip")
		local matType, id, matNum = MaterialMgr.getMatParams(self._cfgActivity.buyCost)
		local str = langPara("lsqordeal_desc2", "<quad name=%s:%s|icon size=40 width=1 offsetY=-5/>*%d")
		local text = string.format(str, matType, id, matNum)

		local function okFunc()
			XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayBuyPlayNumReq(self._activityId)
		end

		TipsFacade.instance:openPopupWindow(title, text, okFunc, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		FloatWordMgr.instance:show(lang("nobuynumber"))
	end
end

function LsqOrdealMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LsqOrdealRankView, self._activityId)
end

function LsqOrdealMainView:_onClickBox()
	if not LuoShiQiOrdealModel.instance:isGainGift() then
		if LuoShiQiOrdealModel.instance:getGiftProgress() >= self._maxGiftProgress then
			UIStateManager.instance:push(ViewName.LsqOrdealBoxGameView, self._activityId)
		else
			FloatWordMgr.instance:show(lang("lsqordeal_desc3"))
		end
	else
		FloatWordMgr.instance:show(lang("lsqordeal_desc4"))
	end
end

function LsqOrdealMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "lsqordealmainview_rule_1")
end

function LsqOrdealMainView:_onGetInfoRes()
	self:_updateView()
end

function LsqOrdealMainView:_onBuyGameNum()
	self:_updateLeftGameNum()
end

function LsqOrdealMainView:_onGameProgressPrizeRes()
	self:_updateReward()
end

function LsqOrdealMainView:_onChangeActivity()
	self._activityId = LuoShiQiOrdealModel.instance:getActivityId()
	self._cfgActivity = LuoShiQiOrdealConfig.instance:getActivityCfg(self._activityId)
	self._maxGameNum = self._cfgActivity.freeNum
	self._maxGiftProgress = self._cfgActivity.giftProgressMax
	self._maxBuyNum = self._cfgActivity.buyNum

	XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayGetInfoReq(self._activityId)
end

function LsqOrdealMainView:_initView()
	self:_initPlayerParams()

	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	if LuoShiQiOrdealConfig.instance:getRankNormalCfg(self._activityId) or LuoShiQiOrdealConfig.instance:getRankCrazyCfg(self._activityId) then
		GameUtil.SetActive(self._btnRank, true)
	else
		GameUtil.SetActive(self._btnRank, false)
	end

	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function LsqOrdealMainView:_updateView()
	self:_updateLeftGameNum()
	self:_updateReward()
	self:_updateGiftProgress()
end

function LsqOrdealMainView:_updateLeftGameNum()
	local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

	self._txtRemain.text = langPara("lsqordeal_desc5", curLeftNum, self._maxGameNum)
end

function LsqOrdealMainView:_updateReward()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
end

function LsqOrdealMainView:_updateGiftProgress()
	local curNum = LuoShiQiOrdealModel.instance:getGiftProgress()

	self._txtGiftProgress.text = string.format(lang("lsqordeal_desc6") .. "：<color=#FAF6B4FF>%d/%d</color>", curNum, self._maxGiftProgress)

	local percent = curNum / self._maxGiftProgress

	self._slider:SetValue(Mathf.Clamp01(percent))

	if percent >= 1 and not LuoShiQiOrdealModel.instance:isGainGift() then
		self:_loadBoxEffect()
	else
		self:_removeBoxEffect()
	end
end

function LsqOrdealMainView:_setPlayerScore()
	self._txtPlayerScore.text = LuoShiQiOrdealModel.instance:getScoreProgress()
end

function LsqOrdealMainView:_initPlayerParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = LuoShiQiOrdealConfig.instance:getGameProgressCfgList(self._cfgActivity.gamePrizePlan)

	function playerParam.getPlayerProgress()
		return LuoShiQiOrdealModel.instance:getScoreProgress()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.score
	end

	function playerParam.getPrizeByRewardCfg(rewardCfg)
		local prizes = string.split(rewardCfg.gain, "#")

		return prizes[1]
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return LuoShiQiOrdealModel.instance:isPlayerRewardCanGet(rewardCfg.prizeId, rewardCfg.score)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return LuoShiQiOrdealModel.instance:isPlayerRewardGeted(rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayGameProgressPrizeReq(self._activityId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function LsqOrdealMainView:_loadBgEffect()
	self:_removeBgEffect()

	local effName = LsqOrdealMainViewPresentor.Effect1

	self._uiBgEffect = UIEffectManager.instance:playEffect(self, effName, self._bgEffectGo.transform, 0, 0, true, false)

	self._uiBgEffect:setLocalPos(0, 0, 0)
	self._uiBgEffect:setScale(1)
	self._uiBgEffect:setParent(self._bgEffectGo.transform)
end

function LsqOrdealMainView:_removeBgEffect()
	if self._uiBgEffect then
		UIEffectManager.instance:stopEffect(self._uiBgEffect)

		self._uiBgEffect = nil
	end
end

function LsqOrdealMainView:_loadBoxEffect()
	self:_removeBoxEffect()

	local effName = LsqOrdealMainViewPresentor.Effect2

	self._uiBoxEffect = UIEffectManager.instance:playEffect(self, effName, self._boxEffectGo.transform, 0, 0, true, false)

	self._uiBoxEffect:setLocalPos(0, 0, 0)
	self._uiBoxEffect:setScale(1)
	self._uiBoxEffect:setParent(self._boxEffectGo.transform)
end

function LsqOrdealMainView:_removeBoxEffect()
	if self._uiBoxEffect then
		UIEffectManager.instance:stopEffect(self._uiBoxEffect)

		self._uiBoxEffect = nil
	end
end

return LsqOrdealMainView
