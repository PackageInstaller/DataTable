-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarMo.lua

module("logiccommon.common.avatar.AvatarMo", package.seeall)

local AvatarMo = class("AvatarMo")
local keyOrders = {
	"expression",
	"face",
	"hair",
	"top",
	"pants",
	"shoes",
	"arm"
}
local tempCancatTable = {}

function AvatarMo:ctor()
	self.skeleton = nil
	self.expression = nil
	self.hair = nil
	self.face = nil
	self.top = nil
	self.pants = nil
	self.shoes = nil
	self.arm = nil
	self.mount = nil
	self.isMount = nil
	self.gender = nil
end

function AvatarMo:equal(mo)
	return self.skeleton == mo.skeleton and self.expression == mo.expression and self.hair == mo.hair and self.face == mo.face and self.top == mo.top and self.pants == mo.pants and self.shoes == mo.shoes and self.arm == mo.arm and self.mount == mo.mount
end

function AvatarMo:getAssetsList(avatarType)
	local assets = {}

	if self.skeleton then
		local skelCo = AvatarConfig.instance:getSkelCo(self.skeleton)

		table.insert(assets, GameUrl.getAvatarSkel(avatarType, skelCo.asset))
	end

	for k, v in pairs(AvatarPartType) do
		local id = self[AvatarPartTypeName[v]]

		if id and id > 0 then
			local skinCo = AvatarConfig.instance:getSkinMeshCo(self[AvatarPartTypeName[v]])

			table.insert(assets, GameUrl.getSkinMesh(avatarType, AvatarPartTypeName[v], skinCo.asset))
		end
	end

	return assets
end

function AvatarMo:toCombineKey()
	table.clear(tempCancatTable)

	for i = 1, #keyOrders do
		if not self[keyOrders[i]] then
			table.insert(tempCancatTable, keyOrders[i])
			table.insert(tempCancatTable, self[keyOrders[i]])
		end
	end

	return table.concat(tempCancatTable)
end

return AvatarMo
