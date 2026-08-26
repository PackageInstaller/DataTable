-- chunkname: @modules/logic/survival/view/rewardinherit/SurvivalRewardInheritView.lua

module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritView", package.seeall)

local SurvivalRewardInheritView = class("SurvivalRewardInheritView", BaseView)

function SurvivalRewardInheritView:onInitView()
	self._goSurvivalRewardInheritTab = gohelper.findChild(self.viewGO, "root/Right/tabScroll/Viewport/#tabContent/#go_SurvivalRewardInheritTab")
	self._tabContent = gohelper.findChild(self.viewGO, "root/Right/tabScroll/Viewport/#tabContent")
	self._scroll_amplifier = gohelper.findChild(self.viewGO, "root/Right/#scroll_amplifier")
	self._scroll_npc = gohelper.findChild(self.viewGO, "root/Right/#scroll_npc")
	self._go_infoview = gohelper.findChild(self.viewGO, "root/Left/#go_infoview")
	self._go_collection_select = gohelper.findChild(self.viewGO, "root/Left/#go_collection_select")
	self._go_collection_txt_tips = gohelper.findChildTextMesh(self.viewGO, "root/Left/#go_collection_select/txt_tips")
	self._collection_go_empty = gohelper.findChild(self._go_collection_select, "collection/#go_empty")
	self._collection_go_has = gohelper.findChild(self._go_collection_select, "collection/#go_has")
	self._btn_remove = gohelper.findChildButtonWithAudio(self._go_collection_select, "collection/#go_has/#btn_remove")
	self._go_put = gohelper.findChild(self._go_collection_select, "collection/#go_has/#go_put")
	self._go_item_container = gohelper.findChild(self._go_collection_select, "collection/#go_has/#go_item_container")
	self._go_txt_name = gohelper.findChildTextMesh(self._go_collection_select, "collection/#go_has/#txt_name")
	self._go_npc_select = gohelper.findChild(self.viewGO, "root/Left/#go_npc_select")
	self._go_npc_txt_tips = gohelper.findChildTextMesh(self.viewGO, "root/Left/#go_npc_select/layout/#txt_tips")
	self.btn_abandon = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/btn/#btn_abandon")
	self.btn_confirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/btn/#btn_confirm")
	self.btn_closeInfo = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closeInfo")
	self.go_empty = gohelper.findChild(self.viewGO, "root/Right/#go_empty")
	self.survivalRewardInheritNpcSelectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._go_npc_select, SurvivalRewardInheritNpcSelectComp, {
		parentView = self,
		refreshFunc = self.refresh
	})

	if self._editableInitView then
		self:_editableInitView()
	end

	local resPath = self.viewContainer:getSetting().otherRes.survivalmapbagitem
	local item = self:getResInst(resPath, self._go_item_container)

	self.selectAmplifierItem = MonoHelper.addNoUpdateLuaComOnceToGo(item, SurvivalBagItem)
	self._itemAmplifier = self:getResInst(resPath, self.viewGO)

	local scale = 1.05

	transformhelper.setLocalScale(self._itemAmplifier.transform, scale, scale, 1)

	resPath = self.viewContainer:getSetting().otherRes.survivalrewardinheritnpcitem
	self._itemNpc = self:getResInst(resPath, self.viewGO)

	gohelper.setActive(self._itemAmplifier, false)
	gohelper.setActive(self._itemNpc, false)

	self._amplifierSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._scroll_amplifier, SurvivalSimpleListPart)

	self._amplifierSimpleList:setCellUpdateCallBack(self._createItemAmplifier, self, SurvivalBagItem, self._itemAmplifier)

	self._npcSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._scroll_npc, SurvivalSimpleListPart)

	self._npcSimpleList:setCellUpdateCallBack(self._createItemNpc, self, SurvivalRewardInheritNpcItem, self._itemNpc)

	local res = self.viewContainer:getSetting().otherRes.infoView
	local infoGo = self:getResInst(res, self._go_infoview)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:updateMo(nil)
	gohelper.setActive(self._goSurvivalRewardInheritTab, false)

	self.tabs = {}
	self.selectSurvivalHandbookMo = nil
end

function SurvivalRewardInheritView:addEvents()
	self.addClickCb(self, self.btn_abandon, self.onClickBtn_abandon, self)
	self.addClickCb(self, self.btn_confirm, self.onClickBtn_confirm, self)
	self.addClickCb(self, self._btn_remove, self.onClickBtn_remove, self)
	self.addClickCb(self, self.btn_closeInfo, self.onClickBtnCloseInfo, self)
end

