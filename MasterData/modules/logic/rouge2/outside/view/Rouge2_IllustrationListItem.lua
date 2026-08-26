-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationListItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationListItem", package.seeall)

local Rouge2_IllustrationListItem = class("Rouge2_IllustrationListItem", ListScrollCellExtend)

function Rouge2_IllustrationListItem:onInitView()
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goUnlocked = gohelper.findChild(self.viewGO, "#go_Unlocked")
	self._simageItemPic = gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/#simage_ItemPic")
	self._goItemMask = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_ItemMask")
	self._goPieces = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_Pieces")
	self._go2 = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_Pieces/#go_2")
	self._go3 = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_Pieces/#go_3")
	self._go4 = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_Pieces/#go_4")
	self._go5 = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_Pieces/#go_5")
	self._goItemFrame = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_ItemFrame")
	self._gonew = gohelper.findChild(self.viewGO, "#go_Unlocked/#go_new")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Unlocked/#txt_Name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Unlocked/#btn_click")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtUnknown = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_Unknown")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_IllustrationListItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnIllustrationScrollViewValueChanged, self.onScrollValueChanged, self)
end

function Rouge2_IllustrationListItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnIllustrationScrollViewValueChanged, self.onScrollValueChanged, self)
end

function Rouge2_IllustrationListItem:_btnclickOnClick()
	local param = {}

	param.config = self._mo
	param.displayType = Rouge2_OutsideEnum.IllustrationDetailType.Illustration

	Rouge2_ViewHelper.openRougeIllustrationDetailView(param)
end

function Rouge2_IllustrationListItem:_editableInitView()
	gohelper.setActive(self._goSelected, false)

	self._click = gohelper.getClickWithDefaultAudio(self._goLocked, self)

	self._click:AddClickListener(self._onClick, self)

	self._pieceParentList = self:getUserDataTb_()
	self._pieceItemListDic = self:getUserDataTb_()

	local childCount = self._goPieces.transform.childCount

	for i = 1, childCount do
		local itemParent = self._goPieces.transform:GetChild(i - 1)

		self._pieceParentList[i + 1] = itemParent.gameObject

		local pieceCount = itemParent.childCount
		local pieceItemList = self:getUserDataTb_()

		self._pieceItemListDic[i + 1] = pieceItemList

		for j = 1, pieceCount do
			local pieceItemGo = itemParent:GetChild(j - 1).gameObject

			table.insert(pieceItemList, pieceItemGo)
		end
	end

	self._aniamtor = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_IllustrationListItem:_onClick()
	GameFacade.showToast(ToastEnum.RougeIllustrationLockTip)
end

function Rouge2_IllustrationListItem:_editableAddEvents()
	return
end

function Rouge2_IllustrationListItem:_editableRemoveEvents()
	return
end

function Rouge2_IllustrationListItem:onScrollValueChanged()
	self:checkRedDot()
end

function Rouge2_IllustrationListItem:onUpdateMO(mo)
	self._mo = mo.config

	Rouge2_IconHelper.setRougeIllustrationSmallIcon(self._mo.id, self._simageItemPic)

	self._txtName.text = self._mo.nameOther

	if UnityEngine.Time.frameCount - Rouge2_IllustrationListModel.instance.startFrameCount < 10 then
		self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

		self._aniamtor:Play("open")
	end

	local isUnlock = Rouge2_OutsideModel.instance:passedAnyEventId(mo.eventIdList)

	gohelper.setActive(self._goUnlocked, isUnlock)
	gohelper.setActive(self._goLocked, not isUnlock)

	if isUnlock then
		self:_updateNewFlag()
	else
		gohelper.setActive(self._gonew, false)
	end

	if isUnlock then
		self:refreshPiece(mo.eventIdList)
	end
end

function Rouge2_IllustrationListItem:refreshPiece(eventIdList)
	local count = #eventIdList
	local havePiece = count > 1

	gohelper.setActive(self._goPieces, havePiece)

	if not havePiece then
		return
	end

	for index, item in pairs(self._pieceParentList) do
		gohelper.setActive(item, index == count)
	end

	local itemList = self._pieceItemListDic[count]

	for i, eventId in ipairs(eventIdList) do
		local isUnlock = Rouge2_OutsideModel.instance:passedEventId(eventId)
		local item = itemList[i]

		gohelper.setActive(item, not isUnlock)
	end
end

function Rouge2_IllustrationListItem:_updateNewFlag()
	self._reddotComp = Rouge2_OutsideRedDotComp.Get(self._gonew, self.viewGO, Rouge2_IllustrationListModel.instance:getScrollGO())

	self._reddotComp:intReddotInfo(RedDotEnum.DotNode.V3a2_Rouge_Review_Illustration, self._mo.id, Rouge2_OutsideEnum.LocalData.Illustration)
end

function Rouge2_IllustrationListItem:checkRedDot()
	if self._reddotComp and self._reddotComp._isDotShow then
		local showNew = self._reddotComp:refresh()

		if showNew then
			self._aniamtor:Play("unlock", 0, 0)
		else
			self._aniamtor:Play("open", 0, 0)
		end
	end
end

function Rouge2_IllustrationListItem:onSelect(isSelect)
	return
end

function Rouge2_IllustrationListItem:onDestroyView()
	if self._click then
		self._click:RemoveClickListener()
	end
end

return Rouge2_IllustrationListItem
