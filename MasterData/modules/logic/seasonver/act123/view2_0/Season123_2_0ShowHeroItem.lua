-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0ShowHeroItem.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0ShowHeroItem", package.seeall)

local Season123_2_0ShowHeroItem = class("Season123_2_0ShowHeroItem", UserDataDispose)

function Season123_2_0ShowHeroItem:ctor()
	self:__onInit()
end

function Season123_2_0ShowHeroItem:dispose()
	self:removeEvents()
	self:__onDispose()
end

function Season123_2_0ShowHeroItem:init(viewGO)
	self.viewGO = gohelper.findChild(viewGO, "root")

	self:initComponent()
end

Season123_2_0ShowHeroItem.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}
Season123_2_0ShowHeroItem.MaxRare = 5

function Season123_2_0ShowHeroItem:initComponent()
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._goassist = gohelper.findChild(self.viewGO, "#go_assit")
	self._godead = gohelper.findChild(self.viewGO, "#go_roledead")
	self._simageicon = gohelper.findChildSingleImage(self._gohero, "#simage_rolehead")
	self._txtlevel = gohelper.findChildText(self._gohero, "#txt_roleLv1")
	self._txttalentevel2 = gohelper.findChildText(self._gohero, "#txt_roleLv2")
	self._goexskill = gohelper.findChild(self._gohero, "#go_exskill")
	self._imageexskill = gohelper.findChildImage(self._gohero, "#go_exskill/#image_exskill")
	self._imagecareer = gohelper.findChildImage(self._gohero, "career")
	self._goselfsupport = gohelper.findChild(self.viewGO, "#btn_selfassit")
	self._goothersupport = gohelper.findChild(self.viewGO, "#btn_otherassit")
	self._sliderhp = gohelper.findChildSlider(self.viewGO, "#slider_hp")
	self._imagehp = gohelper.findChildImage(self.viewGO, "#slider_hp/Fill Area/Fill")
	self._txtrolename = gohelper.findChildText(self._gohero, "#txt_rolename")
	self._gotalentline = gohelper.findChild(self._gohero, "line")
	self._rectheadicon = self._simageicon.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self._gorank = gohelper.findChild(self._gohero, "rank")
	self._rankList = self:getUserDataTb_()

	local maxRank = HeroConfig.instance:getMaxRank(Season123_2_0ShowHeroItem.MaxRare)

	for i = 1, maxRank do
		self._rankList[i] = gohelper.findChild(self._gorank, "rank" .. tostring(i))
	end

	self._gorare = gohelper.findChild(self._gohero, "rare")
	self._rareList = self:getUserDataTb_()

	for i = 1, CharacterEnum.MaxRare + 1 do
		self._rareList[i] = gohelper.findChild(self._gorare, "go_rare" .. tostring(i))
	end

	gohelper.setActive(self._goselfsupport, false)
	gohelper.setActive(self._goothersuppor, false)

	self._heroAnim = self._gohero:GetComponent(gohelper.Type_Animator)

	self._btnclick:AddClickListener(self.onClickSelf, self)
end

function Season123_2_0ShowHeroItem:initData(index)
	self._index = index

	self:refreshUI()
	self:OpenAnim()
end

function Season123_2_0ShowHeroItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Season123_2_0ShowHeroItem:onClose()
	TaskDispatcher.cancelTask(self.playOpenAnim, self)

	if self._mo and self._mo.hpRate <= 0 then
		Season123ShowHeroModel.instance:setPlayedHeroDieAnim(self._mo.uid)
	end
end

function Season123_2_0ShowHeroItem:refreshUI()
	local mo = Season123ShowHeroModel.instance:getByIndex(self._index)

	self._mo = mo

	if mo then
		gohelper.setActive(self._goadd, false)
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._gohero, true)

		local skinConfig = SkinConfig.instance:getSkinCo(mo.heroMO.skin)

		if not skinConfig then
			logError("Season123_2_0ShowHeroItem.refreshUI error, skinCfg is nil, id:" .. tostring(mo.heroMO.skin))

			return
		end

		self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

		if mo.heroMO.config then
			self._txtrolename.text = mo.heroMO.config.name

			UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(mo.heroMO.config.career))
		else
			self._txtrolename.text = ""

			gohelper.setActive(self._imagecareer, false)
		end

		self:refreshRare(mo.heroMO)
		self:refreshRank(mo.heroMO)
		self:refreshExSkill(mo.heroMO)
		self:refreshHp(mo)

		if mo.heroMO then
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

		gohelper.setActive(self._goassist, mo.isAssist)
	else
		gohelper.setActive(self._gohero, false)
		gohelper.setActive(self._goempty, true)
	end
end

function Season123_2_0ShowHeroItem:refreshRare(heroMO)
	for rare = 1, #self._rareList do
		gohelper.setActive(self._rareList[rare], rare <= heroMO.config.rare + 1)
	end
end

function Season123_2_0ShowHeroItem:refreshRank(heroMO)
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

function Season123_2_0ShowHeroItem:refreshExSkill(heroMO)
	if heroMO.exSkillLevel <= 0 then
		self._imageexskill.fillAmount = 0

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[heroMO.exSkillLevel] or 1
end

function Season123_2_0ShowHeroItem:refreshHp(mo)
	gohelper.setActive(self._sliderhp, true)

	local hp100Per = math.floor(mo.hpRate / 10)
	local rate = Mathf.Clamp(hp100Per / 100, 0, 1)

	self._sliderhp:SetValue(rate)

	if mo.hpRate <= 0 then
		gohelper.setActive(self._godead, true)
	else
		gohelper.setActive(self._godead, false)
	end

	Season123HeroGroupUtils.setHpBar(self._imagehp, rate)
end

function Season123_2_0ShowHeroItem:onClickSelf()
	logNormal("onClickSelf ： " .. tostring(self._index))

	local mo = Season123ShowHeroModel.instance:getByIndex(self._index)

	if not mo then
		return
	end

	if mo.hpRate <= 0 then
		GameFacade.showToast(ToastEnum.Season123HeroDead)

		return
	end

	if self._index == Activity123Enum.SupportPosIndex and mo.isSupport then
		return
	end

	local totalHeroList = Season123ShowHeroModel.instance:getList()
	local heroList = {}

	for _, showHeroMO in ipairs(totalHeroList) do
		if showHeroMO.hpRate > 0 then
			table.insert(heroList, showHeroMO.heroMO)
		end
	end

	CharacterController.instance:openCharacterView(mo.heroMO, heroList)
end

function Season123_2_0ShowHeroItem:OpenAnim()
	gohelper.setActive(self.viewGO, false)

	local time = (self._index - 1) % 4 * 0.03

	TaskDispatcher.runDelay(self.playOpenAnim, self, time)
end

function Season123_2_0ShowHeroItem:playOpenAnim()
	gohelper.setActive(self.viewGO, true)

	local animClip = "idle"

	if self._mo and self._mo.hpRate <= 0 then
		local isFirstPlayDieAnim = Season123ShowHeroModel.instance:isFirstPlayHeroDieAnim(self._mo.uid)

		animClip = isFirstPlayDieAnim and "todie" or "die"
	end

	self._heroAnim:Play(animClip, 0, 0)
end

return Season123_2_0ShowHeroItem
