-- chunkname: @modules/logic/survival/view/map/SurvivalPickAssistView.lua

module("modules.logic.survival.view.map.SurvivalPickAssistView", package.seeall)

local SurvivalPickAssistView = class("SurvivalPickAssistView", PickAssistView)

function SurvivalPickAssistView:_btnconfirmOnClick()
	local selectedMO = PickAssistListModel.instance:getSelectedMO()

	if selectedMO then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo:getHeroMo(selectedMO.heroMO.heroId).health <= 0 then
			GameFacade.showToast(ToastEnum.SurvivalHeroDead)

			return
		end
	end

	PickAssistController.instance:pickOver()
	self:closeThis()
end

return SurvivalPickAssistView
