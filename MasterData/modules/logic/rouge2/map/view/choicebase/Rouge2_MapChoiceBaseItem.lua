-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapChoiceBaseItem.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapChoiceBaseItem", package.seeall)

local Rouge2_MapChoiceBaseItem = class("Rouge2_MapChoiceBaseItem", UserDataDispose)

function Rouge2_MapChoiceBaseItem:init(go)
	self:__onInit()

	self.go = go
	self.tr = go:GetComponent(gohelper.Type_RectTransform)

	self:_editableInitView()
end

function Rouge2_MapChoiceBaseItem:_editableInitView()
	self.animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._golocked = gohelper.findChild(self.go, "#go_locked")
	self._imagelockbg = gohelper.findChildImage(self.go, "#go_locked/bg")
	self._txtlocktitle = gohelper.findChildText(self.go, "#go_locked/#txt_locktitle")
	self._txtlockdesc = gohelper.findChildText(self.go, "#go_locked/#txt_lockdesc")
	self._txtlocktip = gohelper.findChildText(self.go, "#go_locked/#txt_locktip")
	self._imagelockshape = gohelper.findChildImage(self.go, "#go_locked/#image_TitleShape")
	self.goLockTip = self._txtlocktip.gameObject
	self._btnlockdisplay = gohelper.findChildButtonWithAudio(self.go, "#go_locked/#btn_lockdisplay")
	self._simagelockdisplay = gohelper.findChildSingleImage(self.go, "#go_locked/#btn_lockdisplay/#simage_lockdisplay")
	self._goAttr3 = gohelper.findChild(self.go, "#go_locked/#go_Attr3")
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._imagenormalbg = gohelper.findChildImage(self.go, "#go_normal/bg")
	self._txtnormaltitle = gohelper.findChildText(self.go, "#go_normal/#txt_normaltitle")
	self._txtnormaldesc = gohelper.findChildText(self.go, "#go_normal/#txt_normaldesc")
	self._txtnormaltip = gohelper.findChildText(self.go, "#go_normal/#txt_normaltip")
	self._imagenormalshape = gohelper.findChildImage(self.go, "#go_normal/#image_TitleShape")
	self._gocheck1 = gohelper.findChild(self.go, "#go_normal/#go_check1")
	self._btnnormaldisplay = gohelper.findChildButtonWithAudio(self.go, "#go_normal/#btn_normaldisplay")
	self._simagenormaldisplay = gohelper.findChildSingleImage(self.go, "#go_normal/#btn_normaldisplay/#simage_normaldisplay")
	self._goAttr1 = gohelper.findChild(self.go, "#go_normal/#go_Attr1")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._imageselectbg = gohelper.findChildImage(self.go, "#go_select/bg")
	self._txtselecttitle = gohelper.findChildText(self.go, "#go_select/#txt_selecttitle")
	self._txtselectdesc = gohelper.findChildText(self.go, "#go_select/#txt_selectdesc")
	self._txtselecttip = gohelper.findChildText(self.go, "#go_select/#txt_selecttip")
	self._imageselectshape = gohelper.findChildImage(self.go, "#go_select/#image_TitleShape")
	self._gocheck2 = gohelper.findChild(self.go, "#go_select/#go_check2")
	self._btnselectdisplay = gohelper.findChildButtonWithAudio(self.go, "#go_select/#btn_selectdisplay")
	self._simageselectdisplay = gohelper.findChildSingleImage(self.go, "#go_select/#btn_selectdisplay/#simage_selectdisplay")
	self._goAttr2 = gohelper.findChild(self.go, "#go_select/#go_Attr2")

	SkillHelper.addHyperLinkClick(self._txtnormaldesc, self._hyperLinkClickCallback, self)
	SkillHelper.addHyperLinkClick(self._txtselectdesc, self._hyperLinkClickCallback, self)

	self.click = gohelper.getClickWithAudio(self.go, AudioEnum.Rouge2.ClickChoice)

	self.click:AddClickListener(self.tryClickSelf, self)

	self.normalDescClick = gohelper.getClickWithDefaultAudio(self._txtnormaldesc.gameObject)

	self.normalDescClick:AddClickListener(self.tryClickSelf, self)

	self.selectDescClick = gohelper.getClickWithDefaultAudio(self._txtselectdesc.gameObject)

	self.selectDescClick:AddClickListener(self.tryClickSelf, self)
	self._btnlockdisplay:AddClickListener(self.tryShowDisplay, self)
	self._btnnormaldisplay:AddClickListener(self.tryShowDisplay, self)
	self._btnselectdisplay:AddClickListener(self.tryShowDisplay, self)
	gohelper.setActive(self._gocheck1, false)
	gohelper.setActive(self._gocheck2, false)

	self._goAttrList = gohelper.findChild(self.go, "#go_AttrList")
	self._imageAttrItem = gohelper.findChild(self.go, "#go_AttrList/#image_AttrItem")

	gohelper.setActive(self._goAttrList, false)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceItemStatusChange, self.onStatusChange, self)
