require "FSM"
require "GameFlowState"

---@class GameState : FSMState
local GameState = FSMState:new("GameState", GameFlowState.GameState)

function GameState:enter()
	print("!!!!!!!!!!!!!!!!!!!!!!!GameState:enter")
	-- QualitySettingsMgr:Init()
	--资源预加载
	self.preloadIndex = 0
	self.preloadNum = 0

	--预加载所有角色资源
	-- local heroList = ClientData:GetRoleList()
	-- self.preloadNum = self.preloadNum + tablex.size(heroList)
	-- for k, hero in pairs(heroList) do
	-- 	local skinConfig = Config.GetCharacterSkinInfo(hero.equipSkin)
	-- 	if skinConfig then
	-- 		PoolMgr:Preload(string.format(Config.PrefabPath.RoleModelPrefab, skinConfig.modelKey, skinConfig.modelKey), 1, function ()
	-- 			self:preloadRes()
	-- 		end)
	-- 	else
	-- 		self:preloadRes()
	-- 	end
	-- end

	self:preloadFinish()
end

function GameState:preloadRes(callback)
	LoadingMgr:UpdateProgress(self.preloadIndex/self.preloadNum/2)
	self.preloadIndex = self.preloadIndex + 1
	if (self.preloadIndex >= self.preloadNum) then
		self:preloadFinish(callback)
	end
end


function GameState:preloadFinish(callback)
	self.baseCamera = UnityEngine.GameObject.Find("BaseCamera")
	if self.baseCamera then
		self.baseCamera.gameObject:SetActive(false)
	end
	local endFunc = function()
		--有家园剧情时直接进入家园场景
		if StoryMgr:getNowHomeStoryArraryId() ~= nil then
			UIMgr:clearUIDataGroup(UIGroup.Main)
			UIMgr:switchUIDataGroup(UIGroup.Main)
			UIMgr:clearAllUI(true)
			local CoveManager = require "CoveManager"
			local coveMgr = CoveManager.instance()
			coveMgr:initCove()
			local data = {
				mode = 2,--家园 
			}
			UIMgr:popUIBase("MainPanel", data, nil, nil, nil, function()
				LuaLogger.ds("GameState:preloadFinish MainPanel callback", debug.traceback())
				LoadingMgr:SetLoadingOver(nil, nil, "GameState")
			end)
			if callback then
				callback()
			end
			return
		end
		UIMgr:switchUIDataGroup(UIGroup.Main)
		local CoveManager = require "CoveManager"
		local coveMgr = CoveManager.instance()
		coveMgr:initCove()
		LuaLogger.ds("[loading 80%] pop MainPanel start")
		UIMgr:popUIBase("MainPanel", nil, nil, nil, nil, function()
			LuaLogger.ds("GameState:preloadFinish MainPanel callback", debug.traceback())

			LuaLogger.ds("[loading 80%] pop MainPanel end")
			LoadingMgr:SetLoadingOver(nil, nil, "GameState2")
		end)
		if callback then
			callback()
		end
	end
	if self.loadSceneTimer then
		DLuaTimer:RemoveTimer(self.loadSceneTimer)
	end
	--加载场景
	-- local asyncOperation = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync("Homeland")
	-- LuaLogger.ds("GameState:preloadFinish LoadSceneAsync", asyncOperation)
	-- if asyncOperation then
	-- 	self.loadSceneTimer = DLuaTimer:DoRepeatForever(0.1, function()
	-- 		--进度条
	-- 		LoadingMgr:UpdateProgress(0.5 + asyncOperation.progress/2)
	-- 		if (asyncOperation.isDone) then
	-- 			endFunc()
	-- 			DLuaTimer:RemoveTimer(self.loadSceneTimer)
	-- 		end
	-- 	end)
	-- else
	-- 	endFunc()
	-- end
	local progress = 0.5
	self.loadSceneTimer = DLuaTimer:DoRepeatForever(0.1, function()
		--进度条
		progress = math.min(progress + 0.01, 1)
		LoadingMgr:UpdateProgress(progress)
	end)
	LuaLogger.ds("[loading 80%] LoadScene Homeland start")
	ResMgr:LoadSceneAsyncLua(Config.ScenePath.HomelandScene, false, function(sceneName)
		LuaLogger.ds("[loading 80%] LoadScene Homeland end")
		endFunc()
		DLuaTimer:RemoveTimer(self.loadSceneTimer)
	end)
end


function GameState:update()

end

function GameState:exit()
	print("!!!!!!!!!!!!!!!!!!!!!!!GameState:exit")
	local CoveManager = require "CoveManager"
	local coveMgr = CoveManager.instance()
	coveMgr:clear()

	if self.baseCamera then
		self.baseCamera.gameObject:SetActive(true)
	end
	ClientData:PauseSyncServerTime()

	UIMgr:clearAllUI(false)
	UIMgr:ClearLoader()
	PoolMgr:Clear()
	SeaMapMgr:Clear()
	-- AssetManager.Instance:UnloadUnusedAssets()
	-- ResMgr:UnloadUnusedBundles(true)
end

return GameState