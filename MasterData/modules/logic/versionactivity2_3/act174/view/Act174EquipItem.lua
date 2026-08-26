-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174EquipItem.lua

module("modules.logic.versionactivity2_3.act174.view.Act174EquipItem", package.seeall)

local Act174EquipItem = class("Act174EquipItem", LuaCompBase)

function Act174EquipItem:ctor(act174TeamView)
	self._teamView = act174TeamView
end

function Act174EquipItem:init(go)
	self._go = go
	self._imageQuality = gohelper.findChildImage(go, "image_quality")
	self._simageCollection = gohelper.findChildSingleImage(go, "simage_Collection")
	self._goEmpty = gohelper.findChild(go, "go_Empty")
	self._click = gohelper.findChildClick(go, "")

	CommonDragHelper.instance:registerDragObj(go, self.beginDrag, nil, self.endDrag, self.checkDrag, self)
end

function Act174EquipItem:addEventListeners()
	self._click:AddClickListener(self.onClick, self)
end

function Act174EquipItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function Act174EquipItem:onDestroy()
	self._simageCollection:UnLoadImage()
	CommonDragHelper.instance:unregisterDragObj(self._go)
end

function Act174EquipItem:setIndex(index)
	self._index = index

	local teamCnt = self._teamView.unLockTeamCnt
	local row = Activity174Helper.CalculateRowColumn(index)

	gohelper.setActive(self._go, row <= teamCnt)
end

function Act174EquipItem:setData(collectionId)
	self._collectionId = collectionId

	if collectionId then
		local config = lua_activity174_collection.configDict[collectionId]

		UISpriteSetMgr.instance:setAct174Sprite(self._imageQuality, "act174_propitembg_" .. config.rare)
		self._simageCollection:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))
	else
		self._simageCollection:UnLoadImage()
	end

	gohelper.setActive(self._imageQuality, collectionId)
	gohelper.setActive(self._simageCollection, collectionId)
	gohelper.setActive(self._goEmpty, not collectionId)
end

function Act174EquipItem:onClick()
	if self.tweenId or self.isDraging then
		return
	end

	self._teamView:clickCollection(self._index)
end

function Act174EquipItem:beginDrag()
	gohelper.setAsLastSibling(self._go)

	self.isDraging = true
end

function Act174EquipItem:endDrag(_, pointerEventData)
	self.isDraging = false

	local pos = pointerEventData.position
	local targetItem = self:findTarget(pos)

	if not targetItem then
		local targetTr = self._teamView.frameTrList[self._index]
		local x, y = recthelper.getAnchor(targetTr)

		self.setToPos(self, self._go.transform, Vector2(x, y), true, self.tweenCallback, self)
		self._teamView:UnInstallCollection(self._index)
	else
		local from = self._index
		local to = targetItem._index

		if self._teamView:canEquipMove(from, to) then
			local targetTr = self._teamView.frameTrList[to]
			local x, y = recthelper.getAnchor(targetTr)

			self.setToPos(self, self._go.transform, Vector2(x, y), true, self.tweenCallback, self)

			if targetItem ~= self then
				local tr = self._teamView.frameTrList[self._index]
				local i, j = recthelper.getAnchor(tr)

				self.setToPos(self, targetItem._go.transform, Vector2(i, j), true, function()
					self._teamView:exchangeEquipItem(self._index, to)
				end, self)
			end
		else
			GameFacade.showToast(ToastEnum.Act174OnlyCollection)

			local targetTr = self._teamView.frameTrList[self._index]
			local x, y = recthelper.getAnchor(targetTr)

			self.setToPos(self, self._go.transform, Vector2(x, y), true, self.tweenCallback, self)
		end
	end
end

function Act174EquipItem:checkDrag()
	if self._collectionId and self._collectionId ~= 0 then
		return false
	end

	return true
end

function Act174EquipItem:findTarget(position)
	for i = 1, self._teamView.unLockTeamCnt * 4 do
		local framTr = self._teamView.frameTrList[i]
		local equipItem = self._teamView.equipItemList[i]
		local x, y = recthelper.getAnchor(framTr)
		local posTr = framTr.parent
		local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

		if math.abs(anchorPos.x - x) * 2 < recthelper.getWidth(framTr) and math.abs(anchorPos.y - y) * 2 < recthelper.getHeight(framTr) then
			return equipItem or nil
		end
	end

	return nil
end

function Act174EquipItem:setToPos(transform, anchorPos, tween, callback, callbackObj)
	if tween then
		CommonDragHelper.instance:setGlobalEnabled(false)

		self.tweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act174EquipItem:tweenCallback()
	self.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

return Act174EquipItem
