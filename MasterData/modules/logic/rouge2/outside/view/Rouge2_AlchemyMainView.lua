-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemyMainView.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemyMainView", package.seeall)

local Rouge2_AlchemyMainView = class("Rouge2_AlchemyMainView", BaseView)

function Rouge2_AlchemyMainView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._goformulaEmpty = gohelper.findChild(self.viewGO, "Left/#go_formulaEmpty")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_formulaEmpty/#btn_add")
	self._goformulaHas = gohelper.findChild(self.viewGO, "Left/#go_formulaHas")
	self._simagerare = gohelper.findChildSingleImage(self.viewGO, "Left/#go_formulaHas/#simage_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_formulaHas/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "Left/#go_formulaHas/image_nameBG/#txt_name")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_formulaHas/#btn_remove")
	self._btnformluaInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_formulaHas/#btn_formulaInfo")
	self._gomaterialEmpty = gohelper.findChild(self.viewGO, "Right/#go_materialEmpty")
	self._gomaterialHas = gohelper.findChild(self.viewGO, "Right/#go_materialHas")
	self._gosubMaterialParent = gohelper.findChild(self.viewGO, "Right/#go_materialHas/sub/#go_subMaterialParent")
	self._gosubitem = gohelper.findChild(self.viewGO, "Right/#go_materialHas/sub/#go_subitem")
	self._btnaddSubMaterial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_materialHas/sub/#btn_addSubMaterial")
	self._btncombine = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_combine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemyMainView:addEvents()
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
	self._btnformluaInfo:AddClickListener(self._btnaddOnClick, self)
	self._btncombine:AddClickListener(self._btncombineOnClick, self)
	self._btnaddSubMaterial:AddClickListener(self._btnaddSubMaterialOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemyFormulaClear, self.onClearFormula, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemyFormula, self.refreshUI, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemySubMaterial, self.refreshUI, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemySuccess, self.onAlchemySuccess, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onAlchemyListViewClose, self)
end

function Rouge2_AlchemyMainView:removeEvents()
	self._btnadd:RemoveClickListener()
	self._btnremove:RemoveClickListener()
	self._btnformluaInfo:RemoveClickListener()
	self._btncombine:RemoveClickListener()
	self._btnaddSubMaterial:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemyFormulaClear, self.onClearFormula, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemyFormula, self.refreshUI, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onSelectAlchemySubMaterial, self.refreshUI, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemySuccess, self.onAlchemySuccess, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onAlchemyListViewClose, self)
end

function Rouge2_AlchemyMainView:_btnaddOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_alchemyidea)

	local viewParam = {}

	viewParam.itemType = Rouge2_OutsideEnum.AlchemyItemType.Formula

	Rouge2_OutsideController.instance:openAlchemySelectView(viewParam)
	self:cacheAlchemyInfo(true)
end

function Rouge2_AlchemyMainView:_btnremoveOnClick()
	if Rouge2_AlchemyModel.instance:getCurFormula() == nil then
		return
	end

	Rouge2_AlchemyModel.instance:clearFormula()
end

function Rouge2_AlchemyMainView:_btncombineOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_click)

	local curFormulaId = Rouge2_AlchemyModel.instance:getCurFormula()

	if curFormulaId == nil then
		logError("FormulaId is empty")

		return
	end

	local config = Rouge2_OutSideConfig.instance:getFormulaConfig(curFormulaId)
	local needMaterialParam = string.split(config.mainIdNum, "|")

	for _, materialParam in ipairs(needMaterialParam) do
		local info = string.splitToNumber(materialParam, "#")
		local haveCount = Rouge2_AlchemyModel.instance:getMaterialNum(info[1])

		if haveCount < info[2] then
			logError("MainMaterial is not enough")

			return
		end
	end

	local subMaterialList = {}
	local subMaterialDic = Rouge2_AlchemyModel.instance:getCurSubMaterialDic()

	if subMaterialDic then
		for _, materialId in pairs(subMaterialDic) do
			table.insert(subMaterialList, materialId)
		end
	end

	Rouge2OutsideRpc.instance:sendRouge2AlchemyRequest(curFormulaId, subMaterialList)
end

function Rouge2_AlchemyMainView:_btnaddSubMaterialOnClick()
	if Rouge2_AlchemyModel.instance:getCurFormula() == nil then
		return
	end

	local viewParam = {}

	viewParam.itemType = Rouge2_OutsideEnum.AlchemyItemType.SubMaterial

	Rouge2_OutsideController.instance:openAlchemySelectView(viewParam)
	self:cacheAlchemyInfo(true)
