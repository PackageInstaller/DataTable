-- chunkname: @modules/logic/room/view/building/RoomGoodsItem.lua

module("modules.logic.room.view.building.RoomGoodsItem", package.seeall)

local RoomGoodsItem = class("RoomGoodsItem", ListScrollCellExtend)

function RoomGoodsItem:onInitView()
	self._imagerare = gohelper.findChildImage(self.viewGO, "#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._gorarecircle = gohelper.findChild(self.viewGO, "#go_rarecircle")
	self._gocountbg = gohelper.findChild(self.viewGO, "countbg")
	self._txtcount = gohelper.findChildText(self.viewGO, "countbg/#txt_count")
	self._click = gohelper.getClick(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomGoodsItem:addEventListeners()
	self._click:AddClickListener(self._onClick, self)
end

function RoomGoodsItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function RoomGoodsItem:_editableInitView()
	self._isEnableClick = true
	self._rareCircleTabs = self:getUserDataTb_()

	for i = 5, 4, -1 do
		local rareGO = gohelper.findChild(self._gorarecircle, "#go_rare" .. i)
		local rareItem = {
			id = i,
			go = rareGO
		}

		table.insert(self._rareCircleTabs, rareItem)
	end
end

function RoomGoodsItem:onUpdateMO(mo)
	self:setMOValue(mo.materilType, mo.materilId, mo.quantity)
end

function RoomGoodsItem:setMOValue(materilType, materilId, quantity, colorStr)
	self._itemType = tonumber(materilType)
	self._itemId = materilId
	self._itemQuantity = tonumber(quantity)

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId)

	self._config = config

	self._simageicon:LoadImage(icon)

	if config.rare then
		if not config.rare then
			local rare = 5

			UISpriteSetMgr.instance:setRoomSprite(self._imagerare, "bg_wupindi_" .. tostring(ItemEnum.Color[rare]))

			if rare >= 4 then
				for k, v in ipairs(self._rareCircleTabs) do
					gohelper.setActive(v.go, v.id == rare)
				end
			end

			self._colorStr = colorStr
			self._txtcount.text = string.nilorempty(self._colorStr) and GameUtil.numberDisplay(self._itemQuantity) or string.format("<color=%s>%s</color>", self._colorStr, GameUtil.numberDisplay(self._itemQuantity))
		end
	end
end

function RoomGoodsItem:isEnableClick(flag)
	self._isEnableClick = flag
end

function RoomGoodsItem:setRecordFarmItem(needSetRecordFarm)
	self.needSetRecordFarm = needSetRecordFarm
end

function RoomGoodsItem:setConsume(consume)
	self._isConsume = consume
end

function RoomGoodsItem:_onClick(forceClick)
	if not self._isEnableClick and not forceClick then
		return
	end

	if self._customCallback then
		return self._customCallback(self.params)
	end

	if self.needSetRecordFarm then
		local recordFarmItem = {
			type = self._itemType,
			id = self._itemId,
			quantity = self._itemQuantity,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		}

		MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId, self._inPack, nil, nil, recordFarmItem, nil, self._itemQuantity, self._isConsume, self.jumpFinishCallback, self.jumpFinishCallbackObj, self.jumpFinishCallbackParam)
	else
		MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId, self._inPack, nil, nil)
	end
end

function RoomGoodsItem:customOnClickCallback(callback, params)
	self._customCallback = callback
	self.params = params
end

function RoomGoodsItem:setCountText(str)
	self._txtcount.text = str
end

function RoomGoodsItem:canShowRareCircle(flag)
	gohelper.setActive(self._gorarecircle, flag)
end

function RoomGoodsItem:setIconPos(posX, posY)
	recthelper.setAnchor(self._simageicon.transform, posX, posY)
end

function RoomGoodsItem:setIconScale(scale)
	transformhelper.setLocalScale(self._simageicon.transform, scale, scale, scale)
end

function RoomGoodsItem:setCountPos(posX, posY)
	recthelper.setAnchor(self._gocountbg.transform, posX, posY)
end

function RoomGoodsItem:setCountScale(scale)
	transformhelper.setLocalScale(self._gocountbg.transform, scale, scale, scale)
end

function RoomGoodsItem:isShowCount(flag)
	gohelper.setActive(self._gocountbg, flag)
end

function RoomGoodsItem:setGrayscale(grayscale)
	ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, grayscale)
	ZProj.UGUIHelper.SetGrayscale(self._imagerare.gameObject, grayscale)
end

function RoomGoodsItem:setJumpFinishCallback(callback, callbackObj, param)
	self.jumpFinishCallback = callback
	self.jumpFinishCallbackObj = callbackObj
	self.jumpFinishCallbackParam = param
end

function RoomGoodsItem:onSelect(isSelect)
	return
end

function RoomGoodsItem:onDestroyView()
	if self._simageicon then
		self._simageicon:UnLoadImage()
	end
end

return RoomGoodsItem
