-- chunkname: @modules/logic/herogroup/view/CharacterSkillCardBase.lua

module("modules.logic.herogroup.view.CharacterSkillCardBase", package.seeall)

local CharacterSkillCardBase = class("CharacterSkillCardBase", LuaCompBase)

function CharacterSkillCardBase:init(go)
	self.viewGO = go

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillCardBase:addEventListeners()
	return
end

function CharacterSkillCardBase:removeEventListeners()
	return
end

function CharacterSkillCardBase:_editableInitView()
	gohelper.setActive(self._gonormalItem, false)
	gohelper.setActive(self._gospecialItem, false)

	self._cardNum = 3
	self._isLoadFinish = false
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterSkillCardBase:_copyCardItems()
	self._cardItems = self:getUserDataTb_()

	if not self.viewContainer then
		return
	end

	local normalCard = self.viewContainer:getSetting().otherRes.NormalCard
	local uniqueCard = self.viewContainer:getSetting().otherRes.UniqueCard

	if not normalCard or not uniqueCard then
		logError("未加载卡片资源")

		return
	end

	local playcards = gohelper.findChild(self.viewGO, "playcards/card_layout")

	for i = 1, 3 do
		if not self._cardItems[i] then
			local item = self:getUserDataTb_()

			item.root = gohelper.findChild(playcards, "card" .. i)

			local path = i == 3 and uniqueCard or normalCard

			item.go = self.viewContainer:getResInst(path, item.root.gameObject)
			item.icon = gohelper.findChildSingleImage(item.go, "root/skillicon/imgIcon")
			item.tag = gohelper.findChildSingleImage(item.go, "root/skillicon/tag/tagIcon")

			local goBtn = gohelper.findChild(item.go, "root/skillicon/bg")

			item.btn = gohelper.getClickWithAudio(goBtn, AudioEnum.UI.Play_ui_role_description)
			item.index = i

			item.btn:AddClickListener(self._onSkillCardClick, self, item.index)
			recthelper.setAnchor(item.go.transform, 0, 0)

			item.cardItem = item
			self._cardItems[i] = item
		end
	end
end

function CharacterSkillCardBase:_refreshCardUI()
	if not self._cardItems then
		self:_copyCardItems()
	end

	if not self._heroId or not HeroConfig.instance:getHeroCO(self._heroId) then
		for i, v in ipairs(self._cardItems) do
			local item = v.cardItem

			if item then
				gohelper.setActive(item.go.gameObject, false)
			end
		end

		return
	end

	local skillInfos = self:getSkillIdDict()

	for i, v in ipairs(self._cardItems) do
		local item = v.cardItem
		local index = item.index
		local skillId = skillInfos[index]

		item.icon:UnLoadImage()
		item.tag:UnLoadImage()

		if skillId and skillId ~= 0 then
			local skillCO = lua_skill.configDict[skillId]

			if not skillCO then
				logError(string.format("heroID : %s, skillId not found : %s", self._heroId, skillId))
			else
				item.icon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))
				item.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillCO.showTag))
			end

			gohelper.setActive(item.tag.gameObject, i ~= 3)
		end

		gohelper.setActive(item.go.gameObject, skillId ~= nil)
	end
end

function CharacterSkillCardBase:onUpdateMO(heroId, heroMo, param, isBalance, showAttributeOption, balanceHelper)
	self._heroId = heroId
	self._heroMo = heroMo
	self._isBalance = isBalance
	self._showAttributeOption = showAttributeOption
	self._balanceHelper = balanceHelper
	self._param = param

	local heroCo = HeroConfig.instance:getHeroCO(self._heroId)

	if heroCo then
		self._heroName = heroCo.name
	end

	self:_refreshUI()
end

function CharacterSkillCardBase:getSkillIdDict()
	return (SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(self._heroId, self._showAttributeOption, self._heroMo, self._balanceHelper))
end

function CharacterSkillCardBase:getSkillIdsDict()
	return (SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(self._heroId, self._showAttributeOption, self._heroMo))
end

function CharacterSkillCardBase:_refreshUI()
	self:_refreshCardUI()
end

function CharacterSkillCardBase:_onSkillCardClick(index)
	if self._heroId then
		local info = {}
		local skillDict = self:getSkillIdsDict()

		info.super = index == 3
		info.skillIdList = skillDict[index]
		info.isBalance = self._isBalance
		info.monsterName = self._heroName
		info.heroId = self._heroId
		info.heroMo = self._heroMo
		info.skillIndex = index

		if self._param then
			info.anchorX = self._param.skillTipX
			info.anchorY = self._param.skillTipY
			info.adjustBuffTip = self._param.adjustBuffTip
			info.showAssassinBg = self._param.showAssassinBg
		end

		ViewMgr.instance:openView(ViewName.SkillTipView, info)
	end
end

function CharacterSkillCardBase:onDestroy()
	if self._cardItems then
		for i, v in ipairs(self._cardItems) do
			local item = v.cardItem

			item.btn:RemoveClickListener()
			item.icon:UnLoadImage()
			item.tag:UnLoadImage()
		end
	end
end

return CharacterSkillCardBase
