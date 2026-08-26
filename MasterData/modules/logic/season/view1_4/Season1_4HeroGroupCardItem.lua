-- chunkname: @modules/logic/season/view1_4/Season1_4HeroGroupCardItem.lua

module("modules.logic.season.view1_4.Season1_4HeroGroupCardItem", package.seeall)

local Season1_4HeroGroupCardItem = class("Season1_4HeroGroupCardItem", UserDataDispose)

Season1_4HeroGroupCardItem.TweenDuration = 0.16
Season1_4HeroGroupCardItem.DragOffset = Vector2(0, 40)
Season1_4HeroGroupCardItem.ZeroPos = Vector2(-2.7, -5)
Season1_4HeroGroupCardItem.ZeroScale = 0.39

function Season1_4HeroGroupCardItem:ctor(go, parent, param)
	self:__onInit()

	self.go = go
	self.parent = parent
	self.transform = go.transform
	self.param = param
	self.slot = param.slot

	self:init()
end

function Season1_4HeroGroupCardItem:init()
	self._gocardempty = gohelper.findChild(self.go, "go_empty")
	self._gocardicon = gohelper.findChild(self.go, "go_card")
	self._trscard = self._gocardicon.transform
	self._gocardlock = gohelper.findChild(self.go, "go_lock")
	self._btncardclick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self.trsRect = self._btncardclick.transform

	self.addClickCb(self, self._btncardclick, self._btnCardClick, self)
	self:AddDrag(self._btncardclick.gameObject)

	local x, y, z = transformhelper.getLocalRotation(self._trscard)

	self.orignRoteZ = z
end

function Season1_4HeroGroupCardItem:AddDrag(go)
	if self._drag then
		return
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function Season1_4HeroGroupCardItem:setData(data, equipId, equipUid, hasTrialEquip)
	self._equipId = equipId
	self._equipUid = equipUid
	self._layer = Activity104Model.instance:getAct104CurLayer()
	self.id = data.id
	self._hasUseSeasonEquipCard = false
	self.hasTrialEquip = hasTrialEquip

	self:updateView()
end

function Season1_4HeroGroupCardItem:setActive(isActive)
	self.isActive = isActive
end

function Season1_4HeroGroupCardItem:updateView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local groupId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)

	self.posUnlock = Activity104Model.instance:isSeasonLayerPosUnlock(actId, groupId, self._layer, self.slot, self.id - 1)
	self.slotUnlock = Activity104Model.instance:isSeasonLayerSlotUnlock(actId, groupId, self._layer, self.slot)

	if self.hasTrialEquip and self:getEquipId(actId, groupId) == 0 then
		self.posUnlock = false
		self.slotUnlock = false
	end

	gohelper.setActive(self._gocardlock, not self.posUnlock)
	gohelper.setActive(self._gocardempty, self.posUnlock)
	gohelper.setActive(self.go, self.slotUnlock)

	if self.posUnlock then
		local equipId = self:getEquipId(actId, groupId)

		if equipId ~= 0 then
			if not self._seasonCardItem then
				self._seasonCardItem = Season1_4CelebrityCardItem.New()

				self._seasonCardItem:init(self._gocardicon, equipId, {
					noClick = true
				})
			else
				gohelper.setActive(self._seasonCardItem.go, true)
				self._seasonCardItem:reset(equipId)
			end

			self._hasUseSeasonEquipCard = true
		else
			if self._seasonCardItem then
				gohelper.setActive(self._seasonCardItem.go, false)
			end

			self:playEmptyUnlockAnim()
		end
	elseif self._seasonCardItem then
		gohelper.setActive(self._seasonCardItem.go, false)
	end
end

function Season1_4HeroGroupCardItem:playEmptyUnlockAnim()
	local actId = Activity104Model.instance:getCurSeasonId()
	local pos = self.id - 1
	local slot = self.slot
	local index = pos == 4 and 9 or pos + 1 + 4 * (slot - 1)

	if Activity104Model.instance:isContainGroupCardUnlockTweenPos(actId, self._layer - 1, index) then
		return
	end

	self._animcardempty = self._animcardempty or self._gocardempty:GetComponent(typeof(UnityEngine.Animator))

	self._animcardempty:Play("lock")
	Activity104Model.instance:setGroupCardUnlockTweenPos(actId, index)
end

