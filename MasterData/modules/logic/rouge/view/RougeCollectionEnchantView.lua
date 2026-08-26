-- chunkname: @modules/logic/rouge/view/RougeCollectionEnchantView.lua

module("modules.logic.rouge.view.RougeCollectionEnchantView", package.seeall)

local RougeCollectionEnchantView = class("RougeCollectionEnchantView", BaseView)

function RougeCollectionEnchantView:onInitView()
	self._gotips = gohelper.findChild(self.viewGO, "left/#go_tips")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "left/#go_tips/#simage_icon")
	self._txtcollectionname = gohelper.findChildText(self.viewGO, "left/#go_tips/#txt_collectionname")
	self._gocollectiondesccontent = gohelper.findChild(self.viewGO, "left/#go_tips/#scroll_collectiondesc/Viewport/#go_collectiondesccontent")
	self._gocollectiondescitem = gohelper.findChild(self.viewGO, "left/#go_tips/#scroll_collectiondesc/Viewport/#go_collectiondesccontent/#go_collectiondescitem")
	self._gotags = gohelper.findChild(self.viewGO, "left/#go_tips/#go_tags")
	self._gotagitem = gohelper.findChild(self.viewGO, "left/#go_tips/#go_tags/#go_tagitem")
	self._goholetool = gohelper.findChild(self.viewGO, "left/#go_tips/#go_holetool")
	self._goholeitem = gohelper.findChild(self.viewGO, "left/#go_tips/#go_holetool/#go_holeitem")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_tips/#btn_last")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_tips/#btn_next")
	self._goshapecontainer = gohelper.findChild(self.viewGO, "left/#go_tips/#go_shapecontainer")
	self._goshapecell = gohelper.findChild(self.viewGO, "left/#go_tips/#go_shapecontainer/#go_shapecell")
	self._gounselected = gohelper.findChild(self.viewGO, "middle/#go_unselected")
	self._goenchantempty = gohelper.findChild(self.viewGO, "right/#go_enchantempty")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "middle/#scroll_desc")
	self._simageenchanticon = gohelper.findChildSingleImage(self.viewGO, "middle/#simage_enchanticon")
	self._goenchantcontent = gohelper.findChild(self.viewGO, "middle/#scroll_desc/Viewport/#go_enchantcontent")
	self._txtenchantdesc = gohelper.findChildText(self.viewGO, "middle/#scroll_desc/Viewport/#go_enchantcontent/#txt_enchantdesc")
	self._txtname = gohelper.findChildText(self.viewGO, "middle/#txt_name")
	self._gotagcontents = gohelper.findChild(self.viewGO, "left/#go_tips/#go_tagcontents")
	self._gotagnameitem = gohelper.findChild(self.viewGO, "left/#go_tips/#go_tagcontents/#go_tagnameitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionEnchantView:addEvents()
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function RougeCollectionEnchantView:removeEvents()
	self._btnlast:RemoveClickListener()
	self._btnnext:RemoveClickListener()
end

local disInteractableBtnAlpha = 0.3
local interactableBtnAlpha = 1

function RougeCollectionEnchantView:_btnlastOnClick()
	RougeCollectionEnchantController.instance:switchCollection(false)
	self:updateSwitchBtnState()
	self:delay2RefreshInfo(RougeCollectionEnchantView.DelayRefreshInfoTime)
	self._tipAnimator:Play("switch", 0, 0)
end

function RougeCollectionEnchantView:_btnnextOnClick()
	RougeCollectionEnchantController.instance:switchCollection(true)
	self:updateSwitchBtnState()
	self:delay2RefreshInfo(RougeCollectionEnchantView.DelayRefreshInfoTime)
	self._tipAnimator:Play("switch", 0, 0)
end

function RougeCollectionEnchantView:updateSwitchBtnState()
	local curSelectIndex = RougeCollectionUnEnchantListModel.instance:getCurSelectIndex()
	local totalCollectionCount = RougeCollectionUnEnchantListModel.instance:getCount()
	local lastbtnCanvasGroup = gohelper.onceAddComponent(self._btnlast, typeof(UnityEngine.CanvasGroup))
	local isCurFirstCollection = curSelectIndex <= 1

	if isCurFirstCollection then
		lastbtnCanvasGroup.alpha = disInteractableBtnAlpha or interactableBtnAlpha
	end

	lastbtnCanvasGroup.interactable = not isCurFirstCollection
	lastbtnCanvasGroup.blocksRaycasts = not isCurFirstCollection

	local nextBtnCanvasGroup = gohelper.onceAddComponent(self._btnnext, typeof(UnityEngine.CanvasGroup))
	local isCurLastCollection = totalCollectionCount <= curSelectIndex

	if isCurLastCollection then
		nextBtnCanvasGroup.alpha = disInteractableBtnAlpha or interactableBtnAlpha
	end

	nextBtnCanvasGroup.interactable = not isCurLastCollection
	nextBtnCanvasGroup.blocksRaycasts = not isCurLastCollection
end

function RougeCollectionEnchantView:_btndetailsOnClick()
	RougeCollectionModel.instance:switchCollectionInfoType()
end

function RougeCollectionEnchantView:_editableInitView()
	self.addEventCb(self, RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, self.updateCollectionEnchantInfo, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)

	self._cellModelTab = self:getUserDataTb_()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._tipAnimator = gohelper.onceAddComponent(self._gotips, gohelper.Type_Animator)
	self._itemInstTab = self:getUserDataTb_()
end

function RougeCollectionEnchantView:onOpen()
	if self.viewParam then
		if self.viewParam then
			local collectionIds = self.viewParam.collectionIds

			if self.viewParam then
				local selectHoleIndex = self.viewParam.selectHoleIndex

				RougeCollectionEnchantController.instance:onOpenView(self.viewParam, collectionIds, selectHoleIndex)
				self:refreshCollectionTips()
				self:updateSwitchBtnState()
			end
		end
	end
end

function RougeCollectionEnchantView:refreshCollectionTips()
	local collectionId = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	self:refresh(collectionId)
end

function RougeCollectionEnchantView:refresh(collectionId)
	collectionId = collectionId or RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		logError("cannot find collection, id = " .. tostring(collectionId))

		return
	end

	local collectionCfgId = collectionMO.cfgId
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	self:refreshCollectionBaseInfo(collectionMO)

	local enchantCfgIds = collectionMO:getAllEnchantCfgId()

	RougeCollectionHelper.loadCollectionAndEnchantTags(collectionCfgId, enchantCfgIds, self._gotags, self._gotagitem)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(collectionCfgId, enchantCfgIds, self._gotagcontents, self._gotagnameitem, RougeCollectionHelper._loadCollectionTagNameCallBack, RougeCollectionHelper)
	RougeCollectionHelper.loadShapeGrid(collectionMO.cfgId, self._goshapecontainer, self._goshapecell, self._cellModelTab, false)
	self:refreshCollectionHoles(collectionCfg, collectionMO)
	self:checkIsSelectEnchant()
end

function RougeCollectionEnchantView:refreshCollectionBaseInfo(collectionMO)
	if not collectionMO then
		return
	end

	local enchantCfgIds = collectionMO:getAllEnchantCfgId()

	self._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(collectionMO.cfgId, enchantCfgIds)

	RougeCollectionDescHelper.setCollectionDescInfos(collectionMO.id, self._gocollectiondesccontent, self._itemInstTab)

	local iconUrl = RougeCollectionHelper.getCollectionIconUrl(collectionMO.cfgId)

	self._simageicon:LoadImage(iconUrl)
end

local maxHoleNum = 3

function RougeCollectionEnchantView:refreshCollectionHoles(collectionCfg, collectionMO)
	if not collectionCfg.holeNum then
		gohelper.setActive(self._goholetool, collectionCfg.holeNum > 0)

		local curSelectHoleIndex = RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex()

		for i = 1, maxHoleNum do
			local collectionItem = self:getOrCreateHole(i)
			local enchantId, enchantCfgId = collectionMO:getEnchantIdAndCfgId(i)
			local isEnchant = enchantId and enchantId > 0

			gohelper.setActive(collectionItem.viewGO, true)
			gohelper.setActive(collectionItem.golock, collectionCfg.holeNum < i)
			gohelper.setActive(collectionItem.goenchant, i <= collectionCfg.holeNum and isEnchant)
			gohelper.setActive(collectionItem.goselect, i == curSelectHoleIndex)
			gohelper.setActive(collectionItem.btnclick.gameObject, i <= collectionCfg.holeNum)
			gohelper.setActive(collectionItem.goadd, i <= collectionCfg.holeNum and not isEnchant)

			if isEnchant then
				collectionItem.icon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(enchantCfgId))
			end
		end
	end