end

function Rouge2_MapChoiceBaseItem:onStatusChange(choiceId)
	return
end

function Rouge2_MapChoiceBaseItem:tryClickSelf()
	local canClick = self:checkCanClick()

	if not canClick then
		return
	end

	self:onClickSelf()
end

function Rouge2_MapChoiceBaseItem:checkCanClick()
	return not self._isClickHyperLink
end

function Rouge2_MapChoiceBaseItem:onClickSelf()
	return
end

function Rouge2_MapChoiceBaseItem:onSelectAnimDone()
	return
end

function Rouge2_MapChoiceBaseItem:update(index)
	self._index = index
	self._shapeImgIndex = self._index % 3
	self.go.name = self._index

	UISpriteSetMgr.instance:setRouge6Sprite(self._imagelockshape, "rouge2_choice_shape" .. self._shapeImgIndex)
	UISpriteSetMgr.instance:setRouge6Sprite(self._imagenormalshape, "rouge2_choice_shape" .. self._shapeImgIndex)
	UISpriteSetMgr.instance:setRouge6Sprite(self._imageselectshape, "rouge2_choice_shape" .. self._shapeImgIndex)
end

function Rouge2_MapChoiceBaseItem:canShowNormalUI()
	return self.status == Rouge2_MapEnum.ChoiceStatus.Normal or self.status == Rouge2_MapEnum.ChoiceStatus.UnSelect
end

function Rouge2_MapChoiceBaseItem:canShowLockUI()
	return self.status == Rouge2_MapEnum.ChoiceStatus.Lock
end

function Rouge2_MapChoiceBaseItem:canShowSelectUI()
	return self.status == Rouge2_MapEnum.ChoiceStatus.Select
end

function Rouge2_MapChoiceBaseItem:refreshUI()
	self:refreshBg()
	self:refreshLockUI()
	self:refreshNormalUI()
	self:refreshSelectUI()
end

function Rouge2_MapChoiceBaseItem:refreshBg()
	return
end

function Rouge2_MapChoiceBaseItem:refreshLockUI()
	local show = self:canShowLockUI()

	gohelper.setActive(self._golocked, show)

	if show then
		self._txtlocktitle.text = self.title
		self._txtlockdesc.text = self.desc
		self._txtlocktip.text = self.tip

		self:refreshAttrList(self._goAttr3)
		self:showDisplayItem(self._btnlockdisplay, self._simagelockdisplay)
		gohelper.setActive(self.goLockTip, not string.nilorempty(self.tip))
	end
end

function Rouge2_MapChoiceBaseItem:refreshNormalUI()
	local show = self:canShowNormalUI()

	gohelper.setActive(self._gonormal, show)

	if show then
		self._txtnormaltitle.text = self.title
		self._txtnormaldesc.text = self.desc
		self._txtnormaltip.text = self.tip

		self:refreshAttrList(self._goAttr1)
		self:showDisplayItem(self._btnnormaldisplay, self._simagenormaldisplay)

		if self.status == Rouge2_MapEnum.ChoiceStatus.Normal then
			local anim = self._isOpening and "open" or "normal"

			self.animator:Play(anim, 0, 0)

			self._isOpening = false
		else
			self.animator:Play("unselect", 0, 0)
		end
	end
end

