-- chunkname: @modules/logic/room/view/RoomProductLineLevelUpView.lua

module("modules.logic.room.view.RoomProductLineLevelUpView", package.seeall)

local RoomProductLineLevelUpView = class("RoomProductLineLevelUpView", BaseView)

function RoomProductLineLevelUpView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simageproductlineIcon = gohelper.findChildSingleImage(self.viewGO, "root/info/#simage_productIcon")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "root/info/#txt_namecn")
	self._txtnamen = gohelper.findChildText(self.viewGO, "root/info/#txt_namecn/#txt_nameen")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/info/#txt_namecn/#image_icon")
	self._golevelupInfoItem = gohelper.findChild(self.viewGO, "root/levelupInfo/#go_levelupInfoItem")
	self._gocostitem = gohelper.findChild(self.viewGO, "root/costs/content/#go_costitem")
	self._btnlevelup = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_levelup")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_reddot")
	self._golacktip = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_lacktip")
	self._txtroomLvTips = gohelper.findChildTextMesh(self.viewGO, "root/#btn_levelup/#txt_roomLvTips")
	self._golevelupbeffect = gohelper.findChild(self.viewGO, "root/#btn_levelup/#go_reddot/#go_levelupbeffect")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomProductLineLevelUpView:addEvents()
	self._btnlevelup:AddClickListener(self._btnlevelupOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomProductLineLevelUpView:removeEvents()
	self._btnlevelup:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RoomProductLineLevelUpView:_btncloseOnClick()
	self:closeThis()
end

function RoomProductLineLevelUpView:_btnlevelupOnClick()
	if not self._costEnough then
		GameFacade.showToast(ToastEnum.RoomProductNotCost)

		return
	end

	if self._isMaxLevel == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomProductLineLevelUpConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			RoomRpc.instance:sendProductionLineLvUpRequest(self._productionLineMO.id, self._tarLevel)
		end)
	else
		GameFacade.showToast(ToastEnum.RoomProductIsMaxLev)
	end
end

function RoomProductLineLevelUpView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(self._golevelupInfoItem, false)

	self._levelUpInfoItemList = {}

	gohelper.setActive(self._gocostitem, false)

	self._costItemList = {}

	gohelper.removeUIClickAudio(self._btnclose.gameObject)
end

function RoomProductLineLevelUpView:onUpdateParam()
	self._productionLineMO = self.viewParam.lineMO
	self._selectPartId = self.viewParam.selectPartId or 0

	self:_refreshUI()
end

function RoomProductLineLevelUpView:onOpen()
	self._selectPartId = self.viewParam.selectPartId or 0
	self._productionLineMO = self.viewParam.lineMO

	self.addEventCb(self, RoomController.instance, RoomEvent.ProduceLineLevelUp, self._onLevelUp, self)
	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function RoomProductLineLevelUpView:onClose()
	self.removeEventCb(self, RoomController.instance, RoomEvent.ProduceLineLevelUp, self._onLevelUp, self)

	if self.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function RoomProductLineLevelUpView:_onLevelUp()
	ViewMgr.instance:openView(ViewName.RoomLevelUpTipsView, {
		productLineMO = self._productionLineMO
	})
	ViewMgr.instance:closeView(ViewName.RoomProductLineLevelUpView, nil, false)
end

function RoomProductLineLevelUpView:_refreshUI()
	local maxLineConfigLevel = self._productionLineMO.maxConfigLevel
	local lineLevel = self._productionLineMO.level

	self._tarLevel = math.min(maxLineConfigLevel, lineLevel + 1)
	self._isMaxLevel = self._productionLineMO.level == self._productionLineMO.maxLevel
	self._isMaxConfigLevel = self._productionLineMO.level == self._productionLineMO.maxConfigLevel
	self._costEnough = true

	self:_refreshLevelUpInfo()
	self:_refreshTitleInfo()
	self:_refreshCost()
	self:_refreshLevel()

	self._productionLineMO = self.viewParam.lineMO
	self._selectPartId = self.viewParam.selectPartId or 0

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomProductionLevel, self._productionLineMO.id)
end

