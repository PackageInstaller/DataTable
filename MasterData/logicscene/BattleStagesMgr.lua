-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/BattleStagesMgr.lua

module("logicscene.scene.BattleStagesMgr", package.seeall)

local BattleStagesMgr = class("BattleStagesMgr")

function BattleStagesMgr:ctor()
	self._stagesCache = {}
	self._loadingStages = {}
	self._capacity = 3
end

function BattleStagesMgr:loadStage(stageUrl, loadCallback, loadCallbackObj)
	if self._stagesCache[stageUrl] then
		self._stagesCache[stageUrl].time = UnityEngine.Time.realtimeSinceStartup

		if loadCallback then
			loadCallback(loadCallbackObj)
		end
	else
		if loadCallback then
			self._loadingStages[stageUrl] = self._loadingStages[stageUrl] or {}

			local loadingCfgs = self._loadingStages[stageUrl]

			table.insert(loadingCfgs, {
				loadCallback = loadCallback,
				loadCallbackObj = loadCallbackObj
			})
		end

		getres(stageUrl, self._onStageResLoaded, self, ResType.AssetBunble, true)
	end
end

function BattleStagesMgr:_onStageResLoaded(res)
	local resPath = res.ResPath
	local mainAsset = res:GetMainAsset()
	local go = mainAsset and goutil.clone(mainAsset) or UnityEngine.GameObject.New()

	go:SetActive(false)
	self:addStage(resPath, go, res)

	local loadingCfgs = self._loadingStages[resPath]

	for i = 1, #loadingCfgs do
		if loadingCfgs[i].loadCallback then
			loadingCfgs[i].loadCallback(loadingCfgs[i].loadCallbackObj)
		end
	end

	self._loadingStages[resPath] = nil
end

function BattleStagesMgr:addStage(stageUrl, gameObject, res)
	self._stagesCache[stageUrl] = {
		gameObject = gameObject,
		time = UnityEngine.Time.realtimeSinceStartup,
		res = res
	}

	res:Retain()
end

function BattleStagesMgr:getStage(stageUrl)
	if self._stagesCache[stageUrl] then
		return self._stagesCache[stageUrl].gameObject
	end
end

function BattleStagesMgr:removeStage(stageUrl)
	removeresl(stageUrl, self._onStageResLoaded, self)

	self._loadingStages[stageUrl] = nil

	local cache = self._stagesCache[stageUrl]

	if not goutil.isNil(cache.gameObject) then
		goutil.destroy(cache.gameObject)
	end

	local res = cache.res

	if res then
		res:Release()
	end

	self._stagesCache[stageUrl] = nil
end

function BattleStagesMgr:clear()
	self:clearExcept()
end

function BattleStagesMgr:clearExcept(exceptUrl)
	local temp = {}

	table.merge(temp, self._stagesCache)

	for k, v in pairs(temp) do
		if k ~= exceptUrl then
			self:removeStage(k)
		end
	end
end

function BattleStagesMgr:checkRemoveExceedStage(stageUrl)
	if table.nums(self._stagesCache) >= self._capacity and not self._stagesCache[stageUrl] then
		self:removeExceedStage(true)
	end
end

function BattleStagesMgr:removeExceedStage(force)
	if force or table.nums(self._stagesCache) > self._capacity then
		local minTime = math.huge
		local removeKey

		for k, v in pairs(self._stagesCache) do
			if minTime > v.time then
				minTime = v.time
				removeKey = k
			end
		end

		if removeKey then
			self:removeStage(removeKey)
		end
	end
end

function BattleStagesMgr:removeUnusedStages()
	local exceptUrl
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

	self:clearExcept((battleScene and battleScene.stage and battleScene.stage.getStageUrl or nil) and battleScene.stage:getStageUrl())
end

BattleStagesMgr.instance = BattleStagesMgr.New()

return BattleStagesMgr
