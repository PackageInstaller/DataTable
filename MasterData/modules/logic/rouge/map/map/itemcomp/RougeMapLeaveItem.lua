-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapLeaveItem.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapLeaveItem", package.seeall)

local RougeMapLeaveItem = class("RougeMapLeaveItem", RougeMapBaseItem)

function RougeMapLeaveItem:init(map)
	RougeMapLeaveItem.super.init(self)

	self.map = map

	self:setId(RougeMapEnum.LeaveId)
	self:createGo()
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onReceivePieceChoiceEvent, self.refreshActive, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
end

function RougeMapLeaveItem:createGo()
	self.go = gohelper.clone(self.map.middleLayerLeavePrefab, self.map.goLayerPiecesContainer)
	self.transform = self.go.transform

	local posX, posY = RougeMapModel.instance:getMiddleLayerLeavePos()

	transformhelper.setLocalPos(self.transform, posX, posY, RougeMapHelper.getOffsetZ(posY))

	self.scenePos = self.transform.position

	self:refreshActive()
end

function RougeMapLeaveItem:refreshActive()
	gohelper.setActive(self.go, self:isActive())
end

function RougeMapLeaveItem:getScenePos()
	return self.scenePos
end

function RougeMapLeaveItem:getClickArea()
	return RougeMapEnum.LeaveItemClickArea
end

function RougeMapLeaveItem:onClick()
	logNormal("on click leave item")
	RougeMapController.instance:moveToLeaveItem(self.onMoveDone, self)
end

function RougeMapLeaveItem:onMoveDone()
	local isSelectEndingFourth = self:_checkIsSelectEndingFourth()

	if isSelectEndingFourth then
		local needPlayStoryIds, isNeedPlayStory = self:_getNeedPlayEndingFourthStories()

		if isNeedPlayStory then
			StoryController.instance:playStories(needPlayStoryIds, nil, self._sendMoveRpc, self)

			return
		end
	end

	self:_sendMoveRpc()
end

function RougeMapLeaveItem:_checkIsSelectEndingFourth()
	local pieceMoList = RougeMapModel.instance:getPieceList()
	local fourthEndingChoiceIdStr = lua_rouge_const.configDict[RougeEnum.Const.FourthEndingChoiceIds].value
	local fourthEndingChoiceIds = string.splitToNumber(fourthEndingChoiceIdStr, "#")

	if fourthEndingChoiceIds and pieceMoList then
		for _, pieceMo in ipairs(pieceMoList) do
			if pieceMo.finish and pieceMo.selectId and tabletool.indexOf(fourthEndingChoiceIds, pieceMo.selectId) then
				return true
			end
		end
	end
end

function RougeMapLeaveItem:_getNeedPlayEndingFourthStories()
	local storyIds = string.splitToNumber(lua_rouge_const.configDict[RougeEnum.Const.FourthEndingStoryId].value2, "#")
	local needPlayStoryIds = {}

	for _, storyId in ipairs(storyIds) do
		local isStoryFinished = StoryModel.instance:isStoryFinished(storyId)

		if not isStoryFinished then
			needPlayStoryIds = storyIds

			break
		end
	end

	local isNeedPlayStory = needPlayStoryIds and #needPlayStoryIds > 0

	return needPlayStoryIds, isNeedPlayStory
end

function RougeMapLeaveItem:_sendMoveRpc()
	RougeRpc.instance:sendRougePieceMoveRequest(RougeMapEnum.PathSelectIndex)
end

function RougeMapLeaveItem:isActive()
	if self.onPieceView then
		return false
	end

	local middleLayerCo = RougeMapModel.instance:getMiddleLayerCo()
	local type = middleLayerCo.leavePosUnlockType
	local param = middleLayerCo.leavePosUnlockParam

	return RougeMapUnlockHelper.checkIsUnlock(type, param)
end

function RougeMapLeaveItem:onMiddleActorBeforeMove(data)
	local pieceId = data.pieceId

	if pieceId == RougeMapEnum.LeaveId then
		return
	end

	self.onPieceView = true

	self:refreshActive()
end

function RougeMapLeaveItem:onExitPieceChoiceEvent()
	self.onPieceView = false

	self:refreshActive()
end

return RougeMapLeaveItem
