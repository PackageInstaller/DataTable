-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/view/GodXiuerGoodOrEvilView.lua

module("logic.extensions.godxiuerchallenge.view.GodXiuerGoodOrEvilView", package.seeall)

local GodXiuerGoodOrEvilView = class("GodXiuerGoodOrEvilView", ViewComponent)

function GodXiuerGoodOrEvilView:ctor()
	GodXiuerGoodOrEvilView.super.ctor(self)
end

function GodXiuerGoodOrEvilView:buildUI()
	GodXiuerGoodOrEvilView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._btnSliderTip = self:getBtn("sliderInfo/txtState/btnSliderTip")
	self._con = self:getGo("con")
	self._slider = self:getSlider("sliderInfo/sldProgress")
	self._txtSad = self:getTxt("sliderInfo/sad/round/txt")
	self._txtHappy = self:getTxt("sliderInfo/happy/survival/txt")
	self._txtDesc = self:getTxt("sliderInfo/buffDesc/txtDesc")
	self._buffDesc = self:getGo("sliderInfo/buffDesc")
	self._txtState = self:getTxt("sliderInfo/txtState")
	self._itemList = {}

	local prefix1 = "challenge/happy/"
	local prefix2 = "challenge/sad/"

	for i = 1, 10 do
		local go = i >= 1 and i <= 5 and self:getGo(prefix1 .. "btnChallenge_" .. i) or self:getGo(prefix2 .. "btnChallenge_" .. i)
		local item = {}

		item.go = go
		item.btn = Framework.ButtonAdapter.Get(go)
		item.txtNum = goutil.findChildTextComponent(go, "tag/txt")
		item.pass = goutil.findChild(go, "pass")
		item.tag = goutil.findChild(go, "tag")

		table.insert(self._itemList, item)
	end

	self._effectBg = self:getGo("effect")
end

function GodXiuerGoodOrEvilView:bindEvents()
	GodXiuerGoodOrEvilView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnSliderTip:AddClickListener(self._onClickSliderTip, self)

	for i, v in ipairs(self._itemList) do
		v.btn:AddClickListener(function()
			self:_onClickItem(i)
		end)
	end
end

function GodXiuerGoodOrEvilView:unbindEvents()
	GodXiuerGoodOrEvilView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnSliderTip:RemoveClickListener()

	for i, v in ipairs(self._itemList) do
		v.btn:RemoveClickListener()
	end
end

function GodXiuerGoodOrEvilView:onEnter()
	GodXiuerGoodOrEvilView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodHyurLimitChallengeInfoRes, self._onLimitChallengeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GodHyurLimitChallengeResetRes, self._onLimitChallengeResetRes, self)

	self._challengeId = self:getFirstParam()

	self:_updateView()
	self:_showRoleModel()
	self:_loadEffect()

	if not GodXiuerChallengeController.instance:isFinishLimitChallenge(self._challengeId) then
		GodHyurChallengeAgent.instance:sendPM_GodHyurLimitChallengeInfoReq(self._challengeId)
	else
		self:_showFinishChallengeTip()
	end
end

function GodXiuerGoodOrEvilView:onExit()
	GodXiuerGoodOrEvilView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodHyurLimitChallengeInfoRes, self._onLimitChallengeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodHyurLimitChallengeResetRes, self._onLimitChallengeResetRes, self)
	self:_resetRoleModel()
	self:_removeEffect()
end

function GodXiuerGoodOrEvilView:_onClickClose()
	self:close()
end

function GodXiuerGoodOrEvilView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "godxiuergoodorevilview")
end

