-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\iFrameMgr.lua

local strClassName = "iFrameManager"
local iFrameManager = Class(strClassName)

function iFrameManager:ctor(matrixInstance)
	self.matrixInstance = matrixInstance
	self.frameQueue = {}
	self.curFrame = 0
	self.maxFrame = 0
	self.matrixFrameLength = matrixInstance.frameLength
end

function iFrameManager:onReceiveMsg(inputType, packArgs, frameNum)
	frameNum = frameNum or self.curFrame + 1

	if not self.frameQueue[frameNum] then
		self.frameQueue[frameNum] = {}
	end

	table.insert(self.frameQueue[frameNum], {
		inputType,
		packArgs
	})
	self.matrixInstance:receiveInputInfo(inputType, packArgs, frameNum)
end

function iFrameManager:tick()
	return
end

function iFrameManager:nextFrame()
	if self.curFrame >= self.maxFrame then
		return nil
	end

	self.curFrame = self.curFrame + 1

	local frameData = self.frameQueue[self.curFrame]

	self.matrixInstance:addEvent(self.curFrame, frameData)
	self.matrixInstance:nextFrame()

	return self.matrixInstance:getFrameOutput()
end

function iFrameManager:destroy()
	return
end

return iFrameManager
