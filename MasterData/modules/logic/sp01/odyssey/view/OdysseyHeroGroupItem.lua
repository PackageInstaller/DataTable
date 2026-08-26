-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroGroupItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupItem", package.seeall)

local OdysseyHeroGroupItem = class("OdysseyHeroGroupItem", LuaCompBase)

function OdysseyHeroGroupItem:ctor(heroGroupListView)
	self._heroGroupListView = heroGroupListView
end

OdysseyHeroGroupItem.EquipTweenDuration = 0.16
OdysseyHeroGroupItem.EquipDragOffset = Vector2(0, 150)
OdysseyHeroGroupItem.EquipDragMobileScale = 1.7
OdysseyHeroGroupItem.EquipDragOtherScale = 1.4
OdysseyHeroGroupItem.OdysseyEquipDragOtherScale = 1.1
OdysseyHeroGroupItem.PressColor = GameUtil.parseColor("#C8C8C8")

function OdysseyHeroGroupItem:init(go)
	self.go = go
	self._noneGO = gohelper.findChild(go, "heroitemani/none")
	self._addGO = gohelper.findChild(go, "heroitemani/none/add")
	self._lockGO = gohelper.findChild(go, "heroitemani/none/lock")
	self._heroGO = gohelper.findChild(go, "heroitemani/hero")
	self._tagTr = gohelper.findChildComponent(go, "heroitemani/tags", typeof(UnityEngine.Transform))
	self._subGO = gohelper.findChild(go, "heroitemani/tags/aidtag")
	self._aidGO = gohelper.findChild(go, "heroitemani/tags/storytag")
	self._trialTagGO = gohelper.findChild(go, "heroitemani/tags/trialtag")
	self._trialTagTxt = gohelper.findChildTextMesh(go, "heroitemani/tags/trialtag/#txt_trial_tag")
	self._clickGO = gohelper.findChild(go, "heroitemani/click")
	self._clickThis = gohelper.getClick(self._clickGO)
	self._equipGO = gohelper.findChild(go, "heroitemani/equip")
	self._clickEquip = gohelper.getClick(self._equipGO)
	self._charactericon = gohelper.findChild(go, "heroitemani/hero/charactericon")
	self._careericon = gohelper.findChildImage(go, "heroitemani/hero/career")
	self._goblackmask = gohelper.findChild(go, "heroitemani/hero/blackmask")
	self.level_part = gohelper.findChild(go, "heroitemani/hero/vertical/layout")
	self._lvnum = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/lv/lvnum")
	self._lvnumen = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/lv/lvnum/lv")
	self._goRankList = self:getUserDataTb_()

	for i = 1, 3 do
		local rankGO = gohelper.findChildImage(go, "heroitemani/hero/vertical/layout/rankobj/rank" .. i)

		table.insert(self._goRankList, rankGO)
	end

	self._goStarList = self:getUserDataTb_()

	for i = 1, 6 do
		local starGO = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star" .. i)

		table.insert(self._goStarList, starGO)
	end

	self._goStars = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList")
	self._fakeEquipGO = gohelper.findChild(go, "heroitemani/hero/vertical/fakeequip")
	self._dragFrameGO = gohelper.findChild(go, "heroitemani/selectedeffect")
	self._dragFrameSelectGO = gohelper.findChild(go, "heroitemani/selectedeffect/xuanzhong")
	self._dragFrameCompleteGO = gohelper.findChild(go, "heroitemani/selectedeffect/wancheng")

	gohelper.setActive(self._dragFrameGO, false)

	self._emptyEquipGo = gohelper.findChild(go, "heroitemani/emptyequip")
	self._animGO = gohelper.findChild(go, "heroitemani")
	self.anim = self._animGO:GetComponent(typeof(UnityEngine.Animator))
	self._replayReady = gohelper.findChild(go, "heroitemani/hero/replayready")
	self._gorecommended = gohelper.findChild(go, "heroitemani/hero/#go_recommended")
	self._gocounter = gohelper.findChild(go, "heroitemani/hero/#go_counter")
	self._herocardGo = gohelper.findChild(go, "heroitemani/roleequip")
	self._leftDrop = gohelper.findChildDropdown(go, "heroitemani/roleequip/left")
	self._rightDrop = gohelper.findChildDropdown(go, "heroitemani/roleequip/right")
	self._imageAdd = gohelper.findChildImage(go, "heroitemani/none/add")
	self._gomojing = gohelper.findChild(go, "heroitemani/#go_mojing")
	self._gomojingtxt = gohelper.findChildText(go, "heroitemani/#go_mojing/#txt")
	self._commonHeroCard = CommonHeroCard.create(self._charactericon, self._heroGroupListView.viewName)
	self._goOdysseyEquipParent = gohelper.findChild(go, "go_Equip")
