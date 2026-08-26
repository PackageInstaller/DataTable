-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultSlotItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultSlotItem", package.seeall)

local TowerComposeResultSlotItem = class("TowerComposeResultSlotItem", LuaCompBase)

function TowerComposeResultSlotItem:ctor()
	return
end

function TowerComposeResultSlotItem:init(go, themeId, planeId)
	self.go = go
	self._themeId = themeId
	self._planeId = planeId
	self._goSupport = gohelper.findChild(self.go, "go_support")
	self._goSupportNormal = gohelper.findChild(self._goSupport, "normal")
	self._goSupportSelect = gohelper.findChild(self._goSupport, "selected")
	self._goSupportEquip = gohelper.findChild(self._goSupport, "equiped")
	self._simageSupport = gohelper.findChildSingleImage(self._goSupport, "equiped/simage_support")
	self._goResearch = gohelper.findChild(self.go, "go_research")
	self._goResearchNormal = gohelper.findChild(self._goResearch, "normal")
	self._goResearchSelect = gohelper.findChild(self._goResearch, "selected")
	self._goResearchEquip = gohelper.findChild(self._goResearch, "equiped")
	self._imageResearch = gohelper.findChildImage(self._goResearch, "equiped/image_research")

	self:_addEvents()
end

function TowerComposeResultSlotItem:_addEvents()
	return
end

function TowerComposeResultSlotItem:_removeEvents()
	return
end

function TowerComposeResultSlotItem:refresh()
	self._supportBuffId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self._themeId, self._planeId, TowerComposeEnum.TeamBuffType.Support)
	self._researchBuffId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self._themeId, self._planeId, TowerComposeEnum.TeamBuffType.Research)

	gohelper.setActive(self._goSupportSelect, false)
	gohelper.setActive(self._goSupportEquip, self._supportBuffId > 0)
	gohelper.setActive(self._goSupportNormal, self._supportBuffId == 0)
	gohelper.setActive(self._goResearchSelect, false)
	gohelper.setActive(self._goResearchEquip, self._researchBuffId > 0)
	gohelper.setActive(self._goResearchNormal, self._researchBuffId == 0)

	if self._supportBuffId > 0 then
		local supportConfig = TowerComposeConfig.instance:getSupportCo(self._supportBuffId)
		local heroMo = HeroModel.instance:getByHeroId(supportConfig.heroId)
		local heroConfig = HeroConfig.instance:getHeroCO(supportConfig.heroId)

		if heroMo then
			if not heroMo.skin then
				local skinId = heroConfig.skinId
				local assistData = TowerComposeHeroGroupModel.instance:getThemePlaneAssistData(self._themeId, self._planeId)

				skinId = assistData and assistData.heroId == supportConfig.heroId and assistData.skin > 0 and assistData.skin or skinId

				local skinConfig = SkinConfig.instance:getSkinCo(skinId)

				self._simageSupport:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
			end
		end
	end

	local isPlaneLayerUnlock = TowerComposeModel.instance:checkHasPlaneLayerUnlock(self._themeId)

	gohelper.setActive(self._goResearch, isPlaneLayerUnlock)

	if isPlaneLayerUnlock and self._researchBuffId > 0 then
		local researchCo = TowerComposeConfig.instance:getResearchCo(self._researchBuffId)

		UISpriteSetMgr.instance:setTower2Sprite(self._imageResearch, researchCo.icon)
	end
end

function TowerComposeResultSlotItem:destroy()
	self:_removeEvents()
end

return TowerComposeResultSlotItem
