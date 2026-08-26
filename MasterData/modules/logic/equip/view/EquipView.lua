-- chunkname: @modules/logic/equip/view/EquipView.lua

module("modules.logic.equip.view.EquipView", package.seeall)

local EquipView = class("EquipView", BaseView)

function EquipView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "#scroll_category")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_center")
	self._gocentereffect = gohelper.findChild(self.viewGO, "#go_center/effect")
	self._simageequip = gohelper.findChildSingleImage(self.viewGO, "#go_center/#simage_equip")
	self._gostarList = gohelper.findChild(self.viewGO, "#go_center/#go_starList")
	self._scrollcostequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_costequip")
	self._scrollbreakequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_breakquip")
	self._gobreakequipcontent = gohelper.findChild(self.viewGO, "#scroll_breakquip/Viewport/Content")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_equip")
	self._scrollrefineequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_refine_equip")
	self._scrollcontent = gohelper.findChild(self.viewGO, "#scroll_refine_equip/viewport/scrollcontent")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_title/rare/#rare")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_title/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_title/#txt_name/#txt_nameen")
	self._animscrollequip = self._scrollequip:GetComponent(typeof(UnityEngine.Animator))
	self._animscrollrefineequip = self._scrollrefineequip:GetComponent(typeof(UnityEngine.Animator))
	self._animcenter = self._gocenter:GetComponent(typeof(UnityEngine.Animator))
	self._animtitle = self._gotitle:GetComponent(typeof(UnityEngine.Animator))
	self._goscrollArea = gohelper.findChild(self.viewGO, "#go_scrollArea")
	self._equipSlide = SLFramework.UGUI.UIDragListener.Get(self._goscrollArea)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipView:addEvents()
	self._equipSlide:AddDragBeginListener(self._onDragBegin, self)
	self._equipSlide:AddDragEndListener(self._onDragEnd, self)
end

function EquipView:removeEvents()
	self._equipSlide:RemoveDragBeginListener()
	self._equipSlide:RemoveDragEndListener()
end

EquipView.DragAbsPositionX = 30

function EquipView:initRightRopStatus()
	self._animgorighttop = self._gorighttop:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gorighttop, true)
	self._animgorighttop:Play("go_righttop_out", 0, 1)
end

function EquipView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getEquipBg("full/bg_equipbg.png"))

	self._rareLineColor = {
		"#DCF5D5",
		"#9EB7D7",
		"#7D5B7E",
		"#D2D79E",
		"#D6A181"
	}
	self._starList = self:getUserDataTb_()

	for i = 1, 6 do
		local starGO = gohelper.findChild(self._gostarList, "star" .. i)

		table.insert(self._starList, starGO)
	end

	self._breakCostItems = self:getUserDataTb_()

	gohelper.setActive(self._scrollequip.gameObject, false)
	gohelper.setActive(self._gocentereffect, false)

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.costEquipScrollAnim = self._scrollcostequip:GetComponent(typeof(UnityEngine.Animator))
	self.breakEquipScrollAnim = self._scrollbreakequip:GetComponent(typeof(UnityEngine.Animator))

	self:initRightRopStatus()
end

function EquipView:_onDragBegin(param, pointerEventData)
	if self.viewContainer:getIsOpenLeftBackpack() then
		return
	end

	self.startDragPosX = pointerEventData.position.x
end

function EquipView:_onDragEnd(param, pointerEventData)
	if self.viewContainer:getIsOpenLeftBackpack() then
		return
	end

	local endDragPosX = pointerEventData.position.x

	if math.abs(endDragPosX - self.startDragPosX) > EquipView.DragAbsPositionX then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)
		self:_onSlide(endDragPosX < self.startDragPosX)
	end
end

function EquipView:_onSlide(isSlideNext)
	local curEquipIndex = self:_getCurEquipIndex()

	curEquipIndex = isSlideNext and (curEquipIndex + 1 > GameUtil.getTabLen(self._allEquipList) and 1 or curEquipIndex + 1) or curEquipIndex - 1 <= 0 and GameUtil.getTabLen(self._allEquipList) or curEquipIndex - 1

	local targetMo = self._allEquipList[curEquipIndex]

	if targetMo ~= self._equipMO then
		local lastNormalEquip = EquipHelper.isNormalEquip(self._config)
		local targetNormalEquip = EquipHelper.isNormalEquip(targetMo.config)

		if lastNormalEquip ~= targetNormalEquip then
			if lastNormalEquip and EquipCategoryListModel.instance.curCategoryIndex ~= 4 then
				EquipCategoryListModel.instance.curCategoryIndex = 1
			end

			if targetNormalEquip and EquipCategoryListModel.instance.curCategoryIndex == 2 then
				EquipCategoryListModel.instance.curCategoryIndex = 4
			end
		end
	end

	self._equipMO = self._allEquipList[curEquipIndex]

	if self._equipMO then
		self._equipId = self._equipMO.config.id or self._equipMO.equipId
	end

	if self._equipMO then
		self._config = self._equipMO.config or EquipConfig.instance:getEquipCo(self._equipId)
	end

	self:destroyFlow()

	self.flow = FlowSequence.New()

	self.flow:addWork(DelayFuncWork.New(self.playTableViewCloseAnimation, self, EquipEnum.AnimationDurationTime))
	self.flow:addWork(DelayFuncWork.New(self._reSelectEquip, self))
	self.flow:registerDoneListener(self.endAnimBlock, self)
	self:startAnimBlock()
	self.flow:start()
