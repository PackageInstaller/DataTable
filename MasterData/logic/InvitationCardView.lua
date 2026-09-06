-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/InvitationCardView.lua

module("logic.extensions.activitypopup.view.InvitationCardView", package.seeall)

local InvitationCardView = class("InvitationCardView", ViewComponent)
local STATE_READ = 0
local STATE_SURE = 1
local STATE_JUMP = 2

function InvitationCardView:ctor()
	InvitationCardView.super.ctor(self)
end

function InvitationCardView:buildUI()
	InvitationCardView.super.buildUI(self)

	self._content = self:getGo("content")
	self._itemList = {}

	for i = 1, 3 do
		local item = self:getGo("content/item" .. i)

		table.insert(self._itemList, item)
	end

	self._txtDes = goutil.findChildTextComponent(self.mainGO, "content/txtDesc")
	self._close = self:getBtn("content/btnClose")
	self._btnSure = self:getBtn("content/btnSure")
	self._txtSure = goutil.findChildTextComponent(self.mainGO, "content/btnSure/Text")
	self._ImgC_Icon = goutil.findChildComponent(self.mainGO, "imgIcon", "Image")
	self._ImgSpriteChange = self._ImgC_Icon:GetComponent("UIImageSpriteChange")
	self._initX, self._initY, self._initZ = Framework.TransformUtil.GetPos(self._ImgC_Icon.transform, 0, 0, 0)
	self._content = self:getGo("content")
	self._enterEffectNode = self:getGo("enterEffectNode")
	self._bg = self:getGo("content/bg")
	self._funcId = 0
end

function InvitationCardView:bindEvents()
	InvitationCardView.super.bindEvents(self)
	self._close:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._sure, self)
end

function InvitationCardView:unbindEvents()
	InvitationCardView.super.unbindEvents(self)
	self._close:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function InvitationCardView:destroyUI()
	InvitationCardView.super.destroyUI(self)
end

function InvitationCardView:onEnter()
	InvitationCardView.super.onEnter(self)

	self.activityId = checknumber(self:getOpenParam()[1])
	self.actCfg = self:getOpenParam()[2]
	self._state = STATE_READ

	GlobalDispatcher:addListener(GlobalNotify.OperationInvitation, self._refresh, self)
	GameUtil.setLocalScale(self._content, 1, 1, 1)
	Framework.TransformUtil.SetPos(self._ImgC_Icon.transform, self._initX, self._initY, self._initZ)
	Framework.TransformUtil.SetLocalScale(self._ImgC_Icon.transform, 1, 1, 1)
	goutil.setActive(self._ImgC_Icon.gameObject, false)
	goutil.setActive(self._enterEffectNode, true)
	goutil.setActive(self._content, false)
	self:_showContent()
	self:_refresh()

	if self._effectPath ~= nil and self._effectPath ~= "" then
		self._showEff = UIEffectManager.instance:playEffect(self, self._effectPath, nil, 0, 0, true, nil, nil, nil, self)

		self._showEff:setParent(self.mainGO.transform)

		self._showEff.hideEffWhileNotOnTop = true

		self._showEff:setScale(1)
	end

	self:_startCountDown()
end

function InvitationCardView:onEnterFinished()
	InvitationCardView.super.onEnterFinished(self)
end

function InvitationCardView:onExit()
	InvitationCardView.super.onExit(self)
	self:_stopCountDown()
	GlobalDispatcher:removeListener(GlobalNotify.OperationInvitation, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._playTrailerEffect, self)
	uGuiUtil.clearImage(self._bg)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._itemList[i])
	end

	if self._tweenScale then
		self._tweenScale:Stop()

		self._tweenScale = nil
	end

	if self._enterEffect then
		UIEffectManager.instance:stopEffect(self._enterEffect)

		self._enterEffect = nil
	end

	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)
	end

	GlobalDispatcher:removeListener(GlobalNotify.GetFuncBtnPosRes, self._onGetFuncBtnPos, self)
	removetimer(self._showContent, self)
	removetimer(self._update, self)
	removetimer(self._flyFinished, self)
	MagicSchoolController.instance:setOpenedInvitedCard(true)
end

function InvitationCardView:onExitFinished()
	InvitationCardView.super.onExitFinished(self)
end

