-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191HeroQuickEditItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroQuickEditItem", package.seeall)

local Act191HeroQuickEditItem = class("Act191HeroQuickEditItem", ListScrollCell)

function Act191HeroQuickEditItem:init(go)
	self.go = go
	self.nameCnTxt = gohelper.findChildText(go, "namecn")
	self.nameEnTxt = gohelper.findChildText(go, "nameen")
	self.cardIcon = gohelper.findChild(go, "mask/charactericon")
	self.commonHeroCard = CommonHeroCard.create(self.cardIcon, self.__cname)
	self.front = gohelper.findChildImage(go, "mask/front")
	self.rare = gohelper.findChildImage(go, "image_rare")
	self.selectframe = gohelper.findChild(go, "selectframe")
	self.careerIcon = gohelper.findChildImage(go, "career")
	self.goexskill = gohelper.findChild(go, "go_exskill")
	self.imageexskill = gohelper.findChildImage(go, "go_exskill/image_exskill")
	self.newTag = gohelper.findChild(go, "new")
	self.goFetter = gohelper.findChild(go, "fetter/image_Fetter")
	self.goOrderBg = gohelper.findChild(go, "go_OrderBg")
	self.imageOrder = gohelper.findChildImage(go, "go_OrderBg/image_Order")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "click")
	self.animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self.assist = gohelper.findChild(go, "assist")
	self.imageFetterList = self:getUserDataTb_()

	gohelper.setActive(self.goFetter, false)
end

function Act191HeroQuickEditItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._onItemClick, self)
end

function Act191HeroQuickEditItem:removeEventListeners()
	return
end

function Act191HeroQuickEditItem:onUpdateMO(mo)
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
	self:refreshSelect()

	self._open_ani_finish = true
end

function Act191HeroQuickEditItem:refreshSelect()
	self._team_pos_index = Act191HeroQuickEditListModel.instance:getHeroTeamPos(self._mo.heroId)
	self.isSelect = self._team_pos_index ~= 0

	if not self._open_ani_finish then
		TaskDispatcher.runDelay(self.showOrderBg, self, 0.3)
	else
		self:showOrderBg()
	end
end

function Act191HeroQuickEditItem:showOrderBg()
	if self.isSelect then
		if self._team_pos_index < 5 then
			gohelper.setActive(self.goOrderBg, true)
			gohelper.setActive(self.assist, false)
			gohelper.setActive(self.selectframe, true)
			UISpriteSetMgr.instance:setHeroGroupSprite(self.imageOrder, "biandui_shuzi_" .. self._team_pos_index)
		else
			gohelper.setActive(self.goOrderBg, false)
			gohelper.setActive(self.assist, true)
			gohelper.setActive(self.selectframe, true)
		end
	else
		gohelper.setActive(self.goOrderBg, false)
		gohelper.setActive(self.assist, false)
		gohelper.setActive(self.selectframe, false)
	end
end

function Act191HeroQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	Act191HeroQuickEditListModel.instance:selectHero(self._mo.heroId, not self.isSelect)
	self:refreshSelect()
	Activity191Controller.instance:dispatchEvent(Activity191Event.ClickHeroEditItem, self._mo)
end

function Act191HeroQuickEditItem:onDestroy()
	TaskDispatcher.cancelTask(self.showOrderBg, self)
end

function Act191HeroQuickEditItem:getAnimator()
	return self.animator
end

function Act191HeroQuickEditItem:refreshFetterIcon()
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

return Act191HeroQuickEditItem
