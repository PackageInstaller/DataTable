-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minigamecollection/controller/MiniGameCollectionController.lua

module("logic.extensions.minigamecollection.controller.MiniGameCollectionController", package.seeall)

local MiniGameCollectionController = class("MiniGameCollectionController", BaseController)

function MiniGameCollectionController:ctor()
	MiniGameCollectionController.super.ctor(self)
end

function MiniGameCollectionController:onReset()
	self.callBackList = {}
	self.callBackIdx = 0
end

function MiniGameCollectionController:onInit()
	self:onReset()
end

function MiniGameCollectionController:rmCallbackByIdx(idx, isHandle)
	local callBack = self.callBackList[idx]

	if idx and callBack then
		if isHandle then
			GameUtil.callBack(callBack.func, callBack.target)
		end

		self.callBackList[idx] = nil
	end
end

function MiniGameCollectionController:rmAllcallBack()
	self.callBackList = {}
end

function MiniGameCollectionController:addCallBack(cb, cbTarget)
	if cb ~= nil and type(cb) == "function" then
		self.callBackIdx = self.callBackIdx + 1

		local callBack = {}

		callBack.func = cb
		callBack.target = cbTarget
		self.callBackList[self.callBackIdx] = callBack

		return self.callBackIdx
	end
end

function MiniGameCollectionController:sendGetInfo(cb, cbTarget)
	local idx = self:addCallBack(cb, cbTarget)

	GameCollectionAgent.instance:sendPM_GameECollectionGetInfoReq(function(msg)
		MiniGameCollectionModel.instance:updateInfo(msg)
		self:rmCallbackByIdx(idx, true)
	end)
end

function MiniGameCollectionController:sendBuyTimes(cb, cbTarget)
	local idx = self:addCallBack(cb, cbTarget)

	GameCollectionAgent.instance:sendPM_GameECollectionBuyTimesReq(function(msg)
		MiniGameCollectionModel.instance:updateBuyPlayTimeSuc(msg)
		self:rmCallbackByIdx(idx, true)
	end)
end

MiniGameCollectionController.instance = MiniGameCollectionController.New()

return MiniGameCollectionController
