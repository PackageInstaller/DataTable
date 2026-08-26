-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1CelebrityCardGetView.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1CelebrityCardGetView", package.seeall)

local Season123_2_1CelebrityCardGetView = class("Season123_2_1CelebrityCardGetView", BaseViewExtended)

Season123_2_1CelebrityCardGetView.OpenType = {
	Get = 1
}

function Season123_2_1CelebrityCardGetView:onInitView()
	self._goselfSelect = gohelper.findChild(self.viewGO, "#go_selfSelect")
	self._gocardget = gohelper.findChild(self.viewGO, "#go_cardget")
	self._scrollcardget = gohelper.findChildScrollRect(self.viewGO, "#go_cardget/mask/#scroll_cardget")
	self._gocardContent = gohelper.findChild(self.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent")
	self._gocarditem = gohelper.findChild(self.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent/#go_carditem")
	self._btnclose = gohelper.getClick(self.viewGO)
	self._contentGrid = self._gocardContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._contentSizeFitter = self._gocardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1CelebrityCardGetView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123_2_1CelebrityCardGetView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season123_2_1CelebrityCardGetView:_btncloseOnClick()
	self:closeThis()
end

function Season123_2_1CelebrityCardGetView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	gohelper.setActive(self._goselfSelect, false)
	gohelper.setActive(self._gocardget, true)
	self:_showGetCard()
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(Season123Model.instance:getCurSeasonId())
end

function Season123_2_1CelebrityCardGetView:_showGetCard()
	self:com_loadAsset(Season123_2_1CelebrityCardItem.AssetPath, self._onCardItemLoaded)
end

function Season123_2_1CelebrityCardGetView:_onCardItemLoaded(loader)
	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, gohelper.findChild(self._gocarditem, "go_itempos"), "root")

	transformhelper.setLocalScale(obj.transform, 0.65, 0.65, 0.65)

	self._scroll_view = self:com_registSimpleScrollView(self._scrollcardget.gameObject, ScrollEnum.ScrollDirV, 4)

	self._scroll_view:setClass(Season123_2_1CelebrityCardGetScrollItem)
	self._scroll_view:setObjItem(obj)

	local data = self.viewParam.data

	if #data > 4 then
		recthelper.setAnchor(self._scrollcardget.transform, 0, -473)

		self._contentGrid.enabled = false
		self._contentSizeFitter.enabled = false
	else
		recthelper.setAnchor(self._scrollcardget.transform, 0, -618)

		self._contentGrid.enabled = true
		self._contentSizeFitter.enabled = true
	end

	self._scroll_view:setData(data)
end

function Season123_2_1CelebrityCardGetView:isItemID()
	return self.viewParam.is_item_id
end

function Season123_2_1CelebrityCardGetView:onClose()
	return
end

return Season123_2_1CelebrityCardGetView
