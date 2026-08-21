-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendMainViewPresentor.lua

module("logic.extensions.friend.view.FriendMainViewPresentor", package.seeall)

local M = class("FriendMainViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Friend_friend_main_view,
		ResName.Friend_friend_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FriendMainView.New())
	table.insert(views, BlurBgView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
