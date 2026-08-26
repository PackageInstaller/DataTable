-- chunkname: @modules/logic/rouge/map/controller/RougeMapController.lua

module("modules.logic.rouge.map.controller.RougeMapController", package.seeall)

local RougeMapController = class("RougeMapController")

function RougeMapController:registerMap(mapComp)
	self.mapComp = mapComp
end

function RougeMapController:unregisterMap()
	self.mapComp = nil
end

function RougeMapController:getMapComp()
	return self.mapComp
end

function RougeMapController:startMove(callback, callbackObj)
	self.mapComp:getActorComp():moveToMapItem(nil, callback, callbackObj)
end

function RougeMapController:moveToPieceItem(pieceMo, callback, callbackObj)
	self.mapComp:getActorComp():moveToPieceItem(pieceMo, callback, callbackObj)
end

function RougeMapController:moveToLeaveItem(callback, callbackObj)
	self.mapComp:getActorComp():moveToLeaveItem(callback, callbackObj)
end

function RougeMapController:getActorMap()
	return self.mapComp and self.mapComp:getActorComp()
end

function RougeMapController:openRougeFinishView()
	ViewMgr.instance:openView(ViewName.RougeFinishView, RougeMapEnum.FinishEnum.Finish)
end

function RougeMapController:openRougeFailView()
	ViewMgr.instance:openView(ViewName.RougeFinishView, RougeMapEnum.FinishEnum.Fail)
end

function RougeMapController:checkEventChoicePlayedUnlockAnim(choiceId)
	self:_initPlayedChoiceList()

	return tabletool.indexOf(self.playedChoiceIdList, choiceId)
end

function RougeMapController:playedEventChoiceEvent(choiceId)
	self:_initPlayedChoiceList()

	if tabletool.indexOf(self.playedChoiceIdList, choiceId) then
		return
	end

	table.insert(self.playedChoiceIdList, choiceId)

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimEventId)

	PlayerPrefsHelper.setString(key, table.concat(self.playedChoiceIdList, "#"))
end

function RougeMapController:_initPlayedChoiceList()
	if not self.playedChoiceIdList then
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimEventId)
		local playedIdList = PlayerPrefsHelper.getString(key, "")

		self.playedChoiceIdList = string.splitToNumber(playedIdList, "#")
	end
end

function RougeMapController:checkPieceChoicePlayedUnlockAnim(choiceId)
	self:_initPlayedPieceChoiceList()

	return tabletool.indexOf(self.playedPieceChoiceIdList, choiceId)
end

function RougeMapController:playedPieceChoiceEvent(choiceId)
	self:_initPlayedPieceChoiceList()

	if tabletool.indexOf(self.playedPieceChoiceIdList, choiceId) then
		return
	end

	table.insert(self.playedPieceChoiceIdList, choiceId)

	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimPieceChoiceId)

	PlayerPrefsHelper.setString(key, table.concat(self.playedPieceChoiceIdList, "#"))
end

function RougeMapController:_initPlayedPieceChoiceList()
	if not self.playedPieceChoiceIdList then
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimPieceChoiceId)
		local playedIdList = PlayerPrefsHelper.getString(key, "")

		self.playedPieceChoiceIdList = string.splitToNumber(playedIdList, "#")
	end
end

function RougeMapController:clear()
	self.playedChoiceIdList = nil
	self.playedPieceChoiceIdList = nil
	self.mapComp = nil
end

function RougeMapController:onExistFight()
	DungeonModel.instance.curSendEpisodeId = nil

	if RougeModel.instance:isFinish() then
		RougeMapHelper.backToMainScene()
	else
		RougeController.instance:enterRouge()
	end
end

RougeMapController.instance = RougeMapController.New()

LuaEventSystem.addEventMechanism(RougeMapController.instance)

return RougeMapController
