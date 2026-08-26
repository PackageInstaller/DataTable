-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyListView.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyListView", package.seeall)

local Rouge2_AlchemyListView = class("Rouge2_AlchemyListView", BaseView)

function Rouge2_AlchemyListView:onInitView()
	self._simagepanelbg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_panelbg1")
	self._simagepanelbg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_panelbg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_close")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_collection")
	self._gocontent = gohelper.findChild(self.viewGO, "Left/#scroll_collection/Viewport/#go_content")
	self._gosmalltitle = gohelper.findChild(self.viewGO, "Left/#go_smalltitle")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Left/#go_smalltitle/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Left/#go_smalltitle/#txt_Title/#txt_TitleEn")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/filter/#btn_filter")
	self._golayout = gohelper.findChild(self.viewGO, "Left/filter/#go_layout")
	self._gomain = gohelper.findChild(self.viewGO, "Right/#go_main")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_main/empty/#btn_add")
	self._imagerare = gohelper.findChildImage(self.viewGO, "Right/#go_main/has/detail/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Right/#go_main/has/detail/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "Right/#go_main/has/detail/#txt_name")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_main/has/detail/#scroll_desc")
	self._godescContent = gohelper.findChild(self.viewGO, "Right/#go_main/has/detail/#scroll_desc/Viewport/#go_descContent")
	self._txtneed = gohelper.findChildTextMesh(self.viewGO, "Right/#go_main/has/need/#txt_need")
	self._txtlack = gohelper.findChildTextMesh(self.viewGO, "Right/#go_main/has/need/#txt_lack")
	self._gosmallitem = gohelper.findChild(self.viewGO, "Right/#go_main/has/need/layout/#go_smallitem")
	self._gosub = gohelper.findChild(self.viewGO, "Right/#go_sub")
	self._scrollsubMaterialDesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_sub/#scroll_subMaterialDesc")
	self._txtsubMaterialName = gohelper.findChildText(self.viewGO, "Right/#go_sub/#scroll_subMaterialDesc/#txt_subMaterialName")
	self._gosubMaterialDescContent = gohelper.findChild(self.viewGO, "Right/#go_sub/#scroll_subMaterialDesc/Viewport/#go_subMaterialDescContent")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_add")
	self._btnunload = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_unload")
	self._btncloseView = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Btn/#btn_closeView")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemyListView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnunload:AddClickListener(self._btnunloadOnClick, self)
	self._btncloseView:AddClickListener(self._btncloseViewOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onClickAlchemyFormula, self.onClickFormula, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onClickAlchemySubMaterial, self.onClickSubMaterial, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemyFormula, self.onSelectFormula, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemySubMaterial, self.onSelectMaterial, self)
end

function Rouge2_AlchemyListView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnunload:RemoveClickListener()
	self._btncloseView:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onClickAlchemyFormula, self.onClickFormula, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onClickAlchemySubMaterial, self.onClickSubMaterial, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemyFormula, self.onSelectFormula, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemySubMaterial, self.onSelectMaterial, self)
end

function Rouge2_AlchemyListView:_btnfilterOnClick()
	return
end

function Rouge2_AlchemyListView:_btnaddOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_add)

	if self.itemType == Rouge2_OutsideEnum.AlchemyItemType.Formula then
		if self._curFormulaId then
			Rouge2_AlchemyModel.instance:setCurFormula(self._curFormulaId)
			self:closeThis()
		end
	elseif self.itemType == Rouge2_OutsideEnum.AlchemyItemType.SubMaterial then
		self:closeThis()
	end
end

function Rouge2_AlchemyListView:_btncloseOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_click)
	self:closeThis()
end

function Rouge2_AlchemyListView:_btnunloadOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_cancel)

	if self.itemType == Rouge2_OutsideEnum.AlchemyItemType.Formula then
		if self._curFormulaId then
			Rouge2_AlchemyModel.instance:setCurFormula(nil)
		end
	elseif self.itemType == Rouge2_OutsideEnum.AlchemyItemType.SubMaterial and self._curSubMaterialId then
		local index = Rouge2_AlchemyModel.instance:getCurSubMaterialIndex(self._curSubMaterialId)

		Rouge2_AlchemyModel.instance:setCurSubMaterialDic(index, nil)
	end
end

function Rouge2_AlchemyListView:_btncloseViewOnClick()
	self:closeThis()
end

