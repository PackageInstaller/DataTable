-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotHeroGroupHeroItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupHeroItem", package.seeall)

local V1a6_CachotHeroGroupHeroItem = class("V1a6_CachotHeroGroupHeroItem", LuaCompBase)

function V1a6_CachotHeroGroupHeroItem:ctor(heroGroupListView)
	self._heroGroupListView = heroGroupListView
end

V1a6_CachotHeroGroupHeroItem.EquipTweenDuration = 0.16
V1a6_CachotHeroGroupHeroItem.EquipDragOffset = Vector2(0, 150)
V1a6_CachotHeroGroupHeroItem.EquipDragMobileScale = 1.7
V1a6_CachotHeroGroupHeroItem.EquipDragOtherScale = 1.4
V1a6_CachotHeroGroupHeroItem.PressColor = GameUtil.parseColor("#C8C8C8")

function V1a6_CachotHeroGroupHeroItem:init(go)
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
		local rankGO = gohelper.findChildImage(go, "heroitemani/hero/vertical/layout/lv/rankobj/rank" .. i)

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
	self._goquality = gohelper.findChild(go, "heroitemani/#go_quality")
	self._seatbgicon = gohelper.findChildImage(go, "heroitemani/hero/#go_qualitytag")
	self._seaticon = gohelper.findChildImage(go, "heroitemani/#go_quality/icon")
	self._gohp = gohelper.findChild(go, "heroitemani/#go_hp")
	self._sliderhp = gohelper.findChildSlider(go, "heroitemani/#go_hp/#slider_hp")
	self._gotalent = gohelper.findChild(go, "heroitemani/hero/vertical/layout/gongming")
	self._txttalent = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/gongming/lvltxt")
	self._txtlvtalent = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/gongming/lv")
	self._icontalent = gohelper.findChildImage(go, "heroitemani/hero/vertical/layout/gongming/icon")
	self._commonHeroCard = CommonHeroCard.create(self._charactericon, self._heroGroupListView.viewName)
end

function V1a6_CachotHeroGroupHeroItem:getQualityGo()
	return self._goquality
end

function V1a6_CachotHeroGroupHeroItem:setIndex(index)
	self._index = index
	self._goquality.name = "#go_quality_" .. tostring(index)
end

function V1a6_CachotHeroGroupHeroItem:_showMojingTip()
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

function V1a6_CachotHeroGroupHeroItem:setParent(transform)
	self.currentParent = transform

	self._subGO.transform:SetParent(transform, true)
	self._equipGO.transform:SetParent(transform, true)
end

function V1a6_CachotHeroGroupHeroItem:flowOriginParent()
	self._equipGO.transform:SetParent(self._animGO.transform, false)
end

function V1a6_CachotHeroGroupHeroItem:flowCurrentParent()
	self._equipGO.transform:SetParent(self.currentParent, false)
end

function V1a6_CachotHeroGroupHeroItem:initEquips(equipIndex)
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

			self:_equipIconAddDrag(self._equip.equipIcon.gameObject)
		end

		local curGroupMO = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
		local equips = curGroupMO:getPosEquips(self.mo.id - 1).equipUid
		local equipId = equips[1]

		self._equipMO = EquipModel.instance:getEquip(equipId) or HeroGroupTrialModel.instance:getEquipMo(equipId)

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

		gohelper.setActive(self._equip.equipIcon.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipRare.gameObject, self._equipMO or trialEquipCO)
		gohelper.setActive(self._equip.equipAddGO, not self._equipMO and not trialEquipCO)
		gohelper.setActive(self._equip.equipGolv, self._equipMO or trialEquipCO)
		ZProj.UGUIHelper.SetColorAlpha(self._equip.equiptxten, (self._equipMO or trialEquipCO) and 0.15 or 0.06)

		if self._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._equip.equipIcon, self._equipMO.config.icon)

			local _, _, equipLv = HeroGroupBalanceHelper.getBalanceLv()

			if equipLv and equipLv > self._equipMO.level and self._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				self._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. equipLv
			else
				local level = V1a6_CachotTeamModel.instance:getEquipMaxLevel(self._equipMO, self._seatLevel)
				local convertLevel = self._equipMO.level ~= level

				self._equip.equiptxtlv.text = "LV." .. level

				if convertLevel then
					SLFramework.UGUI.GuiHelper.SetColor(self._equip.equiptxtlv, "#bfdaff")
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._equip.equiptxtlv, "#d2d2d2")
				end
			end

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

