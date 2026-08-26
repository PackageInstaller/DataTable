-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotHeroGroupEditItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditItem", package.seeall)

local V1a6_CachotHeroGroupEditItem = class("V1a6_CachotHeroGroupEditItem", ListScrollCell)

function V1a6_CachotHeroGroupEditItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)

	self._hptextwhite = gohelper.findChildText(go, "hpbg/hptextwhite")
	self._hptextred = gohelper.findChildText(go, "hpbg/hptextred")
	self._hpimage = gohelper.findChildImage(go, "hpbg/hp")
	self._goselect = gohelper.findChild(go, "#go_select")
	self._gohp = gohelper.findChild(go, "#go_hp")
	self._sliderhp = gohelper.findChildSlider(go, "#go_hp/#slider_hp")
	self._godead = gohelper.findChild(go, "#go_dead")

	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._gohp, false)
	gohelper.setActive(self._godead, false)
	self:_initObj(go)
end

function V1a6_CachotHeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)

	self._heroGroupModel = V1a6_CachotHeroGroupModel.instance
	self._heroSingleGroupModel = V1a6_CachotHeroSingleGroupModel.instance
end

function V1a6_CachotHeroGroupEditItem:addEventListeners()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
end

function V1a6_CachotHeroGroupEditItem:removeEventListeners()
	return
end

function V1a6_CachotHeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function V1a6_CachotHeroGroupEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function V1a6_CachotHeroGroupEditItem:updateLimitStatus()
	if HeroGroupQuickEditListModel.instance.adventure then
		gohelper.setActive(self._gohp, false)

		local cd = WeekWalkModel.instance:getCurMapHeroCd(self._mo.config.id)

		self._heroItem:setInjury(cd > 0)
	else
		gohelper.setActive(self._gohp, false)

		if self._heroGroupModel:isRestrict(self._mo.uid) then
			self._heroItem:setRestrict(true)
		else
			self._heroItem:setRestrict(false)
		end
	end
end

function V1a6_CachotHeroGroupEditItem:_updateBySeatLevel()
	local originalLevel = self._mo.level
	local level = originalLevel
	local seatLevel = V1a6_CachotHeroGroupEditListModel.instance:getSeatLevel()

	if seatLevel then
		level = V1a6_CachotTeamModel.instance:getHeroMaxLevel(self._mo, seatLevel)
	end

	local showLevel, rank = HeroConfig.instance:getShowLevel(level)
	local convertLevel = originalLevel ~= level

	self._heroItem._lvTxt.text = tostring(showLevel)

	local txtColor, iconColor
	local nameColor = "#FFFFFF"

	if convertLevel then
		txtColor = "#bfdaff"
		iconColor = "#81abe5"
	else
		txtColor = "#E9E9E9"
		iconColor = "#F6F3EC"
	end

	if self._isDead then
		nameColor = "#6F6F6F"
		txtColor = "#6F6F6F"
		iconColor = "#595959"
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._heroItem._lvTxt, txtColor)
	SLFramework.UGUI.GuiHelper.SetColor(self._heroItem._lvTxtEn, txtColor)
	self._heroItem:_fillStarContentColor(self._mo.config.rare, rank, iconColor)
	SLFramework.UGUI.GuiHelper.SetColor(self._heroItem._nameCnTxt, nameColor)
	gohelper.setActive(self._heroItem._maskgray, self._isDead)
end

function V1a6_CachotHeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	if not mo:isTrial() then
		local lv = HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()

	local inteam = V1a6_CachotHeroGroupEditListModel.instance:isInTeamHero(self._mo.uid)

	self._inTeam = inteam

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(inteam)
	self:_updateCachot()
	self:_updateBySeatLevel()
end

function V1a6_CachotHeroGroupEditItem:_updateCachot()
	if V1a6_CachotHeroGroupEditListModel.instance:getHeroGroupEditType() == V1a6_CachotEnum.HeroGroupEditType.Init then
		return
	end

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()
	local hpInfo = teamInfo:getHeroHp(self._mo.heroId)

	if not hpInfo then
		return
	end

	if hpInfo then
		if not hpInfo.life then
			local hpValue = 0

			gohelper.setActive(self._gohp, true)
			self._sliderhp:SetValue(hpValue / 1000)

			local isDead = hpValue <= 0

			gohelper.setActive(self._godead, isDead)
			self._heroItem:setDamage(isDead)

			self._heroItem._isInjury = false
			self._isDead = isDead
		end
	end
end

function V1a6_CachotHeroGroupEditItem:updateTrialTag()
	local txt

	self._heroItem:setTrialTxt((self._mo:isTrial() or nil) and luaLang("herogroup_trial_tag0"))
end

function V1a6_CachotHeroGroupEditItem:updateTrialRepeat()
	local singleGroupMO = self._heroSingleGroupModel:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = V1a6_CachotHeroGroupEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function V1a6_CachotHeroGroupEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function V1a6_CachotHeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local singleGroupMO = self._heroSingleGroupModel:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not self._heroSingleGroupModel:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and V1a6_CachotHeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo.isPosLock or not singleGroupMO:isEmpty() and singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._heroGroupModel:isRestrict(self._mo.uid) then
		local battleCo = self._heroGroupModel:getCurrentBattleConfig()
		local restrictReason = battleCo and battleCo.restrictReason

		if not string.nilorempty(restrictReason) then
			ToastController.instance:showToastWithString(restrictReason)
		end

		return
	end

	if V1a6_CachotHeroGroupEditListModel.instance:getHeroGroupEditType() == V1a6_CachotEnum.HeroGroupEditType.Event and self._inTeam then
		GameFacade.showToast(ToastEnum.V1a6CachotToast03)

		return
	end

	if self._isSelect and self._enableDeselect and not self._mo.isPosLock then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

function V1a6_CachotHeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function V1a6_CachotHeroGroupEditItem:onDestroy()
	return
end

function V1a6_CachotHeroGroupEditItem:getAnimator()
	return self._animator
end

return V1a6_CachotHeroGroupEditItem
