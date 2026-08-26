-- chunkname: @modules/logic/survival/view/shelter/SurvivalBossInvadeView.lua

module("modules.logic.survival.view.shelter.SurvivalBossInvadeView", package.seeall)

local SurvivalBossInvadeView = class("SurvivalBossInvadeView", BaseView)

function SurvivalBossInvadeView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageFrame = gohelper.findChildSingleImage(self.viewGO, "#simage_Frame")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalBossInvadeView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SurvivalBossInvadeView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SurvivalBossInvadeView:_btncloseOnClick()
	self:closeThis()
end

function SurvivalBossInvadeView:_editableInitView()
	return
end

function SurvivalBossInvadeView:onUpdateParam()
	return
end

function SurvivalBossInvadeView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.DestroyViewFinish, self._destroyViewFinish, self)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_warn)
end

function SurvivalBossInvadeView:_destroyViewFinish(_viewName)
	if _viewName == ViewName.SurvivalLoadingView then
		gohelper.setActive(self.viewGO, false)
		gohelper.setActive(self.viewGO, true)
	end
end

function SurvivalBossInvadeView:onClose()
	return
end

function SurvivalBossInvadeView:onDestroyView()
	return
end

return SurvivalBossInvadeView
