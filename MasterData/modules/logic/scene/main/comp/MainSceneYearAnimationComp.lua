-- chunkname: @modules/logic/scene/main/comp/MainSceneYearAnimationComp.lua

module("modules.logic.scene.main.comp.MainSceneYearAnimationComp", package.seeall)

local MainSceneYearAnimationComp = class("MainSceneYearAnimationComp", BaseSceneComp)

MainSceneYearAnimationComp.CurveAssetPath = "scenes/dynamic/m_s01_zjm_a/anim/year_curve.asset"
MainSceneYearAnimationComp.ConstVarId = {
	RotateDurationId = 602,
	IntervalId = 600,
	CirculationIntervalId = 603,
	RotateCircleId = 601,
	StartYearId = 604
}

function MainSceneYearAnimationComp:onInit()
	self.interval = 0.3
	self.rotateCircle = 1
	self.rotateDuration = 3
	self.circulationInterval = 2
	self.startYear = 1999
	self.animationEndTime = 0
	self.materials = {}
	self.yearTable = {}
	self.setNumYearTable = {}
	self.node = nil
	self.node1 = nil
	self.aniCurveConfig = nil
	self.forcePlayAnimation = false
	self.circulationNums = {}
	self.circulationIndex = 0
end

function MainSceneYearAnimationComp:onSceneStart()
	self.interval = CommonConfig.instance:getConstNum(MainSceneYearAnimationComp.ConstVarId.IntervalId)
	self.rotateCircle = CommonConfig.instance:getConstNum(MainSceneYearAnimationComp.ConstVarId.RotateCircleId)
	self.rotateDuration = CommonConfig.instance:getConstNum(MainSceneYearAnimationComp.ConstVarId.RotateDurationId)
	self.circulationInterval = CommonConfig.instance:getConstNum(MainSceneYearAnimationComp.ConstVarId.CirculationIntervalId)
	self.startYear = CommonConfig.instance:getConstNum(MainSceneYearAnimationComp.ConstVarId.StartYearId)
	self.setNumYearTable = self:_numberConvertToTable(self.startYear)
end

function MainSceneYearAnimationComp:onScenePrepared(sceneId, levelId)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	self:initSceneNodeStatus()

	if self.forcePlayAnimation then
		self:_onCloseViewFinish()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.SwitchSceneFinish, self._onSwitchSceneFinish, self)
end

function MainSceneYearAnimationComp:_onSwitchSceneFinish()
	self:initSceneNodeStatus()

	self.lastEpisodeCo = nil
	self.forcePlayAnimation = true

	self:_onCloseViewFinish()

	self.forcePlayAnimation = false
end

function MainSceneYearAnimationComp:initSceneNodeStatus()
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

function MainSceneYearAnimationComp:initAnimationCurve(callback, callbackObj)
	self.loadAnimationCurveCallback = callback
	self.loadAnimationCurveCallbackObj = callbackObj

	loadAbAsset(MainSceneYearAnimationComp.CurveAssetPath, false, self.loadCallback, self)
end

function MainSceneYearAnimationComp:loadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self.assetItem

		self.assetItem = assetItem

		self.assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self.aniCurveConfig = self.assetItem:GetResource(MainSceneYearAnimationComp.CurveAssetPath)
	else
		self.aniCurveConfig = nil

		logError("%s scene load '%s' failed", GameSceneMgr.instance:getCurScene()._gameObj.name, MainSceneYearAnimationComp.CurveAssetPath)
	end

	self.loadAnimationCurveCallback(self.loadAnimationCurveCallbackObj)
end

function MainSceneYearAnimationComp:_onCloseViewFinish()
	if not self.node then
		logNormal("node not found, direct return, not play animation")

		return
	end

	if not self.forcePlayAnimation then
		if not ViewMgr.instance:isOpen(ViewName.MainView) then
			return
		end

		if not ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) then
			return
		end
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

function MainSceneYearAnimationComp:reCirculateCirculationNums()
	self.circulationNums = {}

	if self.lastEpisodeCo.year == 0 then
		logNormal(string.format("[MainSceneYearAnimationComp] episode config not have year, id : %s, name : %s, year : %s", self.lastEpisodeCo.id, self.lastEpisodeCo.name, self.lastEpisodeCo.year))
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

function MainSceneYearAnimationComp:forcePlayAni()
	self.forcePlayAnimation = true

	self:_onCloseViewFinish()

	self.forcePlayAnimation = false
end

function MainSceneYearAnimationComp:getSceneNode(nodePath)
	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGO = scene.level:getSceneGo()

	if sceneGO then
		return gohelper.findChild(sceneGO, nodePath)
	end
end

function MainSceneYearAnimationComp:_playNodeAnimation()
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

function MainSceneYearAnimationComp:_onFrame()
	local currentTime = Time.time

	if self:canStopAnimation() then
		self:cancelAnimationTask()

		return
	end

	if MainSceneSwitchController.instance:isSwitching() then
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

function MainSceneYearAnimationComp:hideNode()
	gohelper.setActive(self.node, false)
	gohelper.setActive(self.node1, false)
end

function MainSceneYearAnimationComp:showNode()
	gohelper.setActive(self.node, true)
	gohelper.setActive(self.node1, true)
end

function MainSceneYearAnimationComp:canStopAnimation()
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

function MainSceneYearAnimationComp:setMaterialsParam()
	for _, mat in ipairs(self.materials) do
		mat:SetVector("_Year", Vector4.New(self.setNumYearTable[1], self.setNumYearTable[2], self.setNumYearTable[3], self.setNumYearTable[4]))
	end
end

function MainSceneYearAnimationComp:_getTotalIncrement(startNum, endNum)
	local totalIncrement = 10 * self.rotateCircle
	local addNum = endNum - startNum

	if addNum < 0 then
		addNum = addNum + 10
	end

	return totalIncrement + addNum
end

function MainSceneYearAnimationComp:_numberConvertToTable(number)
	local stringNum = tostring(number)
	local numTable = {}

	for char in string.gmatch(stringNum, ".") do
		table.insert(numTable, tonumber(char))
	end

	return numTable
end

function MainSceneYearAnimationComp:addRepeatTask()
	TaskDispatcher.runRepeat(self._playNodeAnimation, self, self.rotateDuration + self.circulationInterval)
end

function MainSceneYearAnimationComp:cancelRepeatTask()
	TaskDispatcher.cancelTask(self._playNodeAnimation, self)
	self:cancelAnimationTask()
end

function MainSceneYearAnimationComp:cancelAnimationTask()
	TaskDispatcher.cancelTask(self._onFrame, self)

	self.yearTable = {}
end

function MainSceneYearAnimationComp:onSceneClose()
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
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	MainSceneSwitchController.instance:unregisterCallback(MainSceneSwitchEvent.SwitchSceneFinish, self._onSwitchSceneFinish, self)
end

return MainSceneYearAnimationComp
