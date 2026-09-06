-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/Passportshow2024ViewPresentor.lua

module("logic.extensions.passport.view.Passportshow2024ViewPresentor", package.seeall)

local Passportshow2024ViewPresentor = class("Passportshow2024ViewPresentor", ViewPresentor)

function Passportshow2024ViewPresentor:ctor()
	Passportshow2024ViewPresentor.super.ctor(self)
end

function Passportshow2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Passportshow2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportshow2024view.prefab"
	}
end

function Passportshow2024ViewPresentor:buildViews()
	return {
		Passportshow2024View.New()
	}
end

function Passportshow2024ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Passportshow2024ViewPresentor