function SurvivalRewardInheritView:onOpen()
	self.handbookType = self.viewParam.handbookType
	self.closeCallBack = self.viewParam.closeCallBack
	self.closeCallBackContext = self.viewParam.closeCallBackContext

	if self.handbookType == SurvivalEnum.HandBookType.Amplifier then
		gohelper.setActive(self._scroll_amplifier, true)
		gohelper.setActive(self._scroll_npc, false)

		self.survivalRewardInheritSelectMo = SurvivalRewardInheritModel.instance.amplifierSelectMo

		gohelper.setActive(self._go_collection_select, true)
		gohelper.setActive(self._go_npc_select, false)

		self._go_collection_txt_tips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalRewardInheritView_1"), {
			self.survivalRewardInheritSelectMo.maxAmount
		})
	elseif self.handbookType == SurvivalEnum.HandBookType.Npc then
		gohelper.setActive(self._scroll_amplifier, false)
		gohelper.setActive(self._scroll_npc, true)

		self.survivalRewardInheritSelectMo = SurvivalRewardInheritModel.instance.npcSelectMo

		gohelper.setActive(self._go_collection_select, false)
		gohelper.setActive(self._go_npc_select, true)

		self._go_npc_txt_tips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalRewardInheritView_2"), {
			self.survivalRewardInheritSelectMo.maxAmount
		})
	end

	self.oriSelectIdDic = self.survivalRewardInheritSelectMo:copySelectIdDic()
	self.readyPos = 1

	self:refreshTab()
	self:selectTab(1)
	self:refreshInheritSelect(true)
end

function SurvivalRewardInheritView:onClose()
	if self.closeCallBack then
		self.closeCallBack(self.closeCallBackContext)
	end
end

function SurvivalRewardInheritView:onDestroyView()
	return
end

function SurvivalRewardInheritView:onClickBtn_abandon()
	self.survivalRewardInheritSelectMo:replaceSelectIdDic(self.oriSelectIdDic)
	self:closeThis()
end

function SurvivalRewardInheritView:onClickBtn_confirm()
	self:closeThis()
end

function SurvivalRewardInheritView:onClickBtn_remove()
	self.survivalRewardInheritSelectMo:removeOneByPos(1)
	self:refresh()
end

function SurvivalRewardInheritView:onClickBtnCloseInfo()
	if self._infoPanel then
		self._infoPanel:updateMo(nil)
	end
end

function SurvivalRewardInheritView:refreshTab()
	local tabAmount = #self.tabs
	local itemList

	if self.handbookType == SurvivalEnum.HandBookType.Amplifier then
		itemList = SurvivalEnum.HandBookAmplifierSubTypeUIPos
	elseif self.handbookType == SurvivalEnum.HandBookType.Npc then
		local HandBookNpcSubType = SurvivalEnum.HandBookNpcSubType

		itemList = {
			HandBookNpcSubType.Foundation,
			HandBookNpcSubType.Laplace,
			HandBookNpcSubType.Zeno,
			HandBookNpcSubType.People
		}
	end

	local itemAmount = #itemList

	for i = 1, itemAmount do
		local subType = itemList[i]

		if tabAmount < i then
			local obj = gohelper.clone(self._goSurvivalRewardInheritTab, self._tabContent)

			self.tabs[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalRewardInheritTab)
		end

		gohelper.setActive(self.tabs[i].go, true)
		self.tabs[i]:setData({
			handbookType = self.handbookType,
			subType = subType,
			index = i,
			survivalRewardInheritSelectMo = self.survivalRewardInheritSelectMo,
			onClickTabCallBack = self.onClickTabCallBack,
			onClickTabContext = self,
			isLast = i == itemAmount
		})
	end

	for i = itemAmount + 1, tabAmount do
		gohelper.setActive(self.tabs[i].go, false)
		self.tabs[i]:setData(nil)
	end
end

function SurvivalRewardInheritView:onClickTabCallBack(survivalRewardInheritTab)
	self:selectTab(survivalRewardInheritTab.index)
end

function SurvivalRewardInheritView:selectTab(tarSelect)
	local haveChange = (not tarSelect or not self.curSelect or self.curSelect ~= tarSelect) and (not not tarSelect or not not self.curSelect)

	if haveChange then
		if self.curSelect then
			self.tabs[self.curSelect]:setSelect(false)
		end

		self.curSelect = tarSelect

		if self.curSelect then
			self.tabs[self.curSelect]:setSelect(true)
		end

		self:refreshList()
	end
end

function SurvivalRewardInheritView:_createItemAmplifier(obj, data, index)
	local itemMo = data:getSurvivalBagItemMo()

	obj:updateMo(itemMo)
	obj:setClickCallback(self.onClickItemAmplifier, self)
	obj:setExtraParam({
		index = index,
		survivalHandbookMo = data
	})
	obj:setTextName(false)
	obj:setIsSelect(self.selectHandbookMo and self.selectHandbookMo.id == data.id)

	local isSelect = self.survivalRewardInheritSelectMo:isSelect(data.id)
	local name = itemMo.co.name
	local offset = SLFramework.UGUI.GuiHelper.GetPreferredWidth(obj._textName, "...") + 0.1

	name = GameUtil.getBriefNameByWidth(name, obj._textName, offset, "...")

	obj:showRewardInherit(name, isSelect)
end

