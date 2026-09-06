-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/model/PetskinMo.lua

module("logic.extensions.petskin.model.PetskinMo", package.seeall)

local PetskinMo = class("PetskinMo", MaterialMo)

function PetskinMo:ctor()
	return
end

function PetskinMo:setData(data)
	self.data = data

	if data then
		local time = checknumber(data.expireTimeMillis)

		if data:HasField("expireTimeMillis") and checknumber(data.expireTimeMillis) > 0 then
			-- block empty
		else
			PetskinModel.instance:setForeverSkin(data.skinId)
		end
	end
end

function PetskinMo:setOtherName(name)
	if self.data then
		self.data.otherName = name
	end
end

function PetskinMo:getOtherName()
	return self.data.otherName
end

function PetskinMo:isForeverSkin()
	if self.data then
		return checknumber(self.data.expireTimeMillis) <= 0
	end

	return false
end

return PetskinMo
