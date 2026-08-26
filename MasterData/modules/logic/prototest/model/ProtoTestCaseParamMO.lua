-- chunkname: @modules/logic/prototest/model/ProtoTestCaseParamMO.lua

module("modules.logic.prototest.model.ProtoTestCaseParamMO", package.seeall)

local ProtoTestCaseParamMO = pureTable("ProtoTestCaseParamMO")

function ProtoTestCaseParamMO:initProto(parentParamMO, descField, value)
	self.key = descField.name
	self.value = value
	self.id = descField.number
	self.pType = descField.type
	self.pLabel = descField.label
	self.repeated = false

	if self:isRepeated() then
		self.value = ProtoParamHelper.buildRepeatedParamsByProto(value or {}, self)

		if descField.message_type then
			self.struct = descField.message_type.name
		end
	elseif self:isProtoType() then
		if value then
			self.struct = getmetatable(value)._descriptor.name
			self.value = ProtoParamHelper.buildProtoParamsByProto(value, self)
		else
			self.struct = descField.message_type.name

			local temp = ProtoParamHelper.buildProtoByStructName(self.struct)

			self.value = ProtoParamHelper.buildProtoParamsByProto(temp, self)
		end
	end
end

function ProtoTestCaseParamMO:initProtoRepeated(parentParamMO, id, value)
	self.key = id
	self.value = value
	self.id = id
	self.pType = parentParamMO.pType
	self.pLabel = ProtoEnum.LabelType.optional
	self.repeated = true

	if self:isProtoType() then
		self.struct = getmetatable(value)._descriptor.name
		self.value = ProtoParamHelper.buildProtoParamsByProto(value, self)
	end
end

function ProtoTestCaseParamMO:isProtoType()
	return self.pType == ProtoEnum.ParamType.proto
end

function ProtoTestCaseParamMO:isOptional()
	return self.pLabel == ProtoEnum.LabelType.optional
end

function ProtoTestCaseParamMO:isRepeated()
	return self.pLabel == ProtoEnum.LabelType.repeated
end

function ProtoTestCaseParamMO:getParamDescLine()
	if self:isRepeated() then
		local tb = {}

		for _, childParamMO in ipairs(self.value) do
			table.insert(tb, childParamMO:getParamDescLine())
		end

		return string.format("%s:{%s}", self.key, table.concat(tb, ","))
	elseif self:isProtoType() then
		local tb = {}

		if self.value then
			for _, childParamMO in ipairs(self.value) do
				table.insert(tb, childParamMO:getParamDescLine())
			end
		end

		if self.repeated then
			return string.format("{%s}", table.concat(tb, ","))
		else
			return string.format("%s:{%s}", self.key, table.concat(tb, ","))
		end
	elseif self.repeated then
		return cjson.encode(self.value)
	else
		return string.format("%s:%s", self.key, self.value)
	end
end

function ProtoTestCaseParamMO:clone()
	local paramMO = ProtoTestCaseParamMO.New()

	paramMO.key = self.key
	paramMO.value = self.value
	paramMO.id = self.id
	paramMO.pType = self.pType
	paramMO.pLabel = self.pLabel
	paramMO.struct = self.struct
	paramMO.repeated = self.repeated

	if self:isRepeated() then
		paramMO.value = {}

		for _, childParamMO in ipairs(self.value) do
			table.insert(paramMO.value, childParamMO:clone())
		end
	elseif self:isProtoType() then
		paramMO.value = {}

		for _, childParamMO in ipairs(self.value) do
			local cloneChildParamMO = childParamMO:clone()

			table.insert(paramMO.value, cloneChildParamMO)
		end
	end

	return paramMO
end

function ProtoTestCaseParamMO:fillProtoMsg(protoMsg)
	if not self.value then
		return
	end

	if self:isRepeated() then
		for _, childParamMO in ipairs(self.value) do
			childParamMO:fillProtoMsg(protoMsg[self.key])
		end
	elseif self:isProtoType() then
		if self.repeated then
			local proto = ProtoParamHelper.buildProtoByStructName(self.struct)

			for _, childParamMO in ipairs(self.value) do
				childParamMO:fillProtoMsg(proto)
			end

			table.insert(protoMsg, proto)
		else
			for _, childParamMO in ipairs(self.value) do
				childParamMO:fillProtoMsg(protoMsg[self.key])
			end
		end
	elseif self.repeated then
		table.insert(protoMsg, self.value)
	else
		if not protoMsg then
			logError(self.key)
		end

		protoMsg[self.key] = self.value
	end
end

function ProtoTestCaseParamMO:serialize()
	local jsonTable = {}

	jsonTable.key = self.key
	jsonTable.value = self.value
	jsonTable.id = self.id
	jsonTable.pType = self.pType
	jsonTable.pLabel = self.pLabel
	jsonTable.repeated = self.repeated
	jsonTable.struct = self.struct

	if self:isRepeated() or self:isProtoType() then
		jsonTable.value = {}

		for _, childParamMO in ipairs(self.value) do
			table.insert(jsonTable.value, childParamMO:serialize())
		end
	end

	return jsonTable
end

function ProtoTestCaseParamMO:deserialize(jsonTable)
	self.key = jsonTable.key
	self.value = jsonTable.value
	self.id = jsonTable.id
	self.pType = jsonTable.pType
	self.pLabel = jsonTable.pLabel
	self.repeated = jsonTable.repeated
	self.struct = jsonTable.struct

	if self:isRepeated() or self:isProtoType() then
		self.value = {}

		for _, childParamJson in ipairs(jsonTable.value) do
			local paramMO = ProtoTestCaseParamMO.New()

			paramMO:deserialize(childParamJson)
			table.insert(self.value, paramMO)
		end
	end
end

return ProtoTestCaseParamMO
