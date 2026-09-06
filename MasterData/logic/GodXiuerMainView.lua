-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/view/GodXiuerMainView.lua

module("logic.extensions.godxiuerchallenge.view.GodXiuerMainView", package.seeall)

local GodXiuerMainView = class("GodXiuerMainView", ViewComponent)

function GodXiuerMainView:ctor()
	GodXiuerMainView.super.ctor(self)
end

function GodXiuerMainView:buildUI()
	GodXiuerMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnChallenge1 = self:getBtn("btns/btnChallenge1/btn")
	self._btnChallenge2 = self:getBtn("btns/btnChallenge2/btn")
	self._txtScore = self:getTxt("progress/changelayer/txtScore")
	self._con = self:getGo("con")
	self._oneKeyItem = self:getGo("bubble/item")
	self._itemGo = self:getGo("progress/changelayer/txtScore/itemGo")
	self._itemIcon = self:getGo("progress/changelayer/txtScore/icon")
	self._bubble = self:getGo("bubble")
	self._progress = self:getGo("progress")
	self._txtDesc = self:getTxt("btns/btnChallenge1/bubble/txtDesc")
	self._effectBg = self:getGo("effect")
	self._effectBtn1 = self:getGo("btns/btnChallenge1/effRoot")
	self._effectBtn2 = self:getGo("btns/btnChallenge2/effRoot")
	self._effectProgress = self:getGo("progress/effect")
	self._pointerDownHandler1 = PointerDownHandler.Get(self._btnChallenge1.gameObject)
	self._pointerDownHandler2 = PointerDownHandler.Get(self._btnChallenge2.gameObject)
end

function GodXiuerMainView:bindEvents()
	GodXiuerMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnChallenge1:AddClickListener(self._onClickChallenge1, self)
	self._btnChallenge2:AddClickListener(self._onClickChallenge2, self)

	self._hashNum1 = self._pointerDownHandler1:AddLuaHandler(function(obj, eventData)
		self:_onPointDown(obj, eventData, 1)
	end)
	self._hashNum2 = self._pointerDownHandler2:AddLuaHandler(function(obj, eventData)
		self:_onPointDown(obj, eventData, 2)
	end)
end

function GodXiuerMainView:unbindEvents()
	GodXiuerMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._pointerDownHandler1:RemoveLuaHandler(self._hashNum1)
	self._pointerDownHandler2:RemoveLuaHandler(self._hashNum2)
end

function GodXiuerMainView:onEnter()
	GodXiuerMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodHyurChallengeScoreInfoRes, self._onScoreInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GodHyurChallengeOneKeyPassRes, self._onOneKeyPassRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GodHyurLimitChallengeInfoRes, self._onLimitChallengeInfoRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateData, self)

	self._challengeId = self:getFirstParam() or GodXiuerChallengeController.instance:getAvailableChallengeId()

	GodXiuerChallengeModel.instance:setCurChallengeId(self._challengeId)

	self._cfgChallenge = GoodOrEvilChallengeConfig.instance:getCfgById(self._challengeId)

	self:_initGameObject()
	self:_updateChallengeState()
	self:_updateScore()
	self:_showRoleModel()
	self:_initOneKeyReward()
	self:_updateBubbleText()
	self:_clearAllEffects()
	self:_loadBaseEffects()
	GodHyurChallengeAgent.instance:sendPM_GodHyurChallengeScoreInfoReq(self._challengeId)

	if not GodXiuerChallengeModel.instance:isEvolveChallenge(challengeId) then
		GodHyurChallengeAgent.instance:sendPM_GodHyurLimitChallengeInfoReq(self._challengeId)

		self._isExistLimitChallengeInfo = false
	else
		self._isExistLimitChallengeInfo = true
	end
end

function GodXiuerMainView:onExit()
	GodXiuerMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodHyurChallengeScoreInfoRes, self._onScoreInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodHyurChallengeOneKeyPassRes, self._onOneKeyPassRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodHyurLimitChallengeInfoRes, self._onLimitChallengeInfoRes, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._updateData, self)
	self:_resetRoleModel()
	MaterialMgr.resetAll(self._oneKeyItem)
	self:_clearAllEffects()
end

function GodXiuerMainView:_initGameObject()
	goutil.setActive(self._effectBtn1, false)
	goutil.setActive(self._effectBtn2, false)
end

function GodXiuerMainView:_onClickClose()
	self:close()
end

function GodXiuerMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "godxiuermainview")
end

function GodXiuerMainView:_onClickBuy()
	if string.nilorempty(self._cfgChallenge.passSaleCost) then
		return
	end

	if not GodXiuerChallengeController.instance:isFinishChallenge(self._challengeId) then
		local type, id, num = MaterialMgr.getMatParams(self._cfgChallenge.passSaleCost)

		TipsFacade.instance:openPopupCostMatViewNew(type, id, num, langPara("godxiuer_2", num), function()
			GodXiuerChallengeController.instance:reqBuyOneKeyPass(self._challengeId)
		end)
	else
		FloatWordMgr.instance:show(lang("godxiuer_3"))
	end
end

function GodXiuerMainView:_onPointDown(go, eventData, index)
	self:_loadClickEffect(index)
end

