-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamItem", package.seeall)

local V1a6_CachotTeamItem = class("V1a6_CachotTeamItem", ListScrollCellExtend)

function V1a6_CachotTeamItem:onInitView()
	self._gorole = gohelper.findChild(self.viewGO, "#go_role")
	self._gorolenone = gohelper.findChild(self.viewGO, "#go_role/#go_rolenone")
	self._goroleunselect = gohelper.findChild(self.viewGO, "#go_role/#go_roleunselect")
	self._goroledead = gohelper.findChild(self.viewGO, "#go_role/#go_roledead")
	self._goroleselect = gohelper.findChild(self.viewGO, "#go_role/#go_roleselect")
	self._simagerolehead = gohelper.findChildSingleImage(self.viewGO, "#go_role/#go_roleselect/mask/#simage_rolehead")
	self._godeadmask = gohelper.findChildSingleImage(self.viewGO, "#go_role/#go_roleselect/mask/deadmask")
	self._careericon = gohelper.findChildImage(self.viewGO, "#go_role/#go_roleselect/mask/career")
	self._txtroleLv1 = gohelper.findChildText(self.viewGO, "#go_role/#go_roleselect/#txt_roleLv1")
	self._txtroleLv2 = gohelper.findChildText(self.viewGO, "#go_role/#go_roleselect/#txt_roleLv2")
	self._txtrolename = gohelper.findChildText(self.viewGO, "#go_role/#go_roleselect/#txt_rolename")
	self._gotalentnone = gohelper.findChild(self.viewGO, "#go_role/#go_roleselect/none")
	self._gohp = gohelper.findChild(self.viewGO, "#go_role/#go_roleselect/#go_hp")
	self._sliderhp = gohelper.findChildSlider(self.viewGO, "#go_role/#go_roleselect/#go_hp/#slider_hp")
	self._btnroleclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_role/#btn_roleclick")
	self._goheart = gohelper.findChild(self.viewGO, "#go_heart")
	self._goheartnone = gohelper.findChild(self.viewGO, "#go_heart/#go_heartnone")
	self._goheartunselect = gohelper.findChild(self.viewGO, "#go_heart/#go_heartunselect")
	self._goheartselect = gohelper.findChild(self.viewGO, "#go_heart/#go_heartselect")
	self._simageheart = gohelper.findChildSingleImage(self.viewGO, "#go_heart/#go_heartselect/#simage_heart")
	self._txtheartLv = gohelper.findChildText(self.viewGO, "#go_heart/#go_heartselect/#simage_heart/#txt_heartLv")
	self._btnheartclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_heart/#btn_heartclick")
	self._gocost = gohelper.findChild(self.viewGO, "#go_cost")
	self._txtcost = gohelper.findChildText(self.viewGO, "#go_cost/#txt_cost")
	self._txtmax = gohelper.findChildText(self.viewGO, "#go_cost/#txt_max")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goselect2 = gohelper.findChild(self.viewGO, "#go_select2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotTeamItem:addEvents()
	self._btnroleclick:AddClickListener(self._btnroleclickOnClick, self)
	self._btnheartclick:AddClickListener(self._btnheartclickOnClick, self)
end

function V1a6_CachotTeamItem:removeEvents()
	self._btnroleclick:RemoveClickListener()
	self._btnheartclick:RemoveClickListener()
end

function V1a6_CachotTeamItem:_btnselectOnClick()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnClickTeamItem, self._mo)
end

function V1a6_CachotTeamItem:_btnheartclickOnClick()
	self:_onClickEquip()
end

function V1a6_CachotTeamItem:_btnroleclickOnClick()
	self:_openHeroGroupEditView()
end

function V1a6_CachotTeamItem:_onClickEquip()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)

		local heroGroupMO = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()
		local param = {
			seatLevel = self._seatLevel,
			heroGroupMo = heroGroupMO,
			heroMo = self._heroMO,
			equipMo = self._equipMO,
			posIndex = self._mo.id - 1,
			fromView = EquipEnum.FromViewEnum.FromCachotHeroGroupView
		}

		V1a6_CachotEquipInfoTeamListModel.instance:setSeatLevel(self._seatLevel)
		V1a6_CachotController.instance:openV1a6_CachotEquipInfoTeamShowView(param)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function V1a6_CachotTeamItem:_openHeroGroupEditView()
	local id = self._mo.id
	local heroGroupMO = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()
	local equips = heroGroupMO:getPosEquips(id - 1).equipUid
	local param = {}

	param.singleGroupMOId = id
	param.originalHeroUid = V1a6_CachotHeroSingleGroupModel.instance:getHeroUid(id)
	param.equips = equips
	param.heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Init
	param.seatLevel = self._seatLevel

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, param)
end

