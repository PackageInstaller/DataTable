-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/view/DoDragonChallengeBossView.lua

module("logic.extensions.dodragonchallenge.view.DoDragonChallengeBossView", package.seeall)

local DoDragonChallengeBossView = class("DoDragonChallengeBossView", ViewComponent)

function DoDragonChallengeBossView:buildUI()
	DoDragonChallengeBossView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnChallenge = goutil.findChild(self.mainGO, "btnChallenge/btn")
	self._btnChallengeEffRoot = goutil.findChild(self.mainGO, "btnChallenge/effRoot")
	self._btnPreview = goutil.findChild(self.mainGO, "btnPreview")
	self._txtRemain = goutil.findChildTextComponent(self.mainGO, "remain/txt")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txt")
	self._bloodSliderGo = goutil.findChild(self.mainGO, "bloodSlider")
	self._bloodSliderComp = self._bloodSliderGo:GetComponent(ComponentType.Slider)
	self._txtBlood = goutil.findChildTextComponent(self.mainGO, "bloodSlider/txtBlood")
	self._txtTotalBlood = goutil.findChildTextComponent(self.mainGO, "bloodSlider/txtTotalBlood")
	self._fitArea = {}

	local mainGo = goutil.findChild(self.mainGO, "bloodSlider/fitArea")

	self._fitArea._mainGo = mainGo
	self._fitArea._pointerUp = goutil.findChild(mainGo, "pointerUp")
	self._fitArea._pointerDown = goutil.findChild(mainGo, "pointerDown")
	self._fitArea._txtTips = goutil.findChild(mainGo, "txtTips")
	self._con = goutil.findChild(self.mainGO, "con")
end

function DoDragonChallengeBossView:bindEvents()
	DoDragonChallengeBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnPreview, self._onClickBtnPreview, self)
end

function DoDragonChallengeBossView:unbindEvents()
	DoDragonChallengeBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPreview)
end

function DoDragonChallengeBossView:onEnter()
	DoDragonChallengeBossView.super.onEnter(self)

	self._activityId = DoDragonChallengeController.instance:getActivityId()
	self._activityType = DoDragonChallengeController.instance:getActivityType()
	self._extremeData = DoDragonChallengeConfig.instance:getDdExtremeData(self._activityId)

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.DisorderDragonChallengeGetInfoRes, self._onUpdateUI, self)
	DoDragonChallengeController.instance:sendPM_DisorderDragonChallengeGetInfoReq(self._activityId)

	if DoDragonChallengeModel.instance:isRelifeAsBoss() and not DoDragonChallengeModel.instance:isHasPlayRelifeAnimAsBoss() then
		DoDragonChallengeModel.instance:setHasPlayRelifeAnimAsBoss(true)

		local info = {}

		info.tipsStr = "无序之神复活！"

		function info.callBack()
			return
		end

		UIStateManager.instance:push(ViewName.BossTrigger, info)
	end
end

function DoDragonChallengeBossView:onExit()
	DoDragonChallengeBossView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DisorderDragonChallengeGetInfoRes, self._onUpdateUI, self)
	UIEffectManager.instance:stopEffect(self._btnChallengeEff)
	self:_stopRole()
end

