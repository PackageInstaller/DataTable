-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRevivalResultViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalResultViewContainer", package.seeall)

local V1a6_CachotRoleRevivalResultViewContainer = class("V1a6_CachotRoleRevivalResultViewContainer", BaseViewContainer)

function V1a6_CachotRoleRevivalResultViewContainer:buildViews()
	return {
		V1a6_CachotRoleRevivalResultView.New()
	}
end

return V1a6_CachotRoleRevivalResultViewContainer
