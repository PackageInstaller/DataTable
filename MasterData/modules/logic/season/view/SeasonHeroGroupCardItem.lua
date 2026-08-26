-- chunkname: @modules/logic/season/view/SeasonHeroGroupCardItem.lua

module("modules.logic.season.view.SeasonHeroGroupCardItem", package.seeall)

local SeasonHeroGroupCardItem = class("SeasonHeroGroupCardItem", UserDataDispose)

SeasonHeroGroupCardItem.TweenDuration = 0.16
SeasonHeroGroupCardItem.DragOffset = Vector2(0, 40)
SeasonHeroGroupCardItem.ZeroPos = Vector2(-2.7, -5)
SeasonHeroGroupCardItem.ZeroScale = 0.39

function SeasonHeroGroupCardItem:ctor(go, parent, param)
	self:__onInit()

	self.go = go
	self.parent = parent
	self.transform = go.transform
	self.param = param
	self.slot = param.slot

	self:init()
end

function SeasonHeroGroupCardItem:init()
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

function SeasonHeroGroupCardItem:AddDrag(go)
	if self._drag then
		return
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function SeasonHeroGroupCardItem:setData(data, layer, equipId, equipUid)
	self._equipId = equipId
	self._equipUid = equipUid
	self._layer = layer or Activity104Model.instance:getAct104CurLayer()
	self.id = data.id
	self._hasUseSeasonEquipCard = false

	self:updateView()
end

function SeasonHeroGroupCardItem:updateView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local groupId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)

	self.posUnlock = Activity104Model.instance:isSeasonLayerPosUnlock(actId, groupId, self._layer, self.slot, self.id - 1)
	self.slotUnlock = Activity104Model.instance:isSeasonLayerSlotUnlock(actId, groupId, self._layer, self.slot)

	gohelper.setActive(self._gocardlock, not self.posUnlock)
	gohelper.setActive(self._gocardempty, self.posUnlock)
	gohelper.setActive(self.go, self.slotUnlock)

	if self.posUnlock then
		local equipId = self:getEquipId(actId, groupId)

		if equipId ~= 0 then
			if not self._seasonCardItem then
				self._seasonCardItem = SeasonCelebrityCardItem.New()

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

function SeasonHeroGroupCardItem:playEmptyUnlockAnim()
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

function SeasonHeroGroupCardItem:getEquipId(actId, groupId)
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

function SeasonHeroGroupCardItem:hasUseSeasonEquipCard()
	return self._hasUseSeasonEquipCard
end

function SeasonHeroGroupCardItem:_btnCardClick()
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

function SeasonHeroGroupCardItem:canDrag()
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

function SeasonHeroGroupCardItem:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	self:killTweenId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setAsLastSibling(self.parent.go)
	gohelper.setAsLastSibling(self.go)

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	self:_tweenToPos(self._trscard, anchorPos + SeasonHeroGroupCardItem.DragOffset, true)

	local scale = SeasonHeroGroupCardItem.ZeroScale * 1.7

	self.tweenId = ZProj.TweenHelper.DOScale(self._trscard, scale, scale, scale, SeasonHeroGroupCardItem.TweenDuration)
	self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, 0, SeasonHeroGroupCardItem.TweenDuration)
	self.inDrag = true
end

function SeasonHeroGroupCardItem:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.transform)

	self:_tweenToPos(self._trscard, anchorPos + SeasonHeroGroupCardItem.DragOffset)

	self.inDrag = true
end

function SeasonHeroGroupCardItem:_onEndDrag(dragTransform, pointerEventData)
	self.inDrag = false

	if not self:canDrag() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	self:killTweenId()

	local scale = SeasonHeroGroupCardItem.ZeroScale * 1

	self.tweenId = ZProj.TweenHelper.DOScale(self._trscard, scale, scale, scale, SeasonHeroGroupCardItem.TweenDuration)

	local targetItem = self:_moveToTarget(pointerEventData.position)

	self:_setDragEnabled(false)

	if not targetItem or not targetItem:canExchange(self) then
		self._setToPos(self, self._trscard, SeasonHeroGroupCardItem.ZeroPos, true, self._onDragFailTweenEnd, self)

		self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, self.orignRoteZ, SeasonHeroGroupCardItem.TweenDuration)

		return
	end

	local anchorPos = recthelper.rectToRelativeAnchorPos(targetItem.transform.position, self.transform)

	self._setToPos(self, self._trscard, anchorPos, true, self._onDragSuccessTweenEnd, self, targetItem)

	self.rotaTweenId = ZProj.TweenHelper.DOLocalRotate(self._trscard, 0, 0, targetItem.orignRoteZ, SeasonHeroGroupCardItem.TweenDuration)
end

function SeasonHeroGroupCardItem:_tweenToPos(transform, anchorPos)
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end

	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		self.posTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, SeasonHeroGroupCardItem.TweenDuration)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)
	end
end

function SeasonHeroGroupCardItem:_setToPos(transform, anchorPos, tween, callback, callbackObj, param)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if tween then
		self.moveTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, SeasonHeroGroupCardItem.TweenDuration, callback, callbackObj, param)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj, param)
		end
	end
end

function SeasonHeroGroupCardItem:_moveToTarget(position)
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

function SeasonHeroGroupCardItem:_setDragEnabled(isEnabled)
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

function SeasonHeroGroupCardItem:setDragEnabled(isEnabled)
	if self._drag then
		self._drag.enabled = isEnabled
	end
end

function SeasonHeroGroupCardItem:canExchange(targetItem)
	if targetItem == self then
		return false
	end

	if not targetItem.posUnlock or not self.posUnlock then
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
				GameFacade.showToast(SeasonEquipItem.Toast_Same_Card)

				return false
			end
		end

		if i ~= tarSlot then
			local id = Activity104Model.instance:getSeasonHeroGroupEquipId(actId, groupId, i, tarPos)
			local co = SeasonConfig.instance:getSeasonEquipCo(id)

			if srcCO and co and co.group == srcCO.group and tarPos ~= srcPos then
				GameFacade.showToast(SeasonEquipItem.Toast_Same_Card)

				return false
			end
		end
	end

	return true
end

function SeasonHeroGroupCardItem:_onDragFailTweenEnd()
	self:_setDragEnabled(true)
	gohelper.setAsLastSibling(self.parent._cardItem1.go)
end

function SeasonHeroGroupCardItem:_onDragSuccessTweenEnd(targetItem)
	self:killTweenId()
	self:_setToPos(self._trscard, SeasonHeroGroupCardItem.ZeroPos)
	self:_setToPos(targetItem._trscard, SeasonHeroGroupCardItem.ZeroPos)
	transformhelper.setLocalRotation(self._trscard, 0, 0, self.orignRoteZ)
	self:_setDragEnabled(true)
	gohelper.setAsLastSibling(self.parent._cardItem1.go)

	local targetEquipId, targetEquipUid = targetItem:getEquipId()
	local targetPos = targetItem.id - 1
	local targetSlot = targetItem.slot
	local srcEquipId, srcEquipUid = self:getEquipId()
	local srcPos = self.id - 1
	local srcSlot = self.slot
	local actId = Activity104Model.instance:getCurSeasonId()
	local groupId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)

	Activity104EquipController.instance:exchangeEquip(srcPos, srcSlot, srcEquipUid, targetPos, targetSlot, targetEquipUid, actId, groupId)
end

function SeasonHeroGroupCardItem:killTweenId()
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

function SeasonHeroGroupCardItem:destory()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self:killTweenId()
	self:__onDispose()
end

return SeasonHeroGroupCardItem