end

function RougeCollectionEnchantView:getOrCreateHole(index)
	self._holeTab = self._holeTab or self:getUserDataTb_()

	local hole = self._holeTab[index]

	if not hole then
		hole = self:getUserDataTb_()
		hole.viewGO = gohelper.cloneInPlace(self._goholeitem, "hole_" .. index)
		hole.golock = gohelper.findChild(hole.viewGO, "go_lock")
		hole.goenchant = gohelper.findChild(hole.viewGO, "go_enchant")
		hole.btnremove = gohelper.findChildButtonWithAudio(hole.viewGO, "go_enchant/btn_remove")

		hole.btnremove:AddClickListener(self._btnremoveEnchantOnClick, self, index)

		hole.goselect = gohelper.findChild(hole.viewGO, "go_select")
		hole.goadd = gohelper.findChild(hole.viewGO, "go_add")
		hole.btnclick = gohelper.findChildButtonWithAudio(hole.viewGO, "btn_click")

		hole.btnclick:AddClickListener(self._btnclickHoleOnClick, self, index)

		hole.icon = gohelper.findChildSingleImage(hole.viewGO, "go_enchant/simage_icon")
		self._holeTab[index] = hole
	end

	return hole
end

function RougeCollectionEnchantView:_btnremoveEnchantOnClick(holeIndex)
	local curSelectCollectionId = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	RougeCollectionEnchantController.instance:removeEnchant(curSelectCollectionId, holeIndex)
