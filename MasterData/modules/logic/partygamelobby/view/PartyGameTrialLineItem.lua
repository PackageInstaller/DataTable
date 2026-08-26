-- chunkname: @modules/logic/partygamelobby/view/PartyGameTrialLineItem.lua

module("modules.logic.partygamelobby.view.PartyGameTrialLineItem", package.seeall)

local PartyGameTrialLineItem = class("PartyGameTrialLineItem", PartyGameTrialGameItem)

function PartyGameTrialLineItem:_editableInitView()
	PartyGameTrialLineItem.super._editableInitView(self)
	gohelper.setActive(self._goIndex, true)
end

function PartyGameTrialLineItem:initIndex(index)
	self.trialIndex = index
	self._txtindex.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_lobby_trial_count"), index)
end

function PartyGameTrialLineItem:_btnclickareaOnClick()
	ViewMgr.instance:openView(ViewName.PartyGameLobbyTrialSelectView, {
		trialIndex = self.trialIndex
	})
end

function PartyGameTrialLineItem:UpdateGameInfo(gameCo)
	PartyGameTrialLineItem.super.UpdateGameInfo(self, gameCo)

	local isHave = gameCo ~= nil

	if isHave then
		gohelper.setActive(self._goVxRefresh, false)
		gohelper.setActive(self._goVxRefresh, true)
	end

	gohelper.setActive(self._goHas, isHave)
	gohelper.setActive(self._goEmpty, not isHave)

	local needRefresh = isHave and self._lastGameId ~= gameCo.id

	if self._goAnim and isHave and needRefresh then
		self._goAnim:Play("refresh", 0, 0)
	end

	if gameCo ~= nil then
		self._lastGameId = gameCo.id or nil
	end
end

return PartyGameTrialLineItem
