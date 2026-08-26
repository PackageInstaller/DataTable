-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1HeroGroupHeroItem.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1HeroGroupHeroItem", package.seeall)

local Season123_2_1HeroGroupHeroItem = class("Season123_2_1HeroGroupHeroItem", LuaCompBase)

function Season123_2_1HeroGroupHeroItem:ctor(SeasonHeroGroupListView)
	self._seasonHeroGroupListView = SeasonHeroGroupListView
end

function Season123_2_1HeroGroupHeroItem:init(go)
	self.go = go
	self._goheroitem = gohelper.findChild(go, "heroitemani")
	self.anim = self._goheroitem:GetComponent(typeof(UnityEngine.Animator))
	self._tagTr = gohelper.findChildComponent(go, "heroitemani/tags", typeof(UnityEngine.Transform))
	self._subGO = gohelper.findChild(go, "heroitemani/tags/aidtag")
	self._aidGO = gohelper.findChild(go, "heroitemani/tags/storytag")
	self._trialTagGO = gohelper.findChild(go, "heroitemani/tags/trialtag")
	self._subGO = gohelper.findChild(go, "heroitemani/aidtag")
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
	self._cardItem1 = Season123_2_1HeroGroupCardItem.New(self._gocarditem1, self, {
		slot = 1
	})
	self._goherolvLayout = gohelper.findChild(go, "heroitemani/equipcard/vertical/layout")
	self._sliderhp = gohelper.findChildSlider(go, "heroitemani/#go_hp/#slider_hp")
	self._gohp = gohelper.findChild(go, "heroitemani/#go_hp")
	self._imagehp = gohelper.findChildImage(go, "heroitemani/#go_hp/#slider_hp/Fill Area/Fill")
	self._charactericon = gohelper.findChild(go, "heroitemani/hero/charactericon")
	self._commonHeroCard = CommonHeroCard.create(self._charactericon, self._seasonHeroGroupListView.viewName)

	self:_initData()
	self:_addEvents()
end

