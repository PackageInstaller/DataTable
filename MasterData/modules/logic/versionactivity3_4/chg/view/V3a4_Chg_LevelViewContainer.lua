-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_LevelViewContainer.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_LevelViewContainer", package.seeall)

local V3a4_Chg_LevelViewContainer = class("V3a4_Chg_LevelViewContainer", ChgViewBaseContainer)

function V3a4_Chg_LevelViewContainer:buildViews()
	self._mainView = V3a4_Chg_LevelView.New()

	return {
		self._mainView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function V3a4_Chg_LevelViewContainer:mainView()
	return self._mainView
end

function V3a4_Chg_LevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function V3a4_Chg_LevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(self:actId())
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self:actId()
	})
end

function V3a4_Chg_LevelViewContainer:onContainerDestroy()
	V3a4_Chg_LevelViewContainer.super.onContainerDestroy(self)
end

local kActChgFirstEnter = "ActChgFirstEnter"

function V3a4_Chg_LevelViewContainer:_getPrefsKeyPrefix_ActChgFirstEnter()
	return self:getPrefsKeyPrefix() .. kActChgFirstEnter
end

function V3a4_Chg_LevelViewContainer:getIsActChgFirstEnter()
	local key = self:_getPrefsKeyPrefix_ActChgFirstEnter()

	return self:getInt(key, 0) == 1
end

function V3a4_Chg_LevelViewContainer:setIsActChgFirstEnter(isFirst)
	local key = self:_getPrefsKeyPrefix_ActChgFirstEnter()

	self:saveInt(key, isFirst and 1 or 0)
end

return V3a4_Chg_LevelViewContainer
