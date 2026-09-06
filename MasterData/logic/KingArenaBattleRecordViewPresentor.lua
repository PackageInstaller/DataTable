-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/KingArenaBattleRecordViewPresentor.lua

module("logic.extensions.kingarena.view.KingArenaBattleRecordViewPresentor", package.seeall)

local KingArenaBattleRecordViewPresentor = class("KingArenaBattleRecordViewPresentor", ViewPresentor)

function KingArenaBattleRecordViewPresentor:ctor()
	KingArenaBattleRecordViewPresentor.super.ctor(self)
end

function KingArenaBattleRecordViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingArenaBattleRecordViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/kingarenabattlerecordview.prefab"
	}
end

function KingArenaBattleRecordViewPresentor:buildViews()
	return {
		KingArenaBattleRecordView.New()
	}
end

return KingArenaBattleRecordViewPresentor
