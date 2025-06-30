-- chunkname: @IQIGame\\Module\\Story\\StoryCharacterMoveConfigManager.lua

local StoryCharacterMoveConfigManager = {}

function StoryCharacterMoveConfigManager.New(gameObject)
	local obj = Clone(StoryCharacterMoveConfigManager)

	obj:Init(gameObject)

	return obj
end

function StoryCharacterMoveConfigManager:Init(view)
	self.gameObject = view
	self.transform = view.transform
	self.obstaclesForAllTransform = self.transform:Find("ObstaclesForAll")
	self.obstaclesForPlayerTransform = self.transform:Find("ObstaclesForPlayer")
	self.obstaclesForPlayerChildrenTable = {}

	if self.obstaclesForPlayerTransform ~= nil then
		LuaUtility.SetTransGameObjectShow(self.obstaclesForPlayerTransform, true)

		local obstacles = self.obstaclesForPlayerTransform:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.Story.StoryPlayerObstacle))
		local obstaclesCount = obstacles.Length
		local storyPlayerObstacle, obstacleName

		for i = 0, obstaclesCount - 1 do
			storyPlayerObstacle = obstacles[i]

			if storyPlayerObstacle.ObstacleName ~= "" then
				LuaUtility.SetTransGameObjectShow(storyPlayerObstacle.transform, false)
				storyPlayerObstacle:Init()

				obstacleName = storyPlayerObstacle.ObstacleName

				if self.obstaclesForPlayerChildrenTable[obstacleName] == nil then
					self.obstaclesForPlayerChildrenTable[obstacleName] = {}
				end

				table.insert(self.obstaclesForPlayerChildrenTable[obstacleName], storyPlayerObstacle.transform)
			end
		end
	end

	self:AddListeners()

	self.isInitialized = true
end

function StoryCharacterMoveConfigManager:AddListeners()
	return
end

function StoryCharacterMoveConfigManager:RemoveListeners()
	return
end

function StoryCharacterMoveConfigManager:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function StoryCharacterMoveConfigManager:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function StoryCharacterMoveConfigManager:Dispose()
	self:RemoveListeners()

	for key, _ in pairs(self.obstaclesForPlayerChildrenTable) do
		for key2, _ in pairs(self.obstaclesForPlayerChildrenTable[key]) do
			self.obstaclesForPlayerChildrenTable[key][key2] = nil
		end

		self.obstaclesForPlayerChildrenTable[key] = nil
	end

	self.obstaclesForPlayerChildrenTable = nil

	if self.gameObject then
		GameObject.Destroy(self.gameObject)

		self.gameObject = nil
	end

	self.transform = nil
	self.obstaclesForAllTransform = nil
	self.obstaclesForPlayerTransform = nil
end

function StoryCharacterMoveConfigManager:SetObstacleForPlayerEnable(obstacleName, isEnable)
	if self.isInitialized then
		local targetObstacleTable = self.obstaclesForPlayerChildrenTable[obstacleName]

		if targetObstacleTable ~= nil then
			for _, obstacleTransform in pairs(targetObstacleTable) do
				LuaUtility.SetTransGameObjectShow(obstacleTransform, isEnable)
			end

			return true
		else
			logError("StoryCharacterMoveConfigManager:SetObstacleForPlayerEnable: 无法找到名为{0}的障碍物，请检查Hierarchy内是否有ObstacleName={1}的障碍物物体，或行为树节点参数是否正确.", obstacleName, obstacleName)
		end
	else
		logError("StoryCharacterMoveConfigManager: Manager haven't Initialize.")
	end

	return false
end

return StoryCharacterMoveConfigManager
