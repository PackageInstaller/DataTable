-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_MaterialListView.lua

module("modules.logic.rouge2.outside.view.Rouge2_MaterialListView", package.seeall)

local Rouge2_MaterialListView = class("Rouge2_MaterialListView", BaseView)

function Rouge2_MaterialListView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_collection")
	self._gocontent = gohelper.findChild(self.viewGO, "Left/#scroll_collection/Viewport/#go_content")
	self._gosmalltitle = gohelper.findChild(self.viewGO, "Left/#go_smalltitle")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Left/#go_smalltitle/#image_icon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Left/#go_smalltitle/#txt_Title")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/filter/#btn_filter")
	self._golayout = gohelper.findChild(self.viewGO, "Left/filter/#go_layout")
	self._gonormal = gohelper.findChild(self.viewGO, "Right/#go_normal")
	self._imageicon1 = gohelper.findChildImage(self.viewGO, "Right/#go_normal/#image_icon1")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_normal/#image_icon1")
	self._txtcollectionname1 = gohelper.findChildText(self.viewGO, "Right/#go_normal/#txt_collectionname1")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_normal/#scroll_collectiondesc")
	self._godescContent = gohelper.findChild(self.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent")
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/#btn_block")
	self._golocked = gohelper.findChild(self.viewGO, "Right/#go_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "Right/#go_locked/locked/#txt_locked")
	self._gounget = gohelper.findChild(self.viewGO, "Right/#go_unget")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "Right/#go_unget/#image_icon2")
	self._gobasetags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2")
	self._gobasetagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2/#go_basetagitem2")
	self._goextratags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2")
	self._goextratagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2/#go_extratagitem2")
	self._gotips2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_tips2")
	self._txttagitem2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/tags/#go_tips2/#txt_tagitem2")
	self._goshapecell2 = gohelper.findChild(self.viewGO, "Right/#go_unget/shape/#go_shapecell2")
	self._txtcollectionname2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/#txt_collectionname2")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MaterialListView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnClickMaterialListItem, self._onClickCollectionListItem, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectCollectionFormulaItem, self._onClickFormulaItem, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function Rouge2_MaterialListView:removeEvents()
	self._btnfilter:RemoveClickListener()
	self._btnblock:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnClickMaterialListItem, self._onClickCollectionListItem, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectCollectionFormulaItem, self._onClickFormulaItem, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function Rouge2_MaterialListView:_btnfilterOnClick()
	return
end

function Rouge2_MaterialListView:_btnblockOnClick()
	return
end

function Rouge2_MaterialListView:_editableInitView()
	self._goUnselectLayout = gohelper.findChild(self._golayout.gameObject, "unselected")
	self._goSelectLayout = gohelper.findChild(self._golayout.gameObject, "selected")
	self._gocontenttransform = self._gocontent.transform

	self._scrollcollection:AddOnValueChanged(self._onScrollChange, self)

	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "Left/filter/#go_layout")

	self._dropherogroup:AddOnValueChanged(self._onDropValueChanged, self)

	self._dropherogrouparrow = gohelper.findChild(self.viewGO, "Left/filter/#go_layout/selected/Label/go_arrow").transform
	self._dropgroupchildcount = self._goSelectLayout.transform.childCount
	self._selectIndex = 1
	self._labelList = {
		luaLang("p_all"),
		luaLang("p_rouge2illustrated_txt_type1"),
		luaLang("p_rouge2illustrated_txt_type2")
	}

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(self._labelList)
	self._dropherogroup:SetValue(self._selectIndex - 1)
	TaskDispatcher.runRepeat(self._checkDropArrow, self, 0)

	local goRight = gohelper.findChild(self.viewGO, "Right")

	self._rightAnimator = gohelper.onceAddComponent(goRight, gohelper.Type_Animator)
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._txtDesc = gohelper.findChildTextMesh(self._godescContent, "txt_desc")
	self._txtGang = gohelper.findChild(self.viewGO, "Left/#go_smalltitle/txt_gang")

	gohelper.setActive(self._golocked, false)
	gohelper.setActive(self._gounget, false)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._txtGang, false)
	gohelper.setActive(self._imageicon, false)
	Rouge2_ItemDescHelper.addFixTmpBreakLine(self._txtDesc)
	SkillHelper.addHyperLinkClick(self._txtDesc)

	self._goFormulaInfo = gohelper.findChild(self.viewGO, "Right/#go_normal/canUse")
	self._goFormulaItem = gohelper.findChild(self.viewGO, "Right/#go_normal/canUse/#scroll_canUse/Viewport/Content/#go_collectionitem")

	gohelper.setActive(self._goFormulaItem, false)

	self._dropHeroText = gohelper.findChildTextMesh(self.viewGO, "Left/filter/#go_layout/selected/Label")
end

function Rouge2_MaterialListView:_checkDropArrow()
	local childCount = self._goSelectLayout.transform.childCount

	if childCount ~= self._dropDownChildCount then
		self._dropDownChildCount = childCount

		local isOpen = self._dropgroupchildcount ~= childCount

		transformhelper.setLocalScale(self._dropherogrouparrow, 1, isOpen and -1 or 1, 1)
	end
end

function Rouge2_MaterialListView:_onDropValueChanged(value)
	self._selectIndex = value + 1

	Rouge2_MaterialListModel.instance:onInitData(self._selectIndex)

	self._dropHeroText.text = self._labelList[self._selectIndex]

	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio7)
end

