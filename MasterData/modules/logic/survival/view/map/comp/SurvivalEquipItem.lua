-- chunkname: @modules/logic/survival/view/map/comp/SurvivalEquipItem.lua

module("modules.logic.survival.view.map.comp.SurvivalEquipItem", package.seeall)

local SurvivalEquipItem = class("SurvivalEquipItem", LuaCompBase)

function SurvivalEquipItem:init(go)
	self.go = go
	self._golight = gohelper.findChild(go, "#light")
	self._godrag = gohelper.findChild(go, "#go_drag")
	self._goitem = gohelper.findChild(go, "#go_drag/item")
	self._goempty = gohelper.findChild(go, "#go_drag/empty")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#btn_click")
	self._golock = gohelper.findChild(go, "#go_lock")
	self._gonew = gohelper.findChild(go, "#go_new")
	self._goput = gohelper.findChild(go, "#put")
	self._goFrequency = gohelper.findChild(go, "#go_drag/Frequency")
	self._imageFrequency = gohelper.findChildImage(go, "#go_drag/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	self._txtFrequency = gohelper.findChildTextMesh(go, "#go_drag/Frequency/image_NumBG/#txt_Num")
end

function SurvivalEquipItem:addEventListeners()
	CommonDragHelper.instance:registerDragObj(self.go, self._beginDrag, self._onDrag, self._onEndDrag, self._checkDrag, self, nil, true)
	self._btnclick:AddClickListener(self._onClick, self)
end

function SurvivalEquipItem:removeEventListeners()
	CommonDragHelper.instance:unregisterDragObj(self.go)
	self._btnclick:RemoveClickListener()
end

function SurvivalEquipItem:initIndex(index)
	self._index = index
end

function SurvivalEquipItem:setClickCallback(callback, callobj)
	self._callback = callback
	self._callobj = callobj
end

function SurvivalEquipItem:_onClick()
	if not self.mo then
		return
	end

	if not self.mo.unlock then
		GameFacade.showToast(ToastEnum.SurvivalEquipLock)

		return
	end

	if self.mo.newFlag then
		SurvivalWeekRpc.instance:sendSurvivalEquipSetNewFlagRequest({
			self.mo.slotId
		})

		self.mo.newFlag = false

		gohelper.setActive(self._gonew, false)
	end

	self._callback(self._callobj, self._index)
end

function SurvivalEquipItem:setItemRes(itemRes)
	local itemGO = gohelper.clone(itemRes, self._goitem)

	gohelper.setActive(itemGO, true)

	self._item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, SurvivalBagItem)
end

function SurvivalEquipItem:initData(mo, isFirst)
	local isPlayPut = not not (not isFirst and self.mo and mo and not mo.item:isEmpty() and self.mo.item.uid ~= mo.item.uid)

	self.mo = mo

	gohelper.setActive(self.go, mo)

	local isEmpty = not mo or mo.item:isEmpty()
	local isUnLock = mo and mo.unlock

	gohelper.setActive(self._goitem, not isEmpty and isUnLock)
	gohelper.setActive(self._goempty, isEmpty and isUnLock)
	gohelper.setActive(self._golock, not isUnLock)
	gohelper.setActive(self._goFrequency, false)

	if not isEmpty then
		self._isSp = self.mo.item.equipCo.equipType == 1

		self:updateItemMo()

		if self._goFrequency then
			local equipBox = mo.parent
			local maxTagId = equipBox.maxTagId
			local tagCo = lua_survival_equip_found.configDict[maxTagId]

			if tagCo then
				gohelper.setActive(self._goFrequency, true)
				UISpriteSetMgr.instance:setSurvivalSprite(self._imageFrequency, tagCo.value)

				self._txtFrequency.text = self.mo.values[tagCo.value] or 0
			end
		end
	end

	if mo then
		gohelper.setActive(self._gonew, mo.newFlag)
	end

	if isPlayPut then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_put_2)
		gohelper.setActive(self._goput, false)
		gohelper.setActive(self._goput, true)
	end
end

function SurvivalEquipItem:updateItemMo()
	self._item:updateMo(self.mo.item)
