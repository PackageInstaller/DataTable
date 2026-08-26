-- chunkname: @modules/logic/room/view/RoomLevelUpTipsView.lua

module("modules.logic.room.view.RoomLevelUpTipsView", package.seeall)

local RoomLevelUpTipsView = class("RoomLevelUpTipsView", BaseView)
local COST_FONT_SIZE = 43

function RoomLevelUpTipsView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "#simage_maskbg")
	self._txttype = gohelper.findChildText(self.viewGO, "title/#txt_type")
	self._gopreviouslevel = gohelper.findChild(self.viewGO, "levelup/previous/node/#go_previouslevel")
	self._txtpreviouslv = gohelper.findChildText(self.viewGO, "levelup/previous/#txt_previouslv")
	self._gocurrentlevel = gohelper.findChild(self.viewGO, "levelup/current/node/#go_currentlevel")
	self._txtcurrentlv = gohelper.findChildText(self.viewGO, "levelup/current/#txt_currentlv")
	self._goinfo = gohelper.findChild(self.viewGO, "levelupInfo/#go_info")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLevelUpTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomLevelUpTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomLevelUpTipsView:_btncloseOnClick()
	self:closeThis()
end

function RoomLevelUpTipsView:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(self._gopreviouslevel, false)
	gohelper.setActive(self._gocurrentlevel, false)
	gohelper.setActive(self._goinfo, false)

	self._previousLevelItemList = {}
	self._currentLevelItemList = {}
	self._infoItemList = {}
	self._btnclose = gohelper.findChildClickWithAudio(self.viewGO, "bg")
end

function RoomLevelUpTipsView:_refreshLevel(itemList, go, currentLevel, maxLevel)
	for level = 1, maxLevel do
		local item = itemList[level]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(go, "item" .. level)
			item.golight = gohelper.findChild(item.go, "active")

			table.insert(itemList, item)
		end

		gohelper.setActive(item.golight, level <= currentLevel)
		gohelper.setActive(item.go, true)
	end

	for i = maxLevel + 1, #itemList do
		local item = itemList[i]

		gohelper.setActive(item.go, false)
	end
end

function RoomLevelUpTipsView:_playLevelAnimation(itemList, level)
	if not itemList or #itemList <= 0 then
		return
	end

	for i = 1, level do
		local item = itemList[i]

		gohelper.setActive(item.golight, false)
	end

	local delay = 0.6
	local interval = 0.06
	local duration = delay + (level - 1) * interval

	self._levelTweenId = self._scene and self._scene.tween and self._scene.tween:tweenFloat(0, duration, duration, self._levelAnimationFrame, self._levelAnimationFinish, self, {
		delay = delay,
		interval = interval,
		level = level,
		duration = duration,
		itemList = itemList
	}) or ZProj.TweenHelper.DOTweenFloat(0, duration, duration, self._levelAnimationFrame, self._levelAnimationFinish, self, {
		delay = delay,
		interval = interval,
		level = level,
		duration = duration,
		itemList = itemList
	})
end

function RoomLevelUpTipsView:_levelAnimationFrame(value, param)
	for i = 1, param.level do
		local item = param.itemList[i]

		gohelper.setActive(item.golight, value >= param.delay + (i - 1) * param.interval)
	end
end

function RoomLevelUpTipsView:_levelAnimationFinish(param)
	self:_levelAnimationFrame(param.duration + 0.001, param)
end

function RoomLevelUpTipsView:onOpen()
	if self.viewParam.level then
		self:_updateLevelInfo(self.viewParam.level)
	elseif self.viewParam.buildingUid then
		self:_updateBuildingLevelInfo(self.viewParam.buildingUid)
	else
		self:_updateProductLineLevelInfo(self.viewParam.productLineMO)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function RoomLevelUpTipsView:_updateLevelInfo(level)
	self._txttype.text = luaLang("room_level_up")
	self._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", level - 1)
	self._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", level)

	local maxLevel = RoomConfig.instance:getMaxRoomLevel()

	self:_refreshLevel(self._previousLevelItemList, self._gopreviouslevel, level - 1, maxLevel)
	self:_refreshLevel(self._currentLevelItemList, self._gocurrentlevel, level, maxLevel)
	self:_playLevelAnimation(self._currentLevelItemList, level)

	local params = RoomProductionHelper.getRoomLevelUpParams(level - 1, level, true)

	self:_refreshDescTips(params)