function V1a6_CachotHeroGroupHeroItem:_showEquipParticleEffect(equipIndex)
	if equipIndex == self.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function V1a6_CachotHeroGroupHeroItem:_equipIconAddDrag(go)
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

function V1a6_CachotHeroGroupHeroItem:_onBeginDrag(equipTransform, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if self.trialCO and self.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return
	end

	gohelper.setAsLastSibling(self._heroGroupListView.heroPosTrList[self.mo.id].parent.gameObject)

	local pos = pointerEventData.position
	local scale = V1a6_CachotHeroGroupHeroItem.EquipDragOtherScale

	if GameUtil.isMobilePlayerAndNotEmulator() then
		scale = V1a6_CachotHeroGroupHeroItem.EquipDragMobileScale
		pos = pos + V1a6_CachotHeroGroupHeroItem.EquipDragOffset
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._equipGO.transform)

	self:_tweenToPos(self._equip.moveContainer.transform, anchorPos)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(self._equip.equipGolv, false)
	self:killEquipTweenId()

	self.equipTweenId = ZProj.TweenHelper.DOScale(equipTransform.parent, scale, scale, scale, V1a6_CachotHeroGroupHeroItem.EquipTweenDuration)
end

function V1a6_CachotHeroGroupHeroItem:_onDrag(param, pointerEventData)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if self.trialCO and self.trialCO.equipId > 0 then
		return
	end

	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + V1a6_CachotHeroGroupHeroItem.EquipDragOffset
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._equipGO.transform)

	self:_tweenToPos(self._equip.moveContainer.transform, anchorPos)
end

function V1a6_CachotHeroGroupHeroItem:_onEndDrag(equipTransform, pointerEventData)
	if self.trialCO and self.trialCO.equipId > 0 then
		return
	end

	self:killEquipTweenId()

	self.equipTweenId = ZProj.TweenHelper.DOScale(equipTransform.parent, 1, 1, 1, V1a6_CachotHeroGroupHeroItem.EquipTweenDuration)

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local pos = pointerEventData.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		pos = pos + V1a6_CachotHeroGroupHeroItem.EquipDragOffset
	end

	local targetHeroItem = self:_moveToTarget(pos)

	self:_setEquipDragEnabled(false)

	if targetHeroItem then
		::label_14_0::

		local var_14_0 = targetHeroItem.trialCO

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
				EquipTeamListModel.instance:openTeamEquip(self.mo.id - 1, self._heroMO, V1a6_CachotHeroGroupModel.instance:getCurGroupMO())

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
					V1a6_CachotHeroGroupController.removeEquip(srcPos, true)
				end

				local targetEquipId = EquipTeamListModel.instance:getTeamEquip(targetPos)[1]

				targetEquipId = (EquipModel.instance:getEquip(targetEquipId) or HeroGroupTrialModel.instance:getEquipMo(targetEquipId)) and targetEquipId or nil

				if targetEquipId then
					V1a6_CachotHeroGroupController.removeEquip(targetPos, true)
				end

				if srcEquipId then
					V1a6_CachotHeroGroupController.replaceEquip(targetPos, srcEquipId, true)
				end

				if targetEquipId then
					V1a6_CachotHeroGroupController.replaceEquip(srcPos, targetEquipId, true)
				end

				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
				V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
			end, self)
		end
	end
end

function V1a6_CachotHeroGroupHeroItem:_playDragEndAudio(targetHeroItem)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function V1a6_CachotHeroGroupHeroItem:_tweenToPos(transform, anchorPos)
	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)
	end
end

function V1a6_CachotHeroGroupHeroItem:_setToPos(transform, anchorPos, tween, callback, callbackObj)
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

function V1a6_CachotHeroGroupHeroItem:_moveToTarget(position)
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

function V1a6_CachotHeroGroupHeroItem:_setEquipDragEnabled(isEnabled)
	for i, heroItem in ipairs(self._heroGroupListView._heroItemList) do
		if heroItem._drag then
			heroItem._drag.enabled = isEnabled
		end
	end