function Season123_2_1HeroGroupHeroItem:onUpdateMO(mo, viewParam, replayHeroData)
	self.mo = mo
	self.viewParam = viewParam
	self._heroMO = Season123HeroUtils.getHeroMO(Season123HeroGroupModel.instance.activityId, self.mo.heroUid, Season123HeroGroupModel.instance.stage)
	self._monsterCo = mo:getMonsterCO()
	self.trialCO = mo:getTrialCO()
	self._posIndex = self.mo.id - 1

	ZProj.UGUIHelper.SetGrayscale(self._simagecharactericon.gameObject, false)

	local curHeroGroupMo = HeroGroupModel.instance:getCurGroupMO()

	gohelper.setActive(self._goreplayready, curHeroGroupMo.isReplay)

	local skinConfig

	if self._heroMO or replayHeroData and replayHeroData.heroId and replayHeroData.heroId ~= 0 then
		if curHeroGroupMo.isReplay then
			if not curHeroGroupMo.replay_hero_data[self.mo.heroUid] then
				local replay_data

				if replay_data then
					local level, rank = HeroConfig.instance:getShowLevel(replay_data.level or self._heroMO.level)

					self._txtlvnum.text = level
					skinConfig = FightConfig.instance:getSkinCO((replay_data or nil) and (replay_data.skin or self._heroMO.skin))

					if self._heroMO then
						if not self._heroMO.config then
							local heroCfg = HeroConfig.instance:getHeroCO(replayHeroData.heroId)

							self._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
							UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "lssx_" .. tostring(heroCfg.career))

							for i = 1, 3 do
								gohelper.setActive(self._goranks[i], i == rank - 1)
							end

							gohelper.setActive(self._gostarroot, true)

							for i = 1, 6 do
								gohelper.setActive(self._gostars[i], i <= CharacterEnum.Star[heroCfg.rare])
							end
						end
					end
				end
			end
		end
	elseif self._monsterCo then
		skinConfig = FightConfig.instance:getSkinCO(self._monsterCo.skinId)

		self._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "lssx_" .. tostring(self._monsterCo.career))

		local level, rank = HeroConfig.instance:getShowLevel(self._monsterCo.level)

		self._txtlvnum.text = level

		for i = 1, 3 do
			gohelper.setActive(self._goranks[i], i == rank - 1)
		end

		gohelper.setActive(self._gostarroot, false)
	elseif self.trialCO then
		local heroCo = HeroConfig.instance:getHeroCO(self.trialCO.heroId)

		skinConfig = self.trialCO.skin > 0 and SkinConfig.instance:getSkinCo(self.trialCO.skin) or SkinConfig.instance:getSkinCo(heroCo.skinId)

		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "lssx_" .. tostring(heroCo.career))

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.trialCO.level)

		self._txtlvnum.text = showLevel

		for i = 1, 3 do
			gohelper.setActive(self._goranks[i], i == rank - 1)
		end

		for i = 1, 6 do
			gohelper.setActive(self._gostars[i], i <= CharacterEnum.Star[heroCo.rare])
		end
	end

	if skinConfig then
		self._commonHeroCard:onUpdateMO(skinConfig)
	end

	self.isLock = not HeroGroupModel.instance:isPositionOpen(self.mo.id)
	self.isAidLock = self.mo.aid and self.mo.aid == -1
	self.isTrialLock = (self.mo.trial and self.mo.trialPos) ~= nil
	self.isAid = self.mo.aid ~= nil

	local roleNum = HeroGroupModel.instance:getBattleRoleNum()

	self.isRoleNumLock = roleNum and roleNum < self.mo.id
	self.isEmpty = mo:isEmpty()

	if not self._heroMO and not self._monsterCo and not self.trialCO then
		if replayHeroData then
			::label_3_0::

			local var_3_3 = replayHeroData.heroId
			local isHeroShow = true

			if replayHeroData.heroId then
				if replayHeroData.heroId ~= 0 then
					if not self.isLock then
						isHeroShow = not self.isRoleNumLock

						goto label_3_1
					end
				end

				isHeroShow = false
			end

			::label_3_1::

			gohelper.setActive(self._gohero, isHeroShow)
			gohelper.setActive(self._gostarroot, isHeroShow)
			gohelper.setActive(self._goherolvLayout, isHeroShow)

			local isNoData = not self._heroMO and (replayHeroData == nil or replayHeroData.heroId == nil or replayHeroData.heroId == 0) and not self._monsterCo and not self.trialCO

			if not isNoData then
				::label_3_2::

				local var_3_4 = self.isLock

				if not self.isLock then
					var_3_4 = self.isAidLock

					if not self.isAidLock then
						local isNoneShow = self.isRoleNumLock

						gohelper.setActive(self._gonone, isNoneShow)

						local isAddShow = isNoData and not self.isLock and not self.isAidLock and not self.isRoleNumLock

						gohelper.setActive(self._goadd, isAddShow)
						gohelper.setActive(self._golock, self.isLock or self.isAidLock or self.isRoleNumLock)
						gohelper.setActive(self._aidGO, self.mo.aid and self.mo.aid ~= -1)
						gohelper.setActive(self._trialTagGO, self.trialCO ~= nil)
						recthelper.setAnchor(self._tagTr, -62.5, self._subGO.activeSelf and -98.9 or -51.3)

						if not HeroSingleGroupModel.instance:isTemp() and self.isRoleNumLock and self._heroMO ~= nil and self._monsterCo == nil then
							HeroSingleGroupModel.instance:remove(self._heroMO.id)
							Season123HeroGroupController.instance:saveCurrentHeroGroup()
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
			end
		end
	end
end

function Season123_2_1HeroGroupHeroItem:checkSubGoVisable()
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

function Season123_2_1HeroGroupHeroItem:_initData()
	self._firstEnter = true

	gohelper.setActive(self._goselectdebuff, false)
end

function Season123_2_1HeroGroupHeroItem:_addEvents()
	self._btnclickitem:AddClickListener(self._onClickHeroItem, self)
	self._btnclickequip:AddClickListener(self._onClickEquip, self)
	self.addEventCb(self, Season123EquipController.instance, Season123EquipEvent.EquipUpdate, self._updateEquipCards, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self._updateSeasonEquips, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, self.setHeroGroupEquipEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, self.playHeroGroupHeroEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ChangeEquip, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onBreakSuccess, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipStrengthenReply, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipRefineReply, self._updateSeasonEquips, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self._updateSeasonEquips, self)
