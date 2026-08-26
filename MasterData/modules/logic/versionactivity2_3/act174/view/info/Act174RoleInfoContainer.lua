-- chunkname: @modules/logic/versionactivity2_3/act174/view/info/Act174RoleInfoContainer.lua

module("modules.logic.versionactivity2_3.act174.view.info.Act174RoleInfoContainer", package.seeall)

local Act174RoleInfoContainer = class("Act174RoleInfoContainer", BaseViewContainer)

function Act174RoleInfoContainer:buildViews()
	local views = {}

	table.insert(views, Act174RoleInfo.New())

	return views
end

return Act174RoleInfoContainer