function V1a6_CachotTeamItem:setHpVisible(value)
	gohelper.setActive(self._gohp, value)
end

function V1a6_CachotTeamItem:setInteractable(value)
	self._interactable = value
end

function V1a6_CachotTeamItem:setSelectEnable(value)
	if not self._btnselect then
		self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "btn_select")

		self._btnselect:AddClickListener(self._btnselectOnClick, self)
	end

	gohelper.setActive(self._btnselect, value)
end

function V1a6_CachotTeamItem:setSelected(value)
	gohelper.setActive(self._goselect, value)
end

function V1a6_CachotTeamItem:setCost(value)
	gohelper.setActive(self._txtcost, value)
	gohelper.setActive(self._txtmax, not value)

	self._txtcost.text = value

	gohelper.setActive(self._gocost, true)
end

function V1a6_CachotTeamItem:_setSeatIndex(value)
	self._seatIndex = value
end

function V1a6_CachotTeamItem:getSeatIndex()
	return self._seatIndex
end

function V1a6_CachotTeamItem:_setSeatLevel(level)
	self._qualityLevel = level

	if not self._quality then
		self._quality = gohelper.findChildImage(self.viewGO, "quality")
		self._qualityEffectList = self:getUserDataTb_()

		local qualityeffect = gohelper.findChild(self.viewGO, "quality_effect")
		local transform = qualityeffect.transform
		local childCount = transform.childCount

		for i = 1, childCount do
			local child = transform:GetChild(i - 1)

			self._qualityEffectList[child.name] = child
		end
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(self._quality, "v1a6_cachot_quality_0" .. level)

	local targetName = "effect_0" .. level

	for k, v in pairs(self._qualityEffectList) do
		gohelper.setActive(v, k == targetName)
	end
end

function V1a6_CachotTeamItem:showSelectEffect()
	self._selectedEffect = self._selectedEffect or gohelper.findChild(self.viewGO, "effect_select")

	gohelper.setActive(self._selectedEffect, false)
	gohelper.setActive(self._selectedEffect, true)
end

function V1a6_CachotTeamItem:_editableInitView()
	self._heartImg = gohelper.findChildImage(self.viewGO, "#go_heart/#go_heartselect/#simage_heart")
	self._goStarList = self:getUserDataTb_()

	for i = 1, 6 do
		local starGO = gohelper.findChild(self.viewGO, "#go_role/#go_roleselect/rare/go_rare" .. i)

		table.insert(self._goStarList, starGO)
	end

	self._rankList = self:getUserDataTb_()

	for i = 1, 3 do
		local starImg = gohelper.findChildImage(self.viewGO, "#go_role/#go_roleselect/rankobj/rank" .. i)

		table.insert(self._rankList, starImg)
	end

	gohelper.setActive(self._gohp, false)
end

function V1a6_CachotTeamItem:_editableAddEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ChangeEquip, self._changeEquip, self)
end

function V1a6_CachotTeamItem:_editableRemoveEvents()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.ChangeEquip, self._changeEquip, self)
end

function V1a6_CachotTeamItem:_changeEquip(index)
	self:_updateEquip()
end

function V1a6_CachotTeamItem:getMo()
	return self._mo
end

function V1a6_CachotTeamItem:getHeroMo()
	return self._heroMO
end

function V1a6_CachotTeamItem:onUpdateMO(mo)
	self._mo = mo
	self._heroMO = mo:getHeroMO()

	local seatInfo = V1a6_CachotTeamModel.instance:getSeatInfo(mo)

	if seatInfo then
		self:_setSeatIndex(seatInfo[1])

		self._seatLevel = seatInfo[2]

		self:_setSeatLevel(self._seatLevel)
	else
		self._seatLevel = nil
	end

	self:_updateHero()
	self:_updateEquip()
end

function V1a6_CachotTeamItem:_updateHp()
	if not self._heroMO then
		self:setHpVisible(false)

		return
	end

	self:setHpVisible(true)

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()
	local hpInfo = teamInfo:getHeroHp(self._heroMO.heroId)

	if hpInfo then
		if not hpInfo.life then
			local hpValue = 0

			self._sliderhp:SetValue(hpValue / 1000)
			self:_showDeadStatus(hpValue <= 0)
		end
	end
end

function V1a6_CachotTeamItem:_showDeadStatus(isDead)
	gohelper.setActive(self._goroledead, isDead)
	gohelper.setActive(self._godeadmask, isDead)

	local x, y, z = transformhelper.getLocalPos(self._simagerolehead.transform)

	transformhelper.setLocalPos(self._simagerolehead.transform, x, y, isDead and 1 or 0)
