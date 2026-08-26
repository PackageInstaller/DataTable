-- chunkname: @modules/logic/gm/view/rouge/RougeProfileController.lua

module("modules.logic.gm.view.rouge.RougeProfileController", package.seeall)

local RougeProfileController = class("RougeProfileController")

function RougeProfileController:startRecordMemory()
	if self.startRecord then
		GameFacade.showToastString("recording ")

		return
	end

	self.startRecord = true
	self.memoryTimeList = {}
	self.maxMemory = collectgarbage("count")
	self.maxMemoryScene = GameSceneMgr.instance:getCurSceneType()
	self.maxOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	self.minMemory = self.maxMemory
	self.minMemoryScene = GameSceneMgr.instance:getCurSceneType()
	self.minOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")

	TaskDispatcher.runRepeat(self._calLuaMemory, self, 1)
end

function RougeProfileController:_calLuaMemory()
	local curMemory = collectgarbage("count")

	self.memoryTimeList[#self.memoryTimeList + 1] = {
		time = os.time(),
		memory = curMemory,
		scene = GameSceneMgr.instance:getCurSceneType()
	}

	if curMemory > self.maxMemory then
		self.maxMemory = curMemory
		self.maxMemoryScene = GameSceneMgr.instance:getCurSceneType()
		self.maxOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	end

	if curMemory < self.minMemory then
		self.minMemory = curMemory
		self.minMemoryScene = GameSceneMgr.instance:getCurSceneType()
		self.minOpenNameList = table.concat(ViewMgr.instance:getOpenViewNameList(), ",")
	end
end

function RougeProfileController:endRecord()
	if not self.startRecord then
		return
	end

	self.startRecord = nil

	TaskDispatcher.cancelTask(self._calLuaMemory, self)

	local log = ""

	log = log .. string.format("占用最大内存 ：%s, 场景 ： %s, openView : %s\n", self.maxMemory / 1024, self.maxMemoryScene, self.maxOpenNameList)
	log = log .. string.format("占用最小内存 ：%s, 场景 ： %s, openView : %s\n\n\n", self.minMemory / 1024, self.minMemoryScene, self.minOpenNameList)

	local peakList = {}
	local preMemory = 0
	local up = true

	for _, memoryObj in ipairs(self.memoryTimeList) do
		local time = memoryObj.time
		local memory = memoryObj.memory / 1024

		if up then
			if memory < preMemory then
				table.insert(peakList, self:getLineLog(preMemory, memory, time, memoryObj.scene))

				up = false
			end
		elseif preMemory < memory then
			table.insert(peakList, self:getLineLog(preMemory, memory, time, memoryObj.scene))

			up = true
		end

		preMemory = memory
	end

	table.insert(peakList, self:getLineLog(preMemory, preMemory, self.memoryTimeList[#self.memoryTimeList].time, self.memoryTimeList[#self.memoryTimeList].scene))

	log = log .. table.concat(peakList, "\n")
	log = log .. "\n\n详细内存统计 : \n"

	for _, memoryObj in ipairs(self.memoryTimeList) do
		log = log .. memoryObj.time .. " : " .. memoryObj.memory / 1024 .. "MB\n"
	end

	local time = os.time()
	local dir = SLFramework.FrameworkSettings.PersistentResRootDir .. "/luaMemoryTest/"
	local fileName = dir .. time .. ".log"

	SLFramework.FileHelper.WriteTextToPath(fileName, log)
	ZProj.OpenSelectFileWindow.OpenExplorer(dir)

	self.memoryTimeList = nil
	self.maxMemory = nil
	self.maxMemoryScene = nil
	self.maxOpenNameList = nil
	self.minMemory = nil
	self.minMemoryScene = nil
	self.minOpenNameList = nil
end

function RougeProfileController:getLineLog(preMemory, curMemory, time, scene)
	return string.format("preMemory : %s ---- curMemory : %s, time : %s, scene : %s", preMemory, curMemory, time, scene)
end

RougeProfileController.instance = RougeProfileController.New()

return RougeProfileController
