-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsStarburst.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsStarburst", package.seeall)

local StoryBgEffsStarburst = class("StoryBgEffsStarburst", StoryBgEffsBase)

function StoryBgEffsStarburst:ctor()
	StoryBgEffsStarburst.super.ctor(self)
end

function StoryBgEffsStarburst:init(bgCo)
	StoryBgEffsStarburst.super.init(self, bgCo)

	local starburstid = bgCo.effDegree
	local burstCo = StoryConfig.instance:getStoryStarburstConfig(starburstid)

	self._starMeshPath = string.format("ui/assets/story_particle_shape/%s.asset", burstCo.meshpath)
	self._starPrefabPath = string.format("effects/prefabs/story/%s.prefab", burstCo.effpath)

	table.insert(self._resList, self._starMeshPath)
	table.insert(self._resList, self._starPrefabPath)

	self._effLoaded = false
end

function StoryBgEffsStarburst:start(callback, callbackObj)
	StoryBgEffsStarburst.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
end

function StoryBgEffsStarburst:onLoadFinished()
	StoryBgEffsStarburst.super.onLoadFinished(self)

	self._effLoaded = true

	StoryTool.enablePostProcess(true)

	local meshAssetItem = self._loader:getAssetItem(self._starMeshPath)
	local starMesh = meshAssetItem:GetResource(self._starMeshPath)
	local prefabAssetItem = self._loader:getAssetItem(self._starPrefabPath)
	local starGo = prefabAssetItem:GetResource(self._starPrefabPath)
	local frontBgGo = StoryViewMgr.instance:getStoryFrontBgGo()

	self._goPts = gohelper.clone(starGo, frontBgGo)

	local list = self._goPts:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for i = 0, list.Length - 1 do
		local pts = list[i]

		pts.shape.shapeType = UnityEngine.ParticleSystemShapeType.Mesh
		pts.shape.mesh = starMesh
	end
end

function StoryBgEffsStarburst:reset(bgCo)
	StoryBgEffsStarburst.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end
end

function StoryBgEffsStarburst:destroy()
	if self._goPts then
		gohelper.destroy(self._goPts)

		self._goPts = nil
	end

	StoryBgEffsStarburst.super.destroy(self)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsStarburst
