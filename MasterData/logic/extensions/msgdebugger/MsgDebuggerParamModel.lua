-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/msgdebugger/MsgDebuggerParamModel.lua

module("logic.extensions.msgdebugger.MsgDebuggerParamModel", package.seeall)

local MsgDebuggerParamModel = class("MsgDebuggerParamModel", BaseListModel)

function MsgDebuggerParamModel:onInit()
	MsgDebuggerParamModel.super.onInit(self)

	self.editingMsgMO = nil
	self.paramDepth = nil
end

function MsgDebuggerParamModel:enterMsg(msgDebuggerMO, depthName)
	if not self.paramDepth then
		self.paramDepth = {}
	end

	if depthName then
		table.insert(self.paramDepth, depthName)
	end

	if msgDebuggerMO then
		self.editingMsgMO = msgDebuggerMO
	end

	local paramList = self.editingMsgMO:getParamList(self.paramDepth)

	self:setMoList(paramList)
end

function MsgDebuggerParamModel:exitMsg(isForce)
	if isForce or self.paramDepth and #self.paramDepth == 0 then
		self.paramDepth = nil
		self.editingMsgMO = nil
	elseif self.paramDepth and #self.paramDepth > 0 then
		table.remove(self.paramDepth, #self.paramDepth)

		local paramList = self.editingMsgMO:getParamList(self.paramDepth)

		self:setMoList(paramList)
	end
end

function MsgDebuggerParamModel:addDefaultParam(paramMO)
	local paramList = self.editingMsgMO:getParamList(self.paramDepth)
	local paramCount = paramList and #paramList or 0

	paramMO.id = paramCount + 1

	local addParamMO = MsgDebuggerParamMO.New()

	addParamMO:initRepeated(self.editingMsgMO, paramMO.parentParamMO, paramCount)
	addParamMO:setDefaultValue(self.editingMsgMO, paramMO.parentParamMO, paramCount)
	table.insert(paramList, paramCount, addParamMO)
	self:setMoList(paramList)
end

function MsgDebuggerParamModel:removeParam(paramMO)
	local paramList = self.editingMsgMO:getParamList(self.paramDepth)

	table.remove(paramList, paramMO.id)
	table.remove(paramMO.parentParamMO.msgValue, paramMO.id)

	for i = 1, #paramList do
		paramList[i].id = i
	end

	self:setMoList(paramList)
end

function MsgDebuggerParamModel:isModifingParam()
	return self.editingMsgMO
end

MsgDebuggerParamModel.instance = MsgDebuggerParamModel.New()

return MsgDebuggerParamModel
