-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/store/AirWorkShopStoreModel.lua

module("logic.extensions.airworkshop.model.store.AirWorkShopStoreModel", package.seeall)

local M = class("AirWorkShopStoreModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	return
end

function M:getStoreTabId()
	return AirWorkShopConfig.instance:getStudioConst("StoreTabId").numValue
end

function M:getStoreList()
	local tabId = self:getStoreTabId()

	return StoreModel.instance:getStoreListByTabIndex(tabId) or {}
end

M.instance = M.New()

return M
