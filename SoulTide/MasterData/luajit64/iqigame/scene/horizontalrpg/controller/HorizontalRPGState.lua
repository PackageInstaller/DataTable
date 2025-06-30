-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\Controller\\HorizontalRPGState.lua

local m = {
	isEnter = false,
	enterTime = 0
}

function m.New(stateData, controller)
	local obj = Clone(m)

	obj:__Init(stateData, controller)

	return obj
end

function m:__Init(stateData, controller)
	self.stateData = stateData
	self.controller = controller
end

function m:Enter()
	if self.stateData == nil then
		return
	end

	self.isEnter = true

	log("Entering state: 播放动作 " .. self.stateData.animationName)
	self.controller:PlayAction(self.stateData.animationName, self.stateData.isLoop)

	if self.controller.ChangeGroundPos then
		self.controller:ChangeGroundPos(self.stateData.checkGroundY)
	end

	self.enterTime = UnityEngine.Time.realtimeSinceStartup
end

function m:Exit()
	self.isEnter = false

	if self.stateData then
		log("Exiting state: " .. self.stateData.animationName)
	end
end

function m:FrameUpdate()
	if self.stateData and self.isEnter and not self.stateData.isLoop and UnityEngine.Time.realtimeSinceStartup - self.enterTime >= self.stateData.playTime then
		self:Exit()
	end
end

function m:Dispose()
	return
end

return m
