-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKGuessRecordViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKGuessRecordViewPresentor", package.seeall)

local TCKGuessRecordViewPresentor = class("TCKGuessRecordViewPresentor", ViewPresentor)

function TCKGuessRecordViewPresentor:ctor()
	TCKGuessRecordViewPresentor.super.ctor(self)
end

function TCKGuessRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKGuessRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckguessrecordview.prefab"
	}
end

function TCKGuessRecordViewPresentor:buildViews()
	return {
		TCKGuessRecordView.New()
	}
end

return TCKGuessRecordViewPresentor
