-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/model/MaterialMo.lua

module("logic.extensions.material.model.MaterialMo", package.seeall)

local MaterialMo = class("MaterialMo")

function MaterialMo:ctor()
	self.subType = 0

	local mt = getmetatable(self)
	local set = mt.__newindex

	function mt.__newindex(t, k, v)
		if k == "materialType" then
			rawset(t, "type", v)
		elseif k == "type" then
			rawset(t, "materialType", v)
		end

		if set ~= nil then
			if type(set) == "function" then
				set(t, k, v)
			else
				set[k] = v
			end
		else
			rawset(t, k, v)
		end
	end

	setmetatable(self, mt)
end

function MaterialMo:initData(matType, id, num)
	local t = type(matType)

	if t == "number" then
		self.type = matType
		self.id = id
		self.num = num or 0
	elseif t == "string" then
		local arr = (matType .. "").split(":")

		self.type = checknumber(arr[1])
		self.id = checknumber(arr[2])
		self.num = checknumber(arr[3]) or 0
	end
end

function MaterialMo:getId()
	return self.id
end

function MaterialMo:getMatType()
	return self.type
end

function MaterialMo:getDefineId()
	return self.id
end

function MaterialMo:SetCount(newValue)
	self.num = newValue
end

function MaterialMo:GetCount()
	return self.num
end

function MaterialMo:GetMatType()
	return self.type
end

function MaterialMo:checkSameByTypeId(type, id)
	return type == self.type and self.id == id
end

function MaterialMo:addCount(num)
	self:SetCount(self.num + num)
end

function MaterialMo:GetSubType()
	return self.subType
end

function MaterialMo:clone()
	local mat = MaterialMo.New()

	mat:initData(self.type, self.id, self.num)

	return mat
end

function MaterialMo:toString()
	return self.type .. ":" .. self.id .. ":" .. self.num
end

return MaterialMo
