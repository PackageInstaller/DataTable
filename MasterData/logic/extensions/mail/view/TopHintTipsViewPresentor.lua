-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/view/TopHintTipsViewPresentor.lua

module("logic.extensions.mail.view.TopHintTipsViewPresentor", package.seeall)

local M = class("TopHintTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Mail_mail_capacity_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TopHintTipsView.New())

	return views
end

return M
