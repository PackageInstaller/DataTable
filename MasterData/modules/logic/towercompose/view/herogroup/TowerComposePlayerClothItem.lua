-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposePlayerClothItem.lua

module("modules.logic.towercompose.view.herogroup.TowerComposePlayerClothItem", package.seeall)

local TowerComposePlayerClothItem = class("TowerComposePlayerClothItem", PlayerClothItem)

function TowerComposePlayerClothItem:_updateOnUse()
	local groupModel = PlayerClothListViewModel.instance:getGroupModel()
	local curGroupMO = groupModel and groupModel:getCurGroupMO()
	local defaultSelectClothId = curGroupMO and curGroupMO.clothId

	self.recordFightParam = TowerComposeModel.instance:getRecordFightParam()

	local themeId = self.recordFightParam.themeId
	local layerId = self.recordFightParam.layerId

	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)

	if self.towerEpisodeConfig then
		local curPlaneId = self._view.viewParam.planeId
		local planeClothId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(themeId, curPlaneId, TowerComposeEnum.TeamBuffType.Cloth)

		defaultSelectClothId = planeClothId or defaultSelectClothId
	end

	local cloth_id = PlayerClothModel.instance:getSpEpisodeClothID() or defaultSelectClothId
	local isUsing = cloth_id == self.mo.clothId

	gohelper.setActive(self._beSelectedGO, self._isSelect)
	gohelper.setActive(self._inUseGO, isUsing)
end

function TowerComposePlayerClothItem:_onClickThis()
	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.recordFightParam.themeId, self._view.viewParam.planeId)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.recordFightParam.themeId)
	local planeMo = themeMo:getPlaneMo(self._view.viewParam.planeId)

	if isPlaneLock and planeMo.hasFight then
		GameFacade.showToast(ToastEnum.TowerComposeChallengeLock)

		return
	end

	TowerComposePlayerClothItem.super._onClickThis(self)
end

return TowerComposePlayerClothItem
