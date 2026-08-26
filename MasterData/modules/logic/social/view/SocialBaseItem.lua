-- chunkname: @modules/logic/social/view/SocialBaseItem.lua

module("modules.logic.social.view.SocialBaseItem", package.seeall)

local SocialBaseItem = class("SocialBaseItem", LuaCompBase)

function SocialBaseItem:onInitView(go, parent)
	self.viewGO = go
	self.viewParent = parent
	self._gotag = gohelper.findChild(self.viewGO, "box/tag")
	self._goplayericon = gohelper.findChild(self.viewGO, "box/#go_playericon")
	self._txtlevel = gohelper.findChildText(self.viewGO, "box/#txt_level")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "box/skinnode/#simage_role")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "box/skinnode/#simage_role/#btn_role")
	self._goachieve = gohelper.findChild(self.viewGO, "box/go_achievement")
	self._txtachieveNum = gohelper.findChildText(self.viewGO, "box/#txt_achieveNum")
	self._txtname = gohelper.findChildText(self.viewGO, "info/#txt_name")
	self._txtuid = gohelper.findChildText(self.viewGO, "info/#txt_uid")
	self._btncopy = gohelper.findChildButtonWithAudio(self.viewGO, "info/#txt_uid/#btn_copy")
	self._txtstatus = gohelper.findChildText(self.viewGO, "info/#txt_uid/status/#txt_status")
	self._txtofflinetime = gohelper.findChildText(self.viewGO, "info/#txt_uid/status/#txt_offlinetime")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "info/btn/#btn_add")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "info/btn/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "info/btn/#btn_cancel")
	self._gosent = gohelper.findChild(self.viewGO, "info/btn/#go_sent")
	self._gobadge = gohelper.findChild(self.viewGO, "info/badge")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialBaseItem:addEvents()
	return
end

function SocialBaseItem:removeEvents()
	return
end

function SocialBaseItem:_btncopyOnClick()
	ZProj.UGUIHelper.CopyText(self._txtuid.text)
	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function SocialBaseItem:_editableInitView()
	self:addEvents()
	self._btncopy:AddClickListener(self._btncopyOnClick, self)
	self:_initRole()
	self:_initTag()
	self:_initAchievement()

	self._badgeItems = self:getUserDataTb_()
	self._playericon = self._playericon or IconMgr.instance:getCommonPlayerIcon(self._goplayericon)
end

function SocialBaseItem:_initAchievement()
	self._achievementCls = MonoHelper.addNoUpdateLuaComOnceToGo(self._goachieve, CommonAchievement)

	self._achievementCls:onInitView(self._goachieve, self.viewParent)
end

function SocialBaseItem:_initRole()
	self._heros = {}
	self._heroParents = self:getUserDataTb_()

	for i = 1, 3 do
		self._heroParents[i] = gohelper.findChild(self.viewGO, "info/Role/" .. i)
	end
end

function SocialBaseItem:_initTag()
	self._tags = {}

	for i = 1, 4 do
		local tagItem = self:getUserDataTb_()

		tagItem.go = gohelper.findChild(self.viewGO, "box/tag/tag_" .. i)
		tagItem.imgicon = gohelper.findChildImage(tagItem.go, "#image_icon")
		tagItem.txtnum = gohelper.findChildText(tagItem.go, "#txt_num")

		if i > 1 then
			tagItem.txtnum2 = gohelper.findChildText(tagItem.go, "#txt_num2")
		end

		table.insert(self._tags, tagItem)
	end
end

function SocialBaseItem:onUpdateMO(mo)
	self._mo = mo
	self._playercardInfo = self._mo:getPlayerCardInfo()

	self:updateBox()
	self:updateInfo()
	self:updateAchievement()
	self:updateRole()
	self:_refreshBadges()
end

function SocialBaseItem:updateBox()
	local heroId, skinId, _, isL2d = self._playercardInfo:getMainHero()

	self:_updateHeroBg(heroId, skinId)
	self:_updateTag()
end

function SocialBaseItem:_updateTag()
	local selectMoList = self._playercardInfo:getBaseInfoSetting()
	local firstTag = self._tags[1]

	UISpriteSetMgr.instance:setSocialSkinSprite(firstTag.imgicon, "social_playercardicon_1", true)

	firstTag.txtnum.text = self._playercardInfo:getHeroCount()

	if selectMoList and #selectMoList > 0 then
		for _, selectMo in ipairs(selectMoList) do
			local pos = selectMo[1]
			local id = selectMo[2]
			local tag = self._tags[pos]

			if pos ~= 1 and tag then
				local isShowNum2 = SocialEnum.NeedShowTextType2[id]

				gohelper.setActive(tag.txtnum.gameObject, not isShowNum2)
				gohelper.setActive(tag.txtnum2.gameObject, isShowNum2)
				gohelper.setActive(tag.imgicon.gameObject, true)
				UISpriteSetMgr.instance:setSocialSkinSprite(tag.imgicon, "social_playercardicon_" .. id, true)

				tag.txtnum.text = self._playercardInfo:getBaseInfoByIndex(id)
				tag.txtnum2.text = self._playercardInfo:getBaseInfoByIndex(id)
			end
		end
	end

	local emptyposlist = self._playercardInfo:getEmptyBaseInfoPosList()

	for pos, empty in ipairs(emptyposlist) do
		if empty then
			local baseInfoNode = self._tags[pos]

			gohelper.setActive(baseInfoNode.imgicon.gameObject, false)
			gohelper.setActive(baseInfoNode.txtnum.gameObject, false)
			gohelper.setActive(baseInfoNode.txtnum2.gameObject, false)
		end
	end
