-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/model/FirstChargePlusModel.lua

module("logic.extensions.firstcharge.model.FirstChargePlusModel", package.seeall)

local FirstChargePlusModel = class("FirstChargePlusModel", BaseModel)

function FirstChargePlusModel:ctor()
	return
end

function FirstChargePlusModel:onInit()
	self:onReset()
end

function FirstChargePlusModel:onReset()
	self._activityId = nil
	self._chargeMoney = 0
	self._hasSignDay = 0
	self._hasGainGifts = {}
	self._hasSignGiftS = {}
	self._isShowHub = false
	self._tryGetPrizeId = nil
	self._msgPool = {}
end

function FirstChargePlusModel:updateAfterGetInfo(msg)
	local activityId = msg.activityId

	self._msgPool[activityId] = GameUtil.pbToTable(msg)
end

function FirstChargePlusModel:updatePrize(activityId, pId)
	local msgInfo = self._msgPool[activityId]

	if msgInfo then
		msgInfo.hasGainGifts = msgInfo.hasGainGifts or {}

		table.insert(msgInfo.hasGainGifts, pId)
	end
end

function FirstChargePlusModel:updateDay(activityId, day)
	local msgInfo = self._msgPool[activityId]

	if msgInfo then
		msgInfo.hasGainSignPrizeDay = msgInfo.hasGainSignPrizeDay or {}

		table.insert(msgInfo.hasGainSignPrizeDay, day)
	end
end

function FirstChargePlusModel:setIsShowHub(isShow)
	self._isShowHub = checkbool(isShow)
end

function FirstChargePlusModel:tryGetPirze(id)
	self._tryGetPrizeId = checkint(id)
end

function FirstChargePlusModel:setShowIndex(id)
	self._showIndex = checkint(id)
end

function FirstChargePlusModel:tryGetSignPirze(id)
	self._tryGetPrizeId = checkint(id)
end

function FirstChargePlusModel:getChargeMoney(activityId)
	local msgInfo = self._msgPool[activityId]

	if msgInfo then
		return msgInfo.money
	end

	return 0
end

function FirstChargePlusModel:getIsHasSign(activityId, dayId)
	local msgInfo = self._msgPool[activityId]

	if msgInfo then
		return table.indexof(msgInfo.hasGainSignPrizeDay or {}, dayId) ~= false
	end

	return false
end

function FirstChargePlusModel:getSignIndex(activityId)
	local signCfgs = FirstChargePlusConfig.instance:getActSignCfgsById(activityId)

	if not signCfgs then
		return nil
	end

	local msgInfo = self._msgPool[activityId]

	return #((msgInfo or nil) and (msgInfo.hasGainSignPrizeDay or {})) + 1
end

function FirstChargePlusModel:getIsHasAllSign(activityId)
	local signCfgs = FirstChargePlusConfig.instance:getActSignCfgsById(activityId)

	if not signCfgs then
		return false
	end

	local msgInfo = self._msgPool[activityId]

	return #signCfgs <= #((msgInfo or nil) and (msgInfo.hasGainSignPrizeDay or {}))
end

function FirstChargePlusModel:getIsAbleToSign(activityId)
	local signCfgs = FirstChargePlusConfig.instance:getActSignCfgsById(activityId)

	if not signCfgs then
		return false
	end

	local msgInfo = self._msgPool[activityId]

	return ((msgInfo or nil) and msgInfo.loginDay) >= self:getSignIndex(activityId) and not self:getIsHasAllSign(activityId)
end

function FirstChargePlusModel:getCurActivityId()
	return ActivityDefineController.instance:getActivityIdByType(324)
end

function FirstChargePlusModel:getCurPetSkinGoodId()
	return 9001
end

function FirstChargePlusModel:getCurPigSkinGoodId()
	return 4013
end

function FirstChargePlusModel:getHasGainGiftByIndex(activityId, id)
	local msgInfo = self._msgPool[activityId]

	if id == 1 then
		local money = FirstChargePlusConfig.instance:getActCfgsById(activityId, id).consumeMoney

		if msgInfo then
			return money <= msgInfo.money and not self:getIsAbleToSign(activityId)
		end
	elseif msgInfo then
		if not msgInfo.hasGainGifts then
			local list = {}

			return table.indexof(list, id) ~= false
		end
	end

	return false
end

function FirstChargePlusModel:getCurActCfgs(activityId)
	return FirstChargePlusConfig.instance:getActCfgsById(activityId)
end

function FirstChargePlusModel:getTemResByActcfg(activityId)
	local res = {}
	local cfgs = FirstChargePlusConfig.instance:getActCfgsById(activityId)

	if cfgs then
		for k, v in pairs(cfgs) do
			table.insert(res, GameUrl.getFirstChargeBGUrl(v.BG))
		end

		table.remove(res)
	end

	return res
end

function FirstChargePlusModel:getIsShowHub()
	return self._isShowHub
end

function FirstChargePlusModel:getShowIndex()
	return self._showIndex
end

FirstChargePlusModel.instance = FirstChargePlusModel.New()

return FirstChargePlusModel