end

function EquipView:_reSelectEquip()
	local param = {}

	param.equipMO = self._equipMO
	param.defaultTabIds = {
		[2] = EquipCategoryListModel.instance.curCategoryIndex
	}

	EquipController.instance:openEquipView(param)
end

function EquipView:startAnimBlock()
	UIBlockMgr.instance:startBlock("EquipAnimBlock")
end

function EquipView:endAnimBlock()
	UIBlockMgr.instance:endBlock("EquipAnimBlock")
end

function EquipView:destroyFlow()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end

	self:endAnimBlock()
end

function EquipView:_getCurEquipIndex()
	local curEquipIndex = 0

	for k, v in ipairs(self._allEquipList) do
		if v.uid == self._equipMO.uid then
			curEquipIndex = k
		end
	end

	return curEquipIndex
end

function EquipView:playTableViewCloseAnimation()
	self.viewContainer.tableView:playCloseAnimation()
end

function EquipView:onUpdateParam()
	self._equipMO = self.viewParam.equipMO

	if self._equipMO then
		self._equipId = self._equipMO.config.id or self.viewParam.equipId
	end

	if self._equipMO then
		self._config = self._equipMO.config or EquipConfig.instance:getEquipCo(self._equipId)
	end

	self:_refreshUI()
end

function EquipView:showStar()
	for i, star in pairs(self._starList) do
		gohelper.setActive(self._starList[i], i <= self._config.rare + 1)
	end
end

function EquipView:onOpen()
	self._equipMO = self.viewParam.equipMO

	if self._equipMO then
		self._equipId = self._equipMO.config.id or self.viewParam.equipId
	end

	if self._equipMO then
		self._config = self._equipMO.config or EquipConfig.instance:getEquipCo(self._equipId)
	end

	self.fromHandBook = self.viewParam.fromHandBook

	self:_refreshUI()
	self.addEventCb(self, EquipController.instance, EquipEvent.onChangeStrengthenScrollState, self.changeStrengthenScrollVisibleState, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onShowBreakCostListModelContainer, self.showBreakContainer, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onShowStrengthenListModelContainer, self.showStrengthenContainer, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onHideBreakAndStrengthenListModelContainer, self.hideStrengthenAndBreakContainer, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onCloseEquipStrengthenView, self.hideStrengthenAndBreakContainer, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onChangeRefineScrollState, self.changeRefineScrollVisibleState, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self.updateSlideEquipList, self)
	self:hideStrengthenAndBreakContainer()

	self._allEquipList = self.viewParam.equipList or EquipModel.instance:getEquips()

	NavigateMgr.instance:addEscape(ViewName.EquipView, self._onEscapeBtnClick, self)

	self._isShowRefineScroll = false
	self._isShowStrengthenScroll = false

	EquipChooseListModel.instance:openEquipView()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	self._viewAnim:Play(UIAnimationName.Open)
end

function EquipView:_onEscapeBtnClick()
	if self._isShowStrengthenScroll then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, false)
	elseif self._isShowRefineScroll then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false)
	else
		self:closeThis()
	end
end

function EquipView:_refreshUI()
	if self.viewParam.defaultTabIds then
		if not self.viewParam.defaultTabIds[2] then
			local tabIndex = 1

			transformhelper.setLocalPosXY(self._gocenter.transform, 0, 0)
			EquipCategoryListModel.instance:initCategory(self._equipMO, self._config)
			self.viewContainer._views[1]:selectCell(tabIndex, true)
			self._simageequip:LoadImage(ResUrl.getEquipSuit(self._config.icon))

			if self.fromHandBook and not HandbookModel.instance:haveEquip(self._config.id) then
				ZProj.UGUIHelper.SetGrayscale(self._simageequip.gameObject, true)
				gohelper.setActive(self._goscrollArea, false)
			else
				gohelper.setActive(self._goscrollArea, self._equipMO and self._equipId)
			end

			SLFramework.UGUI.GuiHelper.SetColor(self._imagerare, self._rareLineColor[self._config.rare])

			if not string.nilorempty(self._config.name) then
				self._txtname.text = self._config.name
				self._txtnameen.text = self._config.name_en
			else
				self._txtname.text = ""
				self._txtnameen.text = ""
			end

			self:showStar()
		end
	end
