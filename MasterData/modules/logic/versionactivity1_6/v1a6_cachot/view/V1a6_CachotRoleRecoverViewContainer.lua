-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRecoverViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverViewContainer", package.seeall)

local V1a6_CachotRoleRecoverViewContainer = class("V1a6_CachotRoleRecoverViewContainer", BaseViewContainer)

function V1a6_CachotRoleRecoverViewContainer:buildViews()
	return {
		V1a6_CachotRoleRecoverView.New()
	}
end

return V1a6_CachotRoleRecoverViewContainer
