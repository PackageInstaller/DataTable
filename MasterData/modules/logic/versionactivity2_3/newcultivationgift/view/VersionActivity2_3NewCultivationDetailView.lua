-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationDetailView.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDetailView", package.seeall)

local VersionActivity2_3NewCultivationDetailView = class("VersionActivity2_3NewCultivationDetailView", BaseView)

function VersionActivity2_3NewCultivationDetailView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFullBGsp = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG_sp")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "effect/#simage_mask")
	self._simagemasksp = gohelper.findChildSingleImage(self.viewGO, "effect/#simage_mask_sp")
	self._scrollrole = gohelper.findChildScrollRect(self.viewGO, "effect/#scroll_role")
	self._goroleitemcontent = gohelper.findChild(self.viewGO, "effect/#scroll_role/Viewport/#go_roleitemcontent")
	self._goroleitem = gohelper.findChild(self.viewGO, "effect/#scroll_role/Viewport/#go_roleitemcontent/#go_roleitem")
	self._goselectsp = gohelper.findChild(self.viewGO, "effect/#scroll_role/Viewport/#go_roleitemcontent/#go_roleitem/#go_select_sp")
	self._goselect = gohelper.findChild(self.viewGO, "effect/#scroll_role/Viewport/#go_roleitemcontent/#go_roleitem/#go_select")
	self._goclick = gohelper.findChild(self.viewGO, "effect/#scroll_role/Viewport/#go_roleitemcontent/#go_roleitem/#go_select/#go_click")
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "effect/#scroll_effect")
	self._godestinycontent = gohelper.findChild(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent")
	self._goeffectitem = gohelper.findChild(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem")
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#simage_stone")
	self._gokeyword = gohelper.findChild(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/RoleTag/#go_keyword")
	self._txttag = gohelper.findChildText(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/RoleTag/#go_keyword/#txt_tag")
	self._txtsmalltitle = gohelper.findChildText(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#txt_smalltitle")
	self._godecitem = gohelper.findChild(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#go_decitem")
	self._txtdec = gohelper.findChildText(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#go_decitem/#txt_dec")
	self._godecitemsp = gohelper.findChild(self.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#go_decitem_sp")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity2_3NewCultivationDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
end

VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE = {
	Reward = 2,
	Effect = 1
}

function VersionActivity2_3NewCultivationDetailView:_actId()
	return self.viewContainer:actId()
end

function VersionActivity2_3NewCultivationDetailView:_destinyIdList()
	if self.viewParam then
		if not self.viewParam.destinyId then
			local destinyIds = {}

			if not destinyIds or not next(destinyIds) then
				return {}
			end

			local filterDestinyIds = {}

			for _, destinyId in ipairs(destinyIds) do
				local isIgnore = self:_isIgnoreDestiny(destinyId)

				if not isIgnore then
					table.insert(filterDestinyIds, destinyId)
				end
			end

			return filterDestinyIds
		end
	end
end

function VersionActivity2_3NewCultivationDetailView:_destinyIdDict()
	if not self.__destinyIdDict then
		local destinyIds = self:_destinyIdList()
		local dict = {}

		for _, id in ipairs(destinyIds) do
			dict[id] = true
		end

		self.__destinyIdDict = dict
	end

	return self.__destinyIdDict
end

function VersionActivity2_3NewCultivationDetailView:_heroIdList()
	return (self.viewParam or nil) and (self.viewParam.heroId or {})
end

function VersionActivity2_3NewCultivationDetailView:_ignoreIdList()
	return (self.viewParam or nil) and (self.viewParam.ignoreIds or {})
end

function VersionActivity2_3NewCultivationDetailView:_showType()
	return (self.viewParam or nil) and (self.viewParam.showType or 0)
end

function VersionActivity2_3NewCultivationDetailView:isEffect()
	return self:_showType() == self.DISPLAY_TYPE.Effect
end

function VersionActivity2_3NewCultivationDetailView:isReward()
	return self:_showType() == self.DISPLAY_TYPE.Reward
end

function VersionActivity2_3NewCultivationDetailView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity2_3NewCultivationDetailView:_editableInitView()
	self._destinyEffectItemList = {}
	self._rewardItemList = {}
	self._roleItemList = {}

	gohelper.setActive(self._goeffectitem, false)
	gohelper.setActive(self._goroleitem, false)
	gohelper.setActive(self._gorewarditem, false)

	self._goeffect = gohelper.findChild(self.viewGO, "effect")
	self._goreward = gohelper.findChild(self.viewGO, "reward")
	self._simageFullBGGo = self._simageFullBG.gameObject
	self._simageFullBGGo_sp = self._simageFullBGsp.gameObject
	self._simagemaskGo = self._simagemask.gameObject
	self._simagemaskGo_sp = self._simagemasksp.gameObject
	self._titleGo = gohelper.findChild(self.viewGO, "effect/title")
	self._titleGo_sp = gohelper.findChild(self.viewGO, "effect/title_sp")
end

function VersionActivity2_3NewCultivationDetailView:onUpdateParam()
	self:_refresh()
end

function VersionActivity2_3NewCultivationDetailView:onOpen()
	self.viewContainer:setCurSelectEpisodeIdSlient(self.viewContainer:episodeId())
	self:onUpdateParam()
end

function VersionActivity2_3NewCultivationDetailView:_refresh()
	local isEffect = self:isEffect()
	local isReward = self:isReward()

	if isEffect then
		self:_refreshDestinyInfo()
	elseif isReward then
		self:_refreshRewardList()
	end

	gohelper.setActive(self._goeffect, isEffect)
	gohelper.setActive(self._goreward, isReward)
end

function VersionActivity2_3NewCultivationDetailView:_refreshRewardList()
	local bonusList = self.viewContainer:getBonusListCur()

	for i, itemCo in ipairs(bonusList) do
		local item = self._rewardItemList[i]

		if not item then
			item = self:_create_VersionActivity2_3NewCultivationRewardItem(i)

			table.insert(self._rewardItemList, item)
		end

		item:setActive(true)
		item:onUpdateMO(itemCo)
	end

	for i = #bonusList + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end
end

function VersionActivity2_3NewCultivationDetailView:_refreshDestinyInfo()
	self:_refreshRoleInfo()
end

function VersionActivity2_3NewCultivationDetailView:onSelectRoleItem(roleId, focusIndex)
	if self._roleId == roleId then
		return
	end

	self._roleId = roleId

	for _, item in ipairs(self._roleItemList) do
		local isSelect = item:refreshSelect(roleId)

		if isSelect then
			self:setSelectedFixedBg(item:isSp())
		end
	end

	if focusIndex and focusIndex > 0 then
		local x, y = recthelper.getAnchor(self._goroleitemcontent.transform)
		local curPosX = -(focusIndex - 1) * 200

		recthelper.setAnchor(self._goroleitemcontent.transform, curPosX, y)
	end

	self:_refreshEffectInfo(roleId)
end

function VersionActivity2_3NewCultivationDetailView:setSelectedFixedBg(isSp)
	self:_setActive_simageFullBGGo(isSp)
	self:_setActive_simagemask(isSp)
	self:_setActive_titleGo(isSp)
	self:_setActive_simagemaskGo(isSp)
end

function VersionActivity2_3NewCultivationDetailView:_setActive_simageFullBGGo(isSp)
	gohelper.setActive(self._simageFullBGGo, not isSp)
	gohelper.setActive(self._simageFullBGGo_sp, isSp)
end

function VersionActivity2_3NewCultivationDetailView:_setActive_simagemaskGo(isSp)
	gohelper.setActive(self._simagemaskGo, not isSp)
	gohelper.setActive(self._simagemaskGo_sp, isSp)
end

function VersionActivity2_3NewCultivationDetailView:_setActive_simagemask(isSp)
	gohelper.setActive(self._simagemask, not isSp)
	gohelper.setActive(self._simagemasksp, isSp)
end

function VersionActivity2_3NewCultivationDetailView:_setActive_titleGo(isSp)
	gohelper.setActive(self._titleGo, not isSp)
	gohelper.setActive(self._titleGo_sp, isSp)
end

function VersionActivity2_3NewCultivationDetailView:_isIgnoreDestiny(destinyId)
	local ignoreIds = self:_ignoreIdList()

	if not ignoreIds or not next(ignoreIds) then
		return false
	end

	return LuaUtil.tableContains(ignoreIds, destinyId)
end

function VersionActivity2_3NewCultivationDetailView:_refreshRoleInfo()
	local lua_character_destinyCOList
	local heroIds = self:_heroIdList()
	local destinyIds = self:_destinyIdList()
	local heroSet = {}

	if #heroIds > 0 then
		lua_character_destinyCOList = {}

		for _, heroId in ipairs(heroIds) do
			if not heroSet[heroId] then
				heroSet[heroId] = true

				local lua_character_destiny_CO = self.viewContainer:getHeroDestiny(heroId)

				table.insert(lua_character_destinyCOList, lua_character_destiny_CO)
			end
		end
	elseif #destinyIds > 0 then
		lua_character_destinyCOList = {}

		for _, destinyId in ipairs(destinyIds) do
			local heroId = self.viewContainer:getDestinyFacetHeroId(destinyId)

			if not heroId then
				logError("excel:J角色养成表.xlsx export_角色命石表.sheet 命石id: " .. tostring(destinyId) .. " 找不到角色id")
			elseif not heroSet[heroId] then
				heroSet[heroId] = true

				local lua_character_destiny_CO = self.viewContainer:getHeroDestiny(heroId)

				table.insert(lua_character_destinyCOList, lua_character_destiny_CO)
			end
		end
	end

	lua_character_destinyCOList = lua_character_destinyCOList or CharacterDestinyConfig.instance:getAllDestinyConfigList() or {}

	for i, lua_character_destinyCO in ipairs(lua_character_destinyCOList) do
		local roleItem = self._roleItemList[i]

		if not roleItem then
			roleItem = self:_create_VersionActivity2_3NewCultivationRoleItem(i)

			table.insert(self._roleItemList, roleItem)
		end

		roleItem:onUpdateMO(lua_character_destinyCO)
		roleItem:setClickCallBack(self.onSelectRoleItem, self)
		roleItem:setActive(true)
	end

	for i = #lua_character_destinyCOList + 1, #self._roleItemList do
		local roleItem = self._roleItemList[i]

		roleItem:setActive(false)
	end

	local index = 1

	if self.viewParam.targetHeroId then
		for i, lua_character_destinyCO in ipairs(lua_character_destinyCOList) do
			if lua_character_destinyCO.heroId == self.viewParam.targetHeroId then
				index = i

				break
			end
		end
	end

	local defaultRole = lua_character_destinyCOList[index]

	if defaultRole then
		self:onSelectRoleItem(defaultRole.heroId, index)
	end
end

function VersionActivity2_3NewCultivationDetailView:_refreshEffectInfo(heroId)
	local lua_character_destiny_CO = self.viewContainer:getHeroDestiny(heroId)
	local destinyIds = {}

	if lua_character_destiny_CO then
		local facetsIds = string.splitToNumber(lua_character_destiny_CO.facetsId, "#")

		for i, facetsId in ipairs(facetsIds) do
			local isIgnore = self:_isIgnoreDestiny(facetsId)

			if not isIgnore then
				table.insert(destinyIds, facetsId)
			end
		end
	end

	local destinyCount = #destinyIds
	local destinyIdList = self:_destinyIdList()
	local destinyIdDict = self:_destinyIdDict()
	local needShowNewTag = destinyCount > 1 and #destinyIdList > 0

	if needShowNewTag then
		table.sort(destinyIds, function(destinyIdA, destinyIdB)
			if destinyIdDict[destinyIdA] ~= destinyIdDict[destinyIdB] then
				return destinyIdDict[destinyIdA]
			end

			return VersionActivity2_3NewCultivationDetailView._sortIdFunc(destinyIdA, destinyIdB)
		end)
	else
		table.sort(destinyIds, VersionActivity2_3NewCultivationDetailView._sortIdFunc)
	end

	for i, destinyId in ipairs(destinyIds) do
		local item = self._destinyEffectItemList[i]

		if not item then
			item = self:_create_VersionActivity2_3NewCultivationDestinyItem(i)

			table.insert(self._destinyEffectItemList, item)
		end

		local isNew = needShowNewTag and destinyIdDict[destinyId]

		item:setData(heroId, destinyId, isNew)
		item:setActive(true)
	end

	for i = #destinyIds + 1, #self._destinyEffectItemList do
		local currentItem = self._destinyEffectItemList[i]

		currentItem:setActive(false)
	end
end

function VersionActivity2_3NewCultivationDetailView:onClose()
	return
end

function VersionActivity2_3NewCultivationDetailView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_roleItemList")
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(self, "_destinyEffectItemList")
end

function VersionActivity2_3NewCultivationDetailView:_create_VersionActivity2_3NewCultivationRewardItem(index)
	local go = gohelper.clone(self._gorewarditem, self._gocontent)
	local item = VersionActivity2_3NewCultivationRewardItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function VersionActivity2_3NewCultivationDetailView:_create_VersionActivity2_3NewCultivationRoleItem(index)
	local go = gohelper.clone(self._goroleitem, self._goroleitemcontent)
	local item = VersionActivity2_3NewCultivationRoleItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function VersionActivity2_3NewCultivationDetailView:_create_VersionActivity2_3NewCultivationDestinyItem(index)
	local go = gohelper.clone(self._goeffectitem, self._godestinycontent)
	local item = VersionActivity2_3NewCultivationDestinyItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function VersionActivity2_3NewCultivationDetailView._sortIdFunc(idA, idB)
	if idA ~= idB then
		return idB < idA
	end
end

return VersionActivity2_3NewCultivationDetailView