function Rouge2_MapChoiceBaseItem:refreshSelectUI()
	local show = self:canShowSelectUI()

	gohelper.setActive(self._goselect, show)

	if show then
		self._txtselecttitle.text = self.title
		self._txtselectdesc.text = self.desc
		self._txtselecttip.text = self.tip

		self:refreshAttrList(self._goAttr2)
		self:showDisplayItem(self._btnselectdisplay, self._simageselectdisplay)
	end
end

function Rouge2_MapChoiceBaseItem:clearCallback()
	if self.callbackId then
		Rouge2_Rpc.instance:removeCallbackById(self.callbackId)

		self.callbackId = nil
	end
end

function Rouge2_MapChoiceBaseItem:show()
	gohelper.setActive(self.go, true)

	self._isOpening = true
end

function Rouge2_MapChoiceBaseItem:hide()
	gohelper.setActive(self.go, false)
end

function Rouge2_MapChoiceBaseItem:_hyperLinkClickCallback(itemId)
	itemId = tonumber(itemId)

	local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)

	if not itemCo then
		return
	end

	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

	self._isClickHyperLink = true
	self._openHyperLinkViewName = Rouge2_BackpackHelper.itemType2ShowViewName(itemType)

	self:showItemTipsView({
		itemId
	})
end

function Rouge2_MapChoiceBaseItem:showDisplayItem(btn, simageIcon)
	if self.display then
		local display = self.display ~= 0

		gohelper.setActive(btn.gameObject, display)

		if not display then
			return
		end

		Rouge2_IconHelper.setGameItemIcon(self.display, simageIcon)
	end
end

function Rouge2_MapChoiceBaseItem:tryShowDisplay()
	self:showItemTipsView({
		self.display
	})
end

function Rouge2_MapChoiceBaseItem:showItemTipsView(itemIdList)
	if not itemIdList or #itemIdList <= 0 then
		return
	end

	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemIdList[1])
	local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(itemType)

	ViewMgr.instance:openView(showViewName, {
		viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Tips,
		dataType = Rouge2_Enum.ItemDataType.Config,
		itemList = itemIdList
	})
end

function Rouge2_MapChoiceBaseItem:_onCloseViewFinish(viewName)
	if self._isClickHyperLink and self._openHyperLinkViewName == viewName then
		self._isClickHyperLink = false
		self._openHyperLinkViewName = nil
	end
end

function Rouge2_MapChoiceBaseItem:refreshAttrList(goRoot)
	if self.attrList then
		if not #self.attrList then
			local attrNum = 0

			if attrNum <= 0 or attrNum > Rouge2_MapEnum.MaxChoiceAttrNum then
				gohelper.setActive(self._goAttrList, false)

				return
			end

			gohelper.addChild(goRoot, self._goAttrList)
			gohelper.setActive(self._goAttrList, true)
			gohelper.CreateObjList(self, self._refreshAttrItem, self.attrList, self._goAttrList, self._imageAttrItem.gameObject)
		end
	end
end

function Rouge2_MapChoiceBaseItem:_refreshAttrItem(obj, attrId, index)
	local imageIcon = gohelper.findChildComponent(obj, "", gohelper.Type_Image)
	local goRecommend = gohelper.findChild(obj, "#go_Recommand_light")

	Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon, Rouge2_Enum.AttrIconSuffix.CircleBg)

	local careerId = Rouge2_Model.instance:getCareerId()
	local isRecommend = Rouge2_BackpackController.instance:isAttrRecommend(careerId, attrId)

	gohelper.setActive(goRecommend, isRecommend)
end

function Rouge2_MapChoiceBaseItem:dispatchAttrLightEvent()
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.onLightAttr, self.attrList)
end

function Rouge2_MapChoiceBaseItem:destroy()
	TaskDispatcher.cancelTask(self.onSelectAnimDone, self)
	self.click:RemoveClickListener()
	self.normalDescClick:RemoveClickListener()
	self.selectDescClick:RemoveClickListener()
	self._btnlockdisplay:RemoveClickListener()
	self._btnnormaldisplay:RemoveClickListener()
	self._btnselectdisplay:RemoveClickListener()
	self._simagelockdisplay:UnLoadImage()
	self._simagenormaldisplay:UnLoadImage()
	self._simageselectdisplay:UnLoadImage()
	self:clearCallback()
	self:__onDispose()
end

return Rouge2_MapChoiceBaseItem
