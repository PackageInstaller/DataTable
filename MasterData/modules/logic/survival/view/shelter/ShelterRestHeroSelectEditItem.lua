-- chunkname: @modules/logic/survival/view/shelter/ShelterRestHeroSelectEditItem.lua

module("modules.logic.survival.view.shelter.ShelterRestHeroSelectEditItem", package.seeall)

local ShelterRestHeroSelectEditItem = class("ShelterRestHeroSelectEditItem", SurvivalInitHeroSelectEditItem)

function ShelterRestHeroSelectEditItem:getGroupModel()
	return ShelterRestGroupModel.instance
end

function ShelterRestHeroSelectEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._isSelect then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

return ShelterRestHeroSelectEditItem
