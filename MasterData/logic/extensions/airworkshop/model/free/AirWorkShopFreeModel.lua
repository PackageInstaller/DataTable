-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/free/AirWorkShopFreeModel.lua

module("logic.extensions.airworkshop.model.free.AirWorkShopFreeModel", package.seeall)

local M = class("AirWorkShopFreeModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._playerFreeEndlessInfo = nil
end

function M:updateEndlessInfoFromServer(msg)
	local infoMo = self:getEndlessPlayerInfoMo()

	if not infoMo then
		self._playerFreeEndlessInfo = AirWorkShopFreeEndlessMo.New()
		infoMo = self._playerFreeEndlessInfo
	end

	infoMo:updateFromServer(msg)
end

function M:getEndlessPlayerInfoMo()
	return self._playerFreeEndlessInfo
end

function M:getEndlessCurIsWin()
	local isWin
	local infoMo = self:getEndlessPlayerInfoMo()

	if infoMo then
		isWin = infoMo:getIsWin()
	end

	return isWin
end

M.instance = M.New()

return M
