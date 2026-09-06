-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessMainView.lua

module("logic.extensions.goddess.view.GoddessMainView", package.seeall)

local GoddessMainView = class("GoddessMainView", ViewComponent)

function GoddessMainView:buildUI()
	GoddessMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTouch = self:getBtn("btnTouch")
	self._btnFlower = self:getBtn("btnFlower")
	self._btnGame = self:getBtn("btnGame")
	self._btnChat = self:getBtn("btnChat")
	self._btnRank = self:getBtn("btnRank")
	self._btnLvPrize = self:getBtn("btnLvPrize")
	self._btnTip = self:getBtn("btnTip")
	self._sldHeart = self:getSlider("Lv/exp")
	self._txtLv = self:getTxt("Lv/txtLv")
	self._txtExp = self:getTxt("Lv/txtexp")
	self._txtGame = self:getTxt("btnGame/Count/txt")
	self._txtTouch = goutil.findChildTextComponent(self._btnTouch.gameObject, "Count/txt")
	self._mask = self:getGo("mask")
	self._goRole = self:getGo("role")
	self._posBubble = self:getGo("posBubble")
	self._redPointGame = self:getGo("btnGame/imgPoint")
	self._redPointChat = self:getGo("btnChat/redPoint")
	self._redPointFlower = self:getGo("btnFlower/imgPoint")
	self._effPosGift = self:getGo("effPosGift")
	self._effPosLvUp = self:getGo("effPosLvUp")
	self._posBubble = self:getGo("posBubble")
	self._redPointLvPrize = self:getGo("btnLvPrize/imgPoint")
	self._redPointTouch = self:getGo("btnTouch/imgPoint")
	self._posTouch = self:getGo("posTouch")
end

function GoddessMainView:onEnter()
	GoddessMainView.super.onEnter(self)

	local actId = GoddessModel.instance:getActIdByCfg()

	if actId then
		GoddessModel.instance:setActId(actId)
		GoddessController.instance:getInfo()
	else
		FloatWordMgr.instance:show(lang("不在活动时间"))
		self:close()
	end

	GlobalDispatcher:addListener(GlobalNotify.GoddessError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessInfoUpdate, self._updateInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessAddFeelingAni, self._playAddGoodFeelAni, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessPlayBubble, self._playBubble, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessRefresMainView, self._updateInfo, self)

	self._giftNeedPlayEffectCount = {}
	self._isPlayEffect = false
	self._isPlayTouchEffing = false
end

function GoddessMainView:onExit()
	GoddessMainView.super.onExit(self)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)
	self._curInfo = nil

	GlobalDispatcher:removeListener(GlobalNotify.GoddessError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessInfoUpdate, self._updateInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessAddFeelingAni, self._playAddGoodFeelAni, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessPlayBubble, self._playBubble, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessRefresMainView, self._updateInfo, self)
	self:_finishPlayBubble()
	removetimer(self._giftEffectFinish, self)
	removetimer(self._playNextBubble, self)
	removetimer(self._finishPlayBubble, self)

	if self._touchEff then
		UIEffectManager.instance:stopEffect(self._touchEff)

		self._touchEff = nil
	end
end

function GoddessMainView:bindEvents()
	GoddessMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTouch:AddClickListener(self._onClickTouch, self)
	self._btnFlower:AddClickListener(self._onClickFlower, self)
	self._btnGame:AddClickListener(self._onClickGame, self)
	self._btnChat:AddClickListener(self._onClickChat, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnLvPrize:AddClickListener(self._onClickLvPrize, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function GoddessMainView:unbindEvents()
	GoddessMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTouch:RemoveClickListener()
	self._btnFlower:RemoveClickListener()
	self._btnGame:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnLvPrize:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function GoddessMainView:_onClickTouch()
	GoddessModel.instance:resetGoodFeelingChangeValue()

	if self._isPlayTouchEffing then
		return
	end

	self._isPlayTouchEffing = true

	if GoddessModel.instance:getLeftTouchTimes() > 0 then
		GoddessController.instance:touchGoddess(self._curInfo.raceId)
	end

	self:_playBubble(self._curInfo.raceCfg.bubbleTouch)

	if self._touchEff then
		UIEffectManager.instance:stopEffect(self._touchEff)

		self._touchEff = nil
	end

	local effPath = "fx_ui_wuxianweilai/fx_ui_wuxianweilai_shou.prefab"

	self._touchEff = UIEffectManager.instance:playEffect(self, effPath, self._posTouch.transform, 0, 0, false, false, function()
		self._isPlayTouchEffing = false

		self:_playAddGoodFeelAni()
	end, function(target, eff)
		eff.effGo.transform:SetParent(self._posTouch.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
	end)
end

function GoddessMainView:_onClickFlower()
	UIStateManager.instance:push(ViewName.GoddessFlowerView)
end

function GoddessMainView:_onClickChat()
	if self._curInfo then
		UIStateManager.instance:push(ViewName.GoddesschatView, self._curInfo.raceId)
	end

	UIStateManager.instance:push(ViewName.GoddesschatView)
end

function GoddessMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.GoddessrankView)
end

function GoddessMainView:_onClickLvPrize()
	UIStateManager.instance:push(ViewName.GoddessLvPrizeView)
end

function GoddessMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "goddessrule")
end

function GoddessMainView:_onClickGame()
	if self._curInfo then
		UIStateManager.instance:push(ViewName.GoddessgameView, self._curInfo.raceId)
	end
end

function GoddessMainView:_onError(staus)
	return
end

function GoddessMainView:_updateInfo()
	local info = GoddessModel.instance:getCurGoddessInfo()

	if info ~= self._curInfo then
		self._curInfo = info
		self.loader = RoleObjectPool.instance:removeRole(self.loader)
		self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._curInfo.raceId, self._goRole, 1)
	end

	self._txtTouch.text = GoddessModel.instance:getLeftTouchTimes()

	goutil.setActive(self._redPointTouch, GoddessModel.instance:getLeftTouchTimes() > 0)
	goutil.setActive(self._redPointLvPrize, GoddessModel.instance:getIsLvPrizeRedPointShow())

	local gameTime = GoddessModel.instance:getGameLeftTime()

	self._txtGame.text = gameTime

	goutil.setActive(self._redPointGame, gameTime > 0)
	goutil.setActive(self._redPointChat, GoddessModel.instance:checkChatRedPoint(self._curInfo.raceId))
	self:_updateExpValue()
	self:_playNextBubble()
