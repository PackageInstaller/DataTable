-- chunkname: @modules/logic/rouge2/map/view/store/Rouge2_MapStoreStealChoiceItem.lua

module("modules.logic.rouge2.map.view.store.Rouge2_MapStoreStealChoiceItem", package.seeall)

local Rouge2_MapStoreStealChoiceItem = class("Rouge2_MapStoreStealChoiceItem", LuaCompBase)

function Rouge2_MapStoreStealChoiceItem:init(go)
	self.go = go
	self._txtTitle = gohelper.findChildText(self.go, "txt_Title")
	self._txtDesc = gohelper.findChildText(self.go, "scroll_Desc/Viewport/Content/txt_Desc")
	self._imageIcon = gohelper.findChildImage(self.go, "image_Icon")
	self._goSelected = gohelper.findChild(self.go, "go_Selected")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")
	self._btnClick2 = gohelper.findChildClickWithDefaultAudio(self.go, "scroll_Desc/Viewport/Content/txt_Desc")
end

function Rouge2_MapStoreStealChoiceItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick2:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectStoreChoice, self._onSelectStoreChoice, self)
end

function Rouge2_MapStoreStealChoiceItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
end

function Rouge2_MapStoreStealChoiceItem:_btnClickOnClick()
	if not self._isSelect then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectStoreChoice, self._choiceId)

		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onConfirmStoreChoice, self._choiceId)
end

function Rouge2_MapStoreStealChoiceItem:refresh(choiceId, index)
	self._choiceId = choiceId
	self._index = index
	self._isSelect = false

	self:refreshUI()
end

function Rouge2_MapStoreStealChoiceItem:refreshUI()
	local titleConstId = Rouge2_MapEnum.StoreStealFialChoiceTitle[self._choiceId]
	local descConstId = Rouge2_MapEnum.StoreStealFialChoiceDesc[self._choiceId]
	local titleConstCo = lua_rouge2_const.configDict[titleConstId]
	local descConstCo = lua_rouge2_const.configDict[descConstId]

	if titleConstCo then
		self._txtTitle.text = titleConstCo.value2 or ""
	end

	self._txtDesc.text = descConstCo and Rouge2_ItemDescHelper.buildDesc(descConstCo.value2) or ""

	local iconName = Rouge2_MapEnum.StoreStealFialChoiceIcon[self._choiceId]

	UISpriteSetMgr.instance:setRouge7Sprite(self._imageIcon, iconName)
	gohelper.setActive(self._goSelected, self._isSelect)
end

function Rouge2_MapStoreStealChoiceItem:_onSelectStoreChoice(choiceId)
	self._isSelect = choiceId == self._choiceId

	gohelper.setActive(self._goSelected, self._isSelect)
end

function Rouge2_MapStoreStealChoiceItem:onDestroy()
	return
end

return Rouge2_MapStoreStealChoiceItem
