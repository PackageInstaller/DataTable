-- chunkname: @modules/logic/season/view3_0/Season3_0FightCardItem.lua

module("modules.logic.season.view3_0.Season3_0FightCardItem", package.seeall)

local Season3_0FightCardItem = class("Season3_0FightCardItem", UserDataDispose)

function Season3_0FightCardItem:ctor(go)
	self:__onInit()

	self.go = go
	self.goTop = gohelper.findChild(go, "go_top")
	self.imageHead = gohelper.findChildImage(go, "go_top/headiconbg/image_headicon")
	self.txtName = gohelper.findChildTextMesh(go, "go_top/headiconbg/txt_owner")
	self.goSpecialCardBg = gohelper.findChild(go, "bottom/left/go_specialcardbg")
	self.goCardPos = gohelper.findChild(go, "bottom/left/go_cardpos")
	self.goSpecialCardName = gohelper.findChild(go, "bottom/right/righttop/go_special")
	self.txtSpecialCardName = gohelper.findChildTextMesh(self.goSpecialCardName, "txt_specialcardname")
	self.goNormalName = gohelper.findChild(go, "bottom/right/righttop/go_normal")
	self.txtNormalCardName = gohelper.findChildTextMesh(self.goNormalName, "txt_normalcardname")
	self._goDesc = gohelper.findChild(go, "bottom/right/desclist/txt_descitem")
	self.layoutElement = gohelper.findChild(go, "bottom"):GetComponent(typeof(UnityEngine.UI.LayoutElement))
end

Season3_0FightCardItem.MainRoleItemMinHeight = 390
Season3_0FightCardItem.NormalRoleItemMinHeight = 315
Season3_0FightCardItem.RoleCardPos = {
	Vector2(-16.5, 0.5),
	Vector2(-16.5, 0.5),
	Vector2(-16.5, -6.5),
	Vector2(-16.5, -17),
	Vector2(-16.5, -1)
}

function Season3_0FightCardItem:setData(data)
	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)

	self.trialId = data.trialId
	self.equipId = data.equipId
	self.heroUid = data.heroUid
	self.isMainRole = not self.heroUid or self.heroUid == "-100000"

	gohelper.setActive(self.goSpecialCardBg, self.isMainRole)

	if self.isMainRole then
		self.layoutElement.minHeight = Season3_0FightCardItem.MainRoleItemMinHeight or Season3_0FightCardItem.NormalRoleItemMinHeight
	end

	gohelper.setActive(self.goTop, data.count == 1)
	self:_setName()
	self:_setHead()
	self:_setCard(self.equipId)
	self:_setDesc(self.equipId)
end

function Season3_0FightCardItem:_setName()
	if self.isMainRole then
		self.txtName.text = luaLang("seasonmainrolecardname")
	else
		local mo = HeroModel.instance:getById(self.heroUid) or HeroGroupTrialModel.instance:getById(self.heroUid)

		if mo and mo.config then
			if not mo.config.name then
				local name = ""

				if self.trialId then
					if lua_hero_trial.configDict[self.trialId] then
						local trailCo = lua_hero_trial.configDict[self.trialId][0]

						if trailCo then
							local heroCo = HeroConfig.instance:getHeroCO(trailCo.heroId)

							name = heroCo.name or ""
						end
					end
				end

				self.txtName.text = formatLuaLang("seasoncardnames", name)
			end
		end
	end
end

function Season3_0FightCardItem:_setHead()
	local headIcon = Activity104Enum.MainRoleHeadIconID

	if not self.isMainRole then
		local mo = HeroModel.instance:getById(self.heroUid) or HeroGroupTrialModel.instance:getById(self.heroUid)

		if mo and mo.skin then
			local skinConfig = SkinConfig.instance:getSkinCo(mo.skin)

			headIcon = skinConfig and skinConfig.headIcon
		end

		if self.trialId then
			if lua_hero_trial.configDict[self.trialId] then
				local trailCo = lua_hero_trial.configDict[self.trialId][0]

				if trailCo then
					local heroCo = HeroConfig.instance:getHeroCO(trailCo.heroId)
					local skinConfig = trailCo.skin > 0 and SkinConfig.instance:getSkinCo(trailCo.skin) or SkinConfig.instance:getSkinCo(heroCo.skinId)

					headIcon = skinConfig and skinConfig.headIcon
				end
			end
		end
	end

	gohelper.getSingleImage(self.imageHead.gameObject):LoadImage(ResUrl.roomHeadIcon(headIcon))
end

function Season3_0FightCardItem:_setCard(equipId)
	if not self.cardItem then
		self.cardItem = Season3_0CelebrityCardItem.New()

		self.cardItem:init(self.goCardPos, equipId, {
			noClick = true
		})
	else
		self.cardItem:reset(equipId)
	end

	local rare = SeasonConfig.instance:getSeasonEquipCo(equipId).rare
	local targetCardPos = Season3_0FightCardItem.RoleCardPos[tonumber(rare)] or Vector2(0, 0)

	recthelper.setAnchor(self.goCardPos.transform, targetCardPos.x, targetCardPos.y)
end

function Season3_0FightCardItem:_setDesc(equipId)
	local config = SeasonConfig.instance:getSeasonEquipCo(equipId)

	if self.isMainRole then
		gohelper.setActive(self.goSpecialCardName, true)
		gohelper.setActive(self.goNormalName, false)

		self.txtSpecialCardName.text = config.name
	else
		gohelper.setActive(self.goNormalName, true)
		gohelper.setActive(self.goSpecialCardName, false)

		self.txtNormalCardName.text = config.name
	end

	local dataList = SeasonEquipMetaUtils.getSkillEffectStrList(config)
	local propsList = SeasonEquipMetaUtils.getEquipPropsStrList(config.attrId)
	local list = {}

	for i, v in ipairs(propsList) do
		table.insert(list, v)
	end

	for i, v in ipairs(dataList) do
		table.insert(list, v)
	end

	self.itemList = self.itemList or self:getUserDataTb_()

	for i = 1, math.max(#self.itemList, #list) do
		local data = list[i]

		if not self.itemList[i] then
			local item = self:createDescItem(i)

			self:updateDescItem(self.itemList[i], data)
		end
	end
end

function Season3_0FightCardItem:createDescItem(index)
	local item = {}
	local go = gohelper.cloneInPlace(self._goDesc, string.format("desc%s", index))

	item.go = go
	item.txtDesc = go:GetComponent(typeof(TMPro.TMP_Text))
	item.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(item.txtDesc.gameObject, FixTmpBreakLine)
	self.itemList[index] = item

	return item
end

function Season3_0FightCardItem:updateDescItem(item, skillStr)
	if not skillStr then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	skillStr = HeroSkillModel.instance:skillDesToSpot(skillStr)
	item.txtDesc.text = SkillHelper.addLink(skillStr)

	item.fixTmpBreakLine:refreshTmpContent(item.txtDesc)
	SkillHelper.addHyperLinkClick(item.txtDesc)
end

function Season3_0FightCardItem:destroyDescItem(item)
	return
end

function Season3_0FightCardItem:destroy()
	if self.itemList then
		for i, v in ipairs(self.itemList) do
			self:destroyDescItem(v)
		end

		self.itemList = nil
	end

	if self.cardItem then
		self.cardItem:destroy()

		self.cardItem = nil
	end

	self:__onDispose()
end

return Season3_0FightCardItem
