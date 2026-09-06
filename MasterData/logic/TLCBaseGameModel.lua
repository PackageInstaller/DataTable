-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/TLCBaseGameModel.lua

module("logic.extensions.timelimitedchallenge.model.TLCBaseGameModel", package.seeall)

local TLCBaseGameModel = class("TLCBaseGameModel", BaseModel)

function TLCBaseGameModel:randomClientKey()
	self._clientKey = math.random(1, 100000)

	return self._clientKey
end

function TLCBaseGameModel:getClientKey()
	return self._clientKey
end

function TLCBaseGameModel:setServerKey(key)
	self._severKey = key
end

function TLCBaseGameModel:getServerKey()
	return self._severKey
end

function TLCBaseGameModel:getEncryptedKey(...)
	local encryptedKey = 0
	local clientKey = self:getClientKey()
	local serverKey = GenEncryptedKeyUtil.dxor(self:getServerKey(), clientKey)
	local nums = {
		...
	}

	for _, num in ipairs(nums) do
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	return tostring(encryptedKey)
end

TLCBaseGameModel.instance = TLCBaseGameModel.New()

return TLCBaseGameModel
