-- chunkname: @/tmp/or_script/lua_compile/cocos/physics3d/physics3d-constants.lua

if cc.Physics3DComponent == nil then
	return
end

cc.Physics3DComponent.PhysicsSyncFlag = {
	PHYSICS_TO_NODE = 2,
	NODE_TO_PHYSICS = 1,
	NODE_AND_NODE = 3,
	NONE = 0
}
cc.Physics3DObject.PhysicsObjType = {
	RIGID_BODY = 1,
	UNKNOWN = 0
}
