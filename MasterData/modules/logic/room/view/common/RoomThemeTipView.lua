-- chunkname: @modules/logic/room/view/common/RoomThemeTipView.lua

module("modules.logic.room.view.common.RoomThemeTipView", package.seeall)

local RoomThemeTipView = class("RoomThemeTipView", BaseView)

function RoomThemeTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageblockpackageicon = gohelper.findChildSingleImage(self.viewGO, "content/blockpackageiconmask/#simage_blockpackageicon")
	self._gosuitcollect = gohelper.findChild(self.viewGO, "content/blockpackageiconmask/#go_suitcollect")
	self._simagebuildingicon = gohelper.findChildSingleImage(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#simage_buildingicon")
	self._btnsuitcollect = gohelper.findChildButtonWithAudio(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#btn_suitcollect")
	self._gocollecticon = gohelper.findChild(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#go_collecticon")
	self._txtbuildingname = gohelper.findChildText(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_buildingname")
	self._txtcollectdesc = gohelper.findChildText(self.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_collectdesc")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "content/title/#go_normaltitle")
	self._txtname = gohelper.findChildText(self.viewGO, "content/title/#go_normaltitle/#txt_name")
	self._gohascollect = gohelper.findChild(self.viewGO, "content/title/#go_hascollect")
	self._txtname2 = gohelper.findChildText(self.viewGO, "content/title/#go_hascollect/#txt_name2")
	self._txtdesc = gohelper.findChildText(self.viewGO, "content/desc/#txt_desc")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "content/go_scroll/#scroll_item")
	self._gocobrand = gohelper.findChild(self.viewGO, "content/#go_cobrand")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomThemeTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsuitcollect:AddClickListener(self._btnsuitcollectOnClick, self)
end

function RoomThemeTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsuitcollect:RemoveClickListener()
end

function RoomThemeTipView:_btncloseOnClick()
	self:closeThis()
end

function RoomThemeTipView:_btnsuitcollectOnClick()
	if RoomModel.instance:isHasGetThemeRewardById(self._themeId) then
		return
	end

	if self._collectionBonus and #self._collectionBonus > 0 then
		local bonus = self._collectionBonus[1]
		local data = {
			type = bonus[1],
			id = bonus[2]
		}

		MaterialTipController.instance:showMaterialInfoWithData(data.type, data.id, data)
	end
end

function RoomThemeTipView:_editableInitView()
	RoomThemeItemListModel.instance:setItemShowType(RoomThemeItemListModel.SwitchType.Collect)
	gohelper.setActive(gohelper.findChild(self.viewGO, "content/themeitem"), false)

	self._gocollecticonanimator = self._gocollecticon:GetComponent(typeof(UnityEngine.Animator))
	self.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gocobrand, RoomSourcesCobrandLogoItem, self)
end

function RoomThemeTipView:_refreshUI()
	self._themeId = RoomConfig.instance:getThemeIdByItem(self._itemId, self._itemType) or 1

	local config = RoomConfig.instance:getThemeConfig(self._themeId)

	self._collectionBonus = RoomConfig.instance:getThemeCollectionRewards(self._themeId)
	self._hasCollectionReward = self._collectionBonus and #self._collectionBonus > 0

	if config then
		self._simageblockpackageicon:LoadImage(ResUrl.getRoomThemeRewardIcon(config.rewardIcon))
		RoomThemeItemListModel.instance:setThemeId(self._themeId)

		self._txtname.text = config.name
		self._txtname2.text = config.name
		self._txtdesc.text = config.desc
	end

	self.cobrandLogoItem:setSourcesTypeStr(config and config.sourcesType)

	if self._hasCollectionReward then
		local isGet = RoomModel.instance:isGetThemeRewardById(self._themeId)

		if not isGet then
			::label_7_0::

			local isFinsh = RoomModel.instance:isFinshThemeById(self._themeId)

			gohelper.setActive(self._gosuitcollect, self._hasCollectionReward)
			gohelper.setActive(self._gonormaltitle, not isFinsh)
			gohelper.setActive(self._gohascollect, isFinsh)

			if self._hasCollectionReward then
				gohelper.setActive(self._gocollecticon, isGet)
				gohelper.setActive(self._btnsuitcollect, not isGet)

				local bonus = self._collectionBonus[1]
				local cfg, icons = ItemModel.instance:getItemConfigAndIcon(bonus[1], bonus[2], true)

				self._simagebuildingicon:LoadImage(icons)

				self._txtbuildingname.text = cfg.name
			end
		end
	end
end

function RoomThemeTipView:_onUpdateRoomThemeReward(themeId)
	if self._themeId == themeId then
		self:_refreshUI()
	end
end

function RoomThemeTipView:onOpen()
	self._itemType = self.viewParam.type
	self._itemId = self.viewParam.id

	self.addEventCb(self, RoomController.instance, RoomEvent.UpdateRoomThemeReward, self._onUpdateRoomThemeReward, self)
	self:_refreshUI()
	TaskDispatcher.runDelay(self._checkSendReward, self, 1.5)

	if RoomModel.instance:isHasGetThemeRewardById(self._themeId) then
		gohelper.setActive(self._gocollecticonanimator, true)
		self._gocollecticonanimator:Play("open", 0, 0)
	end
end

function RoomThemeTipView:onUpdateParam()
	self._itemType = self.viewParam.type
	self._itemId = self.viewParam.id

	self:_refreshUI()
	self:_checkSendReward()
end

function RoomThemeTipView:_checkSendReward()
	if RoomModel.instance:isHasGetThemeRewardById(self._themeId) then
		RoomRpc.instance:sendGetRoomThemeCollectionBonusRequest(self._themeId)
	end
end

function RoomThemeTipView:onClose()
	TaskDispatcher.cancelTask(self._checkSendReward, self)
	self:_checkSendReward()
end

function RoomThemeTipView:onDestroyView()
	self._simageblockpackageicon:UnLoadImage()
	self._simagebuildingicon:UnLoadImage()
	self.cobrandLogoItem:onDestroy()
end

return RoomThemeTipView
