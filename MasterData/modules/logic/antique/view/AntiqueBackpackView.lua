-- chunkname: @modules/logic/antique/view/AntiqueBackpackView.lua

module("modules.logic.antique.view.AntiqueBackpackView", package.seeall)

local AntiqueBackpackView = class("AntiqueBackpackView", BaseView)

function AntiqueBackpackView:onInitView()
	self._scrollantique = gohelper.findChildScrollRect(self.viewGO, "#scroll_antique")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AntiqueBackpackView:addEvents()
	return
end

function AntiqueBackpackView:removeEvents()
	return
end

function AntiqueBackpackView:_editableInitView()
	self._ani = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function AntiqueBackpackView:onUpdateParam()
	return
end

function AntiqueBackpackView:onOpen()
	self.viewContainer:setCurrentSelectCategoryId(ItemEnum.CategoryType.Antique)

	self._ani.enabled = #self.tabContainer._tabAbLoaders < 2
	self._scrollantique.verticalNormalizedPosition = 1

	self:refreshAntique()
end

function AntiqueBackpackView:refreshAntique()
	local antiqueList = AntiqueModel.instance:getAntiqueList()
	local list = {}

	for _, mo in pairs(antiqueList) do
		table.insert(list, mo)
	end

	AntiqueBackpackListModel.instance:setAntiqueList(list)
end

function AntiqueBackpackView:onClose()
	return
end

function AntiqueBackpackView:onDestroyView()
	AntiqueBackpackListModel.instance:clearAntiqueList()
end

return AntiqueBackpackView
