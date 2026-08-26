-- chunkname: @modules/logic/partygame/view/carddrop/timeline/CardDropTimelineItem.lua

module("modules.logic.partygame.view.carddrop.timeline.CardDropTimelineItem", package.seeall)

local CardDropTimelineItem = class("CardDropTimelineItem", UserDataDispose)
local BehaviourPool = {}
local Type2BehaviourDict = {
	[CardDropBehaviourType.Type.Move] = CardDropTimelineMove,
	[CardDropBehaviourType.Type.ResetPos] = CardDropTimelineResetPos,
	[CardDropBehaviourType.Type.PlayAction] = CardDropTimelinePlayAction,
	[CardDropBehaviourType.Type.AddEffect] = CardDropTimelineAddEffect,
	[CardDropBehaviourType.Type.AddGlobalEffect] = CardDropTimelineAddGlobalEffect,
	[CardDropBehaviourType.Type.PlayAudio] = CardDropTimelinePlayAudio
}

function CardDropTimelineItem.ClearBehaviourPool()
	for _, poolList in pairs(BehaviourPool) do
		for _, behaviour in ipairs(poolList) do
			behaviour:destroy()
		end
	end

	tabletool.clear(BehaviourPool)
end

function CardDropTimelineItem:setPlayUid(uid)
	self.uid = uid
	self.entity = CardDropGameController.instance:getEntity(uid)
end

function CardDropTimelineItem:init(timelineId, goRoot)
	self:__onInit()

	self.timelineId = timelineId
	self.go = gohelper.create3d(nil, "timeline_" .. self.timelineId)

	self.go.transform:SetParent(goRoot.transform)

	self.binder = PartyGame.Runtime.Timeline.PartyGamePlayableAssetBinder.Get(self.go)

	self.binder:AddFrameEventCallback(self.onFrameEventCallback, self)
	self.binder:AddEndCallback(self.onTimelineEndCallback, self)

	self.binder.director.enabled = false
	self.updateHandle = UpdateBeat:CreateListener(self.frameUpdate, self)
	self.playingBehaviourDict = {}
end

function CardDropTimelineItem:onFrameEventCallback(type, id, isBegin, duration, paramStr)
	if isBegin then
		self:beginBehaviour(type, id, duration, paramStr)
	else
		self:endBehaviour(type, id)
	end
end

function CardDropTimelineItem:beginBehaviour(type, id, duration, paramStr)
	local poolList = BehaviourPool[type]

	if not poolList then
		poolList = {}
		BehaviourPool[type] = poolList
	end

	local behaviour = table.remove(poolList)

	if not behaviour then
		local cls = Type2BehaviourDict[type]

		behaviour = cls.New()

		behaviour:init()
	end

	behaviour:setPlayerUid(self.uid)
	behaviour:onBehaviourStart(type, id, duration, cjson.decode(paramStr))

	self.playingBehaviourDict[id] = behaviour
end

function CardDropTimelineItem:endBehaviour(type, id)
	local playingBehaviour = self.playingBehaviourDict[id]

	if not playingBehaviour then
		return
	end

	playingBehaviour:onBehaviourEnd()
end

function CardDropTimelineItem:onTimelineEndCallback()
	self:onTimeLineEnd()
end

function CardDropTimelineItem:registerOnTimeLineEnd(endFunc, endFuncObj)
	self.endFunc = endFunc
	self.endFuncObj = endFuncObj
end

function CardDropTimelineItem:getTimelineId()
	return self.timelineId
end

function CardDropTimelineItem:stop()
	self.binder:Stop(true)
	self:onTimeLineEnd()
end

function CardDropTimelineItem:onTimeLineEnd()
	for _, behaviour in pairs(self.playingBehaviourDict) do
		behaviour:onTimelineEnd()

		local type = behaviour:getType()
		local poolList = BehaviourPool[type]

		table.insert(poolList, behaviour)
	end

	tabletool.clear(self.playingBehaviourDict)
	self:removeUpdateHandle()

	self.binder.director.enabled = false

	if self.endFunc then
		self.endFunc(self.endFuncObj, self)
	end

	local callback = self.callback
	local callbackObj = self.callbackObj

	self.callback = nil
	self.callbackObj = nil

	if callback then
		self.callback(callbackObj)
	end
end

function CardDropTimelineItem:play(uid, timelineName, callback, callbackObj)
	self:setPlayUid(uid)

	self.timelineName = timelineName
	self.timelineUrl = ResUrl.getPartyGameTimelineUrl(timelineName)
	self.timelineAbName = ResUrl.getPartyGameTimelineAbName(timelineName)
	self.callback = callback
	self.callbackObj = callbackObj

	self:clearLoader()

	self.loader = MultiAbLoader.New()

	self.loader:addPath(self.timelineAbName)
	self.loader:startLoad(self.onLoadTimelineDone, self)
end

function CardDropTimelineItem:onLoadTimelineDone()
	self.assetItem = self.loader:getFirstAssetItem()

	self:addUpdateHandle()

	self.binder.director.enabled = true

	self.binder:Play(self.assetItem, self.timelineUrl)
end

function CardDropTimelineItem:addUpdateHandle()
	if self.updateHandle then
		UpdateBeat:AddListener(self.updateHandle)
	end
end

function CardDropTimelineItem:removeUpdateHandle()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end
end

function CardDropTimelineItem:frameUpdate()
	if self.binder == nil then
		return
	end

	self.binder:Evaluate(Time.deltaTime)
end

function CardDropTimelineItem:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function CardDropTimelineItem:destroy()
	if self.binder then
		self.binder:RemoveFrameEventCallback()
		self.binder:RemoveEndCallback()
		self.binder:Stop(true)
	end

	gohelper.destroy(self.go)

	if self.playingBehaviourDict then
		for _, behaviour in pairs(self.playingBehaviourDict) do
			behaviour:onBehaviourEnd()
			behaviour:onTimelineEnd()
			behaviour:destroy()
		end

		tabletool.clear(self.playingBehaviourDict)

		self.playingBehaviourDict = nil
	end

	self:clearLoader()
	self:removeUpdateHandle()

	self.updateHandle = nil

	self:__onDispose()
end

return CardDropTimelineItem
