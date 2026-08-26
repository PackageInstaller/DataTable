-- chunkname: @modules/logic/weather/controller/WeatherYearAnimationComp.lua

module("modules.logic.weather.controller.WeatherYearAnimationComp", package.seeall)

local WeatherYearAnimationComp = class("WeatherYearAnimationComp", BaseSceneComp)

WeatherYearAnimationComp.CurveAssetPath = "scenes/dynamic/m_s01_zjm_a/anim/year_curve.asset"
WeatherYearAnimationComp.ConstVarId = {
	RotateDurationId = 602,
	IntervalId = 600,
	CirculationIntervalId = 603,
	RotateCircleId = 601,
	StartYearId = 604
}

function WeatherYearAnimationComp:onInit()
	self.animationEndTime = 0
	self.materials = {}
	self.yearTable = {}
	self.node = nil
	self.node1 = nil
	self.aniCurveConfig = nil
	self.circulationNums = {}
	self.circulationIndex = 0
	self.interval = CommonConfig.instance:getConstNum(WeatherYearAnimationComp.ConstVarId.IntervalId)
	self.rotateCircle = CommonConfig.instance:getConstNum(WeatherYearAnimationComp.ConstVarId.RotateCircleId)
	self.rotateDuration = CommonConfig.instance:getConstNum(WeatherYearAnimationComp.ConstVarId.RotateDurationId)
	self.circulationInterval = CommonConfig.instance:getConstNum(WeatherYearAnimationComp.ConstVarId.CirculationIntervalId)
	self.startYear = CommonConfig.instance:getConstNum(WeatherYearAnimationComp.ConstVarId.StartYearId)
	self.setNumYearTable = self:_numberConvertToTable(self.startYear)
end

function WeatherYearAnimationComp:initSceneGo(go)
	self._sceneGo = go

	self:initSceneNodeStatus()
	self.initAnimationCurve(self, self._onCloseViewFinish, self)
end

function WeatherYearAnimationComp:initSceneNodeStatus()
	self.node = self:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year")
	self.node1 = self:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year (1)")

	if not self.node then
		logError("initSceneNodeStatus no node")

		return
	end

	self.materials = {}

	local material = self.node:GetComponent(typeof(UnityEngine.Renderer)).sharedMaterial

	table.insert(self.materials, material)

	if self.node1 then
		local material1 = self.node1:GetComponent(typeof(UnityEngine.Renderer)).sharedMaterial

		table.insert(self.materials, material1)
	end

	self:setMaterialsParam()
end

function WeatherYearAnimationComp:initAnimationCurve(callback, callbackObj)
	self.loadAnimationCurveCallback = callback
	self.loadAnimationCurveCallbackObj = callbackObj

	loadAbAsset(WeatherYearAnimationComp.CurveAssetPath, false, self.loadCallback, self)
end

function WeatherYearAnimationComp:loadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self.assetItem

		self.assetItem = assetItem

		self.assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self.aniCurveConfig = self.assetItem:GetResource(WeatherYearAnimationComp.CurveAssetPath)
	else
		self.aniCurveConfig = nil

		logError("%s scene load '%s' failed", GameSceneMgr.instance:getCurScene()._gameObj.name, WeatherYearAnimationComp.CurveAssetPath)
	end

	self.loadAnimationCurveCallback(self.loadAnimationCurveCallbackObj)
end

function WeatherYearAnimationComp:_onCloseViewFinish()
	if not self.node then
		logNormal("node not found, direct return, not play animation")

		return
	end

	local lastEpisodeCo = DungeonModel.instance:getLastEpisodeConfigAndInfo()

	lastEpisodeCo = lastEpisodeCo.preEpisode == 0 and DungeonConfig.instance:getEpisodeCO(10003) or DungeonConfig.instance:getEpisodeCO(lastEpisodeCo.preEpisode)

	if not self.lastEpisodeCo or lastEpisodeCo.id ~= self.lastEpisodeCo.id then
		self.lastEpisodeCo = lastEpisodeCo

		self:reCirculateCirculationNums()
	end

	self:cancelRepeatTask()

	if self.circulationNums and #self.circulationNums ~= 0 then
		self.circulationIndex = 0

		self:addRepeatTask()
		self:_playNodeAnimation()
	end
end

function WeatherYearAnimationComp:reCirculateCirculationNums()
	self.circulationNums = {}

	if self.lastEpisodeCo.year == 0 then
		logNormal(string.format("[WeatherYearAnimationComp] episode config not have year, id : %s, name : %s, year : %s", self.lastEpisodeCo.id, self.lastEpisodeCo.name, self.lastEpisodeCo.year))
		self:hideNode()

		return
	end

	table.insert(self.circulationNums, self.lastEpisodeCo.year)

	local timeStr = self.lastEpisodeCo.time

	if not string.nilorempty(timeStr) then
		local _, _, month, day, hour, minute = string.find(timeStr, "(%d+)/(%d+)%s+(%d+):(%d+)")

		if not string.nilorempty(month) and not string.nilorempty(day) then
			table.insert(self.circulationNums, string.format("%02d%02d", month, day))
		end

		if not string.nilorempty(hour) and not string.nilorempty(minute) then
			table.insert(self.circulationNums, string.format("%02d%02d", hour, minute))
		end
	end
