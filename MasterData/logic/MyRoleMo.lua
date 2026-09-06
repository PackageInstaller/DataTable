-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/model/MyRoleMo.lua

module("logic.extensions.role.model.MyRoleMo", package.seeall)

local MyRoleMo = class("MyRoleMo", RoleMo)

function MyRoleMo:ctor()
	MyRoleMo.super.ctor(self)
end

return MyRoleMo
