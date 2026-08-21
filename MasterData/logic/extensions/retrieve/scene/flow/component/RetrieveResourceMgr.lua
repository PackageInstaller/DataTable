-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/flow/component/RetrieveResourceMgr.lua

module("logic.extensions.retrieve.scene.flow.component.RetrieveResourceMgr", package.seeall)

local M = class("RetrieveResourceMgr", ISceneFlowComp)

function M:onInit()
	self._resLoader = MultiResLoader.New()
	self._handler = Handler.New()
	self._wishCameras = {}
	self._heroLoader = MultiResLoader.New()
	self._allHeroInfo = {}
	self._heroInstMap = {}
end

function M:onEnter()
	self:_preloadBgRes()
	self._resLoader:addResPath(ResName.RetrieveWishCamera)
	self._resLoader:addResPath(IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_RetrieveMainView))
	self._resLoader:addResPath(IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language))
end

function M:_preloadBgRes()
	local bgMaps = {
		"jscjdd_bg_0001_s",
		"jscjdd_bg_0001_a",
		"jscjdd_bg_0001_b",
		"jscjdd_bg_0001_c"
	}

	for _, bgName in pairs(bgMaps) do
		local path = GameUrl.getRetrieveBigDynamic(bgName)

		self._resLoader:addResPath(path)
	end
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_RetrieveMainView)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Language)

	if self._wishCameraGo and not goutil.isNil(self._wishCameraGo) then
		goutil.destroy(self._wishCameraGo)

		self._wishCameraGo = false
	end

	self._wishCameras = false

	self._handler:clear()
	self._resLoader:clear()
	self._heroLoader:clear()

	if self._allHeroInfo then
		table.clear(self._allHeroInfo)
	end
end

function M:load(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self._onAllLoaded, false, self)
end

function M:setPrefabCallBack(callback, callbackSelf)
	self._prefabCallBack = callback
	self._prefabCallBackSelf = callbackSelf
end

function M:getResource(resPath)
	return self._resLoader:getResource(resPath)
end

function M:getInst(resPath)
	local res = self._resLoader:getResource(resPath)

	if res then
		return goutil.clone(res:GetMainAsset())
	end
end

function M:removeListener()
	self._handler:clear()
end

function M:_onAllLoaded()
	if not self._resLoader:isAllSuccess() then
		if enableErrorLog then
			printError("load resource failed!")
		end

		self._handler:call(false)

		return
	end

	self._handler:call(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_RetrieveMainView)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Language)
	self:_initWishCamera()
end

function M:_progressCallback(res, loadedCount, totalCount)
	if not res.IsSuccess and enableErrorLog then
		printError("load resource failed!", res.ResPath)
	end
end

function M:_onAllPrefabLoaded()
	if self._prefabCallBack then
		self._prefabCallBack(self._prefabCallBackSelf)
	end
end

function M:_initWishCamera()
	self._wishCameraGo = self:getInst(ResName.RetrieveWishCamera)

	local container = self._flow.unitFactory:getContainer()

	goutil.addChildToParent(self._wishCameraGo, container)

	for i = 0, self._wishCameraGo.transform.childCount - 1 do
		local child = self._wishCameraGo.transform:GetChild(i).gameObject

		table.insert(self._wishCameras, child)
	end
end

function M:getWishCamera()
	return self._wishCameras
end

function M:preloadHeroList(respathList)
	self._heroLoader:clear()

	if self._allHeroInfo then
		table.clear(self._allHeroInfo)
	end

	for i, resInfo in ipairs(respathList) do
		self._heroLoader:addResPath(resInfo.modelUrl)
		self._heroLoader:addResPath(resInfo.clipUrl)
		self._heroLoader:addResPath(resInfo.headUrl)
		self._heroLoader:addResPath(resInfo.timelineUrl)

		if resInfo then
			local model = {
				code = resInfo.heroId,
				url = resInfo.modelUrl,
				index = resInfo.index
			}

			table.insert(self._allHeroInfo, model)
		end
	end

	self._heroLoader:load(self._onAllHeroLoaded, self._heroProgressCallback, self)
end

function M:_heroProgressCallback(res, loadedCount, totalCount)
	if IsInEditorMode then
		printInfo("Retrieve Hero Load Progress", loadedCount, totalCount)
	end
end

function M:_onAllHeroLoaded()
	if not self._heroLoader:isAllSuccess() and IsInEditorMode and enableErrorLog then
		printError("角色预加载资源出现错误，表现抽卡中断，不影响实际结果。")
	end

	for i, heroInfo in ipairs(self._allHeroInfo) do
		local index = heroInfo.index
		local modelUrl = heroInfo.url
		local heroId = heroInfo.code

		if not self._heroInstMap[index] then
			local modelRes = self:getHeroResource(modelUrl)
			local heroAsset = modelRes:GetMainAsset()
			local go = goutil.clone(heroAsset)
			local container = self._flow.unitFactory:getContainer()

			goutil.addChildToParent(go, container)
			Astral.TransformUtil.SetLocalPos(go.transform, 0, -10000, -10000)
			Astral.TransformUtil.SetLocalRotation(go.transform, 0, 180, 0)

			local characterCO = CharacterConfig.instance:getCfgInfoByID(heroInfo.code)
			local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)
			local idleAnimClip = GameUrl.getMainSceneMeshModelClipUrl(modelCO.mainSceneResName, MainPerformEnum.AnimFullName.ChoukaIdle)
			local animationPlayer = AnimationPlayer.Get(go)
			local animClipRes = self:getHeroResource(idleAnimClip)
			local animaName = MainPerformEnum.AnimFullName.ChoukaIdle

			if animClipRes then
				animationPlayer:ContainsAnimation(animaName)

				local animClip = animClipRes:GetMainAsset()

				animationPlayer:ReplaceClip(animaName, animClip)
				animationPlayer:PlayAnimation(animaName, true, true)
				animationPlayer:Evaluate()
			end

			self._heroInstMap[index] = go
		end
	end

	ViewBlackFadeController.instance:hideGadget(0.3, 0, "pre load hero res finish")
	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Begin_Show_Lottery)
end

function M:getHeroResource(resPath)
	return self._heroLoader:getResource(resPath)
end

function M:getHeroGo(index)
	return self._heroInstMap and self._heroInstMap[index] or false
end

function M:clearHero()
	for i, goHero in pairs(self._heroInstMap) do
		if goHero and not goutil.isNil(goHero) then
			goutil.destroy(goHero)
		end
	end

	table.clear(self._heroInstMap)
end

return M