function GodXiuerMainView:_onClickChallenge1()
	if not self._isExistLimitChallengeInfo then
		return
	end

	if GodXiuerChallengeModel.instance:isEvolveChallenge(self._challengeId) then
		if not GodXiuerChallengeController.instance:isFinishChallenge(self._challengeId) then
			UIStateManager.instance:push(ViewName.GodXiuerGoodOrEvilView, self._challengeId)
		else
			FloatWordMgr.instance:show(lang("godxiuer_3"))
		end
	elseif not GodXiuerChallengeController.instance:isFinishLimitChallenge(self._challengeId) then
		UIStateManager.instance:push(ViewName.GodXiuerGoodOrEvilView, self._challengeId)
	else
		FloatWordMgr.instance:show("已完成悲喜挑战")
	end
end

function GodXiuerMainView:_onClickChallenge2()
	if GodXiuerChallengeModel.instance:isEvolveChallenge(self._challengeId) then
		if not GodXiuerChallengeController.instance:isFinishChallenge(self._challengeId) then
			UIStateManager.instance:push(ViewName.GodXiuerRightWrongView, self._challengeId)
		else
			FloatWordMgr.instance:show(lang("godxiuer_3"))
		end
	else
		UIStateManager.instance:push(ViewName.GodXiuerRightWrongView, self._challengeId)
	end
end

function GodXiuerMainView:_onScoreInfoRes()
	self:_updateScore()

	local curScore = GodXiuerChallengeModel.instance:getScore(self._challengeId)
	local maxScore = GodXiuerChallengeModel.instance:getMaxScore(self._challengeId)

	if checknumber(curScore) >= checknumber(maxScore) then
		self:_showDivineEvolveTipView()
	end
end

function GodXiuerMainView:_onOneKeyPassRes()
	self:_updateScore()

	local function callback()
		GodXiuerChallengeController.instance:showOneKeyReward(self._challengeId)
	end

	self:_showDivineEvolveTipView(GameUtil.handler(callback))
end

function GodXiuerMainView:_onLimitChallengeInfoRes()
	self._isExistLimitChallengeInfo = true
end

function GodXiuerMainView:_showDivineEvolveTipView(callback)
	local function onCloseViewCallback()
		if callback then
			GameUtil.callBack(callback)
		end

		UIStateManager.instance:popByName(ViewName.GodXiuerMainView)
	end

	UIStateManager.instance:push(ViewName.DivineEvolveTipView, onCloseViewCallback)
end

function GodXiuerMainView:_initOneKeyReward()
	local str = self._cfgChallenge.passSaleAward

	if not string.nilorempty(str) then
		MaterialMgr.setCellByCfg(str, self._oneKeyItem)
	end
end

function GodXiuerMainView:_updateBtnBuy()
	goutil.setActive(self._btnBuy.gameObject, not string.nilorempty(self._cfgChallenge.passSaleCost))
end

function GodXiuerMainView:_updateScore()
	local curScore = GodXiuerChallengeModel.instance:getScore(self._challengeId)
	local maxScore = GodXiuerChallengeModel.instance:getMaxScore(self._challengeId)

	self._txtScore.text = string.format("<color=#20b376>%d</color>/%d", curScore, maxScore)
end

function GodXiuerMainView:_showRoleModel()
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

function GodXiuerMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function GodXiuerMainView:_updateChallengeState()
	local isEvolveChallenge = GodXiuerChallengeModel.instance:isEvolveChallenge(self._challengeId)
	local isPassTime = GodXiuerChallengeModel.instance:isPassTime(self._challengeId)

	goutil.setActive(self._btnBuy.gameObject, isEvolveChallenge)
	goutil.setActive(self._progress, isEvolveChallenge)
	goutil.setActive(self._bubble, isEvolveChallenge and isPassTime)
end

function GodXiuerMainView:_updateBubbleText()
	self._txtDesc.text = self._cfgChallenge.bubbleDesc
end

function GodXiuerMainView:_loadEffect(effectPath, effectParent, isLoop, finishHandler, handlerTarget)
	local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, effectParent.transform, 0, 0, isLoop, false, finishHandler, loadedHandler, handlerTarget)

	uiEffect:setParent(effectParent.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = false
	self._uiEffectList = self._uiEffectList or {}

	if isLoop then
		table.insert(self._uiEffectList, uiEffect)
	end
end

function GodXiuerMainView:_loadBaseEffects()
	self:_loadEffect(GodXiuerMainViewPresentor.Effect1, self._effectBg.transform, true)
	self:_loadEffect(GodXiuerMainViewPresentor.Effect2, self._effectProgress.transform, true)
end

function GodXiuerMainView:_loadClickEffect(index)
	if index == 1 then
		goutil.setActive(self._effectBtn1, true)
		self._loadEffect(self, GodXiuerMainViewPresentor.Effect3, self._effectBtn1.transform, false, finishHandler1, self)
	elseif index == 2 then
		goutil.setActive(self._effectBtn2, true)
		self._loadEffect(self, GodXiuerMainViewPresentor.Effect3, self._effectBtn2.transform, false, finishHandler2, self)
	end
end

function GodXiuerMainView:_clearAllEffects()
	if self._uiEffectList then
		for i, v in ipairs(self._uiEffectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._uiEffectList)
	end
end

function GodXiuerMainView:_updateData()
	GodHyurChallengeAgent.instance:sendPM_GodHyurChallengeScoreInfoReq(self._challengeId)
end

return GodXiuerMainView
