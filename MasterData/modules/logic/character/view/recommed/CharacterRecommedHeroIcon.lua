-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedHeroIcon.lua

module("modules.logic.character.view.recommed.CharacterRecommedHeroIcon", package.seeall)

local CharacterRecommedHeroIcon = class("CharacterRecommedHeroIcon", ListScrollCell)

CharacterRecommedHeroIcon.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function CharacterRecommedHeroIcon:onInitView()
	self.transform = self.viewGO.transform
	self._gobossEmpty = gohelper.findChild(self.viewGO, "go_empty")
	self._gocontainer = gohelper.findChild(self.viewGO, "go_container")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "go_container/simage_heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "go_container/image_career")
	self._imagerare = gohelper.findChildImage(self.viewGO, "go_container/rare")
	self._goselected = gohelper.findChild(self.viewGO, "go_container/#go_selected")
	self._godestiny = gohelper.findChild(self.viewGO, "#go_destiny")
	self._simagedestiny = gohelper.findChildSingleImage(self.viewGO, "#go_destiny/#simage_destiny")
	self._btndestiny = gohelper.findChildButtonWithAudio(self.viewGO, "#go_destiny/#btn_destiny")
	self._goreplace = gohelper.findChild(self.viewGO, "#go_replace")
	self._txtlv = gohelper.findChildText(self.viewGO, "go_container/lv")
	self._goexskill = gohelper.findChild(self.viewGO, "go_container/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "go_container/#go_exskill/#image_exskill")
	self._gorank = gohelper.findChild(self.viewGO, "go_container/Rank")

	local clickarea = gohelper.findChild(self.viewGO, "clickarea")

	self._btnclick = SLFramework.UGUI.UIClickListener.Get(clickarea)

	self:showLevel(false)
	self:showRank(false)
	self:showExSkill(false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedHeroIcon:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btndestiny:AddClickListener(self._btndestinyOnClick, self)
end

function CharacterRecommedHeroIcon:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btndestiny:RemoveClickListener()
end

function CharacterRecommedHeroIcon:_btnclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self._clickCB and self._clickCBobj then
		self._clickCB(self._clickCBobj)
	end
end

function CharacterRecommedHeroIcon:_btndestinyOnClick()
	return
end

function CharacterRecommedHeroIcon:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterRecommedHeroIcon:_editableInitView()
	gohelper.setActive(self._goselected, false)
	gohelper.setActive(self._goreplace, false)
end

function CharacterRecommedHeroIcon:_editableAddEvents()
	return
end

function CharacterRecommedHeroIcon:_editableRemoveEvents()
	return
end

function CharacterRecommedHeroIcon:onUpdateMO(mo)
	self._mo = mo

	self:_refreshHero()
end

function CharacterRecommedHeroIcon:_refreshHero()
	local heroConfig = self._mo:getHeroConfig()
	local skinConfig = self._mo:getHeroSkinConfig()

	self._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(heroConfig.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "equipbar" .. CharacterEnum.Color[heroConfig.rare])
end

function CharacterRecommedHeroIcon:SetGrayscale(isGray)
	ZProj.UGUIHelper.SetGrayscale(self._simageheroicon.gameObject, isGray)
	ZProj.UGUIHelper.SetGrayscale(self._imagecareer.gameObject, isGray)
end

function CharacterRecommedHeroIcon:setClickCallback(cb, cbobj)
	self._clickCB = cb
	self._clickCBobj = cbobj
end

function CharacterRecommedHeroIcon:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
end

function CharacterRecommedHeroIcon:showLevel(isShow)
	gohelper.setActive(self._txtlv.gameObject, isShow)

	if not isShow then
		return
	end

	local showLevel = HeroConfig.instance:getShowLevel(self._mo:getHeroLevel())

	self._txtlv.text = string.format("Lv.%s", showLevel)
end

function CharacterRecommedHeroIcon:showRank(isShow)
	gohelper.setActive(self._gorank, isShow)

	if not isShow then
		return
	end

	local tmpRank = self._mo:getHeroRank() - 1

	gohelper.setActive(self._gorank, tmpRank > 0)

	if tmpRank <= 0 then
		return
	end

	if not self._goRankIconTab then
		self._goRankIconTab = self:getUserDataTb_()

		for i = 1, math.huge do
			local goRankIcon = gohelper.findChild(self._gorank, "rank" .. i)

			if gohelper.isNil(goRankIcon) then
				break
			end

			self._goRankIconTab[i] = goRankIcon
		end
	end

	for i, goRankIcon in pairs(self._goRankIconTab) do
		gohelper.setActive(goRankIcon, i == tmpRank)
	end
end

function CharacterRecommedHeroIcon:showExSkill(isShow)
	gohelper.setActive(self._goexskill, isShow)

	if not isShow then
		return
	end

	local exSkillLevel = self._mo:getExSkillLevel()

	if exSkillLevel <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	self._imageexskill.fillAmount = CharacterRecommedHeroIcon.exSkillFillAmount[exSkillLevel] or 1
end

function CharacterRecommedHeroIcon:onDestroy()
	self._simagedestiny:UnLoadImage()
end

return CharacterRecommedHeroIcon