end

function GoddessMainView:_updateExpValue()
	local info = GoddessModel.instance:getCurGoddessInfo()

	if info ~= self._curInfo then
		self._curInfo = info
	end

	self._txtLv.text = self._curInfo.curLv

	if self._curInfo.isLvMax then
		self._txtExp.text = lang("已满级")

		self._sldHeart:SetValue(1)
	else
		local nextLvNeedfeeling = self._curInfo.goodfeelingLvCfgs[self._curInfo.curLv + 1].feeling - self._curInfo.goodfeelingLvCfgs[self._curInfo.curLv].feeling

		self._txtExp.text = langPara("%s/%s", self._curInfo.curShowFeeling, nextLvNeedfeeling)

		self._sldHeart:SetValue(checknumber(self._curInfo.curShowFeeling) / nextLvNeedfeeling)
	end

	self._bubbleText = GoddessConfig.instance:getGoddessTexts(self._curInfo.raceId, self._curInfo.curLv)
end

function GoddessMainView:_playAddGoodFeelAni()
	local addValue, isLvUp = GoddessModel.instance:getGoodFeelingChangeValue()

	if addValue > 0 then
		table.insert(self._giftNeedPlayEffectCount, 1)

		if not ViewMgr.instance:isOpen(ViewName.FavorChange) then
			UIStateManager.instance:open(ViewName.FavorChange, addValue)
		else
			GlobalDispatcher:dispatch(GlobalNotify.PigFavorChange, addValue)
		end

		if not self._isPlayEffect then
			self:_playFeelEff()
		end
	end

	if isLvUp then
		self:_playLvUpEff()
	end

	self:_updateExpValue()
end

function GoddessMainView:_playFeelEff()
	local effectName = "fx_ui_haogandu/fx_ui_haogandu01.prefab"

	table.remove(self._giftNeedPlayEffectCount, 1)

	local posx = 36
	local posy = -146

	self._isPlayEffect = true
	self._giftEffectHandle = UIEffectManager.instance:playEffect(self, effectName, nil, nil, nil, false)

	self._giftEffectHandle:setParent(self._effPosGift.transform)
	self._giftEffectHandle:setScale(1)
	self._giftEffectHandle:setLocalPos(posx, posy, 0)

	self._giftEffectHandle.hideEffWhileNotOnTop = false

	settimer(0.4, self._giftEffectFinish, self, false)
end

function GoddessMainView:_giftEffectFinish()
	self._isPlayEffect = false

	if #self._giftNeedPlayEffectCount > 0 then
		self:_playFeelEff()
	end
end

function GoddessMainView:_playLvUpEff()
	self._lvUpEff = UIEffectManager.instance:playEffect(self, "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_01.prefab", nil, 0, 0, false, false)

	self._lvUpEff:setParent(self._effPosLvUp.transform)
	self._lvUpEff:setScale(1)
	self._lvUpEff:setLocalPos(0, 0, 0)

	self._lvUpEff.hideEffWhileNotOnTop = false
end

function GoddessMainView:_playBubble(playStr)
	if not string.nilorempty(playStr) then
		removetimer(self._playNextBubble, self)
		BubbleController.instance:CloseView()
		removetimer(self._finishPlayBubble, self)
		BubbleController.instance:OpenView(playStr, self._posBubble.transform.position, true)
		settimer(2.5, self._finishPlayBubble, self, false)
	end
end

function GoddessMainView:_finishPlayBubble()
	BubbleController.instance:CloseView()
	settimer(5, self._playNextBubble, self, false)
end

function GoddessMainView:_playNextBubble()
	self:_playBubble(self._bubbleText[math.random(#self._bubbleText)])
end

return GoddessMainView
