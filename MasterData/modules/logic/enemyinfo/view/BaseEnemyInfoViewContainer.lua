-- chunkname: @modules/logic/enemyinfo/view/BaseEnemyInfoViewContainer.lua

module("modules.logic.enemyinfo.view.BaseEnemyInfoViewContainer", package.seeall)

local BaseEnemyInfoViewContainer = class("BaseEnemyInfoViewContainer", BaseViewContainer)

function BaseEnemyInfoViewContainer:buildViews()
	local layoutMo = EnemyInfoLayoutMo.New()
	local enemyInfoMo = EnemyInfoMo.New()
	local views = {
		EnemyInfoEnterView.New(),
		EnemyInfoLayoutView.New(),
		EnemyInfoLeftView.New(),
		EnemyInfoRightView.New(),
		EnemyInfoTipView.New(),
		TabViewGroup.New(1, "#go_btns")
	}

	for _, view in ipairs(views) do
		view.layoutMo = layoutMo
		view.enemyInfoMo = enemyInfoMo
	end

	return views
end

function BaseEnemyInfoViewContainer:onContainerInit()
	BaseEnemyInfoViewContainer.super.onContainerInit(self)

	if self._views then
		for _, item in ipairs(self._views) do
			item.viewParam = self.viewParam
		end
	end
end

function BaseEnemyInfoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return BaseEnemyInfoViewContainer