function Rouge2_AlchemyListView:_editableInitView()
	self._goFormulaEmpty = gohelper.findChild(self.viewGO, "Right/#go_main/empty")
	self._goFormulaHave = gohelper.findChild(self.viewGO, "Right/#go_main/has")
	self._formulaDescItemList = {}

	self:initMainMaterialItem()

	self._subMaterialBgList = self:getUserDataTb_()

	table.insert(self._subMaterialBgList, gohelper.findChild(self.viewGO, "Right/#go_sub/sub/BG/image_2"))
	table.insert(self._subMaterialBgList, gohelper.findChild(self.viewGO, "Right/#go_sub/sub/BG/image_3"))
	table.insert(self._subMaterialBgList, gohelper.findChild(self.viewGO, "Right/#go_sub/sub/BG/image_4"))

	self._subMaterialItemList = {}
	self._gosubMaterialParent = gohelper.findChild(self.viewGO, "Right/#go_sub/sub/#go_subMaterialParent")
	self._subMaterialParentList = self:getUserDataTb_()

	local childCount = self._gosubMaterialParent.transform.childCount

	for i = 1, childCount do
		local itemGo = self._gosubMaterialParent.transform:GetChild(i - 1)

		table.insert(self._subMaterialParentList, itemGo)
	end

	gohelper.setActive(self._godescContent, true)

	self._txtDesc = gohelper.findChildTextMesh(self._godescContent, "txt_desc")

	self:initNeedMaterialItem()

	self._curSubMaterialIndex = nil
	self._subMaterialDescText = gohelper.findChildTextMesh(self._gosubMaterialDescContent, "txt_desc")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Right/#go_main/has/detail/#simage_icon")

	gohelper.setActive(self._gosmalltitle, false)
	gohelper.setActive(self._btnunload, false)

	self._switchAnimator = gohelper.findChildComponent(self.viewGO, "Right", gohelper.Type_Animator)

	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.AlchemySubMaterialCount)

	self.maxSubMaterialCount = tonumber(constConfig.value)
end

function Rouge2_AlchemyListView:initNeedMaterialItem()
	self.needMainMaterialPosList = self:getUserDataTb_()

	table.insert(self.needMainMaterialPosList, gohelper.findChild(self.viewGO, "Right/#go_main/has/need/layout/main/go_icon1"))
	table.insert(self.needMainMaterialPosList, gohelper.findChild(self.viewGO, "Right/#go_main/has/need/layout/main/go_icon2"))

	self.needSubMaterialPosList = self:getUserDataTb_()

	table.insert(self.needSubMaterialPosList, gohelper.findChild(self.viewGO, "Right/#go_main/has/need/layout/sub/go_icon1"))
	table.insert(self.needSubMaterialPosList, gohelper.findChild(self.viewGO, "Right/#go_main/has/need/layout/sub/go_icon2"))
	table.insert(self.needSubMaterialPosList, gohelper.findChild(self.viewGO, "Right/#go_main/has/need/layout/sub/go_icon3"))
	table.insert(self.needSubMaterialPosList, gohelper.findChild(self.viewGO, "Right/#go_main/has/need/layout/sub/go_icon4"))

	self._needMainMaterialItemList = {}

	for index, parent in ipairs(self.needMainMaterialPosList) do
		local itemGo = gohelper.clone(self._gosmallitem, parent, tostring(index))

		gohelper.setActive(itemGo, true)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Rouge2_AlchemyNeedMaterialItem)

		table.insert(self._needMainMaterialItemList, item)
	end

	self._needSubMaterialItemList = {}

	for index, parent in ipairs(self.needSubMaterialPosList) do
		local itemGo = gohelper.clone(self._gosmallitem, parent, tostring(index))

		gohelper.setActive(itemGo, true)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Rouge2_AlchemyNeedMaterialItem)

		table.insert(self._needSubMaterialItemList, item)
	end
end

function Rouge2_AlchemyListView:initMainMaterialItem()
	self._mainMaterialParent = gohelper.findChild(self.viewGO, "Right/#go_sub/main")
	self._mainMaterialItemList = {}

	for i = 1, Rouge2_OutsideEnum.MainMaterialCount do
		local itemGo = self._mainMaterialParent.transform:GetChild(i - 1).gameObject
		local item = self:getUserDataTb_()

		item.go = itemGo
		item.simageIcon = gohelper.findChildSingleImage(itemGo, "#image_icon")

		table.insert(self._mainMaterialItemList, item)
	end
end

function Rouge2_AlchemyListView:onUpdateParam()
	return
end

function Rouge2_AlchemyListView:onOpen()
	self:refreshUI()
end

