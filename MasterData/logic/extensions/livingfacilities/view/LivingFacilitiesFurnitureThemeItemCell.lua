-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesFurnitureThemeItemCell.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesFurnitureThemeItemCell", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("LivingFacilitiesFurnitureThemeItemCell")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._txtTheme = registry:findUIElement("theme_item_1809213794", UIComponentType.Text)
	self._goHint = registry:findUIElement("theme_item_1723887273")
	self._txtScrollGo = registry:findUIElement("theme_item_-1442209565")
	self._txtLoopList = LoopListHelper.New(self._txtScrollGo)

	self._txtLoopList:InitListView(0, self._updateTxtCell, self)

	self._rightFurnitureScrollGo = registry:findUIElement("theme_item_-519480465")
	self._furnitureLoopList = LoopGridViewHelper.New(self._rightFurnitureScrollGo)

	self._furnitureLoopList:InitGridView(0, self._updateFurnitureCell, self)

	self._btnHint = ButtonAdapter.Get(self._goHint)

	self._btnHint:AddClickListener(self._clickHint, self)

	self._hintAffect = registry:findUIElement("theme_item_-1689305958", UIComponentType.Text)
	self._hintDesc = registry:findUIElement("theme_item_105099323", UIComponentType.Text)
end

function M:_clickHint()
	goutil.setActive(self._goHint, true)
end

function M:setCellData(data, index, furnitureList)
	self._showerList = {}
	self._id = data
	self._index = index
	self._furnitureList = furnitureList

	local themeMo = LivingFacilitiesFurniThemeModel.instance:getThemeMoById(self._id)

	self._effectList = themeMo:getEffectList()
	self._allCount = themeMo:getStatusByFurnitureList(self._furnitureList)
	self._fullCount = themeMo:getFullCount()
	self._txtTheme.text = themeMo:getName()

	self._txtLoopList:SetListItemCount(#self._effectList, true)

	self._furnitureCoLit = themeMo:getFurnitureCoListOnline()

	self._furnitureLoopList:SetListItemCount(#self._furnitureCoLit, true)
	goutil.setActive(self._goHint, false)
end

function M:_updateTxtCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._txtLoopList:NewListViewItem("txt_Item")
	local effectInfo = self._effectList[curIndex]
	local unselect = goutil.findChild(item, "type1")
	local select = goutil.findChild(item, "type2")
	local num1 = goutil.findChildTextComponent(unselect, "txt1")
	local num2 = goutil.findChildTextComponent(select, "txt1")
	local up1 = goutil.findChildTextComponent(unselect, "txt2")
	local up2 = goutil.findChildTextComponent(select, "txt2")

	num1.text = string.format("%d/%d", effectInfo.count, self._fullCount)
	num2.text = string.format("%d/%d", effectInfo.count, self._fullCount)
	up1.text = effectInfo.num
	up2.text = effectInfo.num

	local status = self._allCount >= effectInfo.count
	local effectNextInfo = self._effectList[curIndex + 1]

	if effectNextInfo then
		status = status and self._allCount < effectNextInfo.count
	end

	goutil.setActive(unselect, not status)
	goutil.setActive(select, status)

	return item
end

function M:_updateFurnitureCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._furnitureLoopList:NewListViewItem("live_furniture_item1")
	local furnitureInfo = self._furnitureCoLit[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LivingFurnitureItemCell)

	shower:setCellData(ItemData.New({
		itemId = furnitureInfo.id
	}), curIndex)

	local status = table.indexof(self._furnitureList, furnitureInfo.id)

	shower:setLockStatus(status == false)
	table.insert(self._showerList, shower)

	return item
end

function M:refreshHint()
	if self._allCount == self._fullCount then
		goutil.setActive(self._btnHint.gameObject, true)

		local themeMo = LivingFacilitiesFurniThemeModel.instance:getThemeMoById(self._id)
		local activeSkillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(themeMo:getSkillCode())

		self._hintAffect.text = activeSkillCOWrapper and activeSkillCOWrapper:getName() or ""
		self._hintDesc.text = activeSkillCOWrapper and activeSkillCOWrapper:getDescription() or ""
	else
		goutil.setActive(self._btnHint.gameObject, false)
	end
end

function M:onExit()
	for i, shower in ipairs(self._showerList or {}) do
		shower:onExit()
	end

	self._txtLoopList:ClearCells()
	self._furnitureLoopList:ClearCells()
	self._btnHint:RemoveClickListener()
end

function M:onDestroy()
	self._data = nil
	self._index = nil
	self._txtTheme = nil
	self._btnHint = nil
	self._goHint = nil
	self._txtScrollGo = nil
	self._rightFurnitureScrollGo = nil
end

return M
