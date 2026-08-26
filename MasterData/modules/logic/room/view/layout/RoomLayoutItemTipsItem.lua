-- chunkname: @modules/logic/room/view/layout/RoomLayoutItemTipsItem.lua

module("modules.logic.room.view.layout.RoomLayoutItemTipsItem", package.seeall)

local RoomLayoutItemTipsItem = class("RoomLayoutItemTipsItem", ListScrollCellExtend)

function RoomLayoutItemTipsItem:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "content")
	self._gobuildingicon = gohelper.findChild(self.viewGO, "content/#go_buildingicon")
	self._godikuaiicon = gohelper.findChild(self.viewGO, "content/#go_dikuaiicon")
	self._txtname = gohelper.findChildText(self.viewGO, "content/#txt_name")
	self._txtnum = gohelper.findChildText(self.viewGO, "content/#txt_num")
	self._txtdegree = gohelper.findChildText(self.viewGO, "content/#txt_degree")
	self._gobtnbuy = gohelper.findChild(self.viewGO, "#btn_buy")
	self._gocanbuy = gohelper.findChild(self.viewGO, "#btn_buy/canBuy")
	self._gonotcanbuy = gohelper.findChild(self.viewGO, "#btn_buy/notCanBuy")
	self._btnbuy = gohelper.getClickWithDefaultAudio(self._gobtnbuy)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutItemTipsItem:addEvents()
	self._btnbuy:AddClickListener(self._onBtnBuyClick, self)
end

function RoomLayoutItemTipsItem:removeEvents()
	self._btnbuy:RemoveClickListener()
end

function RoomLayoutItemTipsItem:_onBtnBuyClick()
	local mo = self._layoutItemMO
	local type = mo and mo.materialType
	local id = mo and mo.itemId
	local goodsId = StoreConfig.instance:getRoomProductGoodsId(type, id)
	local isCanBuy = self:isCanBuyGoods()

	if goodsId then
		::label_4_0::

		local goodsMo = StoreModel.instance:getGoodsMO(goodsId)

		if goodsMo and isCanBuy then
			StoreController.instance:checkAndOpenStoreView(tonumber(goodsMo.config.storeId), goodsId)
		else
			GameFacade.showToast(ToastEnum.RoomNoneGoods)
		end
	end
end

function RoomLayoutItemTipsItem:_editableInitView()
	self._canvasGroup = gohelper.onceAddComponent(self._gocontent, gohelper.Type_CanvasGroup)
end

function RoomLayoutItemTipsItem:_editableAddEvents()
	return
end

function RoomLayoutItemTipsItem:_editableRemoveEvents()
	return
end

function RoomLayoutItemTipsItem:onUpdateMO(mo)
	self._layoutItemMO = mo

	self:_refreshUI()
end

function RoomLayoutItemTipsItem:onSelect(isSelect)
	return
end

function RoomLayoutItemTipsItem:_refreshUI()
	local mo = self._layoutItemMO

	if not mo then
		return
	end

	local itemCfg = mo:getItemConfig()

	if not itemCfg then
		logError(string.format("itemId:%s itemType:%s not find itemConfig.", mo.itemId, mo.itemType))

		return
	end

	gohelper.setActive(self._gobuildingicon, mo:isBuilding())
	gohelper.setActive(self._godikuaiicon, mo:isBlockPackage() or mo:isSpecialBlock())

	if not mo.itemNum then
		local blockNum = 0
		local degree = 0
		local isLack = mo:isLack()

		if mo:isBuilding() then
			local buildParam = RoomMapModel.instance:getBuildingConfigParam(mo.itemId)

			blockNum = buildParam and buildParam.pointList and #buildParam.pointList or 0
			degree = itemCfg.buildDegree or 0
		elseif mo:isBlockPackage() then
			degree = (itemCfg.blockBuildDegree or 0) * blockNum
		elseif mo:isSpecialBlock() then
			local packCfg = RoomConfig.instance:getBlockPackageConfig(RoomBlockPackageEnum.ID.RoleBirthday)

			degree = packCfg and packCfg.blockBuildDegree or 0
		end

		self._txtname.text = isLack and formatLuaLang("room_layoutplan_namemask_lack", itemCfg.name) or itemCfg.name
		self._txtnum.text = blockNum
		self._txtdegree.text = degree
		self._canvasGroup.alpha = isLack and 0.3 or 1

		self:refreshBtnBuy()
	end
end

function RoomLayoutItemTipsItem:refreshBtnBuy()
	local isShowBuy = false
	local mo = self._layoutItemMO

	if self._view and self._view.viewParam and self._view.viewParam.showBuy then
		isShowBuy = mo and mo:isLack()
	end

	if isShowBuy then
		local isCanBuy = self:isCanBuyGoods()

		gohelper.setActive(self._gocanbuy, isCanBuy)
		gohelper.setActive(self._gonotcanbuy, not isCanBuy)
	end

	gohelper.setActive(self._gobtnbuy, isShowBuy)
end

function RoomLayoutItemTipsItem:isCanBuyGoods()
	local isTimeEnd = true
	local isSoldOut = true
	local mo = self._layoutItemMO
	local type = mo and mo.materialType
	local id = mo and mo.itemId
	local goodsId = StoreConfig.instance:getRoomProductGoodsId(type, id)

	if goodsId then
		::label_12_0::

		local goodsMo = StoreModel.instance:getGoodsMO(goodsId)

		if goodsMo then
			if goodsMo:getIsActivityGoods() then
				local status = ActivityHelper.getActivityStatus(goodsMo.config.activityId)

				isTimeEnd = status ~= ActivityEnum.ActivityStatus.Normal
			else
				local serverTime = ServerTime.now()

				if goodsMo:getIsPackageGoods() then
					local bindGoodsMO = StoreModel.instance:getGoodsMO(goodsMo.config.bindgoodid)

					if bindGoodsMO then
						local onlineTime = TimeUtil.stringToTimestamp(bindGoodsMO.config.onlineTime)
						local offlineTime = TimeUtil.stringToTimestamp(bindGoodsMO.config.offlineTime)

						isTimeEnd = serverTime < onlineTime or offlineTime <= serverTime
					else
						isTimeEnd = true
					end
				else
					local offlineTime = goodsMo:getOfflineTime()

					isTimeEnd = offlineTime > 0 and offlineTime <= serverTime
				end
			end

			isSoldOut = goodsMo:isSoldOut()
		end

		return not isTimeEnd and not isSoldOut
	end
end

function RoomLayoutItemTipsItem:onDestroyView()
	return
end

return RoomLayoutItemTipsItem