function DoDragonChallengeBossView:_onSetUI()
	local effParent = self._btnChallengeEffRoot
	local pathName = "fx_ui_fuli/fx_ui_fuli_lingqu"

	UIEffectManager.instance:stopEffect(self._btnChallengeEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._btnChallengeEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function DoDragonChallengeBossView:_onUpdateUI()
	self._hp = DoDragonChallengeModel.instance:getBossHpAsBoss(self._activityId)
	self._exchangId = DoDragonChallengeConfig.instance:getDdExchangeId(self._activityId, self._hp)
	self._exchangeData = DoDragonChallengeConfig.instance:getDdExchangeData(self._activityId, self._exchangId)

	local challengeTimes = DoDragonChallengeModel.instance:getChallengeTimesAsBoss(self._activityId)
	local totalChallengeTimes = DoDragonChallengeConfig.instance:getTotalChallengeTimes(self._activityId)
	local leftTimes = Mathf.Max(totalChallengeTimes - challengeTimes, 0)

	self._txtRemain.text = string.format("本日次数：%s/%s", leftTimes, totalChallengeTimes)

	local totalHp = DoDragonChallengeController.instance:getTotalHp(self._activityId)

	self._txtBlood.text = string.format("<color=#FFE797FF>%s</color>", self._hp)
	self._txtTotalBlood.text = string.format("%s", totalHp)
	self._bloodSliderComp.value = self._hp / totalHp

	local buffId = DoDragonChallengeModel.instance:getBuffIdAsBoss(self._activityId)
	local buffData = DoDragonChallengeConfig.instance:getDdBuffData(buffId)

	if buffData then
		self._txtBubble.text = buffData.des
	end

	local condition = self._extremeData.condition
	local totalHp = DoDragonChallengeController.instance:getTotalHp(self._activityId)
	local hpUp, hpDown = condition[1], condition[2]
	local yUp, yDown, yCenter = 0, 0, 0
	local height = GameUtil.getHeight(self._bloodSliderGo)

	if totalHp > 0 then
		yUp = hpUp / totalHp * height - height / 2
		yDown = hpDown / totalHp * height - height / 2
		yCenter = (hpUp / totalHp * height - height / 2 + (hpDown / totalHp * height - height / 2)) / 2
	end

	local pointerUpPos = GameUtil.getLocalPos(self._fitArea._pointerUp)
	local pointerDownPos = GameUtil.getLocalPos(self._fitArea._pointerDown)
	local tipsPos = GameUtil.getLocalPos(self._fitArea._txtTips)

	GameUtil.setLocalPos(self._fitArea._pointerUp, pointerUpPos.x, yUp, pointerUpPos.z)
	GameUtil.setLocalPos(self._fitArea._pointerDown, pointerDownPos.x, yDown, pointerDownPos.z)
	GameUtil.setLocalPos(self._fitArea._txtTips, tipsPos.x, yCenter, tipsPos.z)
	self:_loadRole()
	self:_checkPassAndPop()
end

function DoDragonChallengeBossView:_checkPassAndPop()
	local result, tips = DoDragonChallengeController.instance:getTryEnteryBossViewResultAndTips(self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		local text = tips

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindowNoX("提示", text, func, btnText, alignment)
	end
end

function DoDragonChallengeBossView:_loadRole()
	local skinId = self:_getCurSkinId()

	if skinId > 0 then
		local pos = self:_getCurPos()

		if not pos[1] then
			if not pos[2] then
				local y = 0

				if not pos[3] then
					local scale = 1

					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, pos[1], y)
				end
			end
		end
	else
		self:_stopRole()
	end
end

function DoDragonChallengeBossView:_stopRole()
	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function DoDragonChallengeBossView:_getCurSkinId()
	return self._exchangeData and self._exchangeData.skinId or DoDragonChallengeConfig.instance:getDdCommonValue("PET_SKINID", true)
end

function DoDragonChallengeBossView:_getCurPos()
	local pos = {}

	if self._exchangeData and self._exchangeData.pos then
		pos = self._exchangeData.pos
	else
		local value = DoDragonChallengeConfig.instance:getDdCommonValue("BOSS_DEFAULT_SKIN_POS", false)

		if not string.nilorempty(value) then
			pos = string.split(value, "#")
		end
	end

	return pos
end

function DoDragonChallengeBossView:_onClickBtnChallenge()
	self:_enterBattle(false)
end

function DoDragonChallengeBossView:_onClickBtnPreview()
	self:_enterBattle(true)
end

function DoDragonChallengeBossView:_enterBattle(isTry)
	local result, tips = DoDragonChallengeController.instance:getTryBossBtlResultAndTips(self._activityId, isTry)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.DoDragonChallengeMainView, nil)
	UIJumper.instance:pushOneStack(ViewName.DoDragonChallengeBossView, nil)
	DoDragonChallengeController.instance:enterBattleAsBoss(self._activityId, isTry)
end

return DoDragonChallengeBossView
