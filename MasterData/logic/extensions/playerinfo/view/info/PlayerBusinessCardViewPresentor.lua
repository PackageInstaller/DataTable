-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerBusinessCardViewPresentor.lua

module("logic.extensions.playerinfo.view.info.PlayerBusinessCardViewPresentor", package.seeall)

local M = class("PlayerBusinessCardViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.player_business_card_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerBusinessCardView.New())

	local titleView = TitleView.New(CommEnum.GuideID.PlayerStatus)

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)
	table.insert(views, BlurBgView.New())

	return views
end

return M