function Season1_4HeroGroupCardItem:getEquipId(actId, groupId)
	local groupMo = HeroGroupModel.instance:getCurGroupMO()

	if groupMo and groupMo.isReplay then
		return self._equipId, self._equipUid
	end

	if self._equipId ~= 0 then
		return self._equipId, self._equipUid
	end

	if not self.slot or not self.id then
		return 0
	end

	actId = actId or Activity104Model.instance:getCurSeasonId()
	groupId = groupId or Activity104Model.instance:getSeasonCurSnapshotSubId(actId)

	return Activity104Model.instance:getSeasonHeroGroupEquipId(actId, groupId, self.slot, self.id - 1)
end

function Season1_4HeroGroupCardItem:hasUseSeasonEquipCard()
	return self._hasUseSeasonEquipCard
end

function Season1_4HeroGroupCardItem:_btnCardClick()
	if self.inDrag then
		return
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not self.id then
		return
	end

	local actId = Activity104Model.instance:getCurSeasonId()
	local groupId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)
	local unlock = Activity104Model.instance:isSeasonPosUnlock(actId, groupId, self.slot, self.id - 1)

	if not unlock then
		GameFacade.showToast(ToastEnum.SeasonEquipSlotNotUnlock)

		return
	end

	local param = {}

	param.group = groupId
	param.actId = actId
	param.pos = self.id - 1
	param.slot = self.slot or 1

	Activity104Controller.instance:openSeasonEquipView(param)
end

function Season1_4HeroGroupCardItem:canDrag()
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if not self.posUnlock then
		return false
	end

	local equipId, equipUid = self:getEquipId()

	if not equipId or equipId == 0 or not equipUid then
		return false
	end

	return true
end

function Season1_4HeroGroupCardItem:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	self:killTweenId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setAsLastSibling(self.parent.go)
	gohelper.setAsLastSibling(self.go)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	self:_tweenToPos(self._trscard, anchorPos + Season1_4HeroGroupCardItem.DragOffset, true)

	local scale = Season1_4HeroGroupCardItem.ZeroScale * 1.7

	self.tweenId = ZProj.TweenHelper.DOScale(self._trscard, scale, scale, scale, Season1_4HeroGroupCardItem.TweenDuration)
	self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, 0, Season1_4HeroGroupCardItem.TweenDuration)
	self.inDrag = true
end

function Season1_4HeroGroupCardItem:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	self:_tweenToPos(self._trscard, anchorPos + Season1_4HeroGroupCardItem.DragOffset)

	self.inDrag = true
end

function Season1_4HeroGroupCardItem:_onEndDrag(dragTransform, pointerEventData)
	self.inDrag = false

	if not self:canDrag() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	self:killTweenId()

	local scale = Season1_4HeroGroupCardItem.ZeroScale * 1

	self.tweenId = ZProj.TweenHelper.DOScale(self._trscard, scale, scale, scale, Season1_4HeroGroupCardItem.TweenDuration)

	local targetItem = self:_moveToTarget(pointerEventData.position)

	self:_setDragEnabled(false)

	if not targetItem or not targetItem:canExchange(self) then
		self._setToPos(self, self._trscard, Season1_4HeroGroupCardItem.ZeroPos, true, self._onDragFailTweenEnd, self)

		self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, self.orignRoteZ, Season1_4HeroGroupCardItem.TweenDuration)

		return
	end

	local anchorPos = recthelper.rectToRelativeAnchorPos(targetItem.transform.position, self.transform)

	self._setToPos(self, self._trscard, anchorPos, true, self._onDragSuccessTweenEnd, self, targetItem)

	self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, targetItem.orignRoteZ, Season1_4HeroGroupCardItem.TweenDuration)
end

function Season1_4HeroGroupCardItem:_tweenToPos(transform, anchorPos)
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end

	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		self.posTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, Season1_4HeroGroupCardItem.TweenDuration)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)
	end
end

function Season1_4HeroGroupCardItem:_setToPos(transform, anchorPos, tween, callback, callbackObj, param)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if tween then
		self.moveTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, Season1_4HeroGroupCardItem.TweenDuration, callback, callbackObj, param)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj, param)
		end
	end
end