function Rouge2_MaterialListView:_onScrollChange()
	local y = recthelper.getAnchorY(self._gocontenttransform)
	local model = Rouge2_MaterialListModel.instance
	local typeMap = model:getTypeHeightMap()
	local typeList = model:getTypeList()
	local curType

	for i, v in ipairs(typeList) do
		local type = v.type
		local height = (typeMap[type] or 0) + 48

		if height < y then
			curType = type
		else
			break
		end
	end

	curType = curType or model:getFirstType() or typeList[1].type

	local showTitle = curType ~= nil and #Rouge2_MaterialListModel.instance:getList() > 0

	gohelper.setActive(self._gosmalltitle, showTitle)

	if showTitle then
		local langName = "p_rouge2illustrated_txt_type" .. curType

		self._txtTitle.text = luaLang(langName)
	end
end

function Rouge2_MaterialListView:_checkDropArrow()
	local childCount = self._goSelectLayout.transform.childCount

	if childCount ~= self._dropDownChildCount then
		self._dropDownChildCount = childCount

		local isOpen = self._dropgroupchildcount ~= childCount

		transformhelper.setLocalScale(self._dropherogrouparrow, 1, isOpen and -1 or 1, 1)
		self:_onScrollChange()
	end
end

function Rouge2_MaterialListView:_onClickCollectionListItem()
	self._rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._refreshSelectMaterialInfo, self)
	TaskDispatcher.runDelay(self._refreshSelectMaterialInfo, self, Rouge2_OutsideEnum.CollectionListViewDelayTime)
end

function Rouge2_MaterialListView:_onClickFormulaItem(formulaId)
	if ViewMgr.instance:isOpen(ViewName.Rouge2_FavoriteCollectionView) then
		self:closeThis()
	else
		local param = {
			defaultTabIds = {
				[2] = Rouge2_OutsideEnum.CollectionDisplayType.Formula
			},
			selectItemId = formulaId
		}

		Rouge2_OutsideController.instance:openFavoriteMainView(param, false, self.closeThis, self)
	end
end

function Rouge2_MaterialListView:_onSwitchCollectionInfoType()
	local infoType = Rouge2_OutsideModel.instance:getCurCollectionInfoType()
	local config = self._collectionConfig
	local isSimple = infoType == Rouge2_OutsideEnum.CollectionInfoType.Simple

	if isSimple then
		if not Rouge2_Enum.ItemDescMode.Simply then
			local model = Rouge2_Enum.ItemDescMode.Full

			Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, config.id, self._txtDesc, model, nil, Rouge2_OutsideEnum.DescPercentColor, Rouge2_OutsideEnum.DescBracketColor)

			local desc = self._txtDesc.text

			self._txtDesc.text = Rouge2_ItemDescHelper.replaceColor(desc, Rouge2_OutsideEnum.DescReplaceColor, Rouge2_OutsideEnum.DescPercentColor)
		end
	end
end

function Rouge2_MaterialListView:_refreshSelectMaterialInfo()
	local selectedConfig = Rouge2_MaterialListModel.instance:getSelectedConfig()

	if not selectedConfig then
		return
	end

	self._materialId = selectedConfig.id
	self._materialConfig = selectedConfig

	self:refreshNormalInfo()
	self:refreshFormulaInfo()
end

function Rouge2_MaterialListView:onUpdateParam()
	return
end

function Rouge2_MaterialListView:onOpen()
	local param = self.viewParam
	local selectMaterialId = param and param.selectMaterialId

	Rouge2_MaterialListModel.instance:onInitData(self._selectIndex, selectMaterialId)
	self._aniamtor:Play("open", 0, 0)
	self:_onScrollChange()
	self:_refreshSelectMaterialInfo()
end

function Rouge2_MaterialListView:refreshNormalInfo()
	local materialConfig = self._materialConfig

	Rouge2_IconHelper.setMaterialIcon(materialConfig.id, self._simageicon1)

	self._txtcollectionname1.text = materialConfig.name

	local desc = Rouge2_ItemDescHelper.buildDesc(materialConfig.details, Rouge2_OutsideEnum.DescPercentColor, Rouge2_OutsideEnum.DescBracketColor)

	self._txtDesc.text = Rouge2_ItemDescHelper.replaceColor(desc, Rouge2_OutsideEnum.DescReplaceColor, Rouge2_OutsideEnum.DescPercentColor)
end

function Rouge2_MaterialListView:refreshFormulaInfo()
	local selectedConfig = self._materialConfig
	local showFormula = not string.nilorempty(selectedConfig.formula)

	gohelper.setActive(self._goFormulaInfo, showFormula)

	if not showFormula then
		return
	end

	local data = {}
	local formulaParam = string.splitToNumber(selectedConfig.formula, "#")

	for _, param in ipairs(formulaParam) do
		local mo = {}

		mo.type = Rouge2_OutsideEnum.CollectionType.Formula
		mo.itemId = param
		mo.id = param
		mo.showRedDot = false

		table.insert(data, mo)
	end

	gohelper.CreateObjList(self, self.onFormulaItemShow, data, nil, self._goFormulaItem, Rouge2_CollectionFormulaItem)
end

function Rouge2_MaterialListView:onFormulaItemShow(item, data, index)
	item:onUpdateMO(data)
end

function Rouge2_MaterialListView:onClose()
	self._scrollcollection:RemoveOnValueChanged()
	self._dropherogroup:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._checkDropArrow, self)
	TaskDispatcher.cancelTask(self._refreshSelectMaterialInfo, self)
end

function Rouge2_MaterialListView:onDestroyView()
	return
end

return Rouge2_MaterialListView
