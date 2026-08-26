-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerAttributeTipsView.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerAttributeTipsView", package.seeall)

local Rouge2_CareerAttributeTipsView = class("Rouge2_CareerAttributeTipsView", BaseViewExtended)

Rouge2_CareerAttributeTipsView.SafeArea = Vector2(0, 200)
Rouge2_CareerAttributeTipsView.CareerDescPrecentColor = "#FFA854"

function Rouge2_CareerAttributeTipsView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goMark = gohelper.findChild(self.viewGO, "#go_Mark")
	self._goFlag = gohelper.findChild(self.viewGO, "#go_Mark/#go_Flag")
	self._scrolloverview = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_overview")
	self._goArrow = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/arrow")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/Title/#image_Icon")
	self._txtCareer = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/Title/txt_Career")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/Title/#txt_Num")
	self._txtDropNum = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/Title/#txt_Num/#txt_DropNum")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport")
	self._scrollRelics = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#scroll_Relics")
	self._goRelicsContent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#scroll_Relics/Viewport/Content")
	self._btnRelicsTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#scroll_Relics/Viewport/#btn_RelicsTips")
	self._goTagTitle = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_TagTitle")
	self._goSpDescList = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_SpDescList")
	self._goSpDescItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_SpDescList/#go_SpDescItem")
	self._goEmptySpDesc = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_EmptySpDesc")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._txtCareerDesc = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/CareerDesc/#txt_CareerDesc")
	self._goRecommend = gohelper.findChild(self.viewGO, "#go_Root/#go_Recommend")
	self._transform = self.viewGO.transform
	self._tranRoot = self._goRoot.transform
	self._tranMark = self._goMark.transform
	self._tranFlag = self._goFlag.transform
	self._isInitDone = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerAttributeTipsView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._scrolloverview:AddOnValueChanged(self._refreshArrow, self)
	self._btnRelicsTips:AddClickListener(self._btnRelicsTipsOnClick, self)
end

function Rouge2_CareerAttributeTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._scrolloverview:RemoveOnValueChanged()
	self._btnRelicsTips:RemoveClickListener()
end

function Rouge2_CareerAttributeTipsView:_refreshArrow()
	gohelper.setActive(self._goMark, self._scrolloverview.verticalNormalizedPosition > 0.01)
end

function Rouge2_CareerAttributeTipsView:_editableInitView()
	self._goRelicsItem = self:getResInst(Rouge2_Enum.ResPath.CareerAttrActiveItem, self._goRelicsContent, "#go_RelicsItem")

	local width = recthelper.getWidth(self._scrolloverview.transform) + Rouge2_CareerAttributeTipsView.SafeArea.x
	local height = recthelper.getHeight(self._scrolloverview.transform) + Rouge2_CareerAttributeTipsView.SafeArea.y

	recthelper.setSize(self._tranFlag, width, height)

	local scrollPosX, scrollPosY = recthelper.getAnchor(self._scrolloverview.transform)

	recthelper.setAnchor(self._tranFlag, scrollPosX, scrollPosY)

	width = recthelper.getWidth(self._tranRoot)
	height = recthelper.getHeight(self._tranRoot)

	recthelper.setSize(self._tranMark, width, height)
end

function Rouge2_CareerAttributeTipsView:onOpen()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
end

function Rouge2_CareerAttributeTipsView:onUpdateParam()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
end

function Rouge2_CareerAttributeTipsView:onRefreshViewParam(viewParam)
	self.viewParam = viewParam

	if not self._isInitDone then
		return
	end

	self:onUpdateParam()
end

function Rouge2_CareerAttributeTipsView:refreshParams()
	self._careerId = self.viewParam and self.viewParam.careerId
	self._attrId = self.viewParam and self.viewParam.attributeId
	self._attrValue = self.viewParam and self.viewParam.attributeValue
	self._pos = self.viewParam and self.viewParam.pos
	self._ignorePos = self.viewParam and self.viewParam.ignorePos

	if self.viewParam then
		self._offset = self.viewParam.offset or Vector2.zero
	end

	self._attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attrId)
	self._clickCallback = self.viewParam and self.viewParam.clickCallback
	self._clickCallbackObj = self.viewParam and self.viewParam.clickCallbackObj
	self._passiveSkillCo = Rouge2_AttributeConfig.instance:getCareerPassiveSkill(self._careerId, self._attrId, self._attrValue)
end