end

function V1a6_CachotHeroGroupHeroItem:addEventListeners()
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

function V1a6_CachotHeroGroupHeroItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
	self._clickThis:RemoveClickUpListener()
	self._clickThis:RemoveClickDownListener()
	self._clickEquip:RemoveClickListener()
	self._clickEquip:RemoveClickUpListener()
	self._clickEquip:RemoveClickDownListener()
end

function V1a6_CachotHeroGroupHeroItem:playHeroGroupHeroEffect(state)
	self.anim:Play(state, 0, 0)

	self.last_equip = nil
	self.last_hero = nil
end

function V1a6_CachotHeroGroupHeroItem:onUpdateMO(mo)
	self._commonHeroCard:setGrayScale(false)

	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	self.mo = mo
	self._posIndex = self.mo.id - 1
	self._heroMO = mo:getHeroMO()
	self.monsterCO = mo:getMonsterCO()

	gohelper.setActive(self._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	local replay_data

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		replay_data = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[self.mo.heroUid]
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

					local originalLevel = self._heroMO.level
					local cachotLevel, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
					local convertLevel = originalLevel ~= cachotLevel

					if not isBalanceLv then
						lv = cachotLevel
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

						if convertLevel then
							SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, "#bfdaff")
							SLFramework.UGUI.GuiHelper.SetColor(self._lvnum, "#bfdaff")
						else
							SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, "#E9E9E9")
							SLFramework.UGUI.GuiHelper.SetColor(self._lvnum, "#E9E9E9")
						end
					end

					for i = 1, 3 do
						local img = self._goRankList[i]
						local visible = i == hero_rank - 1

						gohelper.setActive(img, visible)

						if visible then
							img.color = convertLevel and GameUtil.parseColor("#81abe5") or Color.white
						end
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

	self.isLock = not HeroGroupModel.instance:isPositionOpen(self.mo.id)
	self.isAidLock = self.mo.aid and self.mo.aid == -1
	self.isAid = self.mo.aid ~= nil
	self.isTrialLock = (self.mo.trial and self.mo.trialPos) ~= nil

	local roleNum = HeroGroupModel.instance:getBattleRoleNum()

	self.isRoleNumLock = roleNum and roleNum < self.mo.id
	self.isEmpty = mo:isEmpty()

	gohelper.setActive(self._heroGO, (self._heroMO ~= nil or self.monsterCO ~= nil or self.trialCO ~= nil) and not self.isLock and not self.isRoleNumLock)
	gohelper.setActive(self._noneGO, (self._heroMO ~= nil or self.monsterCO ~= nil or self.trialCO ~= nil) and (self.isLock or self.isAidLock or self.isRoleNumLock) or true)
	gohelper.setActive(self._addGO, self._heroMO == nil and self.monsterCO == nil and self.trialCO == nil and not self.isLock and not self.isAidLock and not self.isRoleNumLock)
	gohelper.setActive(self._lockGO, self:selfIsLock())
	gohelper.setActive(self._aidGO, self.mo.aid and self.mo.aid ~= -1)

	if battleCO then
		gohelper.setActive(self._subGO, not self.isLock and not self.isAidLock and not self.isRoleNumLock and self.mo.id > battleCO.playerMax)
	else
		gohelper.setActive(self._subGO, not self.isLock and not self.isAidLock and not self.isRoleNumLock and self.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

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

		self.anim:Play(UIAnimationName.Open, 0, 0)
	end

	self:_showMojingTip()
	self:_updateCachot()

	if self._heroItemContainer then
		self._heroItemContainer.compColor[self._lvnumen] = self._lvnumen.color
		self._heroItemContainer.compColor[self._lvnum] = self._lvnum.color
		self._heroItemContainer.compColor[self._txttalent] = self._txttalent.color
		self._heroItemContainer.compColor[self._txtlvtalent] = self._txtlvtalent.color
		self._heroItemContainer.compColor[self._icontalent] = self._icontalent.color

		for i = 1, 3 do
			self._heroItemContainer.compColor[self._goRankList[i]] = self._goRankList[i].color
		end
	end
end

function V1a6_CachotHeroGroupHeroItem:moveQuality()
	if self._qualityDefaultPos then
		return
	end

	local transform = self._goquality.transform

	self._qualityDefaultPos = transform.position

	local pos = self._qualityDefaultPos

	gohelper.addChild(self._heroGroupListView.heroGo, self._goquality)

	transform.position = pos
end

function V1a6_CachotHeroGroupHeroItem:resetQualityParent()
	local transform = self._goquality.transform
	local pos = transform.position

	gohelper.addChild(self._animGO, self._goquality)

	transform.position = pos
	self._goquality.name = "#go_quality"
end

function V1a6_CachotHeroGroupHeroItem:_updateCachot()
	self._seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(self._index)

	UISpriteSetMgr.instance:setV1a6CachotSprite(self._seaticon, "v1a6_cachot_quality2_0" .. self._seatLevel)
	UISpriteSetMgr.instance:setV1a6CachotSprite(self._seatbgicon, "v1a6_cachot_quality3_0" .. self._seatLevel)

	if not self._qualityEffectList then
		self._qualityEffectList = self:getUserDataTb_()

		local effectGo = gohelper.findChild(self._goquality, "quality_effect")
		local transform = effectGo.transform
		local childCount = transform.childCount

		for i = 1, childCount do
			local child = transform:GetChild(i - 1)

			if string.find(child.name, "effect_") then
				self._qualityEffectList[child.name] = child
			end
		end
	end

	local targetName = "effect_0" .. self._seatLevel

	for k, v in pairs(self._qualityEffectList) do
		gohelper.setActive(v, k == targetName)
	end

	self:_updateHp()
	self:_updateTalent()
end

function V1a6_CachotHeroGroupHeroItem:_updateTalent()
	if not self._heroMO then
		return
	end

	local cachotLevel, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
	local showLevel, rank = HeroConfig.instance:getShowLevel(cachotLevel)
	local showRank = rank >= CharacterEnum.TalentRank and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)

	gohelper.setActive(self._gotalent, showRank)

	if not showRank then
		return
	end

	local originalTalentLevel = self._heroMO.talent
	local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
	local convertTalentLevel = originalTalentLevel ~= talentLevel

	self._txttalent.text = talentLevel

	if convertTalentLevel then
		SLFramework.UGUI.GuiHelper.SetColor(self._txttalent, "#bfdaff")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtlvtalent, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txttalent, "#E9E9E9")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtlvtalent, "#E9E9E9")
	end

	self._icontalent.color = convertTalentLevel and GameUtil.parseColor("#81abe5") or Color.white
