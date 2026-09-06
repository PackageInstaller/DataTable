-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/tutorsystem/TutorSystemView.lua

module("logic.extensions.bonus.view.tutorsystem.TutorSystemView", package.seeall)

local TutorSystemView = class("TutorSystemView", ViewComponent)

function TutorSystemView:ctor()
	TutorSystemView.super.ctor(self)
end

function TutorSystemView:bindEvents()
	TutorSystemView.super.bindEvents(self)
	self._gotoBtn:AddClickListener(function()
		GotoMgr.gotoByString("func#623")
	end, self)
	GameUtil.asBtn(self._clickGo):AddClickListener(function()
		if self._curState == 0 then
			FloatWordMgr.instance:show("还未结成师徒关系，不可领取")

			return
		end

		if self._curState == 2 then
			FloatWordMgr.instance:show("已领取了奖励")

			return
		end

		TutorActvityAgent.instance:sendPM_TutorActivityGainFormPrizeReq()
	end, self)
end

function TutorSystemView:unbindEvents()
	TutorSystemView.super.unbindEvents(self)
	self._gotoBtn:RemoveClickListener()
	GameUtil.asBtn(self._clickGo):RemoveClickListener()
end

function TutorSystemView:onExit()
	TutorSystemView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTutorActivityInfo, self._updataShowReward, self)

	if self._rewardEff then
		UIEffectManager.instance:stopEffect(self._rewardEff)

		self._rewardEff = nil
	end

	MaterialMgr.resetAll(self._goodsPos)

	self._proxy = nil
end

function TutorSystemView:destroyUI()
	TutorSystemView.super.destroyUI(self)
end

function TutorSystemView:buildUI()
	TutorSystemView.super.buildUI(self)

	self._gotoBtn = self:getBtn("gotoBtn")
	self._goodsPos = self:getGo("rewardGo/goodsPos")
	self._effectTran = self:getGo("rewardGo/effectGo"):GetComponent(goutil.Type_RectTransform)
	self._clickGo = self:getGo("rewardGo/clickGo")
	self._finishGo = self:getGo("rewardGo/finishGo")
	self._timeTxt = self:getTxt("timeTxt")
	self._timeTxt.text = ""

	GameUtil.SetActive(self._finishGo, false)
end

function TutorSystemView:onEnter()
	TutorSystemView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTutorActivityInfo, self._updataShowReward, self)

	self._proxy = MaterialMgr.setCellByCfg(TutorSystemConfig.instance:getTutorActivityCommon("TUTOR_FORM_PRIZE"), self._goodsPos)
	self._timeTxt.text = TutorSystemConfig.instance:getTutorActivityCommon("TUTOP_TIME_SHOW")
	self._curState = 0

	self:_updataShowReward()
	TutorActvityAgent.instance:sendPM_TutorActivityFormInfoReq()
end

function TutorSystemView:_updataShowReward(state)
	self._curState = checknumber(state)

	if self._curState == 1 then
		if self._rewardEff == nil then
			self._rewardEff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._effectTran.gameObject, 0, 0, true, nil, nil, function(view, eff)
				eff:setParent(self._effectTran)
				eff:setScale(1)
				eff:setClipping(self._effectTran)

				eff.hideEffWhileNotOnTop = true
			end)
		end
	elseif self._rewardEff then
		UIEffectManager.instance:stopEffect(self._rewardEff)

		self._rewardEff = nil
	end

	if self._proxy == nil then
		return
	end

	self._proxy.binder:SetGray(self._curState == 2)
	GameUtil.SetActive(self._finishGo, self._curState == 2)
end

return TutorSystemView
