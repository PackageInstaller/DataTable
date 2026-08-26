-- chunkname: @modules/logic/backpack/controller/BackpackController.lua

module("modules.logic.backpack.controller.BackpackController", package.seeall)

local BackpackController = class("BackpackController", BaseController)

BackpackController.BackpackViewTabContainerId = 2

function BackpackController:onInit()
	return
end

function BackpackController:onInitFinish()
	return
end

function BackpackController:addConstEvents()
	self.registerCallback(self, BackpackEvent.SelectCategoryById, self._onSelectCategoryById, self)
end

function BackpackController:_onSelectCategoryById(id)
	self._selectCategoryType = tonumber(id)
end

function BackpackController:enterItemBackpack(categoryEnum)
	local data = {}

	data.cateList = self:getCategoryCoList()
	data.itemList = BackpackModel.instance:getBackpackList()

	if self._selectCategoryType then
		categoryEnum = categoryEnum or self._selectCategoryType
	end

	self._selectCategoryType = nil
	categoryEnum = categoryEnum or ItemEnum.CategoryType.Material

	BackpackModel.instance:setCurCategoryId(categoryEnum)
	BackpackModel.instance:setBackpackItemList(data.itemList)
	BackpackModel.instance:setBackpackCategoryList(data.cateList)
	BackpackCategoryListModel.instance:setCategoryList(data.cateList)

	local id = BackpackModel.instance:getCurCategoryId()
	local itemList = BackpackModel.instance:getCategoryItemlist(id)

	BackpackPropListModel.instance:setCategoryPropItemList(itemList)

	local viewParam = {}

	viewParam.data = data
	viewParam.isJump = true

	if categoryEnum == ItemEnum.CategoryType.Equip then
		viewParam.defaultTabIds = {}
		viewParam.defaultTabIds[BackpackController.BackpackViewTabContainerId] = 2
	elseif categoryEnum == ItemEnum.CategoryType.Antique then
		-- block empty
	end

	ViewMgr.instance:openView(ViewName.BackpackView, viewParam)
end

function BackpackController:getCategoryCoList()
	local categoryList = tabletool.copy(BackpackConfig.instance:getCategoryList())

	table.remove(categoryList, 1)

	local hasExpBoxItem = HeroExpBoxModel.instance:hasExpBoxItem()

	if not hasExpBoxItem then
		for i, co in ipairs(categoryList) do
			if co.id == ItemEnum.CategoryType.HeroExpBox then
				table.remove(categoryList, i)

				break
			end
		end
	end

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Equip) then
		local equipCateCo = {}

		equipCateCo.id = ItemEnum.CategoryType.Equip
		equipCateCo.name = luaLang("equip")
		equipCateCo.subname = "PSYCHUBE"

		table.insert(categoryList, equipCateCo)
	end

	if AntiqueModel.instance:isAntiqueUnlock() then
		local antiqueCateCo = {}

		antiqueCateCo.id = ItemEnum.CategoryType.Antique
		antiqueCateCo.name = luaLang("antique")
		antiqueCateCo.subname = "Collections"

		table.insert(categoryList, antiqueCateCo)
	end

	return categoryList
end

function BackpackController:reInit()
	return
end

BackpackController.instance = BackpackController.New()

return BackpackController
