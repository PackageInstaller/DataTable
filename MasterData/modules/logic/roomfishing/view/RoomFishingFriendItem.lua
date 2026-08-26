-- chunkname: @modules/logic/roomfishing/view/RoomFishingFriendItem.lua

module("modules.logic.roomfishing.view.RoomFishingFriendItem", package.seeall)

local RoomFishingFriendItem = class("RoomFishingFriendItem", ListScrollCellExtend)

function RoomFishingFriendItem:onInitView()
	self._goheadicon = gohelper.findChild(self.viewGO, "#go_headicon")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "#txt_PlayerName")
	self._govisit = gohelper.findChild(self.viewGO, "txt_State")
	self._goUnFinished = gohelper.findChild(self.viewGO, "Schedule/#go_UnFinished")
	self._imagefishing = gohelper.findChildImage(self.viewGO, "Schedule/#go_UnFinished/image_ScheduleFG")
	self._imageItemBG = gohelper.findChildImage(self.viewGO, "Schedule/#image_ItemBG")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "Schedule/#simage_Prop")
	self._txtSchedule = gohelper.findChildText(self.viewGO, "Schedule/#txt_Schedule")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFishingFriendItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RoomFishingFriendItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomFishingFriendItem:_btnclickOnClick()
	if not self._mo then
		return
	end

	FishingController.instance:visitOtherFishingPool(self._mo.userId)
end

function RoomFishingFriendItem:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goheadicon)
end

function RoomFishingFriendItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshInfo()
	self:refreshStatus()
end

function RoomFishingFriendItem:refreshInfo()
	if not self._mo then
		return
	end

	local userId = self._mo.userId
	local defaultPortrait = CommonConfig.instance:getConstNum(ConstEnum.PlayerDefaultIcon)

	self._playericon:setMOValue(userId, "", 0, self._mo.portrait or defaultPortrait)
	self._playericon:setShowLevel(false)
	self._playericon:setEnableClick(false)

	self._txtPlayerName.text = self._mo.name

	local curPoolUserId = FishingModel.instance:getCurShowingUserId()

	gohelper.setActive(self._govisit, userId == curPoolUserId)

	local poolItemData = FishingConfig.instance:getFishingPoolItem(self._mo.poolId)

	if poolItemData then
		local itemCfg, icon = ItemModel.instance:getItemConfigAndIcon(poolItemData[1], poolItemData[2])

		UISpriteSetMgr.instance:setRoomSprite(self._imageItemBG, "roomfish_itemqualitybg2_" .. CharacterEnum.Color[itemCfg.rare], true)
		self._simageProp:LoadImage(icon)
	end
end

function RoomFishingFriendItem:refreshStatus()
	TaskDispatcher.cancelTask(self.timerUpdate, self)

	if self._mo then
		local userId = self._mo.userId
		local isFishing = FishingModel.instance:getIsFishingInUserPool(userId)

		if isFishing then
			self:timerUpdate()
			TaskDispatcher.runRepeat(self.timerUpdate, self, TimeUtil.OneSecond)
		else
			self._txtSchedule.text = luaLang("p_roomview_fishing_reward")
		end

		gohelper.setActive(self._goUnFinished, isFishing)
	end
end

function RoomFishingFriendItem:timerUpdate()
	if self._mo then
		local userId = self._mo.userId
		local isFishing = FishingModel.instance:getIsFishingInUserPool(userId)

		if isFishing and self._txtSchedule and self._imagefishing then
			local progress = FishingModel.instance:getMyFishingProgress(userId)
			local progressStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), progress)

			self._imagefishing.fillAmount = Mathf.Clamp01(progress / 100)
			self._txtSchedule.text = progressStr
		else
			TaskDispatcher.cancelTask(self.timerUpdate, self)
		end
	end
end

function RoomFishingFriendItem:onDestroyView()
	self._simageProp:UnLoadImage()
	TaskDispatcher.cancelTask(self.timerUpdate, self)
end

return RoomFishingFriendItem
