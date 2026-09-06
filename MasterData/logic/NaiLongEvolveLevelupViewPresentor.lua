-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveLevelupViewPresentor.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveLevelupViewPresentor", package.seeall)

local NaiLongEvolveLevelupViewPresentor = class("NaiLongEvolveLevelupViewPresentor", ViewPresentor)

function NaiLongEvolveLevelupViewPresentor:ctor()
	NaiLongEvolveLevelupViewPresentor.super.ctor(self)
end

function NaiLongEvolveLevelupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongEvolveLevelupViewPresentor:dependWhatResources()
	return {
		"ui/views/nailongevolve/nailongevolvelevelupview.prefab"
	}
end

function NaiLongEvolveLevelupViewPresentor:buildViews()
	return {
		NaiLongEvolveLevelupView.New()
	}
end

return NaiLongEvolveLevelupViewPresentor