end

function Season123_2_1HeroGroupHeroItem:_updateSeasonEquips()
	self:_updateEquips()
	self:_updateEquipCards()
	self:_updateAct123Hp()
end

function Season123_2_1HeroGroupHeroItem:_onClickHeroItem()
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

function Season123_2_1HeroGroupHeroItem:_onClickEquip()
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
			fromView = EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView
		}

		if self.trialCO then
			param.heroMo = HeroGroupTrialModel.instance:getHeroMo(self.trialCO)

			if self.trialCO.equipId > 0 then
				param.equipMo = param.heroMo.trialEquipMo
			end
		end

		EquipController.instance:openEquipInfoTeamView(param)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function Season123_2_1HeroGroupHeroItem:_updateEquips()
	self._equipType = -1

	if self.isLock or self.isAid or self.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not self.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(self._gofakeequip, false)
		gohelper.setActive(self._goemptyequip, false)
	else
		gohelper.setActive(self._gofakeequip, true)
		gohelper.setActive(self._goemptyequip, true)

		if not self._equip then
			self._equip = self:getUserDataTb_()
			self._equip.moveContainer = gohelper.findChild(self._goequip, "moveContainer")
			self._equip.moveContainerTrs = self._equip.moveContainer.transform
			self._equip.equipIcon = gohelper.findChildImage(self._goequip, "moveContainer/equipIcon")
			self._equip.equipRare = gohelper.findChildImage(self._goequip, "moveContainer/equiprare")
			self._equip.equiptxtlv = gohelper.findChildText(self._goequip, "moveContainer/equiplv/txtequiplv")
			self._equip.equipGolv = gohelper.findChild(self._goequip, "moveContainer/equiplv")

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

		local trialEquipCO

		if self.trialCO and self.trialCO.equipId > 0 then
			trialEquipCO = EquipConfig.instance:getEquipCo(self.trialCO.equipId)
		end

		if self._equipMO then
			self._equipType = self._equipMO.config.rare - 2
		elseif trialEquipCO then
			self._equipType = trialEquipCO.rare - 2
		end

		gohelper.setActive(self._equip.equipIcon.gameObject, self._equipMO)
		gohelper.setActive(self._equip.equipRare.gameObject, self._equipMO)
		gohelper.setActive(self._equip.equipGolv, self._equipMO)

		local isCurPos = self.mo.id - 1 == EquipTeamListModel.instance:getCurPosIndex()

		if self._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, self._equipMO.config.icon)

			self._equip.equiptxtlv.text = "LV." .. self._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. self._equipMO.config.rare)
		elseif trialEquipCO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, trialEquipCO.icon)

			self._equip.equiptxtlv.text = "LV." .. self.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(self._equip.equipRare, "bianduixingxian_" .. trialEquipCO.rare)
		end
	end

	self.last_equip = self._equipMO and self._equipMO.uid

	if self._heroMO then
		self.last_hero = self._heroMO.heroId or 0
	end

	self._firstEnter = false
end

Season123_2_1HeroGroupHeroItem.NonCardSlotBlackMaskHeight = 362
Season123_2_1HeroGroupHeroItem.HasCardSlotBlackMashHeight = 200
Season123_2_1HeroGroupHeroItem.SingleSlotCardItem1Pos = Vector2.New(-3.8, 24.9)
Season123_2_1HeroGroupHeroItem.TwoSlotCardItem1Pos = Vector2.New(-51.6, 28.2)

