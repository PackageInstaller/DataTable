-- chunkname: @modules/logic/sp01/act204/controller/Activity204RpcWork.lua

module("modules.logic.sp01.act204.controller.Activity204RpcWork", package.seeall)

local Activity204RpcWork = class("Activity204RpcWork", BaseWork)

function Activity204RpcWork:ctor(activityId, rpcFunc, rpcInst, params, callback, callbackObj)
	self._activityId = activityId
	self._rpcFunc = rpcFunc
	self._rpcInst = rpcInst
	self._params = params
	self._callback = callback
	self._callbackObj = callbackObj
end

function Activity204RpcWork:onStart()
	local isOpen = ActivityHelper.isOpen(self._activityId)

	if not isOpen then
		self:onDone(true)

		return
	end

	if not self._rpcFunc or not self._rpcInst then
		logError(string.format("Activity204RpcWork Error ! RpcFun or RpcInst is nil ! activityId = %s", self._activityId))
		self:onDone(false)

		return
	end

	self._callbackId = self._params and self._rpcFunc(self._rpcInst, self._params, self._onGetRpcInfo, self) or self._rpcFunc(self._rpcInst, self._onGetRpcInfo, self)
end

function Activity204RpcWork:_onGetRpcInfo(resultCode, msg)
	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, resultCode, msg)
		else
			self._callback(resultCode, msg)
		end
	end

	self:onDone(true)
end

function Activity204RpcWork:clearWork()
	if self._callbackId and self._rpcInst then
		self._rpcInst:removeCallbackById(self._callbackId)

		self.callbackId = nil
	end

	Activity204RpcWork.super.clearWork(self)
end

return Activity204RpcWork
