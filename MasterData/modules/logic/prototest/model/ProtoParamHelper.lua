-- chunkname: @modules/logic/prototest/model/ProtoParamHelper.lua

module("modules.logic.prototest.model.ProtoParamHelper", package.seeall)

local ProtoParamHelper = _M

function ProtoParamHelper.buildProtoParamsByProto(protoMsg, parentParamMO)
	local descriptor = getmetatable(protoMsg)._descriptor
	local fieldsDescList = descriptor.fields
	local moList = {}

	for _, fieldDesc in ipairs(fieldsDescList) do
		local value = protoMsg._fields[fieldDesc]
		local paramMO = ProtoTestCaseParamMO.New()

		paramMO:initProto(parentParamMO, fieldDesc, value)
		table.insert(moList, paramMO)
	end

	table.sort(moList, function(mo1, mo2)
		return mo1.id < mo2.id
	end)

	return moList
end

function ProtoParamHelper.buildRepeatedParamsByProto(protoMsg, parentParamMO)
	local moList = {}

	for i, oneValue in ipairs(protoMsg) do
		local paramMO = ProtoTestCaseParamMO.New()

		paramMO:initProtoRepeated(parentParamMO, i, oneValue)
		table.insert(moList, paramMO)
	end

	table.sort(moList, function(mo1, mo2)
		return mo1.id < mo2.id
	end)

	return moList
end

local ProtoList
local ProtoStructDict = {}

function ProtoParamHelper.buildProtoByStructName(protoStructName)
	ProtoParamHelper._firstInitProtoDict()

	if ProtoStructDict[protoStructName] then
		return ProtoStructDict[protoStructName]()
	end

	for _, proto in ipairs(ProtoList) do
		if proto[protoStructName] then
			ProtoStructDict[protoStructName] = proto[protoStructName]

			return ProtoStructDict[protoStructName]()
		end
	end
end

function ProtoParamHelper._firstInitProtoDict()
	if not ProtoList then
		ProtoList = {}

		for name, _ in pairs(moduleNameToPath) do
			if string.find(name, "_pb") then
				if not moduleNameToTables[name] then
					callWithCatch(function()
						return
					end)
				end

				table.insert(ProtoList, moduleNameToTables[name])
			end
		end
	end
end

function ProtoParamHelper.buildValueMOsByStructName(protoStructName)
	local list = {}
	local protoMsg = ProtoParamHelper.buildProtoByStructName(protoStructName)
	local descriptor = getmetatable(protoMsg)._descriptor
	local fieldsDescList = descriptor.fields

	for _, fieldDesc in ipairs(fieldsDescList) do
		local value = protoMsg._fields[fieldDesc]
		local paramMO = ProtoTestCaseParamMO.New()

		paramMO:initProto(nil, fieldDesc, value)
		table.insert(list, paramMO)
	end

	return list
end

return ProtoParamHelper
