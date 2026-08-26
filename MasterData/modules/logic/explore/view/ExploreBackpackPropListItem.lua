-- chunkname: @modules/logic/explore/view/ExploreBackpackPropListItem.lua

module("modules.logic.explore.view.ExploreBackpackPropListItem", package.seeall)

local ExploreBackpackPropListItem = class("ExploreBackpackPropListItem", LuaCompBase)

function ExploreBackpackPropListItem:init(go)
	self.go = go
	self._goinuse = gohelper.findChild(self.go, "#go_inuse")
	self._click = gohelper.findChildButton(self.go, "#btn_click")

	self._click:AddClickListener(self._onItemClick, self)

	self._simagepropicon = gohelper.findChildSingleImage(self.go, "#simage_propicon")
	self._simageusepropicon = gohelper.findChildSingleImage(self.go, "#go_inuse/#simage_propicon")
	self._goselect = gohelper.findChild(self.go, "#go_selected")
	self._txtname = gohelper.findChildTextMesh(self.go, "#go_selected/#txt_propname")
	self._btnIconDetail = gohelper.findChildButton(self.go, "#go_selected/#txt_propname/icon")
end

function ExploreBackpackPropListItem:addEventListeners()
	self.addEventCb(self, ExploreController.instance, ExploreEvent.UseItemChanged, self._updateUsing, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.MapStatusChange, self.onMapStatusChange, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnHeroMoveEnd, self.onHeroMoveEnd, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.ExploreLightBallEnterExit, self.onLightBallChange, self)
	self._btnIconDetail:AddClickListener(self.onDetailClick, self)
end

function ExploreBackpackPropListItem:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.UseItemChanged, self._updateUsing, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.MapStatusChange, self.onMapStatusChange, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnHeroMoveEnd, self.onHeroMoveEnd, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.ExploreLightBallEnterExit, self.onLightBallChange, self)
	self._btnIconDetail:RemoveClickListener()
end

function ExploreBackpackPropListItem:onUpdateMO(data)
	self._mo = data

	local icon = ResUrl.getPropItemIcon(data.config.icon)

	self._simagepropicon:LoadImage(icon)
	self._simageusepropicon:LoadImage(icon)
	self:_updateUsing(ExploreModel.instance:getUseItemUid())

	self._txtname.text = self._mo.config.name

	self:onMapStatusChange(ExploreController.instance:getMap():getNowStatus())
end

function ExploreBackpackPropListItem:onLightBallChange()
	if not self._mo then
		return
	end

	local effect = self._mo.itemEffect

	if effect == ExploreEnum.ItemEffect.CreateUnit2 then
		self:_updateUsing()
	end
end

function ExploreBackpackPropListItem:_updateUsing(useItemUid)
	if not self._mo then
		return
	end

	local effect = self._mo.itemEffect
	local isUsing = useItemUid == self._mo.id

	if effect == ExploreEnum.ItemEffect.CreateUnit2 then
		local unit = ExploreController.instance:getMap():getUnit(tonumber(self._mo.id), true)

		isUsing = not not unit
	end

	gohelper.setActive(self._goinuse, isUsing)
end

function ExploreBackpackPropListItem:_onItemClick()
	local effect = self._mo.itemEffect

	if effect == ExploreEnum.ItemEffect.Fix then
		ToastController.instance:showToast(ExploreConstValue.Toast.UseWithFixPrism)

		return
	end

	if not ExploreModel.instance:isHeroInControl() then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end

	local map = ExploreController.instance:getMap()

	if map:getNowStatus() == ExploreEnum.MapStatus.UseItem then
		local mo = map:getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo()

		map:setMapStatus(ExploreEnum.MapStatus.Normal)

		if mo == self._mo then
			return
		end
	elseif map:getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantUseItem)

		return
	end

	local usingId = ExploreModel.instance:getUseItemUid()
	local usingUnit = map:getUnit(tonumber(usingId), true)

	if usingUnit and usingUnit:getUnitType() == ExploreEnum.ItemType.PipePot then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end

	local hero = ExploreController.instance:getMap():getHero()

	if hero:isMoving() then
		local heroPos = hero.nodePos
		local key = ExploreHelper.getKey(heroPos)
		local node = ExploreMapModel.instance:getNode(key)

		if node.nodeType == ExploreEnum.NodeType.Ice then
			return
		end
	end

	if hero:isMoving() then
		if not hero:stopMoving() then
			return
		end

		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.UseItem)

		self._waitHeroMoveEnd = true

		return
	end

	if effect == ExploreEnum.ItemEffect.CreateUnit2 then
		local unit = ExploreController.instance:getMap():getUnit(tonumber(self._mo.id), true)

		if unit then
			hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.UseItem, true, true)
			ExploreRpc.instance:sendExploreUseItemRequest(self._mo.id, 0, 0)

			return
		end
	end

	if effect == ExploreEnum.ItemEffect.Active then
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.UseItem, true, true)
	end

	if self._mo.isActiveTypeItem then
		ExploreRpc.instance:sendExploreUseItemRequest(self._mo.id, 0, 0)
	else
		ExploreController.instance:dispatchEvent(ExploreEvent.DragItemBegin, self._mo)
	end
end

function ExploreBackpackPropListItem:onHeroMoveEnd()
	if self._waitHeroMoveEnd then
		self._waitHeroMoveEnd = nil

		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UseItem)
		self:_onItemClick()
	end
end

function ExploreBackpackPropListItem:onDetailClick()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.ExploreGetItemView, {
		id = self._mo.itemId
	})
end

function ExploreBackpackPropListItem:onMapStatusChange(status)
	if status == ExploreEnum.MapStatus.UseItem then
		local mo = ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo()

		if mo == self._mo then
			gohelper.setActive(self._goselect, true)
		else
			gohelper.setActive(self._goselect, false)
		end
	else
		gohelper.setActive(self._goselect, false)
	end
end

function ExploreBackpackPropListItem:onDestroyView()
	self._click:RemoveClickListener()

	if self._simagepropicon then
		self._simagepropicon:UnLoadImage()

		self._simagepropicon = nil
	end

	if self._simageusepropicon then
		self._simageusepropicon:UnLoadImage()

		self._simageusepropicon = nil
	end
end

return ExploreBackpackPropListItem