function GodXiuerGoodOrEvilView:_onClickReset()
	local text = lang("godxiuer_4")

	local function okFunc()
		GodHyurChallengeAgent.instance:sendPM_GodHyurLimitChallengeResetReq(self._challengeId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function GodXiuerGoodOrEvilView:_onClickSliderTip()
	local desc = lang("godxiuer_5")
	local screenPos = UGUIToolHelper.GetTouchPosition()

	CommonTipsMgr.instance:showTips(desc, screenPos, offset)
end

function GodXiuerGoodOrEvilView:_onClickItem(id)
	if not GodXiuerChallengeController:isFinishLimitChallenge(self._challengeId) then
		GodXiuerChallengeController.instance:openGoodOrEvilChallengeForm(self._challengeId, id)
	else
		FloatWordMgr.instance:show(lang("godxiuer_6"))
	end
end

function GodXiuerGoodOrEvilView:_onLimitChallengeInfoRes()
	self:_updateView()
end

function GodXiuerGoodOrEvilView:_onLimitChallengeResetRes()
	GodHyurChallengeAgent.instance:sendPM_GodHyurLimitChallengeInfoReq(self._challengeId)
end

function GodXiuerGoodOrEvilView:_updateView()
	self:_updateSliderInfo()
	self:_updateHappyAndSadItems()
end

function GodXiuerGoodOrEvilView:_updateSliderInfo()
	local baseNum = 10
	local totalNum = baseNum * 2
	local curNum = 0
	local happyNum, sadNum = GodXiuerChallengeModel.instance:getLimitChallengeSurvivalAndRound(self._challengeId)
	local isLimitChallengedAll = GodXiuerChallengeModel.instance:isLimitChallengedAll(self._challengeId)
	local diff = sadNum - happyNum
	local absDiff = Mathf.Clamp(Mathf.Abs(diff), 0, 10)
	local revDiff = -1 * diff

	curNum = diff > 0 and baseNum + absDiff or diff < 0 and baseNum - absDiff or baseNum

	local cfgMood = GoodOrEvilChallengeConfig.instance:getMoodCfgByMoodRangeNum(revDiff, isLimitChallengedAll)

	if cfgMood then
		if not cfgMood.buffPlanId then
			local buffPlanId = 0
			local cfgBuff = GoodOrEvilChallengeConfig.instance:getBuffCfg(buffPlanId)

			if cfgMood then
				if not cfgMood.name then
					local stateText = "nil"

					self._slider:SetValue((Mathf.Clamp01(curNum / totalNum)))
					goutil.setActive(self._buffDesc, cfgBuff and cfgBuff.des)

					self._txtState.text = lang("godxiuer_7") .. stateText

					if cfgBuff then
						self._txtDesc.text = cfgBuff.des or ""
					end

					self._txtSad.text = lang("godxiuer_8") .. sadNum
					self._txtHappy.text = lang("godxiuer_9") .. happyNum
				end
			end
		end
	end
end

function GodXiuerGoodOrEvilView:_updateHappyAndSadItems()
	for i, v in ipairs(self._itemList) do
		self:_updateItem(v, i)
	end
end

function GodXiuerGoodOrEvilView:_updateItem(item, id)
	local isPass, curNum = GodXiuerChallengeModel.instance:isLevelPass(self._challengeId, id)

	item.txtNum.text = curNum

	goutil.setActive(item.pass, isPass)
	goutil.setActive(item.tag, isPass)
end

function GodXiuerGoodOrEvilView:_showFinishChallengeTip()
	if GodXiuerChallengeController.instance:isFinishLimitChallenge(self._challengeId) then
		local function onCloseViewCallback()
			UIStateManager.instance:popByName(ViewName.GodXiuerGoodOrEvilView)
		end

		UIStateManager.instance:push(ViewName.DivineEvolveTipView, onCloseViewCallback)
	end
end

function GodXiuerGoodOrEvilView:_showRoleModel()
	local skinId = 15015
	local offset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._con, scale, nil, true, x, y)
end

function GodXiuerGoodOrEvilView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function GodXiuerGoodOrEvilView:_loadEffect()
	self:_removeEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, GodXiuerGoodOrEvilViewPresentor.Effect1, self._effectBg.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectBg.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = false
	self._uiEffect = uiEffect
end

function GodXiuerGoodOrEvilView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return GodXiuerGoodOrEvilView
