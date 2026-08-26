-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRevivalView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalView", package.seeall)

local V1a6_CachotRoleRevivalView = class("V1a6_CachotRoleRevivalView", BaseView)

function V1a6_CachotRoleRevivalView:onInitView()
	self._gotipswindow = gohelper.findChild(self.viewGO, "#go_tipswindow")
	self._gopreparecontent = gohelper.findChild(self.viewGO, "#go_tipswindow/scroll_view/Viewport/#go_preparecontent")
	self._gostart = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_start")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tipswindow/#go_start/#btn_start")
	self._gostartlight = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_start/#btn_start/#go_startlight")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotRoleRevivalView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotRoleRevivalView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotRoleRevivalView:_btnstartOnClick()
	if not self._selectedMo or not self._selectedMo:getHeroMO() then
		GameFacade.showToast(ToastEnum.V1a6CachotToast11)

		return
	end

	local heroMo = self._selectedMo:getHeroMO()

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, heroMo.heroId, self._onSelectEnd, self)
end

function V1a6_CachotRoleRevivalView:_onSelectEnd()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_easter_success)

	local heroMo = self._selectedMo:getHeroMO()
	local tip = formatLuaLang("cachot_revival", heroMo.config.name)

	V1a6_CachotController.instance:openV1a6_CachotTipsView({
		str = tip,
		style = V1a6_CachotEnum.TipStyle.Normal
	})
end

function V1a6_CachotRoleRevivalView:_btncloseOnClick()
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, self.closeThis, self)
end

function V1a6_CachotRoleRevivalView:_editableInitView()
	V1a6_CachotRoleRevivalPrepareListModel.instance:initList()
	gohelper.setActive(self._gostartlight, false)
end

function V1a6_CachotRoleRevivalView:onUpdateParam()
	return
end

function V1a6_CachotRoleRevivalView:onOpen()
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function V1a6_CachotRoleRevivalView:_onCloseView(viewName)
	if viewName == ViewName.V1a6_CachotRoleRevivalResultView or viewName == ViewName.V1a6_CachotTipsView then
		self:closeThis()
	end
end

function V1a6_CachotRoleRevivalView:_onClickTeamItem(mo)
	self._selectedMo = mo

	gohelper.setActive(self._gostartlight, true)
end

function V1a6_CachotRoleRevivalView:onClose()
	return
end

function V1a6_CachotRoleRevivalView:onDestroyView()
	return
end

return V1a6_CachotRoleRevivalView