function InvitationCardView:_refresh()
	local cfg = OperationSummaryConfig.instance:getSummaryCfgById(self.activityId)

	if cfg then
		if not string.nilorempty(cfg.bgName) then
			local bgName = string.format("ui/bigbg/activitypopup/%s.png", cfg.bgName)

			uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgName)
		end

		self._funcId = cfg.funcId

		local rewardList = MaterialMgr.changeItemStrArr(cfg.invitationPrize)

		for i = 1, 3 do
			if i <= #rewardList then
				goutil.setActive(self._itemList[i], true)
				MaterialMgr.setCellByCfg(rewardList[i], self._itemList[i])
			else
				goutil.setActive(self._itemList[i], false)
			end
		end

		self._txtDes.text = langPara(cfg.des, RoleModel.instance:getUserName())
		self._effectPath = cfg.effectPath
	end

	self:_updateBtnSureUI()
end

function InvitationCardView:_sure()
	if self._state == STATE_READ then
		-- block empty
	elseif self._state == STATE_SURE then
		self._state = STATE_JUMP

		OpSummaryController.instance:acceptInvite(self.activityId, self.actCfg)
		GlobalDispatcher:addListener(GlobalNotify.OnMaterialPopEnd, self._playTrailerEffect, self)
	elseif self._state == STATE_JUMP then
		self:_playTrailerEffect()
	end
end

function InvitationCardView:_updateBtnSureUI()
	local isNeedGray = false
	local str = ""

	if self._state == STATE_READ then
		str = "接受(3s)"
		isNeedGray = true
	elseif self._state == STATE_SURE then
		str = "接受"
	elseif self._state == STATE_JUMP then
		str = "接受"
	end

	self._txtSure.text = str

	GameUtil.SetGray(self._btnSure, isNeedGray)
end

function InvitationCardView:_playTrailerEffect()
	if self._funcId == 0 then
		self:close()

		return
	end

	local scale = 0
	local duration = 0.7
	local cv3 = GameUtil.getLocalScale(self._content)

	self._tweenScale = UnityTweens.TweenScale.Create(self._content, cv3, Vector3.New(scale, scale, scale), duration)

	self._tweenScale:Stop()
	self._tweenScale:Begin()
	goutil.setActive(self._ImgC_Icon.gameObject, true)

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(self._funcId)

	self._ImgSpriteChange:ChangeSprite(cfg.tipsIcon)
	GlobalDispatcher:addListener(GlobalNotify.GetFuncBtnPosRes, self._onGetFuncBtnPos, self)
	GlobalDispatcher:dispatch(GlobalNotify.GetFuncBtnPosReq, self._funcId)
end

function InvitationCardView:_onGetFuncBtnPos(pos)
	printError("_onGetFuncBtnPos")

	pos = pos or Vector3.New(0, 0, 0)

	GlobalDispatcher:removeListener(GlobalNotify.GetFuncBtnPosRes, self._onGetFuncBtnPos, self)
	self._ImgC_Icon.transform:DOMove(pos, 1)
	self._ImgC_Icon.transform:DOScale(Vector3.New(0, 0, 0), 1)

	self._feiEffect = UIEffectManager.instance:playEffect(self, "fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab", self._ImgC_Icon.gameObject, 0, 0, false, nil, nil, nil, self)

	settimer(0, self._update, self)
	settimer(1.2, self._flyFinished, self, false)
end

function InvitationCardView:_update()
	if not self._feiEffect then
		return nil
	end

	UIEffectManager.instance:updateEffectPosition(self._feiEffect)
end

function InvitationCardView:_flyFinished()
	if self._feiEffect then
		UIEffectManager.instance:stopEffect(self._feiEffect)

		self._feiEffect = nil
	end

	removetimer(self._update, self)
	removetimer(self._flyFinished, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._playTrailerEffect, self)
	self:close()
	FuncOpenController.instance:openFunc(self._funcId, self.activityId)
end

function InvitationCardView:_showContent()
	goutil.setActive(self._enterEffectNode, false)
	goutil.setActive(self._content, true)
	removetimer(self._showContent, self)
end

function InvitationCardView:_startCountDown()
	self._totalTime = 3
	self._curTime = -1
	self._deltaTime = 1

	self:_countDowning()
	settimer(self._deltaTime, self._countDowning, self)
end

function InvitationCardView:_stopCountDown()
	removetimer(self._countDowning, self)
end

function InvitationCardView:_countDowning()
	self._curTime = self._curTime + self._deltaTime

	if self._curTime >= self._totalTime then
		self:_stopCountDown()

		self._state = STATE_SURE

		self:_updateBtnSureUI()

		return
	end

	self._txtSure.text = string.format("接受(%s)", checkint(self._totalTime - self._curTime))
end

return InvitationCardView
