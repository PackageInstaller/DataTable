-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3MailViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3MailViewContainer", package.seeall)

local Anniversary3MailViewContainer = class("Anniversary3MailViewContainer", BaseViewContainer)

function Anniversary3MailViewContainer:buildViews()
	local views = {}

	table.insert(views, Anniversary3MailView.New())

	return views
end

return Anniversary3MailViewContainer