function Season123_2_1HeroGroupHeroItem:_updateEquipCards()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equips = curGroupMO:getAct104PosEquips(self.mo.id - 1).equipUid
	local context = Season123Model.instance:getBattleContext()

	if not context then
		return
	end

	local actId = context.actId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local layer = context.layer
	local hasTrialEquip = false
	local equipUid1, equipId1

	if curGroupMO.isReplay then
		local equipdata = curGroupMO.replay_activity104Equip_data[self.mo.heroUid]

		equipId1 = equipdata and equipdata[1] and equipdata[1].equipId or 0
	else
		local equips = curGroupMO:getAct104PosEquips(self.mo.id - 1).equipUid or {}

		hasTrialEquip = self.trialCO and (self.trialCO.act104EquipId1 > 0 or self.trialCO.act104EquipId2 > 0)

		if self.trialCO and self.trialCO.act104EquipId1 > 0 then
			equipId1 = self.trialCO.act104EquipId1
		else
			equipUid1 = equips[1]
			equipId1 = seasonMO:getItemIdByUid(equips[1])
		end

		layer = nil
	end

	self._cardItem1:setData(self.mo, layer, equipId1, equipUid1)

	self._hasUseSeasonEquipCard = self._cardItem1:hasUseSeasonEquipCard()

	local hasShowCardSlot = not self.isAid and self._cardItem1.slotUnlock

	if hasShowCardSlot then
		if not Season123_2_1HeroGroupHeroItem.NonCardSlotBlackMaskHeight then
			local targetBlackMaskHeight = Season123_2_1HeroGroupHeroItem.HasCardSlotBlackMashHeight

			recthelper.setHeight(self._goblackmask.transform, targetBlackMaskHeight)
			gohelper.setActive(self._gocardlist, hasShowCardSlot)
			self._cardItem1:setActive(hasShowCardSlot)

			local targetSlot1Pos = Season123_2_1HeroGroupHeroItem.SingleSlotCardItem1Pos

			recthelper.setAnchor(self._cardItem1.transform, targetSlot1Pos.x, targetSlot1Pos.y)
		end
	end
end

function Season123_2_1HeroGroupHeroItem:_updateAct123Hp()
	local context = Season123Model.instance:getBattleContext()

	if not context then
		return
	end

	local actId, stage, layer = context.actId, context.stage, context.layer

	if not stage then
		gohelper.setActive(self._gohp, false)

		return
	end

	local seasonHeroMO = Season123Model.instance:getSeasonHeroMO(actId, stage, layer, self.mo.heroUid)

	if seasonHeroMO ~= nil then
		gohelper.setActive(self._gohp, true)
		self:setHp(seasonHeroMO.hpRate)
	else
		gohelper.setActive(self._gohp, false)
	end
end

function Season123_2_1HeroGroupHeroItem:setHp(hpRate)
	local hp100Per = math.floor(hpRate / 10)
	local rate = Mathf.Clamp(hp100Per / 100, 0, 1)

	self._sliderhp:SetValue(rate)
	Season123HeroGroupUtils.setHpBar(self._imagehp, rate)
end

function Season123_2_1HeroGroupHeroItem:_equipIconAddDrag(go)
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

