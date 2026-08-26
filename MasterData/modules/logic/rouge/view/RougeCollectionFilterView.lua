-- chunkname: @modules/logic/rouge/view/RougeCollectionFilterView.lua

module("modules.logic.rouge.view.RougeCollectionFilterView", package.seeall)

local RougeCollectionFilterView = class("RougeCollectionFilterView", BaseView)

function RougeCollectionFilterView:onInitView()
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

function RougeCollectionFilterView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function RougeCollectionFilterView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function RougeCollectionFilterView:_btncloseOnClick()
	self:closeThis()
end

function RougeCollectionFilterView:_btnresetOnClick()
	tabletool.clear(self._baseBtnSelectMap)
	tabletool.clear(self._extraBtnSelectMap)
	self:BuildCollectionTagList()
	self:BuildCollectionTypeList()
end

function RougeCollectionFilterView:_btnconfirmOnClick()
	local confirmCallback = self.viewParam.confirmCallback

	if confirmCallback then
		if self.viewParam then
			self.viewParam:confirmCallback(self._baseBtnSelectMap, self._extraBtnSelectMap)
		end
	end

	self:closeThis()
end

function RougeCollectionFilterView:_editableInitView()
	self._extraBtnMap = self:getUserDataTb_()
	self._baseBtnMap = self:getUserDataTb_()
end

function RougeCollectionFilterView:onUpdateParam()
	return
end

function RougeCollectionFilterView:onOpen()
	self:onInit()
end

function RougeCollectionFilterView:onInit()
	self:BuildSelectMap()
	self:BuildCollectionTagList()
	self:BuildCollectionTypeList()
end

function RougeCollectionFilterView:BuildSelectMap()
	self._baseBtnSelectMap = self.viewParam.baseSelectMap and self.viewParam.baseSelectMap or {}
	self._extraBtnSelectMap = self.viewParam.extraSelectMap and self.viewParam.extraSelectMap or {}
end

function RougeCollectionFilterView:BuildCollectionTagList()
	local baseTags = RougeCollectionConfig.instance:getCollectionBaseTags()

	GoHelperExtend.CreateObjList(self, self.refreshBaseTagBtn, baseTags, self._gobaseContainer, self._gorareItem)
end

local UnselectNameColor = "#B6B2A8"
local SelectNameColor = "#ECA373"

function RougeCollectionFilterView:refreshBaseTagBtn(obj, tagCfg, index)
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

function RougeCollectionFilterView:onClickBaseBtnItem(params)
	if not self._baseBtnSelectMap[params.tagId] then
		local isSelect = false

		isSelect = not isSelect
		self._baseBtnSelectMap[params.tagId] = isSelect and true or nil

		gohelper.setActive(params.goUnselected, not isSelect)
		gohelper.setActive(params.goselected, isSelect)
		SLFramework.UGUI.GuiHelper.SetColor(params.txtname, (isSelect or nil) and (SelectNameColor or UnselectNameColor))
	end
end

function RougeCollectionFilterView:BuildCollectionTypeList()
	local extraTags = RougeCollectionConfig.instance:getCollectionExtraTags()

	GoHelperExtend.CreateObjList(self, self.refreshExtraTagBtn, extraTags, self._goextraContainer, self._goextraItem)
end

function RougeCollectionFilterView:refreshExtraTagBtn(obj, extraTagCfg, index)
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

function RougeCollectionFilterView:onClickExtraBtnItem(params)
	local isSelect = self._extraBtnSelectMap[params.typeId]

	isSelect = not isSelect
	self._extraBtnSelectMap[params.typeId] = isSelect and true or nil

	gohelper.setActive(params.goUnselected, not isSelect)
	gohelper.setActive(params.goselected, isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(params.txtname, (isSelect or nil) and (SelectNameColor or UnselectNameColor))
end

function RougeCollectionFilterView:releaseAllClickListeners()
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

function RougeCollectionFilterView:onClose()
	return
end

function RougeCollectionFilterView:onDestroyView()
	self:releaseAllClickListeners()
end

return RougeCollectionFilterView
