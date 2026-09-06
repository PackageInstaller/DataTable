-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/view/YuHuiChallengeLevelView.lua

module("logic.extensions.yuhuichallenge.view.YuHuiChallengeLevelView", package.seeall)

local YuHuiChallengeLevelView = class("YuHuiChallengeLevelView", ViewComponent)

function YuHuiChallengeLevelView:buildUI()
	YuHuiChallengeLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnLeft = self:getGo("balance/btnLeft")
	self._txtDescLeft = goutil.findChildTextComponent(self._btnLeft, "bg/desc/txt")
	self._btnRight = self:getGo("balance/btnRight")
	self._txtDescRight = goutil.findChildTextComponent(self._btnRight, "bg/desc/txt")
	self._txtValue = self:getTxt("balance/value/txt")
	self._txtBuff = self:getTxt("balance/buff/txt")
	self._btnReset = self:getGo("btnReset")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtCurLevelMax = self:getTxt("curLevelMax/txt")
	self._iconReward = self:getGo("reward/item/icon")
	self._txtNumReward = self:getTxt("reward/item/txtNum")
	self._receiveReward = self:getGo("reward/receive")
	self._bubbleReward = self:getGo("reward/bubble")
	self._sldLevel = self:getSlider("level/slider")
	self._txtBottomLevel = self:getTxt("level/txtBottom")
	self._txtTopLevel = self:getTxt("level/txtTop")
	self._txtCurLevel = self:getTxt("level/slider/FillArea/info/txtLevel")
	self._curChallengeId = 107
end

function YuHuiChallengeLevelView:bindEvents()
	YuHuiChallengeLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
end

function YuHuiChallengeLevelView:unbindEvents()
	YuHuiChallengeLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function YuHuiChallengeLevelView:onEnter()
	YuHuiChallengeLevelView.super.onEnter(self)

	self._curChallengeId = checknumber(self:getFirstParam())

	YuHuiChallengeModel.instance:ShowCI()
	self:_refreshViewByCfg()
	self:_refreshViewByInfo()
	GlobalDispatcher:addListener(GlobalNotify.YuHuiCallengeError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.YuHuiCallengeGetInfo, self._refreshViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.YuHuiCallengeReset, self._refreshViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.YuHuiCallengeFightEnd, self._refreshViewByInfo, self)
end

function YuHuiChallengeLevelView:onExit()
	YuHuiChallengeLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.YuHuiCallengeError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.YuHuiCallengeGetInfo, self._refreshViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.YuHuiCallengeReset, self._refreshViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.YuHuiCallengeFightEnd, self._refreshViewByInfo, self)
	MaterialMgr.resetAll(self._iconReward)
end

function YuHuiChallengeLevelView:_onClickClose()
	self:close()
end

function YuHuiChallengeLevelView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "Yu_Hui_Challenge_Level_Rule")
end

function YuHuiChallengeLevelView:_onClickReset()
	TipsFacade.instance:openPopupWindow(lang("通知"), lang("是否进行关卡重置，重置后进度将归零，并且奖励无法重复获得"), function()
		YuHuiChallengeController.instance:challengeReset(self._curChallengeId)
		FloatWordMgr.instance:show(lang("重置成功"))
	end)
end

function YuHuiChallengeLevelView:_onClickLeft()
	if self._isAllPass then
		FloatWordMgr.instance:show(lang("已全部通关"))

		return
	end

	if self._leftModeCfg then
		local mo = YuHuiChallengeModel.instance:getCustomFmtMo()

		mo:initParams(self._leftModeCfg, self._curChallengeId)
		CustomFmtController.instance:showMissionView(mo)
	end
end

function YuHuiChallengeLevelView:_onClickRight()
	if self._isAllPass then
		FloatWordMgr.instance:show(lang("已全部通关"))

		return
	end

	if self._rightModeCfg then
		local mo = YuHuiChallengeModel.instance:getCustomFmtMo()

		mo:initParams(self._rightModeCfg, self._curChallengeId)
		CustomFmtController.instance:showMissionView(mo)
	end
end

function YuHuiChallengeLevelView:_onError(status)
	return
end

function YuHuiChallengeLevelView:_refreshViewByCfg()
	self._challengeCfg = YuHuiChallengeConfig.instance:getChallengeCfgById(self._curChallengeId)
	self._stageCfgs = YuHuiChallengeConfig.instance:getStageCfgs(self._challengeCfg.stagePlanId)
	self._buffCfgs = YuHuiChallengeConfig.instance:getBuffCfgs(self._challengeCfg.buffPlanId)
end

function YuHuiChallengeLevelView:_refreshViewByInfo()
	self._curBalanceValue = YuHuiChallengeModel.instance:getBalanceValue(self._curChallengeId)
	self._curStageId = YuHuiChallengeModel.instance:getCurStageId(self._curChallengeId)
	self._maxStageId = YuHuiChallengeModel.instance:getMaxStageId(self._curChallengeId)

	self:_refreshLevelPart()
	self:_refreshBalancePart()
end

function YuHuiChallengeLevelView:_refreshBalancePart()
	self._txtValue.text = langPara("平衡值：%s", self._curBalanceValue)

	local buffCfg = self._buffCfgs[self._curBalanceValue]

	if buffCfg and not string.nilorempty(buffCfg.desc) then
		if not buffCfg.desc then
			self._txtBuff.text = lang("无")

			local offY = Mathf.Clamp(self._curBalanceValue * 2, -60, 60)

			GameUtil.setAnchoredPos(self._btnLeft, -240, -60 + offY)
			GameUtil.setAnchoredPos(self._btnRight, 240, -60 - offY)

			if self._leftModeCfg then
				self._txtDescLeft.text = self._leftModeCfg.balanceValue < 0 and langPara("平衡值%s", self._leftModeCfg.balanceValue) or langPara("平衡值+%s", self._leftModeCfg.balanceValue)
			end

			if self._rightModeCfg then
				self._txtDescRight.text = self._rightModeCfg.balanceValue < 0 and langPara("平衡值%s", self._rightModeCfg.balanceValue) or langPara("平衡值+%s", self._rightModeCfg.balanceValue)
			end
		end
	end
end

function YuHuiChallengeLevelView:_refreshLevelPart()
	if #self._stageCfgs < self._curStageId then
		if not #self._stageCfgs then
			local stageId = self._curStageId

			self._isAllPass = #self._stageCfgs < self._curStageId

			if not self._stageCfgs[stageId] then
				local stageCfg = {}

				self._txtCurLevelMax.text = self._maxStageId

				goutil.setActive(self._bubbleReward, stageId > self._maxStageId)
				goutil.setActive(self._receiveReward, stageId <= self._maxStageId)
				MaterialMgr.resetAll(self._iconReward)

				local matType, matId, matNum = MaterialMgr.getMatParams(stageCfg.passPrize)

				self._txtNumReward.text = matNum

				MaterialMgr.setIcon(self._iconReward, matType, matId)

				self._txtCurLevel.text = langPara("当前第%s关", stageId)
				self._txtTopLevel.text = langPara("%s关", #self._stageCfgs)

				self._sldLevel:SetValue((#self._stageCfgs > 1 or nil) and checknumber(stageId - 1) / checknumber(#self._stageCfgs - 1))

				local modeCfgs = YuHuiChallengeConfig.instance:getStageModeCfgs(stageCfg.stageModePlanId)

				self._leftModeCfg = modeCfgs and modeCfgs[1]
				self._rightModeCfg = modeCfgs and modeCfgs[2]
			end
		end
	end
end

return YuHuiChallengeLevelView
