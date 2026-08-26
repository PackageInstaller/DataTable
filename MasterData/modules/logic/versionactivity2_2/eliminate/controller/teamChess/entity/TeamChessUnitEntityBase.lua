-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/entity/TeamChessUnitEntityBase.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessUnitEntityBase", package.seeall)

local TeamChessUnitEntityBase = class("TeamChessUnitEntityBase", LuaCompBase)
local tweenHelper = ZProj.TweenHelper

function TeamChessUnitEntityBase:init(go)
	self.go = go
	self.trans = go.transform
	self._posX = 0
	self._posY = 0
	self._posZ = 0
	self._lastActive = nil
	self._canClick = false
	self._canDrag = false
	self._scale = 1
end

function TeamChessUnitEntityBase:updateMo(unitMo)
	self._unitMo = unitMo

	self:setScale(unitMo:getScale())
	self:loadAsset(self._unitMo:getUnitPath())
end

function TeamChessUnitEntityBase:loadAsset(path)
	if not string.nilorempty(path) and not self._loader then
		self._loader = PrefabInstantiate.Create(self.go)

		self._loader:startLoad(path, self._onResLoaded, self)
	end
end

function TeamChessUnitEntityBase:updatePos(posX, posY, posZ)
	self._posX, self._posY, self._posZ = posX, posY, posZ

	transformhelper.setPos(self.trans, posX, posY, posZ)
end

function TeamChessUnitEntityBase:moveToPos(posX, posY, posZ)
	tweenHelper.DOMove(self.trans, posX, posY, posZ, EliminateTeamChessEnum.entityMoveTime, self._onMoveEnd, nil, nil, EaseType.OutQuart)
end

function TeamChessUnitEntityBase:getPosXYZ()
	local x, y, z = transformhelper.getPos(self.trans)

	return x, y + 0.4, z
end

function TeamChessUnitEntityBase:getTopPosXYZ()
	local x, y, z = self:getPosXYZ()

	return x - 0.1, y + 0.5, z
end

function TeamChessUnitEntityBase:setActive(active)
	if self._lastActive == nil then
		self._lastActive = active
	end

	if self._lastActive ~= active then
		gohelper.setActive(self.go, active)

		self._lastActive = active
	end
end

function TeamChessUnitEntityBase:setCanClick(state)
	self._canClick = state
end

function TeamChessUnitEntityBase:setCanDrag(state)
	self._canDrag = state
end

function TeamChessUnitEntityBase:setScale(scale)
	self._scale = scale or 1
end

function TeamChessUnitEntityBase:_onResLoaded()
	self._resGo = self._loader:getInstGO()

	transformhelper.setLocalScale(self._resGo.transform, self._scale, self._scale, self._scale)
end

function TeamChessUnitEntityBase:dispose()
	self:onDestroy()
end

function TeamChessUnitEntityBase:onDestroy()
	gohelper.destroy(self.go)

	self._lastActive = nil

	if self._loader then
		self._loader:onDestroy()

		self._loader = nil
	end
end

return TeamChessUnitEntityBase
