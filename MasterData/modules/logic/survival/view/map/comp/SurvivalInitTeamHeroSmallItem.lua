-- chunkname: @modules/logic/survival/view/map/comp/SurvivalInitTeamHeroSmallItem.lua

module("modules.logic.survival.view.map.comp.SurvivalInitTeamHeroSmallItem", package.seeall)

local SurvivalInitTeamHeroSmallItem = class("SurvivalInitTeamHeroSmallItem", LuaCompBase)
local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function SurvivalInitTeamHeroSmallItem:init(go)
	self.go = go
	self._goHeroRoot = gohelper.findChild(go, "#go_HaveHero")
	self._goEmpty = gohelper.findChild(go, "#go_Empty")
	self._goEmpty2 = gohelper.findChild(go, "#go_Empty2")
	self._goEmptyAdd = gohelper.findChild(go, "#go_Empty/image_Add")
	self._goLock = gohelper.findChild(go, "#go_Locked")
	self._goAssit = gohelper.findChild(self._goHeroRoot, "assit")

	local heroGo = gohelper.findChild(self._goHeroRoot, "hero")

	self._imagerare = gohelper.findChildImage(heroGo, "role/rare")
	self._simageicon = gohelper.findChildSingleImage(heroGo, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(heroGo, "role/career")
	self._txtlv = gohelper.findChildText(heroGo, "role/Lv")
	self._goexskill = gohelper.findChild(heroGo, "role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(heroGo, "role/#go_exskill/#image_exskill")
	self._goRankBg = gohelper.findChild(heroGo, "role/Rank")
	self._goranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._goranks[i] = gohelper.findChildImage(heroGo, "role/Rank/rank" .. i)
	end

	self._clickThis = gohelper.getClick(self.go)

	gohelper.setActive(self._goLock, false)

	self._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(self._goHeroRoot, SurvivalHeroHealthPart)
end

function SurvivalInitTeamHeroSmallItem:setIndex(index)
	self._index = index
end

function SurvivalInitTeamHeroSmallItem:setParentView(view)
	self._teamView = view
end

function SurvivalInitTeamHeroSmallItem:addEventListeners()
	self._clickThis:AddClickListener(self._onClickThis, self)
end

function SurvivalInitTeamHeroSmallItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
end

function SurvivalInitTeamHeroSmallItem:getHeroMo()
	return self._heroMO
end

function SurvivalInitTeamHeroSmallItem:setNoShowAdd()
	self._noShowAdd = true
end

function SurvivalInitTeamHeroSmallItem:onUpdateMO(mo)
	self._heroMO = mo

	local hasHero = self._heroMO ~= nil

	gohelper.setActive(self._goEmpty, not hasHero)
	gohelper.setActive(self._goEmptyAdd, not hasHero and not self._noShowAdd)
	gohelper.setActive(self._goEmpty2, (false or nil) and true)
	gohelper.setActive(self._goHeroRoot, hasHero)

	if hasHero then
		self:updateBaseInfo(mo)
		self._healthPart:setHeroId(mo.heroId)
	end
end

function SurvivalInitTeamHeroSmallItem:setTrialValue(value)
	self._isTrial = value

	gohelper.setActive(self._goAssit, value)
end

function SurvivalInitTeamHeroSmallItem:setIsLock(value)
	self._isLock = value

	if value then
		gohelper.setActive(self._goLock, true)
		gohelper.setActive(self._goHeroRoot, false)
		gohelper.setActive(self._goEmpty, false)
	end
end

function SurvivalInitTeamHeroSmallItem:showSelectEffect()
	return
end

function SurvivalInitTeamHeroSmallItem:_onClickThis()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo.inSurvival and not self._isLock then
		if self._heroMO then
			local list = {}
			local teamInfoMo = SurvivalMapModel.instance:getSceneMo().teamInfo

			for i, v in ipairs(teamInfoMo.heros) do
				local heroMo = teamInfoMo:getHeroMo(v)

				table.insert(list, heroMo)
			end

			CharacterController.instance:openCharacterView(self._heroMO, list)
		end

		return
	end

	if self._isTrial or self._isLock then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	SurvivalMapModel.instance:getInitGroup().curClickHeroIndex = self._index

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	SurvivalMapModel.instance:getInitGroup():initHeroList()
	ViewMgr.instance:openView(ViewName.SurvivalInitHeroSelectView)
end

function SurvivalInitTeamHeroSmallItem:updateBaseInfo(heroMo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroMo.skin)
	local heroCo = heroMo.config

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	local balanceLv, balanceRank, fixTalent = SurvivalBalanceHelper.getHeroBalanceInfo(heroMo.heroId, heroMo)
	local rank = heroMo.rank

	if balanceRank then
		if not (balanceRank - 1) then
			local rankIconIndex = rank - 1
			local isShowRanIcon = false

			for i = 1, 3 do
				local isCurRanIcon = i == rankIconIndex

				gohelper.setActive(self._goranks[i], isCurRanIcon)

				isShowRanIcon = isShowRanIcon or isCurRanIcon

				if isCurRanIcon and balanceRank and rank < balanceRank then
					SLFramework.UGUI.GuiHelper.SetColor(self._goranks[i], SurvivalBalanceHelper.BalanceIconColor)
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._goranks[i], "#F6F3EC")
				end
			end

			gohelper.setActive(self._goRankBg, isShowRanIcon)

			local color = ""
			local heroLv = heroMo.level

			if balanceLv and heroLv < balanceLv then
				heroLv = balanceLv
				color = "<color=" .. SurvivalBalanceHelper.BalanceColor .. ">"
			end

			self._txtlv.text = color .. "LV." .. tostring(HeroConfig.instance:getShowLevel(heroLv))

			if heroMo.exSkillLevel <= 0 then
				gohelper.setActive(self._goexskill, false)

				return
			end

			gohelper.setActive(self._goexskill, true)

			self._imageexskill.fillAmount = exSkillFillAmount[heroMo.exSkillLevel] or 1
		end
	end
end

function SurvivalInitTeamHeroSmallItem:onDestroy()
	self._teamView = nil
end

return SurvivalInitTeamHeroSmallItem