end

function SocialBaseItem:_updateHeroBg(heroId, skinId)
	local hero = HeroModel.instance:getByHeroId(heroId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId or hero and hero.skin)

	if not skinCo then
		return
	end

	self.skinCo = skinCo
	self.heroCo = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self:resetRes()
	self._simagerole:LoadImage(ResUrl.getHeadIconImg(self.skinCo.id), self._loadedImage, self)
end

function SocialBaseItem:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simagerole.gameObject)

	local offsetStr = self.skinCo.playercardViewImgOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simagerole.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simagerole.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	end
end

function SocialBaseItem:resetRes()
	self._simagerole:UnLoadImage()
end

function SocialBaseItem:updateInfo()
	self._playericon:onUpdateMO(self._mo)
	self._playericon:setShowLevel(false)

	self._txtlevel.text = "Lv." .. self._mo.level

	local uidString = tostring(self._mo.userId)
	local uidLength = GameUtil.utf8len(uidString)

	self._txtname.text = string.format("%s#%s", self._mo.name, (uidLength > 3 or nil) and GameUtil.utf8sub(uidString, uidLength - 2, uidLength))
	self._txtuid.text = string.format(uidString)

	local isOnline = tonumber(self._mo.time) == 0

	if not isOnline then
		self._txtofflinetime.text = SocialConfig.instance:getStatusText(self._mo.time)
	end

	gohelper.setActive(self._goofflinebg, not isOnline)
	gohelper.setActive(self._txtstatus.gameObject, isOnline)
	gohelper.setActive(self._txtofflinetime.gameObject, not isOnline)

	self._txtstatus.text = luaLang("social_online")

	self:updateBtnState()
end

function SocialBaseItem:updateBtnState()
	return
end

function SocialBaseItem:updateAchievement()
	self._achievementCls:onUpdateMO(self._playercardInfo)

	self._txtachieveNum.text = self._playercardInfo.achievementCount == -1 and PlayerCardEnum.EmptyString2 or tostring(self._playercardInfo.achievementCount)
end

function SocialBaseItem:updateRole()
	if not self._mo.infos then
		local heroList = {}
		local count = #heroList

		for i = 1, 3 do
			local item = self:getHeroIcon(i)

			if i <= count then
				item:updateMo(heroList[i])
			else
				item:setActive(false)
			end
		end
	end
end

function SocialBaseItem:getHeroIcon(index)
	if not self._heros[index] then
		local go = self.viewParent:getResInst("ui/viewres/social/socialheroitem.prefab", self._heroParents[index], "HeroItem")

		self._heros[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SocialHeroItem)
	end

	return self._heros[index]
end

function SocialBaseItem:onSelect(isSelect)
	return
end

local badgePrefabPath = "ui/viewres/social/socialsearchbadgeview.prefab"

function SocialBaseItem:_refreshBadges()
	if not self._gobadge then
		return
	end

	local isHideBadge = self._playercardInfo:getShowSettingByType(PlayerCardEnum.ShowSettingsType.HideBadgeFormOther)
	local equipBadgeIds = self._playercardInfo:getEquipBadges()

	if equipBadgeIds and isHideBadge and isHideBadge == 0 then
		if self._badgePrefab then
			self:_refreshBadgeItems()
		elseif not self._isLoadingBadge then
			self._loader = self._loader or MultiAbLoader.New()

			self._loader:addPath(badgePrefabPath)
			self._loader:startLoad(self._onLoadFinish, self)

			self._isLoadingBadge = true
		end
	else
		for _, item in ipairs(self._badgeItems) do
			gohelper.setActive(item.go, false)
		end

		gohelper.setActive(self._badgePrefab, false)
	end
end

function SocialBaseItem:_refreshBadgeItems()
	local count = 0

	if self._playercardInfo then
		local equipBadgeIds = self._playercardInfo:getEquipBadges()

		if equipBadgeIds then
			for i, id in ipairs(equipBadgeIds) do
				if id > 0 then
					local item = self:_getBadgeItem(i)
					local co = PlayerCardConfig.instance:getBageCoById(id)

					UISpriteSetMgr.instance:setPlayerCard2Sprite(item.icon, co.icon)

					count = count + 1
				end
			end
		end
	end

	for i, item in ipairs(self._badgeItems) do
		gohelper.setActive(item.go, i <= count)
	end

	gohelper.setActive(self._badgePrefab, count > 0)
end

function SocialBaseItem:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(badgePrefabPath)
	local res = assetItem:GetResource(badgePrefabPath)

	self._badgePrefab = gohelper.clone(res, self._gobadge)

	gohelper.setActive(self._badgePrefab, false)

	self._isLoadingBadge = false

	self:_refreshBadgeItems()
end

function SocialBaseItem:_getBadgeItem(index)
	local item = self._badgeItems[index]

	if not item and self._badgePrefab then
		item = self:getUserDataTb_()

		local badge = gohelper.findChild(self._badgePrefab, "root/#image_badge")

		item.go = index == 1 and badge or gohelper.cloneInPlace(badge, "badge_" .. index)
		item.icon = item.go:GetComponent(typeof(UnityEngine.UI.Image))
		self._badgeItems[index] = item
	end

	return item
end

function SocialBaseItem:onCloseInternal()
	self:removeEvents()
	self._btncopy:RemoveClickListener()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function SocialBaseItem:onDestroyView()
	return
end

return SocialBaseItem
