-- chunkname: @modules/logic/season/view1_2/Season1_2HeroGroupHeroItem.lua

module("modules.logic.season.view1_2.Season1_2HeroGroupHeroItem", package.seeall)

local Season1_2HeroGroupHeroItem = class("Season1_2HeroGroupHeroItem", LuaCompBase)

function Season1_2HeroGroupHeroItem:ctor(Season1_2HeroGroupListView)
	self._Season1_2HeroGroupListView = Season1_2HeroGroupListView
end

function Season1_2HeroGroupHeroItem:init(go)
	self.go = go
	self._goheroitem = gohelper.findChild(go, "heroitemani")
	self.anim = self._goheroitem:GetComponent(typeof(UnityEngine.Animator))
	self._subGO = gohelper.findChild(go, "heroitemani/aidtag")
	self._aidGO = gohelper.findChild(go, "heroitemani/storytag")
	self._gonone = gohelper.findChild(go, "heroitemani/none")
	self._goadd = gohelper.findChild(go, "heroitemani/none/add")
	self._golock = gohelper.findChild(go, "heroitemani/none/lock")
	self._gohero = gohelper.findChild(go, "heroitemani/hero")
	self._simagecharactericon = gohelper.findChildSingleImage(go, "heroitemani/hero/charactericon")
	self._imagecareericon = gohelper.findChildImage(go, "heroitemani/hero/career")
	self._goblackmask = gohelper.findChild(go, "heroitemani/hero/blackmask")
	self._gostarroot = gohelper.findChild(go, "heroitemani/equipcard/#go_starList")
	self._gostars = self:getUserDataTb_()

	for i = 1, 6 do
		self._gostars[i] = gohelper.findChild(go, "heroitemani/equipcard/#go_starList/star" .. i)
	end

	self._txtlvnum = gohelper.findChildText(go, "heroitemani/equipcard/vertical/layout/lv/lvnum")
	self._goranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._goranks[i] = gohelper.findChild(go, "heroitemani/equipcard/vertical/layout/rankobj/rank" .. i)
	end

	self._goequipcard = gohelper.findChild(go, "heroitemani/equipcard")
	self._goequip = gohelper.findChild(go, "heroitemani/equipcard/vertical/equip")
	self._btnclickequip = gohelper.getClick(self._goequip)
	self._gofakeequip = gohelper.findChild(go, "heroitemani/equipcard/vertical/fakeequip")
	self._goreplayready = gohelper.findChild(go, "heroitemani/hero/replayready")
	self._goclick = gohelper.findChild(go, "heroitemani/click")
	self._btnclickitem = gohelper.getClick(self._goclick)
	self._goselectdebuff = gohelper.findChild(go, "heroitemani/selectedeffect")
	self._goselected = gohelper.findChild(go, "heroitemani/selectedeffect/xuanzhong")
	self._gofinished = gohelper.findChild(go, "heroitemani/selectedeffect/wancheng")
	self._goroleequip = gohelper.findChild(go, "heroitemani/roleequip")
	self._droproleequipleft = gohelper.findChildDropdown(go, "heroitemani/roleequip/left")
	self._droproleequipright = gohelper.findChildDropdown(go, "heroitemani/roleequip/right")
	self._goflags = gohelper.findChild(go, "heroitemani/hero/go_flags")
	self._gorecommended = gohelper.findChild(go, "heroitemani/hero/go_flags/go_recommended")
	self._gocounter = gohelper.findChild(go, "heroitemani/hero/go_flags/go_counter")
	self._goseason = gohelper.findChild(go, "heroitemani/equipcard")
	self._goboth = gohelper.findChild(go, "heroitemani/equipcard/go_both")
	self._gosingle = gohelper.findChild(go, "heroitemani/equipcard/go_single")
	self._gocardlist = gohelper.findChild(go, "heroitemani/equipcard/cardlist")
	self._gocarditem1 = gohelper.findChild(go, "heroitemani/equipcard/cardlist/carditem1")
	self._cardItem1 = Season1_2HeroGroupCardItem.New(self._gocarditem1, self, {
		slot = 1
	})
	self._gocarditem2 = gohelper.findChild(go, "heroitemani/equipcard/cardlist/carditem2")
	self._cardItem2 = Season1_2HeroGroupCardItem.New(self._gocarditem2, self, {
		slot = 2
	})
	self._goherolvLayout = gohelper.findChild(go, "heroitemani/equipcard/vertical/layout")

	self:_initData()
	self:_addEvents()
