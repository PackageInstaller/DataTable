-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/model/RetrieveModel.lua

module("logic.extensions.retrieve.model.RetrieveModel", package.seeall)

local M = class("RetrieveModel", BaseModel)

function M:ctor()
	return
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._curJumpInfo = false
	self._lotteryId = false
	self._isTest = false
end

function M:cacheChoosePool(lotteryId)
	self._lotteryId = lotteryId
end

function M:getLotteryId()
	return self._lotteryId
end

function M:setJumpInfo(data)
	self._curJumpInfo = data
end

function M:getJumpInfo()
	return self._curJumpInfo
end

function M:clearJumpInfo()
	self._curJumpInfo = false
end

function M:setTestModel(isTest)
	self._isTest = isTest
end

function M:getIsTest()
	return self._isTest or false
end

M.instance = M.New()

return M
