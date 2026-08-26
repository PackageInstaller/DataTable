-- chunkname: @modules/logic/survival/view/rewardinherit/survivalrewardselect/SurvivalRewardSelectView.lua

module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectView", package.seeall)

local SurvivalRewardSelectView = class("SurvivalRewardSelectView", BaseView)

function SurvivalRewardSelectView:onInitView()
	self._btncloseInfo = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closeInfo")
	self._btnabandon = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/btn/#btn_abandon")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/btn/#btn_confirm")
	self._gogrey = gohelper.findChild(self.viewGO, "root/Left/btn/#btn_confirm/#go_grey")
	self._txtcurrent = gohelper.findChildText(self.viewGO, "root/Left/score/#txt_current")
	self._txttotal = gohelper.findChildText(self.viewGO, "root/Left/score/#txt_total")
	self._scrollList = gohelper.findChild(self.viewGO, "root/Left/#scroll_List")
	self._goleftempty = gohelper.findChild(self.viewGO, "root/Left/#go_empty")
	self._gorightempty = gohelper.findChild(self.viewGO, "root/Right/#go_empty")
	self._gotab1 = gohelper.findChild(self.viewGO, "root/Right/top/#go_tab1")
	self._goselect = gohelper.findChild(self.viewGO, "root/Right/top/#go_tab1/#go_select")
	self._gonum = gohelper.findChild(self.viewGO, "root/Right/top/#go_tab1/#go_num")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/Right/top/#go_tab1/#go_num/#txt_num")
	self._btntab = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/top/#go_tab1/#btn_tab")
	self._gotab2 = gohelper.findChild(self.viewGO, "root/Right/top/#go_tab2")
	self._tabContent = gohelper.findChild(self.viewGO, "root/Right/tabScroll/Viewport/#tabContent")
	self._goSurvivalRewardInheritTab = gohelper.findChild(self.viewGO, "root/Right/tabScroll/Viewport/#tabContent/#go_SurvivalRewardInheritTab")
	self._goSelected = gohelper.findChild(self.viewGO, "root/Right/tabScroll/Viewport/#tabContent/#go_SurvivalRewardInheritTab/#go_Selected")
	self._scroll_amplifier = gohelper.findChild(self.viewGO, "root/Right/#scroll_amplifier")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "root/Right/#scroll_amplifier/Viewport/Content/#go_collectionitem")
	self._scroll_npc = gohelper.findChild(self.viewGO, "root/Right/#scroll_npc")
	self._gonpcitem = gohelper.findChild(self.viewGO, "root/Right/#scroll_npc/Viewport/Content/#go_npcitem")
	self._btnquick = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/#btn_quick")
	self.go_infoview = gohelper.findChild(self.viewGO, "root/#go_infoview")
	self._goSelectGrey = gohelper.findChild(self.viewGO, "root/Right/#btn_quick/#go_grey")

	gohelper.setActive(self._goSurvivalRewardInheritTab, false)

	self.handbookTabs = {}
	self.tabs = {}

	local resPath = self.viewContainer:getSetting().otherRes.survivalmapbagitem

	self._itemAmplifier = self:getResInst(resPath, self.viewGO)
	resPath = self.viewContainer:getSetting().otherRes.survivalrewardinheritnpcitem
	self._itemNpc = self:getResInst(resPath, self.viewGO)

	gohelper.setActive(self._itemAmplifier, false)
	gohelper.setActive(self._itemNpc, false)

	self._selectSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._scrollList, SurvivalSimpleListPart)

	self._selectSimpleList:setCellUpdateCallBack(self._createItemSelect, self, SurvivalBagItem, self._itemAmplifier)

	self._amplifierSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._scroll_amplifier, SurvivalSimpleListPart)

	self._amplifierSimpleList:setCellUpdateCallBack(self._createItemAmplifier, self, SurvivalBagItem, self._itemAmplifier)

	self._npcSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._scroll_npc, SurvivalSimpleListPart)

	self._npcSimpleList:setCellUpdateCallBack(self._createItemNpc, self, SurvivalRewardInheritNpcItem, self._itemNpc)

	self.selectMo = SurvivalRewardInheritModel.instance.selectMo

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(infoViewRes, self.go_infoview)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalShowBagInfoPart)

	self._infoPanel:updateMo(nil)
	self._infoPanel:setCloseShow(true, self.onCloseInfo, self)

	self.handbookTypes = {
		SurvivalEnum.HandBookType.Amplifier,
		SurvivalEnum.HandBookType.Npc
	}

	local HandBookNpcSubType = SurvivalEnum.HandBookNpcSubType

	self.npcSubType = {
		HandBookNpcSubType.Foundation,
		HandBookNpcSubType.Laplace,
		HandBookNpcSubType.Zeno,
		HandBookNpcSubType.People
	}
