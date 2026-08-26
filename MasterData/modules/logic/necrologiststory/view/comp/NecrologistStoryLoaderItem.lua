-- chunkname: @modules/logic/necrologiststory/view/comp/NecrologistStoryLoaderItem.lua

module("modules.logic.necrologiststory.view.comp.NecrologistStoryLoaderItem", package.seeall)

local NecrologistStoryLoaderItem = class("NecrologistStoryLoaderItem")

function NecrologistStoryLoaderItem:ctor(param, parent)
	self.parent = parent
	self.loaderId = param.loaderId
	self.loadingPathList = param.loadingPathList
	self.loader = nil
end

function NecrologistStoryLoaderItem:startLoad()
	if self.loader then
		return
	end

	self.loader = MultiAbLoader.New()

	self.loader:setPathList(self.loadingPathList)
	self.loader:startLoad(self.onLoadedFinish, self)
end

function NecrologistStoryLoaderItem:onLoadedFinish(loader)
	if self.parent then
		self.parent:_onItemLoaded(self.loaderId, loader, self.loadingPathList)
	end
end

function NecrologistStoryLoaderItem:dispose()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.parent = nil
end

return NecrologistStoryLoaderItem
