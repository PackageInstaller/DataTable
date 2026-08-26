-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3PickHeroEntryItem.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3PickHeroEntryItem", package.seeall)

local Season123_2_3PickHeroEntryItem = class("Season123_2_3PickHeroEntryItem", UserDataDispose)

function Season123_2_3PickHeroEntryItem:ctor()
	self:__onInit()
end

function Season123_2_3PickHeroEntryItem:dispose()
	self:removeEvents()
	self:__onDispose()
end

function Season123_2_3PickHeroEntryItem:init(viewGO)
	self.viewGO = gohelper.findChild(viewGO, "root")

	self:initComponent()
end

Season123_2_3PickHeroEntryItem.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}
Season123_2_3PickHeroEntryItem.MaxRare = 5

function Season123_2_3PickHeroEntryItem:initComponent()
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")
	self._goassist = gohelper.findChild(self.viewGO, "#go_assit")
	self._simageicon = gohelper.findChildSingleImage(self._gohero, "#simage_rolehead")
	self._txtlevel = gohelper.findChildText(self._gohero, "#txt_roleLv1")
	self._txttalentevel2 = gohelper.findChildText(self._gohero, "#txt_roleLv2")
	self._goexskill = gohelper.findChild(self._gohero, "#go_exskill")
	self._imageexskill = gohelper.findChildImage(self._gohero, "#go_exskill/#image_exskill")
	self._imagecareer = gohelper.findChildImage(self._gohero, "career")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self._btnselfsupport = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_selfassit")
	self._btnothersupport = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_otherassit")
	self._txtrolename = gohelper.findChildText(self._gohero, "#txt_rolename")
	self._gotalentline = gohelper.findChild(self._gohero, "line")
	self._gosliderhp = gohelper.findChild(self.viewGO, "#slider_hp")
	self._gorank = gohelper.findChild(self._gohero, "rank")
	self._gocuthero = gohelper.findChild(self.viewGO, "#click")

	local _goAnimCuthero = gohelper.findChild(self._gocuthero, "ani")

	self._animCuthero = _goAnimCuthero:GetComponent(typeof(UnityEngine.Animator))
	self._rankList = self:getUserDataTb_()

	local maxRank = HeroConfig.instance:getMaxRank(Season123_2_3PickHeroEntryItem.MaxRare)

	for i = 1, maxRank do
		self._rankList[i] = gohelper.findChild(self._gorank, "rank" .. tostring(i))
	end

	self._gorare = gohelper.findChild(self._gohero, "rare")
	self._rareList = self:getUserDataTb_()

	for i = 1, CharacterEnum.MaxRare + 1 do
		self._rareList[i] = gohelper.findChild(self._gorare, "go_rare" .. tostring(i))
	end

	self._btnclick:AddClickListener(self.onClickSelf, self)
	self._btnselfsupport:AddClickListener(self.onClickSupport, self)
	self._btnothersupport:AddClickListener(self.onClickSupport, self)
end

function Season123_2_3PickHeroEntryItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnselfsupport:RemoveClickListener()
	self._btnothersupport:RemoveClickListener()
	TaskDispatcher.cancelTask(self.playOpenAnim, self)
end

function Season123_2_3PickHeroEntryItem:initData(index)
	self._index = index

	self:refreshUI()
	self:OpenAnim()
end

