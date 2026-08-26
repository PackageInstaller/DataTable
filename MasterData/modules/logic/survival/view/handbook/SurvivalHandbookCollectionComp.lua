-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookCollectionComp.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookCollectionComp", package.seeall)

local SurvivalHandbookCollectionComp = class("SurvivalHandbookCollectionComp", SurvivalHandbookViewComp)

function SurvivalHandbookCollectionComp:ctor(parentView)
	self._parentView = parentView
	self.handbookType = SurvivalEnum.HandBookType.Collection
	self.handBookDatas = {}
end

function SurvivalHandbookCollectionComp:init(go)
	SurvivalHandbookCollectionComp.super.init(self, go)

	self.scroll = gohelper.findChild(go, "#scroll")

	local resPath = self._parentView.viewContainer:getSetting().otherRes.survivalmapbagitem

	self._item = self._parentView:getResInst(resPath, self.go)

	gohelper.setActive(self._item, false)

	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self.scroll, SurvivalSimpleListPart, {
		minUpdate = 6
	})

	self._simpleList:setCellUpdateCallBack(self._createItem, self, SurvivalBagItem, self._item)
end

function SurvivalHandbookCollectionComp:onOpen()
	SurvivalHandbookController.instance:markNewHandbook(self.handbookType, 0)
	self:refreshList()
end

function SurvivalHandbookCollectionComp:_createItem(obj, data, index)
	local itemMo = data:getSurvivalBagItemMo()

	obj:updateMo(itemMo, {
		jumpAnimHas = true
	})
	obj:setShowNum(false)
	obj:setClickCallback(self.onClickItem, self)
	obj:setExtraParam({
		index = index,
		survivalHandbookMo = data
	})

	if data.isUnlock then
		local name = itemMo.co.name
		local offset = SLFramework.UGUI.GuiHelper.GetPreferredWidth(obj._textName, "...") + 0.1
		local str = GameUtil.getBriefNameByWidth(name, obj._textName, offset, "...")

		str = string.format("<color=#422415>%s</color>", str)

		obj:setTextName(data.isUnlock, str)
	end
end

function SurvivalHandbookCollectionComp:onClickItem(item)
	local survivalHandbookMo = item.extraParam.survivalHandbookMo

	if survivalHandbookMo.isUnlock then
		local index = self:getIndex(survivalHandbookMo)

		ViewMgr.instance:openView(ViewName.SurvivalHandbookInfoView, {
			handBookType = self.handbookType,
			handBookDatas = self.handBookDatas,
			select = index
		})
	end
end

function SurvivalHandbookCollectionComp:refreshList()
	local datas = SurvivalHandbookModel.instance:getHandBookDatas(self.handbookType, 0)

	table.sort(datas, SurvivalHandbookModel.instance.handBookSortFunc)
	tabletool.clear(self.handBookDatas)

	for i, mo in ipairs(datas) do
		if mo.isUnlock then
			table.insert(self.handBookDatas, mo)
		end
	end

	self._simpleList:setOpenAnimation(0.03, 6)
	self._simpleList:setList(datas)
end

function SurvivalHandbookCollectionComp:getIndex(survivalHandbookMo)
	return tabletool.indexOf(self.handBookDatas, survivalHandbookMo)
end

return SurvivalHandbookCollectionComp
