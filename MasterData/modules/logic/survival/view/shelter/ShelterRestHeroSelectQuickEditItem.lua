-- chunkname: @modules/logic/survival/view/shelter/ShelterRestHeroSelectQuickEditItem.lua

module("modules.logic.survival.view.shelter.ShelterRestHeroSelectQuickEditItem", package.seeall)

local ShelterRestHeroSelectQuickEditItem = class("ShelterRestHeroSelectQuickEditItem", SurvivalInitHeroSelectQuickEditItem)

function ShelterRestHeroSelectQuickEditItem:getGroupModel()
	return ShelterRestGroupModel.instance
end

function ShelterRestHeroSelectQuickEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local addIndex = self:getGroupModel():tryAddHeroMo(self._mo)

	if addIndex then
		self._view:selectCell(self._index, true)
		gohelper.setActive(self._goorderbg, true)
		gohelper.setActive(self._goframe, true)

		self._txtorder.text = addIndex
	else
		gohelper.setActive(self._goorderbg, false)
		gohelper.setActive(self._goframe, false)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, self._mo)
end

return ShelterRestHeroSelectQuickEditItem
