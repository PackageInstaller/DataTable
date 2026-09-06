-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryStageViewPresentor.lua

module("logic.extensions.goddessglory.view.GoddessGloryStageViewPresentor", package.seeall)

local GoddessGloryStageViewPresentor = class("GoddessGloryStageViewPresentor", ViewPresentor)

function GoddessGloryStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessGloryStageViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessglory/goddessglorystageview.prefab"
	}
end

function GoddessGloryStageViewPresentor:getTempResources()
	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()

	if challengeId == 0 or stageId == 0 then
		return
	end

	local stageMo = GoddessGloryModel.instance:getGoddessGloryStage(challengeId, stageId)

	return {
		stageMo.image
	}
end

function GoddessGloryStageViewPresentor:buildViews()
	return {
		GoddessGloryStageView.New()
	}
end

return GoddessGloryStageViewPresentor
