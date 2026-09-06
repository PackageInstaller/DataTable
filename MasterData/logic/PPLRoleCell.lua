-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PPLRoleCell.lua

module("logic.extensions.maintainpowerpilla.view.PPLRoleCell", package.seeall)

local PPLRoleCell = class("PPLRoleCell")

function PPLRoleCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	printInfo("test PPLMapCell", go.name)

	self.mainGO = go
	self._rectTrans = self.mainGO:GetComponent(goutil.Type_RectTransform)
end

function PPLRoleCell:init(param)
	self._columnNum = param.columnNum

	self:updatePos(param.row, param.column, param.pos)
end

function PPLRoleCell:getRow()
	return self._row
end

function PPLRoleCell:getColumn()
	return self._column
end

function PPLRoleCell:getGridId()
	return self._gridId
end

function PPLRoleCell:getPos()
	return self._pos
end

function PPLRoleCell:updatePos(row, column, pos)
	self._gridId = (row - 1) * self._columnNum + column
	self._row = row
	self._column = column
	self._pos = pos

	Framework.TransformUtil.SetAnchoredPos(self._rectTrans, self._pos[1], self._pos[2])
end

function PPLRoleCell:setLocalScale(x, y, z)
	GameUtil.setLocalScale(self.mainGO, x, y, z)
end

return PPLRoleCell
