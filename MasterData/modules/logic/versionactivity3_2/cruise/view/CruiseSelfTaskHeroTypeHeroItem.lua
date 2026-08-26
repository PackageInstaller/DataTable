-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskHeroTypeHeroItem.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskHeroTypeHeroItem", package.seeall)

local CruiseSelfTaskHeroTypeHeroItem = class("CruiseSelfTaskHeroTypeHeroItem", LuaCompBase)

function CruiseSelfTaskHeroTypeHeroItem:init(go)
	self.go = go
	self._gorole = gohelper.findChild(go, "role")
	self._imagerare = gohelper.findChildImage(go, "role/rare")
	self._simageicon = gohelper.findChildSingleImage(go, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(go, "role/career")
	self._txtname = gohelper.findChildText(go, "role/name")
	self._goexskill = gohelper.findChildImage(go, "role/go_exskill")
	self._gorank = gohelper.findChild(go, "role/go_rank")
	self._roleClick = gohelper.getClick(self._gorole)

	self._roleClick:AddClickListener(self._onRoleClick, self)
	gohelper.setActive(self._goexskill, false)
	gohelper.setActive(self._imagerare.gameObject, true)
	gohelper.setActive(self._imagecareer.gameObject, true)
	gohelper.setActive(self._gorank, false)
end

function CruiseSelfTaskHeroTypeHeroItem:_onRoleClick()
	if not self._heroConfig then
		return
	end

	local heroMo = HeroModel.instance:getByHeroId(self._heroConfig.id)

	if not heroMo then
		GameFacade.showToast(ToastEnum.CruiseNotUnlockHero)

		return
	end

	CharacterController.instance:openCharacterView(heroMo)
end

function CruiseSelfTaskHeroTypeHeroItem:refresh(heroId)
	gohelper.setActive(self.go, true)

	self._heroConfig = HeroConfig.instance:getHeroCO(heroId)
	self._txtname.text = self._heroConfig.name

	local config, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Hero, heroId)

	self._simageicon:LoadImage(icon)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "equipbar" .. CharacterEnum.Color[config.rare])
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. config.career)
end

function CruiseSelfTaskHeroTypeHeroItem:destroy()
	self._roleClick:RemoveClickListener()
end

return CruiseSelfTaskHeroTypeHeroItem
