-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterView.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterView", package.seeall)

local MatchGameCharacterView = class("MatchGameCharacterView", BaseView)

function MatchGameCharacterView:onInitView()
	self._btnDevelop = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TabList/#btn_Develop")
	self._btnTalent = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TabList/#btn_Talent")
	self._goDevelopRedDot = gohelper.findChild(self.viewGO, "#go_TabList/#btn_Develop/#go_DevelopRedDot")
	self._goTalentRedDot = gohelper.findChild(self.viewGO, "#go_TabList/#btn_Talent/#go_TalentRedDot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameCharacterView:addEvents()
	self._btnDevelop:AddClickListener(self._btnDevelopOnClick, self)
	self._btnTalent:AddClickListener(self._btnTalentOnClick, self)
	self.addEventCb(self, self.viewContainer, ViewEvent.ToSwitchTab, self._toSwitchTab, self, LuaEventSystem.Low)
end

function MatchGameCharacterView:removeEvents()
	self._btnDevelop:RemoveClickListener()
	self._btnTalent:RemoveClickListener()
end

function MatchGameCharacterView:_btnDevelopOnClick()
	if self._curTabId == MatchGameEnum.CharacterTabType.Develop then
		return
	end

	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, MatchGameCharacterViewContainer.ContainerTabId, MatchGameEnum.CharacterTabType.Develop)
end

function MatchGameCharacterView:_btnTalentOnClick()
	if self._curTabId == MatchGameEnum.CharacterTabType.Talent then
		return
	end

	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, MatchGameCharacterViewContainer.ContainerTabId, MatchGameEnum.CharacterTabType.Talent)
end

function MatchGameCharacterView:_editableInitView()
	self._goSelectDevelop = gohelper.findChild(self._btnDevelop.gameObject, "go_Select")
	self._goUnselectDevelop = gohelper.findChild(self._btnDevelop.gameObject, "go_Unselect")
	self._goSelectTalent = gohelper.findChild(self._btnTalent.gameObject, "go_Select")
	self._goUnselectTalent = gohelper.findChild(self._btnTalent.gameObject, "go_Unselect")

	RedDotController.instance:addRedDot(self._goDevelopRedDot, RedDotEnum.DotNode.MatchGameCharacterEntry)
	RedDotController.instance:addRedDot(self._goTalentRedDot, RedDotEnum.DotNode.MatchGameTalentEntry)
end

function MatchGameCharacterView:onOpen()
	self:refreshTabBtn()
end

function MatchGameCharacterView:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId ~= MatchGameCharacterViewContainer.ContainerTabId then
		return
	end

	self:refreshTabBtn()
end

function MatchGameCharacterView:refreshTabBtn()
	self._curTabId = self.viewContainer:getCurTabId()

	gohelper.setActive(self._goSelectDevelop, self._curTabId == MatchGameEnum.CharacterTabType.Develop)
	gohelper.setActive(self._goUnselectDevelop, self._curTabId ~= MatchGameEnum.CharacterTabType.Develop)
	gohelper.setActive(self._goSelectTalent, self._curTabId == MatchGameEnum.CharacterTabType.Talent)
	gohelper.setActive(self._goUnselectTalent, self._curTabId ~= MatchGameEnum.CharacterTabType.Talent)
end

function MatchGameCharacterView:onClose()
	return
end

function MatchGameCharacterView:onDestroyView()
	return
end

return MatchGameCharacterView
