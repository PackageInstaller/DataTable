-- chunkname: @modules/logic/season/view3_0/Season3_0CelebrityCardGetlView.lua

module("modules.logic.season.view3_0.Season3_0CelebrityCardGetlView", package.seeall)

local Season3_0CelebrityCardGetlView = class("Season3_0CelebrityCardGetlView", BaseViewExtended)

Season3_0CelebrityCardGetlView.OpenType = {
	Get = 1
}

function Season3_0CelebrityCardGetlView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._simagebg3 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg3")
	self._simagebg4 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg4")
	self._simagebg5 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg5")
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

function Season3_0CelebrityCardGetlView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Season3_0CelebrityCardGetlView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Season3_0CelebrityCardGetlView:_btncloseOnClick()
	self:closeThis()
end

function Season3_0CelebrityCardGetlView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	self._simagebg3:LoadImage(ResUrl.getSeasonIcon("bg_zs.png"))
	self._simagebg5:LoadImage(ResUrl.getSeasonIcon("bg_zs2.png"))
	self._simagebg4:LoadImage(ResUrl.getSeasonIcon("full/img_bg2.png"))
	gohelper.setActive(self._goselfSelect, false)
	gohelper.setActive(self._gocardget, true)
	self:_showGetCard()
	Activity104Rpc.instance:sendGetUnlockActivity104EquipIdsRequest(Activity104Model.instance:getCurSeasonId())
end

function Season3_0CelebrityCardGetlView:_showGetCard()
	self:com_loadAsset(Season3_0CelebrityCardItem.AssetPath, self._onCardItemLoaded)
end

function Season3_0CelebrityCardGetlView:_onCardItemLoaded(loader)
	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, gohelper.findChild(self._gocarditem, "go_itempos"), "root")

	transformhelper.setLocalScale(obj.transform, 0.65, 0.65, 0.65)

	self._scroll_view = self:com_registSimpleScrollView(self._scrollcardget.gameObject, ScrollEnum.ScrollDirV, 4)

	self._scroll_view:setClass(Season3_0CelebrityCardGetScrollItem)
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

function Season3_0CelebrityCardGetlView:isItemID()
	return self.viewParam.is_item_id
end

function Season3_0CelebrityCardGetlView:onClose()
	self._simagebg1:UnLoadImage()
	self._simagebg3:UnLoadImage()
	self._simagebg4:UnLoadImage()
	self._simagebg5:UnLoadImage()
end

return Season3_0CelebrityCardGetlView
