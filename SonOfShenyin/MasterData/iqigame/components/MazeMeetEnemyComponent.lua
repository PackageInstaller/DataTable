-- chunkname: @IQIGame\\Components\\MazeMeetEnemyComponent.lua

local MazeMeetEnemyComponent = {}

function MazeMeetEnemyComponent.New()
	local o = Clone(MazeMeetEnemyComponent)

	o:Initialize()

	return o
end

function MazeMeetEnemyComponent:Initialize()
	self.meetEnemySpanTime = CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.MazeMeetEnemyTime) / 1000
	self.dyMeetEnemySpan = 0

	self:InitDelegate()
	self:AddListener()
end

function MazeMeetEnemyComponent:InitDelegate()
	function self.OnFightOverDelegate()
		self:_OnFightOver()
	end
end

function MazeMeetEnemyComponent:AddListener()
	return
end

function MazeMeetEnemyComponent:RemoveListener()
	return
end

function MazeMeetEnemyComponent:OnDestroy()
	return
end

function MazeMeetEnemyComponent:Processing(moveCount)
	if self.isTriggered then
		return
	end

	self.dyMeetEnemySpan = self.dyMeetEnemySpan + Time.fixedDeltaTime

	if self.dyMeetEnemySpan < self.meetEnemySpanTime then
		return
	end

	local currentRoomID = MazeStageModule.GetCurrentRoomID()

	if not currentRoomID or currentRoomID == 0 then
		return
	end

	local cfgRoom = CfgUtil.GetCfgMazeRoomDataWithID(currentRoomID)

	if self.isExceedMaxMeetCount then
		return
	elseif MazeStageModule.GetMazeMeetFightCount() > CfgUtil.GetCfgMazeStageDataWithID(MazeStageModule.GetMazeStageID()).LimitFight then
		self.isExceedMaxMeetCount = true

		return
	end

	local len = #cfgRoom.MeetEnemyDistance

	if len ~= #cfgRoom.MeetEnemyProbability then
		logError(string.format("【迷宫】迷宫房间 room = %s，遇怪配置距离和概率数组长度不相同，请检查！", currentRoomID))

		return
	end

	if len < 1 then
		return
	end

	local prob = 0
	local index = 0

	if moveCount > 0 and moveCount <= cfgRoom.MeetEnemyDistance[1] then
		prob = cfgRoom.MeetEnemyProbability[1]
		index = 1
	elseif moveCount > cfgRoom.MeetEnemyDistance[len] then
		prob = cfgRoom.MeetEnemyProbability[len]
		index = len
	else
		for i = 1, len - 1 do
			if moveCount >= cfgRoom.MeetEnemyDistance[i] and moveCount < cfgRoom.MeetEnemyDistance[i + 1] then
				prob = cfgRoom.MeetEnemyProbability[i]
				index = i

				break
			end
		end
	end

	if prob == 0 then
		return
	end

	local p = index / len

	if p <= 0.333 then
		EventDispatcher.Dispatch(EventID.SetMazeWarningShowEvent, Constant.MazeWarningDefine.Low)
	elseif p > 0.333 and p <= 0.666 then
		EventDispatcher.Dispatch(EventID.SetMazeWarningShowEvent, Constant.MazeWarningDefine.Medium)
	else
		EventDispatcher.Dispatch(EventID.SetMazeWarningShowEvent, Constant.MazeWarningDefine.High)
	end

	log("【迷宫】当前遇怪概率 = " .. prob / 10000)

	if self:_CheckTriggerFight(prob) then
		self:_RandomFight(cfgRoom.MeetEnemyFight)
	end

	self.dyMeetEnemySpan = 0
end

function MazeMeetEnemyComponent:_CheckTriggerFight(prob)
	local num = math.random(1, 10000)

	log("【迷宫】随机数 = " .. num)

	if num <= prob then
		return true
	end

	return false
end

function MazeMeetEnemyComponent:_RandomFight(eventID)
	local cfgEvent = CfgUtil.GetCfgMazeEventDataWithID(eventID)
	local num = math.random(1, 100)
	local param = 0
	local temp = 0
	local len = #cfgEvent.Weight

	for i = 1, len do
		temp = temp + cfgEvent.Weight[i]

		if num < temp then
			param = cfgEvent.Params[i]

			break
		end
	end

	if param == 0 then
		return
	end

	self:_StartFight(param)
end

function MazeMeetEnemyComponent:_StartFight(param)
	self.isTriggered = true
	self.currentParam = param

	StoryModule.player:StopMove()
	StoryModule.PauseStory()
	StoryModule.SetNPCVariable(Constant.StoryMazeNpcID, Constant.StoryMazeMeetFight, IQIGame.Onigao.Game.VariableSetting.VariableType.Int, param, true)
	StoryModule.Save(false)
	coroutine.start(function()
		BehaviorTreeUtility.PlayBlackInkScreenEffect(1, 0.8)
		coroutine.wait(0.8)
		BehaviorTreeUtility.PlayBlackInkScreenEffect(2, 0.2)
		StoryModule.StartFight(param, self.OnFightOverDelegate)
	end)
end

function MazeMeetEnemyComponent:_OnFightOver()
	if MazeStageModule.isExitMazePrepare then
		BehaviorTreeUtility.PlayBlackInkScreenEffect(2, 0)

		self.isTriggered = false

		return
	end

	MazeStageModule.AddMazeMeetFightCount()
	StoryModule.SetNPCVariable(Constant.StoryMazeNpcID, Constant.StoryMazeMeetFight, IQIGame.Onigao.Game.VariableSetting.VariableType.Int, -1, true)
	StoryModule.Save(false)
	StoryModule.ContinueStory()
	BehaviorTreeUtility.PlayBlackInkScreenEffect(2, 0)
	StoryModule.player.joystickControl:ClearAbsMove()
	EventDispatcher.Dispatch(EventID.SetMazeWarningShowEvent, Constant.MazeWarningDefine.Low)
	StoryModule.AddExtensionMazeEvent(Constant.MazeEventDefine.MeetMonster, self.currentParam)

	self.isTriggered = false
end

return MazeMeetEnemyComponent
