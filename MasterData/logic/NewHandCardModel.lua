-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/model/NewHandCardModel.lua

module("logic.extensions.newhandcard.model.NewHandCardModel", package.seeall)

local NewHandCardModel = class("NewHandCardModel", BaseModel)

function NewHandCardModel:ctor()
	return
end

function NewHandCardModel:onInit()
	self:onReset()
end

function NewHandCardModel:onReset()
	self._buycardtime = 0
	self._gaintimes = {}
	self._needCheckTime = false
	self._getServerMsg = false
	self._allTimeClose = false
end

function NewHandCardModel:isgetServerMsg()
	return self._getServerMsg
end

function NewHandCardModel:setCardInfo(buycardtime, gaintimes)
	self._needCheckTime = true
	self._buycardtime = checknumber(buycardtime)
	self._gaintimes = gaintimes or self._gaintimes
	self._getServerMsg = true
end

function NewHandCardModel:setBuyCardInfo(buycardtime)
	self._needCheckTime = true
	self._buycardtime = checknumber(buycardtime)

	table.insert(self._gaintimes, buycardtime)

	self._getServerMsg = true
end

function NewHandCardModel:getGainTimes()
	return self._gaintimes
end

function NewHandCardModel:isBuyCard()
	return self._buycardtime > 0
end

function NewHandCardModel:needCheckIconTime()
	return self._needCheckTime
end

function NewHandCardModel:setNeedCheckIconTime(bool)
	self._needCheckTime = bool
end

function NewHandCardModel:isShowMainIcon()
	if self._allTimeClose then
		return false
	end

	local open = FuncOpenModel.instance:getFuncIsOpen(142)

	if not open then
		return false
	end

	local show = true

	if self._getServerMsg then
		if self:isBuyCard() then
			show = ServerTime.nowMs() - self._buycardtime < 86400000 * NewHandCardConfig.instance:getDuration()
			self._allTimeClose = not show
		elseif not self:isInAct() then
			show = false

			local openTime = NewHandCardConfig.instance:getOpenAndCloseTime()

			self._allTimeClose = openTime < ServerTime.now()
		elseif self:isInAct() then
			show = true
		end
	end

	return show
end

function NewHandCardModel:isInAct()
	local openTime, closeTIme = NewHandCardConfig.instance:getOpenAndCloseTime()
	local now = ServerTime.now()

	return openTime < now and now < closeTIme
end

NewHandCardModel.instance = NewHandCardModel.New()

return NewHandCardModel