end

function Rouge2_AlchemyMainView:cacheAlchemyInfo(isSave)
	if isSave then
		local subMaterialDic = Rouge2_AlchemyModel.instance:getCurSubMaterialDic()

		self._tempSubMaterialDic = tabletool.copy(subMaterialDic)
		self._tempFormulaId = Rouge2_AlchemyModel.instance:getCurFormula()
	else
		self._tempSubMaterialDic = nil
		self._tempFormulaId = nil
	end
end

function Rouge2_AlchemyMainView:_editableInitView()
	self:initMainMaterialItem()

	self._subMaterialBgList = self:getUserDataTb_()

	table.insert(self._subMaterialBgList, gohelper.findChild(self.viewGO, "Right/#go_materialHas/sub/BG/simage_2"))
	table.insert(self._subMaterialBgList, gohelper.findChild(self.viewGO, "Right/#go_materialHas/sub/BG/simage_3"))
	table.insert(self._subMaterialBgList, gohelper.findChild(self.viewGO, "Right/#go_materialHas/sub/BG/simage_4"))

	self._subMaterialParentList = self:getUserDataTb_()

	local childCount = self._gosubMaterialParent.transform.childCount

	for i = 1, childCount do
		local itemGo = self._gosubMaterialParent.transform:GetChild(i - 1)

		table.insert(self._subMaterialParentList, itemGo)
	end

	self._subMaterialItemList = {}
	self._alchemyBtnCanvas = gohelper.findChildComponent(self._btncombine.gameObject, "", gohelper.Type_CanvasGroup)
	self._tempFormulaId = nil
	self._tempSubMaterialDic = nil

	gohelper.setActive(self._gosubitem, false)

	self._formulaAnimator = gohelper.findChildComponent(self.viewGO, "Left", gohelper.Type_Animator)
	self._materialAnimator = gohelper.findChildComponent(self.viewGO, "Right", gohelper.Type_Animator)
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_AlchemyMainView:initMainMaterialItem()
	self._mainMaterialParent = gohelper.findChild(self.viewGO, "Right/#go_materialHas/main")
	self._mainMaterialItemList = {}

	for i = 1, Rouge2_OutsideEnum.MainMaterialCount do
		local itemGo = self._mainMaterialParent.transform:GetChild(i - 1).gameObject
		local item = self:getUserDataTb_()

		item.go = itemGo
		item.simageIcon = gohelper.findChildSingleImage(itemGo, "#image_icon")

		table.insert(self._mainMaterialItemList, item)
	end
end

function Rouge2_AlchemyMainView:onUpdateParam()
	return
end

function Rouge2_AlchemyMainView:onOpen()
	self:refreshUI()
end

function Rouge2_AlchemyMainView:onClearFormula()
	self._formulaAnimator:Play("emptyin", 0, 0)
	self._materialAnimator:Play("emptyin", 0, 0)
	self:refreshUI()
end

function Rouge2_AlchemyMainView:refreshUI()
	self:refreshFormulaInfo()
	self:refreshMaterialInfo()
	self:refreshBtnState()
end

function Rouge2_AlchemyMainView:refreshFormulaInfo()
	local curFormulaId = Rouge2_AlchemyModel.instance:getCurFormula()
	local haveSelect = curFormulaId ~= nil

	gohelper.setActive(self._goformulaEmpty, not haveSelect)
	gohelper.setActive(self._goformulaHas, haveSelect)
	gohelper.setActive(self._btnremove, haveSelect)

	if not haveSelect then
		return
	end

	local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(curFormulaId)

	if not formulaConfig.rare then
		local rare = 1
		local path = "alchemy/rouge2_quality_circle2_" .. tostring(rare - 1)

		self._simagerare:LoadImage(ResUrl.getRouge2Icon(path))

		local rareColor = Rouge2_OutsideEnum.FormulaRareColor[rare]

		self._txtname.text = string.format("<color=%s>%s</color>", rareColor, formulaConfig.name)

		Rouge2_IconHelper.setFormulaIcon(curFormulaId, self._simageicon)
	end
end

