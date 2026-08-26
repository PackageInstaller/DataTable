-- chunkname: @modules/logic/rouge2/backpack/model/descmo/Rouge2_ItemDescInfoMO.lua

module("modules.logic.rouge2.backpack.model.descmo.Rouge2_ItemDescInfoMO", package.seeall)

local Rouge2_ItemDescInfoMO = pureTable("Rouge2_ItemDescInfoMO")

function Rouge2_ItemDescInfoMO:init(descType, descMode, ...)
	self._descType = descType
	self._descMode = descMode

	self:_initParamList(...)
end

function Rouge2_ItemDescInfoMO:_initParamList(...)
	self._paramMap = {}

	local paramList = {
		...
	}
	local paramNum = math.floor(#paramList)

	for i = 1, paramNum - 1, 2 do
		local key = paramList[i]
		local value = paramList[i + 1]
		local isSucc = self:addParam(key, value)

		if not isSucc then
			logError(string.format("Rouge2_ItemDescInfoMO._initParamList error !!! descType = %s, paramIndex = %s", self._descType, i))

			break
		end
	end
end

function Rouge2_ItemDescInfoMO:addParam(key, value)
	if not key or not value then
		return
	end

	self._paramMap[key] = value

	return true
end

function Rouge2_ItemDescInfoMO:getDescType()
	return self._descType
end

function Rouge2_ItemDescInfoMO:getDescMode()
	return self._descMode
end

function Rouge2_ItemDescInfoMO:getValue(key)
	if not key then
		return nil
	end

	return self._paramMap and self._paramMap[key]
end

function Rouge2_ItemDescInfoMO:getContent()
	return (self:getValue(Rouge2_Enum.RelicsDescParam.Desc))
end

return Rouge2_ItemDescInfoMO
