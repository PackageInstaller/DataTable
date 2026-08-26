-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterScenePathComp.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterScenePathComp", package.seeall)

local SurvivalShelterScenePathComp = class("SurvivalShelterScenePathComp", BaseSceneComp)

SurvivalShelterScenePathComp.ResPaths = {
	Point = "survival/transport/v2a8_survival_transport_e.prefab"
}

function SurvivalShelterScenePathComp:onScenePrepared(sceneId, levelId)
	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._pathRoot = gohelper.create3d(self._sceneGo, "Effect")

	local trans = self._pathRoot.transform

	transformhelper.setLocalPos(trans, 0, 0.01, 0)

	self.effectList = {}
	self._pools = {}

	for k, v in pairs(SurvivalShelterScenePathComp.ResPaths) do
		self._pools[v] = {}
	end
end

function SurvivalShelterScenePathComp:showPath(path)
	self:clearEffects()

	local pos = path[#path]

	if not pos then
		return
	end

	table.insert(self.effectList, self:getObj(SurvivalShelterScenePathComp.ResPaths.Point, pos, 0))
end

function SurvivalShelterScenePathComp:hidePath()
	self:clearEffects()
end

function SurvivalShelterScenePathComp:getObj(path, pos, rotate)
	local go = table.remove(self._pools[path])

	if go then
		gohelper.setActive(go, true)
	else
		local res = SurvivalMapHelper.instance:getBlockRes(path)

		go = gohelper.clone(res, self._pathRoot)
	end

	local trans = go.transform
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

	transformhelper.setLocalPos(trans, x, y, z)
	transformhelper.setLocalRotation(trans, 0, rotate + 90, 0)

	return {
		path = path,
		go = go
	}
end

function SurvivalShelterScenePathComp:returnObj(path, obj)
	table.insert(self._pools[path], obj)
	gohelper.setActive(obj, false)
end

function SurvivalShelterScenePathComp:clearEffects()
	if not next(self.effectList) then
		return
	end

	for _, v in ipairs(self.effectList) do
		self:returnObj(v.path, v.go)
	end

	self.effectList = {}
end

function SurvivalShelterScenePathComp:onSceneClose()
	for k, v in pairs(self._pools) do
		for _, go in pairs(v) do
			gohelper.destroy(go)
		end
	end

	self._pools = {}

	for _, v in ipairs(self.effectList) do
		gohelper.destroy(v.go)
	end

	self.effectList = {}
end

return SurvivalShelterScenePathComp