end

function OdysseyHeroGroupItem:initEquipItem(getResFunc, getResObj)
	self._odysseyItemList = {}

	local parent = self._goOdysseyEquipParent.transform
	local emptyParentGo = gohelper.clone(self._goOdysseyEquipParent, self._animGO)
	local mainCountConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount)
	local childCount = tonumber(mainCountConstCo.value)

	for i = 1, childCount do
		local child = getResFunc(getResObj, parent.gameObject)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(child.gameObject, OdysseyHeroGroupEquipItem)

		item:setEmptyParent(emptyParentGo.transform)
		self:_odysseyEquipAddDrag(item)
		table.insert(self._odysseyItemList, item)
	end

	self._odysseyEmptyEquipParent = emptyParentGo
	self._odysseyEquipOriginPos = parent.localPosition
	self._odysseyEquipEmptyOriginPos = emptyParentGo.transform.localPosition
end

function OdysseyHeroGroupItem:setIndex(index)
	self._index = index
end

function OdysseyHeroGroupItem:_showMojingTip()
	local showMojingTip = false
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig and episodeConfig.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.Daily then
		showMojingTip = self._index == 3
	end

	gohelper.setActive(self._gomojing, showMojingTip)

	if not showMojingTip then
		return
	end

	self._gomojingtxt.text = luaLang("p_v1a3_herogroup_mojing_" .. tostring(episodeId))
end

function OdysseyHeroGroupItem:setParent(transform)
	self.currentParent = transform

	self._subGO.transform:SetParent(transform, true)
	self._equipGO.transform:SetParent(transform, true)
	self._goOdysseyEquipParent.transform:SetParent(transform, true)
end

function OdysseyHeroGroupItem:flowOriginParent()
	self._equipGO.transform:SetParent(self._animGO.transform, true)
	self._goOdysseyEquipParent.transform:SetParent(self._animGO.transform, true)
end

function OdysseyHeroGroupItem:flowCurrentParent()
	self._equipGO.transform:SetParent(self.currentParent, true)
	self._goOdysseyEquipParent.transform:SetParent(self.currentParent, true)
end

function OdysseyHeroGroupItem:initEquips(equipIndex)
	self._equipType = -1

	if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not self.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(self._equipGO, false)
		gohelper.setActive(self._fakeEquipGO, false)
		gohelper.setActive(self._emptyEquipGo, false)
	else
		gohelper.setActive(self._equipGO, true)
		gohelper.setActive(self._fakeEquipGO, true)
		gohelper.setActive(self._emptyEquipGo, true)

		if not self._equip then
			self._equip = self:getUserDataTb_()
			self._equip.moveContainer = gohelper.findChild(self._equipGO, "moveContainer")
			self._equip.equipIcon = gohelper.findChildImage(self._equipGO, "moveContainer/equipIcon")
			self._equip.equipRare = gohelper.findChildImage(self._equipGO, "moveContainer/equiprare")
			self._equip.equiptxten = gohelper.findChildText(self._equipGO, "equiptxten")
			self._equip.equiptxtlv = gohelper.findChildText(self._equipGO, "moveContainer/equiplv/txtequiplv")
			self._equip.equipGolv = gohelper.findChild(self._equipGO, "moveContainer/equiplv")

			self:_equipIconAddDrag(self._equip.moveContainer, self._equip.equipIcon)
		end

		local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
		local equips = curGroupMO:getPosEquips(self.mo.id - 1).equipUid
		local equipId = equips[1]

		self._equipMO = EquipModel.instance:getEquip(equipId) or HeroGroupTrialModel.instance:getEquipMo(equipId)

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			self._equipMO = nil

			local equip_data = HeroGroupModel.instance:getCurGroupMO().replay_equip_data[self.mo.heroUid]

			if equip_data then
				local tar_config = EquipConfig.instance:getEquipCo(equip_data.equipId)

				if tar_config then
					self._equipMO = {}
					self._equipMO.config = tar_config
					self._equipMO.refineLv = equip_data.refineLv
					self._equipMO.level = equip_data.equipLv
				end
			end
		end

		local trialEquipCO

		if self.trialCO and self.trialCO.equipId > 0 then
			trialEquipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)
		end

		if self._equipMO then
			self._equipType = self._equipMO.config.rare - 2
		elseif trialEquipCO then
			self._equipType = trialEquipCO.rare - 2
		end

		gohelper.setActive(self._equip.equipIcon.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipRare.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipAddGO, not self._equipMO and not trialEquipCO)
		gohelper.setActive(self._equip.equipGolv, self._equipMO or trialEquipCO)
		ZProj.UGUIHelper.SetColorAlpha(self._equip.equiptxten, (self._equipMO or trialEquipCO) and 0.15 or 0.06)

		if self._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, self._equipMO.config.icon)

			local _, _, equipLv = HeroGroupBalanceHelper.getBalanceLv()

			self._equip.equiptxtlv.text = equipLv and equipLv > self._equipMO.level and self._equipMO.equipType == EquipEnum.ClientEquipType.Normal and "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. equipLv or "LV." .. self._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. self._equipMO.config.rare)
			self:_showEquipParticleEffect(equipIndex)
		elseif trialEquipCO then
			local equipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, equipCO.icon)

			self._equip.equiptxtlv.text = "LV." .. self.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. equipCO.rare)
			self:_showEquipParticleEffect(equipIndex)
		end
	end

	self.last_equip = self._equipMO and self._equipMO.uid

	if self._heroMO then
		self.last_hero = self._heroMO.heroId or 0
	end
