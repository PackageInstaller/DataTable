-- chunkname: @modules/logic/test/view/TestHeroBagItemView.lua

module("modules.logic.test.view.TestHeroBagItemView", package.seeall)

local TestHeroBagItemView = class("TestHeroBagItemView", BaseViewExtended)

function TestHeroBagItemView:onInitView()
	return
end

function TestHeroBagItemView:addEvents()
	return
end

function TestHeroBagItemView:onScrollItemRefreshData(data)
	self._data = data

	if self._heroItem then
		self._heroItem:onUpdateMO(self._data)
	end
end

function TestHeroBagItemView:onOpen()
	self:com_loadAsset("ui/viewres/common/item/commonheroitemnew.prefab", self._loaded)
end

function TestHeroBagItemView:_loaded(assetItem)
	local tarPrefab = assetItem:GetResource()
	local heroObj = gohelper.clone(tarPrefab, self.viewGO)

	self._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(heroObj, CommonHeroItem)

	self._heroItem:addClickListener(self._onItemClick, self)
end

function TestHeroBagItemView:_onItemClick()
	logError("点击了英雄id:" .. self._data.heroId)
end

function TestHeroBagItemView:onClose()
	if self._heroItem then
		self._heroItem:onDestroy()

		self._heroItem = nil
	end
end

return TestHeroBagItemView
