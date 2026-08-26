-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookAmplifierComp.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookAmplifierComp", package.seeall)

local SurvivalHandbookAmplifierComp = class("SurvivalHandbookAmplifierComp", SurvivalHandbookViewComp)

function SurvivalHandbookAmplifierComp:ctor(parentView)
	self._parentView = parentView
	self.handbookType = SurvivalEnum.HandBookType.Amplifier
	self.handBookDatas = {}
end

function SurvivalHandbookAmplifierComp:init(go)
	SurvivalHandbookAmplifierComp.super.init(self, go)

	self.scroll = gohelper.findChild(go, "#scroll")
	self.tabContent = gohelper.findChild(go, "tabScroll/Viewport/#tabContent")
	self._goAmplifierTab = gohelper.findChild(go, "tabScroll/Viewport/#go_AmplifierTab")

	gohelper.setActive(self._goAmplifierTab, false)

	self.tabs = {}

	local HandBookAmplifierSubTypeUIPos = SurvivalEnum.HandBookAmplifierSubTypeUIPos

	for i, subType in ipairs(HandBookAmplifierSubTypeUIPos) do
		local obj = gohelper.clone(self._goAmplifierTab, self.tabContent)

		gohelper.setActive(obj, true)

		local survivalHandbookAmplifierTab = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalHandbookAmplifierTab)

		survivalHandbookAmplifierTab:setData({
			index = i,
			handbookType = self.handbookType,
			subType = subType,
			onClickTabCallBack = self.onClickTab,
			onClickTabContext = self,
			isLast = i == #HandBookAmplifierSubTypeUIPos
		})
		table.insert(self.tabs, survivalHandbookAmplifierTab)
	end

	local resPath = self._parentView.viewContainer:getSetting().otherRes.survivalmapbagitem

	self._item = self._parentView:getResInst(resPath, self.go)

	gohelper.setActive(self._item, false)

	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self.scroll, SurvivalSimpleListPart, {
		minUpdate = 6
	})

	self._simpleList:setCellUpdateCallBack(self._createItem, self, SurvivalBagItem, self._item)
end

function SurvivalHandbookAmplifierComp:onOpen()
	self:selectTab(1, true)
end

function SurvivalHandbookAmplifierComp:onClose()
	self:selectTab(nil)
end

function SurvivalHandbookAmplifierComp:addEventListeners()
	return
end

function SurvivalHandbookAmplifierComp:removeEventListeners()
	return
end

function SurvivalHandbookAmplifierComp:onDestroy()
	return
end

function SurvivalHandbookAmplifierComp:onClickTab(survivalHandbookAmplifierTab)
	self:selectTab(survivalHandbookAmplifierTab.index)
end

function SurvivalHandbookAmplifierComp:_createItem(obj, data, index)
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

function SurvivalHandbookAmplifierComp:onClickItem(item)
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

function SurvivalHandbookAmplifierComp:refreshList(isAnim)
	if self.curSelect == nil then
		self._simpleList:setList({})

		return
	end

	tabletool.clear(self.handBookDatas)

	local datas = SurvivalHandbookModel.instance:getHandBookDatas(self.handbookType, self.tabs[self.curSelect].subType)

	table.sort(datas, SurvivalHandbookModel.instance.handBookSortFunc)

	for i, mo in ipairs(datas) do
		if mo.isUnlock then
			table.insert(self.handBookDatas, mo)
		end
	end

	if isAnim then
		self._simpleList:setOpenAnimation(0.03, 6)
	end

	self._simpleList:setList(datas)
end

function SurvivalHandbookAmplifierComp:getIndex(survivalHandbookMo)
	return tabletool.indexOf(self.handBookDatas, survivalHandbookMo)
end

function SurvivalHandbookAmplifierComp:selectTab(tarSelect, isAnim)
	local haveChange = (not tarSelect or not self.curSelect or self.curSelect ~= tarSelect) and (not not tarSelect or not not self.curSelect)

	if haveChange then
		if self.curSelect then
			self.tabs[self.curSelect]:setSelect(false)
		end

		self.curSelect = tarSelect

		if self.curSelect then
			SurvivalHandbookController.instance:markNewHandbook(self.handbookType, self.tabs[self.curSelect].subType)
			self.tabs[self.curSelect]:setSelect(true)
		end

		self:refreshList(isAnim)
	end
end

return SurvivalHandbookAmplifierComp
