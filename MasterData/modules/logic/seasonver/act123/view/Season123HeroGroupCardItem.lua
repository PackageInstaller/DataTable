-- chunkname: @modules/logic/seasonver/act123/view/Season123HeroGroupCardItem.lua

module("modules.logic.seasonver.act123.view.Season123HeroGroupCardItem", package.seeall)

local Season123HeroGroupCardItem = class("Season123HeroGroupCardItem", UserDataDispose)

Season123HeroGroupCardItem.TweenDuration = 0.16
Season123HeroGroupCardItem.DragOffset = Vector2(0, 40)
Season123HeroGroupCardItem.ZeroPos = Vector2(-2.7, -5)
Season123HeroGroupCardItem.ZeroScale = 0.39

function Season123HeroGroupCardItem:ctor(go, parent, param)
	self:__onInit()

	self.go = go
	self.parent = parent
	self.transform = go.transform
	self.param = param
	self.slot = param.slot

	self:init()
end

function Season123HeroGroupCardItem:init()
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

function Season123HeroGroupCardItem:AddDrag(go)
	if self._drag then
		return
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function Season123HeroGroupCardItem:setData(data, layer, equipId, equipUid, hasTrialEquip)
	self._equipId = equipId
	self._equipUid = equipUid
	self._layer = layer or Season123HeroGroupModel.instance.layer
	self.id = data.id
	self._hasUseSeasonEquipCard = false
	self.hasTrialEquip = hasTrialEquip

	self:updateView()
end

function Season123HeroGroupCardItem:setActive(isActive)
	self.isActive = isActive
end

function Season123HeroGroupCardItem:updateView()
	local actId = Season123HeroGroupModel.instance.activityId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local groupId = seasonMO.heroGroupSnapshotSubId

	self.posUnlock = Season123HeroGroupModel.instance:isEquipCardPosUnlock(self.slot, self.id - 1)
	self.slotUnlock = Season123HeroGroupModel.instance:isSlotNeedShow(self.slot)

	if self.hasTrialEquip and self:getEquipId(actId, groupId) == 0 then
		self.posUnlock = false
		self.slotUnlock = false
	end

	gohelper.setActive(self._gocardlock, not self.posUnlock)
	gohelper.setActive(self._gocardempty, self.posUnlock)
	gohelper.setActive(self.go, self.slotUnlock)

	if self.posUnlock then
		local equipId = self:getEquipId(actId, groupId)

		if equipId ~= nil and equipId ~= 0 then
			if not self._seasonCardItem then
				self._seasonCardItem = Season123CelebrityCardItem.New()

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

function Season123HeroGroupCardItem:playEmptyUnlockAnim()
	local pos = self.id - 1
	local slot = self.slot
	local index = Season123Model.instance:getUnlockCardIndex(pos, slot)

	if Season123HeroGroupModel.instance:isContainGroupCardUnlockTweenPos(index) then
		return
	end

	self._animcardempty = self._animcardempty or self._gocardempty:GetComponent(typeof(UnityEngine.Animator))

	self._animcardempty:Play("lock")
	Season123HeroGroupModel.instance:saveGroupCardUnlockTweenPos(index)
end

function Season123HeroGroupCardItem:getEquipId(actId, groupId)
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

	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	groupId = groupId or seasonMO.heroGroupSnapshotSubId

	return Season123HeroGroupUtils.getHeroGroupEquipCardId(seasonMO, groupId, self.slot, self.id - 1)
end

function Season123HeroGroupCardItem:hasUseSeasonEquipCard()
	return self._hasUseSeasonEquipCard
end

function Season123HeroGroupCardItem:_btnCardClick()
	if self.inDrag then
		return
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not self.id then
		return
	end

	local actId = Season123HeroGroupModel.instance.activityId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local groupId = seasonMO.heroGroupSnapshotSubId
	local unlock = Season123HeroGroupModel.instance:isEquipCardPosUnlock(self.slot, self.id - 1)

	if not unlock then
		GameFacade.showToast(ToastEnum.SeasonEquipSlotNotUnlock)

		return
	end

	local var_10_0 = {
		group = groupId,
		actId = actId,
		pos = self.id - 1
	}

	var_10_0.slot = self.slot or 1
	var_10_0.layer = self._layer
	var_10_0.stage = Season123HeroGroupModel.instance.stage

	local param = var_10_0

	Season123Controller.instance:openSeasonEquipView(param)
