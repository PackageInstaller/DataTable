-- chunkname: @modules/logic/rouge/view/RougeCollectionTipView.lua

module("modules.logic.rouge.view.RougeCollectionTipView", package.seeall)

local RougeCollectionTipView = class("RougeCollectionTipView", BaseView)

function RougeCollectionTipView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_root/anim/#simage_icon")
	self._txtcollectionname = gohelper.findChildText(self.viewGO, "#go_root/anim/#txt_collectionname")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "#go_root/anim/#scroll_collectiondesc")
	self._godescContent = gohelper.findChild(self.viewGO, "#go_root/anim/#scroll_collectiondesc/Viewport/#go_descContent")
	self._godescitem = gohelper.findChild(self.viewGO, "#go_root/anim/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	self._gotags = gohelper.findChild(self.viewGO, "#go_root/anim/#go_tags")
	self._gotagitem = gohelper.findChild(self.viewGO, "#go_root/anim/#go_tags/#go_tagitem")
	self._goextratags = gohelper.findChild(self.viewGO, "#go_root/anim/tags/#go_extratags")
	self._goextratagitem = gohelper.findChild(self.viewGO, "#go_root/anim/tags/#go_extratags/#go_extratagitem")
	self._goholetool = gohelper.findChild(self.viewGO, "#go_root/anim/#go_holetool")
	self._goholeitem = gohelper.findChild(self.viewGO, "#go_root/anim/#go_holetool/#go_holeitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goshapecontainer = gohelper.findChild(self.viewGO, "#go_root/anim/#go_shapecontainer")
	self._goshapecell = gohelper.findChild(self.viewGO, "#go_root/anim/#go_shapecontainer/#go_shapecell")
	self._btnunequip = gohelper.findChildButton(self.viewGO, "#go_root/anim/#btn_unequip")
	self._gotips = gohelper.findChild(self.viewGO, "#go_root/anim/#go_tips")
	self._gotagdescitem = gohelper.findChild(self.viewGO, "#go_root/anim/#go_tips/#txt_tagitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnunequip:AddClickListener(self._btnunequipOnClick, self)
end

function RougeCollectionTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnunequip:RemoveClickListener()
end

function RougeCollectionTipView:_btncloseOnClick()
	self:closeThis()
end

function RougeCollectionTipView:_btnunequipOnClick()
	if self.viewParam then
		RougeCollectionChessController.instance:removeCollectionFromSlotArea(self.viewParam)
		self:closeThis()
		AudioMgr.instance:trigger(AudioEnum.UI.UnEquipCollection)
	end
end

function RougeCollectionTipView:_editableInitView()
	self.addEventCb(self, RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, self.updateCollectionEnchantInfo, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.SetCollectionTipViewInteractable, self.setViewInteractable, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.UpdateCollectionAttr, self.updateCollectionAttr, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)

	self._cellModelTab = self:getUserDataTb_()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._hooltoolCanvasGroup = gohelper.onceAddComponent(self._goholetool, gohelper.Type_CanvasGroup)
	self._rootCanvasGroup = gohelper.onceAddComponent(self._goroot, gohelper.Type_CanvasGroup)
end

function RougeCollectionTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_1)
	self:refreshCollectionInfos()
end

function RougeCollectionTipView:onUpdateParam()
	self:refreshCollectionInfos()
end

function RougeCollectionTipView:refreshCollectionInfos()
	if self.viewParam then
		if self.viewParam then
			local collectionCfgId = self.viewParam.collectionCfgId
			local targetPos = self:getViewPos()

			self._interactable = true
			self._useCloseBtn = true

			if self.viewParam and self.viewParam.interactable ~= nil then
				self._interactable = self.viewParam.interactable
			end

			if self.viewParam and self.viewParam.useCloseBtn ~= nil then
				self._useCloseBtn = self.viewParam.useCloseBtn
			end

			self:updateViewPosition(targetPos)
			self:refreshCollectionTips(self.viewParam, collectionCfgId)
			self:setInterable(self._interactable)
			self:setCloseBtnInteractable(self._useCloseBtn)
		end
	end
end

function RougeCollectionTipView:getViewPos()
	if self.viewParam then
		if self.viewParam then
			local openViewType = self.viewParam.source

			if openViewType ~= RougeEnum.OpenCollectionTipSource.ChoiceView then
				return self.viewParam
			end

			return recthelper.screenPosToAnchorPos(self.viewParam, self.viewGO.transform)
		end
	end
end

function RougeCollectionTipView:setCloseBtnInteractable(interactable)
	gohelper.setActive(self._btnclose.gameObject, interactable)
end

function RougeCollectionTipView:setInterable(interactable)
	self._hooltoolCanvasGroup.interactable = interactable
	self._hooltoolCanvasGroup.blocksRaycasts = interactable
end

function RougeCollectionTipView:updateViewPosition(targetPos)
	if targetPos then
		if not targetPos.x then
			local targetPosX = 0

			if targetPos then
				if not targetPos.y then
					local targetPosY = 0

					recthelper.setAnchor(self._goroot.transform, targetPosX, targetPosY)
				end
			end
		end
	end
end

function RougeCollectionTipView:refreshCollectionTips(collectionId, collectionCfgId)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if collectionMO then
		collectionCfgId = collectionMO.cfgId
	end

	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	self:refreshCollectionBaseInfo(collectionMO, collectionCfg)
	self:refreshCollectionHoles(collectionCfg, collectionMO)
	RougeCollectionHelper.loadShapeGrid(collectionCfgId, self._goshapecontainer, self._goshapecell, self._cellModelTab, false)

	local enchantCfgIds = collectionMO and collectionMO:getAllEnchantCfgId()

	RougeCollectionHelper.loadCollectionAndEnchantTags(collectionCfgId, enchantCfgIds, self._gotags, self._gotagitem)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(collectionCfgId, enchantCfgIds, self._gotips, self._gotagdescitem, RougeCollectionHelper._loadCollectionTagNameCallBack, RougeCollectionHelper)

	local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

	gohelper.setActive(self._btnunequip.gameObject, isInSlotArea and self._interactable)
end

local NormalDescContentHeight = 247
local NullHoleDescContentHeight = 420

function RougeCollectionTipView:refreshCollectionBaseInfo(collectionMO, collectionCfg)
	local enchantCfgIds = collectionMO and collectionMO:getAllEnchantCfgId()
	local collectionCfgId = collectionCfg and collectionCfg.id

	self._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(collectionCfgId, enchantCfgIds)

	local iconUrl = RougeCollectionHelper.getCollectionIconUrl(collectionCfgId)

	self._simageicon:LoadImage(iconUrl)

	self._itemInstTab = self._itemInstTab or self:getUserDataTb_()

	if collectionMO then
		RougeCollectionDescHelper.setCollectionDescInfos(collectionMO.id, self._godescContent, self._itemInstTab)
	else
		RougeCollectionDescHelper.setCollectionDescInfos2(collectionCfgId, enchantCfgIds, self._godescContent, self._itemInstTab, nil, {
			isAllActive = true
		})
	end

	if collectionCfg then
		if not collectionCfg.holeNum then
			local holeNum = 0

			if holeNum > 0 then
				if not NormalDescContentHeight then
					local effectContentHeight = NullHoleDescContentHeight

					recthelper.setHeight(self._scrollcollectiondesc.transform, effectContentHeight)
				end
			end
		end
	end
end

local maxHoleNum = 3

function RougeCollectionTipView:refreshCollectionHoles(collectionCfg, collectionMO)
	if not collectionCfg.holeNum then
		gohelper.setActive(self._goholetool, collectionCfg.holeNum > 0)

		for i = 1, maxHoleNum do
			local holeItem = self:getOrCreateHole(i)

			gohelper.setActive(holeItem.viewGO, true)
			gohelper.setActive(holeItem.golock, collectionCfg.holeNum < i)
			gohelper.setActive(holeItem.godisenchant, not self._interactable or not collectionMO)

			local isEnchant = false

			if collectionMO then
				local enchantId, enchantCfgId = collectionMO:getEnchantIdAndCfgId(i)

				isEnchant = enchantId and enchantId > 0

				if isEnchant then
					local iconUrl = RougeCollectionHelper.getCollectionIconUrl(enchantCfgId)

					holeItem.simageicon:LoadImage(iconUrl)
				end
			end

			gohelper.setActive(holeItem.goadd, i <= collectionCfg.holeNum and not isEnchant and self._interactable)
			gohelper.setActive(holeItem.goenchant, i <= collectionCfg.holeNum and isEnchant)
			gohelper.setActive(holeItem.btnremoveenchant.gameObject, i <= collectionCfg.holeNum and isEnchant and self._interactable)
			gohelper.setActive(holeItem.btnclick.gameObject, i <= collectionCfg.holeNum)
		end
	end
end

function RougeCollectionTipView:getOrCreateHole(index)
	self._holeTab = self._holeTab or self:getUserDataTb_()

	local hole = self._holeTab[index]

	if not hole then
		hole = self:getUserDataTb_()
		hole.viewGO = gohelper.cloneInPlace(self._goholeitem, "hole_" .. index)
		hole.godisenchant = gohelper.findChild(hole.viewGO, "go_disenchant")
		hole.goadd = gohelper.findChild(hole.viewGO, "go_add")
		hole.golock = gohelper.findChild(hole.viewGO, "go_lock")
		hole.goenchant = gohelper.findChild(hole.viewGO, "go_enchant")
		hole.btnclick = gohelper.findChildButtonWithAudio(hole.viewGO, "btn_click")

		hole.btnclick:AddClickListener(self._btnclickOnClick, self, index)

		hole.simageicon = gohelper.findChildSingleImage(hole.viewGO, "go_enchant/simage_icon")
		hole.btnremoveenchant = gohelper.findChildButtonWithAudio(hole.viewGO, "go_enchant/btn_remove")

		hole.btnremoveenchant:AddClickListener(self._btnRemoveEnchantOnClick, self, index)

		self._holeTab[index] = hole
	end

	return hole
end

function RougeCollectionTipView:_btnclickOnClick(holeIndex)
	if not self._interactable then
		return
	end

	if self.viewParam then
		local collectionId = self.viewParam.collectionId

		if collectionId and collectionId > 0 then
			self._selectCollectionId = collectionId
			self._selectHoleIndex = holeIndex
			self._waitCount = 1

			self._animatorPlayer:Play("switch", self.playSwitchAnimDoneCallBack, self)
		end
	end
end

function RougeCollectionTipView:_btnRemoveEnchantOnClick(holeIndex)
	if not self._interactable then
		return
	end

	if self.viewParam then
		local collectionId = self.viewParam.collectionId

		if collectionId and collectionId > 0 then
			RougeCollectionEnchantController.instance:removeEnchant(collectionId, holeIndex)
		end
	end
end

function RougeCollectionTipView:playSwitchAnimDoneCallBack()
	if not self._waitCount then
		self._waitCount = self._waitCount - 1

		self:checkIsCouldOpenEnchantView()
	end
end

function RougeCollectionTipView:checkIsCouldOpenEnchantView()
	if self._waitCount <= 0 then
		local collectionIds = self:getCollectionIds()
		local params = {
			collectionId = self._selectCollectionId,
			collectionIds = collectionIds,
			selectHoleIndex = self._selectHoleIndex
		}

		RougeController.instance:openRougeCollectionEnchantView(params)
	end
end

function RougeCollectionTipView:getCollectionIds()
	if self.viewParam then
		local collections = {}
		local sortFunc = self.sortCollectionFunction1

		if self.viewParam == RougeEnum.OpenCollectionTipSource.SlotArea then
			collections = RougeCollectionModel.instance:getSlotAreaCollection()
			sortFunc = self.sortCollectionFunction1
		elseif self.viewParam == RougeEnum.OpenCollectionTipSource.BagArea then
			collections = RougeCollectionModel.instance:getBagAreaCollection()
			sortFunc = self.sortCollectionFunction2
		end

		local collectionIds = {}

		if collections then
			for _, collection in ipairs(collections) do
				local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collection.cfgId)

				if collectionCfg then
					if not collectionCfg.holeNum then
						local holeNum = 0

						if holeNum > 0 then
							table.insert(collectionIds, collection.id)
						end
					end
				end
			end
		end

		table.sort(collectionIds, sortFunc)

		return collectionIds
	end
end

function RougeCollectionTipView.sortCollectionFunction1(aId, bId)
	local aMO = RougeCollectionModel.instance:getCollectionByUid(aId)
	local bMO = RougeCollectionModel.instance:getCollectionByUid(bId)
	local aCfgId = aMO and aMO.cfgId
	local bCfgId = bMO and bMO.cfgId
	local aCfg = RougeCollectionConfig.instance:getCollectionCfg(aCfgId)
	local bCfg = RougeCollectionConfig.instance:getCollectionCfg(bCfgId)

	if aCfg then
		if not aCfg.showRare then
			local aShowRare = 0

			if bCfg then
				if not bCfg.showRare then
					local bShowRare = 0

					if aShowRare ~= bShowRare then
						return bShowRare < aShowRare
					end

					local aShapeCellCount = RougeCollectionConfig.instance:getCollectionCellCount(aMO.cfgId, RougeEnum.CollectionEditorParamType.Shape)
					local bShapeCellCount = RougeCollectionConfig.instance:getCollectionCellCount(bMO.cfgId, RougeEnum.CollectionEditorParamType.Shape)

					if aShapeCellCount ~= bShapeCellCount then
						return bShapeCellCount < aShapeCellCount
					end

					return aId < bId
				end
			end
		end
	end
end

function RougeCollectionTipView.sortCollectionFunction2(aId, bId)
	local aMO = RougeCollectionModel.instance:getCollectionByUid(aId)
	local bMO = RougeCollectionModel.instance:getCollectionByUid(bId)
	local aCfgId = aMO and aMO.cfgId
	local bCfgId = bMO and bMO.cfgId
	local aCfg = RougeCollectionConfig.instance:getCollectionCfg(aCfgId)
	local bCfg = RougeCollectionConfig.instance:getCollectionCfg(bCfgId)

	if aCfg.type ~= bCfg.type and (aCfg.type == RougeEnum.CollectionType.Enchant or bCfg.type == RougeEnum.CollectionType.Enchant) then
		return aCfg.type == RougeEnum.CollectionType.Enchant
	end

	if aCfg then
		if not aCfg.showRare then
			local aShowRare = 0

			if bCfg then
				if not bCfg.showRare then
					local bShowRare = 0

					if aShowRare ~= bShowRare then
						return bShowRare < aShowRare
					end

					local aShapeCellCount = RougeCollectionConfig.instance:getCollectionCellCount(aMO.cfgId, RougeEnum.CollectionEditorParamType.Shape)
					local bShapeCellCount = RougeCollectionConfig.instance:getCollectionCellCount(bMO.cfgId, RougeEnum.CollectionEditorParamType.Shape)

					if aShapeCellCount ~= bShapeCellCount then
						return bShapeCellCount < aShapeCellCount
					end

					return aId < bId
				end
			end
		end
	end
end

function RougeCollectionTipView:updateCollectionEnchantInfo(collectionId)
	if self.viewParam then
		if not self.viewParam or self.viewParam ~= collectionId then
			return
		end

		self:refreshCollectionTips(collectionId)
	end
end

function RougeCollectionTipView:updateCollectionAttr(updateCollectionId)
	if self.viewParam then
		if self.viewParam == updateCollectionId then
			self:refreshCollectionTips(self.viewParam)
		end
	end
end

function RougeCollectionTipView:removeAllHoleClicks()
	if self._holeTab then
		for _, hole in pairs(self._holeTab) do
			hole.btnclick:RemoveClickListener()
			hole.btnremoveenchant:RemoveClickListener()
			hole.simageicon:UnLoadImage()
		end
	end
end

function RougeCollectionTipView:onCloseViewCallBack(viewName)
	if viewName == ViewName.RougeCollectionEnchantView then
		self._animatorPlayer:Play("back", self._onPlayBackAnimCallBack, self)
	end
end

function RougeCollectionTipView:_onPlayBackAnimCallBack()
	return
end

function RougeCollectionTipView:setViewInteractable(interactable)
	self._rootCanvasGroup.interactable = interactable
	self._rootCanvasGroup.blocksRaycasts = interactable
end

function RougeCollectionTipView:_onSwitchCollectionInfoType()
	self:refreshCollectionInfos()
end

function RougeCollectionTipView:onClose()
	self:removeAllHoleClicks()
end

function RougeCollectionTipView:onDestroyView()
	self._simageicon:UnLoadImage()

	if self._itemAttrCallBackId then
		RougeRpc.instance:removeCallbackById(self._itemAttrCallBackId)

		self._itemAttrCallBackId = nil
	end
end

return RougeCollectionTipView
