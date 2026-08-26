-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedHeroIcon.lua

module("modules.logic.character.view.recommed.CharacterRecommedHeroIcon", package.seeall)

local CharacterRecommedHeroIcon = class("CharacterRecommedHeroIcon", ListScrollCell)

function CharacterRecommedHeroIcon:onInitView()
	self._gobossEmpty = gohelper.findChild(self.viewGO, "go_empty")
	self._gocontainer = gohelper.findChild(self.viewGO, "go_container")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "go_container/simage_heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "go_container/image_career")
	self._imagerare = gohelper.findChildImage(self.viewGO, "go_container/rare")
	self._goselected = gohelper.findChild(self.viewGO, "go_container/#go_selected")

	local clickarea = gohelper.findChild(self.viewGO, "clickarea")

	self._btnclick = SLFramework.UGUI.UIClickListener.Get(clickarea)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedHeroIcon:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterRecommedHeroIcon:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function CharacterRecommedHeroIcon:_btnclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self._clickCB and self._clickCBobj then
		self._clickCB(self._clickCBobj)
	end
end

function CharacterRecommedHeroIcon:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterRecommedHeroIcon:_editableInitView()
	gohelper.setActive(self._goselected, false)
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

function CharacterRecommedHeroIcon:onDestroy()
	return
end

return CharacterRecommedHeroIcon
