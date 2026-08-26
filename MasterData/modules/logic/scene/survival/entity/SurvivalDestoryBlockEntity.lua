-- chunkname: @modules/logic/scene/survival/entity/SurvivalDestoryBlockEntity.lua

module("modules.logic.scene.survival.entity.SurvivalDestoryBlockEntity", package.seeall)

local SurvivalDestoryBlockEntity = class("SurvivalDestoryBlockEntity", SurvivalBlockEntity)

function SurvivalDestoryBlockEntity.Create(unitMo, root)
	local go = gohelper.create3d(root, tostring(unitMo.pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(unitMo.pos.q, unitMo.pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, 0, 0)

	local blockRes = SurvivalMapHelper.instance:getSpBlockRes(0, "survival_kengdong")

	if blockRes then
		local blockGo = gohelper.clone(blockRes, go)
		local trans = blockGo.transform

		transformhelper.setLocalPos(trans, 0, 0, 0)
		transformhelper.setLocalRotation(trans, 0, 30, 0)
		transformhelper.setLocalScale(trans, 1, 1, 1)
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalDestoryBlockEntity, unitMo)
end

return SurvivalDestoryBlockEntity