end

function SurvivalEquipItem:setParentRoot(root)
	self._root = root
	self._rawRoot = self.go.transform.parent
end

function SurvivalEquipItem:_beginDrag()
	self.go.transform:SetParent(self._root, true)
end

function SurvivalEquipItem:_onDrag(_, pointerEventData)
	local position = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(position, self.go.transform)
	local trans = self._godrag.transform
	local curAnchorX, curAnchorY = recthelper.getAnchor(trans)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(trans, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)
	end

	local index, equipItem = self._parentView:getDragIndex(pointerEventData.position, self._isSp)

	if equipItem ~= self and equipItem ~= self._curOverEquip then
		if self._curOverEquip then
			self._curOverEquip:setLightActive(false)
		end

		self._curOverEquip = equipItem

		if self._curOverEquip then
			self._curOverEquip:setLightActive(true)
		end
	end
end

function SurvivalEquipItem:setLightActive(isActive)
	if not self.mo or not self.mo.unlock then
		return
	end

	gohelper.setActive(self._golight, isActive)
end

function SurvivalEquipItem:_onEndDrag(_, pointerEventData)
	if self._curOverEquip then
		self._curOverEquip:setLightActive(false)

		self._curOverEquip = nil
	end

	local index, equipItem = self._parentView:getDragIndex(pointerEventData.position, self._isSp)

	if index == -1 then
		local trans = self._godrag.transform

		ZProj.TweenHelper.DOAnchorPos(trans, 0, 0, 0.2)

		if not self._isSp then
			SurvivalWeekRpc.instance:sendSurvivalEquipDemount(self._index)
		else
			SurvivalWeekRpc.instance:sendSurvivalJewelryEquipDemount(self._index)
		end
	elseif not index or index == self._index or not self:canMoveToIndex(index) then
		local trans = self._godrag.transform

		ZProj.TweenHelper.DOAnchorPos(trans, 0, 0, 0.2)
	else
		self._tweenToIndex = index
		self._tweenToItem = equipItem

		UIBlockHelper.instance:startBlock("SurvivalEquipItem_Tween", 0.2)
		equipItem:moveTo(self)
		self.moveTo(self, equipItem, self.moveEnd, self)
	end

	self.go.transform:SetParent(self._rawRoot, true)
end

function SurvivalEquipItem:moveTo(item, callback, callobj)
	local position = recthelper.uiPosToScreenPos(item.go.transform)
	local anchorPos = recthelper.screenPosToAnchorPos(position, self.go.transform)
	local trans = self._godrag.transform

	ZProj.TweenHelper.DOAnchorPos(trans, anchorPos.x, anchorPos.y, 0.2, callback, callobj)
end

function SurvivalEquipItem:moveEnd()
	if self._isSp then
		SurvivalWeekRpc.instance:sendSurvivalJewelryEquipWear(self._tweenToIndex, self.mo.item.uid, self._onRecvMsg, self)
	else
		SurvivalWeekRpc.instance:sendSurvivalEquipWear(self._tweenToIndex, self.mo.item.uid, self._onRecvMsg, self)
	end
end

function SurvivalEquipItem:_onRecvMsg()
	local trans = self._godrag.transform

	recthelper.setAnchor(trans, 0, 0)

	local trans2 = self._tweenToItem._godrag.transform

	recthelper.setAnchor(trans2, 0, 0)
end

function SurvivalEquipItem:canMoveToIndex(index)
	local equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox
	local slots = equipBox.slots

	if not slots[index] then
		return false
	end

	if not slots[index].unlock then
		GameFacade.showToast(ToastEnum.SurvivalEquipLock)

		return false
	end

	if self.mo.item.equipLevel > slots[index].level then
		GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

		return false
	end

	if not slots[index].item:isEmpty() and slots[index].item.equipLevel > self.mo.level then
		GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

		return false
	end

	return true
end

function SurvivalEquipItem:_checkDrag()
	if not self.mo or self.mo.item:isEmpty() then
		return true
	end
end

function SurvivalEquipItem:setParentView(view)
	self._parentView = view
end

return SurvivalEquipItem
