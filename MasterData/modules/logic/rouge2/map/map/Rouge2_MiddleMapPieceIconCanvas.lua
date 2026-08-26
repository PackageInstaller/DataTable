-- chunkname: @modules/logic/rouge2/map/map/Rouge2_MiddleMapPieceIconCanvas.lua

module("modules.logic.rouge2.map.map.Rouge2_MiddleMapPieceIconCanvas", package.seeall)

local Rouge2_MiddleMapPieceIconCanvas = class("Rouge2_MiddleMapPieceIconCanvas", LuaCompBase)
local CanvasPlanceDistance = 7

function Rouge2_MiddleMapPieceIconCanvas:init(go)
	self.go = go
	self.goPieceContainer = gohelper.findChild(self.go, "#go_LayerPieceContainer")
	self.goPieceItem = gohelper.findChild(self.go, "#go_LayerPieceContainer/#go_PieceItem")
	self.goLeaveItem = gohelper.findChild(self.go, "#go_LayerPieceContainer/#go_LeaveItem")
	self.tranPieceContainer = self.goPieceContainer.transform

	gohelper.setActive(self.goPieceItem, false)
	gohelper.setActive(self.goLeaveItem, false)

	self.Canvas = self.go:GetComponent("Canvas")
	self.Canvas.worldCamera = CameraMgr.instance:getMainCamera()
	self.Canvas.planeDistance = CanvasPlanceDistance
	self.pieceItemTab = self:getUserDataTb_()
end

function Rouge2_MiddleMapPieceIconCanvas:addEventListeners()
	return
end

function Rouge2_MiddleMapPieceIconCanvas:removeEventListeners()
	return
end

function Rouge2_MiddleMapPieceIconCanvas:getOrCreatePieceIconItem(pieceId)
	local nodeItem = self.pieceItemTab[pieceId]

	if not nodeItem then
		local go = gohelper.cloneInPlace(self.goPieceItem, pieceId)

		nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapPieceIconItem, self.tranPieceContainer)
		self.pieceItemTab[pieceId] = nodeItem
	end

	return nodeItem
end

function Rouge2_MiddleMapPieceIconCanvas:getOrCreateLeaveIconItem()
	self._leaveIconItem = self._leaveIconItem or MonoHelper.addNoUpdateLuaComOnceToGo(self.goLeaveItem, Rouge2_MapLeaveIconItem, self.tranPieceContainer)

	return self._leaveIconItem
end

function Rouge2_MiddleMapPieceIconCanvas:onDestroy()
	self.Canvas.worldCamera = nil
end

return Rouge2_MiddleMapPieceIconCanvas