end

function OdysseyHeroGroupItem:initOdysseyEquips()
	if OdysseyItemModel.instance:haveEquipItem() == false then
		for _, item in ipairs(self._odysseyItemList) do
			item:setActive(false)
		end

		return
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local heroIndex = self.mo.id
	local equipMo = curGroupMO:getOdysseyEquips(heroIndex - 1)

	for index, equipIdParam in ipairs(equipMo.equipUid) do
		local item = self._odysseyItemList[index]

		if not item then
			logError("奥德赛编队界面 装备索引超过上限 index: " .. tostring(index))
		else
			local equipId = tonumber(equipIdParam)

			item:setActive(true)
			item:setInfo(heroIndex, index, equipId, OdysseyEnum.BagType.FightPrepare)
			item:refreshUI()
		end
	end

	local itemCount = #self._odysseyItemList
	local equipCount = #equipMo.equipUid

	if equipCount < itemCount then
		for i = equipCount + 1, itemCount do
			local item = self._odysseyItemList[i]

			item:clear()
			item:setActive(false)
		end
	end
end

function OdysseyHeroGroupItem:_showEquipParticleEffect(equipIndex)
	if equipIndex == self.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function OdysseyHeroGroupItem:_odysseyEquipAddDrag(odysseyItem)
	local scale = OdysseyHeroGroupItem.OdysseyEquipDragOtherScale
	local moveOffset

	if GameUtil.isMobilePlayerAndNotEmulator() then
		moveOffset = OdysseyHeroGroupItem.EquipDragOffset
		scale = OdysseyHeroGroupItem.EquipDragMobileScale
	end

	local param = {}

	param.item = odysseyItem

	CommonDragHelper.instance:registerDragObj(odysseyItem._gonoEmpty, self._onOdysseyItemBeginDrag, nil, self._onOdysseyItemEndDrag, self._checkOdysseyItemDrag, self, param, nil, moveOffset, scale)
end

function OdysseyHeroGroupItem:_checkOdysseyItemDrag(param)
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return true
	end

	local odysseyItem = param.item

	if odysseyItem.isLongParse then
		return true
	end

	if odysseyItem.equipUid == nil or odysseyItem.equipUid == 0 then
		return true
	end

	local index = odysseyItem.heroPos

	if index > OdysseyEnum.MaxHeroGroupCount then
		return true
	end

	return false
end

function OdysseyHeroGroupItem:_onOdysseyItemBeginDrag(param)
	logNormal("onOdysseyItemBeginDrag")

	local currentItem = param.item

	currentItem.isDrag = true

	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function OdysseyHeroGroupItem:_onOdysseyItemEndDrag(param, pointerEventData)
	logNormal("onOdysseyItemEndDrag")

	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + OdysseyHeroGroupItem.EquipDragOffset
	end

	local currentItem = param.item
	local targetItem = self:_moveOdysseyToTarget(pos, currentItem)
	local currentTran = currentItem._gonoEmpty.transform

	if targetItem == nil then
		logNormal("没有合适位置， 返回原处")
		self._setToPos(self, currentTran, Vector2(), true, function()
			self:_setEquipDragEnabled(true)

			currentItem.isDrag = false
		end, self)

		return
	end

	self:_setEquipDragEnabled(false)
	self:_playDragEndAudio()
	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[targetItem.heroPos].parent.gameObject)

	local targetTran = targetItem._gonoEmpty.transform
	local curAnchorPos = recthelper.rectToRelativeAnchorPos(currentItem._goEmpty.transform.position, targetItem._goEmpty.transform)
	local targetAnchorPos = recthelper.rectToRelativeAnchorPos(targetItem._goEmpty.transform.position, currentItem._goEmpty.transform)

	if targetItem:isEmpty() == false then
		self._odysseyTweenId = self:_setToPos(targetTran, curAnchorPos, true)
	end

	logNormal("有合适位置")
	self._setToPos(self, currentTran, targetAnchorPos, true, function()
		if self._odysseyTweenId then
			ZProj.TweenHelper.KillById(self._odysseyTweenId)
		end

		self:_setEquipDragEnabled(true)
		OdysseyHeroGroupController.instance:swapOdysseyEquip(currentItem.heroPos - 1, targetItem.heroPos - 1, currentItem.index, targetItem.index)

		currentItem.isDrag = false
	end, self)