end

function Season1_2HeroGroupHeroItem:onUpdateMO(mo)
	self.mo = mo
	self._heroMO = mo:getHeroMO()
	self._monsterCo = mo:getMonsterCO()
	self._posIndex = self.mo.id - 1

	ZProj.UGUIHelper.SetGrayscale(self._simagecharactericon.gameObject, false)

	local curHeroGroupMo = HeroGroupModel.instance:getCurGroupMO()

	gohelper.setActive(self._goreplayready, curHeroGroupMo.isReplay)

	if self._heroMO then
		if curHeroGroupMo.isReplay then
			if not curHeroGroupMo.replay_hero_data[self.mo.heroUid] then
				local replay_data

				if replay_data then
					local level, rank = HeroConfig.instance:getShowLevel(replay_data.level or self._heroMO.level)

					self._txtlvnum.text = level

					if replay_data then
						local skinConfig = FightConfig.instance:getSkinCO(replay_data.skin or self._heroMO.skin)

						self._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
						UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "lssx_" .. tostring(self._heroMO.config.career))

						for i = 1, 3 do
							gohelper.setActive(self._goranks[i], i == rank - 1)
						end

						for i = 1, 6 do
							gohelper.setActive(self._gostars[i], i <= CharacterEnum.Star[self._heroMO.config.rare])
						end
					end
				end
			end
		end
	elseif self._monsterCo then
		local skinConfig = FightConfig.instance:getSkinCO(self._monsterCo.skinId)
		local characterCfg = lua_character.configDict[skinConfig.characterId]

		self._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "lssx_" .. tostring(self._monsterCo.career))

		local level, rank = HeroConfig.instance:getShowLevel(self._monsterCo.level)

		self._txtlvnum.text = level

		for i = 1, 3 do
			gohelper.setActive(self._goranks[i], i == rank - 1)
		end

		for i = 1, 6 do
			gohelper.setActive(self._gostars[i], i <= CharacterEnum.Star[characterCfg.rare])
		end
	end

	self.isLock = not HeroGroupModel.instance:isPositionOpen(self.mo.id)
	self.isAidLock = self.mo.aid and self.mo.aid == -1
	self.isAid = self.mo.aid ~= nil

	local roleNum = HeroGroupModel.instance:getBattleRoleNum()

	self.isRoleNumLock = roleNum and roleNum < self.mo.id
	self.isEmpty = mo:isEmpty()

	if not self._heroMO then
		local isHeroShow = true

		if self._monsterCo then
			isHeroShow = not self.isLock and not self.isRoleNumLock or false
		end

		gohelper.setActive(self._gohero, isHeroShow)
		gohelper.setActive(self._gostarroot, isHeroShow)
		gohelper.setActive(self._goherolvLayout, isHeroShow)

		local isNoneShow = true
		local isNoneShow

		if self._heroMO or self._monsterCo then
			isNoneShow = self.isLock or self.isAidLock or self.isRoleNumLock
		end

		gohelper.setActive(self._gonone, isNoneShow)

		local isAddShow = not self._heroMO and not self._monsterCo and not self.isLock and not self.isAidLock and not self.isRoleNumLock

		gohelper.setActive(self._goadd, isAddShow)
		gohelper.setActive(self._golock, self.isLock or self.isAidLock or self.isRoleNumLock)
		gohelper.setActive(self._aidGO, self.mo.aid and self.mo.aid ~= -1)

		if self.isRoleNumLock and self._heroMO ~= nil and self._monsterCo == nil then
			HeroSingleGroupModel.instance:remove(self._heroMO.id)

			local actId = Activity104Model.instance:getCurSeasonId()
			local subId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)
			local extraData = {}

			extraData.groupIndex = subId
			extraData.heroGroup = Activity104Model.instance:getSnapshotHeroGroupBySubId(subId)

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, extraData)
		end

		gohelper.setActive(self._subGO, self:checkSubGoVisable())
		self:_updateSeasonEquips()
		self:showCounterSign()

		if self._playDeathAnim then
			self._playDeathAnim = nil

			self.anim:Play("open", 0, 0)
		end
	end
