-- chunkname: @modules/logic/versionactivity2_8/decalogpresent/view/V2a8DecalogPresentFullView.lua

module("modules.logic.versionactivity2_8.decalogpresent.view.V2a8DecalogPresentFullView", package.seeall)

local V2a8DecalogPresentFullView = class("V2a8DecalogPresentFullView", V1a9DecalogPresentFullView)

function V2a8DecalogPresentFullView:refreshRemainTime()
	local actId = DecalogPresentModel.instance:getDecalogPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	self._txtremainTime.text = actInfoMo:getRemainTimeStr3(false, true)
end

function V2a8DecalogPresentFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_qiyuan_unlock_2)
end

return V2a8DecalogPresentFullView
