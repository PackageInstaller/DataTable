-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/TimingD6ItemCell.lua

module("logic.extensions.charactersystem.view.equip.TimingD6ItemCell", package.seeall)

local M = class("TimingD6ItemCell", BackpackD6ItemCell)

function M:_initComponents()
	M.super._initComponents(self)
end

function M:dealSelect()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_TIMING_D6_SELECTED, self._data)
end

function M:onSelect(isSelected)
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isSelected)

	local operateComp = self:getComponent("operate")

	operateComp:setImgOperateGoVisible(false)
	operateComp:setBtnCutGoVisible(false)
end

return M
