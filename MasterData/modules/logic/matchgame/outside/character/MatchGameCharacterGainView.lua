-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterGainView.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterGainView", package.seeall)

local MatchGameCharacterGainView = class("MatchGameCharacterGainView", BaseView)

function MatchGameCharacterGainView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._scrollCharacter = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_Character")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Character/Viewport/Content")
	self._goCharacterItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Character/Viewport/Content/#go_CharacterItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameCharacterGainView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function MatchGameCharacterGainView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function MatchGameCharacterGainView:_btnCloseOnClick()
	self:closeThis()
end

function MatchGameCharacterGainView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function MatchGameCharacterGainView:onOpen()
	self:refreshUI()
end

function MatchGameCharacterGainView:refreshUI()
	if self.viewParam then
		local characterIdList = self.viewParam.characterIdList

		characterIdList = self.viewParam or {}

		gohelper.CreateObjList(self, self._refreshCharacter, self.viewParam, self._goContent, self._goCharacterItem, MatchGameCharacterGainItem)
	end
end

function MatchGameCharacterGainView:_refreshCharacter(characterItem, characterId, index)
	characterItem:onUpdateMO(characterId)
end

function MatchGameCharacterGainView:onClose()
	return
end

function MatchGameCharacterGainView:onDestroyView()
	return
end

return MatchGameCharacterGainView
