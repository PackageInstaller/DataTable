-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6GameResultContainer.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameResultContainer", package.seeall)

local LengZhou6GameResultContainer = class("LengZhou6GameResultContainer", BaseViewContainer)

function LengZhou6GameResultContainer:buildViews()
	local views = {}

	table.insert(views, LengZhou6GameResult.New())

	return views
end

return LengZhou6GameResultContainer
