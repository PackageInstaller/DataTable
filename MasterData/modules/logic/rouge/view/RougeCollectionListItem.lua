-- chunkname: @modules/logic/rouge/view/RougeCollectionListItem.lua

module("modules.logic.rouge.view.RougeCollectionListItem", package.seeall)

local RougeCollectionListItem = class("RougeCollectionListItem", ListScrollCellExtend)

function RougeCollectionListItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gonew = gohelper.findChild(self.viewGO, "#go_normal/go_new")
	self._imagebg = gohelper.findChildImage(self.viewGO, "#go_normal/#image_bg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_collection")
	self._imagecollection = gohelper.findChildImage(self.viewGO, "#go_normal/#simage_collection")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._godlctag = gohelper.findChild(self.viewGO, "#go_dlctag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionListItem:addEvents()
	return
end

function RougeCollectionListItem:removeEvents()
	return
end

function RougeCollectionListItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.UI_Common_Click)
	self._color = self._imagecollection.color
	self._orderColor = self._txtnum.color
end

function RougeCollectionListItem:_editableAddEvents()
	self._click:AddClickListener(self._onClickItem, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickCollectionListItem, self._onClickCollectionListItem, self)
end

function RougeCollectionListItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function RougeCollectionListItem:_onClickItem()
	RougeCollectionListModel.instance:setSelectedConfig(self._mo)

	if self._showNewFlag then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Collection, self._mo.id, self._updateNewFlag, self)
	end
end

function RougeCollectionListItem:_onClickCollectionListItem()
	self:_updateSelected()
end

function RougeCollectionListItem:_updateSelected()
	local selectedConfig = RougeCollectionListModel.instance:getSelectedConfig()

	gohelper.setActive(self._goselected, selectedConfig and selectedConfig == self._mo)
end

function RougeCollectionListItem:onUpdateMO(mo)
	self._mo = mo

	local isShow = mo ~= nil

	gohelper.setActive(self.viewGO, isShow)

	if not isShow then
		return
	end

	local isUnlock = RougeFavoriteModel.instance:collectionIsUnlock(mo.id)
	local isPass

	if isUnlock then
		isPass = RougeOutsideModel.instance:collectionIsPass(mo.id)
		self._color.a = isPass and 1 or 0.3
		self._imagecollection.color = self._color
	end

	self._orderColor.a = isPass and 0.7 or 0.3
	self._txtnum.color = self._orderColor
	self._txtnum.text = RougeCollectionListModel.instance:getPos(mo.id)

	local config = RougeCollectionConfig.instance:getCollectionCfg(mo.id)
	local icon = "rouge_episode_collectionbg_" .. config.showRare

	UISpriteSetMgr.instance:setRougeSprite(self._imagebg, icon, true)
	gohelper.setActive(self._gonormal, isUnlock)
	gohelper.setActive(self._golocked, not isUnlock)
	self:_updateSelected()
	self._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self._mo.id))
	self:_updateNewFlag()
	self:_refreshDLCTag(config.versions, isUnlock)
end

function RougeCollectionListItem:_updateNewFlag()
	self._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Collection, self._mo.id) ~= nil

	gohelper.setActive(self._gonew, self._showNewFlag)
end

function RougeCollectionListItem:_refreshDLCTag(versions, isUnlock)
	local version = versions and versions[1]
	local isShowTag = version ~= nil and isUnlock

	gohelper.setActive(self._godlctag, isShowTag)

	if isShowTag then
		local dlcImage = self._godlctag:GetComponent(gohelper.Type_Image)

		UISpriteSetMgr.instance:setRougeSprite(dlcImage, "rouge_episode_tagdlc_101")
	end
end

function RougeCollectionListItem:onSelect(isSelect)
	return
end

function RougeCollectionListItem:onDestroyView()
	return
end

return RougeCollectionListItem
