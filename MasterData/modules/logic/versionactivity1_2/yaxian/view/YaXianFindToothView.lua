-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianFindToothView.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianFindToothView", package.seeall)

local YaXianFindToothView = class("YaXianFindToothView", BaseView)

function YaXianFindToothView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtname = gohelper.findChildText(self.viewGO, "main/#txt_name")
	self._txtunlockskill = gohelper.findChildText(self.viewGO, "main/unlockbg/#txt_unlockskill")
	self._txtup = gohelper.findChildText(self.viewGO, "main/#txt_up/")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianFindToothView:addEvents()
	return
end

function YaXianFindToothView:removeEvents()
	return
end

function YaXianFindToothView:onFullClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:closeThis()
end

function YaXianFindToothView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getYaXianImage("img_huode_bg_2"))

	self.fullClick = gohelper.getClick(self._simagebg.gameObject)

	self.fullClick:AddClickListener(self.onFullClick, self)

	self.toothIcon = gohelper.findChildSingleImage(self.viewGO, "main/iconbg/icon")
	self.goUnlockSkill = gohelper.findChild(self.viewGO, "main/unlockbg")
end

function YaXianFindToothView:onUpdateParam()
	self:onOpen()
end

function YaXianFindToothView:onOpen()
	self.toothId = self.viewParam.toothId
	self.toothConfig = YaXianConfig.instance:getToothConfig(self.toothId)

	self.toothIcon:LoadImage(ResUrl.getYaXianImage(self.toothConfig.icon))

	self._txtname.text = self.toothConfig.name

	local unlockSkillId = YaXianConfig.instance:getToothUnlockSkill(self.toothId)

	gohelper.setActive(self.goUnlockSkill, unlockSkillId)

	if unlockSkillId then
		self._txtunlockskill.text = luaLang("versionactivity_1_2_yaxian_unlock_skill_" .. unlockSkillId)
	end

	local heroTemplate = YaXianConfig.instance:getToothUnlockHeroTemplate(self.toothId)
	local templateCo = lua_hero_trial.configDict[YaXianEnum.HeroTrialId][heroTemplate]

	if templateCo then
		local showLevel = HeroConfig.instance:getCommonLevelDisplay(templateCo.level or 0)

		self._txtup.text = string.format(luaLang("versionactivity_1_2_yaxian_up_to_level"), showLevel)
	end
end

function YaXianFindToothView:onClose()
	return
end

function YaXianFindToothView:onDestroyView()
	self._simagebg:UnLoadImage()
	self.toothIcon:UnLoadImage()
	self.fullClick:RemoveClickListener()
end

return YaXianFindToothView
