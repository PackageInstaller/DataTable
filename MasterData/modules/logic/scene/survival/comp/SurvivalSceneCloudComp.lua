-- chunkname: @modules/logic/scene/survival/comp/SurvivalSceneCloudComp.lua

module("modules.logic.scene.survival.comp.SurvivalSceneCloudComp", package.seeall)

local SurvivalSceneCloudComp = class("SurvivalSceneCloudComp", BaseSceneComp)
local cloudColor = {
	Color(0.64, 0.643, 0.438),
	Color(0.4, 0.42, 0.51),
	[6] = Color(0.456, 0.392, 0.482),
	[4] = Color(0.59, 0.63, 0.745),
	[5] = Color(0.766, 0.6, 0.37),
	(Color(0.63, 0.68, 0.53))
}

function SurvivalSceneCloudComp:init(sceneId, levelId)
	self._sceneGo = self:getCurScene():getSceneContainerGO()
	self._cloudRoot = gohelper.create3d(self._sceneGo, "CloudRoot")

	transformhelper.setLocalPos(self._cloudRoot.transform, 0, SurvivalConst.CloudHeight, 0)

	self._allClouds = {}
	self.v3 = Vector3()
	self._hex = SurvivalHexNode.New()
	self._hex2 = SurvivalHexNode.New()
	self._cloudRes = SurvivalMapHelper.instance:getSpBlockRes(0, "survival_cloud")

	if self._cloudRes then
		self._cloudRes = gohelper.clone(self._cloudRes, self._cloudRoot, "[res]")

		gohelper.setActive(self._cloudRes, false)
	end

	local scneMo = SurvivalMapModel.instance:getSceneMo()
	local cloud = gohelper.findChild(self._cloudRes, "cloud")

	if cloud then
		local meshRender = cloud:GetComponent(typeof(UnityEngine.MeshRenderer))

		if meshRender then
			local material = meshRender.material

			if material then
				material:SetColor("_MainColor", cloudColor[scneMo.mapType] or Color())
			end
		end
	end

	self._pool = {}
	self._tweeningPos = {}
	self._tweenId = nil

	self:updateCloudShow(true)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.onScreenResize, self)
	TaskDispatcher.runRepeat(self._frameSetCloudOffset, self, 0, -1)
end

function SurvivalSceneCloudComp:onScreenResize()
	self:updateCloudShow()
end

local tempV3 = Vector3()

function SurvivalSceneCloudComp:_frameSetCloudOffset()
	local screenWidth = UnityEngine.Screen.width
	local screenHeight = UnityEngine.Screen.height

	tempV3:Set(screenWidth / 2, screenHeight / 2, 0)

	local pos1 = SurvivalHelper.instance:getScene3DPos(tempV3, 0)
	local pos2 = SurvivalHelper.instance:getScene3DPos(tempV3, SurvivalConst.CloudHeight)

	transformhelper.setLocalPos(self._cloudRoot.transform, pos2.x - pos1.x, SurvivalConst.CloudHeight, pos2.z - pos1.z)
end

