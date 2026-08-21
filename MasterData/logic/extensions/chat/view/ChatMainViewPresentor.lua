-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatMainViewPresentor.lua

module("logic.extensions.chat.view.ChatMainViewPresentor", package.seeall)

local M = class("ChatMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Chat_chat_main_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChatMainView.New())
	table.insert(views, BlurBgView.New("chat_panel/mask/common_blur_rt"))

	return views
end

return M
