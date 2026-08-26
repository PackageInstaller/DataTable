-- chunkname: @modules/logic/survival/view/shelter/ShelterRestHeroItem.lua

module("modules.logic.survival.view.shelter.ShelterRestHeroItem", package.seeall)

local ShelterRestHeroItem = class("ShelterRestHeroItem", ListScrollCellExtend)

function ShelterRestHeroItem:onInitView()
	local go = self.viewGO

	self._goHeroRoot = gohelper.findChild(go, "#go_HaveHero")
	self._goEmpty = gohelper.findChild(go, "#go_Empty")
	self._goLock = gohelper.findChild(go, "#go_Locked")
	self._goAssit = gohelper.findChild(self._goHeroRoot, "assit")

	local heroGo = gohelper.findChild(self._goHeroRoot, "hero")

	self._heroItem = IconMgr.instance:getCommonHeroItem(heroGo)

	self._heroItem:setStyle_CharacterBackpack()
	self._heroItem:hideFavor(true)
	self._heroItem:setSelectFrameSize(245, 583, 0, -12)

	self._clickThis = gohelper.getClick(go)

	gohelper.setActive(self._goLock, false)

	self._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(self._goHeroRoot, SurvivalHeroHealthPart)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShelterRestHeroItem:addEvents()
	self.addClickCb(self, self._clickThis, self._onClickThis, self)
end

function ShelterRestHeroItem:removeEvents()
	self:removeClickCb(self._clickThis)
end

function ShelterRestHeroItem:_editableInitView()
	return
end

function ShelterRestHeroItem:_onClickThis()
	if self._isLock then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo:isAllHeroHealth() then
		GameFacade.showToast(ToastEnum.SurvivalRestTips)

		return
	end

	ViewMgr.instance:openView(ViewName.ShelterRestHeroSelectView, {
		index = self._index,
		buildingId = self.mo.buildingId
	})
end

function ShelterRestHeroItem:onUpdateMO(mo)
	self.mo = mo

	local isLock = mo.pos == nil

	self._isLock = isLock

	if not mo.heroId then
		local heroId = 0
		local isEmpty = heroId == 0

		gohelper.setActive(self._goLock, isLock)
		gohelper.setActive(self._goEmpty, not isLock and isEmpty)
		gohelper.setActive(self._goHeroRoot, not isLock and not isEmpty)

		if isEmpty then
			return
		end

		local heroMo = HeroModel.instance:getByHeroId(heroId)

		self._heroItem:onUpdateMO(heroMo)
		self._heroItem:setNewShow(false)

		local lv = SurvivalBalanceHelper.getHeroBalanceLv(heroId)

		if lv > heroMo.level then
			self._heroItem:setBalanceLv(lv)
		end

		self._healthPart:setHeroId(heroId)
	end
end

function ShelterRestHeroItem:onDestroyView()
	return
end

return ShelterRestHeroItem
