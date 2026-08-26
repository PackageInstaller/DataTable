-- chunkname: @modules/logic/versionactivity1_2/dreamtail/view/Activity119TrialHeroItem.lua

module("modules.logic.versionactivity1_2.dreamtail.view.Activity119TrialHeroItem", package.seeall)

local Activity119TrialHeroItem = class("Activity119TrialHeroItem")

function Activity119TrialHeroItem:init(go, index)
	self.go = go
	self.index = index

	self:onInitView()
	self:addEvents()
end

function Activity119TrialHeroItem:onInitView()
	self._btn = gohelper.findButtonWithAudio(self.go)
	self._quality = gohelper.findChildImage(self.go, "quality")
	self._career = gohelper.findChildImage(self.go, "career")
	self._icon = gohelper.findChildSingleImage(self.go, "mask/icon")
end

function Activity119TrialHeroItem:addEvents()
	self._btn:AddClickListener(self.onClickHero, self)
end

function Activity119TrialHeroItem:removeEvents()
	self._btn:RemoveClickListener()
end

function Activity119TrialHeroItem:updateMO()
	local heroMO = HeroGroupTrialModel.instance:getByIndex(self.index)

	self._mo = heroMO

	local skinCo = SkinConfig.instance:getSkinCo(heroMO.config.skinId)

	self._icon:LoadImage(ResUrl.getRoomHeadIcon(skinCo.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._quality, "bgequip" .. tostring(ItemEnum.Color[heroMO.config.rare]))
	UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(heroMO.config.career))
end

function Activity119TrialHeroItem:onClickHero()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)
	CharacterController.instance:openCharacterView(self._mo, HeroGroupTrialModel.instance:getList())
end

function Activity119TrialHeroItem:dispose()
	self:removeEvents()

	self.go = nil
	self.index = nil
	self._quality = nil

	self._icon:UnLoadImage()

	self._icon = nil
end

return Activity119TrialHeroItem