function SurvivalSceneCloudComp:updateCloudShow(isForce, posTween, isOut)
	if not self._cloudRoot or not self._cloudRes then
		return
	end

	if posTween then
		for _, v in ipairs(posTween) do
			SurvivalHelper.instance:addNodeToDict(self._tweeningPos, v, isOut)
		end
	end

	local screenWidth = UnityEngine.Screen.width
	local screenHeight = UnityEngine.Screen.height

	self.v3:Set(screenWidth / 2, screenHeight / 2, 0)

	local screenCenterPos = SurvivalHelper.instance:getScene3DPos(self.v3)

	self._hex2:set(SurvivalHelper.instance:worldPointToHex(screenCenterPos.x, screenCenterPos.y, screenCenterPos.z))

	if not isForce and self._hex == self._hex2 then
		return
	end

	self._hex:copyFrom(self._hex2)

	for q, v in pairs(self._allClouds) do
		for r, cloudData in pairs(v) do
			cloudData.flag = true
		end
	end

	local width = 16
	local height = 16
	local width_half = width / 2
	local height_half = height / 2
	local index = 1

	for i = 0, width - 1 do
		for j = 0, height - 1 do
			local r = j - height_half
			local q = i - math.floor(r / 2) - width_half

			self._hex2:set(q + self._hex.q, r + self._hex.r)

			local isInFog = SurvivalMapModel.instance:isInFog2(self._hex2) or SurvivalHelper.instance:getValueFromDict(self._tweeningPos, self._hex2)

			if isInFog then
				if not SurvivalHelper.instance:getValueFromDict(self._allClouds, self._hex2) then
					self._allClouds[self._hex2.q] = self._allClouds[self._hex2.q] or {}

					local tempNode = SurvivalMapModel.instance:getCacheHexNode(index)

					tempNode:copyFrom(self._hex2)

					index = index + 1
					self._allClouds[self._hex2.q][self._hex2.r] = {
						hex = tempNode
					}
				else
					self._allClouds[self._hex2.q][self._hex2.r].flag = false
				end
			end
		end
	end

	for q, v in pairs(self._allClouds) do
		for r, cloudData in pairs(v) do
			if cloudData.flag then
				if self._tweeningPos[q] and self._tweeningPos[q][r] then
					transformhelper.setLocalScale(cloudData.go.transform, 1, 1, 1)
				end

				self:releaseInstGo(cloudData.go)

				v[r] = nil
			end
		end
	end

	for q, v in pairs(self._allClouds) do
		for r, cloudData in pairs(v) do
			if cloudData.hex then
				cloudData.go = self:getInstGo(cloudData.hex)
				cloudData.hex = nil
			end
		end
	end

	if posTween and not self._tweenId then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, SurvivalConst.PlayerMoveSpeed * 0.95, self._tweenCloudScale, self._tweenFinish, self)
	end
end

function SurvivalSceneCloudComp:_tweenCloudScale(value)
	for q, v in pairs(self._tweeningPos) do
		for r, isOut in pairs(v) do
			if self._allClouds[q] then
				local cloudData = self._allClouds[q][r]

				if cloudData then
					if isOut then
						if not (1 - value) then
							local scale = value

							transformhelper.setLocalScale(cloudData.go.transform, scale, scale, scale)
						end
					end
				end
			end
		end
	end
end

function SurvivalSceneCloudComp:_tweenFinish()
	for q, v in pairs(self._tweeningPos) do
		for r in pairs(v) do
			if self._allClouds[q] then
				if self._allClouds[q] then
					transformhelper.setLocalScale(self._allClouds[q].go.transform, 1, 1, 1)
					self._hex2:set(q, r)

					if not SurvivalMapModel.instance:isInFog2(self._hex2) then
						self:releaseInstGo(self._allClouds[q].go)
						SurvivalHelper.instance:removeNodeToDict(self._allClouds, self._hex2)
					end
				end
			end
		end
	end

	self._tweenId = nil
	self._tweeningPos = {}
end

function SurvivalSceneCloudComp:getInstGo(hexPoint)
	local go = table.remove(self._pool)

	if not go then
		go = gohelper.clone(self._cloudRes, self._cloudRoot, tostring(hexPoint))
	else
		go.name = tostring(hexPoint)
	end

	gohelper.setActive(go, true)

	local x, _, z = SurvivalHelper.instance:hexPointToWorldPoint(hexPoint.q, hexPoint.r)
	local trans = go.transform

	transformhelper.setLocalPos(trans, x, 0, z)

	return go
end

function SurvivalSceneCloudComp:releaseInstGo(go)
	if not go then
		return
	end

	if #self._pool > 200 then
		gohelper.destroy(go)

		return
	end

	gohelper.setActive(go, false)
	table.insert(self._pool, go)
end

function SurvivalSceneCloudComp:onSceneClose()
	TaskDispatcher.cancelTask(self._frameSetCloudOffset, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self.onScreenResize, self)
	gohelper.destroy(self._cloudRoot)

	self._cloudRoot = nil
	self._cloudRes = nil
	self._allClouds = nil
	self._pool = nil
	self._tweeningPos = {}

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return SurvivalSceneCloudComp
