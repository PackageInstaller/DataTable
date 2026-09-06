-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/nuoya/NuoyaShenqiChallengeView.lua

module("logic.extensions.noahchallenge.view.nuoya.NuoyaShenqiChallengeView", package.seeall)

local NuoyaShenqiChallengeView = class("NuoyaShenqiChallengeView", ViewComponent)

function NuoyaShenqiChallengeView:unbindEvents()
	NuoyaShenqiChallengeView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function NuoyaShenqiChallengeView:bindEvents()
	NuoyaShenqiChallengeView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function NuoyaShenqiChallengeView:buildUI()
	NuoyaShenqiChallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnTip = self:getBtn("btnTip")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtPay = self:getTxt("btnBuy/Text")
	self._goRole = self:getGo("role")
	self._birthdayTag = self:getGo("birthdayTag")
	self._txtBuff = self:getTxt("birthdayTag/txtBuff")
	self._listLevel = {}

	for i = 1, 12 do
		local itemLevel = {}

		itemLevel.go = self:getGo("listLevel/com_" .. i)
		itemLevel.eff1 = goutil.findChild(itemLevel.go, "eff1")
		itemLevel.eff2 = goutil.findChild(itemLevel.go, "eff2")
		itemLevel.txtStage = goutil.findChildTextComponent(itemLevel.go, "txtStage")
		itemLevel.bg = goutil.findChildComponent(itemLevel.go, "bg", "UIImageSpriteChange")
		self._listLevel[i] = itemLevel
	end
end

function NuoyaShenqiChallengeView:onEnter()
	NuoyaShenqiChallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeInfoRes, self._onNoahChallengeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeBuyEndRes, self._onNoahChallengeBuyEndRes, self)

	local param = self:getOpenParam()

	self._challengeId = param[1]
	self._petId = param[2]

	local isEnterFormMainView = param[3]

	self._curChallengeCfg = NoahChallengeConfig.instance:getChallengeCfg(self._challengeId)

	if not self._curChallengeCfg then
		return
	end

	self:_setTxtBtnBuy()
	NoahChallengeAgent.instance:sendPM_NoahChallengeInfoReq(self._challengeId)
	self:_createEff("20211126/shenqijinhua/fx_ui_shenqijinhua_beijing.prefab", self.mainGO, "mainBGEff")

	self._ableToClick = true

	if isEnterFormMainView then
		UIStateManager.instance:updateParms(ViewName.NuoyaShenqiChallenge, {
			self._challengeId,
			self._petId
		})

		local aniKey = "NuoyaShenqiChallenge"
		local aniUserData = checkint(GameUtil.getUserData(aniKey))

		if aniUserData <= 0 then
			AnimationPlayer.play("storyconfig/animations/shendijinhua_donghua.txt", self._onfinishPlayAni, nil, self)
			GameUtil.saveUserData(aniKey, 1)
		else
			self._ableToClick = false

			local animConfig = {
				animName = "shendijinhua_donghua",
				animFinishCallback = self._onfinishPlayAni,
				callbackTarget = self
			}

			ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
		end
	end

	GameUtil.SetActive(self._birthdayTag, self:_birthdayTagState())
	NoahChallengeAgent.instance:sendPM_NoahChallengeInfoReq(self._challengeId)
end

function NuoyaShenqiChallengeView:_onfinishPlayAni()
	self._ableToClick = true
end

function NuoyaShenqiChallengeView:onExit()
	NuoyaShenqiChallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NoahChallengeInfoRes, self._onNoahChallengeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NoahChallengeBuyEndRes, self._onNoahChallengeBuyEndRes, self)
	self:_removeEffect()
end

function NuoyaShenqiChallengeView:_onNoahChallengeInfoRes()
	self:_refreshView()
end

function NuoyaShenqiChallengeView:_onNoahChallengeBuyEndRes()
	self:_refreshView()
end

function NuoyaShenqiChallengeView:_onClickClose()
	self:close()
end

function NuoyaShenqiChallengeView:_onClickBuy()
	if not self._ableToClick then
		return
	end

	local isPassed = NoahChallengeModel.instance:isPassed(self._challengeId)

	if not isPassed then
		local cfgPay = NoahChallengeConfig.instance:getChallengePay(self._curChallengeCfg.payPlanId)

		if self._curChallengeCfg and cfgPay then
			PayController.instance:pay(cfgPay.payGoodsId, GameEnum.PaySubGoodsType.NOAHCHALLENGE, self._curChallengeCfg.challengeId)
		end
	else
		FloatWordMgr.instance:show(lang("noahchallenge_tip1"))
	end
end

function NuoyaShenqiChallengeView:_onClickChallenge()
	if not self._ableToClick then
		return
	end

	local isPassed = NoahChallengeModel.instance:isPassed(self._challengeId)

	if not isPassed then
		local curStage = NoahChallengeModel.instance:getCurStage(self._challengeId)

		curStage = curStage + 1

		UIStateManager.instance:open(ViewName.NuoyaShenqiEnterBattle, self._challengeId, curStage, self._petId)
	else
		FloatWordMgr.instance:show(lang("noahchallenge_tip1"))
	end
end

function NuoyaShenqiChallengeView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "nuoyashenqichallenge")
end

function NuoyaShenqiChallengeView:_refreshView()
	self:_refreshLevels()
	self:_refreshBtns()
end

function NuoyaShenqiChallengeView:_refreshLevels()
	local passedStage = NoahChallengeModel.instance:getCurStage(self._challengeId)
	local curStage = passedStage + 1

	for i, v in ipairs(self._listLevel) do
		if curStage == i then
			v.bg:SetState(0)
			self:_createEff("20211126/shenqijinhua/fx_ui_shenqijinhua_lan.prefab", v.eff1, "eff" .. i)
		elseif curStage < i then
			v.bg:SetState(0)
		else
			v.bg:SetState(1)
			self:_createEff("20211126/shenqijinhua/fx_ui_shenqijinhua_huang.prefab", v.eff1, "eff" .. i)
		end
	end
end

function NuoyaShenqiChallengeView:_refreshBtns()
	local isPassed = NoahChallengeModel.instance:isPassed(self._challengeId)

	GameUtil.SetGray(self._btnChallenge, isPassed)
	GameUtil.SetGray(self._btnBuy, isPassed)
end

function NuoyaShenqiChallengeView:_setTxtBtnBuy()
	if not self._curChallengeCfg then
		return
	end

	local cfgPay = NoahChallengeConfig.instance:getChallengePay(self._curChallengeCfg.payPlanId)
	local arr = string.split(cfgPay.payGoodsId, "_")

	self._txtPay.text = string.format("%s元一键通关", arr[2])
end

function NuoyaShenqiChallengeView:_birthdayTagState()
	local buffCfg = BattleConfig.instance:getBuffCo(self._curChallengeCfg.buff)

	if string.nilorempty(buffCfg.buffDesc) then
		return false
	else
		self._txtBuff.text = buffCfg.buffDesc

		local arr = string.split(self._curChallengeCfg.buffTime, "|")
		local str = string.split(arr[2], ",")
		local startTime, endTime = str[1], str[2]

		return GameUtil.checkIsInTimePeriod(startTime, endTime)
	end
end

function NuoyaShenqiChallengeView:_createEff(effPath, effParent, effKey)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	local newEff = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, true, false)

	newEff:setParent(effParent.transform)
	newEff:setScale(1)
	newEff:setLocalPos(0, 0, 0)

	self._exictEffs[effKey] = newEff
end

function NuoyaShenqiChallengeView:_removeEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

return NuoyaShenqiChallengeView
