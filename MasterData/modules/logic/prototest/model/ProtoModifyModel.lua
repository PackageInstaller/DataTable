-- chunkname: @modules/logic/prototest/model/ProtoModifyModel.lua

module("modules.logic.prototest.model.ProtoModifyModel", package.seeall)

local ProtoModifyModel = class("ProtoModifyModel", ListScrollModel)

function ProtoModifyModel:onInit()
	self._protoMO = nil
	self._depthParamMOs = {}
end

function ProtoModifyModel:getProtoMO()
	return self._protoMO
end

function ProtoModifyModel:getDepthParamMOs()
	return self._depthParamMOs
end

function ProtoModifyModel:getLastMO()
	local depthCount = #self._depthParamMOs

	if depthCount > 0 then
		return self._depthParamMOs[depthCount]
	else
		return self._protoMO
	end
end

function ProtoModifyModel:enterProto(protoMO)
	self._protoMO = protoMO

	self:setList(protoMO.value)
end

function ProtoModifyModel:enterParam(id)
	local paramMO = #self._depthParamMOs > 0 and self._depthParamMOs[#self._depthParamMOs].value[id] or self._protoMO.value[id]

	table.insert(self._depthParamMOs, paramMO)

	if paramMO:isRepeated() or paramMO:isProtoType() then
		self:setList(paramMO.value)

		if paramMO:isRepeated() then
			self:addAtLast({
				id = -99999
			})
		end
	end
end

function ProtoModifyModel:exitParam()
	local depthCount = #self._depthParamMOs

	table.remove(self._depthParamMOs, depthCount)

	if depthCount > 1 then
		local paramMO = self._depthParamMOs[depthCount - 1]

		self:setList(paramMO.value)

		if paramMO:isRepeated() then
			self:addAtLast({
				id = -99999
			})
		end
	else
		self:setList(self._protoMO.value)
	end
end

function ProtoModifyModel:addRepeatedParam()
	local depthCount = #self._depthParamMOs

	if depthCount > 0 then
		local parentParamMO = self._depthParamMOs[depthCount]

		if parentParamMO:isRepeated() then
			local addParamMO = ProtoTestCaseParamMO.New()

			addParamMO.id = #parentParamMO.value + 1
			addParamMO.key = #parentParamMO.value + 1
			addParamMO.pType = parentParamMO.pType
			addParamMO.pLabel = ProtoEnum.LabelType.optional
			addParamMO.repeated = true
			addParamMO.struct = parentParamMO.struct

			if addParamMO.struct then
				addParamMO.value = ProtoParamHelper.buildValueMOsByStructName(addParamMO.struct)
			end

			table.insert(parentParamMO.value, addParamMO)
			self:addAt(addParamMO, addParamMO.id)
		else
			logError("can't remove param, not repeated")
		end
	else
		logError("cant't remove param, not at root")
	end
end

function ProtoModifyModel:removeRepeatedParam(id)
	local depthCount = #self._depthParamMOs

	if depthCount > 0 then
		local parentParamMO = self._depthParamMOs[depthCount]

		if parentParamMO:isRepeated() then
			table.remove(parentParamMO.value, id)
			self:removeAt(id)

			for i, childParamMO in ipairs(parentParamMO.value) do
				childParamMO.id = i
				childParamMO.key = i
			end
		else
			logError("can't remove param, not repeated")
		end
	else
		logError("cant't remove param, not at root")
	end
end

function ProtoModifyModel:isRoot()
	return #self._depthParamMOs == 0
end

ProtoModifyModel.instance = ProtoModifyModel.New()

return ProtoModifyModel
