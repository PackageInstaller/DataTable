-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchFriendshipView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchFriendshipView", package.seeall)

local TianYanMatchFriendshipView = class("TianYanMatchFriendshipView", ViewComponent)
local FLY_EFFECT_PATH = "fx_scene_zhengjiuxuruojingling/fx_ui_tuoweiguiji.prefab"

function TianYanMatchFriendshipView:ctor()
	TianYanMatchFriendshipView.super.ctor(self)
end

function TianYanMatchFriendshipView:unbindEvents()
	TianYanMatchFriendshipView.super.unbindEvents(self)
	self._btnSubmit:clearAllHandlers()
	GameUtil.rmClickHandler(self._btnClose)
end

function TianYanMatchFriendshipView:bindEvents()
	TianYanMatchFriendshipView.super.bindEvents(self)
	self._btnSubmit:addClickHandler(GameUtil.handler(self._onClickSubmit, self))
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TianYanMatchFriendshipView:buildUI()
	TianYanMatchFriendshipView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtFriendship = self:getTxt("friendshipInfo/txtFriendship")
	self._txtAddValue = self:getTxt("friendshipInfo/txtAddValue")
	self._txtMaxFriendship = self:getTxt("friendshipInfo/txtMaxFriendship")
	self._txtName = self:getTxt("info/txtName")
	self._imgToy = self:getGo("imgToy")
	self._itemCon = self:getGo("itemCon")
	self._btnSure = self:getGo("btnSure")
	self._btnSubmit = BtnLongPressHelper.create(self._btnSure)
	self._effectCon = self:getGo("effectCon")
end

function TianYanMatchFriendshipView:onExit()
	TianYanMatchFriendshipView.super.onExit(self)

	if self._flyEffect then
		UIEffectManager.instance:stopEffect(self._flyEffect)
	end

	removetimer(self._sendAddValue, self)
	uGuiUtil.clearImage(self._imgToy)
end

function TianYanMatchFriendshipView:onEnter()
	TianYanMatchFriendshipView.super.onEnter(self)
	self:addGEvent(GlobalNotify.TianYanMatchGetInfo, self._refreshView)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = TianYanMatchConfig.instance:getActivityCfg(self._activityId)

	if self._flyEffect then
		UIEffectManager.instance:stopEffect(self._flyEffect)
	end

	self._flyEffect = UIEffectManager.instance:playEffect(self, FLY_EFFECT_PATH, nil, 0, 0, true)

	self._flyEffect:setParent(self._effectCon.transform)
	self._flyEffect:setScale(1)
	self._flyEffect:setLocalPos(0, 0, 0)
	GameUtil.SetActive(self._effectCon, false)

	local toyId = TianYanMatchModel.instance:getMyToyId(self._activityId)
	local toyCfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, toyId)

	self._txtName.text = toyCfg.desc

	uGuiUtil.setSpriteToImage(self._imgToy, nil, toyCfg.res)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.oneValueCost)

	self._itemProxy = MaterialMgr.setCell(matType, matId, self._itemCon)

	local ownMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._itemProxy.binder:setNumStr(ownMatNum)
	GameUtil.SetActive(self._txtAddValue, false)

	self._addValue = 0

	self:_refreshView()
end

function TianYanMatchFriendshipView:_refreshView()
	local curFriendship = TianYanMatchModel.instance:getFriendship(self._activityId)

	self._txtFriendship.text = langPara("友情值：%d", curFriendship)
	self._txtMaxFriendship.text = langPara("/%d", self._activityCfg.friendshipLimit)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.oneValueCost)
	local ownMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._itemProxy.binder:setNumStr(ownMatNum)
	self:_calcMaxAdd()
end

function TianYanMatchFriendshipView:_calcMaxAdd()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.oneValueCost)
	local ownMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._maxAddTime = math.floor(ownMatNum / matNum)

	local curFriendship = TianYanMatchModel.instance:getFriendship(self._activityId)
	local maxTime = self._activityCfg.friendshipLimit - curFriendship

	if maxTime < self._maxAddTime then
		self._maxAddTime = maxTime
	end