end

function EquipView:updateSlideEquipList()
	local equipList = {}
	local tempEquipMO

	for _, equipMO in ipairs(self._allEquipList) do
		tempEquipMO = EquipModel.instance:getEquip(equipMO.uid)

		if tempEquipMO then
			table.insert(equipList, tempEquipMO)
		end
	end

	self._allEquipList = equipList
end

function EquipView:playOpenStrengthenEquipScrollAnimator()
	self.viewContainer.equipStrengthenView:showScrollContainer()
	self._animscrollequip:Play("scroll_equip_in")
end

function EquipView:playCloseStrengthenEquipScrollAnimator()
	self.viewContainer.equipStrengthenView:hideScrollContainer()
	self._animscrollequip:Play("scroll_equip_out")
end

function EquipView:playOpenRefineEquipScrollAnimator()
	self.viewContainer.equipRefineView:showScrollContainer()
	self._animscrollrefineequip:Play("scroll_refine_equip_in")
end

function EquipView:playCloseRefineEquipScrollAnimator()
	self.viewContainer.equipRefineView:hideScrollContainer()
	self._animscrollrefineequip:Play("scroll_refine_equip_out")
end

function EquipView:playOpenCenterAndTitleAnimator()
	self._animtitle:Play("title_in")
	self._animcenter:Play("center_in")
end

function EquipView:playCloseCenterAndTitleAnimator()
	self._animtitle:Play("title_out")
	self._animcenter:Play("center_out")
end

function EquipView:showStrengthenScrollEquip()
	gohelper.setActive(self._scrollequip.gameObject, true)
	gohelper.setActive(self._scrollrefineequip.gameObject, false)
end

function EquipView:hideStrengthenScrollEquip()
	gohelper.setActive(self._scrollequip.gameObject, false)
end

function EquipView:showRefineScrollEquip()
	gohelper.setActive(self._scrollrefineequip.gameObject, true)
	gohelper.setActive(self._scrollequip.gameObject, false)
end

function EquipView:setStrengthenScrollVerticalNormalizedPosition(value)
	self._scrollequip.verticalNormalizedPosition = value
end

function EquipView:hideRefineScrollEquip()
	gohelper.setActive(self._scrollrefineequip.gameObject, false)
end

function EquipView:showCenterAndTitle()
	gohelper.setActive(self._gocenter, true)
	gohelper.setActive(self._gocentereffect, self._isClickRefine)
	gohelper.setActive(self._gotitle, true)
end

function EquipView:hideCenterAndTitle()
	gohelper.setActive(self._gocenter, false)
	gohelper.setActive(self._gocentereffect, false)
	gohelper.setActive(self._gotitle, false)
end

function EquipView:showTitleAndCenter()
	self._isShowStrengthenScroll = false
	self._isShowRefineScroll = false

	self:hideStrengthenScrollEquip()
	self:hideRefineScrollEquip()
	self:showCenterAndTitle()
	self:playOpenCenterAndTitleAnimator()
	self.viewContainer:setIsOpenLeftBackpack(false)
end

function EquipView:showStrengthenContainer()
	gohelper.setActive(self._scrollbreakequip.gameObject, false)
	gohelper.setActive(self._scrollcostequip.gameObject, true)
end

function EquipView:showBreakContainer(costItems)
	gohelper.setActive(self._scrollbreakequip.gameObject, true)
	gohelper.setActive(self._scrollcostequip.gameObject, false)

	for k, v in pairs(costItems) do
		local costItem = self._breakCostItems[k]

		if not costItem then
			costItem = IconMgr.instance:getCommonItemIcon(self._gobreakequipcontent)

			table.insert(self._breakCostItems, costItem)
		end

		local consume = string.splitToNumber(v, "#")
		local materilType, materilId, needquantity = consume[1], consume[2], consume[3]

		costItem:setMOValue(materilType, materilId, needquantity)
		costItem:setCountFontSize(38)
		costItem:setRecordFarmItem({
			type = materilType,
			id = materilId,
			quantity = needquantity
		})

		local countTxt = costItem:getCount()
		local quantity = ItemModel.instance:getItemQuantity(materilType, materilId)

		countTxt.text = needquantity <= quantity and tostring(GameUtil.numberDisplay(quantity)) .. "/" .. tostring(GameUtil.numberDisplay(needquantity)) or "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(quantity)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(needquantity))
	end
end

function EquipView:hideStrengthenAndBreakContainer()
	gohelper.setActive(self._scrollbreakequip.gameObject, false)
	gohelper.setActive(self._scrollcostequip.gameObject, false)
