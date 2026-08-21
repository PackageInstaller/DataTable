-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/role_experience/RoleExperienceRoleItemCell.lua

module("logic.extensions.welfare.view.role_experience.RoleExperienceRoleItemCell", package.seeall)

local M = class("RoleExperienceRoleItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self.img_imgQuality = self._registry:findUIElement("hero_item_29007724", UIComponentType.Image)
	self.img_imgLine = self._registry:findUIElement("hero_item_-1565489570", UIComponentType.Image)
	self.img_heroIcon = self._registry:findUIElement("battle_hero_item_892867850", UIComponentType.Image)
	self.img_imgCareerSign = self._registry:findUIElement("0&career_1390243743", UIComponentType.Image)
	self.img_imgCareerDi = self._registry:findUIElement("0&career_-1600786498", UIComponentType.Image)
	self.go_imgSelect = self._registry:findUIElement("hero_item_-1394600642")
	self.btn_click = self._registry:findUIElement("battle_hero_item_-1904829982", UIComponentType.ButtonAdapter)
	self._goLevel = self._registry:getGo("battle_hero_item_1708325635")
	self._goRedDot = goutil.findChild(self.mainGO, "pos/normal/red_point")

	self.btn_click:AddClickListener(self._onClick, self)
	goutil.setActive(self._goLevel, false)
end

function M:updateData(characterId)
	local characterCfg = CharacterConfig.instance:getCharacterItemInfo(characterId)
	local modelCfgInfo = ModelConfig.instance:getModelConfig(characterCfg and characterCfg.modelId)

	if not characterCfg or not modelCfgInfo then
		return
	end

	IconLoader.setSprite(self.img_heroIcon, IconType.RoleHeadIcon, modelCfgInfo.headIconName)
	IconLoader.setSprite(self.img_imgQuality, IconType.Skinlib, CharacterCOUtil.quality2IconName(characterCfg.quality))
	IconLoader.setSprite(self.img_imgLine, IconType.Skinlib, CharacterCOUtil.quality2LineName(characterCfg.quality))
	IconLoader.setSprite(self.img_imgCareerDi, IconType.Skinlib, CharacterCOUtil.colorType2IconName(characterCfg.colorType))
	IconLoader.setSprite(self.img_imgCareerSign, IconType.Skinlib, CharacterCOUtil.career2IconName(characterCfg.career))
end

function M:updateRewardState(rewardState)
	goutil.setActive(self._goRedDot, rewardState == CommEnum.RewardEnum.CanGot)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:_onClick()
	if self._handler then
		self._handler:onClickHeroItem(self)
	end
end

function M:setSelected(selected)
	goutil.setActive(self.go_imgSelect, selected)
end

function M:OnDestroy()
	self._handler = false

	if self.btn_click then
		self.btn_click:RemoveClickListener()
	end
end

return M