function Season123_2_1HeroGroupHeroItem:_onBeginDrag(equipTransform, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if self.trialCO and self.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

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

function Season123_2_1HeroGroupHeroItem:_onDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if self.trialCO and self.trialCO.equipId > 0 then
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

function Season123_2_1HeroGroupHeroItem:_onEndDrag(equipTransform, pointerEventData)
	self:killEquipTweenId()

	self.equipTweenId = ZProj.TweenHelper.DOScale(equipTransform.parent, 1, 1, 1, HeroGroupHeroItem.EquipTweenDuration)

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if self.trialCO and self.trialCO.equipId > 0 then
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

	if targetHeroItem then
		::label_17_0::

		local var_17_0 = targetHeroItem.trialCO

		if targetHeroItem.trialCO then
			local isTrialDefaultEquip = targetHeroItem.trialCO.equipId > 0

			if not targetHeroItem or targetHeroItem == self or targetHeroItem.mo.aid or isTrialDefaultEquip then
				if isTrialDefaultEquip then
					GameFacade.showToast(ToastEnum.TrialCantEditEquip)
				end

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
	end
end

function Season123_2_1HeroGroupHeroItem:canMoveCardToPos(tarPos)
	if self._cardItem1 then
		return self._cardItem1:canMoveToPos(tarPos)
	else
		return true
	end
end

function Season123_2_1HeroGroupHeroItem:topDragTransformOrder()
	local dragTransform = self:getDragTransform()

	gohelper.addChildPosStay(self.currentParent, dragTransform.gameObject)
end

function Season123_2_1HeroGroupHeroItem:resetDragTransformOrder()
	local dragTransform = self:getDragTransform()

	gohelper.addChildPosStay(self._goequip, dragTransform.gameObject)
end

function Season123_2_1HeroGroupHeroItem:getDragTransform()
	return self._equip.moveContainerTrs
end

function Season123_2_1HeroGroupHeroItem:getOrignDragPos()
	return self._goequip.transform.position
end

function Season123_2_1HeroGroupHeroItem:onDragEndFail()
	self:resetDragTransformOrder()
	gohelper.setActive(self._gorootequipeffect1, false)
	gohelper.setActive(self._equip.equipGolv, true)
	self:_setEquipDragEnabled(true)
end

function Season123_2_1HeroGroupHeroItem:onDragEndSuccess(targetHeroItem)
	EquipTeamListModel.instance:openTeamEquip(self.mo.id - 1, self._heroMO)

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

	if not HeroSingleGroupModel.instance:isTemp() then
		local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
		local actId = self.viewParam.actId
		local seasonMO = Season123Model.instance:getActInfo(actId)

		if not seasonMO then
			return
		end

		if Season123HeroGroupModel.instance:isEpisodeSeason123() then
			local extraData = {}

			extraData.groupIndex = seasonMO.heroGroupSnapshotSubId
			extraData.heroGroup = seasonMO:getCurHeroGroup()

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123, DungeonModel.instance.curSendEpisodeId, true, extraData)
		elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
			local extraData = {}

			extraData.heroGroup = heroGroupMO

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123Retail, DungeonModel.instance.curSendEpisodeId, true, extraData)
		else
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
			HeroGroupModel.instance:saveCurGroupData()
		end
	end
end

function Season123_2_1HeroGroupHeroItem:_playDragEndAudio(targetHeroItem)
	local skillDesList, _, _ = self._equipMO.config.skillType == 0 and {} or EquipHelper.getSkillBaseDescAndIcon(self._equipMO.config.id, self._equipMO.refineLv)
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

function Season123_2_1HeroGroupHeroItem:_tweenToPos(transform, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)
	end
end

function Season123_2_1HeroGroupHeroItem:_setToPos(transform, anchorPos, tween, callback, callbackObj, param)
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

function Season123_2_1HeroGroupHeroItem:_moveToTarget(position)
	for i, v in ipairs(self._seasonHeroGroupListView.heroPosTrList) do
		if self._seasonHeroGroupListView._heroItemList[i] ~= self then
			local posTr = v.parent
			local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

			if math.abs(anchorPos.x) * 2 < recthelper.getWidth(posTr) and math.abs(anchorPos.y) * 2 < recthelper.getHeight(posTr) then
				return self._seasonHeroGroupListView._heroItemList[i]
			end
		end
	end

	return nil
end

function Season123_2_1HeroGroupHeroItem:_setEquipDragEnabled(isEnabled)
	for i, heroItem in ipairs(self._seasonHeroGroupListView._heroItemList) do
		if heroItem._drag then
			heroItem._drag.enabled = isEnabled
		end
	end
end

function Season123_2_1HeroGroupHeroItem:playHeroGroupHeroEffect(state)
	self.anim:Play(state, 0, 0)

	self.last_equip = nil
	self.last_hero = nil
	self._firstEnter = true
end

function Season123_2_1HeroGroupHeroItem:playRestrictAnimation(needRestrictHeroUidDict, deadHeroUidDict)
	if self._heroMO and (needRestrictHeroUidDict[self._heroMO.uid] or deadHeroUidDict and deadHeroUidDict[self._heroMO.uid]) then
		self._playDeathAnim = true

		self.anim:Play("herogroup_hero_deal", 0, 0)

		self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)
	end
end

function Season123_2_1HeroGroupHeroItem:setGrayFactor(value)
	ZProj.UGUIHelper.SetGrayFactor(self._simagecharactericon.gameObject, value)
