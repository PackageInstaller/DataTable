-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapEpisodeItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapEpisodeItem", package.seeall)

local Rouge2_MapEpisodeItem = class("Rouge2_MapEpisodeItem", UserDataDispose)

function Rouge2_MapEpisodeItem:init(episodeMo, map)
	self:__onInit()

	self.episodeMo = episodeMo
	self.map = map
	self.parentGo = self.map.goLayerNodeContainer
	self.index = episodeMo.id

	self:createGo()
	self:createNodeItemList()
end

function Rouge2_MapEpisodeItem:createGo()
	self.go = gohelper.create3d(self.parentGo, "episode" .. self.index)
	self.tr = self.go:GetComponent(gohelper.Type_Transform)

	transformhelper.setLocalPos(self.tr, Rouge2_MapHelper.getEpisodePosX(self.index), 0, 0)
end

function Rouge2_MapEpisodeItem:createNodeItemList()
	self.nodeItemList = {}

	local nodeMoList = self.episodeMo:getNodeMoList()

	self.posType = #nodeMoList

	for _, nodeMo in ipairs(nodeMoList) do
		local nodeItem = Rouge2_MapNodeItem.New()

		nodeItem:init(nodeMo, self.map, self)
		table.insert(self.nodeItemList, nodeItem)
	end
end

function Rouge2_MapEpisodeItem:getNodeItemList()
	return self.nodeItemList
end

function Rouge2_MapEpisodeItem:destroy()
	for _, nodeItem in ipairs(self.nodeItemList) do
		nodeItem:destroy()
	end

	self:__onDispose()
end

return Rouge2_MapEpisodeItem