function Rouge2_AlchemyListView:onClickFormula(id)
	self._curFormulaId = id

	if id ~= nil then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_choose_4)
		Rouge2_AlchemyItemListModel.instance:setSelect(id)
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnAlchemyFormulaItemClick)
	else
		Rouge2_AlchemyItemListModel.instance:clearSelect()
	end

	self._switchAnimator:Play("switch", 0, 0)

	local delay = Rouge2_OutsideEnum.AlchemySwitchRefreshTime

	Rouge2_OutsideController.instance:lockScreen(true, delay)
	TaskDispatcher.cancelTask(self.onSwitchInfoRefresh, self)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayFinish, self)
	TaskDispatcher.runDelay(self.onSwitchInfoRefresh, self, delay)
	TaskDispatcher.runDelay(self.onSwitchAnimPlayFinish, self, Rouge2_OutsideEnum.AlchemySwitchFinishTime)
end

function Rouge2_AlchemyListView:onSwitchInfoRefresh()
	Rouge2_OutsideController.instance:lockScreen(false)
	TaskDispatcher.cancelTask(self.onSwitchInfoRefresh, self)
	self:refreshFormulaInfo(self._curFormulaId)
end

function Rouge2_AlchemyListView:onSwitchAnimPlayFinish()
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayFinish, self)
	self._switchAnimator:Play("idle", 0, 0)
end

function Rouge2_AlchemyListView:onClickSubMaterial(id)
	if not Rouge2_AlchemyModel.instance:isSelectSubMaterial(id) then
		if self._curSubMaterialIndex == nil then
			return
		end

		local curIndex = self._curSubMaterialIndex

		Rouge2_AlchemyModel.instance:setCurSubMaterialDic(curIndex, id)

		self._curSubMaterialId = id

		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_choose_4)
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnAlchemyMaterialItemClick)
	else
		local index = Rouge2_AlchemyModel.instance:getCurSubMaterialIndex(id)

		Rouge2_AlchemyModel.instance:setCurSubMaterialDic(index, nil)

		self._curSubMaterialId = nil
	end

	local materialDic = Rouge2_AlchemyModel.instance:getCurSubMaterialPosDic()

	Rouge2_AlchemyItemListModel.instance:setSelectList(materialDic)
	self:refreshSubMaterial()
end

function Rouge2_AlchemyListView:onSelectFormula(id)
	self:refreshFormulaInfo()
end

function Rouge2_AlchemyListView:onSelectMaterial(id)
	self:refreshMaterialInfo()
end

function Rouge2_AlchemyListView:refreshUI()
	self:refreshState()
end

function Rouge2_AlchemyListView:refreshState()
	local itemType = self.viewParam.itemType

	self.itemType = itemType

	gohelper.setActive(self._gomain, itemType == Rouge2_OutsideEnum.AlchemyItemType.Formula)
	gohelper.setActive(self._gosub, itemType == Rouge2_OutsideEnum.AlchemyItemType.SubMaterial)
	Rouge2_AlchemyItemListModel.instance:copyListFromConfig(itemType)

	if itemType == Rouge2_OutsideEnum.AlchemyItemType.Formula then
		self:refreshFormulaInfo()
	else
		self:refreshMaterialInfo()
	end
end

function Rouge2_AlchemyListView:refreshMaterialInfo()
	self:refreshMainMaterial()
	self:refreshSubMaterial()
end

function Rouge2_AlchemyListView:refreshMainMaterial()
	local mainMaterialList = Rouge2_AlchemyModel.instance:getCurMainMaterialList()
	local materialCount = 0

	if mainMaterialList == nil then
		logError("肉鸽炼金主料数量为0")
	else
		materialCount = #mainMaterialList

		if #mainMaterialList ~= Rouge2_OutsideEnum.MainMaterialCount then
			logError("肉鸽炼金主料于设定不一致" .. "当前值: " .. tostring(materialCount) .. " 设定值: " .. tostring(Rouge2_OutsideEnum.MainMaterialCount))
		end
	end

	for i = 1, materialCount do
		local id = mainMaterialList[i]
		local item = self._mainMaterialItemList[i]

		if item then
			Rouge2_IconHelper.setMaterialIcon(id, item.simageIcon)
			gohelper.setActive(item.go, true)
		end
	end

	if materialCount < Rouge2_OutsideEnum.MainMaterialCount then
		for i = materialCount + 1, Rouge2_OutsideEnum.MainMaterialCount do
			local item = self._mainMaterialItemList[i]

			gohelper.setActive(item.go, false)
		end
	end
