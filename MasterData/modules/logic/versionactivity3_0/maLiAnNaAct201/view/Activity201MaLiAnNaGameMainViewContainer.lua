-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaGameMainViewContainer.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaGameMainViewContainer", package.seeall)

local Activity201MaLiAnNaGameMainViewContainer = class("Activity201MaLiAnNaGameMainViewContainer", BaseViewContainer)

function Activity201MaLiAnNaGameMainViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity201MaLiAnNaGameMainView.New())

	return views
end

return Activity201MaLiAnNaGameMainViewContainer
