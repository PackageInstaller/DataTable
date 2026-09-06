-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/UserMaterial.lua

module("logic.extensions.material.proxy.UserMaterial", package.seeall)

local UserMaterial = class("UserMaterial")

UserMaterial.DAY = 86400

function UserMaterial:ctor(materialType, id, num, validityTime)
	self.materialType = materialType
	self.id = id
	self.num = num
	self.validityTime = validityTime or 0
end

function UserMaterial:getMaterial()
	if self.material == nil then
		-- block empty
	end

	return self.material
end

function UserMaterial:getMaterialId()
	return self:getMaterial() and self:getMaterial().id or 0
end

function UserMaterial:isForever()
	if self.validityTime <= 0 then
		return true
	end

	local serTime = ServerTime.now()

	if serTime >= self.validityTime then
		return false
	end

	return false
end

return UserMaterial
