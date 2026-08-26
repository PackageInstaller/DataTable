-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183FinishView.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183FinishView", package.seeall)

local Act183FinishView = class("Act183FinishView", BaseView)

function Act183FinishView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183FinishView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
end

function Act183FinishView:removeEvents()
	self._btnclose:RemoveClickListener()
	NavigateMgr.instance:removeEscape(self.viewName)
end

function Act183FinishView:_btncloseOnClick()
	self:closeThis()
end

function Act183FinishView:_editableInitView()
	return
end

function Act183FinishView:onUpdateParam()
	return
end

function Act183FinishView:onOpen()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open, self.closeThis, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenFinishView)
end

function Act183FinishView:onClose()
	return
end

function Act183FinishView:onDestroyView()
	return
end

return Act183FinishView
