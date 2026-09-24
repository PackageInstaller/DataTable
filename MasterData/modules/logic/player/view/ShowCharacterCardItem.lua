-- chunkname: @modules/logic/player/view/ShowCharacterCardItem.lua

module("modules.logic.player.view.ShowCharacterCardItem", package.seeall)

local ShowCharacterCardItem = class("ShowCharacterCardItem", ListScrollCell)

function ShowCharacterCardItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:setStyle_CharacterBackpack()

	self._mask = gohelper.findChild(self._gocharactercarditem, "nummask")
	self._masknum = gohelper.findChildText(self._gocharactercarditem, "nummask/num")
	self._shownum = 0

	self:_initObj()

	self._badgeTblList = {}

	for i = 1, 3 do
		local badgeTbl = self:getUserDataTb_()
		local goBadge = gohelper.findChild(go, "badge/layout/badge" .. tostring(i))

		if goBadge then
			badgeTbl.goEmpty = gohelper.findChild(goBadge, "empty")
			badgeTbl.simageIcon = gohelper.findChildSingleImage(goBadge, "simage_badge")
		end

		self._badgeTblList[i] = badgeTbl
	end

	self._goCount = gohelper.findChild(go, "go_Count")
	self._txtCount = gohelper.findChildText(go, "go_Count/txt_Count")
	self._btnBadge = gohelper.findChildButtonWithAudio(go, "btn_Badge")
	self._goNew = gohelper.findChild(go, "badge/go_New")
end

function ShowCharacterCardItem:_initObj()
	self._animator = gohelper.findComponentAnim(self._heroItem.go)
end

function ShowCharacterCardItem:addEventListeners()
	self.addClickCb(self, self._btnBadge, self._btnBadgeOnClick, self)
	self.addEventCb(self, AssistController.instance, AssistEvent.UpdateWearBadges, self.onWearBadgesUpdate, self)
	self.addEventCb(self, AssistController.instance, AssistEvent.UpdateNewTag, self.refreshNewTag, self)
end

function ShowCharacterCardItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)
	self:_initShowHeroList()
	self:refreshLikeCount()
	self:refreshBadge()
end

function ShowCharacterCardItem:_initShowHeroList()
	local heros = PlayerModel.instance:getShowHeros()

	self:_initnum((self:_clecknum(heros)))
end

function ShowCharacterCardItem:_onItemClick()
	if self.noClick then
		return
	end

	local heros = PlayerModel.instance:getShowHeros()

	if self._shownum ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		self._heroItem:setChoose(nil)
		PlayerModel.instance:setShowHero(self._shownum, 0)

		self._shownum = 0
	else
		self:_addHeroShow(heros)

		if self._shownum ~= 0 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
		end

		PlayerModel.instance:setShowHero(self._shownum, self._mo.heroId)
	end
end

function ShowCharacterCardItem:_addHeroShow(heros)
	for i = 1, #heros do
		if heros[i] == 0 then
			self:_initnum(i)

			return
		end
	end
end

function ShowCharacterCardItem:_clecknum(heros)
	local num = 0

	for i = 1, #heros do
		if heros[i] ~= 0 and self._mo.heroId == heros[i].heroId then
			num = i
		end
	end

	return num
end

function ShowCharacterCardItem:_initnum(num)
	if num == 0 then
		self._heroItem:setChoose(nil)
	elseif not self.noChoose then
		self._heroItem:setChoose(num)
	end

	self._shownum = num
end

function ShowCharacterCardItem:getAnimator()
	return self._animator
end

function ShowCharacterCardItem:_btnBadgeOnClick()
	if self.noClick then
		return
	end

	ViewMgr.instance:openView(ViewName.AssistRoleBadgeView, self._mo)
end

function ShowCharacterCardItem:onWearBadgesUpdate(uid)
	if self._mo.uid == uid then
		self:refreshBadge()
	end
end

function ShowCharacterCardItem:refreshLikeCount()
	local aRecordInfoMo = AssistRecordModel.instance:getRecordInfo()

	if aRecordInfoMo then
		local statMo = aRecordInfoMo:getHeroStatMo(self._mo.uid)

		if statMo then
			if not statMo.count then
				local count = 0

				self._txtCount.text = GameUtil.numberDisplayCustom(count, 4, 6)

				gohelper.setActive(self._goCount, count ~= 0)
			end
		end
	else
		gohelper.setActive(self._goCount, false)
	end
end

function ShowCharacterCardItem:refreshBadge()
	local bInfoMo = RoleBadgeModel.instance:getBadgeInfo()

	if not bInfoMo then
		for _, v in ipairs(self._badgeTblList) do
			gohelper.setActive(v.goEmpty, true)
			gohelper.setActive(v.simageIcon, false)
		end

		return
	end

	self.recordMo = bInfoMo:getRecordMo(self._mo.uid)

	for k, v in ipairs(self._badgeTblList) do
		if self.recordMo then
			local wearMo = self.recordMo:getWearMo(k)

			if self.recordMo then
				if not self.recordMo.badgeId then
					local badgeId = 0

					if badgeId ~= 0 then
						local badgeMo = self.recordMo:getBadgeMo(badgeId)

						if badgeMo and badgeMo.config then
							v.simageIcon:LoadImage(ResUrl.getRoleBadgeSingleBg(badgeMo.config.icon))
						end
					end

					gohelper.setActive(v.goEmpty, badgeId == 0)
					gohelper.setActive(v.simageIcon, badgeId ~= 0)
				end
			end
		end
	end

	self:refreshNewTag()
end

function ShowCharacterCardItem:setShowParam(noClick, noChoose)
	self.noClick = noClick
	self.noChoose = noChoose
end

function ShowCharacterCardItem:refreshNewTag(heroUid)
	if not heroUid or heroUid == self._mo.uid then
		if self.recordMo then
			local hasNewTag = self.recordMo:hasNewTag()

			gohelper.setActive(self._goNew, hasNewTag)
		end
	end
end

function ShowCharacterCardItem:setActiveAnimator(enabled)
	self._animator.enabled = enabled
end

ShowCharacterCardItem.prefabPath = "ui/viewres/player/showcharactercarditem.prefab"

return ShowCharacterCardItem
