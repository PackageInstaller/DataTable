-- chunkname: @modules/logic/lifecircle/controller/LifeCircleController.lua

module("modules.logic.lifecircle.controller.LifeCircleController", package.seeall)

local LifeCircleController = class("LifeCircleController", BaseController)
local ti = table.insert

function LifeCircleController:onInit()
	self:reInit()
end

function LifeCircleController:reInit()
	self._stageid = nil
	self._materialDataMOList = nil
	self._onReceiveHeroGainPushMsg = nil
end

function LifeCircleController:onInitFinish()
	return
end

function LifeCircleController:addConstEvents()
	SignInController.instance:registerCallback(SignInEvent.OnSignInTotalRewardReply, self._onSignInTotalRewardReply, self)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSignInTotalRewardAllReply, self._onReceiveSignInTotalRewardAllReply, self)
end

function LifeCircleController:sendSignInTotalRewardRequest(id, callback, callbackObj)
	SignInRpc.instance:sendSignInTotalRewardRequest(id, callback, callbackObj)
end

function LifeCircleController:sendSignInTotalRewardAllRequest(callback, callbackObj)
	return SignInRpc.instance:sendSignInTotalRewardAllRequest(callback, callbackObj)
end

function LifeCircleController:sendSignInTotalRewardAllRequestIfClaimable(callback, callbackObj)
	if not self:isClaimableAccumulateReward() then
		if callback then
			callback(callbackObj)
		end

		return
	end

	self:sendSignInTotalRewardAllRequest(callback, callbackObj)
end

function LifeCircleController:sendSignInRequest()
	self:sendSignInTotalRewardAllRequestIfClaimable(SignInRpc.sendSignInRequest, SignInRpc.instance)
end

function LifeCircleController:isClaimedAccumulateReward(id)
	return SignInModel.instance:isClaimedAccumulateReward(id)
end

function LifeCircleController:isClaimableAccumulateReward(idOrNil)
	return SignInModel.instance:isClaimableAccumulateReward(idOrNil)
end

local kRewardAllStageId = -11235

function LifeCircleController:_onReceiveSignInTotalRewardAllReply()
	self:dispatchRedDotEventUpdateRelateDotInfo()

	self._stageid = kRewardAllStageId

	if not self._materialDataMOList then
		return
	end

	self:_openLifeCircleRewardView()
end

function LifeCircleController:_onSignInTotalRewardReply(stageid)
	self:dispatchRedDotEventUpdateRelateDotInfo()

	self._stageid = stageid

	if not self._materialDataMOList then
		return
	end

	self:_openLifeCircleRewardView()
end

function LifeCircleController:openLifeCircleRewardView(materialDataMOList)
	if not materialDataMOList or #materialDataMOList == 0 then
		return
	end

	self._materialDataMOList = materialDataMOList

	if not self._stageid then
		return
	end

	self:_openLifeCircleRewardView()
end

function LifeCircleController:_openLifeCircleRewardView()
	if not self._stageid then
		return
	end

	if not self._materialDataMOList then
		return
	end

	local materialDataMOList = self._materialDataMOList
	local stageid = self._stageid
	local loginDayCount = 0

	if kRewardAllStageId == stageid then
		local playinfo = PlayerModel.instance:getPlayinfo()

		loginDayCount = playinfo.totalLoginDays or 0
	else
		local CO = SignInConfig.instance:getSignInLifeTimeBonusCO(stageid)

		loginDayCount = CO.logindaysid
	end

	self._materialDataMOList = nil
	self._stageid = nil

	RoomController.instance:popUpRoomBlockPackageView(materialDataMOList)

	local viewParam = {
		materialDataMOList = materialDataMOList,
		loginDayCount = loginDayCount
	}

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.LifeCircleRewardView, viewParam)
end

function LifeCircleController:onReceiveHeroGainPush(msg)
	self._onReceiveHeroGainPushMsg = msg
end

function LifeCircleController:onReceiveMaterialChangePush(msg)
	local materialDataMOList, faithCO, equip_cards, season123EquipCards = MaterialRpc.receiveMaterial(msg)

	if not materialDataMOList or #materialDataMOList == 0 then
		self._onReceiveHeroGainPushMsg = nil

		return
	end

	local heroIdList = {}
	local others_materialDataMOList = {}

	for _, mo in ipairs(materialDataMOList) do
		local materilType = mo.materilType
		local materilId = mo.materilId

		if materilType == MaterialEnum.MaterialType.Hero then
			ti(heroIdList, materilId)
		else
			ti(others_materialDataMOList, mo)
		end
	end

	if #heroIdList == 0 then
		if self._onReceiveHeroGainPushMsg then
			HeroRpc.instance:_onReceiveHeroGainPush(self._onReceiveHeroGainPushMsg)
		end

		MaterialRpc.instance:_onReceiveMaterialChangePush_default(msg, materialDataMOList, faithCO, equip_cards, season123EquipCards)
	else
		self._onReceiveHeroGainPushMsg = nil

		self:_doVirtualSummonBehavior(heroIdList, others_materialDataMOList)
	end
end

function LifeCircleController:_doVirtualSummonBehavior(heroIdList, others_materialDataMOList)
	ViewMgr.instance:closeView(ViewName.BackpackView)
	SummonController.instance:simpleEnterSummonScene(heroIdList, function()
		if ViewMgr.instance:isOpen(ViewName.BackpackView) then
			return
		end

		BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
		MaterialRpc.instance:simpleShowView(others_materialDataMOList)
	end)
end

function LifeCircleController:isShowRed()
	if self:isExistsNewConfig() then
		return true
	end

	if self:isClaimableAccumulateReward() then
		return true
	end

	return false
end

local kPrefix = "LifeCircleController|"

function LifeCircleController:getPrefsKeyPrefix()
	return kPrefix
end

function LifeCircleController:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function LifeCircleController:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

local kNewConfig = "NewConfig"

function LifeCircleController:setLatestConfigCount(count)
	local key = self:getPrefsKeyPrefix() .. kNewConfig

	self:saveInt(key, count)
end

function LifeCircleController:getLatestConfigCount()
	local key = self:getPrefsKeyPrefix() .. kNewConfig

	return self:getInt(key, 0)
end

function LifeCircleController:isExistsNewConfig()
	local cnt = SignInConfig.instance:getSignInLifeTimeBonusCount()

	return self:getLatestConfigCount() ~= cnt
end

function LifeCircleController:markLatestConfigCount()
	local newValue = SignInConfig.instance:getSignInLifeTimeBonusCount()
	local curValue = self:getLatestConfigCount()

	if curValue ~= newValue then
		self:setLatestConfigCount(newValue)
		self:dispatchRedDotEventUpdateRelateDotInfo()
	end
end

function LifeCircleController:dispatchRedDotEventUpdateRelateDotInfo()
	local redDot = RedDotEnum.DotNode.LifeCircleNewConfig
	local parentReddot = RedDotConfig.instance:getParentRedDotId(redDot)

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(parentReddot)] = true,
		[redDot] = true
	})
end

LifeCircleController.instance = LifeCircleController.New()

return LifeCircleController