end

function Season123HeroGroupCardItem:canDrag()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if not self.posUnlock then
		return false
	end

	local equipId = self:getEquipId()

	if not equipId or equipId == 0 then
		return false
	end

	return true
end

function Season123HeroGroupCardItem:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	self:killTweenId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setAsLastSibling(self.parent.go)
	gohelper.setAsLastSibling(self.go)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	self:_tweenToPos(self._trscard, anchorPos + Season123HeroGroupCardItem.DragOffset, true)

	local scale = Season123HeroGroupCardItem.ZeroScale * 1.7

	self.tweenId = ZProj.TweenHelper.DOScale(self._trscard, scale, scale, scale, Season123HeroGroupCardItem.TweenDuration)
	self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, 0, Season123HeroGroupCardItem.TweenDuration)
	self.inDrag = true
end

function Season123HeroGroupCardItem:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	self:_tweenToPos(self._trscard, anchorPos + Season123HeroGroupCardItem.DragOffset)

	self.inDrag = true
end

function Season123HeroGroupCardItem:_onEndDrag(dragTransform, pointerEventData)
	self.inDrag = false

	if not self:canDrag() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	self:killTweenId()

	local scale = Season123HeroGroupCardItem.ZeroScale * 1

	self.tweenId = ZProj.TweenHelper.DOScale(self._trscard, scale, scale, scale, Season123HeroGroupCardItem.TweenDuration)

	local targetItem = self:_moveToTarget(pointerEventData.position)

	self:_setDragEnabled(false)

	if not targetItem or not targetItem:canExchange(self) then
		self._setToPos(self, self._trscard, Season123HeroGroupCardItem.ZeroPos, true, self._onDragFailTweenEnd, self)

		self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, self.orignRoteZ, Season123HeroGroupCardItem.TweenDuration)

		return
	end

	local anchorPos = recthelper.rectToRelativeAnchorPos(targetItem.transform.position, self.transform)

	self._setToPos(self, self._trscard, anchorPos, true, self._onDragSuccessTweenEnd, self, targetItem)

	self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, targetItem.orignRoteZ, Season123HeroGroupCardItem.TweenDuration)
end

function Season123HeroGroupCardItem:_tweenToPos(transform, anchorPos)
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end

	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		self.posTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, Season123HeroGroupCardItem.TweenDuration)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)
	end
end

function Season123HeroGroupCardItem:_setToPos(transform, anchorPos, tween, callback, callbackObj, param)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if tween then
		self.moveTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, Season123HeroGroupCardItem.TweenDuration, callback, callbackObj, param)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj, param)
		end
	end
end

function Season123HeroGroupCardItem:_moveToTarget(position)
	local heroList = self.parent:getHeroItemList()

	if heroList then
		for index, heroItem in pairs(heroList) do
			local maxCount = Season123EquipItemListModel.instance:getEquipMaxCount(index - 1)

			for i = 1, maxCount do
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

function Season123HeroGroupCardItem:_setDragEnabled(isEnabled)
	local heroList = self.parent:getHeroItemList()

	for i, heroItem in ipairs(heroList) do
		for j = 1, 2 do
			local cardItem = heroItem[string.format("_cardItem%s", j)]

			if cardItem then
				cardItem:setDragEnabled(isEnabled)
			end
		end
	end
end

function Season123HeroGroupCardItem:setDragEnabled(isEnabled)
	if self._drag then
		self._drag.enabled = isEnabled
	end
end