end

function Season1_2HeroGroupHeroItem:checkSubGoVisable()
	if self.isLock then
		return false
	end

	if self.isAidLock then
		return false
	end

	if self.isRoleNumLock then
		return false
	end

	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		return self.mo.id > battleCO.playerMax
	end

	return self.mo.id == ModuleEnum.MaxHeroCountInGroup
end

function Season1_2HeroGroupHeroItem:_initData()
	self._firstEnter = true

	gohelper.setActive(self._goselectdebuff, false)
end

function Season1_2HeroGroupHeroItem:_addEvents()
	self._btnclickitem:AddClickListener(self._onClickHeroItem, self)
	self._btnclickequip:AddClickListener(self._onClickEquip, self)
	self.addEventCb(self, Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, self._updateAct104Equips, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, self._updateAct104Equips, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, self.setHeroGroupEquipEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, self.playHeroGroupHeroEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ChangeEquip, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onBreakSuccess, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipStrengthenReply, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipRefineReply, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self._updateSeasonEquips, self)
end

function Season1_2HeroGroupHeroItem:_updateSeasonEquips()
	self:_updateEquips()
	self:_updateAct104Equips()
end

function Season1_2HeroGroupHeroItem:_onClickHeroItem()
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

function Season1_2HeroGroupHeroItem:_onClickEquip()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		local param = {
			heroMo = self._heroMO,
			equipMo = self._equipMO,
			posIndex = self._posIndex,
			fromView = EquipEnum.FromViewEnum.FromSeasonFightView
		}

		EquipController.instance:openEquipInfoTeamView(param)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function Season1_2HeroGroupHeroItem:_updateEquips()
	self._equipType = -1

	if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		gohelper.setActive(self._goequip, false)
		gohelper.setActive(self._gofakeequip, false)
		gohelper.setActive(self._goemptyequip, false)
	else
		gohelper.setActive(self._gofakeequip, true)
		gohelper.setActive(self._goemptyequip, true)
		gohelper.setActive(self._goequip, true)

		if not self._equip then
			self._equip = self:getUserDataTb_()
			self._equip.moveParent = gohelper.findChild(self._goequip, "moveParent")
			self._equip.moveContainer = gohelper.findChild(self._equip.moveParent, "moveContainer")
			self._equip.moveContainerTrs = self._equip.moveContainer.transform
			self._equip.equipIcon = gohelper.findChildImage(self._equip.moveParent, "moveContainer/equipIcon")
			self._equip.equipRare = gohelper.findChildImage(self._equip.moveParent, "moveContainer/equiprare")
			self._equip.equiptxtlv = gohelper.findChildText(self._equip.moveParent, "moveContainer/equiplv/txtequiplv")
			self._equip.equipGolv = gohelper.findChild(self._equip.moveParent, "moveContainer/equiplv")

			self:_equipIconAddDrag(self._equip.equipIcon.gameObject)
		end

		local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
		local equips = curGroupMO:getPosEquips(self.mo.id - 1).equipUid
		local equipId = equips[1]

		self._equipMO = EquipModel.instance:getEquip(equipId)

		if curGroupMO.isReplay then
			self._equipMO = nil

			local equip_data = curGroupMO.replay_equip_data[self.mo.heroUid]

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

		if self._equipMO then
			self._equipType = self._equipMO.config.rare - 2
		end

		gohelper.setActive(self._equip.equipIcon.gameObject, self._equipMO)
		gohelper.setActive(self._equip.equipRare.gameObject, self._equipMO)
		gohelper.setActive(self._equip.equipGolv, self._equipMO)

		if self._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, self._equipMO.config.icon)

			self._equip.equiptxtlv.text = "LV." .. self._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. self._equipMO.config.rare)
		end
	end

	self.last_equip = self._equipMO and self._equipMO.uid

	if self._heroMO then
		self.last_hero = self._heroMO.heroId or 0
	end

	self._firstEnter = false
