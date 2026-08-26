-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapController.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapController", package.seeall)

local Rouge2_MapController = class("Rouge2_MapController")

function Rouge2_MapController:registerMap(mapComp)
	self.mapComp = mapComp
end

function Rouge2_MapController:unregisterMap()
	self.mapComp = nil
end

function Rouge2_MapController:getMapComp()
	return self.mapComp
end

function Rouge2_MapController:startMove(callback, callbackObj)
	self.mapComp:getActorComp():moveToMapItem(nil, callback, callbackObj)
end

function Rouge2_MapController:moveToPieceItem(pieceMo, callback, callbackObj)
	self.mapComp:getActorComp():moveToPieceItem(pieceMo, callback, callbackObj)
end

function Rouge2_MapController:moveToLeaveItem(callback, callbackObj)
	self.mapComp:getActorComp():moveToLeaveItem(callback, callbackObj)
end

function Rouge2_MapController:getActorMap()
	return self.mapComp and self.mapComp:getActorComp()
end

function Rouge2_MapController:checkEventChoicePlayedUnlockAnim(choiceId)
	self:_initPlayedChoiceList()

	return tabletool.indexOf(self.playedChoiceIdList, choiceId)
end

function Rouge2_MapController:playedEventChoiceEvent(choiceId)
	self:_initPlayedChoiceList()

	if tabletool.indexOf(self.playedChoiceIdList, choiceId) then
		return
	end

	table.insert(self.playedChoiceIdList, choiceId)

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2PlayedUnlockAnimEventId)

	PlayerPrefsHelper.setString(key, table.concat(self.playedChoiceIdList, "#"))
end

function Rouge2_MapController:_initPlayedChoiceList()
	if not self.playedChoiceIdList then
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2PlayedUnlockAnimEventId)
		local playedIdList = PlayerPrefsHelper.getString(key, "")

		self.playedChoiceIdList = string.splitToNumber(playedIdList, "#")
	end
end

function Rouge2_MapController:checkPieceChoicePlayedUnlockAnim(choiceId)
	self:_initPlayedPieceChoiceList()

	return tabletool.indexOf(self.playedPieceChoiceIdList, choiceId)
end

function Rouge2_MapController:playedPieceChoiceEvent(choiceId)
	self:_initPlayedPieceChoiceList()

	if tabletool.indexOf(self.playedPieceChoiceIdList, choiceId) then
		return
	end

	table.insert(self.playedPieceChoiceIdList, choiceId)

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2PlayedUnlockAnimPieceChoiceId)

	PlayerPrefsHelper.setString(key, table.concat(self.playedPieceChoiceIdList, "#"))
end

function Rouge2_MapController:_initPlayedPieceChoiceList()
	if not self.playedPieceChoiceIdList then
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2PlayedUnlockAnimPieceChoiceId)
		local playedIdList = PlayerPrefsHelper.getString(key, "")

		self.playedPieceChoiceIdList = string.splitToNumber(playedIdList, "#")
	end
end

function Rouge2_MapController:clear()
	self.playedChoiceIdList = nil
	self.playedPieceChoiceIdList = nil
	self.mapComp = nil
end

function Rouge2_MapController:onExistFight()
	DungeonModel.instance.curSendEpisodeId = nil

	if Rouge2_Model.instance:isFinish() then
		Rouge2_MapHelper.backToMainScene()
	else
		Rouge2_Controller.instance:enterRouge()
	end
end

Rouge2_MapController.instance = Rouge2_MapController.New()

LuaEventSystem.addEventMechanism(Rouge2_MapController.instance)

return Rouge2_MapController
