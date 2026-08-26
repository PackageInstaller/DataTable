-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGamePackView.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGamePackView", package.seeall)

local AiZiLaGamePackView = class("AiZiLaGamePackView", BaseView)

function AiZiLaGamePackView:onInitView()
	self._btnfullClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullClose")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._scrollItems = gohelper.findChildScrollRect(self.viewGO, "#scroll_Items")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGamePackView:addEvents()
	self._btnfullClose:AddClickListener(self._btnfullCloseOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function AiZiLaGamePackView:removeEvents()
	self._btnfullClose:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AiZiLaGamePackView:_btnfullCloseOnClick()
	self:closeThis()
end

function AiZiLaGamePackView:_btnCloseOnClick()
	self:closeThis()
end

function AiZiLaGamePackView:_editableInitView()
	return
end

function AiZiLaGamePackView:onUpdateParam()
	return
end

function AiZiLaGamePackView:onOpen()
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.ExitGame, self.closeThis, self)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.closeThis, self)
	end

	AiZiLaGamePackListModel.instance:init()
	gohelper.setActive(self._goEmpty, AiZiLaGamePackListModel.instance:getCount() < 1)
end

function AiZiLaGamePackView:onClose()
	return
end

function AiZiLaGamePackView:onDestroyView()
	return
end

return AiZiLaGamePackView