end

function OdysseyHeroGroupItem:_moveOdysseyToTarget(position, item)
	for i, v in ipairs(self._heroGroupListView.odysseyEquipPosList) do
		local odysseyItem = self._heroGroupListView.odysseyEquipItemList[i]

		if odysseyItem:isActive() and (odysseyItem:isEmpty() or odysseyItem.heroPos ~= item.heroPos or odysseyItem.index ~= item.index) then
			local posTr = odysseyItem.go.transform
			local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

			if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
				return odysseyItem
			end
		end
	end

	return nil
end

function OdysseyHeroGroupItem:_equipIconAddDrag(go, icon)
	local image = icon:GetComponent(gohelper.Type_Image)

	image.raycastTarget = true

	local scale = OdysseyHeroGroupItem.EquipDragOtherScale
	local moveOffset

	if GameUtil.isMobilePlayerAndNotEmulator() then
		moveOffset = OdysseyHeroGroupItem.EquipDragOffset
		scale = OdysseyHeroGroupItem.EquipDragMobileScale
	end

	CommonDragHelper.instance:registerDragObj(go, self._onBeginDrag, nil, self._onEndDrag, self._checkDrag, self, go.transform, nil, moveOffset, scale)
end

function OdysseyHeroGroupItem:_checkDrag()
	if self.trialCO and self.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return true
	end

	return false
end

function OdysseyHeroGroupItem:_onBeginDrag()
	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(self._equipGO)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(self._equip.equipGolv, false)
end

function OdysseyHeroGroupItem:_onEndDrag(_, pointerEventData)
	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + OdysseyHeroGroupItem.EquipDragOffset
	end

	local targetHeroItem = self:_moveToTarget(pos)

	self:_setEquipDragEnabled(false)

	if targetHeroItem then
		::label_22_0::

		local var_22_0 = targetHeroItem.trialCO

		if targetHeroItem.trialCO then
			local isTrialDefaultEquip = targetHeroItem.trialCO.equipId > 0

			if not targetHeroItem or targetHeroItem == self or targetHeroItem.mo.aid or isTrialDefaultEquip or not targetHeroItem._equipGO.activeSelf then
				if isTrialDefaultEquip then
					GameFacade.showToast(ToastEnum.TrialCantEditEquip)
				end

				self._setToPos(self, self._equip.moveContainer.transform, Vector2(), true, function()
					gohelper.setActive(self._equip.equipGolv, true)
					self:_setEquipDragEnabled(true)
				end, self)
				self:_showEquipParticleEffect()

				return
			end

			self:_playDragEndAudio(targetHeroItem)
			gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[targetHeroItem.mo.id].parent.gameObject)
			gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)

			local anotherAnchorPos = recthelper.rectToRelativeAnchorPos(self._equipGO.transform.position, targetHeroItem._equipGO.transform)

			self._tweenId = self:_setToPos(targetHeroItem._equip.moveContainer.transform, anotherAnchorPos, true)

			local anchorPos = recthelper.rectToRelativeAnchorPos(targetHeroItem._equipGO.transform.position, self._equipGO.transform)

			self._setToPos(self, self._equip.moveContainer.transform, anchorPos, true, function()
				EquipTeamListModel.instance:openTeamEquip(self.mo.id - 1, self._heroMO)

				if self._tweenId then
					ZProj.TweenHelper.KillById(self._tweenId)
				end

				self:_setToPos(self._equip.moveContainer.transform, Vector2())
				self:_setToPos(targetHeroItem._equip.moveContainer.transform, Vector2())
				gohelper.setActive(self._equip.equipGolv, true)
				self:_setEquipDragEnabled(true)

				local srcPos = self.mo.id - 1
				local targetPos = targetHeroItem.mo.id - 1
				local srcEquipId = EquipTeamListModel.instance:getTeamEquip(srcPos)[1]

				srcEquipId = (EquipModel.instance:getEquip(srcEquipId) or HeroGroupTrialModel.instance:getEquipMo(srcEquipId)) and srcEquipId or nil

				if srcEquipId then
					EquipTeamShowItem.removeEquip(srcPos, true)
				end

				local targetEquipId = EquipTeamListModel.instance:getTeamEquip(targetPos)[1]

				targetEquipId = (EquipModel.instance:getEquip(targetEquipId) or HeroGroupTrialModel.instance:getEquipMo(targetEquipId)) and targetEquipId or nil

				if targetEquipId then
					EquipTeamShowItem.removeEquip(targetPos, true)
				end

				if srcEquipId then
					EquipTeamShowItem.replaceEquip(targetPos, srcEquipId, true)
				end

				if targetEquipId then
					EquipTeamShowItem.replaceEquip(srcPos, targetEquipId, true)
				end

				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
				HeroGroupModel.instance:saveCurGroupData()
			end, self)
		end
	end
