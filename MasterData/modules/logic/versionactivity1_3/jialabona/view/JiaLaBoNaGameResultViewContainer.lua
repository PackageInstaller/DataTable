-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaGameResultViewContainer.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameResultViewContainer", package.seeall)

local JiaLaBoNaGameResultViewContainer = class("JiaLaBoNaGameResultViewContainer", BaseViewContainer)

function JiaLaBoNaGameResultViewContainer:buildViews()
	local views = {}

	self._resultview = JiaLaBoNaGameResultView.New()

	table.insert(views, self._resultview)

	return views
end

function JiaLaBoNaGameResultViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return JiaLaBoNaGameResultViewContainer
