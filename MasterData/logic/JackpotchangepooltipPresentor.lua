-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/view/JackpotchangepooltipPresentor.lua

module("logic.extensions.jackpot.view.JackpotchangepooltipPresentor", package.seeall)

local JackpotchangepooltipPresentor = class("JackpotchangepooltipPresentor", ViewPresentor)

function JackpotchangepooltipPresentor:ctor()
	JackpotchangepooltipPresentor.super.ctor(self)
end

function JackpotchangepooltipPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JackpotchangepooltipPresentor:dependWhatResources()
	return {
		"ui/views/jackpot/jackpotchangepooltip.prefab"
	}
end

function JackpotchangepooltipPresentor:buildViews()
	return {
		JackpotchangepooltipView.New()
	}
end

function JackpotchangepooltipPresentor:onClickOutside()
	self:close()
end

return JackpotchangepooltipPresentor