end

function OdysseyHeroGroupItem:resetEquipPos()
	if not self._equip then
		return
	end

	local trans = self._equip.moveContainer.transform

	recthelper.setAnchor(trans, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)
end

function OdysseyHeroGroupItem:_playDragEndAudio(targetHeroItem)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function OdysseyHeroGroupItem:_setToPos(transform, anchorPos, tween, callback, callbackObj)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function OdysseyHeroGroupItem:_moveToTarget(position)
	for i, v in ipairs(self._heroGroupListView.heroPosTrList) do
		if self._heroGroupListView._heroItemList[i] ~= self then
			local posTr = v.parent
			local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

			if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
				local heroItem = self._heroGroupListView._heroItemList[i]

				return not heroItem:selfIsLock() and heroItem or nil
			end
		end
	end

	return nil
end

function OdysseyHeroGroupItem:_setEquipDragEnabled(isEnabled)
	CommonDragHelper.instance:setGlobalEnabled(isEnabled)
end

function OdysseyHeroGroupItem:addEventListeners()
	self._clickThis:AddClickListener(self._onClickThis, self)
	self._clickThis:AddClickDownListener(self._onClickThisDown, self)
	self._clickThis:AddClickUpListener(self._onClickThisUp, self)
	self._clickEquip:AddClickListener(self._onClickEquip, self)
	self._clickEquip:AddClickDownListener(self._onClickEquipDown, self)
	self._clickEquip:AddClickUpListener(self._onClickEquipUp, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, self.setHeroGroupEquipEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, self.playHeroGroupHeroEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ChangeEquip, self.initEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self.initEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onBreakSuccess, self.initEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipStrengthenReply, self.initEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipRefineReply, self.initEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.initEquips, self)
end

function OdysseyHeroGroupItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
	self._clickThis:RemoveClickUpListener()
	self._clickThis:RemoveClickDownListener()
	self._clickEquip:RemoveClickListener()
	self._clickEquip:RemoveClickUpListener()
	self._clickEquip:RemoveClickDownListener()
end

function OdysseyHeroGroupItem:playHeroGroupHeroEffect(state)
	self:playAnim(state)

	self.last_equip = nil
	self.last_hero = nil
end

