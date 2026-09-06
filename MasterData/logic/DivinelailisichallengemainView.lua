-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelailisi/view/DivinelailisichallengemainView.lua

module("logic.extensions.divinelailisi.view.DivinelailisichallengemainView", package.seeall)

local DivinelailisichallengemainView = class("DivinelailisichallengemainView", YuHuiChallengeMainView)

DivinelailisichallengemainView.ChallengeId = 180

function DivinelailisichallengemainView:ctor()
	DivinelailisichallengemainView.super.ctor(self)
end

function DivinelailisichallengemainView:unbindEvents()
	DivinelailisichallengemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivinelailisichallengemainView:bindEvents()
	DivinelailisichallengemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function DivinelailisichallengemainView:buildUI()
	DivinelailisichallengemainView.super.buildUI(self)

	self._btnBuff = self:getBtn("btnBuff")
	self._buffText = self:getTxt("btnBuff/txtBuff")
	self._buffRed = self:getGo("btnBuff/redPoint")
	self._txtName = self:getTxt("petInfo/txtName")
	self._curChallengeId = DivinelailisichallengemainView.ChallengeId
end

function DivinelailisichallengemainView:onExit()
	DivinelailisichallengemainView.super.onExit(self)
end

function DivinelailisichallengemainView:onEnter()
	DivinelailisichallengemainView.super.onEnter(self)
	self:addGEvent(GlobalNotify.YuHuiCallengeGetInfo, self._onRefreshUI)
	self:_onRefreshUI()
end

function DivinelailisichallengemainView:_onRefreshUI()
	local cfg = YuHuiChallengeConfig.instance:getChallengeCfgById(self._curChallengeId) or {}
	local signInBuffPlanId = cfg.signInBuffPlanId
	local info = YuHuiChallengeModel.instance:getInfo(self._curChallengeId) or {}
	local signInBuffLv = info.signInBuffLv
	local isSignIn = info.isSignIn
	local buffCfg = YuHuiChallengeConfig.instance:getSingBuffCfgs(signInBuffPlanId, signInBuffLv)

	self._buffText.text = buffCfg == nil and "未获得加成" or buffCfg.desc

	self._buffRed:SetActive(not isSignIn)
end

function DivinelailisichallengemainView:_onClickEnter()
	UIStateManager.instance:push(ViewName.DivinelailisichallengelevelView, self._curChallengeId)
end

function DivinelailisichallengemainView:_onClickBuff()
	local info = YuHuiChallengeModel.instance:getInfo(self._curChallengeId) or {}
	local isSignIn = info.isSignIn

	if isSignIn then
		FloatWordMgr.instance:show("今日加成已生效")

		return
	end

	YuHuiChallengeController.instance:sendSignBuff(self._curChallengeId)
end

function DivinelailisichallengemainView:setPetInfo()
	DivinelailisichallengemainView.super.setPetInfo(self)

	self._txtName.text = ""

	if self._skinCfg then
		self._txtName.text = self._skinCfg.skinName
	end
end

function DivinelailisichallengemainView:_onClickTip()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(DivinelailisichallengemainView.ChallengeId)

	UIStateManager.instance:push(ViewName.RulesView, challengeCfg.ruleKey)
end

return DivinelailisichallengemainView
