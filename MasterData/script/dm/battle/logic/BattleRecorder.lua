-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleRecorder.lua

local function deepCopy(src)
	if type(src) ~= "table" then
		return src
	end

	local dst = {}

	for k, v in pairs(src) do
		dst[k] = deepCopy(v)
	end

	return dst
end

IRecordsProvider = interface("IRecordsProvider")

function IRecordsProvider:startProviding()
	return
end

function IRecordsProvider:hasReachedEnding(frame)
	return
end

function IRecordsProvider:allNewTimelinesAtFrame(frame)
	return
end

function IRecordsProvider:allRecordsAtFrame(frame)
	return
end

BattleRecorder = class("BattleRecorder")

function BattleRecorder:initialize()
	super.initialize(self)
end

function BattleRecorder:getTotalFrames()
	return self._maxFrame
end

function BattleRecorder:dumpRecords()
	local timelines = {}
	local timelineArray = self._timelineArray

	if timelineArray ~= nil then
		for i = 1, #timelineArray do
			local tl = timelineArray[i]

			timelines[tl.id] = {
				id = tl.id,
				type = tl.type,
				start = tl.start,
				ended = tl.ended,
				order = i,
				keyframes = {}
			}
		end
	end

	local eventsOnFrames = self._eventsOnFrames

	if eventsOnFrames ~= nil and self._maxFrame ~= nil then
		for frame = 0, self._maxFrame do
			local frameEvents = eventsOnFrames[frame]

			if frameEvents then
				for i = 1, #frameEvents do
					local event = frameEvents[i]
					local tl = timelines[event.id]
					local keyframes = tl and tl.keyframes

					assert(keyframes ~= nil)

					local kf = keyframes[#keyframes]

					if kf == nil or kf.f ~= frame then
						kf = {
							evts = {},
							f = frame
						}
						keyframes[#keyframes + 1] = kf
					end

					local events = kf.evts

					events[#events + 1] = {
						i = i,
						e = event.e,
						d = deepCopy(event.d)
					}
				end
			end
		end
	end

	return {
		maxframe = self._maxFrame,
		ending = self._endingFrame,
		timelines = timelines
	}
end

function BattleRecorder:restoreRecords(recordsInfo)
	local timelineDict = {}
	local timelineArray = {}
	local eventsOnFrames = {}
	local timelines = recordsInfo.timelines

	for id, tl0 in pairs(timelines) do
		local tl = {
			id = id,
			type = tl0.type,
			start = tl0.start,
			ended = tl0.ended
		}

		timelineDict[tl0.id] = tl
		timelineArray[tl0.order] = tl

		local keyframes = tl0.keyframes

		if keyframes then
			for _, kf in ipairs(keyframes) do
				local frameEvents = eventsOnFrames[kf.f]

				if frameEvents == nil then
					frameEvents = {}
					eventsOnFrames[kf.f] = frameEvents
				end

				for _, evt in ipairs(kf.evts) do
					frameEvents[evt.i] = {
						id = id,
						e = evt.e,
						d = deepCopy(evt.d)
					}
				end
			end
		end
	end

	self._timelineDict = timelineDict
	self._timelineArray = timelineArray
	self._eventsOnFrames = eventsOnFrames
	self._maxFrame = recordsInfo.maxframe
	self._endingFrame = recordsInfo.ending

	return self
end

BattleRecorder:implements(IBattleRecorder)

function BattleRecorder:startRecording()
	self._timelineDict = {}
	self._timelineArray = {}
	self._eventsOnFrames = {}
	self._maxFrame = 0
	self._endingFrame = nil
end

function BattleRecorder:endRecording()
	self._endingFrame = self._maxFrame
end

function BattleRecorder:gotoFrame(frame)
	self._currentFrame = frame

	if self._maxFrame == nil or frame > self._maxFrame then
		self._maxFrame = frame
	end
end

function BattleRecorder:getCurrentFrame()
	return self._currentFrame
end

function BattleRecorder:newTimeline(objId, typeName)
	return self:newTimelineAtFrame(objId, self._currentFrame, typeName)
end

function BattleRecorder:recordEvent(objId, evt, data)
	self:recordEventAtFrame(objId, self._currentFrame, evt, data)
end

function BattleRecorder:recordMetaEvent(objId, evt, data, typeName)
	self:newTimeline(objId, typeName)
	self:recordEvent(objId, evt, data)
end

function BattleRecorder:newTimelineAtFrame(objId, frame, typeName)
	assert(self._timelineDict[objId] == nil)

	local index = #self._timelineArray + 1
	local timeline = {
		id = objId,
		type = typeName,
		start = frame,
		ended = frame
	}

	self._timelineDict[objId] = timeline
	self._timelineArray[index] = timeline

	return timeline
end

function BattleRecorder:recordEventAtFrame(objId, frame, evt, data)
	local timeline = self._timelineDict[objId]

	assert(timeline ~= nil, "timeline==nil, frame: " .. frame .. "  , objId: " .. objId)
	assert(frame >= timeline.start, "frame < start, frame: " .. frame .. "  ,start: " .. timeline.start)

	if timeline.ended == nil or frame > timeline.ended then
		timeline.ended = frame
	end

	local frameEvents = self._eventsOnFrames[frame]

	if frameEvents == nil then
		frameEvents = {}
		self._eventsOnFrames[frame] = frameEvents
	end

	local order = #frameEvents + 1

	frameEvents[order] = {
		id = objId,
		e = evt,
		d = data
	}
end

BattleRecorder:implements(IRecordsProvider)

function BattleRecorder:startProviding()
	return
end

function BattleRecorder:hasReachedEnding(frame)
	return self._endingFrame ~= nil and frame > self._endingFrame
end

function BattleRecorder:allNewTimelinesAtFrame(frame)
	local newTimelines
	local timelineArray = self._timelineArray

	for i = 1, #timelineArray do
		local tl = timelineArray[i]

		if tl.start == frame then
			if newTimelines == nil then
				newTimelines = {}
			end

			newTimelines[#newTimelines + 1] = {
				tl.id,
				tl.type
			}
		end
	end

	return newTimelines
end

function BattleRecorder:allRecordsAtFrame(frame)
	local frameEvents = self._eventsOnFrames[frame]

	if frameEvents == nil then
		return nil
	end

	local records = {}

	for i = 1, #frameEvents do
		local event = frameEvents[i]

		records[i] = {
			event.id,
			event.e,
			event.d
		}
	end

	return records
end
