-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionItem", package.seeall)

local V1a6_CachotCollectionItem = class("V1a6_CachotCollectionItem", LuaCompBase)

function V1a6_CachotCollectionItem:init(go)
	self:__onInit()

	self.viewGO = go

	self:initComponents()
end

function V1a6_CachotCollectionItem:initComponents()
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_collection")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_normal/#simage_collection")
	self._imageframe = gohelper.findChildImage(self.viewGO, "#go_normal/#image_frame")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._gonotget = gohelper.findChild(self.viewGO, "#go_notget")
	self._gonew = gohelper.findChild(self.viewGO, "#go_normal/#go_new")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_normal/#go_select")
	self._canvasgroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
	self._anim = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function V1a6_CachotCollectionItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, self.onSelect, self)
end

function V1a6_CachotCollectionItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, self.onSelect, self)
end

function V1a6_CachotCollectionItem:_btnclickOnClick()
	if self._mo then
		V1a6_CachotCollectionController.instance:onSelectCollection(self._mo.id)
	end
end

function V1a6_CachotCollectionItem:onUpdateMO(mo, lineIndex)
	if self._mo ~= mo then
		self._mo = mo

		UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageframe, string.format("v1a6_cachot_img_collectionframe%s", self._mo.showRare))

		local collectionState = V1a6_CachotCollectionListModel.instance:getCollectionState(self._mo.id)

		gohelper.setActive(self._gonotget, collectionState == V1a6_CachotEnum.CollectionState.UnLocked)
		gohelper.setActive(self._golocked, collectionState == V1a6_CachotEnum.CollectionState.Locked)

		self._simagecollection.curImageUrl = nil

		self._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. self._mo.icon))
		self:refreshIconColor(collectionState)
		self:onSelect()
	end

	self:playAnim(lineIndex)
end

V1a6_CachotCollectionItem.IconNormalColor = "#FFFFFF"
V1a6_CachotCollectionItem.IconUnLockColor = "#060606"
V1a6_CachotCollectionItem.IconUnLockAndUnGetColor = "#5C5C5C"
V1a6_CachotCollectionItem.UnLockStateItemAlpha = 0.5
V1a6_CachotCollectionItem.OtherStateItemAlpha = 1

function V1a6_CachotCollectionItem:refreshIconColor(collectionState)
	local iconColor = "#FFFFFF"
	local itemAlpha = V1a6_CachotCollectionItem.OtherStateItemAlpha

	if collectionState == V1a6_CachotEnum.CollectionState.UnLocked then
		iconColor = V1a6_CachotCollectionItem.IconUnLockAndUnGetColor
		itemAlpha = V1a6_CachotCollectionItem.UnLockStateItemAlpha
	else
		iconColor = collectionState == V1a6_CachotEnum.CollectionState.Locked and V1a6_CachotCollectionItem.IconUnLockColor or V1a6_CachotCollectionItem.IconNormalColor
	end

	self._canvasgroup.alpha = itemAlpha

	SLFramework.UGUI.GuiHelper.SetColor(self._imageicon, iconColor)
end

function V1a6_CachotCollectionItem:onSelect()
	local curSelectCollectionId = V1a6_CachotCollectionListModel.instance:getCurSelectCollectionId()
	local isCollectionNew = V1a6_CachotCollectionListModel.instance:isCollectionNew(self._mo.id)

	if self._mo then
		local isSelect = self._mo.id == curSelectCollectionId

		gohelper.setActive(self._goselect, isSelect)
		gohelper.setActive(self._gonew, isCollectionNew)
	end
end

local SingleLineCollectionOpenAnimDelayTime = 0.06
local maxPlayAnimCellIndex = 3

function V1a6_CachotCollectionItem:playAnim(lineIndex)
	TaskDispatcher.cancelTask(self.delayPlayCollectionOpenAnim, self)

	local curPlayAnimCellIndex = V1a6_CachotCollectionListModel.instance:getCurPlayAnimCellIndex()
	local needPlayAnim = lineIndex and (not curPlayAnimCellIndex or curPlayAnimCellIndex <= lineIndex and lineIndex <= maxPlayAnimCellIndex)

	if needPlayAnim then
		local delayTime2PlayAnim = (lineIndex - 1) * SingleLineCollectionOpenAnimDelayTime

		TaskDispatcher.runDelay(self.delayPlayCollectionOpenAnim, self, delayTime2PlayAnim)
		V1a6_CachotCollectionListModel.instance:markCurPlayAnimCellIndex(lineIndex)
	end

	gohelper.setActive(self.viewGO, not needPlayAnim)
end

function V1a6_CachotCollectionItem:delayPlayCollectionOpenAnim()
	gohelper.setActive(self.viewGO, true)
	self._anim:Play("v1a6_cachot_collectionitem_open", 0, 0)
end

function V1a6_CachotCollectionItem:onDestroy()
	TaskDispatcher.cancelTask(self.delayPlayCollectionOpenAnim, self)
	self._simagecollection:UnLoadImage()
	self:__onDispose()
end

return V1a6_CachotCollectionItem
