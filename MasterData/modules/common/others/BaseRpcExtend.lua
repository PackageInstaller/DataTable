-- chunkname: @modules/common/others/BaseRpcExtend.lua

module("modules.common.others.BaseRpcExtend", package.seeall)

local BaseRpcExtend = class("BaseRpcExtend", BaseRpc)

function BaseRpcExtend:onInitInternal()
	self._getter = GameUtil.getUniqueTb(10000)
	self._waitCallBackDict = {}

	BaseRpcExtend.super.onInitInternal(self)
end

function BaseRpcExtend:reInitInternal()
	self._waitCallBackDict = {}

	BaseRpcExtend.super.reInitInternal(self)
end

function BaseRpcExtend:sendMsg(protobuf, callback, callbackObj, socketId)
	local cmd = LuaSocketMgr.instance:getCmdByPbStructName(protobuf.__cname)

	self._waitCallBackDict[cmd] = self._waitCallBackDict[cmd] or {}

	if self._waitCallBackDict[cmd][1] ~= nil then
		BaseRpcExtend.super.sendMsg(self, protobuf, nil, nil, socketId)
	else
		BaseRpcExtend.super.sendMsg(self, protobuf, self.onReceiveMsgExtend, self, socketId)
	end

	if callback then
		local luaCb = LuaGeneralCallback.getPool():getObject()

		luaCb.callback = callback

		luaCb:setCbObj(callbackObj)

		luaCb.id = self._getter()

		table.insert(self._waitCallBackDict[cmd], luaCb)

		return luaCb.id
	else
		table.insert(self._waitCallBackDict[cmd], false)
	end
end

function BaseRpcExtend:removeCallbackByIdExtend(id)
	for _, list in pairs(self._waitCallBackDict) do
		for index, luaCb in ipairs(list) do
			if luaCb and luaCb.id == id then
				list[index] = false

				LuaGeneralCallback.getPool():putObject(luaCb)

				return
			end
		end
	end
end

function BaseRpcExtend:onReceiveMsgExtend(cmd, resultCode, msg)
	if not self._waitCallBackDict[cmd] then
		return
	end

	local luaCb = table.remove(self._waitCallBackDict[cmd], 1)

	if self._waitCallBackDict[cmd][1] ~= nil then
		self.addCallback(self, cmd, self.onReceiveMsgExtend, self)
	end

	if luaCb then
		luaCb:invoke(cmd, resultCode, msg)
		LuaGeneralCallback.getPool():putObject(luaCb)
	end
end

return BaseRpcExtend