end

function V1a6_CachotHeroGroupHeroItem:_updateHp()
	gohelper.setActive(self._gohp, self._heroMO)

	if not self._heroMO then
		return
	end

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()
	local hpInfo = teamInfo:getHeroHp(self._heroMO.heroId)

	if hpInfo then
		if not hpInfo.life then
			local hpValue = 0

			self._sliderhp:SetValue(hpValue / 1000)
		end
	end
end

function V1a6_CachotHeroGroupHeroItem:selfIsLock()
	return self.isLock or self.isAidLock or self.isRoleNumLock
end

function V1a6_CachotHeroGroupHeroItem:checkWeekWalkCd()
	if HeroGroupModel.instance:isAdventureOrWeekWalk() and self._heroMO ~= nil and self.monsterCO == nil then
		local cd = WeekWalkModel.instance:getCurMapHeroCd(self._heroMO.config.id)

		if cd > 0 then
			self._playDeathAnim = true

			self.anim:Play("herogroup_hero_deal", 0, 0)

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return self._heroMO.id
		else
			self._commonHeroCard:setGrayScale(false)
		end
	end
end

function V1a6_CachotHeroGroupHeroItem:playRestrictAnimation(needRestrictHeroUidDict)
	if self._heroMO and needRestrictHeroUidDict[self._heroMO.uid] then
		self._playDeathAnim = true

		self.anim:Play("herogroup_hero_deal", 0, 0)

		self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)
	end
end

function V1a6_CachotHeroGroupHeroItem:setGrayFactor(value)
	self._commonHeroCard:setGrayFactor(value)
end

