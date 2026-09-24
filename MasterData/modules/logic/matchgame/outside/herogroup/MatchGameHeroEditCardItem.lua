-- chunkname: @modules/logic/matchgame/outside/herogroup/MatchGameHeroEditCardItem.lua

module("modules.logic.matchgame.outside.herogroup.MatchGameHeroEditCardItem", package.seeall)

local MatchGameHeroEditCardItem = class("MatchGameHeroEditCardItem", ListScrollCellExtend)

function MatchGameHeroEditCardItem:onInitView()
	self._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, MatchGameHeroCardBaseItem)

	self._cardItem:setClickCallback(self._onClick, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameHeroEditCardItem:addEvents()
	return
end

function MatchGameHeroEditCardItem:removeEvents()
	return
end

function MatchGameHeroEditCardItem:onUpdateMO(mo)
	self._mo = mo

	self._cardItem:onUpdateMO(mo)
	self:_refreshCardState()
end

function MatchGameHeroEditCardItem:onSelect(isSelect)
	self._cardItem:onSelect(isSelect)
	self:_refreshCardState()
end

function MatchGameHeroEditCardItem:_refreshCardState()
	if not self._mo then
		return
	end

	local inTeam = MatchGameHeroGroupModel.instance:isInCurTeam(self._mo.id)
	local isQuickEdit = MatchGameHeroGroupEditListModel.instance:isQuickEditMode()

	self._cardItem:setPosIndexVisible(false)
	self._cardItem:setCurrentTeamVisible(false)
	self._cardItem:setTeamVisible(false)

	if isQuickEdit then
		local isBatch, posIndex = MatchGameHeroGroupEditListModel.instance:isBatchSelected(self._mo.id)

		self._cardItem:setPosIndexVisible(isBatch, posIndex)
	else
		local isSelect = MatchGameHeroGroupModel.instance:getCurEditPosHeroUid() == self._mo.id

		self._cardItem:setCurrentTeamVisible(inTeam and isSelect)
		self._cardItem:setTeamVisible(inTeam and not isSelect)
	end
end

function MatchGameHeroEditCardItem:_onClick()
	if not self._mo then
		return
	end

	local curEpisodeId = MatchGameLevelModel.instance:getCurEpisodeId()

	if MatchGameConfig.instance:isTeachEpisode(curEpisodeId) then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	MatchGameHeroGroupEditListModel.instance:handleSelect(self._mo.id)
end

function MatchGameHeroEditCardItem:onDestroyView()
	return
end

return MatchGameHeroEditCardItem