end

function RougeCollectionEnchantView:_btnclickHoleOnClick(holeIndex)
	if self._holeTab then
		if self._holeTab then
			for index, hole in pairs(self._holeTab) do
				gohelper.setActive(hole.goselect, index == holeIndex)
			end

			RougeCollectionEnchantController.instance:onSelectHoleGrid(holeIndex)
		end
	end
end

function RougeCollectionEnchantView:updateCollectionEnchantInfo(collectionId)
	RougeCollectionEnchantListModel.instance:onInitData(false)
	RougeCollectionEnchantListModel.instance:onModelUpdate()

	local curSelectCollectionId = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	if collectionId ~= curSelectCollectionId then
		return
	end

	if self._isInitDone then
		self._animator:Play("switch", 0, 0)
		self:delay2RefreshInfo(RougeCollectionEnchantView.DelayRefreshInfoTime)
	else
		self:refresh()

		self._isInitDone = true
	end
end

RougeCollectionEnchantView.DelayRefreshInfoTime = 0.16

function RougeCollectionEnchantView:delay2RefreshInfo(delayTime)
	TaskDispatcher.cancelTask(self.refresh, self)
	TaskDispatcher.runDelay(self.refresh, self, delayTime or 0)
end

function RougeCollectionEnchantView:checkIsSelectEnchant()
	local enchantCount = RougeCollectionEnchantListModel.instance:getCount()
	local curSelectEnchantId = RougeCollectionEnchantListModel.instance:getCurSelectEnchantId()
	local enchantMO = RougeCollectionEnchantListModel.instance:getById(curSelectEnchantId)
	local hasSelectEnchant = enchantMO ~= nil

	gohelper.setActive(self._gounselected, not hasSelectEnchant)
	gohelper.setActive(self._scrolldesc.gameObject, hasSelectEnchant)
	gohelper.setActive(self._simageenchanticon.gameObject, hasSelectEnchant)
	gohelper.setActive(self._txtname.gameObject, hasSelectEnchant)
	gohelper.setActive(self._goenchantempty, enchantCount <= 0)

	if hasSelectEnchant then
		local enchantCfgId = enchantMO and enchantMO.cfgId
		local enchantCfg = RougeCollectionConfig.instance:getCollectionCfg(enchantCfgId)

		if enchantCfg then
			self._txtname.text = RougeCollectionConfig.instance:getCollectionName(enchantCfgId)

			self._simageenchanticon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(enchantCfgId))

			local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()

			RougeCollectionDescHelper.setCollectionDescInfos3(enchantCfgId, nil, self._txtenchantdesc, showTypes)
		end
	end
end

function RougeCollectionEnchantView:_onSwitchCollectionInfoType()
	self:refreshCollectionTips()
end

function RougeCollectionEnchantView:removeAllHoleClicks()
	if self._holeTab then
		for _, hole in pairs(self._holeTab) do
			hole.btnremove:RemoveClickListener()
			hole.btnclick:RemoveClickListener()
			hole.icon:UnLoadImage()
		end
	end
end

function RougeCollectionEnchantView:onClose()
	self:removeAllHoleClicks()
end

function RougeCollectionEnchantView:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simageenchanticon:UnLoadImage()
	TaskDispatcher.cancelTask(self.refresh, self)
end

return RougeCollectionEnchantView
