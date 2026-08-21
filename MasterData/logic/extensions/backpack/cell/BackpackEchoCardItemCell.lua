-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/BackpackEchoCardItemCell.lua

module("logic.extensions.backpack.cell.BackpackEchoCardItemCell", package.seeall)

local M = class("BackpackEchoCardItemCell", BackpackItemCell)

function M:_initComponents()
	M.super._initComponents(self)

	local normalComp = self:getComponent("normal")

	normalComp:setRedPointType(CommEnum.RedPointIconType.Strong)
end

function M:refreshRed()
	local item = self._data

	if not item then
		return false
	end

	self:getComponent("normal"):setRedPointType(CommEnum.RedPointIconType.New)

	local redPoint = self:getComponent("normal"):getRedPoint()
	local isRed = item:getRedPointIsNew()

	goutil.setActive(redPoint, isRed)
end

return M
