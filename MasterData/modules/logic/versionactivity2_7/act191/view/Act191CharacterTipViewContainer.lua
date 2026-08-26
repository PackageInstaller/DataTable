-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CharacterTipViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CharacterTipViewContainer", package.seeall)

local Act191CharacterTipViewContainer = class("Act191CharacterTipViewContainer", BaseViewContainer)

function Act191CharacterTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191CharacterTipView.New())

	return views
end

function Act191CharacterTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Act191CharacterTipViewContainer
