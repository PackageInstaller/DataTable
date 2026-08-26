-- chunkname: @modules/logic/character/view/CharacterGuideTalentView.lua

module("modules.logic.character.view.CharacterGuideTalentView", package.seeall)

local CharacterGuideTalentView = class("CharacterGuideTalentView", BaseView)

function CharacterGuideTalentView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "#simage_head")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_look")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate1")
	self._simagedecorate3 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_decorate3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterGuideTalentView:addEvents()
	self._btnlook:AddClickListener(self._btnlookOnClick, self)
end

function CharacterGuideTalentView:removeEvents()
	self._btnlook:RemoveClickListener()
end

function CharacterGuideTalentView:_btnlookOnClick()
	CharacterModel.instance:setSortByRankDescOnce()

	if ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.GuideTransitionBlackView)
	else
		ViewMgr.instance:closeAllPopupViews()
	end
end

function CharacterGuideTalentView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	self._simagehead:LoadImage(ResUrl.getCharacterTalentUpIcon("yd_sixugongming"))
	self._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	self._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function CharacterGuideTalentView:onUpdateParam()
	return
end

function CharacterGuideTalentView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function CharacterGuideTalentView:_onOpenViewFinish(viewName)
	if viewName == ViewName.GuideTransitionBlackView then
		if not ViewMgr.instance:isOpen(ViewName.MainView) then
			ViewMgr.instance:openView(ViewName.MainView)
		end

		ViewMgr.instance:closeAllPopupViews({
			ViewName.GuideTransitionBlackView
		})
	end
end

function CharacterGuideTalentView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CharacterGuideTalentView then
		ViewMgr.instance:closeView(ViewName.GuideTransitionBlackView)
	end
end

function CharacterGuideTalentView:onClose()
	return
end

function CharacterGuideTalentView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagehead:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate3:UnLoadImage()
end

return CharacterGuideTalentView