end

function Rouge2_AlchemyListView:autoSelectSubMaterialIndex(maxCount, subMaterialListDic)
	for i = 1, maxCount do
		if not subMaterialListDic[i] then
			self._curSubMaterialIndex = i

			return
		end
	end

	self._curSubMaterialIndex = nil
end

function Rouge2_AlchemyListView:refreshSubMaterial()
	local maxCount = self.maxSubMaterialCount

	for index, item in ipairs(self._subMaterialBgList) do
		gohelper.setActive(item, index == maxCount - 1)
	end

	local subMaterialListDic = Rouge2_AlchemyModel.instance:getCurSubMaterialDic()
	local itemCount = #self._subMaterialItemList

	self:autoSelectSubMaterialIndex(maxCount, subMaterialListDic)

	local subMaterialListPosDic = Rouge2_AlchemyModel.instance:getCurSubMaterialPosDic()
	local subMaterialAddList = Rouge2_AlchemyModel.instance:getCurSubMaterialAddList()

	Rouge2_AlchemyItemListModel.instance:setSelectList(subMaterialListPosDic)

	if self._curSubMaterialId == nil and subMaterialAddList and next(subMaterialAddList) then
		self._curSubMaterialId = subMaterialAddList[#subMaterialAddList]
	end

	for i = 1, maxCount do
		local id = subMaterialListDic[i]
		local item = self:getSubMaterialItem(i)

		gohelper.setActive(item.go, true)
		item:setInfo(id, nil, Rouge2_OutsideEnum.SubMaterialDisplayType.Wearable)
		item:setSelect(i == self._curSubMaterialIndex)
	end

	if maxCount < itemCount then
		for i = maxCount + 1, itemCount do
			local item = self._subMaterialItemList[i]

			gohelper.setActive(item.go, false)
		end
	end

	self:refreshCurMaterial()
end

function Rouge2_AlchemyListView:refreshCurMaterial()
	local curSelectDic = Rouge2_AlchemyModel.instance:getCurSubMaterialDic()
	local haveSelectMaterial = curSelectDic and next(curSelectDic) ~= nil
	local selectMaterial = self._curSubMaterialId ~= nil

	gohelper.setActive(self._btnadd, haveSelectMaterial)
	gohelper.setActive(self._scrollsubMaterialDesc, haveSelectMaterial and selectMaterial)

	if haveSelectMaterial == false or selectMaterial == false then
		return
	end

	local materialConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(self._curSubMaterialId)

	self._txtsubMaterialName.text = materialConfig.name
	self._subMaterialDescText.text = materialConfig.details
end

function Rouge2_AlchemyListView:getSubMaterialItem(index)
	local item = self._subMaterialItemList[index]

	if not item then
		item = self:createMaterialItem(index)

		table.insert(self._subMaterialItemList, item)
	end

	return item
end

function Rouge2_AlchemyListView:createMaterialItem(index)
	local parent = self._subMaterialParentList[index]
	local itemGo = gohelper.clone(self._gosmallitem, parent.gameObject)

	return (MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Rouge2_AlchemyNeedMaterialItem))
end

function Rouge2_AlchemyListView:refreshFormulaInfo()
	local curFormula = Rouge2_AlchemyModel.instance:getCurFormula()
	local tempId = self._curFormulaId
	local formulaId = tempId ~= nil and tempId or curFormula
	local selectFormula = formulaId ~= nil

	gohelper.setActive(self._goFormulaEmpty, not selectFormula)
	gohelper.setActive(self._goFormulaHave, selectFormula)

	if curFormula ~= nil and tempId == nil then
		Rouge2_AlchemyItemListModel.instance:setSelect(curFormula)
	end

	if selectFormula then
		local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

		Rouge2_IconHelper.setFormulaRareBg(formulaConfig.rare, self._imagerare)
		Rouge2_IconHelper.setFormulaIcon(formulaId, self._simageicon)

		self._txtname.text = formulaConfig.name

		self:refreshFormulaDesc(formulaConfig)

		local isSelect = tempId ~= nil and curFormula ~= nil and tempId == curFormula
		local needMaterialParam = string.split(formulaConfig.mainIdNum, "|")

		gohelper.setActive(self._btnunload, isSelect)

		if isSelect then
			if not Rouge2_OutsideEnum.AlchemyTempAlpha.Select then
				local alpha = Rouge2_OutsideEnum.AlchemyTempAlpha.Temp

				ZProj.UGUIHelper.SetColorAlpha(self._imageicon, alpha)

				if isSelect then
					gohelper.setActive(self._btnadd, false)
				else
					local isEnough = true
					local notEnoughList = {}

					for _, param in ipairs(needMaterialParam) do
						local info = string.splitToNumber(param, "#")
						local id = info[1]
						local haveCount = Rouge2_AlchemyModel.instance:getMaterialNum(id)

						if haveCount < info[2] then
							table.insert(notEnoughList, id)

							isEnough = false
						end
					end

					gohelper.setActive(self._btnadd, isEnough)
					self:refreshNotEnoughMaterialInfo(isEnough, notEnoughList)
				end

				self:refreshFormulaNeed(needMaterialParam)
			end
		end
	else
		gohelper.setActive(self._btnadd, false)
		gohelper.setActive(self._btnunload, false)
	end
