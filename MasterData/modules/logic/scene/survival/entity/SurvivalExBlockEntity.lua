-- chunkname: @modules/logic/scene/survival/entity/SurvivalExBlockEntity.lua

module("modules.logic.scene.survival.entity.SurvivalExBlockEntity", package.seeall)

local SurvivalExBlockEntity = class("SurvivalExBlockEntity", SurvivalBlockEntity)

function SurvivalExBlockEntity.Create(blockMo, root)
	local go = gohelper.create3d(root, tostring(blockMo.pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(blockMo.pos.q, blockMo.pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, blockMo.dir * 60 + 30, 0)

	if blockMo.co then
		local blockRes = SurvivalMapHelper.instance:getSpBlockRes(blockMo.co.map, blockMo.co.resource)

		if blockRes then
			local blockGo = gohelper.clone(blockRes, go)
			local trans = blockGo.transform

			transformhelper.setLocalPos(trans, 0, 0, 0)
			transformhelper.setLocalRotation(trans, 0, 0, 0)
			transformhelper.setLocalScale(trans, 1, 1, 1)
		end
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalExBlockEntity, blockMo)
end

return SurvivalExBlockEntity
