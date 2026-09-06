-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/model/PinGameRootMo.lua

module("logic.extensions.pingame.model.PinGameRootMo", package.seeall)

local PinGameRootMo = class("PinGameRootMo")

function PinGameRootMo:ctor()
	self.rotateSpeed = 90
	self.rootRadius = 150
	self.lineLength = 160
	self.lineRadius = 10
	self.obstacleRadius = 10
	self.shootDuration = 0.1
	self.winCount = 10
	self.shootDir = {
		0
	}
	self.obstacleList = {
		90,
		160
	}
end

function PinGameRootMo:init(data)
	if not data.rotateSpeed or not data.rootRadius or not data.lineLength or not data.lineRadius or not data.shootDuration then
		printError("test PinGameRootMo:init 输入数据有缺失", data.rotateSpeed, data.rootRadius, data.lineLength, data.lineRadius, data.shootDuration)
	end

	self.rotateSpeed = data.rotateSpeed
	self.rootRadius = data.rootRadius
	self.lineLength = data.lineLength
	self.lineRadius = data.lineRadius
	self.shootDuration = data.shootDuration
	self.winCount = data.winCount
	self.shootDir = data.shootDir
	self.obstacleList = data.obstacleList or {}
end

return PinGameRootMo
