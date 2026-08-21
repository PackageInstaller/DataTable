-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/StoreMo.lua

module("logic.extensions.store.model.StoreMo", package.seeall)

local M = class("StoreMo")

function M:ctor()
	self._id = false
	self._storeCO = false
	self._tabId = false
	self._isOnline = false
	self._canManualRefresh = false
	self._manualRefreshCost = false
	self._remainedManualRefreshTimes = false
	self._autoRefreshType = false
	self._autoRefreshParams = false
	self._name = false
	self._showIndex = false
	self._showCoin = false
	self._autoRefreshRemainedSeconds = false
	self._endRemainedSeconds = false
	self._hasGoods = true
end

function M:initByCfg(id)
	self._id = id
	self._storeCO = StoreConfig.instance:getStoreCO(id)
	self._isOnline = false

	if self._storeCO then
		self._tabId = self._storeCO.tabId
		self._storeType = self._storeCO.mallType
		self._canManualRefresh = self._storeCO.manualRefreshDailyLimit > 0 or self._storeCO.manualRefreshDailyLimit == -1
		self._manualRefreshDailyLimit = self._storeCO.manualRefreshDailyLimit
		self._manualRefreshCost = self._storeCO.manualRefreshCost
		self._autoRefreshType = self._storeCO.autoRefreshType
		self._autoRefreshParams = self._storeCO.autoRefreshParams
		self._name = self._storeCO.name
		self._showIndex = self._storeCO.showIndex
		self._showCoin = self._storeCO.showCoin
	end
end

function M:initByAgent(data)
	self._id = data.mallId
	self._storeCO = StoreConfig.instance:getStoreCO(data.mallId)

	if not self._storeCO then
		return
	end

	self:initByCfg(data.mallId)

	if self._storeCO.openId == 0 then
		self._isOnline = true
	else
		local isOpen, lockIndex = SystemOpenModel.instance:isOpen(self._storeCO.openId)

		self._isOnline = isOpen
	end

	self:updateByAgent(data)
end

function M:updateByAgent(data)
	self._autoRefreshRemainedSeconds = tonumber(data.autoRefreshRemainedSeconds)
	self._endRemainedSeconds = tonumber(data.endRemainedSeconds)
	self._remainedManualRefreshTimes = tonumber(data.remainedManualRefreshTimes)
	self._updateTime = ServerTime.now()
	self._hasGoods = true
end

function M:getIsOnLine()
	return self._isOnline
end

function M:setIsOnLine(state)
	self._isOnline = state
end

function M:getId()
	return self._id
end

function M:getTabId()
	return self._tabId
end

function M:getName()
	return self._name
end

function M:getShowIndex()
	return self._showIndex
end

function M:getShowCoin()
	return self._showCoin
end

function M:getStoreCO()
	return self._storeCO
end

function M:getStoreType()
	return self._storeType
end

function M:getCanManualRefresh()
	return self._canManualRefresh
end

function M:setIsHasGoods(value)
	self._hasGoods = value
end

function M:getIsHasGoods()
	return self._hasGoods
end

function M:getAutoRefreshRemainedSeconds()
	if self._updateTime then
		local now = ServerTime.now()
		local offset = now - self._updateTime

		if self._autoRefreshRemainedSeconds - offset > 0 then
			return self._autoRefreshRemainedSeconds - offset
		else
			return 0
		end
	else
		return self._autoRefreshRemainedSeconds
	end
end

function M:getRemainedManualRefreshTimes()
	return self._storeCO.manualRefreshDailyLimit == -1 and 1 or self._remainedManualRefreshTimes or 0
end

return M
