-- chunkname: @modules/logic/tower/view/TowerGuideView.lua

module("modules.logic.tower.view.TowerGuideView", package.seeall)

local TowerGuideView = class("TowerGuideView", BaseView)

function TowerGuideView:onInitView()
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_look")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerGuideView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function TowerGuideView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function TowerGuideView:_btnlookOnClick()
	self:closeThis()
end

function TowerGuideView:_editableInitView()
	return
end

function TowerGuideView:onUpdateParam()
	return
end

function TowerGuideView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function TowerGuideView:onClose()
	return
end

function TowerGuideView:onDestroyView()
	return
end

return TowerGuideView
