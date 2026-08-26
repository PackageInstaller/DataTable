-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaGameResultViewContainer.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameResultViewContainer", package.seeall)

local LanShouPaGameResultViewContainer = class("LanShouPaGameResultViewContainer", BaseViewContainer)

function LanShouPaGameResultViewContainer:buildViews()
	local views = {}

	self._resultview = LanShouPaGameResultView.New()

	table.insert(views, self._resultview)

	return views
end

function LanShouPaGameResultViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return LanShouPaGameResultViewContainer