function V1a6_CachotHeroGroupHeroItem:showCounterSign()
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

	local recommended, counter = FightHelper.detectAttributeCounter()
	local showRecommended = tabletool.indexOf(recommended, career)

	gohelper.setActive(self._gorecommended, showRecommended)

	local showCounter = tabletool.indexOf(counter, career)

	gohelper.setActive(self._gocounter, showCounter)
	recthelper.setAnchorY(self._gohp.transform, (showRecommended or showCounter) and -292 or -271)
end

function V1a6_CachotHeroGroupHeroItem:_setUIPressState(graphicCompArr, isPress, oriColorMap)
	if not graphicCompArr then
		return
	end

	local iter = graphicCompArr:GetEnumerator()

	while iter:MoveNext() do
		local color

		if isPress then
			color = oriColorMap and oriColorMap[iter.Current] * 0.7 or V1a6_CachotHeroGroupHeroItem.PressColor
			color.a = iter.Current.color.a
		else
			color = oriColorMap and oriColorMap[iter.Current] or Color.white
		end

		iter.Current.color = color
	end
end

function V1a6_CachotHeroGroupHeroItem:_onClickThis()
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

function V1a6_CachotHeroGroupHeroItem:_onClickThisDown()
	self:_setHeroItemPressState(true)
end

function V1a6_CachotHeroGroupHeroItem:_onClickThisUp()
	self:_setHeroItemPressState(false)
end

function V1a6_CachotHeroGroupHeroItem:_setHeroItemPressState(press)
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
			if not V1a6_CachotHeroGroupHeroItem.PressColor then
				self._imageAdd.color = Color.white
			end
		end
	end
end

function V1a6_CachotHeroGroupHeroItem:_onClickEquip()
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or self.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		local heroGroupMO = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()

		self._viewParam = {
			seatLevel = self._seatLevel,
			heroGroupMo = heroGroupMO,
			heroMo = self._heroMO,
			equipMo = self._equipMO,
			posIndex = self._posIndex,
			fromView = EquipEnum.FromViewEnum.FromCachotHeroGroupFightView
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

function V1a6_CachotHeroGroupHeroItem:_onClickEquipDown()
	self:_setEquipItemPressState(true)
end

function V1a6_CachotHeroGroupHeroItem:_onClickEquipUp()
	self:_setEquipItemPressState(false)
end

function V1a6_CachotHeroGroupHeroItem:_setEquipItemPressState(press)
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

function V1a6_CachotHeroGroupHeroItem:_onOpenEquipTeamView()
	V1a6_CachotEquipInfoTeamListModel.instance:setSeatLevel(self._seatLevel)
	V1a6_CachotController.instance:openV1a6_CachotEquipInfoTeamShowView(self._viewParam)
end

function V1a6_CachotHeroGroupHeroItem:onItemBeginDrag(index)
	if index == self.mo.id then
		ZProj.TweenHelper.DOScale(self.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(self._dragFrameGO, true)
		gohelper.setActive(self._dragFrameSelectGO, true)
		gohelper.setActive(self._dragFrameCompleteGO, false)
		gohelper.setActive(self._seatbgicon, false)
	end

	gohelper.setActive(self._clickGO, false)
end

function V1a6_CachotHeroGroupHeroItem:onItemEndDrag(index, dragToIndex)
	gohelper.setActive(self._seatbgicon, true)
	ZProj.TweenHelper.DOScale(self.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	self:_setHeroItemPressState(false)
end

function V1a6_CachotHeroGroupHeroItem:onItemCompleteDrag(index, dragToIndex, complete)
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

function V1a6_CachotHeroGroupHeroItem:hideDragEffect()
	gohelper.setActive(self._dragFrameGO, false)
end

function V1a6_CachotHeroGroupHeroItem:setHeroGroupEquipEffect(show)
	self._canPlayEffect = show
end

function V1a6_CachotHeroGroupHeroItem:killEquipTweenId()
	if self.equipTweenId then
		ZProj.TweenHelper.KillById(self.equipTweenId)
	end
end

function V1a6_CachotHeroGroupHeroItem:onDestroy()
	self:killEquipTweenId()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	TaskDispatcher.cancelTask(self._onOpenEquipTeamView, self)
	TaskDispatcher.cancelTask(self.hideDragEffect, self)
end

return V1a6_CachotHeroGroupHeroItem