end

Season1_2HeroGroupHeroItem.NonCardSlotBlackMaskHeight = 362
Season1_2HeroGroupHeroItem.HasCardSlotBlackMashHeight = 200
Season1_2HeroGroupHeroItem.SingleSlotCardItem1Pos = Vector2.New(-3.8, 24.9)
Season1_2HeroGroupHeroItem.TwoSlotCardItem1Pos = Vector2.New(-51.6, 28.2)

function Season1_2HeroGroupHeroItem:_updateAct104Equips()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = curGroupMO:getAct104PosEquips(self.mo.id - 1).equipUid or {}
	local layer = Activity104Model.instance:getAct104CurLayer()

	if DungeonModel.instance.curSendEpisodeId then
		local episodeType = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type

		if episodeType == DungeonEnum.EpisodeType.Season then
			layer = Activity104Model.instance:getBattleFinishLayer()
		end
	end

	local equipUid1 = not curGroupMO.isReplay and equips[1]
	local equipUid2 = not curGroupMO.isReplay and equips[2]
	local equipId1 = Activity104Model.instance:getItemIdByUid(equips[1])
	local equipId2 = Activity104Model.instance:getItemIdByUid(equips[2])

	if curGroupMO.isReplay then
		local equipdata = curGroupMO.replay_activity104Equip_data[self.mo.heroUid]

		equipId1 = equipdata and equipdata[1] and equipdata[1].equipId or 0
		equipId2 = equipdata and equipdata[2] and equipdata[2].equipId or 0
	else
		layer = nil
	end

	self._cardItem1:setData(self.mo, layer, equipId1, equipUid1)
	self._cardItem2:setData(self.mo, layer, equipId2, equipUid2)

	self._hasUseSeasonEquipCard = self._cardItem1:hasUseSeasonEquipCard() or self._cardItem2:hasUseSeasonEquipCard()

	local hasShowCardSlot = true

	goto label_11_0

	::label_11_0::

	if hasShowCardSlot then
		if not Season1_2HeroGroupHeroItem.NonCardSlotBlackMaskHeight then
			local targetBlackMaskHeight = Season1_2HeroGroupHeroItem.HasCardSlotBlackMashHeight

			recthelper.setHeight(self._goblackmask.transform, targetBlackMaskHeight)
			gohelper.setActive(self._gocardlist, hasShowCardSlot)
			self._cardItem1:setActive(hasShowCardSlot)
			self._cardItem2:setActive(hasShowCardSlot)

			if self._cardItem1.slotUnlock then
				if self._cardItem1.slotUnlock then
					if not Season1_2HeroGroupHeroItem.TwoSlotCardItem1Pos then
						local targetSlot1Pos = Season1_2HeroGroupHeroItem.SingleSlotCardItem1Pos

						recthelper.setAnchor(self._cardItem1.transform, targetSlot1Pos.x, targetSlot1Pos.y)
					end
				end
			end
		end
	end
end

