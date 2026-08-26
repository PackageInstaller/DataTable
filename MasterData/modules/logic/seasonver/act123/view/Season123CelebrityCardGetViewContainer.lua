-- chunkname: @modules/logic/seasonver/act123/view/Season123CelebrityCardGetViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123CelebrityCardGetViewContainer", package.seeall)

local Season123CelebrityCardGetViewContainer = class("Season123CelebrityCardGetViewContainer", BaseViewContainer)

function Season123CelebrityCardGetViewContainer:buildViews()
	return {
		Season123CelebrityCardGetView.New()
	}
end

function Season123CelebrityCardGetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123CelebrityCardGetViewContainer