function Season123HeroGroupCardItem:canExchange(targetItem)
	if targetItem == self then
		return false
	end

	if not targetItem.posUnlock or not self.posUnlock then
		return false
	end

	if targetItem.hasTrialEquip or self.hasTrialEquip then
		return false
	end

	if not targetItem.isActive or not self.isActive then
		return false
	end

	local tarEquipId = targetItem:getEquipId()
	local tarPos = targetItem.id - 1
	local tarSlot = targetItem.slot
	local tarCO = Season123Config.instance:getSeasonEquipCo(tarEquipId)
	local srcEquipId = self:getEquipId()
	local srcPos = self.id - 1
	local srcSlot = self.slot
	local srcCO = Season123Config.instance:getSeasonEquipCo(srcEquipId)
	local maxCount = Season123EquipItemListModel.instance:getEquipMaxCount(srcPos)
	local actId = Season123HeroGroupModel.instance.activityId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local groupId = seasonMO.heroGroupSnapshotSubId

	for i = 1, maxCount do
		if i ~= srcSlot then
			local id = Season123HeroGroupUtils.getHeroGroupEquipCardId(seasonMO, groupId, i, srcPos)
			local co = Season123Config.instance:getSeasonEquipCo(id)

			if tarCO and co and co.group == tarCO.group and tarPos ~= srcPos then
				GameFacade.showToast(Season123EquipItem.Toast_Same_Card)

				return false
			end
		end

		if i ~= tarSlot then
			local id = Season123HeroGroupUtils.getHeroGroupEquipCardId(seasonMO, groupId, i, tarPos)
			local co = Season123Config.instance:getSeasonEquipCo(id)

			if srcCO and co and co.group == srcCO.group and tarPos ~= srcPos then
				GameFacade.showToast(Season123EquipItem.Toast_Same_Card)

				return false
			end
		end
	end

	local isLimitSrc, posStrSrc = Season123HeroGroupModel.instance:isCardPosLimit(tarEquipId, srcPos)
	local isLimitTar, posStrTar = Season123HeroGroupModel.instance:isCardPosLimit(srcEquipId, tarPos)

	if isLimitSrc or isLimitTar then
		if isLimitSrc then
			GameFacade.showToast(Season123EquipItem.Toast_Pos_Wrong, posStrSrc)
		end

		if isLimitTar then
			GameFacade.showToast(Season123EquipItem.Toast_Pos_Wrong, posStrTar)
		end

		return false
	end

	return true
end

function Season123HeroGroupCardItem:canMoveToPos(tarPos)
	local itemId = self:getEquipId()

	if not itemId then
		return true
	else
		local isLimit, limitStr = Season123HeroGroupModel.instance:isCardPosLimit(itemId, tarPos)

		return not Season123HeroGroupModel.instance:isCardPosLimit(itemId, tarPos), limitStr
	end
end

function Season123HeroGroupCardItem:_onDragFailTweenEnd()
	self:_setDragEnabled(true)
	gohelper.setAsLastSibling(self.parent._cardItem1.go)
end

function Season123HeroGroupCardItem:_onDragSuccessTweenEnd(targetItem)
	self:killTweenId()
	self:_setToPos(self._trscard, Season123HeroGroupCardItem.ZeroPos)
	self:_setToPos(targetItem._trscard, Season123HeroGroupCardItem.ZeroPos)
	transformhelper.setLocalRotation(self._trscard, 0, 0, self.orignRoteZ)
	self:_setDragEnabled(true)
	gohelper.setAsLastSibling(self.parent._cardItem1.go)

	local targetEquipId, targetEquipUid = targetItem:getEquipId()
	local targetPos = targetItem.id - 1
	local targetSlot = targetItem.slot
	local srcEquipId, srcEquipUid = self:getEquipId()
	local srcPos = self.id - 1
	local srcSlot = self.slot
	local actId = Season123HeroGroupModel.instance.activityId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local groupId = seasonMO.heroGroupSnapshotSubId

	Season123EquipController.instance:exchangeEquip(srcPos, srcSlot, srcEquipUid, targetPos, targetSlot, targetEquipUid, groupId)
end

function Season123HeroGroupCardItem:killTweenId()
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

function Season123HeroGroupCardItem:destory()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self:killTweenId()
	self:__onDispose()
end

return Season123HeroGroupCardItem