function Season1_2HeroGroupHeroItem:_equipIconAddDrag(go)
	if self._drag then
		return
	end

	local image = go:GetComponent(gohelper.Type_Image)

	image.raycastTarget = true
	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function Season1_2HeroGroupHeroItem:_onBeginDrag(equipTransform, pointerEventData)
	if UnityEngine.Input.touchCount > 1 then
		return
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	gohelper.setAsLastSibling(self.go)

	local dragTransform = self:getDragTransform()

	self:topDragTransformOrder()

	local pos = pointerEventData.position
	local scale = HeroGroupHeroItem.EquipDragOtherScale

	if GameUtil.isMobilePlayerAndNotEmulator() then
		scale = HeroGroupHeroItem.EquipDragMobileScale
		pos = pos + HeroGroupHeroItem.EquipDragOffset
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pos, dragTransform.parent)

	self:_tweenToPos(dragTransform, anchorPos)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(self._equip.equipGolv, false)
	self:killEquipTweenId()

	self.equipTweenId = ZProj.TweenHelper.DOScale(equipTransform.parent, scale, scale, scale, HeroGroupHeroItem.EquipTweenDuration)
end

function Season1_2HeroGroupHeroItem:_onDrag(param, pointerEventData)
	if UnityEngine.Input.touchCount > 1 then
		return
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + HeroGroupHeroItem.EquipDragOffset
	end

	local dragTransform = self:getDragTransform()
	local anchorPos = recthelper.screenPosToAnchorPos(pos, dragTransform.parent)

	self:_tweenToPos(dragTransform, anchorPos)
end

function Season1_2HeroGroupHeroItem:_onEndDrag(equipTransform, pointerEventData)
	if UnityEngine.Input.touchCount > 1 then
		return
	end

	self:killEquipTweenId()

	self.equipTweenId = ZProj.TweenHelper.DOScale(equipTransform.parent, 1, 1, 1, HeroGroupHeroItem.EquipTweenDuration)

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + HeroGroupHeroItem.EquipDragOffset
	end

	local targetHeroItem = self:_moveToTarget(pos)

	self:_setEquipDragEnabled(false)

	local dragTransform = self:getDragTransform()
	local orignPos = self:getOrignDragPos()

	if not targetHeroItem or targetHeroItem == self or targetHeroItem.mo.aid then
		local anchorPos = recthelper.rectToRelativeAnchorPos(orignPos, dragTransform.parent)

		self._setToPos(self, dragTransform, anchorPos, true, self.onDragEndFail, self)

		return
	end

	self:_playDragEndAudio(targetHeroItem)

	local targetDragTransform = targetHeroItem:getDragTransform()

	targetHeroItem:topDragTransformOrder()

	local targetOrignPos = targetHeroItem:getOrignDragPos()
	local anotherAnchorPos = recthelper.rectToRelativeAnchorPos(orignPos, targetDragTransform.parent)

	self._tweenId = self:_setToPos(targetDragTransform, anotherAnchorPos, true)

	local anchorPos = recthelper.rectToRelativeAnchorPos(targetOrignPos, dragTransform.parent)

	self._setToPos(self, dragTransform, anchorPos, true, self.onDragEndSuccess, self, targetHeroItem)
end

function Season1_2HeroGroupHeroItem:topDragTransformOrder()
	local dragTransform = self:getDragTransform()

	gohelper.addChildPosStay(self.currentParent, dragTransform.gameObject)
end

function Season1_2HeroGroupHeroItem:resetDragTransformOrder()
	local dragTransform = self:getDragTransform()

	gohelper.addChildPosStay(self._equip.moveParent, dragTransform.gameObject)
end

function Season1_2HeroGroupHeroItem:getDragTransform()
	return self._equip.moveContainerTrs
end

function Season1_2HeroGroupHeroItem:getOrignDragPos()
	return self._equip.moveParent.transform.position
end

function Season1_2HeroGroupHeroItem:onDragEndFail()
	self:resetDragTransformOrder()
	gohelper.setActive(self._gorootequipeffect1, false)
	gohelper.setActive(self._equip.equipGolv, true)
	self:_setEquipDragEnabled(true)
end

