-- chunkname: @modules/logic/scene/shelter/entity/SurvivalShelterBlockEntity.lua

module("modules.logic.scene.shelter.entity.SurvivalShelterBlockEntity", package.seeall)

local SurvivalShelterBlockEntity = class("SurvivalShelterBlockEntity", LuaCompBase)

function SurvivalShelterBlockEntity.Create(blockCo, root)
	local go = gohelper.create3d(root, tostring(blockCo.pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(blockCo.pos.q, blockCo.pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, blockCo.dir * 60 + 30, 0)

	local blockRes = SurvivalMapHelper.instance:getBlockRes(blockCo.assetPath)

	if blockRes then
		local blockGo = gohelper.clone(blockRes, go)
		local trans = blockGo.transform

		transformhelper.setLocalPos(trans, 0, 0, 0)
		transformhelper.setLocalRotation(trans, 0, 0, 0)
		transformhelper.setLocalScale(trans, 1, 1, 1)
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalShelterBlockEntity, blockCo)
end

function SurvivalShelterBlockEntity:init(go)
	self.go = go
end

function SurvivalShelterBlockEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

return SurvivalShelterBlockEntity