end

function Rouge2_AlchemyListView:refreshNotEnoughMaterialInfo(isEnough, notEnoughList)
	gohelper.setActive(self._txtlack, not isEnough)
	gohelper.setActive(self._txtneed, isEnough)

	if isEnough then
		return
	end

	local nameStrList = {}

	for _, materialId in ipairs(notEnoughList) do
		local materialConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(materialId)

		table.insert(nameStrList, materialConfig.name)
	end

	local sep = luaLang("rouge2_alchemy_mainmaterial_not_enough_link")
	local nameDesc = table.concat(nameStrList, sep)

	self._txtlack.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_alchemy_mainmaterial_not_enough"), nameDesc)
end

function Rouge2_AlchemyListView:refreshFormulaNeed(needMaterialParam)
	for index, param in ipairs(needMaterialParam) do
		local info = string.splitToNumber(param, "#")
		local needCount = info[2]
		local item = self._needMainMaterialItemList[index]

		gohelper.setActive(item.go, true)
		item:setInfo(info[1], needCount, Rouge2_OutsideEnum.SubMaterialDisplayType.DisplayOnly)
	end

	local itemCount = #self._needMainMaterialItemList
	local needCount = #needMaterialParam

	if needCount < itemCount then
		for i = needCount + 1, itemCount do
			local item = self._needMainMaterialItemList[i]

			gohelper.setActive(item.go, false)
		end
	end

	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.AlchemySubMaterialCount)
	local maxCount = tonumber(constConfig.value)
	local subMaterialDic = Rouge2_AlchemyModel.instance:getCurSubMaterialDic()

	for i = 1, maxCount do
		if subMaterialDic then
			if not subMaterialDic[i] then
				local materialId
				local item = self._needSubMaterialItemList[i]

				gohelper.setActive(item.go, true)
				item:setInfo(materialId, nil, Rouge2_OutsideEnum.SubMaterialDisplayType.DisplayOnly)
			end
		end
	end

	itemCount = #self._needSubMaterialItemList

	if maxCount < #self._needSubMaterialItemList then
		for i = maxCount + 1, itemCount do
			local item = self._needSubMaterialItemList[i]

			gohelper.setActive(item.go, false)
		end
	end
end

function Rouge2_AlchemyListView:refreshFormulaDesc(formulaConfig)
	local count = 1
	local item = self:getFormulaDesc(1)

	if formulaConfig then
		gohelper.setActive(item.go, true)

		item.text.text = formulaConfig.details
	else
		logError("formulaConfig not exist ")
		gohelper.setActive(item.go, false)
	end

	self:hideFormulaDesc(count)
end

function Rouge2_AlchemyListView:getFormulaDesc(index)
	local item = self._formulaDescItemList[index]

	if not item then
		item = self:createFormulaDesc()

		table.insert(self._formulaDescItemList, item)
	end

	return item
end

function Rouge2_AlchemyListView:createFormulaDesc()
	local textGo = gohelper.cloneInPlace(self._txtDesc.gameObject)
	local item = self:getUserDataTb_()

	item.go = textGo.gameObject
	item.text = gohelper.findChildTextMesh(textGo, "")

	return item
end

function Rouge2_AlchemyListView:hideFormulaDesc(count)
	local itemCount = #self._formulaDescItemList

	if count < itemCount then
		for i = count + 1, itemCount do
			local item = self:getFormulaDesc(i)

			gohelper.setActive(item.go, false)
		end
	end
end

function Rouge2_AlchemyListView:onClose()
	TaskDispatcher.cancelTask(self.onSwitchInfoRefresh, self)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayFinish, self)
end

function Rouge2_AlchemyListView:onDestroyView()
	return
end

return Rouge2_AlchemyListView
