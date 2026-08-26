-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapDragContext.lua

local ti = table.insert
local MyData = require("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext_MyData")

module("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext", package.seeall)

local ChgMapDragContext = class("ChgMapDragContext", UserDataDispose)

function ChgMapDragContext:_mapMO()
	return ChgBattleModel.instance:mapMO()
end

function ChgMapDragContext:_roundMO()
	return self:_mapMO():curRoundMO()
end

function ChgMapDragContext:_lineSegmentList()
	return self._viewObj._lineSegmentList
end

function ChgMapDragContext:getOrCreateLineItem(...)
	return self:_lineSegmentList():getOrCreateLineItem(...)
end

function ChgMapDragContext:resetToIdle(...)
	return self:_lineSegmentList():resetToIdle(...)
end

function ChgMapDragContext:recentValidLineItem(...)
	return self:_lineSegmentList():recentValidLineItem(...)
end

function ChgMapDragContext:recentValidLineItemBySpecificEnd(...)
	return self:_lineSegmentList():recentValidLineItemBySpecificEnd(...)
end

function ChgMapDragContext:checkIsCompleted(...)
	return self:_lineSegmentList():checkIsCompleted(...)
end

function ChgMapDragContext:currentDir(...)
	return self:_lineSegmentList():currentDir(...)
end

function ChgMapDragContext:getAllVisitedCheckpointItemList(...)
	return self:_lineSegmentList():getAllVisitedCheckpointItemList(...)
end

function ChgMapDragContext:lastUsedAndUsing(...)
	return self:_lineSegmentList():lastUsedAndUsing(...)
end

function ChgMapDragContext:getValidLineItemListFromEnd(...)
	return self:_lineSegmentList():getValidLineItemListFromEnd(...)
end

function ChgMapDragContext:ctor()
	self:clear()
end

function ChgMapDragContext:clear()
	GameUtil.onDestroyViewMember_TweenId(self, "_previewTweenId")
	GameUtil.onDestroyViewMemberList(self, "_cmdFlowList")
	self:__onDispose()
	self:__onInit()

	self._enabled = false
	self._viewObj = false
	self._viewContainer = false
	self._isCompleted = false
	self._cmdFlowList = {}
end

function ChgMapDragContext:reset(current_V3a4_Chg_GameView)
	self:clear()

	self._viewObj = current_V3a4_Chg_GameView
	self._viewContainer = self._viewObj.viewContainer

	self._viewContainer:triggerPlayLoopSFX(false)
	self:setEnabled(true)
end

function ChgMapDragContext:onDragBegin(dragObj, userParams)
	self._viewContainer:triggerPlayLoopSFX(false)

	if not self._enabled then
		return
	end

	userParams._myData = userParams._myData or MyData.New(self)

	userParams._myData:onDragBegin(dragObj)
end

function ChgMapDragContext:onDrag(dragObj, userParams)
	if not self._enabled then
		return
	end

	if userParams._myData then
		userParams._myData:onDrag(dragObj)
	end
end

function ChgMapDragContext:onDragEnd(dragObj, userParams)
	self._viewContainer:triggerPlayLoopSFX(false)

	if not self._enabled then
		return
	end

	if userParams._myData then
		userParams._myData:onDragEnd(dragObj)
	end
end

function ChgMapDragContext:execDragBegin(myData)
	return
end

function ChgMapDragContext:execDragging_FirstFrame(cmdFlow)
	self:_execImpl(cmdFlow)
end

function ChgMapDragContext:execDragging(cmdFlow)
	self:_execImpl(cmdFlow)
end

function ChgMapDragContext:execDragEnd(cmdFlow)
	self:_execImpl(cmdFlow)
end

function ChgMapDragContext:_execImpl(cmdFlow)
	ti(self._cmdFlowList, cmdFlow)
	cmdFlow:start(self)
end

function ChgMapDragContext:setEnabled(isEnabled)
	self._enabled = not not isEnabled
end

function ChgMapDragContext:_critical_beforeClear()
	if self._viewContainer then
		self._viewContainer:triggerPlayLoopSFX(false)
	end

	GameUtil.onDestroyViewMemberList(self, "_cmdFlowList")

	self._cmdFlowList = {}

	self:setEnabled(false)
end

function ChgMapDragContext:isCompleted()
	return self._isCompleted
end

function ChgMapDragContext:setCompleted()
	if self._isCompleted then
		return
	end

	self._isCompleted = true

	self:setEnabled(false)
	self._viewObj:completeRound()
end

return ChgMapDragContext
