-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191HeroEditItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroEditItem", package.seeall)

local Act191HeroEditItem = class("Act191HeroEditItem", ListScrollCell)

function Act191HeroEditItem:init(go)
	self.go = go
	self.nameCnTxt = gohelper.findChildText(go, "namecn")
	self.nameEnTxt = gohelper.findChildText(go, "nameen")
	self.cardIcon = gohelper.findChild(go, "mask/charactericon")
	self.commonHeroCard = CommonHeroCard.create(self.cardIcon, self.__cname)
	self.front = gohelper.findChildImage(go, "mask/front")
	self.current = gohelper.findChild(go, "current")
	self.rare = gohelper.findChildImage(go, "image_rare")
	self.selectframe = gohelper.findChild(go, "selectframe")
	self.careerIcon = gohelper.findChildImage(go, "career")
	self.goexskill = gohelper.findChild(go, "go_exskill")
	self.imageexskill = gohelper.findChildImage(go, "go_exskill/image_exskill")
	self.newTag = gohelper.findChild(go, "new")
	self.goFetter = gohelper.findChild(go, "fetter/image_Fetter")
	self.goOrderBg = gohelper.findChild(go, "go_OrderBg")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "click")
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self.isSelect = false
	self.inteam = gohelper.findChild(go, "inteam")
	self.insub = gohelper.findChild(go, "insub")
	self.imageFetterList = self:getUserDataTb_()

	gohelper.setActive(self.goFetter, false)
end

function Act191HeroEditItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._onItemClick, self)
end

function Act191HeroEditItem:onUpdateMO(mo)
	self._mo = mo
	self.config = mo.config
	self.nameCnTxt.text = self.config.name

	UISpriteSetMgr.instance:setCommonSprite(self.careerIcon, "lssx_" .. tostring(self.config.career))
	UISpriteSetMgr.instance:setAct174Sprite(self.rare, "act174_rolefame_" .. tostring(self.config.quality))
	UISpriteSetMgr.instance:setAct174Sprite(self.front, "act174_rolebg_" .. tostring(self.config.quality))

	local skinConfig = FightConfig.instance:getSkinCO(self.config.skinId)

	if not skinConfig then
		logError("找不到皮肤配置, id: " .. tostring(self.config.skinId))

		return
	end

	self.commonHeroCard:onUpdateMO(skinConfig)
	gohelper.setActive(self.goexskill, self.config.exLevel ~= 0)

	self.imageexskill.fillAmount = self.config.exLevel / CharacterEnum.MaxSkillExLevel

	self:refreshFetterIcon()
	gohelper.setActive(self.inteam, mo.inTeam == 2)
	gohelper.setActive(self.insub, mo.inTeam == 1)
	gohelper.setActive(self.current, mo.inTeam == 3)
end

function Act191HeroEditItem:onSelect(select)
	self.isSelect = select

	gohelper.setActive(self.selectframe, select)

	if select then
		Activity191Controller.instance:dispatchEvent(Activity191Event.ClickHeroEditItem, self._mo)
	end
end

function Act191HeroEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self.isSelect then
		self._view:selectCell(self._index, false)
		Activity191Controller.instance:dispatchEvent(Activity191Event.ClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

function Act191HeroEditItem:onDestroy()
	return
end

function Act191HeroEditItem:getAnimator()
	return self._animator
end

function Act191HeroEditItem:refreshFetterIcon()
	local tagArr = string.split(self.config.tag, "#")

	for k, tag in ipairs(tagArr) do
		local imageFetter = self.imageFetterList[k]

		if not imageFetter then
			local go = gohelper.cloneInPlace(self.goFetter)

			self.imageFetterList[k] = gohelper.findChildImage(go, "")
		end

		local tagCo = Activity191Config.instance:getRelationCo(tag)

		Activity191Helper.setFetterIcon(self.imageFetterList[k], tagCo.icon)
		gohelper.setActive(self.imageFetterList[k], true)
	end

	for i = #tagArr + 1, #self.imageFetterList do
		gohelper.setActive(self.imageFetterList[i], false)
	end
end

return Act191HeroEditItem
