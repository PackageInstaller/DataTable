-- chunkname: @modules/logic/explore/view/ExploreBonusSceneRecordViewContainer.lua

module("modules.logic.explore.view.ExploreBonusSceneRecordViewContainer", package.seeall)

local ExploreBonusSceneRecordViewContainer = class("ExploreBonusSceneRecordViewContainer", BaseViewContainer)

function ExploreBonusSceneRecordViewContainer:buildViews()
	return {
		ExploreBonusSceneRecordView.New()
	}
end

return ExploreBonusSceneRecordViewContainer
