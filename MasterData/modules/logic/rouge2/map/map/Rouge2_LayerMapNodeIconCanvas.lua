-- chunkname: @modules/logic/rouge2/map/map/Rouge2_LayerMapNodeIconCanvas.lua

module("modules.logic.rouge2.map.map.Rouge2_LayerMapNodeIconCanvas", package.seeall)

local Rouge2_LayerMapNodeIconCanvas = class("Rouge2_LayerMapNodeIconCanvas", LuaCompBase)
local CanvasPlanceDistance = 7

function Rouge2_LayerMapNodeIconCanvas:init(go)
	self.go = go
	self.goNodeContainer = gohelper.findChild(self.go, "#go_LayerNodeContainer")
	self.goNodeItem = gohelper.findChild(self.go, "#go_LayerNodeContainer/#go_NodeItem")
	self.tranNodeContainer = self.goNodeContainer.transform

	gohelper.setActive(self.goNodeItem, false)

	self.Canvas = self.go:GetComponent("Canvas")
	self.Canvas.worldCamera = CameraMgr.instance:getMainCamera()
	self.Canvas.planeDistance = CanvasPlanceDistance
	self.nodeItemTab = self:getUserDataTb_()
end

function Rouge2_LayerMapNodeIconCanvas:addEventListeners()
	return
end

function Rouge2_LayerMapNodeIconCanvas:removeEventListeners()
	return
end

function Rouge2_LayerMapNodeIconCanvas:getOrCreateNodeIconItem(nodeId)
	local nodeItem = self.nodeItemTab[nodeId]

	if not nodeItem then
		local go = gohelper.cloneInPlace(self.goNodeItem, nodeId)

		nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapNodeIconItem, self.tranNodeContainer)
		self.nodeItemTab[nodeId] = nodeItem
	end

	return nodeItem
end

function Rouge2_LayerMapNodeIconCanvas:onDestroy()
	self.Canvas.worldCamera = nil
end

return Rouge2_LayerMapNodeIconCanvas
