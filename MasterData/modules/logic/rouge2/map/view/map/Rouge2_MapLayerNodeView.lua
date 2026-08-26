-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapLayerNodeView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapLayerNodeView", package.seeall)

local Rouge2_MapLayerNodeView = class("Rouge2_MapLayerNodeView", LuaCompBase)

function Rouge2_MapLayerNodeView:init(go)
	self.go = go
	self.goLayerNodeContainer = gohelper.findChild(self.go, "#go_LayerNodeContainer")
end

function Rouge2_MapLayerNodeView:initCanvas()
	self._canvas = self.go:GetComponent("Canvas")
	self._canvas.worldCamera = CameraMgr.instance:getMainCamera()
end

function Rouge2_MapLayerNodeView:onDestory()
	self._canvas = nil
	self._canvas.worldCamera = nil
end

function Rouge2_MapLayerNodeView:getLayerNodeContainer()
	return self.goLayerNodeContainer
end

return Rouge2_MapLayerNodeView