function RoomProductLineLevelUpView:_refreshTitleInfo()
	local partConfig = RoomConfig.instance:getProductionPartConfig(self._selectPartId)
	local lineName = string.nilorempty(self._productionLineMO.config.name) and "" or "·" .. self._productionLineMO.config.name

	self._txtnamecn.text = string.format("%s%s", partConfig.name, (RoomProductionHelper.getPartType(partConfig.id) == RoomProductLineEnum.ProductType.Change or nil) and "")
	self._txtnamen.text = partConfig.nameEn

	UISpriteSetMgr.instance:setRoomSprite(self._imageicon, "bg_part" .. self._selectPartId)
	self._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part" .. self._selectPartId))
end

function RoomProductLineLevelUpView:_refreshLevel()
	ZProj.UGUIHelper.SetGrayscale(self._btnlevelup.gameObject, self._isMaxLevel or not self._costEnough)
	gohelper.setActive(self._golacktip, false)
	gohelper.setActive(self._golevelupbeffect, not self._isMaxLevel and self._costEnough)

	local targetLvCO = RoomConfig.instance:getProductionLineLevelConfig(self._productionLineMO.config.levelGroup, self._tarLevel)

	self._txtroomLvTips.text = targetLvCO and targetLvCO.needRoomLevel > RoomModel.instance:getRoomLevel() and self._costEnough and formatLuaLang("roomproductlinelevelup_roomtips", targetLvCO.needRoomLevel) or ""
end

function RoomProductLineLevelUpView:_refreshLevelUpInfo()
	local params = {}

	if self._isMaxConfigLevel == false then
		params = RoomProductionHelper.getProductLineLevelUpParams(self._productionLineMO.id, self._productionLineMO.level, self._tarLevel, false)
	end

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

function RoomProductLineLevelUpView:_refreshCost()
	local costParam = {}

	if self._isMaxConfigLevel == false then
		local levelGroupConfig = RoomConfig.instance:getProductionLineLevelConfig(self._productionLineMO.config.levelGroup, self._tarLevel)
		local cost = levelGroupConfig.cost

		costParam = GameUtil.splitString2(cost, true)
	end

	for i, param in ipairs(costParam) do
		local costItem = self._costItemList[i]

		if not costItem then
			costItem = self:getUserDataTb_()
			costItem.index = i
			costItem.go = gohelper.cloneInPlace(self._gocostitem, "item" .. i)
			costItem.parent = gohelper.findChild(costItem.go, "go_itempos")
			costItem.itemIcon = IconMgr.instance:getCommonItemIcon(costItem.parent)

			table.insert(self._costItemList, costItem)
		end

		costItem.param = param

		local enough = true
		local costType = param[1]
		local costId = param[2]
		local costNum = param[3]
		local hasQuantity = ItemModel.instance:getItemQuantity(costType, costId)

		enough = costNum <= hasQuantity

		costItem.itemIcon:setMOValue(costType, costId, costNum)
		costItem.itemIcon:setCountFontSize(43)
		costItem.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, self)

		local countText = costItem.itemIcon:getCount()

		countText.text = enough and string.format("%s/%s", GameUtil.numberDisplay(hasQuantity), GameUtil.numberDisplay(costNum)) or string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(hasQuantity), GameUtil.numberDisplay(costNum))
		self._costEnough = self._costEnough and enough

		gohelper.setActive(costItem.go, true)
	end

	for i = #costParam + 1, #self._costItemList do
		local costItem = self._costItemList[i]

		gohelper.setActive(costItem.go, false)
	end
end

function RoomProductLineLevelUpView:_btnclickOnClick(index)
	local costItem = self._costItemList[index]
	local param = costItem.param

	MaterialTipController.instance:showMaterialInfo(param[1], param[2], nil, nil, nil, {
		type = param[1],
		id = param[2],
		quantity = param[3],
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function RoomProductLineLevelUpView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simageproductlineIcon:UnLoadImage()
end

return RoomProductLineLevelUpView