end

function V1a6_CachotTeamItem:tweenHp(startValue, endValue, duration)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._tweenStartValue = startValue
	self._tweenEndValue = endValue
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, duration, self._tweenUpdate, self._tweenEnd, self, nil, EaseType.Linear)

	self:_tweenUpdate(0)
end

function V1a6_CachotTeamItem:_tweenUpdate(val)
	self._sliderhp:SetValue(Mathf.Lerp(self._tweenStartValue, self._tweenEndValue, val) / 1000)
end

function V1a6_CachotTeamItem:_updateHero()
	gohelper.setActive(self._btnroleclick, self._interactable)

	local showNone = not self._heroMO and not self._interactable

	gohelper.setActive(self._gorolenone, showNone)
	gohelper.setActive(self._goroleunselect, not showNone and not self._heroMO)
	gohelper.setActive(self._goroleselect, not showNone and self._heroMO)

	if not self._heroMO then
		return
	end

	local originalLevel = self._heroMO.level
	local originalTalentLevel = self._heroMO.talent
	local level, talentLevel = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._heroMO, self._seatLevel)
	local convertLevel = originalLevel ~= level
	local convertTalentLevel = originalTalentLevel ~= talentLevel
	local skinCo = SkinConfig.instance:getSkinCo(self._heroMO.skin)

	self._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(skinCo.headIcon))
	UISpriteSetMgr.instance:setV1a6CachotSprite(self._careericon, "v1a6_cachot_career_" .. self._heroMO.config.career)

	self._txtrolename.text = self._heroMO.config.name
	self._talentIcon = self._talentIcon or gohelper.findChildImage(self._txtroleLv2.gameObject, "icon")
	self._talentIcon.color = convertTalentLevel and GameUtil.parseColor("#81abe5") or Color.white
	self._txtroleLv2.text = "<size=17>LV</size>." .. tostring(talentLevel)

	if convertTalentLevel then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtroleLv2, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtroleLv2, "#e6e6e6")
	end

	local starCount = CharacterEnum.Star[self._heroMO.config.rare]

	for i, starGO in ipairs(self._goStarList) do
		gohelper.setActive(starGO, i <= starCount)
	end

	local showLevel, rank = HeroConfig.instance:getShowLevel(level)
	local showTalent = rank >= CharacterEnum.TalentRank and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)

	gohelper.setActive(self._txtroleLv2, showTalent)
	gohelper.setActive(self._gotalentnone, not showTalent)

	self._txtroleLv1.text = "<size=17>LV</size>." .. tostring(showLevel)

	if convertLevel then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtroleLv1, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtroleLv1, "#e6e6e6")
	end

	for i, img in ipairs(self._rankList) do
		local visible = i == rank - 1

		gohelper.setActive(img, visible)

		if visible then
			img.color = convertLevel and GameUtil.parseColor("#81abe5") or Color.white
		end
	end
end

function V1a6_CachotTeamItem:_getEquipMO()
	if self._mo then
		local curGroupMO = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()
		local equips = curGroupMO:getPosEquips(self._mo.id - 1).equipUid
		local equipId = equips[1]

		self._equipMO = EquipModel.instance:getEquip(equipId)
	end
end

function V1a6_CachotTeamItem:hideEquipNone()
	self._hideEquipNone = true
end

function V1a6_CachotTeamItem:_updateEquip()
	gohelper.setActive(self._btnheartclick, self._interactable)
	self:_getEquipMO()

	local showNone = not self._equipMO and not self._interactable

	gohelper.setActive(self._goheartnone, showNone and not self._hideEquipNone)
	gohelper.setActive(self._goheartunselect, not showNone and not self._equipMO)
	gohelper.setActive(self._goheartselect, not showNone and self._equipMO)

	if self._equipMO then
		local level = V1a6_CachotTeamModel.instance:getEquipMaxLevel(self._equipMO, self._seatLevel)
		local convertLevel = self._equipMO.level ~= level

		self._txtheartLv.text = "LV." .. level

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._heartImg, self._equipMO.config.icon)

		if convertLevel then
			SLFramework.UGUI.GuiHelper.SetColor(self._txtheartLv, "#bfdaff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(self._txtheartLv, "#A8A8A8")
		end
	end
end

function V1a6_CachotTeamItem:onSelect(isSelect)
	return
end

function V1a6_CachotTeamItem:onDestroyView()
	self._simagerolehead:UnLoadImage()

	if self._btnselect then
		self._btnselect:RemoveClickListener()
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return V1a6_CachotTeamItem
