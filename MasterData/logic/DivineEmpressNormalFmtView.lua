-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressNormalFmtView.lua

module("logic.extensions.divineempress.view.DivineEmpressNormalFmtView", package.seeall)

local DivineEmpressNormalFmtView = class("DivineEmpressNormalFmtView", ViewComponent)

function DivineEmpressNormalFmtView:ctor()
	DivineEmpressNormalFmtView.super.ctor(self)
end

function DivineEmpressNormalFmtView:unbindEvents()
	DivineEmpressNormalFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCard)
	GameUtil.rmClickHandler(self._btnRandom)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineEmpressNormalFmtView:bindEvents()
	DivineEmpressNormalFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
	GameUtil.addClickHandler(self._btnRandom, self._onClickRandom, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function DivineEmpressNormalFmtView:buildUI()
	DivineEmpressNormalFmtView.super.buildUI(self)

	self._nomalRule = self:getGo("cardInfo/nomalRule")
	self._imgNomal = self:getGo("cardInfo/nomalRule/imgType")
	self._txtBuffDesc = self:getTxt("cardInfo/nomalRule/desc")
	self._nomalAnimator = self._nomalRule:GetComponent("Animator")
	self._btnSure = self:getGo("cardInfo/btnSure")
	self._effect = self:getGo("cardInfo/effect")
	self._cardInfo = self:getGo("cardInfo")
	self._btnRandom = self:getGo("cardInfo/btnRandom")
	self._btnCard = self:getGo("btnCard")
	self._mask = self:getGo("cardInfo/mask")
	self._txtRandomCount = self:getTxt("cardInfo/txtRandomCount")
	self._buffDesc = self:getGo("buffDesc")
	self._txtDesc = self:getTxt("buffDesc/txtDesc")
end

function DivineEmpressNormalFmtView:onExit()
	DivineEmpressNormalFmtView.super.onExit(self)
	uGuiUtil.clearImage(self._imgNomal)

	if self._showEffectHandler then
		UIEffectManager.instance:stopEffect(self._showEffectHandler)

		self._showEffectHandler = nil
	end

	removetimer(self._playRuleEffectEnd, self)
end

function DivineEmpressNormalFmtView:onEnter()
	DivineEmpressNormalFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineEmpressResetNormalClgBuffRes, self._PM_DivineEmpressResetNormalClgBuffRes, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo.activityId
	self._stageId = self._fmtMo.stageId

	self:_hideEffectInfo()
	self:_refreshEffectInfo()
	self:_startAminEffectShow()

	if not DivineEmpressModel.instance:getShowNormalClgDailyEffect(self._activityId, self._stageId) then
		-- block empty
	end
end

function DivineEmpressNormalFmtView:_refreshEffectInfo()
	local stageInfo = DivineEmpressModel.instance:getNormalStageInfo(self._activityId, self._stageId)
	local buffCfg = DivineEmpressConfig.instance:getNormalBuffCfg(self._activityId, stageInfo.buffId)

	uGuiUtil.clearImage(self._imgNomal)

	if not string.nilorempty(buffCfg.rulePath) then
		uGuiUtil.setSpriteToImage(self._imgNomal, nil, GameUrl.getIconFolderUrl("familytech", buffCfg.rulePath))
	end

	self._txtBuffDesc.text = buffCfg.desc
	self._txtDesc.text = buffCfg.desc
	self._txtRandomCount.text = langPara("剩余次数:%d", DivineEmpressModel.instance:getLeftDailyResetTimes(self._activityId))
end

function DivineEmpressNormalFmtView:_startAminEffectShow()
	GameUtil.SetActive(self._btnCard, false)
	GameUtil.SetActive(self._buffDesc, false)
	GameUtil.SetActive(self._btnRandom, false)
	GameUtil.SetActive(self._btnSure, false)
	GameUtil.SetActive(self._txtRandomCount, false)
	GameUtil.SetActive(self._effect, true)
	GameUtil.SetActive(self._mask, true)
	GameUtil.SetActive(self._cardInfo, true)
	settimer(0.7, self._playRuleEffectEnd, self, false)

	self._nomalAnimator.enabled = true

	local name = UnityEngine.Animator.StringToHash("nomalrule")

	self._nomalAnimator:Play(name, 0, 0)
end

function DivineEmpressNormalFmtView:_showEffectInfo()
	GameUtil.SetActive(self._btnCard, false)
	GameUtil.SetActive(self._buffDesc, false)
	GameUtil.SetActive(self._cardInfo, true)
	GameUtil.SetActive(self._mask, true)
	GameUtil.SetActive(self._btnRandom, true)
	GameUtil.SetActive(self._btnSure, true)
	GameUtil.SetActive(self._txtRandomCount, true)
	GameUtil.SetActive(self._effect, true)
end

function DivineEmpressNormalFmtView:_hideEffectInfo()
	GameUtil.SetActive(self._btnCard, true)
	GameUtil.SetActive(self._buffDesc, true)
	GameUtil.SetActive(self._cardInfo, false)
end

function DivineEmpressNormalFmtView:_playRuleEffectEnd()
	GameUtil.SetActive(self._btnRandom, true)
	GameUtil.SetActive(self._btnSure, true)
	GameUtil.SetActive(self._txtRandomCount, true)
	UIEffectManager.instance:stopEffect(self._showEffectHandler)

	self._showEffectHandler = nil
	self._nomalAnimator.enabled = false
end

function DivineEmpressNormalFmtView:_onClickCard()
	self:_showEffectInfo()
end

function DivineEmpressNormalFmtView:_onClickRandom()
	if DivineEmpressModel.instance:getLeftDailyResetTimes(self._activityId) > 0 then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否消耗1次重新占卜次数，重新随机占卜结果？"), function()
			DivineEmpressChallengeAgent.instance:sendPM_DivineEmpressResetNormalClgBuffReq(self._activityId, self._stageId)
		end)
	else
		FloatWordMgr.instance:show(lang("今日已无重新占卜次数"))
	end
end

function DivineEmpressNormalFmtView:_onClickSure()
	self:_hideEffectInfo()
end

function DivineEmpressNormalFmtView:_PM_DivineEmpressResetNormalClgBuffRes()
	self:_refreshEffectInfo()
	self:_startAminEffectShow()
end

return DivineEmpressNormalFmtView
