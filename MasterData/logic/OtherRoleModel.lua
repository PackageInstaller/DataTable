-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/model/OtherRoleModel.lua

module("logic.extensions.role.model.OtherRoleModel", package.seeall)

local Src = {
	Chat = 2,
	Friend = 1
}
local Trans = {
	[Src.Friend] = {
		maxZdl = "zdl",
		userId = "id",
		name = "name"
	},
	[Src.Chat] = {
		senderId = "id",
		senderName = "name"
	}
}
local OtherRoleModel = class("OtherRoleModel", BaseModel)

function OtherRoleModel:ctor()
	OtherRoleModel.super.ctor(self)

	self._data = {}
end

function OtherRoleModel:AddData(id, data, src)
	id = tonumber(id)

	local mo = self:GetData(id)
	local isNew = mo == nil

	if isNew then
		mo = OtherRoleMo.New()
	end

	for k, v in pairs(Trans[src]) do
		local value = data[k]

		if v == "id" then
			value = tonumber(value)
		end

		mo:Set(v, value)
	end

	self._data[id] = mo

	return mo
end

function OtherRoleModel:GetData(id)
	id = tonumber(id)

	return self._data[id]
end

OtherRoleModel.instance = OtherRoleModel.New()
OtherRoleModel.Src = Src

return OtherRoleModel
