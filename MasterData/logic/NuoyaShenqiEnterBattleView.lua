-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/nuoya/NuoyaShenqiEnterBattleView.lua

module("logic.extensions.noahchallenge.view.nuoya.NuoyaShenqiEnterBattleView", package.seeall)

local NuoyaShenqiEnterBattleView = class("NuoyaShenqiEnterBattleView", ViewComponent)

function NuoyaShenqiEnterBattleView:ctor()
	NuoyaShenqiEnterBattleView.super.ctor(self)
end

function NuoyaShenqiEnterBattleView:bindEvents()
	NuoyaShenqiEnterBattleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function NuoyaShenqiEnterBattleView:unbindEvents()
	NuoyaShenqiEnterBattleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function NuoyaShenqiEnterBattleView:buildUI()
	NuoyaShenqiEnterBattleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtTip1 = self:getTxt("txtTips1/txt")
	self._txtTip2 = self:getTxt("txtTips2/txt")
	self._txtLevel = self:getTxt("txtLevel")
	self._txtZdl = self:getGo("power/txtNum"):GetComponent("UIImgNumeralText")
	self._wenhao = self:getGo("wenhao")
	self._blurBg = self:getGo("mask"):GetComponent(typeof(StaticBluredScreen))
end

function NuoyaShenqiEnterBattleView:onEnter()
	NuoyaShenqiEnterBattleView.super.onEnter(self)

	local param = self:getOpenParam()

	self._challengeId = param[1]
	self._curStage = param[2]
	self._petId = param[3]

	self:_refreshView()
	self._blurBg:Release()
	self._blurBg:Capture()
	self:_createEff("20211126/shenqijinhua/fx_ui_shenqijinhua_beijing2.prefab", self.mainGO, "mainBGEff")
end

function NuoyaShenqiEnterBattleView:onExit()
	NuoyaShenqiEnterBattleView.super.onExit(self)
	self._blurBg:Release()
	self:_removeAllEffect()
	removetimer(self._onFinishAni, self)
	removetimer(self._playShuiziEff, self)
end

function NuoyaShenqiEnterBattleView:_refreshView()
	local cfgChallenge = NoahChallengeConfig.instance:getChallengeCfg(self._challengeId)

	self._cfgStage = NoahChallengeConfig.instance:getChallengeStage(cfgChallenge.challengePlanId, self._curStage)
	self._txtLevel.text = GameUtil.toRomanNumber(self._curStage)

	self:_playAni()
end

function NuoyaShenqiEnterBattleView:_onClickClose()
	self:close()
end

function NuoyaShenqiEnterBattleView:_onClickChallenge()
	self:close()
	UIStateManager.instance:push(ViewName.NoahMissionView, self._challengeId, self._curStage, self._petId)
end

function NuoyaShenqiEnterBattleView:_playAni()
	self._txtTip1.text = ""
	self._txtTip2.text = ""

	goutil.setActive(self._wenhao, true)
	goutil.setActive(self._txtZdl.gameObject, false)
	settimer(0.4, self._playShuiziEff, self, false)
end

function NuoyaShenqiEnterBattleView:_playShuiziEff()
	goutil.setActive(self._wenhao, false)

	self._txtTip1.text = self._cfgStage.missionDesc
	self._txtTip2.text = self._cfgStage.WinDesc

	self:_createEff("20211126/shenqijinhua/fx_ui_shenqijinhua_shuzi.prefab", self:getGo("power/effPos"), "playeff")
	settimer(0.8, self._onFinishAni, self, false)
end

function NuoyaShenqiEnterBattleView:_onFinishAni()
	goutil.setActive(self._txtZdl.gameObject, true)
	self._txtZdl:SetText(self._cfgStage.power)
	self:_removeEffect("playeff")
end

function NuoyaShenqiEnterBattleView:_createEff(effPath, effParent, effKey)
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

function NuoyaShenqiEnterBattleView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function NuoyaShenqiEnterBattleView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

return NuoyaShenqiEnterBattleView
