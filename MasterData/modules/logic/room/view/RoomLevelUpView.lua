-- chunkname: @modules/logic/room/view/RoomLevelUpView.lua

module("modules.logic.room.view.RoomLevelUpView", package.seeall)

local RoomLevelUpView = class("RoomLevelUpView", BaseView)

function RoomLevelUpView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_leftbg")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simageproductlineIcon = gohelper.findChildSingleImage(self.viewGO, "root/info/#simage_productIcon")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "root/info/#txt_namecn")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/info/#txt_namecn/#image_icon")
	self._btnlevelup = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_levelup")
	self._txttip = gohelper.findChildText(self.viewGO, "#txt_tip")
	self._golevelupInfoItem = gohelper.findChild(self.viewGO, "root/scrollview/viewport/content/#go_levelupInfoItem")
	self._gocostitem = gohelper.findChild(self.viewGO, "root/costs/content/#go_costitem")
	self._goblockitem = gohelper.findChild(self.viewGO, "root/costs/content/#go_blockitem")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_reddot")
	self._golacktip = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_lacktip")
	self._golevelupbeffect = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_reddot/#go_levelupbeffect")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLevelUpView:addEvents()
	self._btnlevelup:AddClickListener(self._btnlevelupOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomLevelUpView:removeEvents()
	self._btnlevelup:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RoomLevelUpView:_btncloseOnClick()
	self:closeThis()
end

function RoomLevelUpView:_btnlevelupOnClick()
	local roomLevel = RoomMapModel.instance:getRoomLevel()
	local canLevelUp, errorCode = RoomInitBuildingHelper.canLevelUp()

	if canLevelUp then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomLevelUpConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			RoomRpc.instance:sendRoomLevelUpRequest()
		end)
	elseif errorCode == RoomInitBuildingEnum.CanLevelUpErrorCode.MaxLevel then
		-- block empty
	elseif errorCode == RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughItem then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotItem)
	elseif errorCode == RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughBlock then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotBlock)
	end
end

function RoomLevelUpView:_btnclickOnClick(index)
	local costItem = self._costItemList[index]
	local param = costItem.param

	if param.type == "item" then
		local costItemParam = param.item

		MaterialTipController.instance:showMaterialInfo(costItemParam.type, costItemParam.id, nil, nil, nil, {
			type = costItemParam.type,
			id = costItemParam.id,
			quantity = costItemParam.quantity,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		})
	elseif param.type == "block" then
		local confirmBlockCount = RoomMapBlockModel.instance:getConfirmBlockCount()
		local needCount = param.count

		if confirmBlockCount < needCount then
			GameFacade.showToast(ToastEnum.RoomLevelUpNotBlock)
		end
	end
end

function RoomLevelUpView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part0"))

	self._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(self._golevelupInfoItem, false)

	self._levelUpInfoItemList = {}

	gohelper.setActive(self._gocostitem, false)

	self._costItemList = {}

	gohelper.setActive(self._txttip.gameObject, false)
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomInitBuildingLevel)
end

function RoomLevelUpView:_refreshUI()
	self:_refreshTitleInfo()
	self:_refreshLevelUpInfo()
	self:_refreshCost()
	self:_refreshLevel()
end

function RoomLevelUpView:_refreshTitleInfo()
	self._txtnamecn.text = luaLang("room_initbuilding_title")

	UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "bg_init_ovr")
	self._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part0"))
end

function RoomLevelUpView:_refreshLevel()
	local canLevelUp = RoomInitBuildingHelper.canLevelUp()

	gohelper.setActive(self._golevelupbeffect, canLevelUp)
end

function RoomLevelUpView:_refreshLevelUpInfo()
	local roomLevel = RoomMapModel.instance:getRoomLevel()
	local params = RoomProductionHelper.getRoomLevelUpParams(roomLevel, roomLevel + 1, false)

	for i, param in ipairs(params) do
		local levelUpInfoItem = self._levelUpInfoItemList[i]

		if not levelUpInfoItem then
			levelUpInfoItem = self:getUserDataTb_()
			levelUpInfoItem.go = gohelper.cloneInPlace(self._golevelupInfoItem, "item" .. i)
			levelUpInfoItem.bg = gohelper.findChild(levelUpInfoItem.go, "go_bg")
			levelUpInfoItem.curNum = gohelper.findChildText(levelUpInfoItem.go, "#txt_curNum")
			levelUpInfoItem.nextNum = gohelper.findChildText(levelUpInfoItem.go, "#txt_nextNum")
			levelUpInfoItem.txtdesc = gohelper.findChildText(levelUpInfoItem.go, "#txt_levelupInfo")

			table.insert(self._levelUpInfoItemList, levelUpInfoItem)
		end

		levelUpInfoItem.txtdesc.text = param.desc
		levelUpInfoItem.curNum.text = param.currentDesc
		levelUpInfoItem.nextNum.text = param.nextDesc

		gohelper.setActive(levelUpInfoItem.bg, i % 2 ~= 0)
		gohelper.setActive(levelUpInfoItem.go, true)
	end

	for i = #params + 1, #self._levelUpInfoItemList do
		local levelUpInfoItem = self._levelUpInfoItemList[i]

		gohelper.setActive(levelUpInfoItem.go, false)
	end
