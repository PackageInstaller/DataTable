-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRecoverResultViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverResultViewContainer", package.seeall)

local V1a6_CachotRoleRecoverResultViewContainer = class("V1a6_CachotRoleRecoverResultViewContainer", BaseViewContainer)

function V1a6_CachotRoleRecoverResultViewContainer:buildViews()
	return {
		V1a6_CachotRoleRecoverResultView.New()
	}
end

return V1a6_CachotRoleRecoverResultViewContainer