end

function RoomLevelUpTipsView:_updateBuildingLevelInfo(buildingUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	self._txttype.text = luaLang("room_building_level_up")

	local maxLevel, preLevel, level = 0, 0, 0

	if buildingMO then
		level = buildingMO:getLevel()
		preLevel = Mathf.Max(0, level - 1)
	end

	self._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", preLevel)
	self._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", level)

	self:_refreshLevel(self._previousLevelItemList, self._gopreviouslevel, preLevel, maxLevel)
	self:_refreshLevel(self._currentLevelItemList, self._gocurrentlevel, level, maxLevel)
	self:_playLevelAnimation(self._currentLevelItemList, level)

	local params = RoomHelper.getBuildingLevelUpTipsParam(buildingUid)

	self:_refreshDescTips(params)
end

function RoomLevelUpTipsView:_updateProductLineLevelInfo(productLineMO)
	self._txttype.text = luaLang("room_production_line_level_up")
	self._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", productLineMO.level - 1)
	self._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", productLineMO.level)

	self:_refreshLevel(self._previousLevelItemList, self._gopreviouslevel, productLineMO.level - 1, productLineMO.maxLevel)
	self:_refreshLevel(self._currentLevelItemList, self._gocurrentlevel, productLineMO.level, productLineMO.maxLevel)
	self:_playLevelAnimation(self._currentLevelItemList, productLineMO.level)

	local params = RoomProductionHelper.getProductLineLevelUpParams(productLineMO.id, productLineMO.level - 1, productLineMO.level, true)

	self:_refreshDescTips(params)
end

function RoomLevelUpTipsView:_refreshDescTips(params)
	for i, param in ipairs(params) do
		local item = self._infoItemList[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._goinfo, "item" .. i)
			item.trans = item.go.transform
			item.gonormal = gohelper.findChild(item.go, "#go_normal")
			item.txtinfo = gohelper.findChildText(item.go, "#go_normal/txt_info")
			item.gohasNewItem = gohelper.findChild(item.go, "#go_hasNewItem")
			item.txtnewItemInfo = gohelper.findChildText(item.go, "#go_hasNewItem/txt_newItemInfo")
			item.goNewItemLayout = gohelper.findChild(item.go, "#go_hasNewItem/#go_newItemLayout")
			item.goNewItem = gohelper.findChild(item.go, "#go_hasNewItem/#go_newItemLayout/#go_newItem")

			table.insert(self._infoItemList, item)
		end

		local isShowNewItem = not not param.newItemInfoList
		local infoItemHeight = recthelper.getHeight(item.trans)

		if isShowNewItem then
			infoItemHeight = recthelper.getHeight(item.goNewItemLayout.transform)
			item.txtnewItemInfo.text = param.desc

			gohelper.CreateObjList(self, self._onSetNewItem, param.newItemInfoList, item.goNewItemLayout, item.goNewItem)
		else
			item.txtinfo.text = param.desc
		end

		recthelper.setHeight(item.trans, infoItemHeight)
		gohelper.setActive(item.gonormal, not isShowNewItem)
		gohelper.setActive(item.gohasNewItem, isShowNewItem)
		gohelper.setActive(item.go, true)
	end

	for i = #params + 1, #self._infoItemList do
		local item = self._infoItemList[i]

		gohelper.setActive(item.go, false)
	end
end

function RoomLevelUpTipsView:_onSetNewItem(obj, data, index)
	local newItemType = data.type
	local newItemId = data.id

	if not data.quantity then
		local newItemQuantity = 0
		local itemIcon = IconMgr.instance:getCommonItemIcon(obj)

		itemIcon:setCountFontSize(COST_FONT_SIZE)
		itemIcon:setMOValue(newItemType, newItemId, newItemQuantity)
		itemIcon:isShowCount(newItemQuantity ~= 0)
	end
end

function RoomLevelUpTipsView:onClose()
	return
end

function RoomLevelUpTipsView:onDestroyView()
	if self._levelTweenId then
		if self._scene and self._scene.tween then
			self._scene.tween:killById(self._levelTweenId)
		else
			ZProj.TweenHelper.KillById(self._levelTweenId)
		end

		self._levelTweenId = nil
	end
end

return RoomLevelUpTipsView
