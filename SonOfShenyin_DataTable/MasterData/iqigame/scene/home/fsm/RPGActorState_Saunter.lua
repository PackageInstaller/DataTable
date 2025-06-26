-- chunkname: @IQIGame\\Scene\\Home\\FSM\\RPGActorState_Saunter.lua

local m = class(nil, FSMState)

m.Name = Constant.RPGActorFSMState.Saunter

function m:OnEnter(args)
	self.args = args

	local homeRoom = HomeModule.GetCurrentHomeRoom()
	local movePointArray = homeRoom.movePointArray

	if not movePointArray then
		logError("【RPG】当前场景没有寻路移动点位配置")

		return
	end

	local len = #movePointArray

	if len <= 0 then
		logError("【RPG】当前场景没有寻路移动点位配置")

		return
	end

	local filerPosPoint = true
	local posMap = {}
	local posPointArray = {}

	if self.args.actionParam[4] then
		posPointArray = string.split(self.args.actionParam[4], ",")
	end

	if #posPointArray == 0 or #posPointArray == 1 and tonumber(posPointArray[1]) == 0 then
		filerPosPoint = false
	end

	for i = 1, #posPointArray do
		posMap[tonumber(posPointArray[i])] = 1
	end

	local actor = args.actor

	if not actor then
		return
	end

	if LuaUtility.GameObjectIsNullOrEmpty(actor:GetRootGameObject()) then
		return
	end

	local filterMovePointArray = {}

	for i = 1, len do
		if Vector3.Distance(actor.transform.position, movePointArray[i].position) > 0.1 then
			if filerPosPoint then
				if posMap[i] then
					table.insert(filterMovePointArray, movePointArray[i])
				end
			else
				table.insert(filterMovePointArray, movePointArray[i])
			end
		end
	end

	len = #filterMovePointArray

	if len <= 0 then
		return
	end

	local n = math.random(1, len)

	actor.controller.autoMoveController:SetWalkingAnimateName(self.args.actionParam[1])
	actor.controller.autoMoveController:SetSpeed(tonumber(self.args.actionParam[2]))

	self.duration = tonumber(self.args.actionParam[3])

	actor:StartMove(filterMovePointArray[n].position)

	self.dStartTime = Time.time
end

function m:OnUpdate(deltaTime)
	if not self.dStartTime then
		return
	end

	if Time.time - self.dStartTime >= self.duration then
		self.args.actor:StopMove()
		self.args.actor.controller:RandomStartAI()
	end
end

function m:OnExit()
	self.args.actor:StopMove()
end

return m
