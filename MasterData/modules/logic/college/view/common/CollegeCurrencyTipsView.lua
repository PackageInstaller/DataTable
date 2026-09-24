-- chunkname: @modules/logic/college/view/common/CollegeCurrencyTipsView.lua

module("modules.logic.college.view.common.CollegeCurrencyTipsView", package.seeall)

local CollegeCurrencyTipsView = class("CollegeCurrencyTipsView", BaseView)
local TipsOffset = Vector2(-120, -30)

function CollegeCurrencyTipsView:onInitView()
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Container")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Container/title/#txt_Name")
	self._txtTotalNum = gohelper.findChildText(self.viewGO, "#go_Container/title/#txt_TotalNum")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Container/title/#simage_Icon")
	self._goAddContainer = gohelper.findChild(self.viewGO, "#go_Container/#go_AddContainer")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Container/#go_AddContainer/#go_Current")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_Container/#go_AddContainer/#go_Current/#go_CurrentItem/txt_Num")
	self._goAdd = gohelper.findChild(self.viewGO, "#go_Container/#go_AddContainer/#go_Add")
	self._goAddItem = gohelper.findChild(self.viewGO, "#go_Container/#go_AddContainer/#go_Add/#go_AddItem")
	self._goDescContainer = gohelper.findChild(self.viewGO, "#go_Container/#go_DescContainer")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Container/#go_DescContainer/#txt_Desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeCurrencyTipsView:addEvents()
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function CollegeCurrencyTipsView:removeEvents()
	return
end

function CollegeCurrencyTipsView:_editableInitView()
	self._tranContainer = self._goContainer.transform
	self._viewTran = self.viewGO.transform
	self._bgTran = gohelper.findChild(self.viewGO, "#go_Container/bg").transform

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function CollegeCurrencyTipsView:onOpen()
	self:showTips()
end

function CollegeCurrencyTipsView:onUpdateParam()
	self:showTips()
end

function CollegeCurrencyTipsView:showTips()
	self._itemId = self.viewParam and self.viewParam.itemId
	self._screenPos = self.viewParam and self.viewParam.screenPos
	self._screenPos = self._screenPos or Vector2.zero
	self._itemCo = lua_college_item.configDict[self._itemId]
	self._type = self._itemCo and self._itemCo.type
	self._clickParentView = self.viewParam and self.viewParam.clickParentView
	self._clickItem = self.viewParam and self.viewParam.clickItem

	self:refreshUI()
	self:setPosition()
end

function CollegeCurrencyTipsView:setPosition()
	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(self._screenPos, self._viewTran)

	anchorPosX = anchorPosX + TipsOffset.x
	anchorPosY = anchorPosY + TipsOffset.y

	recthelper.setAnchor(self._tranContainer, anchorPosX, anchorPosY)
	gohelper.fitScreenOffset(self._tranContainer)
end

function CollegeCurrencyTipsView:refreshUI()
	self._txtName.text = self._itemCo and self._itemCo.name

	CollegeIconHelper.setItemIcon(self._itemId, self._imageIcon)

	local curItemNum = CollegeModel.instance:getItemCount(self._itemId)

	if self._itemCo then
		local maxItemNum = self._itemCo.max

		self._txtTotalNum.text = string.format("%s/%s", curItemNum, maxItemNum)

		local showAddInfo = self._type == CollegeEnum.ItemType.Resource

		gohelper.setActive(self._goAddContainer, showAddInfo)

		if self._itemCo then
			gohelper.setActive(self._goDescContainer, not string.nilorempty(self._itemCo))

			self._txtDesc.text = self._itemCo

			local haveAdd

			if (showAddInfo or nil) and self:refreshProduceInfo() then
				local comp = gohelper.onceAddComponent(self._goDescContainer, gohelper.Type_VerticalLayoutGroup)

				comp.padding.bottom = 20
			end
		end
	end
end

function CollegeCurrencyTipsView:refreshProduceInfo()
	local allValue, produceInfoList = CollegeAttrHelper.getAllProduceInfo(self._itemId)

	gohelper.setActive(self._goAddContainer, allValue > 0)

	if allValue <= 0 then
		return false
	end

	self._txtNum.text = allValue

	gohelper.CreateObjList(self, self._refreshProduceItem, produceInfoList, self._goAdd, self._goAddItem)

	return true
end

function CollegeCurrencyTipsView:_refreshProduceItem(goItem, produceInfo, index)
	local txtDesc = gohelper.findChildText(goItem, "txt_desc")
	local txtNum = gohelper.findChildText(goItem, "txt_num")

	txtDesc.text = produceInfo.name
	txtNum.text = string.format("+%s", produceInfo.value)
end

function CollegeCurrencyTipsView:_onTouchScreen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local mousePosition = GamepadController.instance:getMousePosition()

	if self._clickParentView then
		local currencyItemList = self._clickParentView:getCurrencyItemList()

		if not self._clickParentView then
			self:closeThis()

			return
		end

		for _, currencyItem in ipairs(self._clickParentView) do
			if currencyItem:isMouseOverGo(mousePosition) then
				if currencyItem == self._clickItem then
					self:closeThis()
				else
					currencyItem:_btnClickOnClick()
				end

				return
			end
		end

		if gohelper.isMouseOverGo(self._bgTran, mousePosition) then
			return
		end

		if GuideController.instance:isAnyGuideRunning() then
			TaskDispatcher.cancelTask(self.closeThis, self)
			TaskDispatcher.runDelay(self.closeThis, self, 0.01)

			return
		end

		self:closeThis()
	end
end

function CollegeCurrencyTipsView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function CollegeCurrencyTipsView:onDestroyView()
	return
end

return CollegeCurrencyTipsView
