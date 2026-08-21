-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/unit/UnitTeamPlayer.lua

module("logic.extensions.team.unit.UnitTeamPlayer", package.seeall)

local M = class("UnitTeamPlayer", BattleUnitBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self.heroId = nil
end

function M:getTag()
	return UnitTag.Player
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:_initComponents()
	self:_addComponent("meshModel", UnitCompMeshModel)
	self:_addComponent("uiFollow", UnitCompUIFollow)
	self:_addComponent("namebar", UnitCompInfoBar)
	self:_addComponent("mover", UnitCompMover)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
end

function M:getSize()
	return
end

function M:Update()
	return
end

return M
