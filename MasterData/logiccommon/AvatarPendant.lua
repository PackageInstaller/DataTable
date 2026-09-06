-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarobject/AvatarPendant.lua

module("logiccommon.common.avatar.avatarobj.AvatarPendant", package.seeall)

local AvatarPendant = class("AvatarPendant", AvatarObject)

function AvatarPendant:ctor(ctrl)
	AvatarPendant.super.ctor(self)

	self._type = nil
	self._id = nil
	self._ctrl = ctrl
end

function AvatarPendant:load(assetPath)
	AvatarPendant.super.load(self, assetPath)

	if not self._id then
		printError("Pendant'Id is NIL VALUE")
	end
end

function AvatarPendant:destroy()
	AvatarPendant.super.destroy(self)

	self._type = nil
	self._id = nil
	self._ctrl = nil
end

function AvatarPendant:loadedHandle(loader)
	if loader == self._resLoader then
		AvatarPendant.super.loadedHandle(self, loader)

		local resObject = self:getResObject()

		resObject.go.name = AvatarPendantTypeName[self._type]

		if self:getGameObject() then
			self._ctrl:dispatch(AvatarNotify.OnPendantLoaded, self)
		end
	end
end

function AvatarPendant:callBackHandle(loader)
	if loader == self._resLoader then
		AvatarPendant.super.callBackHandle(self, loader)
		self._ctrl:dispatch(AvatarNotify.OnPendantLoaded, self)
	end
end

function AvatarPendant:setParent(parent)
	AvatarPendant.super.setParent(self, parent)

	if parent and parent.name then
		if parent.name ~= AvatarHangPointName[AvatarPendantTypeParent[self._type]] then
			print("Pendant's parent is not match type")
		end

		local resObject = self:getResObject()

		if resObject then
			resObject:setRotation(90, 0, 0)
		end

		if resObject and self._id == 500001 then
			if self._ctrl._avatar.avatarmo.skeleton == 1 then
				if self._ctrl._avatar.avatarmo.isMount then
					if self._ctrl._avatar.avatarmo.mount == 10 then
						resObject:setRotation(33.99649, 164.3748, 164.1496)
						resObject:setLocalPos(0.056, 0.052, 0.048)
					else
						resObject:setRotation(90, 0, 0)
						resObject:setLocalPos(0, 0, 0)
					end
				else
					resObject:setRotation(62.4613, 9.951274, 1.68937)
					resObject:setLocalPos(-0.019, 0.045, -0.083)
				end
			elseif self._ctrl._avatar.avatarmo.skeleton == 2 then
				if self._ctrl._avatar.avatarmo.isMount then
					if self._ctrl._avatar.avatarmo.mount == 10 then
						resObject:setRotation(60.82223, 9.997886, 0.8934644)
						resObject:setLocalPos(0.028, 0.071, 0.019)
					else
						resObject:setRotation(90, 0, 0)
						resObject:setLocalPos(0, 0, 0)
					end
				else
					resObject:setRotation(65.9317, 177.9734, 181.315)
					resObject:setLocalPos(0.013, 0.053, -0.003)
				end
			end
		end
	end
end

function AvatarPendant:setPendantType(pendantType)
	if not table.keyof(AvatarPendantType, pendantType) then
		printError("Pendant set Error Type")
	end

	self._type = pendantType
end

function AvatarPendant:getPendantType()
	return self._type
end

function AvatarPendant:setPendantId(id)
	self._id = id
end

function AvatarPendant:getPendantId()
	return self._id
end

function AvatarPendant:reset()
	self._id = nil
	self._assetPath = nil
	self._parent = nil

	self._resLoader:clear()
end

function AvatarPendant:resetState()
	self:_updateParent()

	local resObject = self:getResObject()

	if resObject then
		resObject:setRotation(90, 0, 0)
	end
end

return AvatarPendant
