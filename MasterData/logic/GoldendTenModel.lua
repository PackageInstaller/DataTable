-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/model/GoldendTenModel.lua

module("logic.extensions.goldendten.model.GoldendTenModel", package.seeall)

local GoldendTenModel = class("GoldendTenModel", BaseModel)

function GoldendTenModel:ctor()
	return
end

function GoldendTenModel:onInit()
	self:onReset()
end

function GoldendTenModel:onReset()
	self._baseInfoMap = {}
end

function GoldendTenModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function GoldendTenModel:getBaseInfoByActId(actId)
	if not self._baseInfoMap[actId] then
		printInfo("黄金十周年数据未初始化")
	end

	return self._baseInfoMap[actId]
end

function GoldendTenModel:onGainPrize(msg)
	local baseInfo = self:getBaseInfoByActId(msg.activityId)

	if msg.anotherPrize then
		baseInfo.anotherHasGain = baseInfo.anotherHasGain or {}
		baseInfo.anotherHasGain[msg.prizeId] = true
	else
		baseInfo.hasGain = baseInfo.hasGain or {}
		baseInfo.hasGain[msg.prizeId] = true
	end
end

function GoldendTenModel:onBecomeLeader(msg)
	local baseInfo = self:getBaseInfoByActId(msg.activityId)

	baseInfo.myCode = msg.code
end

function GoldendTenModel:getCurActId()
	return self._curActId
end

function GoldendTenModel:setCurActId(actId)
	self._curActId = actId
end

function GoldendTenModel:getCurCode(actId)
	local baseInfo = self:getBaseInfoByActId(actId)

	return baseInfo and baseInfo.myCode
end

function GoldendTenModel:getOwnIdentity(actId)
	local baseInfo = self:getBaseInfoByActId(actId)

	return baseInfo and baseInfo.identity
end

function GoldendTenModel:getPrizeStatus(actId, prizeId)
	local baseInfo = self:getBaseInfoByActId(actId)
	local var_12_0

	if baseInfo then
		::label_12_0::

		var_12_0 = baseInfo.hasGain and baseInfo.hasGain[prizeId]
	end

	return var_12_0
end

function GoldendTenModel:getAnotherPrizeStatus(actId, prizeId)
	local baseInfo = self:getBaseInfoByActId(actId)
	local var_13_0

	if baseInfo then
		::label_13_0::

		var_13_0 = baseInfo.anotherHasGain and baseInfo.anotherHasGain[prizeId]
	end

	return var_13_0
end

function GoldendTenModel:getCurTeamMateList(actId)
	local baseInfo = self:getBaseInfoByActId(actId)

	return (baseInfo or nil) and (baseInfo.teammates or {})
end

GoldendTenModel.instance = GoldendTenModel.New()

return GoldendTenModel
