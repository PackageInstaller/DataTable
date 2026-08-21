-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\SceneManager.lua

local ResScene = require("ClientData/ResScene")
local EventConst = require("EventConst")
local ImageEffectMgr = Framework.EffectSystem.ImageEffectManager
local ArenaRankBillBoard = require("Logic/PVP/ArenaRankBillBoard")
local TopPvpRankBillBoard = require("Logic/PVP/TopPvpRankBillBoard")
local DeviceHelper = require("Helper/DeviceHelper")
local SceneManager = {}
local self = SceneManager

self._id2Path = {}
self._path2Load = {}

function SceneManager.getScenePath(sceneID)
	local scenePath = self._id2Path[sceneID]

	if scenePath == nil and sceneID ~= Const.NO_STATE_SCENE and sceneID ~= nil then
		local sceneData = ResScene[sceneID]

		scenePath = sceneData.path
		self._id2Path[sceneID] = scenePath
	end

	return scenePath
end

function SceneManager.getDoLoad(sceneID)
	if sceneID == Const.NO_STATE_SCENE then
		return
	end

	local scenePath = self.getScenePath(sceneID)
	local doLoad = self._path2Load[scenePath]

	if doLoad == nil then
		local DoLoadScene = require("System/Load/DoLoadScene")

		doLoad = DoLoadScene(self, scenePath)
		self._path2Load[scenePath] = doLoad
	end

	return doLoad
end

function SceneManager.isSameScene(id1, id2)
	if id1 == id2 or self.getScenePath(id1) == self.getScenePath(id2) then
		return true
	end

	return false
end

function SceneManager.loadScene(tgtSceneID, sceneFinishCallBack, loadinguiName)
	LoadManager.clear()
	self.addLoadScene(tgtSceneID, sceneFinishCallBack)
	LoadManager.start(nil, loadinguiName)
end

function SceneManager.addLoadScene(tgtSceneID, sceneFinishCallBack)
	self.tgtSceneID = tgtSceneID
	self.sceneFinishCallBack = sceneFinishCallBack

	if self._doLoading then
		local phase = LoadManager.addLoadPhase(self._doLoading)

		phase.mRunning = true

		if self._doLoading.mIsLoad then
			if self.isSameScene(self._doLoading.mSceneID, tgtSceneID) then
				self._doLoading.mSceneID = tgtSceneID
			else
				self._doLoading.mLoadedAndUnload = true

				if tgtSceneID ~= Const.NO_STATE_SCENE then
					local doLoad = SceneManager.getDoLoad(tgtSceneID)

					doLoad.mIsLoad = true
					doLoad.mSceneID = tgtSceneID

					LoadManager.addLoadPhase(doLoad)
				end
			end
		end
	else
		if self.mCurSceneID ~= nil and not self.isSameScene(self.mCurSceneID, tgtSceneID) then
			local doUnLoad = SceneManager.getDoLoad(self.mCurSceneID)

			doUnLoad.mIsLoad = false

			LoadManager.addLoadPhase(doUnLoad)
		end

		if tgtSceneID ~= Const.NO_STATE_SCENE then
			local doLoad = SceneManager.getDoLoad(tgtSceneID)

			doLoad.mSceneID = tgtSceneID

			if self.mCurSceneID and self.isSameScene(self.mCurSceneID, tgtSceneID) then
				self.onDoSceneEnd(doLoad)
			else
				doLoad.mIsLoad = true

				LoadManager.addLoadPhase(doLoad)
			end
		end
	end
end

function SceneManager.onDoSceneStart(doLoad)
	self._doLoading = doLoad
end

function SceneManager.onDoSceneEnd(doLoad)
	self._doLoading = nil

	if doLoad.mIsLoad then
		self.mCurSceneID = doLoad.mSceneID

		if self.mCurSceneID == self.tgtSceneID then
			CueManager.applySceneImageEffects(Const.SCENE_PPB_DEFAULT)
			DynamicSceneManager.clear()
			DeviceHelper.resetGCTimer()

			if self.sceneFinishCallBack then
				self.sceneFinishCallBack()
			end

			EventCenter.sendEvent(EventConst.SCENE_LOADED, self.tgtSceneID)
		end
	elseif self.mCurSceneID == doLoad.mSceneID then
		self.mCurSceneID = nil
	end
end

local RainyScene = {
	["Scenes/Battles/battle_yuye_01.unity"] = true
}

function SceneManager.isCurSceneRainy(...)
	if not self.mCurSceneID then
		return false
	end

	local path = self.getScenePath(self.mCurSceneID)

	if path and RainyScene[path] then
		return true
	else
		return false
	end
end

function SceneManager.initArenaRank()
	if self.rankBB then
		self.rankBB:clear()
	else
		self.rankBB = ArenaRankBillBoard()
	end

	self.rankBB:initBillBoard()
	self.rankBB:setRankDisplay()
end

function SceneManager.refreshArenaRank(...)
	if not self.rankBB or not self.rankBB.bbGO or tolua.isnull(self.rankBB.bbGO) then
		SceneManager.initArenaRank()
	else
		self.rankBB:setRankDisplay()
	end
end

function SceneManager.initTopPvpRank(...)
	if self.rankTopPvp then
		self.rankTopPvp:clear()
	else
		self.rankTopPvp = TopPvpRankBillBoard()
	end

	self.rankTopPvp:initBillBoard()
	self.rankTopPvp:setRankDisplay()
end

function SceneManager.refreshTopPvpRank(...)
	if not self.rankTopPvp or not self.rankTopPvp.bbGO or tolua.isnull(self.rankTopPvp.bbGO) then
		SceneManager.initTopPvpRank()
	else
		self.rankTopPvp:setRankDisplay()
	end
end

return SceneManager