function Season123_2_3PickHeroEntryItem:refreshUI()
	local mo = Season123PickHeroEntryModel.instance:getByIndex(self._index)

	if mo then
		local isEmpty = mo:getIsEmpty()

		gohelper.setActive(self._goadd, isEmpty)
		gohelper.setActive(self._gohero, not isEmpty)

		if not isEmpty then
			if mo.heroMO and mo.heroMO.config then
				self._txtrolename.text = mo.heroMO.config.name

				UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(mo.heroMO.config.career))
			else
				self._txtrolename.text = ""

				gohelper.setActive(self._imagecareer, false)
			end

			self:refreshRare(mo.heroMO)
			self:refreshRank(mo.heroMO)
			self:refreshExSkill(mo.heroMO)

			if mo.heroMO then
				local skinConfig = SkinConfig.instance:getSkinCo(mo.heroMO.skin)

				if not skinConfig then
					logError("Season123_2_3PickHeroEntryItem.refreshUI error, skinCfg is nil, id:" .. tostring(mo.skinId))

					return
				end

				self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

				self._txtlevel.text = "Lv." .. tostring(HeroConfig.instance:getShowLevel(mo.heroMO.level))

				local isOpenTalent = false

				if mo.heroMO:isOtherPlayerHero() then
					isOpenTalent = mo.heroMO:getOtherPlayerIsOpenTalent()
				else
					local isFunctionUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)
					local isTalentRank = mo.heroMO.rank >= CharacterEnum.TalentRank

					isOpenTalent = isFunctionUnlock and isTalentRank
				end

				if isOpenTalent then
					gohelper.setActive(self._gotalentline, true)
					gohelper.setActive(self._txttalentevel2, true)

					self._txttalentevel2.text = "Lv." .. tostring(mo.heroMO.talent)
				else
					gohelper.setActive(self._gotalentline, false)
					gohelper.setActive(self._txttalentevel2, false)
				end
			else
				self._txtlevel.text = ""

				gohelper.setActive(self._gotalentline, false)
				gohelper.setActive(self._txttalentevel2, false)
			end
		end
	end

	local isAssistPos = self._index == Activity123Enum.SupportPosIndex

	if isAssistPos then
		gohelper.setActive(self._goassist, isAssistPos and mo and mo.isSupport)
		gohelper.setActive(self._btnselfsupport, mo and (not mo.isSupport or mo:getIsEmpty()))
		gohelper.setActive(self._btnothersupport, mo and mo.isSupport)
	else
		gohelper.setActive(self._goassist, false)
		gohelper.setActive(self._btnselfsupport, false)
		gohelper.setActive(self._btnothersupport, false)
	end
end

function Season123_2_3PickHeroEntryItem:refreshRare(heroMO)
	for rare = 1, #self._rareList do
		gohelper.setActive(self._rareList[rare], rare <= heroMO.config.rare + 1)
	end
end

function Season123_2_3PickHeroEntryItem:refreshRank(heroMO)
	if heroMO and heroMO.rank and heroMO.rank > 1 then
		gohelper.setActive(self._gorank, true)

		local maxRank = 5

		for i = 1, maxRank do
			gohelper.setActive(self._rankList[i], heroMO.rank - 1 == i)
		end
	else
		gohelper.setActive(self._gorank, false)
	end
end

function Season123_2_3PickHeroEntryItem:refreshExSkill(heroMO)
	if heroMO.exSkillLevel <= 0 then
		self._imageexskill.fillAmount = 0

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[heroMO.exSkillLevel] or 1
end

function Season123_2_3PickHeroEntryItem:onClickSelf()
	logNormal("onClickSelf ： " .. tostring(self._index))

	if self._index == Activity123Enum.SupportPosIndex then
		local mo = Season123PickHeroEntryModel.instance:getByIndex(self._index)

		if mo.isSupport then
			Season123PickHeroEntryController.instance:openPickSupportView()

			return
		end
	end

	Season123PickHeroEntryController.instance:openPickHeroView(self._index)
end

function Season123_2_3PickHeroEntryItem:onClickSupport()
	if self._index == Activity123Enum.SupportPosIndex then
		local mo = Season123PickHeroEntryModel.instance:getByIndex(self._index)

		if mo.isSupport then
			GameFacade.showMessageBox(MessageBoxIdDefine.Season123CancelAssist, MsgBoxEnum.BoxType.Yes_No, Season123PickHeroEntryController.instance.cancelSupport, nil, nil, Season123PickHeroEntryController.instance, nil)

			return
		end

		Season123PickHeroEntryController.instance:openPickSupportView(true)
	end
end

function Season123_2_3PickHeroEntryItem:OpenAnim()
	gohelper.setActive(self.viewGO, false)

	local time = (self._index - 1) % 4 * 0.03

	TaskDispatcher.runDelay(self.playOpenAnim, self, time)
end

function Season123_2_3PickHeroEntryItem:playOpenAnim()
	gohelper.setActive(self.viewGO, true)
end

function Season123_2_3PickHeroEntryItem:cutHeroAnim(isCut)
	gohelper.setActive(self._gocuthero, isCut)
	self._animCuthero:Play("pickheroentryview_click", 0, 0)
end

return Season123_2_3PickHeroEntryItem