function OdysseyHeroGroupItem:onUpdateMO(mo)
	self._commonHeroCard:setGrayScale(false)

	self.mo = mo
	self._posIndex = self.mo.id - 1
	self._heroMO = mo:getHeroMO()
	self.monsterCO = mo:getMonsterCO()
	self.trialCO = mo:getTrialCO()

	local groupMo = HeroGroupModel.instance:getCurGroupMO()

	gohelper.setActive(self._replayReady, groupMo.isReplay)

	local replay_data

	if groupMo.isReplay then
		replay_data = groupMo.replay_hero_data[self.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, "#E9E9E9")

	for i = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], "#F6F3EC")
	end

	if self._heroMO then
		local heroSkin = HeroModel.instance:getByHeroId(self._heroMO.heroId)

		if replay_data then
			local skinConfig = FightConfig.instance:getSkinCO(replay_data.skin or heroSkin.skin)

			self._commonHeroCard:onUpdateMO(skinConfig)

			if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
				recthelper.setHeight(self._goblackmask.transform, 125)
			else
				recthelper.setHeight(self._goblackmask.transform, 300)
			end

			UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(self._heroMO.config.career))

			if replay_data then
				if not replay_data.level then
					local lv = self._heroMO.level
					local roleLv = HeroGroupBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
					local isBalanceLv

					if lv < roleLv then
						lv = roleLv
						isBalanceLv = true
					end

					local hero_level, hero_rank = HeroConfig.instance:getShowLevel(lv)

					if isBalanceLv then
						SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, HeroGroupBalanceHelper.BalanceColor)

						self._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. hero_level

						for i = 1, 3 do
							SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], HeroGroupBalanceHelper.BalanceIconColor)
						end
					else
						self._lvnum.text = hero_level
					end

					for i = 1, 3 do
						local rankGO = self._goRankList[i]

						gohelper.setActive(rankGO, i == hero_rank - 1)
					end

					gohelper.setActive(self._goStars, true)

					for i = 1, 6 do
						local starGO = self._goStarList[i]

						gohelper.setActive(starGO, i <= CharacterEnum.Star[self._heroMO.config.rare])
					end
				end
			end
		end
	elseif self.monsterCO then
		local skinConfig = FightConfig.instance:getSkinCO(self.monsterCO.skinId)

		self._commonHeroCard:onUpdateMO(skinConfig)
		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(self.monsterCO.career))

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.monsterCO.level)

		self._lvnum.text = showLevel

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == rank - 1)
		end

		gohelper.setActive(self._goStars, false)
	elseif self.trialCO then
		local heroCo = HeroConfig.instance:getHeroCO(self.trialCO.heroId)
		local skinConfig = self.trialCO.skin > 0 and SkinConfig.instance:getSkinCo(self.trialCO.skin) or SkinConfig.instance:getSkinCo(heroCo.skinId)

		if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(self._goblackmask.transform, 125)
		else
			recthelper.setHeight(self._goblackmask.transform, 300)
		end

		self._commonHeroCard:onUpdateMO(skinConfig)
		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(heroCo.career))

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.trialCO.level)

		self._lvnum.text = showLevel

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == rank - 1)
		end

		gohelper.setActive(self._goStars, true)

		for i = 1, 6 do
			local starGO = self._goStarList[i]

			gohelper.setActive(starGO, i <= CharacterEnum.Star[heroCo.rare])
		end
	end

	if self._heroItemContainer then
		self._heroItemContainer.compColor[self._lvnumen] = self._lvnumen.color

		for i = 1, 3 do
			self._heroItemContainer.compColor[self._goRankList[i]] = self._goRankList[i].color
		end
	end

	self.isLock = false
	self.isAidLock = self.mo.aid and self.mo.aid == -1
	self.isAid = self.mo.aid ~= nil
	self.isTrialLock = (self.mo.trial and self.mo.trialPos) ~= nil

	local roleNum = OdysseyHeroGroupModel.instance:getBattleRoleNum()

	self.isRoleNumLock = roleNum and roleNum < self.mo.id
	self.isEmpty = mo:isEmpty()

	gohelper.setActive(self._heroGO, (self._heroMO ~= nil or self.monsterCO ~= nil or self.trialCO ~= nil) and not self.isLock and not self.isRoleNumLock)
	gohelper.setActive(self._noneGO, (self._heroMO ~= nil or self.monsterCO ~= nil or self.trialCO ~= nil) and (self.isLock or self.isAidLock or self.isRoleNumLock) or true)
	gohelper.setActive(self._addGO, self._heroMO == nil and self.monsterCO == nil and self.trialCO == nil and not self.isLock and not self.isAidLock and not self.isRoleNumLock)
	gohelper.setActive(self._lockGO, self:selfIsLock())

	if self.mo.aid then
		local isAid = self.mo.aid ~= -1

		gohelper.setActive(self._aidGO, isAid)
		gohelper.setActive(self._subGO, false)
		transformhelper.setLocalPosXY(self._tagTr, 36.3, self._subGO.activeSelf and 144.1 or 212.1)

		if self.trialCO then
			gohelper.setActive(self._trialTagGO, true)

			self._trialTagTxt.text = luaLang("herogroup_trial_tag0")
		else
			gohelper.setActive(self._trialTagGO, false)
		end

		if not HeroSingleGroupModel.instance:isTemp() and self.isRoleNumLock and self._heroMO ~= nil and self.monsterCO == nil then
			HeroSingleGroupModel.instance:remove(self._heroMO.id)
		end

		self:initEquips()
		self:showCounterSign()

		if self._playDeathAnim then
			self._playDeathAnim = nil

			self:playAnim(UIAnimationName.Open)
		end

		self:_showMojingTip()
		self:initOdysseyEquips()
	end
end

function OdysseyHeroGroupItem:selfIsLock()
	return self.isLock or self.isAidLock or self.isRoleNumLock
end

function OdysseyHeroGroupItem:playRestrictAnimation(needRestrictHeroUidDict)
	if self._heroMO and needRestrictHeroUidDict[self._heroMO.uid] then
		self._playDeathAnim = true

		self:playAnim("herogroup_hero_deal")

		self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)
	end
end

function OdysseyHeroGroupItem:setGrayFactor(value)
	self._commonHeroCard:setGrayFactor(value)
end

function OdysseyHeroGroupItem:resetGrayFactor()
	self._commonHeroCard:setGrayFactor(0)
end