end

function SurvivalRewardSelectView:addEvents()
	self.addClickCb(self, self._btnabandon, self.onClickBtnAbandon, self)
	self.addClickCb(self, self._btnconfirm, self.onClickBtnConfirm, self)
	self.addClickCb(self, self._btnquick, self.onClickBtnquick, self)
end

function SurvivalRewardSelectView:onOpen()
	self.selectMo:Record()
	self:refreshScore()
	self:refreshSelectList()
	self:refreshHandbookTab()

	self.mode = 1

	gohelper.setActive(self._goSelectGrey, self.mode == 1)
end

function SurvivalRewardSelectView:refreshScore()
	self.curExtendScore = SurvivalRewardInheritModel.instance:getCurExtendScore()
	self._txtcurrent.text = self.curExtendScore
	self.extendScore = SurvivalRewardInheritModel.instance:getExtendScore()
	self._txttotal.text = self.extendScore
end

function SurvivalRewardSelectView:onClose()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRewardInheritRefresh)
end

function SurvivalRewardSelectView:onDestroyView()
	return
end

function SurvivalRewardSelectView:onClickModalMask()
	self:closeThis()
end

function SurvivalRewardSelectView:onClickBtnAbandon()
	self.selectMo:Revert()
	self:closeThis()
end

function SurvivalRewardSelectView:onClickBtnConfirm()
	self:closeThis()
end

function SurvivalRewardSelectView:onClickBtnquick()
	self.mode = -self.mode

	gohelper.setActive(self._goSelectGrey, self.mode == 1)
end

function SurvivalRewardSelectView:refreshHandbookTab()
	for i = 1, 2 do
		local name = "_gotab" .. i
		local obj = self[name]

		self.handbookTabs[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalRewardSelectTab)

		self.handbookTabs[i]:setData({
			index = i,
			handbookType = self.handbookTypes[i],
			onClickTabCallBack = self.onClickHandbookTabCallBack,
			onClickTabContext = self
		})
	end

	self.curSelectHandbookTab = nil

	if self.curSelectHandbookTab == nil then
		self:selectHandbookTab(1, nil)
	end
end

function SurvivalRewardSelectView:onClickHandbookTabCallBack(survivalInheritHandbookTab)
	self:selectHandbookTab(survivalInheritHandbookTab.index)
end

function SurvivalRewardSelectView:selectHandbookTab(tarSelect, selectSubIndex)
	local haveChange = (not tarSelect or not self.curSelectHandbookTab or self.curSelectHandbookTab ~= tarSelect) and (not not tarSelect or not not self.curSelectHandbookTab)

	if haveChange then
		if tarSelect then
			local handbookType = self.handbookTypes[tarSelect]
			local have, index = self:haveHandbookData(handbookType)

			if selectSubIndex == nil then
				selectSubIndex = index
			end
		end

		if self.curSelectHandbookTab then
			self.handbookTabs[self.curSelectHandbookTab]:setSelect(false)
		end

		self.curSelectHandbookTab = tarSelect

		if self.curSelectHandbookTab then
			self.handbookTabs[self.curSelectHandbookTab]:setSelect(true)
		end

		self.handbookType = self:getCurHandbookType()

		self:refreshTab(selectSubIndex)
	end
end

function SurvivalRewardSelectView:getCurHandbookType()
	if self.curSelectHandbookTab == 1 then
		return SurvivalEnum.HandBookType.Amplifier
	elseif self.curSelectHandbookTab == 2 then
		return SurvivalEnum.HandBookType.Npc
	end
end

function SurvivalRewardSelectView:haveHandbookData(handbookType)
	local subTypes = self:getSubTypes(handbookType)

	for index, subType in ipairs(subTypes) do
		if self:haveHandbookSubTypeData(handbookType, subType) then
			return true, index
		end
	end
end

function SurvivalRewardSelectView:haveHandbookSubTypeData(handbookType, subType)
	local datas = SurvivalRewardInheritModel.instance:getInheritHandBookDatas(handbookType, subType)

	if #datas > 0 then
		return true
	end
end

function SurvivalRewardSelectView:getSubTypes(handbookType)
	if handbookType == SurvivalEnum.HandBookType.Amplifier then
		return SurvivalEnum.HandBookAmplifierSubTypeUIPos
	elseif handbookType == SurvivalEnum.HandBookType.Npc then
		return self.npcSubType
	end
end

