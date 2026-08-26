-- chunkname: @modules/logic/room/view/common/RoomBlockPackageGetView.lua

module("modules.logic.room.view.common.RoomBlockPackageGetView", package.seeall)

local RoomBlockPackageGetView = class("RoomBlockPackageGetView", BaseView)

function RoomBlockPackageGetView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._simagebgicon1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bgicon1")
	self._simagebgicon2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bgicon2")
	self._simageblockpackageicon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_blockpackageicon")
	self._simagetipshui = gohelper.findChildSingleImage(self.viewGO, "bg/simage_tipsmask/#simage_tips_hui")
	self._simagetipsbai = gohelper.findChildSingleImage(self.viewGO, "bg/simage_tipsmask/#simage_tips_bai")
	self._gocobrand = gohelper.findChild(self.viewGO, "bg/#go_cobrand")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBlockPackageGetView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomBlockPackageGetView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomBlockPackageGetView:_btncloseOnClick()
	if not self._canClick then
		return
	end

	self:_next()
end

function RoomBlockPackageGetView:_editableInitView()
	self._simagebgicon1:LoadImage(ResUrl.getRoomGetIcon("xw_texiao1"))
	self._simagebgicon2:LoadImage(ResUrl.getRoomGetIcon("xw_texiao2"))

	self._txtname1 = gohelper.findChildText(self.viewGO, "bg/simage_tipsmask/#simage_tips_hui/#txt_name")
	self._txtname2 = gohelper.findChildText(self.viewGO, "bg/simage_tipsmask/#simage_tips_bai/#txt_name")

	gohelper.removeUIClickAudio(self._btnclose.gameObject)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gocobrand, RoomSourcesCobrandLogoItem, self)
	self.cobrandLogoItem.__view = self
end

function RoomBlockPackageGetView:_refreshUI()
	local itemType = self._item.itemType
	local itemId = self._item.itemId
	local isBlockPackage = itemType == MaterialEnum.MaterialType.BlockPackage
	local isBuilding = itemType == MaterialEnum.MaterialType.Building
	local isTheme = itemType == MaterialEnum.MaterialType.RoomTheme

	gohelper.setActive(self._txtname1.gameObject, isBlockPackage or isBuilding or isTheme)
	gohelper.setActive(self._txtname2.gameObject, isBlockPackage or isBuilding or isTheme)
	gohelper.setActive(self._simageblockpackageicon.gameObject, isBlockPackage or isBuilding or isTheme)

	local config

	if isBlockPackage then
		config = RoomConfig.instance:getBlockPackageConfig(itemId)
		self._txtname1.text = config.name
		self._txtname2.text = config.name

		self._simageblockpackageicon:LoadImage(ResUrl.getRoomBlockPackageRewardIcon(config.rewardIcon))
		self._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_1"))
		self._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_1"))
	elseif isBuilding then
		local rewardIcon
		local roomBuildingLevel = self._item.roomBuildingLevel

		if roomBuildingLevel and roomBuildingLevel > 0 then
			local levelConfig = RoomConfig.instance:getLevelGroupConfig(itemId, roomBuildingLevel)

			rewardIcon = levelConfig and levelConfig.rewardIcon
		end

		config = RoomConfig.instance:getBuildingConfig(itemId)

		if string.nilorempty(rewardIcon) then
			rewardIcon = config.rewardIcon
		end

		self._txtname1.text = config.name
		self._txtname2.text = config.name

		self._simageblockpackageicon:LoadImage(ResUrl.getRoomBuildingRewardIcon(rewardIcon))
		self._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode"))
		self._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode"))
	elseif isTheme then
		config = RoomConfig.instance:getThemeConfig(itemId)
		self._txtname1.text = config.name
		self._txtname2.text = config.name

		self._simageblockpackageicon:LoadImage(ResUrl.getRoomThemeRewardIcon(config.rewardIcon))
		self._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_2"))
		self._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_2"))
	else
		logError("不支持的物品类型, itemType: " .. tostring(itemType))
	end

	self.cobrandLogoItem:setSourcesTypeStr(config and config.sourcesType)
end

function RoomBlockPackageGetView:_onEscape()
	self:_btncloseOnClick()
end

function RoomBlockPackageGetView:_next(isUpdateParam)
	TaskDispatcher.cancelTask(self._refreshUI, self)

	self._itemIndex = self._itemIndex + 1
	self._item = self.viewParam and self.viewParam.itemList and self.viewParam.itemList[self._itemIndex]

	if not self._item then
		self:closeThis()

		return
	end

	if self._itemIndex > 1 then
		TaskDispatcher.runDelay(self._animDone, self, 5)

		self._canClick = false

		self._animatorPlayer:Play("all", self._animDone, self)
		TaskDispatcher.runDelay(self._refreshUI, self, 0.5)
	elseif isUpdateParam then
		TaskDispatcher.runDelay(self._animDone, self, 5)

		self._canClick = false

		self._animatorPlayer:Play(UIAnimationName.Open, self._animDone, self)
		self:_refreshUI()
	else
		self:_refreshUI()
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open)
end

function RoomBlockPackageGetView:onOpen()
	self._itemIndex = 0
	self._canClick = true

	self:_next()
	NavigateMgr.instance:addEscape(ViewName.RoomBlockPackageGetView, self._onEscape, self)
end

function RoomBlockPackageGetView:_animDone()
	TaskDispatcher.cancelTask(self._animDone, self)

	self._canClick = true
end

function RoomBlockPackageGetView:onUpdateParam()
	self._itemIndex = 0
	self._canClick = true

	self:_next(true)
end

function RoomBlockPackageGetView:onClose()
	TaskDispatcher.cancelTask(self._animDone, self)
	TaskDispatcher.cancelTask(self._refreshUI, self)

	if self.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function RoomBlockPackageGetView:onDestroyView()
	TaskDispatcher.cancelTask(self._animDone, self)
	TaskDispatcher.cancelTask(self._refreshUI, self)
	self._simagebgicon1:UnLoadImage()
	self._simagebgicon2:UnLoadImage()
	self._simageblockpackageicon:UnLoadImage()
	self._simagetipshui:UnLoadImage()
	self._simagetipsbai:UnLoadImage()
	self.cobrandLogoItem:onDestroy()
end

return RoomBlockPackageGetView
