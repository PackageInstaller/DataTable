-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapEpisodeItem.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapEpisodeItem", package.seeall)

local RougeMapEpisodeItem = class("RougeMapEpisodeItem", UserDataDispose)

function RougeMapEpisodeItem:init(episodeMo, map)
	self:__onInit()

	self.episodeMo = episodeMo
	self.map = map
	self.parentGo = self.map.goLayerNodeContainer
	self.index = episodeMo.id

	self:createGo()
	self:createNodeItemList()
end

function RougeMapEpisodeItem:createGo()
	self.go = gohelper.create3d(self.parentGo, "episode" .. self.index)
	self.tr = self.go:GetComponent(gohelper.Type_Transform)

	transformhelper.setLocalPos(self.tr, RougeMapHelper.getEpisodePosX(self.index), 0, 0)
end

function RougeMapEpisodeItem:createNodeItemList()
	self.nodeItemList = {}

	local nodeMoList = self.episodeMo:getNodeMoList()

	self.posType = #nodeMoList

	for _, nodeMo in ipairs(nodeMoList) do
		local nodeItem = RougeMapNodeItem.New()

		nodeItem:init(nodeMo, self.map, self)
		table.insert(self.nodeItemList, nodeItem)
	end
end

function RougeMapEpisodeItem:getNodeItemList()
	return self.nodeItemList
end

function RougeMapEpisodeItem:destroy()
	for _, nodeItem in ipairs(self.nodeItemList) do
		nodeItem:destroy()
	end

	self:__onDispose()
end

return RougeMapEpisodeItem