function SurvivalRewardSelectView:refreshTab(selectSubIndex)
	local tabAmount = #self.tabs
	local itemList = self:getSubTypes(self.handbookType)
	local itemAmount = #itemList

	for i = 1, itemAmount do
		local subType = itemList[i]

		if tabAmount < i then
			local obj = gohelper.clone(self._goSurvivalRewardInheritTab, self._tabContent)

			gohelper.setActive(obj, true)

			self.tabs[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalRewardInheritTab)
		end

		gohelper.setActive(self.tabs[i].go, true)

		local datas = SurvivalRewardInheritModel.instance:getInheritHandBookDatas(self.handbookType, subType)
		local isTransflective = #datas == 0

		self.tabs[i]:setData({
			handbookType = self.handbookType,
			subType = subType,
			index = i,
			onClickTabCallBack = self.onClickTabCallBack,
			onClickTabContext = self,
			isLast = i == itemAmount,
			isTransflective = isTransflective
		})
	end

	for i = itemAmount + 1, tabAmount do
		gohelper.setActive(self.tabs[i].go, false)
		self.tabs[i]:setData(nil)
	end

	self:selectTab(nil)
	self:selectTab(selectSubIndex)
end

function SurvivalRewardSelectView:onClickTabCallBack(survivalRewardInheritTab)
	self:selectTab(survivalRewardInheritTab.index, true)
end

function SurvivalRewardSelectView:selectTab(tarSelect, checkHaveData)
	local haveChange = (not tarSelect or not self.curSelect or self.curSelect ~= tarSelect) and (not not tarSelect or not not self.curSelect)

	if haveChange then
		if tarSelect and checkHaveData and not self:haveHandbookSubTypeData(self.handbookType, self.tabs[tarSelect].subType) then
			GameFacade.showToastString(luaLang("SurvivalRewardSelectView_2"))

			return
		end

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

function SurvivalRewardSelectView:refreshSelectAmount()
	for i, v in ipairs(self.handbookTabs) do
		v:refreshAmount()
	end

	for i, v in ipairs(self.tabs) do
		v:refreshAmount()
	end
end