function Rouge2_CareerAttributeTipsView:refreshUI()
	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon)

	self._txtNum.text = self._attrValue or 0
	self._txtCareer.text = self._attrCo and self._attrCo.name

	Rouge2_AttrDropDescHelper.loadAttrDropLevelList(self._careerId, self._attrId, self._txtDropNum, true, Rouge2_Enum.AttrDropArrowType.Black)

	if self._passiveSkillCo then
		local skillName = self._passiveSkillCo.name
		local skillNameResult = Rouge2_ItemExpressionHelper.getDescResult(nil, nil, skillName)

		Rouge2_ItemDescHelper.buildAndSetDesc(self._txtCareerDesc, skillNameResult, Rouge2_CareerAttributeTipsView.CareerDescPrecentColor)
		gohelper.setActive(self._goRecommend, Rouge2_BackpackController.instance:isAttrRecommend(self._careerId, self._attrId))
		self:refreshAttrUpdateRelics()
		self:refreshSpPassiveSkill()
	end
end

function Rouge2_CareerAttributeTipsView:refreshAttrUpdateRelics()
	self._attrUpdateRelicsList, self._attrUpdateRelicsIdList = Rouge2_BackpackModel.instance:getAttrUpdateActiveRelicsList(self._attrId, self._attrValue)
	self._hasAttrUpdateRelics = self._attrUpdateRelicsList and #self._attrUpdateRelicsList > 0

	gohelper.setActive(self._scrollRelics.gameObject, self._hasAttrUpdateRelics)

	if not self._hasAttrUpdateRelics then
		return
	end

	gohelper.CreateObjList(self, self._refreshAttrUpdateRelicsItem, self._attrUpdateRelicsList, self._goRelicsContent, self._goRelicsItem, Rouge2_CareerAttributeActiveItem)
end

function Rouge2_CareerAttributeTipsView:_refreshAttrUpdateRelicsItem(activeItem, relicsInfo, index)
	activeItem:onUpdateMO(self._attrValue, relicsInfo)
end

function Rouge2_CareerAttributeTipsView:refreshSpPassiveSkill()
	self._attrDropList = Rouge2_AttributeConfig.instance:getLimitAttrDropList(self._careerId, self._attrId)

	if self._attrDropList then
		local hasAttrDrop = #self._attrDropList > 0

		gohelper.setActive(self._goSpDescList, hasAttrDrop)
		gohelper.setActive(self._goTagTitle, hasAttrDrop)
		gohelper.setActive(self._goEmptySpDesc, not hasAttrDrop)

		if not hasAttrDrop then
			return
		end

		gohelper.CreateObjList(self, self._refreshSpPassiveSkillDesc, self._attrDropList, self._goSpDescList, self._goSpDescItem)
	end
end

function Rouge2_CareerAttributeTipsView:_refreshSpPassiveSkillDesc(obj, attrDropCo, index)
	Rouge2_AttrDropDescHelper.LoadAttrDropDesc(attrDropCo.id, obj)
end

function Rouge2_CareerAttributeTipsView:updatePosition()
	if self._ignorePos then
		return
	end

	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(self._pos, self._transform)

	if self._offset then
		if not self._offset.x then
			local offsetX = 0

			if self._offset then
				if not self._offset.y then
					local offsetY = 0

					anchorPosX = anchorPosX + offsetX
					anchorPosY = anchorPosY + offsetY

					recthelper.setAnchor(self._tranMark, anchorPosX, anchorPosY)
					self:_fitScreenOffset()
					TaskDispatcher.cancelTask(self._fitScreenOffset, self)
					TaskDispatcher.runDelay(self._fitScreenOffset, self, 0.01)
				end
			end
		end
	end
end

function Rouge2_CareerAttributeTipsView:_fitScreenOffset()
	gohelper.fitScreenOffset(self._tranMark)

	local posX, posY = recthelper.getAnchor(self._tranMark)

	recthelper.setAnchor(self._tranRoot, posX, posY)
end

function Rouge2_CareerAttributeTipsView:_btnCloseOnClick()
	if self._clickCallback then
		local clickPosition = GamepadController.instance:getMousePosition()

		if self._clickCallbackObj then
			self._clickCallback(self._clickCallbackObj, self, clickPosition)
		else
			self:_clickCallback(clickPosition)
		end

		return
	end

	self:closeThis()
end

function Rouge2_CareerAttributeTipsView:_btnRelicsTipsOnClick()
	if not self._hasAttrUpdateRelics then
		return
	end

	local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(Rouge2_Enum.BagType.Relics)

	ViewMgr.instance:openView(showViewName, {
		viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Tips,
		dataType = Rouge2_Enum.ItemDataType.Config,
		itemList = self._attrUpdateRelicsIdList
	})
end

function Rouge2_CareerAttributeTipsView:onClose()
	TaskDispatcher.cancelTask(self._fitScreenOffset, self)
end

return Rouge2_CareerAttributeTipsView