function Season1_4HeroGroupCardItem:_moveToTarget(position)
	local heroList = self.parent:getHeroItemList()

	if heroList then
		for _, heroItem in pairs(heroList) do
			for i = 1, 2 do
				local cardItem = heroItem[string.format("_cardItem%s", i)]

				if cardItem ~= self then
					local posTr = cardItem.trsRect
					local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

					if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
						return cardItem
					end
				end
			end
		end
	end

	return nil
end

function Season1_4HeroGroupCardItem:_setDragEnabled(isEnabled)
	local heroList = self.parent:getHeroItemList()

	for _, heroItem in ipairs(heroList) do
		for i = 1, 2 do
			local cardItem = heroItem[string.format("_cardItem%s", i)]

			if cardItem then
				cardItem:setDragEnabled(isEnabled)
			end
		end
	end
end

function Season1_4HeroGroupCardItem:setDragEnabled(isEnabled)
	if self._drag then
		self._drag.enabled = isEnabled
	end
end

function Season1_4HeroGroupCardItem:canExchange(targetItem)
	if targetItem == self then
		return false
	end

	if not targetItem.posUnlock or not self.posUnlock then
		return false
	end

	if not targetItem.isActive or not self.isActive then
		return false
	end

	if targetItem.hasTrialEquip or self.hasTrialEquip then
		return false
	end

	local tarEquipId = targetItem:getEquipId()
	local tarPos = targetItem.id - 1
	local tarSlot = targetItem.slot
	local tarCO = SeasonConfig.instance:getSeasonEquipCo(tarEquipId)
	local srcEquipId = self:getEquipId()
	local srcPos = self.id - 1
	local srcSlot = self.slot
	local srcCO = SeasonConfig.instance:getSeasonEquipCo(srcEquipId)
	local maxCount = Activity104EquipItemListModel.instance:getEquipMaxCount(srcPos)
	local actId = Activity104Model.instance:getCurSeasonId()
	local groupId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)

	for i = 1, maxCount do
		if i ~= srcSlot then
			local id = Activity104Model.instance:getSeasonHeroGroupEquipId(actId, groupId, i, srcPos)
			local co = SeasonConfig.instance:getSeasonEquipCo(id)

			if tarCO and co and co.group == tarCO.group and tarPos ~= srcPos then
				GameFacade.showToast(Season1_4EquipItem.Toast_Same_Card)

				return false
			end
		end

		if i ~= tarSlot then
			local id = Activity104Model.instance:getSeasonHeroGroupEquipId(actId, groupId, i, tarPos)
			local co = SeasonConfig.instance:getSeasonEquipCo(id)

			if srcCO and co and co.group == srcCO.group and tarPos ~= srcPos then
				GameFacade.showToast(Season1_4EquipItem.Toast_Same_Card)

				return false
			end
		end
	end

	return true
end

function Season1_4HeroGroupCardItem:_onDragFailTweenEnd()
	self:_setDragEnabled(true)
	gohelper.setAsLastSibling(self.parent._cardItem1.go)
end

function Season1_4HeroGroupCardItem:_onDragSuccessTweenEnd(targetItem)
	self:killTweenId()
	self:_setToPos(self._trscard, Season1_4HeroGroupCardItem.ZeroPos)
	self:_setToPos(targetItem._trscard, Season1_4HeroGroupCardItem.ZeroPos)
	transformhelper.setLocalRotation(self._trscard, 0, 0, self.orignRoteZ)
	self:_setDragEnabled(true)
	gohelper.setAsLastSibling(self.parent._cardItem1.go)

	local targetEquipId, targetEquipUid = targetItem:getEquipId()
	local targetPos = targetItem.id - 1
	local targetSlot = targetItem.slot
	local srcEquipId, srcEquipUid = self:getEquipId()
	local srcPos = self.id - 1
	local srcSlot = self.slot
	local groupId = Activity104Model.instance:getSeasonCurSnapshotSubId()

	Activity104EquipController.instance:exchangeEquip(srcPos, srcSlot, srcEquipUid, targetPos, targetSlot, targetEquipUid, groupId)
end

function Season1_4HeroGroupCardItem:killTweenId()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.rotaTweenId then
		ZProj.TweenHelper.KillById(self.rotaTweenId)

		self.rotaTweenId = nil
	end

	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end

	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end
end

function Season1_4HeroGroupCardItem:destory()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self:killTweenId()
	self:__onDispose()
end

return Season1_4HeroGroupCardItem
