-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/impl/RogueMapModel.lua

module("logic.extensions.roguelike.unit.impl.RogueMapModel", package.seeall)

local M = class("RogueMapModel", RogueUnitBase)

function M:_initComponents()
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("transform", RogueCompTransform)
	self:_addComponent("meshModelMover", BattleUnitCompMeshModelMover)
	self:_addComponent("meshModel", RogueUnitCompMeshModel)
	self:_addComponent("material", RogueUnitCompMaterial)
end

function M:reset()
	Astral.TransformUtil.SetLocalPos(self.go.transform, 0, 0, 0)
	goutil.setActive(self.go, false)
end

function M:reuse()
	Astral.TransformUtil.SetLocalPos(self.go.transform, 0, 0, 0)
	goutil.setActive(self.go, true)
end

function M:OnDestroy()
	goutil.destroy(self.go)
end

return M
