-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minghuangchallenge/view/MinghuangmainView.lua

module("logic.extensions.minghuangchallenge.view.MinghuangmainView", package.seeall)

local MinghuangmainView = class("MinghuangmainView", TimeLimitedMainView)

function MinghuangmainView:unbindEvents()
	MinghuangmainView.super.unbindEvents(self)
	self._btnVerify:RemoveClickListener()
	self._btnExchangeStore:RemoveClickListener()
end

function MinghuangmainView:bindEvents()
	MinghuangmainView.super.bindEvents(self)
	self._btnVerify:AddClickListener(self._onClickVerify, self)
	self._btnExchangeStore:AddClickListener(self._onClickExchangeStore, self)
end

function MinghuangmainView:onExit()
	MinghuangmainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetVerifySuccess, self._updateBuffUI, self)
end

function MinghuangmainView:buildUI()
	MinghuangmainView.super.buildUI(self)

	self._challengeId = 147
	self._btnVerify = self:getBtn("buff/btnVerify")
	self._txtName = self:getTxt("info/txtName")
	self._btnExchangeStore = self:getBtn("btnExchangeStore")
end

function MinghuangmainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "",
			path = "fx_ui_xianshitiaozhan/fx_ui_aruisixianshitiaozhan_qifen.prefab"
		}
	}
end

function MinghuangmainView:onEnter()
	MinghuangmainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PetVerifySuccess, self._updateBuffUI, self)

	self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._challengeCfg.raceId)
	self._jumpParams = TimeLimitedConfig.instance:getCircleFightCfg(self._challengeId).params
	self._txtLeftTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._challengeId)
end

function MinghuangmainView:_updateCircleUI()
	MinghuangmainView.super._updateCircleUI(self)

	self._buffPlanId = self._circleCfg.buffPlanId

	PetverifyController.instance:getVerifyInfo(self._buffPlanId, GameUtil.handler(self._updateBuffUI, self))
end

function MinghuangmainView:_updateBuffUI()
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(self._buffPlanId)

	self._hasBuff = verifyCfg ~= nil

	self._txtNull:SetActive(not self._hasBuff)
	self._buffCell:setActive(self._hasBuff)
	self._buffCell:updateWithPetVerifyCfg(verifyCfg)
end

function MinghuangmainView:_onClickStart()
	if self._isEmpty then
		FloatWordMgr.instance:show("今天的挑战次数已经用完了")

		return
	end

	UIStateManager.instance:push(ViewName.MinghuangdetailView)
end

function MinghuangmainView:_onClickBuffTips()
	UIStateManager.instance:push(ViewName.PetverifytipView, self._buffPlanId)
end

function MinghuangmainView:_onClickVerify()
	if self._buffPlanId == nil then
		print("buffPlanId为空")

		return
	end

	UIStateManager.instance:push(ViewName.PetverifyView, self._buffPlanId)
end

function MinghuangmainView:_onClickRank()
	if not string.nilorempty(self._jumpParams.jumpToRank) then
		GotoMgr.gotoByString(self._jumpParams.jumpToRank)
	end
end

function MinghuangmainView:_onClickTry()
	if not string.nilorempty(self._jumpParams.jumpToGift) then
		GotoMgr.gotoByString(self._jumpParams.jumpToGift)
	end
end

function MinghuangmainView:_onClickExchange()
	if not string.nilorempty(self._jumpParams.jumpToLottery) then
		GotoMgr.gotoByString(self._jumpParams.jumpToLottery)
	end
end

function MinghuangmainView:_onClickExchangeStore()
	if not string.nilorempty(self._jumpParams.jumpToExchangeStore) then
		GotoMgr.gotoByString(self._jumpParams.jumpToExchangeStore)
	end
end

function MinghuangmainView:_activeTipRank()
	return
end

function MinghuangmainView:_activeTipTry()
	return
end

function MinghuangmainView:_activeTipExchange()
	return
end

function MinghuangmainView:_onTick()
	return
end

return MinghuangmainView