function SurvivalRewardInheritView:onClickItemAmplifier(item)
	local survivalHandbookMo = item.extraParam.survivalHandbookMo

	self.selectHandbookMo = survivalHandbookMo

	self._infoPanel:updateMo(survivalHandbookMo:getSurvivalBagItemMo())

	self.selectSurvivalHandbookMo = survivalHandbookMo

	local isSelect = self.survivalRewardInheritSelectMo:isSelect(survivalHandbookMo.id)

	self._infoPanel:showRewardInheritBtn(self, not isSelect, self.onClickSelectCallBack, self.onClickUnSelectCallBack)
	self:refreshList()
end

function SurvivalRewardInheritView:refresh()
	self:refreshInheritSelect()
	self:refreshList()
	self:refreshTab()
end

function SurvivalRewardInheritView:_createItemNpc(obj, data, index)
	obj:updateMo(data, self.selectHandbookMo, self.onClickItemNpc, self)
end

function SurvivalRewardInheritView:onClickItemNpc(item)
	local survivalHandbookMo = item.mo

	self.selectHandbookMo = survivalHandbookMo

	self._infoPanel:updateMo(survivalHandbookMo:getSurvivalBagItemMo())

	self.selectSurvivalHandbookMo = survivalHandbookMo

	local isSelect = self.survivalRewardInheritSelectMo:isSelect(survivalHandbookMo.id)

	self._infoPanel:showRewardInheritBtn(self, not isSelect, self.onClickSelectCallBack, self.onClickUnSelectCallBack)
	self:refreshList()
end

function SurvivalRewardInheritView:refreshList()
	local datas = SurvivalHandbookModel.instance:getHandBookUnlockDatas(self.handbookType, self.tabs[self.curSelect].subType)

	gohelper.setActive(self.go_empty, #datas == 0)

	if self.handbookType == SurvivalEnum.HandBookType.Amplifier then
		self._amplifierSimpleList:setList(datas)
	elseif self.handbookType == SurvivalEnum.HandBookType.Npc then
		local list = {}
		local temp = {}
		local lineAmount = 4

		for i, survivalHandbookMo in ipairs(datas) do
			local isSelect = self.survivalRewardInheritSelectMo:isSelect(survivalHandbookMo.id)
			local t = {
				isSelect = isSelect,
				survivalHandbookMo = survivalHandbookMo
			}

			table.insert(temp, t)

			if i % lineAmount == 0 or i == #datas then
				local isShowLine = i ~= #datas
				local lineData = {
					viewContainer = self.viewContainer,
					listData = tabletool.copy(temp),
					isShowLine = isShowLine
				}

				table.insert(list, lineData)
				tabletool.clear(temp)
			end
		end

		self._npcSimpleList:setList(list)
	end
end

function SurvivalRewardInheritView:onClickSelectCallBack()
	if self.handbookType == SurvivalEnum.HandBookType.Amplifier then
		self.survivalRewardInheritSelectMo:replaceOne(1, self.selectSurvivalHandbookMo.id)
	elseif self.handbookType == SurvivalEnum.HandBookType.Npc then
		self.survivalRewardInheritSelectMo:replaceOne(self.readyPos, self.selectSurvivalHandbookMo.id)
	end

	self._infoPanel:updateMo(nil)

	self.selectHandbookMo = nil

	self:refresh()
end

function SurvivalRewardInheritView:onClickUnSelectCallBack()
	self.survivalRewardInheritSelectMo:removeOne(self.selectSurvivalHandbookMo.id)

	self.selectHandbookMo = nil

	self._infoPanel:updateMo(nil)
	self:refresh()
end

function SurvivalRewardInheritView:refreshInheritSelect(isFirst)
	local isEmpty, pos = self.survivalRewardInheritSelectMo:haveEmpty()

	if self.survivalRewardInheritSelectMo:getSelect(self.readyPos) ~= nil and isEmpty then
		self.readyPos = pos
	end

	self.readyPos = self.readyPos or self.survivalRewardInheritSelectMo.maxAmount

	if self.handbookType == SurvivalEnum.HandBookType.Amplifier then
		if self.survivalRewardInheritSelectMo:haveSelect() then
			gohelper.setActive(self._collection_go_has, true)
			gohelper.setActive(self._collection_go_empty, false)

			local id = self.survivalRewardInheritSelectMo:getSelect(1)
			local mo = SurvivalHandbookModel.instance:getMoById(id)
			local itemMo = mo:getSurvivalBagItemMo()

			self.selectAmplifierItem:updateMo(itemMo)

			self._go_txt_name.text = itemMo.co.name

			if not isFirst then
				gohelper.setActive(self._go_put, false)
				gohelper.setActive(self._go_put, true)
			end
		else
			gohelper.setActive(self._collection_go_has, false)
			gohelper.setActive(self._collection_go_empty, true)
		end
	elseif self.handbookType == SurvivalEnum.HandBookType.Npc then
		self.survivalRewardInheritNpcSelectComp:refreshInheritSelect(isFirst, self.readyPos)
	end
end

return SurvivalRewardInheritView