function SurvivalRewardSelectView:refreshSelectList()
	local datas = SurvivalRewardInheritModel.instance:getSelectMo()

	self._selectSimpleList:setList(datas)
	gohelper.setActive(self._goleftempty, #datas == 0)
end

function SurvivalRewardSelectView:_createItemSelect(obj, data, index)
	local itemMo = data:getSurvivalBagItemMo()

	obj:updateMo(itemMo)
	obj:setClickCallback(self.onClickItemSelect, self)
	obj:setExtraParam({
		index = index,
		survivalHandbookMo = data
	})
	obj:setTextName(false)
	obj:setShowNum(false)
	obj:showInheritScore()
end

function SurvivalRewardSelectView:onClickItemSelect(item)
	local survivalHandbookMo = item.extraParam.survivalHandbookMo

	if self.mode == 1 then
		self:showInfo(survivalHandbookMo)
		self:refreshList()
	elseif self.mode == -1 then
		self.selectMo:removeByValue(self:getInheritId(survivalHandbookMo))
		self:refreshSelect()
	end
end

function SurvivalRewardSelectView:refreshList()
	if self.curSelect == nil then
		gohelper.setActive(self._scroll_amplifier, false)
		gohelper.setActive(self._scroll_npc, false)

		return
	end

	local datas = SurvivalRewardInheritModel.instance:getInheritHandBookDatas(self.handbookType, self.tabs[self.curSelect].subType)

	table.sort(datas, SurvivalHandbookModel.instance.handBookSortFunc)

	self.data = datas

	gohelper.setActive(self.go_empty, #datas == 0)

	if self.handbookType == SurvivalEnum.HandBookType.Amplifier then
		gohelper.setActive(self._scroll_amplifier, true)
		gohelper.setActive(self._scroll_npc, false)
		self._amplifierSimpleList:setList(datas)
	elseif self.handbookType == SurvivalEnum.HandBookType.Npc then
		gohelper.setActive(self._scroll_amplifier, false)
		gohelper.setActive(self._scroll_npc, true)

		local list = {}
		local temp = {}
		local lineAmount = 4

		for i, survivalHandbookMo in ipairs(datas) do
			local isSelect = self.selectMo:isSelect(self:getInheritId(survivalHandbookMo))
			local t = {
				isSelect = isSelect,
				survivalHandbookMo = survivalHandbookMo
			}

			table.insert(temp, t)

			if i % lineAmount == 0 or i == #datas then
				local isShowLine = i ~= #datas
				local lineData = {
					lineYOffset = -20,
					isShowCost = true,
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

	gohelper.setActive(self._gorightempty, #datas == 0)
end

function SurvivalRewardSelectView:_createItemAmplifier(obj, data, index)
	local itemMo = data:getSurvivalBagItemMo()

	obj:updateMo(itemMo)
	obj:setClickCallback(self.onClickItemAmplifier, self)
	obj:setExtraParam({
		index = index,
		survivalHandbookMo = data
	})
	obj:setTextName(false)
	obj:setShowNum(false)
	obj:setIsSelect(self.selectHandbookMo and self:getInheritId(self.selectHandbookMo) == self:getInheritId(data))

	local isSelect = self.selectMo:isSelect(self:getInheritId(data))
	local name = ""

	obj:showRewardInherit(name, isSelect)
	obj:showInheritScore()
end

function SurvivalRewardSelectView:onClickItemAmplifier(item)
	local survivalHandbookMo = item.extraParam.survivalHandbookMo

	if not survivalHandbookMo.isUnlock then
		return
	end

	if self.mode == 1 then
		self:showInfo(survivalHandbookMo)
		self:refreshList()
	elseif self.mode == -1 then
		local inheritId = self:getInheritId(survivalHandbookMo)

		if self.selectMo:isSelect(inheritId) then
			self.selectMo:removeByValue(inheritId)
		else
			local itemMo = survivalHandbookMo:getSurvivalBagItemMo()
			local cost = itemMo:getExtendCost()

			if self.curExtendScore + cost > self.extendScore then
				GameFacade.showToastString(luaLang("SurvivalRewardSelectView_1"))

				return
			end

			self.selectMo:addToEmptyPos(inheritId)
		end

		self:refreshSelect()
	end
end

function SurvivalRewardSelectView:_createItemNpc(obj, data, index)
	obj:updateMo(data, self.selectHandbookMo, self.onClickItemNpc, self)
end

function SurvivalRewardSelectView:onClickItemNpc(item)
	local survivalHandbookMo = item.mo

	if not survivalHandbookMo.isUnlock then
		return
	end

	if self.mode == 1 then
		self:showInfo(survivalHandbookMo)
		self:refreshList()
	elseif self.mode == -1 then
		local inheritId = self:getInheritId(survivalHandbookMo)

		if self.selectMo:isSelect(inheritId) then
			self.selectMo:removeByValue(inheritId)
		else
			local itemMo = survivalHandbookMo:getSurvivalBagItemMo()
			local cost = itemMo:getExtendCost()

			if self.curExtendScore + cost > self.extendScore then
				GameFacade.showToastString(luaLang("SurvivalRewardSelectView_1"))

				return
			end

			self.selectMo:addToEmptyPos(inheritId)
		end

		self:refreshSelect()
	end
end

function SurvivalRewardSelectView:showInfo(survivalHandbookMo)
	self.selectHandbookMo = survivalHandbookMo

	self._infoPanel:updateMo(survivalHandbookMo:getSurvivalBagItemMo())

	self.selectSurvivalHandbookMo = survivalHandbookMo

	local isSelect = self.selectMo:isSelect(self:getInheritId(survivalHandbookMo))

	self._infoPanel:showRewardInheritBtn(self, not isSelect, self.onClickSelectCallBack, self.onClickUnSelectCallBack)
end

function SurvivalRewardSelectView:onCloseInfo()
	self.selectHandbookMo = nil

	self:refreshList()
end

function SurvivalRewardSelectView:onClickSelectCallBack()
	local inheritId = self:getInheritId(self.selectSurvivalHandbookMo)
	local itemMo = self.selectSurvivalHandbookMo:getSurvivalBagItemMo()
	local cost = itemMo:getExtendCost()

	if self.curExtendScore + cost > self.extendScore then
		GameFacade.showToastString(luaLang("SurvivalRewardSelectView_1"))

		return
	end

	self.selectMo:addToEmptyPos(inheritId)
	self._infoPanel:updateMo(nil)

	self.selectHandbookMo = nil

	self:refreshSelect()
end

function SurvivalRewardSelectView:onClickUnSelectCallBack()
	self.selectMo:removeByValue(self:getInheritId(self.selectSurvivalHandbookMo))
	self._infoPanel:updateMo(nil)

	self.selectHandbookMo = nil

	self:refreshSelect()
	self:refreshList()
end

function SurvivalRewardSelectView:refreshSelect()
	self:refreshScore()
	self:refreshSelectAmount()
	self:refreshList()
	self:refreshSelectList()
end

function SurvivalRewardSelectView:getInheritId(survivalHandbookMo)
	return SurvivalRewardInheritModel.instance:getInheritId(survivalHandbookMo)
end

return SurvivalRewardSelectView
