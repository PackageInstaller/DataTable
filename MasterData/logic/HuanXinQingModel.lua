-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/model/HuanXinQingModel.lua

module("logic.extensions.huanxinqing.model.HuanXinQingModel", package.seeall)

local HuanXinQingModel = class("HuanXinQingModel", BaseModel)

function HuanXinQingModel:ctor()
	return
end

function HuanXinQingModel:onInit()
	self:onReset()
end

function HuanXinQingModel:onReset()
	self._scrollerData = {}
	self._curLevel = 0
	self._curAwakeLevel = 0
	self._getPet = false
	self._unLockItems = {}
	self._hasDirectBuy = false
	self._pressCheckItemId = 0
	self._ModelPool = self._ModelPool or {}
end

function HuanXinQingModel:GetModel(activityId)
	if self._ModelPool[activityId] == nil then
		local cur = {}

		cur.unlockItems = {}
		cur.getPet = false
		cur.hasDirectBuy = false
		cur.propBuyTimes = {}
		self._ModelPool[activityId] = cur
	end

	return self._ModelPool[activityId]
end

function HuanXinQingModel:handlePM_PetActiveGetInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.unlockItems = msg.unlockItems or {}
	curModel.hasDirectBuy = checkbool(msg.hasDirectBuy)
	curModel.propBuyTimes = {}

	if msg.propBuyTimes then
		table.insertto(curModel.propBuyTimes, msg.propBuyTimes)
	end
end

function HuanXinQingModel:handlePM_PetActiveGetUnlockRes(msg)
	local curModel = self:GetModel(msg.activityId)

	table.insert(curModel.unlockItems, msg.itemId)
end

function HuanXinQingModel:handlePM_PetActiveGetDirectBuyRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.hasDirectBuy = true
end

function HuanXinQingModel:handlePM_PetActiveGetExchangePropRes(msg)
	local curModel = self:GetModel(msg.activityId)
	local old = curModel.propBuyTimes[msg.propId]

	curModel.propBuyTimes[msg.propId] = old + msg.num
end

function HuanXinQingModel:hasBuy(activityId, itemId)
	local curModel = self:GetModel(activityId)

	if curModel.hasDirectBuy then
		return true
	end

	return table.indexof(curModel.unlockItems, itemId) ~= false
end

function HuanXinQingModel:getPropBuyTimes(activityId, propId)
	local curModel = self:GetModel(activityId)

	return curModel.propBuyTimes[propId] or 0
end

HuanXinQingModel.instance = HuanXinQingModel.New()

return HuanXinQingModel
