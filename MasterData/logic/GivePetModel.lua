-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/givepet/model/GivePetModel.lua

module("logic.extensions.givepet.model.GivePetModel", package.seeall)

local GivePetModel = class("GivePetModel", BaseModel)

function GivePetModel:ctor()
	return
end

function GivePetModel:onInit()
	self._userList = {}
	self._saveTime = 0
	self._index = 0
end

function GivePetModel:onReset()
	self._saveTime = 0
	self._index = 1
end

function GivePetModel:addUser(list)
	for i, value in ipairs(list) do
		local user = {
			id = value.userId,
			name = value.userName,
			time = value.time
		}

		table.insert(self._userList, user)
	end

	self._userLength = #self._userList
	self._saveTime = ServerTime.now()
end

function GivePetModel:getUser()
	if self._userList[self._index + 1] then
		self._index = self._index + 1 % self._userLength

		return self._userList[self._index]
	else
		return nil
	end
end

function GivePetModel:isUpdate()
	return self._saveTime == 0 or self._saveTime > ServerTime.now() + 300
end

function GivePetModel:clearUser()
	return
end

GivePetModel.instance = GivePetModel.New()

return GivePetModel