function Season1_2HeroGroupHeroItem:onDragEndSuccess(targetHeroItem)
	local realGroupMo = Activity104Model.instance:getRealHeroGroupBySubId()

	EquipTeamListModel.instance:openTeamEquip(self.mo.id - 1, self._heroMO, realGroupMo)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:resetDragTransformOrder()
	targetHeroItem:resetDragTransformOrder()

	local dragTransform = self:getDragTransform()
	local targetDragTransform = targetHeroItem:getDragTransform()

	self:_setToPos(dragTransform, Vector2())
	self:_setToPos(targetDragTransform, Vector2())
	gohelper.setActive(self._gorootequipeffect1, false)
	gohelper.setActive(self._equip.equipGolv, true)
	self:_setEquipDragEnabled(true)

	local srcPos = self.mo.id - 1
	local targetPos = targetHeroItem.mo.id - 1
	local srcEquipId = EquipTeamListModel.instance:getTeamEquip(srcPos)[1]

	srcEquipId = EquipModel.instance:getEquip(srcEquipId) and srcEquipId or nil

	if srcEquipId then
		EquipTeamShowItem.removeEquip(srcPos, true)
	end

	local targetEquipId = EquipTeamListModel.instance:getTeamEquip(targetPos)[1]

	targetEquipId = EquipModel.instance:getEquip(targetEquipId) and targetEquipId or nil

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

	local extraData = {}

	extraData.groupIndex = Activity104Model.instance:getSeasonCurSnapshotSubId()
	extraData.heroGroup = EquipTeamListModel.instance:getCurGroupMo()

	HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, extraData)
end

function Season1_2HeroGroupHeroItem:_playDragEndAudio(targetHeroItem)
	if not self._equipMO or self._equipMO.config.id <= 0 then
		return
	end

	local skillDesList, _, _ = EquipHelper.getSkillBaseDescAndIcon(self._equipMO.config.id, self._equipMO.refineLv)
	local hasSkill = #skillDesList > 0

	if hasSkill then
		local showEffect = EquipHelper.detectEquipSkillSuited(targetHeroItem._heroMO and targetHeroItem._heroMO.heroId, self._equipMO.config.skillType, self._equipMO.refineLv)

		if showEffect then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
		end
	end
end

function Season1_2HeroGroupHeroItem:_tweenToPos(transform, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)
	end
end

function Season1_2HeroGroupHeroItem:_setToPos(transform, anchorPos, tween, callback, callbackObj, param)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj, param)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Season1_2HeroGroupHeroItem:_moveToTarget(position)
	for i, v in ipairs(self._Season1_2HeroGroupListView.heroPosTrList) do
		if self._Season1_2HeroGroupListView._heroItemList[i] ~= self then
			local posTr = v.parent
			local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

			if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
				return self._Season1_2HeroGroupListView._heroItemList[i]
			end
		end
	end

	return nil
end

function Season1_2HeroGroupHeroItem:_setEquipDragEnabled(isEnabled)
	for i, heroItem in ipairs(self._Season1_2HeroGroupListView._heroItemList) do
		if heroItem._drag then
			heroItem._drag.enabled = isEnabled
		end
	end
end

function Season1_2HeroGroupHeroItem:playHeroGroupHeroEffect(state)
	self.anim:Play(state, 0, 0)

	self.last_equip = nil
	self.last_hero = nil
	self._firstEnter = true
end

function Season1_2HeroGroupHeroItem:playRestrictAnimation(needRestrictHeroUidDict)
	if self._heroMO and needRestrictHeroUidDict[self._heroMO.uid] then
		self._playDeathAnim = true

		self.anim:Play("herogroup_hero_deal", 0, 0)

		self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)
	end
end

function Season1_2HeroGroupHeroItem:setGrayFactor(value)
	ZProj.UGUIHelper.SetGrayFactor(self._simagecharactericon.gameObject, value)
end

local restrainTagPosUnUseSeasonCard = Vector2.New(0, -4)
local restrainTagPosUseSeasonCard = Vector2.New(0, -30)

