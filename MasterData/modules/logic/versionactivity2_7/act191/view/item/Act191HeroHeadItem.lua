-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191HeroHeadItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroHeadItem", package.seeall)

local Act191HeroHeadItem = class("Act191HeroHeadItem", LuaCompBase)

function Act191HeroHeadItem:ctor(param)
	if param then
		self.noFetter = param.noFetter
		self.showExSkill = param.exSkill
		self.noClick = param.noClick
	end
end

function Act191HeroHeadItem:init(go)
	self.go = go
	self.goequiped = gohelper.findChild(go, "go_equiped")
	self.gonormal = gohelper.findChild(go, "go_normal")
	self.simageIcon = gohelper.findChildSingleImage(go, "go_normal/hero/simage_Icon")
	self.goExSkill = gohelper.findChild(go, "go_normal/hero/ExSkill")
	self.imageExSkill = gohelper.findChildImage(go, "go_normal/hero/ExSkill/bg/image_ExSkill")
	self.imageRare = gohelper.findChildImage(go, "go_normal/hero/image_Rare")
	self.imageCareer = gohelper.findChildImage(go, "go_normal/image_Career")
	self.goTag = gohelper.findChild(go, "go_normal/tag")

	gohelper.setActive(self.goTag, not self.noFetter)

	self.item = gohelper.findChild(go, "go_normal/tag/item")

	gohelper.setActive(self.item, false)

	self.gounown = gohelper.findChild(go, "go_unown")
	self.simageIconU = gohelper.findChildSingleImage(go, "go_unown/hero/simage_Icon")
	self.goMask = gohelper.findChild(go, "go_unown/hero/mask")
	self.imageRareU = gohelper.findChildImage(go, "go_unown/hero/image_Rare")
	self.imageCareerU = gohelper.findChildImage(go, "go_unown/image_Career")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

	gohelper.setActive(self.btnClick, not self.noClick)

	self.goMaxRare = gohelper.findChild(go, "go_normal/hero/Rare_effect")
	self.fetterItemList = {}
	self.extraEffect = gohelper.findChild(go, "effect")
end

function Act191HeroHeadItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClick, self)
end

function Act191HeroHeadItem:setData(heroId, id)
	if id then
		self.config = Activity191Config.instance:getRoleCo(id)
	else
		local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
		local heroInfo = gameInfo:getHeroInfoInWarehouse(heroId)

		if heroInfo then
			self.config = Activity191Config.instance:getRoleCoByNativeId(heroId, heroInfo.star)
		end
	end

	if self.config then
		local path = Activity191Helper.getHeadIconSmall(self.config)

		self.simageIcon:LoadImage(path)
		UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. self.config.career)
		UISpriteSetMgr.instance:setAct174Sprite(self.imageRare, "act174_roleframe_" .. self.config.quality)
		self.simageIconU:LoadImage(path)
		UISpriteSetMgr.instance:setCommonSprite(self.imageCareerU, "lssx_" .. self.config.career)
		UISpriteSetMgr.instance:setAct174Sprite(self.imageRareU, "act174_roleframe_" .. self.config.quality)
		gohelper.setActive(self.goMaxRare, self.config.quality == 5)

		if self.showExSkill and self.config.exLevel ~= 0 then
			local exLevel = self.config.exLevel

			self.imageExSkill.fillAmount = exLevel / CharacterEnum.MaxSkillExLevel

			gohelper.setActive(self.goExSkill, true)
			gohelper.setActive(self.goMask, true)
		else
			gohelper.setActive(self.goExSkill, false)
			gohelper.setActive(self.goMask, true)
		end

		self:refreshFetter()
	end
end

function Act191HeroHeadItem:refreshFetter()
	if self.noFetter then
		return
	end

	for _, item in ipairs(self.fetterItemList) do
		gohelper.setActive(item.go, false)
	end

	local tagArr = string.split(self.config.tag, "#")

	for k, tag in ipairs(tagArr) do
		local co = Activity191Config.instance:getRelationCo(tag)

		if co then
			local item = self.fetterItemList[k]

			if not item then
				item = self:getUserDataTb_()
				item.go = gohelper.cloneInPlace(self.item)
				item.icon = gohelper.findChildImage(item.go, "icon")
				self.fetterItemList[k] = item
			end

			Activity191Helper.setFetterIcon(item.icon, co.icon)
			gohelper.setActive(item.go, true)
		end
	end
end

function Act191HeroHeadItem:onClick()
	if self._overrideClick then
		self._overrideClick(self._overrideClickObj, self._clickParam)

		return
	end

	local param = {
		preview = self.preview,
		heroList = {
			self.config.id
		}
	}

	Activity191Controller.instance:openHeroTipView(param)
end

function Act191HeroHeadItem:setActivation(bool)
	gohelper.setActive(self.goequiped, bool)
end

function Act191HeroHeadItem:setNotOwn()
	gohelper.setActive(self.gonormal, false)
	gohelper.setActive(self.gounown, true)
end

function Act191HeroHeadItem:setOverrideClick(callback, callbackObj, param)
	self._overrideClick = callback
	self._overrideClickObj = callbackObj
	self._clickParam = param
end

function Act191HeroHeadItem:setPreview()
	self.preview = true
end

function Act191HeroHeadItem:setExtraEffect(bool)
	gohelper.setActive(self.extraEffect, bool)
end

return Act191HeroHeadItem