function OdysseyHeroGroupItem:showCounterSign()
	local career

	if self._heroMO then
		local hero_config = lua_character.configDict[self._heroMO.heroId]

		career = hero_config.career
	elseif self.trialCO then
		local heroCo = HeroConfig.instance:getHeroCO(self.trialCO.heroId)

		career = heroCo.career
	elseif self.monsterCO then
		career = self.monsterCO.career
	end

	local haveFightParam = FightModel.instance:getFightParam()
	local heroGroupType = HeroGroupModel.instance:getHeroGroupType()
	local showRecommend = heroGroupType and heroGroupType == OdysseyEnum.HeroGroupType.Fight
	local offset = 0
	local offsetScale = self._goOdysseyEquipParent.transform.localScale.x / self._odysseyEmptyEquipParent.transform.localScale.x

	if showRecommend and haveFightParam then
		local recommended, counter = FightHelper.detectAttributeCounter()
		local isRecommended = tabletool.indexOf(recommended, career)
		local isCounter = tabletool.indexOf(counter, career)

		gohelper.setActive(self._gorecommended, isRecommended)
		gohelper.setActive(self._gocounter, isCounter)

		if isRecommended or isCounter then
			offset = OdysseyEnum.RecommendOffset
		end
	else
		gohelper.setActive(self._gorecommended, false)
		gohelper.setActive(self._gocounter, false)
	end

	recthelper.setAnchorY(self._odysseyEmptyEquipParent.transform, self._odysseyEquipEmptyOriginPos.y + offset)
	recthelper.setAnchorY(self._goOdysseyEquipParent.transform, self._odysseyEquipOriginPos.y + (offset + ((self._goOdysseyEquipParent.transform.parent ~= self._animGO.transform or nil) and OdysseyEnum.CurrentOffset)) * offsetScale)
end

function OdysseyHeroGroupItem:_setUIPressState(graphicCompArr, isPress, oriColorMap)
	if not graphicCompArr then
		return
	end

	local iter = graphicCompArr:GetEnumerator()

	while iter:MoveNext() do
		local color

		if isPress then
			color = oriColorMap and oriColorMap[iter.Current] * 0.7 or OdysseyHeroGroupItem.PressColor
			color.a = iter.Current.color.a
		else
			color = oriColorMap and oriColorMap[iter.Current] or Color.white
		end

		iter.Current.color = color
	end
end

function OdysseyHeroGroupItem:_onClickThis()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if self.mo.aid or self.isRoleNumLock then
		if self.mo.aid == -1 or self.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if self.isLock then
		local lockDesc, param = HeroGroupModel.instance:getPositionLockDesc(self.mo.id)

		GameFacade.showToast(lockDesc, param)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, self.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function OdysseyHeroGroupItem:_onClickThisDown()
	self:_setHeroItemPressState(true)
end

function OdysseyHeroGroupItem:_onClickThisUp()
	self:_setHeroItemPressState(false)
end

function OdysseyHeroGroupItem:_setHeroItemPressState(press)
	if not self._heroItemContainer then
		self._heroItemContainer = self:getUserDataTb_()

		local images = self._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		self._heroItemContainer.images = images

		local tmps = self._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._heroItemContainer.tmps = tmps
		self._heroItemContainer.compColor = {}

		local iter = images:GetEnumerator()

		while iter:MoveNext() do
			self._heroItemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = tmps:GetEnumerator()

		while iter:MoveNext() do
			self._heroItemContainer.compColor[iter.Current] = iter.Current.color
		end
	end

	self._heroItemContainer.spines = self._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	if self._heroItemContainer then
		self:_setUIPressState(self._heroItemContainer.images, press, self._heroItemContainer.compColor)
		self:_setUIPressState(self._heroItemContainer.tmps, press, self._heroItemContainer.compColor)
		self:_setUIPressState(self._heroItemContainer.spines, press)
	end

	if self._imageAdd then
		if press then
			if not OdysseyHeroGroupItem.PressColor then
				self._imageAdd.color = Color.white
			end
		end
	end
end

function OdysseyHeroGroupItem:_onClickEquip()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or self.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		self._viewParam = {
			heroMo = self._heroMO,
			equipMo = self._equipMO,
			posIndex = self._posIndex,
			fromView = EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView
		}

		if self.trialCO then
			self._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(self.trialCO)

			if self.trialCO.equipId > 0 then
				self._viewParam.equipMo = self._viewParam.heroMo.trialEquipMo
			end
		end

		self:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function OdysseyHeroGroupItem:_onClickEquipDown()
	self:_setEquipItemPressState(true)
end

function OdysseyHeroGroupItem:_onClickEquipUp()
	self:_setEquipItemPressState(false)
end

