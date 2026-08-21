-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgWordTipsViewPresentor.lua

module("logic.extensions.leavemsg.view.LeaveMsgWordTipsViewPresentor", package.seeall)

local M = class("LeaveMsgWordTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.LeaveMsg_leave_message_words_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LeaveMsgWordTipsView.New())

	return views
end

return M
