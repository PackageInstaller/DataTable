-- chunkname: @modules/logic/scene/shelter/entity/SurvivalShelterNpcEntity.lua

module("modules.logic.scene.shelter.entity.SurvivalShelterNpcEntity", package.seeall)

local SurvivalShelterNpcEntity = class("SurvivalShelterNpcEntity", SurvivalShelterUnitEntity)

function SurvivalShelterNpcEntity.Create(unitType, unitId, root)
	local pos, dir = SurvivalMapHelper.instance:getRandomWalkPosAndDir(unitId)

	if not pos then
		logError(string.format("not find npc random pos, npcId:%s", unitId))

		return
	end

	local go = gohelper.create3d(root, tostring(pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, dir * 60, 0)

	local param = {
		unitType = unitType,
		unitId = unitId,
		pos = pos,
		dir = dir
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalShelterNpcEntity, param)
end

function SurvivalShelterNpcEntity:onCtor(param)
	self.pos = param.pos
	self.dir = param.dir
end

function SurvivalShelterNpcEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function SurvivalShelterNpcEntity:onInit()
	self:showModel()
end

function SurvivalShelterNpcEntity:showModel()
	if not gohelper.isNil(self.goModel) then
		return
	end

	if self._loader then
		return
	end

	self._loader = PrefabInstantiate.Create(self.go)

	local path = self:getResPath()

	if string.nilorempty(path) then
		return
	end

	self._loader:startLoad(path, self._onResLoadEnd, self)
end

function SurvivalShelterNpcEntity:getResPath()
	local npcConfig = SurvivalConfig.instance:getNpcConfig(self.unitId)

	if not npcConfig then
		return nil
	end

	return npcConfig.resource
end

function SurvivalShelterNpcEntity:_onResLoadEnd()
	local go = self._loader:getInstGO()
	local trans = go.transform

	self.goModel = go

	transformhelper.setLocalPos(trans, 0, 0, 0)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)
	self:onLoadedEnd()
end

function SurvivalShelterNpcEntity:needUI()
	return true
end

return SurvivalShelterNpcEntity
