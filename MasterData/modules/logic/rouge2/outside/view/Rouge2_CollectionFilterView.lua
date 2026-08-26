-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionFilterView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionFilterView", package.seeall)

local Rouge2_CollectionFilterView = class("Rouge2_CollectionFilterView", BaseView)

function Rouge2_CollectionFilterView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gobase = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base")
	self._gobaseContainer = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer")
	self._gorareItem = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer/#go_rareItem")
	self._imageicon = gohelper.findChildImage(self.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer/#go_rareItem/#image_icon")
	self._goextra = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra")
	self._goextraContainer = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra/#go_extraContainer")
	self._goextraItem = gohelper.findChild(self.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra/#go_extraContainer/#go_extraItem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionFilterView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function Rouge2_CollectionFilterView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function Rouge2_CollectionFilterView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_CollectionFilterView:_btnresetOnClick()
	tabletool.clear(self._baseBtnSelectMap)
	tabletool.clear(self._extraBtnSelectMap)
	self:BuildCollectionTagList()
	self:BuildCollectionTypeList()
end

function Rouge2_CollectionFilterView:_btnconfirmOnClick()
	local confirmCallback = self.viewParam.confirmCallback

	if confirmCallback then
		if self.viewParam then
			self.viewParam:confirmCallback(self._baseBtnSelectMap, self._extraBtnSelectMap)
		end
	end

	self:closeThis()
end

function Rouge2_CollectionFilterView:_editableInitView()
	self._extraBtnMap = self:getUserDataTb_()
	self._baseBtnMap = self:getUserDataTb_()
end

function Rouge2_CollectionFilterView:onUpdateParam()
	return
end

function Rouge2_CollectionFilterView:onOpen()
	self:onInit()
end

function Rouge2_CollectionFilterView:onInit()
	self:BuildSelectMap()
	self:BuildCollectionTagList()
	self:BuildCollectionTypeList()
end

function Rouge2_CollectionFilterView:BuildSelectMap()
	self._baseBtnSelectMap = self.viewParam.baseSelectMap and self.viewParam.baseSelectMap or {}
	self._extraBtnSelectMap = self.viewParam.extraSelectMap and self.viewParam.extraSelectMap or {}
end

function Rouge2_CollectionFilterView:BuildCollectionTagList()
	local baseTags = Rouge2_CollectionConfig.instance:getCollectionBaseTags()

	GoHelperExtend.CreateObjList(self, self.refreshBaseTagBtn, baseTags, self._gobaseContainer, self._gorareItem)
end

local UnselectNameColor = "#B6B2A8"
local SelectNameColor = "#ECA373"

function Rouge2_CollectionFilterView:refreshBaseTagBtn(obj, tagCfg, index)
	if not self._baseBtnMap[index] then
		self._baseBtnMap[index] = self:getUserDataTb_()
		self._baseBtnMap[index].tagId = tagCfg.id
		self._baseBtnMap[index].goUnselected = gohelper.findChild(obj, "unselected")
		self._baseBtnMap[index].goselected = gohelper.findChild(obj, "selected")
		self._baseBtnMap[index].txtname = gohelper.findChildText(obj, "tagText")
		self._baseBtnMap[index].imagetagicon = gohelper.findChildImage(obj, "#image_icon")
		self._baseBtnMap[index].btnclick = gohelper.findChildButtonWithAudio(obj, "click")

		self._baseBtnMap[index].btnclick:AddClickListener(self.onClickBaseBtnItem, self, self._baseBtnMap[index])
	end

	if not self._baseBtnSelectMap[tagCfg.id] then
		local isSelect = false

		gohelper.setActive(self._baseBtnMap[index].goUnselected, not isSelect)
		gohelper.setActive(self._baseBtnMap[index].goselected, isSelect)

		self._baseBtnMap[index].txtname.text = tostring(tagCfg.name)

		SLFramework.UGUI.GuiHelper.SetColor(self._baseBtnMap[index].txtname, (isSelect or nil) and (SelectNameColor or UnselectNameColor))
		UISpriteSetMgr.instance:setRougeSprite(self._baseBtnMap[index].imagetagicon, tagCfg.iconUrl)
	end
end

function Rouge2_CollectionFilterView:onClickBaseBtnItem(params)
	if not self._baseBtnSelectMap[params.tagId] then
		local isSelect = false

		isSelect = not isSelect
		self._baseBtnSelectMap[params.tagId] = isSelect and true or nil

		gohelper.setActive(params.goUnselected, not isSelect)
		gohelper.setActive(params.goselected, isSelect)
		SLFramework.UGUI.GuiHelper.SetColor(params.txtname, (isSelect or nil) and (SelectNameColor or UnselectNameColor))
	end
end

function Rouge2_CollectionFilterView:BuildCollectionTypeList()
	gohelper.setActive(self._goextra)
end

function Rouge2_CollectionFilterView:refreshExtraTagBtn(obj, extraTagCfg, index)
	if not self._extraBtnMap[index] then
		self._extraBtnMap[index] = self:getUserDataTb_()
		self._extraBtnMap[index].typeId = extraTagCfg.id
		self._extraBtnMap[index].goUnselected = gohelper.findChild(obj, "unselected")
		self._extraBtnMap[index].goselected = gohelper.findChild(obj, "selected")
		self._extraBtnMap[index].txtname = gohelper.findChildText(obj, "tagText")
		self._extraBtnMap[index].imagetagicon = gohelper.findChildImage(obj, "#image_icon")
		self._extraBtnMap[index].btnclick = gohelper.findChildButtonWithAudio(obj, "click")

		self._extraBtnMap[index].btnclick:AddClickListener(self.onClickExtraBtnItem, self, self._extraBtnMap[index])
	end

	if not self._extraBtnSelectMap[extraTagCfg.id] then
		local isSelect = false

		gohelper.setActive(self._extraBtnMap[index].goUnselected, not isSelect)
		gohelper.setActive(self._extraBtnMap[index].goselected, isSelect)

		self._extraBtnMap[index].txtname.text = tostring(extraTagCfg.name)

		SLFramework.UGUI.GuiHelper.SetColor(self._extraBtnMap[index].txtname, (isSelect or nil) and (SelectNameColor or UnselectNameColor))
		UISpriteSetMgr.instance:setRougeSprite(self._extraBtnMap[index].imagetagicon, extraTagCfg.iconUrl)
	end
end

function Rouge2_CollectionFilterView:onClickExtraBtnItem(params)
	local isSelect = self._extraBtnSelectMap[params.typeId]

	isSelect = not isSelect
	self._extraBtnSelectMap[params.typeId] = isSelect and true or nil

	gohelper.setActive(params.goUnselected, not isSelect)
	gohelper.setActive(params.goselected, isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(params.txtname, (isSelect or nil) and (SelectNameColor or UnselectNameColor))
end

function Rouge2_CollectionFilterView:releaseAllClickListeners()
	if self._baseBtnMap then
		for _, item in pairs(self._baseBtnMap) do
			item.btnclick:RemoveClickListener()
		end
	end

	if self._extraBtnMap then
		for _, item in pairs(self._extraBtnMap) do
			item.btnclick:RemoveClickListener()
		end
	end
end

function Rouge2_CollectionFilterView:onClose()
	return
end

function Rouge2_CollectionFilterView:onDestroyView()
	self:releaseAllClickListeners()
end

return Rouge2_CollectionFilterView