end

function TianYanMatchFriendshipView:_sendAddValue()
	local curFriendship = TianYanMatchModel.instance:getFriendship(self._activityId)

	TianYanMatchAgent.instance:sendPM_TianYanMatchUpFriendshipReq(self._activityId, self._addValue + curFriendship)
end

function TianYanMatchFriendshipView:_onClickSubmit()
	local curFriendship = TianYanMatchModel.instance:getFriendship(self._activityId)
	local maxTime = self._activityCfg.friendshipLimit - curFriendship

	if self._maxAddTime > 0 then
		self._addValue = self._maxAddTime

		self:_showFlyEffect()

		local curFriendship = TianYanMatchModel.instance:getFriendship(self._activityId)

		TianYanMatchAgent.instance:sendPM_TianYanMatchUpFriendshipReq(self._activityId, self._addValue + curFriendship)
	elseif maxTime <= 0 then
		FloatWordMgr.instance:show(lang("友情值已达上限，无需继续投入"))
	else
		FloatWordMgr.instance:show(lang("道具数量不足，前往[获得礼物]玩法获取吧"))
	end
end

function TianYanMatchFriendshipView:_onLongPressSubmit()
	if self._maxAddTime > 0 then
		self._addStep = 1
		self._addValue = self._addStep

		self:_showFlyEffect()
	else
		FloatWordMgr.instance:show(lang("已达可升级上限"))
	end

	self._pressTime = 0
end

function TianYanMatchFriendshipView:_onPressTimeSubmit()
	return
end

function TianYanMatchFriendshipView:_onUpdateSubmit(deltaTime, pressTime)
	self._pressTime = self._pressTime + deltaTime

	if self._pressTime < 0.5 then
		return
	else
		self._pressTime = 0
	end

	if self._maxAddTime == 0 then
		return
	end

	self._addValue = self._addValue + self._addStep

	if self._addValue >= self._maxAddTime then
		self._addValue = self._maxAddTime
		self._maxAddTime = 0

		settimer(0.5, self._sendAddValue, self, false)
		FloatWordMgr.instance:show(lang("已达可升级上限"))
	end

	self._addStep = self._addStep + 1

	self:_showFlyEffect()
	self:_updateItem()
end

function TianYanMatchFriendshipView:_updateItem()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.oneValueCost)
	local ownMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._itemProxy.binder:setNumStr(ownMatNum - matNum * self._addValue)
end

function TianYanMatchFriendshipView:_showFlyEffect()
	local startPos = GameUtil.getLocalPos(self._itemCon)
	local endPos = GameUtil.getLocalPos(self._imgToy)

	GameUtil.setLocalPos(self._effectCon, startPos.x, startPos.y, startPos.z)

	local particles = self._flyEffect.effGo:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true)

	for i = 0, particles.Length - 1 do
		particles[i]:Stop()
		particles[i]:Clear()
		particles[i]:Play()
	end

	GameUtil.SetActive(self._effectCon, true)

	local tween = UnityTweens.TweenPosition.StartTween(self._effectCon, startPos, endPos, 0.2)

	tween:AddListener(self._showAddNum, self)
end

function TianYanMatchFriendshipView:_showAddNum()
	GameUtil.SetActive(self._txtAddValue, true)
	GameUtil.SetActive(self._effectCon, false)

	if self._tweeners then
		self._tweeners:Kill(false)

		self._tweeners = nil
	end

	self._tweeners = TweenUtil.ValueTo(1, 0, 2, function(val)
		self._txtAddValue.text = "+" .. self._addValue
	end, function()
		self._tweeners = nil

		GameUtil.SetActive(self._txtAddValue, false)
	end, self)
end

function TianYanMatchFriendshipView:_onPressEndSubmit()
	if self._maxAddTime == 0 then
		return
	end

	settimer(0.5, self._sendAddValue, self, false)
end

return TianYanMatchFriendshipView
