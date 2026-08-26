-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8CelebrityCardGetView.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8CelebrityCardGetView", package.seeall)

local Season123_1_8CelebrityCardGetView = class("Season123_1_8CelebrityCardGetView", BaseViewExtended)

Season123_1_8CelebrityCardGetView.OpenType = {
	Get = 1
}

function Season123_1_8CelebrityCardGetView:onInitView()
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

function Season123_1_8CelebrityCardGetView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season123_1_8CelebrityCardGetView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season123_1_8CelebrityCardGetView:_btncloseOnClick()
	self:closeThis()
end

function Season123_1_8CelebrityCardGetView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	gohelper.setActive(self._goselfSelect, false)
	gohelper.setActive(self._gocardget, true)
	self:_showGetCard()
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(Season123Model.instance:getCurSeasonId())
end

function Season123_1_8CelebrityCardGetView:_showGetCard()
	self:com_loadAsset(Season123_1_8CelebrityCardItem.AssetPath, self._onCardItemLoaded)
end

function Season123_1_8CelebrityCardGetView:_onCardItemLoaded(loader)
	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, gohelper.findChild(self._gocarditem, "go_itempos"), "root")

	transformhelper.setLocalScale(obj.transform, 0.65, 0.65, 0.65)

	self._scroll_view = self:com_registSimpleScrollView(self._scrollcardget.gameObject, ScrollEnum.ScrollDirV, 4)

	self._scroll_view:setClass(Season123_1_8CelebrityCardGetScrollItem)
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

function Season123_1_8CelebrityCardGetView:isItemID()
	return self.viewParam.is_item_id
end

function Season123_1_8CelebrityCardGetView:onClose()
	return
end

return Season123_1_8CelebrityCardGetView