end

function RoomLevelUpView:_refreshCost()
	local params = {}
	local roomLevel = RoomMapModel.instance:getRoomLevel()
	local nextRoomLevel = roomLevel + 1
	local nextRoomLevelConfig = RoomConfig.instance:getRoomLevelConfig(nextRoomLevel)
	local costItemParamList = RoomProductionHelper.getFormulaItemParamList(nextRoomLevelConfig.cost)

	for _, costItemParam in ipairs(costItemParamList) do
		table.insert(params, {
			type = "item",
			item = costItemParam
		})
	end

	table.insert(params, {
		type = "block",
		count = nextRoomLevelConfig.needBlockCount
	})

	self._isCostLack = false

	for i, param in ipairs(params) do
		local costItem = self._costItemList[i]

		if not costItem then
			costItem = self:getUserDataTb_()
			costItem.index = i

			if param.type == "item" then
				costItem.go = gohelper.cloneInPlace(self._gocostitem, "item" .. i)
				costItem.parent = gohelper.findChild(costItem.go, "go_itempos")
				costItem.itemIcon = IconMgr.instance:getCommonItemIcon(costItem.parent)

				costItem.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, self)
			elseif param.type == "block" then
				costItem.go = gohelper.cloneInPlace(self._goblockitem, "item" .. i)
				costItem.txtcostcount = gohelper.findChildText(costItem.go, "txt_costcount")
				costItem.btnclick = gohelper.findChildButtonWithAudio(costItem.go, "btnclick")

				costItem.btnclick:AddClickListener(self._btnclickOnClick, self, costItem.index)
			end

			table.insert(self._costItemList, costItem)
		end

		costItem.param = param

		local enough = true

		if param.type == "block" then
			local needBlockCount = param.count
			local confirmBlockCount = RoomMapBlockModel.instance:getConfirmBlockCount()

			enough = needBlockCount <= confirmBlockCount

			if enough then
				costItem.txtcostcount.text = string.format("%d/%d", confirmBlockCount, needBlockCount)
			else
				self._isCostLack = true
				costItem.txtcostcount.text = string.format("<color=#d97373>%d</color>/%d", confirmBlockCount, needBlockCount)
			end
		elseif param.type == "item" then
			local costItemParam = param.item

			costItem.itemIcon:setMOValue(costItemParam.type, costItemParam.id, costItemParam.quantity)
			costItem.itemIcon:setCountFontSize(43)

			local countText = costItem.itemIcon:getCount()
			local hasQuantity = ItemModel.instance:getItemQuantity(costItemParam.type, costItemParam.id)

			enough = hasQuantity >= costItemParam.quantity

			if enough then
				countText.text = string.format("%s/%s", GameUtil.numberDisplay(hasQuantity), GameUtil.numberDisplay(costItemParam.quantity))
			else
				countText.text = string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(hasQuantity), GameUtil.numberDisplay(costItemParam.quantity))
				self._isCostLack = true
			end
		end

		gohelper.setActive(costItem.go, true)
	end

	for i = #params + 1, #self._costItemList do
		local costItem = self._costItemList[i]

		gohelper.setActive(costItem.go, false)
	end

	gohelper.setActive(self._golacktip, false)
	ZProj.UGUIHelper.SetGrayscale(self._btnlevelup.gameObject, self._isCostLack)
	gohelper.setActive(self._golevelupbeffect, not self._isCostLack)
end

function RoomLevelUpView:_updateRoomLevel()
	local roomLevel = RoomMapModel.instance:getRoomLevel()
	local maxRoomLevel = RoomConfig.instance:getMaxRoomLevel()

	ViewMgr.instance:openView(ViewName.RoomLevelUpTipsView, {
		level = roomLevel
	})
	ViewMgr.instance:closeView(ViewName.RoomLevelUpView, nil, false)
end

function RoomLevelUpView:onOpen()
	self:_refreshUI()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateRoomLevel, self._updateRoomLevel, self)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function RoomLevelUpView:onClose()
	if self.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function RoomLevelUpView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simageproductlineIcon:UnLoadImage()

	for i, costItem in ipairs(self._costItemList) do
		if costItem.param.type == "block" then
			costItem.btnclick:RemoveClickListener()
		end
	end
end

return RoomLevelUpView
