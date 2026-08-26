-- chunkname: @modules/logic/test/view/TestHeroBagView.lua

module("modules.logic.test.view.TestHeroBagView", package.seeall)

local TestHeroBagView = class("TestHeroBagView", BaseViewExtended)

function TestHeroBagView:onInitView()
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#scroll_card")
end

function TestHeroBagView:addEvents()
	return
end

function TestHeroBagView:definePrefabUrl()
	self.internal_pre_url = "ui/viewres/character/characterbackpackheroview.prefab"
end

function TestHeroBagView:onOpen()
	local data = HeroModel.instance:getList()

	self._scroll_view = self:com_registSimpleScrollView(self._scrollcard.gameObject, ScrollEnum.ScrollDirV, 6)

	self._scroll_view:setClass(TestHeroBagItemView)
	self._scroll_view:setData(data)
end

function TestHeroBagView:onClose()
	return
end

return TestHeroBagView
