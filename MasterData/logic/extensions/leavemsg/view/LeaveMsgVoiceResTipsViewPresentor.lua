-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgVoiceResTipsViewPresentor.lua

module("logic.extensions.leavemsg.view.LeaveMsgVoiceResTipsViewPresentor", package.seeall)

local M = class("LeaveMsgVoiceResTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.LeaveMsg_leave_message_voice_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LeaveMsgVoiceResTipsView.New())

	return views
end

return M
