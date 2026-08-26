-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaHandbookView.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookView", package.seeall)

local AiZiLaHandbookView = class("AiZiLaHandbookView", BaseView)

function AiZiLaHandbookView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtItemNum = gohelper.findChildText(self.viewGO, "Left/ItemNum/#txt_ItemNum")
	self._imageItemIcon = gohelper.findChildImage(self.viewGO, "Left/#image_ItemIcon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Left/#txt_Title")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._goUnCollect = gohelper.findChild(self.viewGO, "Left/#go_UnCollect")
	self._scrollItems = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_Items")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaHandbookView:addEvents()
	return
end

function AiZiLaHandbookView:removeEvents()
	return
end

function AiZiLaHandbookView:_editableInitView()
	self._goLeft = gohelper.findChild(self.viewGO, "Left")
	self._animatorLeft = self._goLeft:GetComponent(AiZiLaEnum.ComponentType.Animator)
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	self._singleItemIcon = gohelper.findChildSingleImage(self.viewGO, "Left/#image_ItemIcon")
	self._unCollectHideList = self:getUserDataTb_()
	self._grayGoList = self:getUserDataTb_()

	local names = {
		"ItemNum",
		"image_TitleLIne",
		"#txt_Descr"
	}

	for i, name in ipairs(names) do
		table.insert(self._unCollectHideList, gohelper.findChild(self._goLeft, name))
	end

	local tempBg = gohelper.findChild(self.viewGO, "Left/ItemBG")
	local carray = tempBg:GetComponentsInChildren(gohelper.Type_Image, true)
	local tempList = {}

	RoomHelper.cArrayToLuaTable(carray, tempList)

	for i, comp in ipairs(tempList) do
		table.insert(self._grayGoList, comp.gameObject)
	end

	table.insert(self._grayGoList, self._imageItemIcon.gameObject)
end

function AiZiLaHandbookView:onUpdateParam()
	return
end

function AiZiLaHandbookView:playViewAnimator(animName)
	if self._animator then
		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaHandbookView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.closeThis, self)
	end

	local tAiZiLaHandbookListModel = AiZiLaHandbookListModel.instance

	tAiZiLaHandbookListModel:init()

	local mo = tAiZiLaHandbookListModel:getByIndex(1)

	if mo then
		tAiZiLaHandbookListModel:setSelect(mo.id)
	end

	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.SelectItem, self._onSelectItem, self)
	self:refreshUI()
	AiZiLaModel.instance:finishItemRed()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper3)
end

function AiZiLaHandbookView:onClose()
	return
end

function AiZiLaHandbookView:onDestroyView()
	TaskDispatcher.cancelTask(self._onDelayRefreshUI, self)
	self._singleItemIcon:UnLoadImage()
end

function AiZiLaHandbookView:_onSelectItem()
	if self._animatorLeft then
		if not self._isPlayLeftAnimIng then
			self._isPlayLeftAnimIng = true

			self._animatorLeft:Play(UIAnimationName.Switch, 0, 0)
			TaskDispatcher.runDelay(self._onDelayRefreshUI, self, 0.4)
		end
	else
		self:refreshUI()
	end
end

function AiZiLaHandbookView:_onDelayRefreshUI()
	self._isPlayLeftAnimIng = false

	self:refreshUI()
end

function AiZiLaHandbookView:refreshUI()
	local selectMO = AiZiLaHandbookListModel.instance:getSelectMO()

	gohelper.setActive(self._goLeft, selectMO)

	if selectMO then
		local quantity = selectMO:getQuantity()

		if self._lastQuantity ~= quantity then
			self._lastQuantity = quantity
			self._txtItemNum.text = formatLuaLang("materialtipview_itemquantity", quantity)
		end

		if self._lastItemId ~= selectMO.itemId then
			self._lastItemId = selectMO.itemId

			local isNotGray = AiZiLaModel.instance:isCollectItemId(self._lastItemId)
			local cfg = selectMO:getConfig()

			self._singleItemIcon:LoadImage(ResUrl.getV1a5AiZiLaItemIcon(cfg.icon))

			self._txtTitle.text = string.format(isNotGray and "%s" or "<color=#524D46>%s</color>", cfg.name)
			self._txtDescr.text = cfg.desc

			self:_refreshGray(not isNotGray)
		end
	end
end

function AiZiLaHandbookView:_refreshGray(isGray)
	local tempGray = not not isGray

	if self._lastGray ~= tempGray then
		for i, grayGo in ipairs(self._grayGoList) do
			self:_setGrayMode(grayGo, isGray)
		end

		for i, unCoGo in ipairs(self._unCollectHideList) do
			gohelper.setActive(unCoGo, not isGray)
		end

		gohelper.setActive(self._goUnCollect, isGray)
	end
end

function AiZiLaHandbookView:_setGrayMode(go, isGray)
	if isGray then
		ZProj.UGUIHelper.SetGrayFactor(go, 0.8)
	else
		ZProj.UGUIHelper.SetGrayscale(go, false)
	end
end

return AiZiLaHandbookView
