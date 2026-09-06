-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderClgFormationExView.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderClgFormationExView", package.seeall)

local DivineKingOrderClgFormationExView = class("DivineKingOrderClgFormationExView", ViewComponent)

function DivineKingOrderClgFormationExView:ctor()
	DivineKingOrderClgFormationExView.super.ctor(self)
end

function DivineKingOrderClgFormationExView:unbindEvents()
	DivineKingOrderClgFormationExView.super.unbindEvents(self)
end

function DivineKingOrderClgFormationExView:bindEvents()
	DivineKingOrderClgFormationExView.super.bindEvents(self)
end

function DivineKingOrderClgFormationExView:buildUI()
	DivineKingOrderClgFormationExView.super.buildUI(self)

	self._showCellList = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = self:getGo("cell_" .. i)
		cell.water = goutil.findChild(cell.go, "water")
		cell.kong = goutil.findChild(cell.go, "kong")
		self._showCellList[i] = cell
	end
end

function DivineKingOrderClgFormationExView:onExit()
	DivineKingOrderClgFormationExView.super.onExit(self)
end

function DivineKingOrderClgFormationExView:onEnter()
	DivineKingOrderClgFormationExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]

	local cfgs = self._customFmtMo:getMonsterConfigList()

	for i = 1, 9 do
		local cell = self._showCellList[i]

		goutil.setActive(cell.water, false)
		goutil.setActive(cell.kong, false)
	end

	for _, cfg in ipairs(cfgs) do
		local cell = self._showCellList[cfg.posId]

		if cell then
			goutil.setActive(cell.water, cfg.showOwnBuff == 1)
			goutil.setActive(cell.kong, cfg.showOwnBuff == 2)
		end
	end
end

return DivineKingOrderClgFormationExView