end

local restrainTagPosUnUseSeasonCard = Vector2.New(0, -4)
local restrainTagPosUseSeasonCard = Vector2.New(0, -50)
local restrainTagSeasonCardPosOffset = restrainTagPosUseSeasonCard - restrainTagPosUnUseSeasonCard
local restrainHpOriginPos = Vector2.New(0, -270)
local restrainHpTagOffsetPos = Vector2.New(0, -30)

function Season123_2_1HeroGroupHeroItem:showCounterSign()
	local career

	if self._heroMO then
		local hero_config = lua_character.configDict[self._heroMO.heroId]

		career = hero_config.career
	elseif self.monsterCO then
		career = self.monsterCO.career
	elseif self.trialCO then
		local hero_config = lua_character.configDict[self.trialCO.heroId]

		career = hero_config and hero_config.career
	end

	local recommended, counter = FightHelper.detectAttributeCounter()
	local isRecommended = tabletool.indexOf(recommended, career)
	local isCounter = tabletool.indexOf(counter, career)

	gohelper.setActive(self._gorecommended, isRecommended)
	gohelper.setActive(self._gocounter, isCounter)

	local hpPosX, hpPosY = restrainHpOriginPos.x, restrainHpOriginPos.y

	if isRecommended or isCounter then
		if self._hasUseSeasonEquipCard then
			if not restrainTagPosUseSeasonCard then
				do
					local targetPos = restrainTagPosUnUseSeasonCard

					recthelper.setAnchor(self._goflags.transform, targetPos.x, targetPos.y)

					hpPosX = hpPosX + restrainHpTagOffsetPos.x
					hpPosY = hpPosY + restrainHpTagOffsetPos.y
				end

				if self._hasUseSeasonEquipCard then
					hpPosX = hpPosX + restrainTagSeasonCardPosOffset.x
					hpPosY = hpPosY + restrainTagSeasonCardPosOffset.y
				end
			end
		end
	end

	recthelper.setAnchor(self._gohp.transform, hpPosX, hpPosY)
end

function Season123_2_1HeroGroupHeroItem:onItemBeginDrag(index)
	if index == self.mo.id then
		ZProj.TweenHelper.DOScale(self.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(self._goselectdebuff, true)
		gohelper.setActive(self._goselected, true)
		gohelper.setActive(self._gofinished, false)
	end

	gohelper.setActive(self._goclick, false)
end

function Season123_2_1HeroGroupHeroItem:onItemEndDrag(index, dragToIndex)
	ZProj.TweenHelper.DOScale(self.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
end

function Season123_2_1HeroGroupHeroItem:onItemCompleteDrag(index, dragToIndex, complete)
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

function Season123_2_1HeroGroupHeroItem:hideDragEffect()
	gohelper.setActive(self._goselectdebuff, false)
end

function Season123_2_1HeroGroupHeroItem:setHeroGroupEquipEffect(show)
	self._canPlayEffect = show
end

function Season123_2_1HeroGroupHeroItem:setParent(transform)
	self.currentParent = transform

	gohelper.addChildPosStay(transform.gameObject, self._subGO)
end

function Season123_2_1HeroGroupHeroItem:flowOriginParent()
	return
end

function Season123_2_1HeroGroupHeroItem:flowCurrentParent()
	return
end

function Season123_2_1HeroGroupHeroItem:getHeroItemList()
	return self._seasonHeroGroupListView:getHeroItemList()
end

function Season123_2_1HeroGroupHeroItem:killEquipTweenId()
	if self.equipTweenId then
		ZProj.TweenHelper.KillById(self.equipTweenId)

		self.equipTweenId = nil
	end
end

function Season123_2_1HeroGroupHeroItem:_removeEvents()
	self._btnclickitem:RemoveClickListener()
	self._btnclickequip:RemoveClickListener()
end

function Season123_2_1HeroGroupHeroItem:onDestroy()
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

	TaskDispatcher.cancelTask(self.hideDragEffect, self)
end

return Season123_2_1HeroGroupHeroItem
