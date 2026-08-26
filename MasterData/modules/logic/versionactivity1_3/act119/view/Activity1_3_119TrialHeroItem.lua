-- chunkname: @modules/logic/versionactivity1_3/act119/view/Activity1_3_119TrialHeroItem.lua

module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119TrialHeroItem", package.seeall)

local Activity1_3_119TrialHeroItem = class("Activity1_3_119TrialHeroItem")

function Activity1_3_119TrialHeroItem:init(go, index)
	self.go = go
	self.index = index

	self:onInitView()
	self:addEvents()
end

function Activity1_3_119TrialHeroItem:onInitView()
	self._btn = gohelper.findButtonWithAudio(self.go)
	self._quality = gohelper.findChildImage(self.go, "#image_QualityBG")
	self._career = gohelper.findChildImage(self.go, "image_Career")
	self._icon = gohelper.findChildSingleImage(self.go, "image_Mask/#image_RoleIcon")
end

function Activity1_3_119TrialHeroItem:addEvents()
	self._btn:AddClickListener(self.onClickHero, self)
end

function Activity1_3_119TrialHeroItem:removeEvents()
	self._btn:RemoveClickListener()
end

function Activity1_3_119TrialHeroItem:updateMO()
	local heroMO = HeroGroupTrialModel.instance:getByIndex(self.index)

	self._mo = heroMO

	local skinCo = SkinConfig.instance:getSkinCo(heroMO.config.skinId)

	self._icon:LoadImage(ResUrl.getRoomHeadIcon(skinCo.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._quality, "bgequip" .. tostring(ItemEnum.Color[heroMO.config.rare]))
	UISpriteSetMgr.instance:setCommonSprite(self._career, "lssx_" .. tostring(heroMO.config.career))
end

function Activity1_3_119TrialHeroItem:onClickHero()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)
	CharacterController.instance:openCharacterView(self._mo, HeroGroupTrialModel.instance:getList())
end

function Activity1_3_119TrialHeroItem:dispose()
	self:removeEvents()

	self.go = nil
	self.index = nil
	self._quality = nil

	self._icon:UnLoadImage()

	self._icon = nil
end

return Activity1_3_119TrialHeroItem
