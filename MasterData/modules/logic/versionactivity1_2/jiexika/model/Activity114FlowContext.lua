-- chunkname: @modules/logic/versionactivity1_2/jiexika/model/Activity114FlowContext.lua

module("modules.logic.versionactivity1_2.jiexika.model.Activity114FlowContext", package.seeall)

local Activity114FlowContext = class("Activity114FlowContext")

function Activity114FlowContext:ctor()
	self.type = 0
	self.eventId = 0
	self.eventCo = nil
	self.nowDay = 0
	self.nowRound = 0
	self.nowWeek = 0
	self.result = 0
	self.storyId = 0
	self.storyType = 0
	self.storyWorkEnd = nil
	self.transitionId = nil
	self.resultBonus = {}
	self.diceResult = {}
	self.realVerify = 0
	self.preAttention = 0
	self.preAttrs = {}
	self.totalScore = 0
	self.answerIndex = 0
	self.answerIds = {}
end

return Activity114FlowContext