function Season1_2HeroGroupHeroItem:showCounterSign()
	local career

	if self._heroMO then
		local hero_config = lua_character.configDict[self._heroMO.heroId]

		career = hero_config.career
	elseif self.monsterCO then
		career = self.monsterCO.career
	end

	local recommended, counter = FightHelper.detectAttributeCounter()
	local isRecommended = tabletool.indexOf(recommended, career)
	local isCounter = tabletool.indexOf(counter, career)

	gohelper.setActive(self._gorecommended, isRecommended)
	gohelper.setActive(self._gocounter, isCounter)

	if isRecommended or isCounter then
		if self._hasUseSeasonEquipCard then
			if not restrainTagPosUseSeasonCard then
				local targetPos = restrainTagPosUnUseSeasonCard

				recthelper.setAnchor(self._goflags.transform, targetPos.x, targetPos.y)
			end
		end
	end
end

function Season1_2HeroGroupHeroItem:onItemBeginDrag(index)
	if index == self.mo.id then
		ZProj.TweenHelper.DOScale(self.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(self._goselectdebuff, true)
		gohelper.setActive(self._goselected, true)
		gohelper.setActive(self._gofinished, false)
	end

	gohelper.setActive(self._goclick, false)
end

function Season1_2HeroGroupHeroItem:onItemEndDrag(index, dragToIndex)
	ZProj.TweenHelper.DOScale(self.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
end

function Season1_2HeroGroupHeroItem:onItemCompleteDrag(index, dragToIndex, complete)
	if dragToIndex == self.mo.id and index ~= dragToIndex then
		if complete then
			gohelper.setActive(self._goselectdebuff, true)
			gohelper.setActive(self._goselected, false)
			gohelper.setActive(self._gofinished, false)
			gohelper.setActive(self._gofinished, true)
			TaskDispatcher.cancelTask(self.hideDragEffect, self)
			TaskDispatcher.runDelay(self.hideDragEffect, self, 0.833)
		end
	else
		gohelper.setActive(self._goselectdebuff, false)
	end

	gohelper.setActive(self._gorootequipeffect2, false)
	gohelper.setActive(self._goclick, true)
end

function Season1_2HeroGroupHeroItem:hideDragEffect()
	gohelper.setActive(self._goselectdebuff, false)
end

function Season1_2HeroGroupHeroItem:setHeroGroupEquipEffect(show)
	self._canPlayEffect = show
end

function Season1_2HeroGroupHeroItem:setParent(transform)
	self.currentParent = transform

	gohelper.addChildPosStay(transform.gameObject, self._subGO)
end

function Season1_2HeroGroupHeroItem:flowOriginParent()
	return
end

function Season1_2HeroGroupHeroItem:flowCurrentParent()
	return
end

function Season1_2HeroGroupHeroItem:getHeroItemList()
	return self._Season1_2HeroGroupListView:getHeroItemList()
end

function Season1_2HeroGroupHeroItem:killEquipTweenId()
	if self.equipTweenId then
		ZProj.TweenHelper.KillById(self.equipTweenId)

		self.equipTweenId = nil
	end
end

function Season1_2HeroGroupHeroItem:_removeEvents()
	self._btnclickitem:RemoveClickListener()
	self._btnclickequip:RemoveClickListener()
end

function Season1_2HeroGroupHeroItem:onDestroy()
	self:_removeEvents()
	self:killEquipTweenId()
	self._simagecharactericon:UnLoadImage()

	if self._leftSeasonCardItem then
		self._leftSeasonCardItem:destroy()

		self._leftSeasonCardItem = nil
	end

	if self._rightSeasonCardItem then
		self._rightSeasonCardItem:destroy()

		self._rightSeasonCardItem = nil
	end

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	if self._cardItem1 then
		self._cardItem1:destory()

		self._cardItem1 = nil
	end

	if self._cardItem2 then
		self._cardItem2:destory()

		self._cardItem2 = nil
	end

	TaskDispatcher.cancelTask(self.hideDragEffect, self)
end

return Season1_2HeroGroupHeroItem