function OdysseyHeroGroupItem:_setEquipItemPressState(press)
	if not self._equipItemContainer then
		self._equipItemContainer = self:getUserDataTb_()
		self._equipEmtpyContainer = self:getUserDataTb_()

		local images = self._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		self._equipItemContainer.images = images

		local tmps = self._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._equipItemContainer.tmps = tmps
		self._equipItemContainer.compColor = {}

		local emptyEquipImages = self._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		self._equipEmtpyContainer.images = emptyEquipImages

		local emptyEquipTmps = self._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._equipEmtpyContainer.tmps = emptyEquipTmps
		self._equipEmtpyContainer.compColor = {}

		local iter = images:GetEnumerator()

		while iter:MoveNext() do
			self._equipItemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = tmps:GetEnumerator()

		while iter:MoveNext() do
			self._equipItemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = emptyEquipImages:GetEnumerator()

		while iter:MoveNext() do
			self._equipEmtpyContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = emptyEquipTmps:GetEnumerator()

		while iter:MoveNext() do
			self._equipEmtpyContainer.compColor[iter.Current] = iter.Current.color
		end
	end

	if self._equipItemContainer then
		self:_setUIPressState(self._equipItemContainer.images, press, self._equipItemContainer.compColor)
		self:_setUIPressState(self._equipItemContainer.tmps, press, self._equipItemContainer.compColor)
	end

	if self._equipEmtpyContainer then
		self:_setUIPressState(self._equipEmtpyContainer.images, press, self._equipEmtpyContainer.compColor)
		self:_setUIPressState(self._equipEmtpyContainer.tmps, press, self._equipEmtpyContainer.compColor)
	end
end

function OdysseyHeroGroupItem:_onOpenEquipTeamView()
	EquipController.instance:openEquipInfoTeamView(self._viewParam)
end

function OdysseyHeroGroupItem:onItemBeginDrag(index)
	if index == self.mo.id then
		ZProj.TweenHelper.DOScale(self.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		ZProj.TweenHelper.DOScale(self._odysseyEmptyEquipParent.transform, 0.682, 0.682, 1, 0.2, nil, nil, nil, EaseType.Linear)
		ZProj.TweenHelper.DOScale(self._goOdysseyEquipParent.transform, 0.682, 0.682, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(self._dragFrameGO, true)
		gohelper.setActive(self._dragFrameSelectGO, true)
		gohelper.setActive(self._dragFrameCompleteGO, false)
	end

	gohelper.setActive(self._clickGO, false)
end

function OdysseyHeroGroupItem:onItemEndDrag(index, dragToIndex)
	ZProj.TweenHelper.DOScale(self.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	ZProj.TweenHelper.DOScale(self._odysseyEmptyEquipParent.transform, 0.62, 0.62, 1, 0.2, nil, nil, nil, EaseType.Linear)
	ZProj.TweenHelper.DOScale(self._goOdysseyEquipParent.transform, 0.62, 0.62, 1, 0.2, nil, nil, nil, EaseType.Linear)
	self:_setHeroItemPressState(false)
end

function OdysseyHeroGroupItem:onItemCompleteDrag(index, dragToIndex, complete)
	if dragToIndex == self.mo.id and index ~= dragToIndex then
		if complete then
			gohelper.setActive(self._dragFrameGO, true)
			gohelper.setActive(self._dragFrameSelectGO, false)
			gohelper.setActive(self._dragFrameCompleteGO, false)
			gohelper.setActive(self._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(self.hideDragEffect, self)
			TaskDispatcher.runDelay(self.hideDragEffect, self, 0.833)
		end
	else
		gohelper.setActive(self._dragFrameGO, false)
	end

	gohelper.setActive(self._clickGO, true)
end

function OdysseyHeroGroupItem:hideDragEffect()
	gohelper.setActive(self._dragFrameGO, false)
end

function OdysseyHeroGroupItem:setHeroGroupEquipEffect(show)
	self._canPlayEffect = show
end

function OdysseyHeroGroupItem:getAnimStateLength(stateName)
	self.clipLengthDict = self.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	local length = self.clipLengthDict[stateName]

	if not length then
		logError("not get animation state name :  " .. tostring(stateName))
	end

	return length or 0
end

function OdysseyHeroGroupItem:playAnim(animName)
	local length = self:getAnimStateLength(animName)

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, length)
	self.anim:Play(animName, 0, 0)
end

function OdysseyHeroGroupItem:getOdysseyEquipItem()
	return self._odysseyItemList
end

function OdysseyHeroGroupItem:onDestroy()
	if self._equip then
		CommonDragHelper.instance:unregisterDragObj(self._equip.moveContainer)
	end

	TaskDispatcher.cancelTask(self._onOpenEquipTeamView, self)
	TaskDispatcher.cancelTask(self.hideDragEffect, self)

	for _, item in ipairs(self._odysseyItemList) do
		CommonDragHelper.instance:unregisterDragObj(item._gonoEmpty)
	end

	if self._odysseyTweenId then
		ZProj.TweenHelper.KillById(self._odysseyTweenId)
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self:_setEquipDragEnabled(true)
end

return OdysseyHeroGroupItem
