-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\HorizontalRPGRollingBGView.lua

local m = {
	BaseSpeed = 60,
	PlayerMinY = 0,
	CameraMaxY = 0,
	PlayerMaxY = 0,
	CameraMinY = 0,
	RollingBGPool = {}
}
local HorizontalRPGRollingCtrl = require("IQIGame.Scene.HorizontalRPG.Controller.HorizontalRPGRollingCtrl")

function m.New(view, maxY, minY, cameraMaxY, cameraMinY)
	local obj = Clone(m)

	obj:Init(view, maxY, minY, cameraMaxY, cameraMinY)

	return obj
end

function m:Init(view, maxY, minY, cameraMaxY, cameraMinY)
	self.View = view
	self.PlayerMaxY = maxY
	self.PlayerMinY = minY
	self.CameraMaxY = cameraMaxY
	self.CameraMinY = cameraMinY

	LuaCodeInterface.BindOutlet(self.View, self)

	self.BaseSpeed = HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().RollingBgSpeed
	self.RollingBGPool = {}

	for i = 1, 4 do
		if self["Layer" .. i] then
			local RollingBG = HorizontalRPGRollingCtrl.New(self["Layer" .. i], i)

			table.insert(self.RollingBGPool, RollingBG)
		end
	end

	self.View:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:FixedUpdate()
	return
end

function m:LookAt(pos)
	self.View.transform.position = pos
end

function m:FrameUpdate()
	for i, v in pairs(self.RollingBGPool) do
		v:FrameUpdate()
	end
end

function m:RefreshSpeed(horizontalX, cameraPosY, playerPosY, playerHorizontalX, isOnMovePlatform)
	if playerHorizontalX ~= 0 or isOnMovePlatform then
		local speed = 0

		if horizontalX > 0 then
			speed = -self.BaseSpeed
		elseif horizontalX < 0 then
			speed = self.BaseSpeed
		end

		self:SetRollingBGSpeed(speed)
	else
		self:SetRollingBGSpeed(0)
	end

	local playerProportion = (playerPosY - self.PlayerMinY) / (self.PlayerMaxY - self.PlayerMinY)
	local cameraProPortion = (cameraPosY - self.CameraMinY) / (self.CameraMaxY - self.CameraMinY)

	self:SetRollingBGPosY(playerProportion, cameraProPortion)
end

function m:SetRollingBGSpeed(speed)
	for i, v in pairs(self.RollingBGPool) do
		local rollingSpeed = speed

		if v.Layer == 1 then
			rollingSpeed = speed * HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().RollingBgSpeedLev[4]
		elseif v.Layer == 2 then
			rollingSpeed = speed * HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().RollingBgSpeedLev[3]
		elseif v.Layer == 3 then
			rollingSpeed = speed * HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().RollingBgSpeedLev[2]
		elseif v.Layer == 4 then
			rollingSpeed = speed * HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().RollingBgSpeedLev[1]
		end

		v:SetSpeed(rollingSpeed)
	end
end

function m:SetRollingBGPosY(proportion, cameraProportion)
	for i, v in pairs(self.RollingBGPool) do
		local rollingProportion = proportion

		if v.Layer == 1 then
			if math.abs(cameraProportion) < 0.01 then
				rollingProportion = proportion * 1 / 8
			else
				rollingProportion = cameraProportion * 2
			end
		elseif v.Layer == 2 then
			if math.abs(cameraProportion) < 0.01 then
				rollingProportion = proportion * 1 / 3
			else
				rollingProportion = cameraProportion * 4
			end
		elseif v.Layer == 3 then
			if math.abs(cameraProportion) < 0.01 then
				rollingProportion = proportion * 1 / 3
			else
				rollingProportion = cameraProportion * cameraProportion
			end
		elseif v.Layer == 4 then
			rollingProportion = proportion * 4
		end

		v:SetPosY(rollingProportion)
	end
end

function m:RefreshWeather(isDay)
	for i, v in pairs(self.RollingBGPool) do
		v:RefreshWeather(isDay)
	end
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.RollingBGPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