end

function WeatherYearAnimationComp:getSceneNode(nodePath)
	local sceneGO = self._sceneGo

	if sceneGO then
		return gohelper.findChild(sceneGO, nodePath)
	end
end

function WeatherYearAnimationComp:_playNodeAnimation()
	self:showNode()

	self.circulationIndex = self.circulationIndex + 1

	if self.circulationIndex > #self.circulationNums then
		self.circulationIndex = 1
	end

	for i = 1, #self.setNumYearTable do
		self.setNumYearTable[i] = math.floor(self.setNumYearTable[i] % 10)
	end

	self.yearTable = {}

	local targetYearTable = self:_numberConvertToTable(self.circulationNums[self.circulationIndex])

	for i = 1, #targetYearTable do
		local yearObj = {}
		local totalIncrement = self:_getTotalIncrement(self.setNumYearTable[i], targetYearTable[i])

		yearObj.totalIncrement = totalIncrement
		yearObj.everySecondIncrement = totalIncrement / self.rotateDuration
		yearObj.startNum = self.setNumYearTable[i]
		yearObj.targetNum = self.setNumYearTable[i] + totalIncrement

		table.insert(self.yearTable, yearObj)
	end

	if #self.yearTable ~= 4 then
		logError(string.format("episode config error, id : %s, name : %s, year : %s, time : %s ", self.lastEpisodeCo.id, self.lastEpisodeCo.name, self.lastEpisodeCo.year, self.lastEpisodeCo.time))

		return
	end

	local currentTime = Time.time

	for i = 1, 4 do
		self.yearTable[i].startTime = currentTime + (i - 1) * self.interval
	end

	self.animationEndTime = self.yearTable[4].startTime + self.rotateDuration

	TaskDispatcher.runRepeat(self._onFrame, self, 0.001)
end

function WeatherYearAnimationComp:_onFrame()
	local currentTime = Time.time

	if self:canStopAnimation() then
		self:cancelAnimationTask()

		return
	end

	for i = 1, 4 do
		if currentTime >= self.yearTable[i].startTime then
			local deltaTime = currentTime - self.yearTable[i].startTime

			if deltaTime >= self.rotateDuration then
				self.setNumYearTable[i] = self.yearTable[i].targetNum
			else
				local x = deltaTime / self.rotateDuration
				local y = self.aniCurveConfig:GetY(x)

				self.setNumYearTable[i] = self.yearTable[i].startNum + self.yearTable[i].totalIncrement * y
			end
		end
	end

	self:setMaterialsParam()
end

function WeatherYearAnimationComp:hideNode()
	gohelper.setActive(self.node, false)
	gohelper.setActive(self.node1, false)
end

function WeatherYearAnimationComp:showNode()
	gohelper.setActive(self.node, true)
	gohelper.setActive(self.node1, true)
end

function WeatherYearAnimationComp:canStopAnimation()
	if self.animationEndTime < Time.time then
		for i = 1, 4 do
			if self.setNumYearTable[i] < self.yearTable[i].targetNum then
				return false
			end
		end

		return true
	end

	return false
end

function WeatherYearAnimationComp:setMaterialsParam()
	for _, mat in ipairs(self.materials) do
		mat:SetVector("_Year", Vector4.New(self.setNumYearTable[1], self.setNumYearTable[2], self.setNumYearTable[3], self.setNumYearTable[4]))
	end
end

function WeatherYearAnimationComp:_getTotalIncrement(startNum, endNum)
	local totalIncrement = 10 * self.rotateCircle
	local addNum = endNum - startNum

	if addNum < 0 then
		addNum = addNum + 10
	end

	return totalIncrement + addNum
end

function WeatherYearAnimationComp:_numberConvertToTable(number)
	local stringNum = tostring(number)
	local numTable = {}

	for char in string.gmatch(stringNum, ".") do
		table.insert(numTable, tonumber(char))
	end

	return numTable
end

function WeatherYearAnimationComp:addRepeatTask()
	TaskDispatcher.runRepeat(self._playNodeAnimation, self, self.rotateDuration + self.circulationInterval)
end

function WeatherYearAnimationComp:cancelRepeatTask()
	TaskDispatcher.cancelTask(self._playNodeAnimation, self)
	self:cancelAnimationTask()
end

function WeatherYearAnimationComp:cancelAnimationTask()
	TaskDispatcher.cancelTask(self._onFrame, self)

	self.yearTable = {}
end

function WeatherYearAnimationComp:onSceneClose()
	self:cancelRepeatTask()

	self.materials = {}
	self.setNumYearTable = {}
	self.yearTable = {}
	self.circulationNums = {}
	self.node = nil
	self.node1 = nil
	self.circulationIndex = 0
	self.lastEpisodeCo = nil

	if self.assetItem then
		self.assetItem:Release()

		self.aniCurveConfig = nil
		self.assetItem = nil
	else
		removeAssetLoadCb(WeatherYearAnimationComp.CurveAssetPath, self.loadCallback, self)
	end
end

return WeatherYearAnimationComp