end

function EquipView:changeStrengthenScrollVisibleState(isShowStrengthenScroll)
	if self._isShowStrengthenScroll == isShowStrengthenScroll then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)

	self._isShowStrengthenScroll = isShowStrengthenScroll

	self.viewContainer:setIsOpenLeftBackpack(self._isShowStrengthenScroll)
	self:destroyFlow()

	self.flow = FlowSequence.New()

	if self._isShowStrengthenScroll then
		self.flow:addWork(DelayFuncWork.New(self.playCloseCenterAndTitleAnimator, self, EquipEnum.AnimationDurationTime))
		self.flow:addWork(DelayFuncWork.New(self.hideCenterAndTitle, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.showStrengthenScrollEquip, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.playOpenStrengthenEquipScrollAnimator, self, 0))
	else
		self.flow:addWork(DelayFuncWork.New(self.playCloseStrengthenEquipScrollAnimator, self, EquipEnum.AnimationDurationTime))
		self.flow:addWork(DelayFuncWork.New(self.hideStrengthenScrollEquip, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.showCenterAndTitle, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.playOpenCenterAndTitleAnimator, self, 0))
	end

	self.flow:start()
end

function EquipView:_clearClickRefine()
	self._isClickRefine = false
end

function EquipView:changeRefineScrollVisibleState(isShow, clickRefine)
	if self._isShowRefineScroll == isShow then
		return
	end

	self._isShowRefineScroll = isShow
	self._isClickRefine = clickRefine

	self.viewContainer:setIsOpenLeftBackpack(self._isShowRefineScroll)
	self:destroyFlow()

	self.flow = FlowSequence.New()

	if self._isShowRefineScroll then
		self.flow:addWork(DelayFuncWork.New(self.playCloseCenterAndTitleAnimator, self, EquipEnum.AnimationDurationTime))
		self.flow:addWork(DelayFuncWork.New(self.hideCenterAndTitle, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.showRefineScrollEquip, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.playOpenRefineEquipScrollAnimator, self, 0))
	else
		self.flow:addWork(DelayFuncWork.New(self.playCloseRefineEquipScrollAnimator, self, EquipEnum.AnimationDurationTime))
		self.flow:addWork(DelayFuncWork.New(self.hideRefineScrollEquip, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.showCenterAndTitle, self, 0))
		self.flow:addWork(DelayFuncWork.New(self.playOpenCenterAndTitleAnimator, self, 0))
		self.flow:addWork(DelayFuncWork.New(self._clearClickRefine, self, 0))
	end

	self.flow:start()
end

function EquipView:hideRefineScrollAndShowStrengthenScroll()
	self._isShowStrengthenScroll = true
	self._isShowRefineScroll = false

	self:destroyFlow()

	self.flow = FlowSequence.New()

	self.flow:addWork(DelayFuncWork.New(self.playCloseRefineEquipScrollAnimator, self, EquipEnum.AnimationDurationTime))
	self.flow:addWork(DelayFuncWork.New(self.showStrengthenScrollEquip, self, 0))
	self.flow:addWork(DelayFuncWork.New(self.playOpenStrengthenEquipScrollAnimator, self, 0))
	self.flow:start()
end

function EquipView:hideStrengthenScrollAndShowRefineScroll()
	self._isShowStrengthenScroll = false
	self._isShowRefineScroll = true

	self:destroyFlow()

	self.flow = FlowSequence.New()

	self.flow:addWork(DelayFuncWork.New(self.playCloseStrengthenEquipScrollAnimator, self, EquipEnum.AnimationDurationTime))
	self.flow:addWork(DelayFuncWork.New(self.showRefineScrollEquip, self, 0))
	self.flow:addWork(DelayFuncWork.New(self.playOpenRefineEquipScrollAnimator, self, 0))
	self.flow:start()
end

function EquipView:refreshRefineEquipList()
	local equipListCount = EquipRefineListModel.instance:getDataCount()
	local refineEquipListHeight = recthelper.getHeight(self._scrollcontent.transform)
	local refineEquipListPosY = recthelper.getAnchorY(self._scrollcontent.transform)
	local isBetweenLastLine = refineEquipListPosY <= refineEquipListHeight - 480 and refineEquipListPosY >= refineEquipListHeight - 700

	if equipListCount % 3 == 0 and isBetweenLastLine then
		self._scrollrefineequip.verticalNormalizedPosition = 0
	end
end

function EquipView:playCurrencyViewAnimation(animationName)
	self._animgorighttop:Play(animationName)
end

function EquipView:onClose()
	EquipChooseListModel.instance:clear()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	self:destroyFlow()
end

function EquipView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageequip:UnLoadImage()
end

return EquipView