function Rouge2_AlchemyMainView:refreshMaterialInfo()
	local curFormulaId = Rouge2_AlchemyModel.instance:getCurFormula()
	local haveSelect = curFormulaId ~= nil

	gohelper.setActive(self._gomaterialEmpty, not haveSelect)
	gohelper.setActive(self._gomaterialHas, haveSelect)

	if not haveSelect then
		return
	end

	self:refreshMainMaterial()
	self:refreshSubMaterial()
end

function Rouge2_AlchemyMainView:refreshMainMaterial()
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

function Rouge2_AlchemyMainView:refreshSubMaterial()
	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.AlchemySubMaterialCount)
	local maxCount = tonumber(constConfig.value)

	for index, item in ipairs(self._subMaterialBgList) do
		gohelper.setActive(item, index == maxCount - 1)
	end

	local subMaterialDic = Rouge2_AlchemyModel.instance:getCurSubMaterialDic()

	if subMaterialDic then
		if not #subMaterialDic then
			local materialCount = 0
			local itemCount = #self._subMaterialItemList
			local bgCount = #self._subMaterialParentList

			for i = 1, maxCount do
				local id = subMaterialDic[i]
				local item = self:getSubMaterialItem(i)
				local parent = self._subMaterialParentList[i]

				gohelper.setActive(item.go, true)
				gohelper.setActive(parent.gameObject, true)
				item:setInfo(Rouge2_OutsideEnum.SubMaterialDisplayType.DisplayOnly, id)
			end

			if maxCount < itemCount then
				for i = materialCount + 1, itemCount do
					local item = self._subMaterialItemList[i]

					if item and item.go then
						gohelper.setActive(item.go, false)
					end
				end
			end

			if maxCount < bgCount then
				for i = maxCount + 1, bgCount do
					local parent = self._subMaterialParentList[i]

					gohelper.setActive(parent.gameObject, false)
				end
			end
		end
	end
end

function Rouge2_AlchemyMainView:getSubMaterialItem(index)
	local item = self._subMaterialItemList[index]

	if not item then
		item = self:createMaterialItem(index)

		table.insert(self._subMaterialItemList, item)
	end

	return item
end

function Rouge2_AlchemyMainView:createMaterialItem(index)
	local parent = self._subMaterialParentList[index]
	local itemGo = gohelper.clone(self._gosubitem, parent.gameObject, tostring(index))

	return (MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Rouge2_AlchemySubMaterialItem))
end

function Rouge2_AlchemyMainView:refreshBtnState()
	local curFormulaId = Rouge2_AlchemyModel.instance:getCurFormula()
	local haveSelect = curFormulaId ~= nil

	gohelper.setActive(self._btncombine, haveSelect)
end

function Rouge2_AlchemyMainView:onAlchemySuccess()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onAlchemySuccessViewOpenFinish, self)
	self._animator:Play("compose", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_cikeshang_yueka_unfold)
end

function Rouge2_AlchemyMainView:onAlchemyListViewClose(viewName)
	if viewName == ViewName.Rouge2_AlchemyListView then
		local curFormulaId = Rouge2_AlchemyModel.instance:getCurFormula()
		local isEmpty = curFormulaId == nil and self._tempFormulaId ~= nil

		if isEmpty then
			self._formulaAnimator:Play("emptyin", 0, 0)
			self._materialAnimator:Play("emptyin", 0, 0)
			logNormal("emptyin")
		elseif curFormulaId ~= self._tempFormulaId then
			self._formulaAnimator:Play("hasin", 0, 0)
			self._materialAnimator:Play("hasin", 0, 0)
			logNormal("hasin")
		end

		local curMaterialDic = Rouge2_AlchemyModel.instance:getCurSubMaterialDic()

		for index, material in pairs(curMaterialDic) do
			if not self._tempSubMaterialDic[index] or self._tempSubMaterialDic[index] ~= material then
				local item = self._subMaterialItemList[index]

				item.animator:Play("light", 0, 0)
			end
		end

		self:cacheAlchemyInfo(false)
	end
end

function Rouge2_AlchemyMainView:onAlchemySuccessViewOpenFinish(viewName)
	if viewName == ViewName.Rouge2_AlchemySuccessView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onAlchemySuccessViewOpenFinish, self)
		self:closeThis()
	end
end

function Rouge2_AlchemyMainView:onClose()
	Rouge2_AlchemyModel.instance:clearFormula()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onAlchemySuccessViewOpenFinish, self)
end

function Rouge2_AlchemyMainView:onDestroyView()
	return
end

return Rouge2_AlchemyMainView
