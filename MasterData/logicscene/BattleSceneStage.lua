-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/BattleSceneStage.lua

module("logicscene.scene.component.stage.BattleSceneStage", package.seeall)

local BattleSceneStage = class("BattleSceneStage", SceneStageBase)
local isUsingNew = true
local DOWN_LOAD_PROGRESS_VALUE = 0
local LOADING_PROGRESS_VALUE = 1 - DOWN_LOAD_PROGRESS_VALUE
local FMOD_ASSETBUNDLE_PATH = "audio/fmod/"
local FMOD_AssetsName = ".assets"
local FMOD_StreamsName = ".streams"
local FMOD_ExtendName = ".bank"

function BattleSceneStage:ctor(scene)
	BattleSceneStage.super.ctor(self, scene)

	self._stageInst = nil
	self._resLoader = nil
	self._stageResUrl = nil

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if (Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode >= 1100 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode >= 1100 or Framework.OSDef.isEditor or nil) and true or BootstrapLauncher.instance.__VERSION and BootstrapLauncher.instance.__VERSION >= 1 then
		usingnow("bootstrap.BootstrapOnlineResMgr", "BootstrapOnlineResMgr")

		self._hasUpdateAndReload = false

		if BootstrapOnlineResMgr.instance.downloadFilesWithSize then
			self._hasUpdateAndReload = true
		end
	end
end

function BattleSceneStage:onEnterScene(sceneId)
	self._isSceneEntering = true

	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStoryPlayEnded, self)
	GlobalDispatcher:addListener(GlobalNotify.OnBattleRoundPush, self._onRoundPush, self)
end

function BattleSceneStage:onExitScene()
	self._isSceneEntering = nil
	self._loadListener = nil
	self._loadListenerObj = nil

	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStoryPlayEnded, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnBattleRoundPush, self._onRoundPush, self)
	BattleSceneStage.super.onExitScene(self)
end

function BattleSceneStage:_onRoundPush(round)
	if isUsingNew then
		self:_loadSkillAndLoadStage()
	end
end

function BattleSceneStage:startPreloadUnitsSkill(round)
	if isUsingNew then
		self:_loadSkillAndLoadStage()
	else
		self._scene.resPreLoad:startPreloadUnitsSkill()
	end
end

function BattleSceneStage:_loadSkillAndLoadStage()
	if not BattleModel.instance:checkHasBattleIdInitRound() or not BattleModel.instance.isRunning then
		return
	end

	BattleModel.instance:setSkillCheck(false)

	local resourcesList = {}
	local uniqueRecord = {}

	self._skillPathList = {}

	self:_getCharactorModelSkillResourcesWithRound(resourcesList, uniqueRecord)

	if not AMPlayer.takeWithBundle then
		local unloadTakes

		for i = 1, #resourcesList do
			if AMPlayer.IsTakeResLoaded(resourcesList[i]) then
				self:_initSkillMove(resourcesList[i])
			else
				unloadTakes = unloadTakes or {}

				table.insert(unloadTakes, resourcesList[i])
			end
		end

		if unloadTakes then
			self._scene.resQueue:pushResources(unloadTakes, function(loader)
				self:onSkillResourcesLoaded(loader)
				BattleModel.instance:setSkillCheck(true)
				self._scene.resPreLoad:startPreloadUnitsSkill()
			end)
		else
			BattleModel.instance:setSkillCheck(true)
			self._scene.resPreLoad:startPreloadUnitsSkill()
		end
	else
		for i = 1, #resourcesList do
			self:_initSkillMove(resourcesList[i], uniqueRecord, self._skillPathList)
		end

		BattleModel.instance:setSkillCheck(true)
		self._scene.resPreLoad:startPreloadUnitsSkill()
	end
end

function BattleSceneStage:getStageUrl()
	return self._stageResUrl
end

function BattleSceneStage:load(sceneId, loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj

	self:_loadStage()
	GlobalDispatcher:dispatch(GlobalNotify.SceneStartLoaded)
end

function BattleSceneStage:changeStage(stageUrl)
	self._stageResUrl = stageUrl

	self:_updateStageInst()
end

function BattleSceneStage:_getStageUrl()
	local battlePlace = BattleModel.instance.testBattleSceneName

	BattleModel.instance.testBattleSceneName = nil

	if not battlePlace then
		local bgName = BattleController.instance:getStageBgName()

		return GameUrl.getBattleStageUrl(bgName)
	end

	battlePlace = battlePlace or BattleModel.instance:getFightPlace()

	if not battlePlace or #battlePlace == 0 or battlePlace == "default" then
		return "scene/battle/xingkong/xingkong_p.prefab"
	end

	return GameUrl.getBattleStageUrl(battlePlace)
end

function BattleSceneStage:_loadStage()
	local resourcesList = {}
	local uniqueRecord = {}

	self._stageResUrl = self:_getStageUrl()

	BattleStagesMgr.instance:checkRemoveExceedStage(self._stageResUrl)
	self:_addNeedLoadResource(resourcesList, uniqueRecord, self._stageResUrl)

	local stlType = BattleSettlementModel.instance:getType()

	if stlType == BattleSettlementModel.Enum.ResCopy then
		local params = BattleSettlementModel.instance:getParams()
		local dItemPath = DropManager.instance:getDropItemPath(params.chapterId)

		if dItemPath then
			self:_addNeedLoadResource(resourcesList, uniqueRecord, dItemPath)
		end
	end

	if BattleController.instance.preloadModelsOnLoadScene then
		self:_getCharactorModelResources(resourcesList, uniqueRecord)
	end

	if isUsingNew then
		self:_loadSkillAndLoadStage()
	else
		self:_prepareSkillTakes(resourcesList, uniqueRecord)
	end

	self:_prepareBattleInterfaceSkinRes(resourcesList, uniqueRecord)

	if self._hasUpdateAndReload then
		DOWN_LOAD_PROGRESS_VALUE = 0.8
		LOADING_PROGRESS_VALUE = 1 - DOWN_LOAD_PROGRESS_VALUE

		local tempList = {}

		table.insertto(tempList, resourcesList)

		if self._skillPathList then
			if AudioPlayerEx.instance._audioCfg and AudioPlayerEx.instance._fmodMgr then
				local audioId = self._scene.bgm:getBgmId()
				local cfg = AudioPlayerEx.instance._audioCfg[audioId]

				if cfg then
					local bankName = AudioPlayerEx.instance._fmodMgr:GetBankNameByEvent(cfg.evtName)
					local fileName1 = FMOD_ASSETBUNDLE_PATH .. bankName .. FMOD_ExtendName
					local fileName2 = FMOD_ASSETBUNDLE_PATH .. bankName .. FMOD_AssetsName .. FMOD_ExtendName
					local fileName3 = FMOD_ASSETBUNDLE_PATH .. bankName .. FMOD_StreamsName .. FMOD_ExtendName

					self:_addNeedLoadResource(self._skillPathList, uniqueRecord, fileName1)
					self:_addNeedLoadResource(self._skillPathList, uniqueRecord, fileName2)
					self:_addNeedLoadResource(self._skillPathList, uniqueRecord, fileName3)
				end
			end

			table.insertto(tempList, self._skillPathList)
		end

		BootstrapOnlineResMgr.instance:downloadFilesWithSize(tempList, function()
			self._resLoader = MultiResLoader.New()

			self._resLoader:setResPaths(resourcesList)
			self._resLoader:load(self._onStageResourceLoaded, self._onResourceLoaded, self)
			self:_prepareLoadingQueue()
		end, function(res)
			local progress = res.curCount / res.totalCount

			self:_notifyLoadingProgress(progress * DOWN_LOAD_PROGRESS_VALUE)
		end)
	else
		self._resLoader = MultiResLoader.New()

		self._resLoader:setResPaths(resourcesList)
		self._resLoader:load(self._onStageResourceLoaded, self._onResourceLoaded, self)
		self:_prepareLoadingQueue()
	end
end

function BattleSceneStage:loadCharacterRes(finishHandler, handlerObj)
	local resourcesList = {}
	local uniqueRecord = {}

	self:_getCharactorModelResources(resourcesList, uniqueRecord)

	if isUsingNew then
		self:_loadSkillAndLoadStage()
	else
		self:_prepareSkillTakes(resourcesList, uniqueRecord)
	end

	self:_prepareBattleInterfaceSkinRes(resourcesList, uniqueRecord)

	if self._resLoader == nil then
		self._resLoader = MultiResLoader.New()
	else
		self._resLoader:clear()
	end

	if self._hasUpdateAndReload then
		local tempList = {}

		table.insertto(tempList, resourcesList)

		if self._skillPathList then
			table.insertto(tempList, self._skillPathList)
		end

		BootstrapOnlineResMgr.instance:downloadFilesWithSize(tempList, function()
			self._resLoader:setResPaths(resourcesList)
			self._resLoader:load(finishHandler, nil, handlerObj)
		end, function(res)
			return
		end)
	else
		self._resLoader:setResPaths(resourcesList)
		self._resLoader:load(finishHandler, nil, handlerObj)
	end
end

function BattleSceneStage:preloadSkillRes()
	self:_prepareLoadingQueue()
end

function BattleSceneStage:_prepareSkillTakes(resourcesList, uniqueRecord)
	if not AMPlayer.takeWithBundle then
		self:_getCharactorModelSkillResources(resourcesList, uniqueRecord)

		local unloadTakes

		for i = 1, #resourcesList do
			if AMPlayer.IsTakeResLoaded(resourcesList[i]) then
				self:_initSkillMove(resourcesList[i])
			else
				unloadTakes = unloadTakes or {}

				table.insert(unloadTakes, resourcesList[i])
			end
		end

		if unloadTakes then
			self._scene.resQueue:pushResources(unloadTakes, self.onSkillResourcesLoaded, self)
		end
	else
		resourcesList = {}
		uniqueRecord = {}

		self:_getCharactorModelSkillResources(resourcesList, uniqueRecord)

		for i = 1, #resourcesList do
			self:_initSkillMove(resourcesList[i])
		end
	end

	BattleModel.instance:setSkillCheck(true)
end

function BattleSceneStage:_prepareLoadingQueue()
	local resourcesList = {}
	local uniqueRecord = {}

	self:_prepareBattleStory(resourcesList, uniqueRecord)

	if #resourcesList > 0 then
		if self._hasUpdateAndReload then
			BootstrapOnlineResMgr.instance:downloadFilesWithSize(resourcesList, function()
				self._scene.resQueue:pushResources(resourcesList, self._onBattleStoryResourcesLoad, self)
			end)
		else
			self._scene.resQueue:pushResources(resourcesList, self._onBattleStoryResourcesLoad, self)
		end
	end
end

function BattleSceneStage:_getCharactorModelResources(resourcesList, uniqueRecord)
	local originalStates = BattleModel.instance.originalStates

	for k, v in pairs(originalStates.teams) do
		if v.playerView then
			local characterViews = v.playerView.characterViews

			self:_addCharactersNeedLoadResource(characterViews, resourcesList, uniqueRecord)

			local extCharacterViews = v.playerView.extCharacterViews

			self:_addCharactersNeedLoadResource(extCharacterViews, resourcesList, uniqueRecord)
		end
	end
end

function BattleSceneStage:_addCharactersNeedLoadResource(characterViews, resourcesList, uniqueRecord)
	for k1, v1 in ipairs(characterViews) do
		local modelCo = CharacterConfig.instance:getModelCo(v1.curFaceId)

		if modelCo then
			local url = GameUrl.getSpineUrl(modelCo.resName)

			self:_addNeedLoadResource(resourcesList, uniqueRecord, url)

			local url = GameUrl.getCharacterIconUrl(modelCo.headName)

			self:_addNeedLoadResource(resourcesList, uniqueRecord, url)
		end
	end
end

function BattleSceneStage:_prepareBattleStory(resourcesList, uniqueRecord)
	local storyData = BattleModel.instance.storyData

	if not storyData or not storyData.storyId or storyData.storyId == 0 then
		return
	end

	if storyData.mode == TaskConst.BattleStoryTrigger_Start or storyData.mode == TaskConst.BattleStoryTrigger_PetAttacke or storyData.mode == TaskConst.BattleStoryTrigger_Round then
		self._battleStoryId = storyData.storyId

		local storyCos = StoryConfig.instance:getStories(storyData.storyId)

		for i = 1, #storyCos do
			local storyCo = storyCos[i]

			if not StoryConst.isBgWithoutImage(storyCo.bgImg) then
				local texPath = StoryConst.StoryPath_BigImgBg .. storyCo.bgImg

				if not string.find(texPath, ".png") then
					texPath = texPath .. ".png"
				end

				self:_addNeedLoadResource(resourcesList, uniqueRecord, texPath)
			end

			local currStoryConfig = StoryConst.getStoryModelConfig(storyCo)

			if currStoryConfig then
				local resPath

				self:_addNeedLoadResource(resourcesList, uniqueRecord, string.find(currStoryConfig.id, ".png") and StoryConst.StoryPath_BigImg .. currStoryConfig.id or StoryConst.getSpineUrl(currStoryConfig.id))
			end
		end
	end
end

function BattleSceneStage:_getCharactorModelSkillResourcesWithRound(resourcesList, uniqueRecord)
	local rounds = BattleModel.instance.rounds
	local lastPetMap = {}

	for i = 1, #rounds do
		local round = rounds[i]

		if round.roundType == BattleRoundBase.Round then
			local result = round:getCharactorResult()

			if result then
				local skillId = result.skillId
				local characterId = result.caster.targetCharacterId
				local teamId = result.caster.targetTeamId
				local skinId = 0
				local view = BattleModel.instance:getCharactorById(teamId, characterId)

				if view then
					skinId = view.raceId

					if checknumber(view.curFaceId) > 0 then
						skinId = checknumber(view.curFaceId)
					end
				end

				local tem = skinId

				if lastPetMap[tem] then
					skinId = lastPetMap[tem]
				end

				if round._evts then
					for _, evt in ipairs(round._evts) do
						local rrr = evt.oneRoundCharacterResult
						local preTfsModelId, afterTfModelId

						if rrr.targetCharacterResults then
							for i = 1, #rrr.targetCharacterResults do
								local cR = rrr.targetCharacterResults[i]
								local sR = cR.targetNum.resultObjectSummary

								if sR and sR.transform then
									for k = 1, #sR.transform do
										local tR = sR.transform[k]
										local originSkinId = 0
										local originView = BattleModel.instance:getCharactorById(cR.target.targetTeamId, cR.target.targetCharacterId)

										if originView then
											originSkinId = originView.raceId

											if checknumber(originView.curFaceId) > 0 then
												originSkinId = checknumber(originView.curFaceId)
											end
										end

										lastPetMap[originSkinId] = tR.curFaceId

										if tR.oc == GameEnum.BattleOc.Beffore and originSkinId == skinId then
											skinId = lastPetMap[originSkinId]
										end
									end
								end
							end
						end
					end
				end

				self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, skillId, skinId)
			end
		end
	end
end

function BattleSceneStage:_getCharactorModelSkillResources(resourcesList, uniqueRecord)
	local originalStates = BattleModel.instance.originalStates
	local loadMap = {}

	for k, v in pairs(originalStates.teams) do
		if v.playerView then
			local characterViews = v.playerView.characterViews

			for k1, v1 in ipairs(characterViews) do
				if loadMap[v1.curFaceId] == nil then
					loadMap[v1.curFaceId] = true

					self:_addCharactorViewSkillResources(resourcesList, uniqueRecord, v1)
				end
			end

			local extCharacterViews = v.playerView.extCharacterViews

			for k1, v1 in ipairs(extCharacterViews) do
				if loadMap[v1.curFaceId] == nil then
					loadMap[v1.curFaceId] = true

					self:_addCharactorViewSkillResources(resourcesList, uniqueRecord, v1)
				end
			end
		end
	end
end

function BattleSceneStage:_addCharactorViewSkillResources(resourcesList, uniqueRecord, charactorview)
	local curFaceId = charactorview.curFaceId
	local petCO = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	if petCO then
		self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, charactorview.normalSkillId, curFaceId)
		self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, charactorview.ultimateSkillId, curFaceId)
		self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, charactorview.passiveSkillId, curFaceId)
		self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, charactorview.summonSkillId, curFaceId)
		self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, petCO.heroSkillId, curFaceId)
		self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, petCO.circleSkillId, curFaceId)
		self:_getCharactorModelSkillResource(resourcesList, uniqueRecord, petCO.enterSkillId, curFaceId)
		self:_getSpiritInvocationUIResource(resourcesList, uniqueRecord, petCO.spiritInvocationSkillId, curFaceId)
	end
end

function BattleSceneStage:_getCharactorModelSkillResource(resourcesList, uniqueRecord, skillId, skinId)
	if skillId == 0 then
		return
	end

	local take, takeFemale = BattleConfig.instance:getSkillAnimTake(skillId, skinId)

	if take and #take > 0 then
		for _, v in ipairs(take) do
			self:_addNeedLoadResource(resourcesList, uniqueRecord, v)
		end
	end

	if takeFemale and #takeFemale > 0 then
		for _, v in ipairs(takeFemale) do
			self:_addNeedLoadResource(resourcesList, uniqueRecord, v)
		end
	end
end

function BattleSceneStage:_getSpiritInvocationUIResource(resourcesList, uniqueRecord, skillId, skinId)
	if skillId == 0 then
		return
	end

	local spiritCfg = ContractConfig.instance:getSpiritInvocationCfg(skillId)

	if spiritCfg then
		self:_addNeedLoadResource(resourcesList, uniqueRecord, spiritCfg.headImgRes)
		self:_addNeedLoadResource(resourcesList, uniqueRecord, spiritCfg.uiEffectRes)
	end
end

function BattleSceneStage:onSkillResourcesLoaded(loader)
	local resources = loader:getResources()

	for k, v in pairs(resources) do
		self:initSkillTake(k)
	end
end

function BattleSceneStage:initSkillTake(path)
	AMPlayer.AddTakeResources(path)
	self:_initSkillMove(path)
end

function BattleSceneStage:_initSkillMove(path, uniqueRecord, resourcesList)
	local prefabs, fmodBanks, hasMoved = AMPlayer.GetTakeResources(path, nil, nil, nil)

	self._skillMoveTags = self._skillMoveTags or {}
	self._skillMoveTags[path] = hasMoved

	if resourcesList then
		if prefabs then
			local cnt = prefabs.Count - 1

			for i = 0, cnt do
				if prefabs[i] and #prefabs[i] > 0 and not uniqueRecord[prefabs[i]] then
					uniqueRecord[prefabs[i]] = true

					table.insert(resourcesList, prefabs[i])
				end
			end
		end

		if fmodBanks then
			local cnt = fmodBanks.Count - 1

			for i = 0, cnt do
				if fmodBanks[i] and #fmodBanks[i] > 0 then
					local bankName = fmodBanks[i]
					local fileName1 = FMOD_ASSETBUNDLE_PATH .. bankName .. FMOD_ExtendName
					local fileName2 = FMOD_ASSETBUNDLE_PATH .. bankName .. FMOD_AssetsName .. FMOD_ExtendName
					local fileName3 = FMOD_ASSETBUNDLE_PATH .. bankName .. FMOD_StreamsName .. FMOD_ExtendName

					self:_addNeedLoadResource(resourcesList, uniqueRecord, fileName1)
					self:_addNeedLoadResource(resourcesList, uniqueRecord, fileName2)
					self:_addNeedLoadResource(resourcesList, uniqueRecord, fileName3)
				end
			end
		end
	end
end

function BattleSceneStage:_onBattleStoryResourcesLoad(loader)
	self._storyLoader = loader
end

function BattleSceneStage:unload()
	if self._stageInst then
		goutil.setActive(self._stageInst, false)

		self._stageInst = nil
	end

	GameUtil.unloadMultiResLoaderResource(self._resLoader)
	self._scene.resPreLoad:clearAll()
	self._scene.resQueue:clearAll()

	self._resLoader = nil
	self._stageResUrl = nil
	self._stageInst = nil
	self._skillMoveTags = nil
	self._storyLoader = nil
	self._battleStoryId = nil
end

function BattleSceneStage:isSkillMoved(takeName)
	if self._skillMoveTags then
		return self._skillMoveTags[takeName]
	end
end

function BattleSceneStage:_onResourceLoaded(res)
	local progress = self._resLoader.loadedCount / self._resLoader.totalCount

	self:_notifyLoadingProgress(progress * LOADING_PROGRESS_VALUE + DOWN_LOAD_PROGRESS_VALUE)
end

function BattleSceneStage:_onStageResourceLoaded()
	BattleStagesMgr.instance:loadStage(self._stageResUrl, self._onStageCreated, self)
end

function BattleSceneStage:_onStageCreated()
	self:_updateStageInst()
	self:_onAllLoaded()
end

function BattleSceneStage:_updateStageInst()
	if not goutil.isNil(self._stageInst) then
		goutil.setActive(self._stageInst, false)
	end

	self._stageInst = BattleStagesMgr.instance:getStage(self._stageResUrl)

	if self._stageInst then
		goutil.addChildToParent(self._stageInst, self._scene:getContainer())
		goutil.setActive(self._stageInst, true)
	end
end

function BattleSceneStage:_onStoryPlayEnded(storyId)
	if storyId == self._battleStoryId and self._storyLoader then
		GameUtil.unloadMultiResLoaderResource(self._storyLoader)

		self._battleStoryId = nil
		self._storyLoader = nil
	end
end

function BattleSceneStage:_addNeedLoadResource(resourcesList, uniqueRecord, path)
	if not uniqueRecord[path] then
		uniqueRecord[path] = true

		table.insert(resourcesList, path)
	end
end

function BattleSceneStage:_onAllLoaded()
	if not self._isSceneEntering then
		return
	end

	self._isSceneEntering = nil

	self:_notifyLoadingProgress(1, true)

	if not self._loadListener then
		self:loadingDone()
	end
end

function BattleSceneStage:loadingDone()
	local groundCameraTarget = CameraTargetMgr.instance:getTargetByTag(SceneTag.GroundCamera)
	local groundCamera = groundCameraTarget:getCamera()

	groundCamera.fieldOfView = 15

	GameUtil.SetSceneAmbientColor(255, 255, 255)
	SceneMgr.instance:onEnterFinished()
	GMController.instance:showGM(true)
	self:dispatch(SceneNotify.StageLoaded)
end

function BattleSceneStage:_notifyLoadingProgress(progress, isFinished)
	if self._loadListener then
		if self._loadListenerObj then
			self._loadListener(self._loadListenerObj, progress, isFinished)
		else
			self._loadListener(progress, isFinished)
		end
	end
end

function BattleSceneStage:_prepareBattleInterfaceSkinRes(resourcesList, uniqueRecord)
	local skinId = BattleController.instance:getBattleUserInterfaceSkinId()

	UnitCompBattleUI.BattleDamages = CommonResPath.BattleDamages
	UnitCompBattleUI.BattleUITotalDamageTxtPath = CommonResPath.BattleUITotalDamageTxtPath
	UnitCompBattleUI.BattleUIDamageTxtPath = CommonResPath.BattleUIDamageTxtPath
	UnitCompBattleUI.BattleUIBuffDamage = CommonResPath.BattleUIBuffDamage
	UnitCompBattleUI.BattleBuffVigourText = CommonResPath.BattleBuffVigourText
	UnitCompBattleUI.BattleUIShieldTxtPath = CommonResPath.BattleUIShieldTxtPath

	if skinId > 1 then
		local BattleDamages = string.format("ui/views/battle/battle_damages_%s.prefab", skinId)
		local BattleUITotalDamageTxtPath = string.format("ui/views/battle/battleunitui_total_damage_txt_%s.prefab", skinId)
		local BattleUIDamageTxtPath = string.format("ui/views/battle/battleunitui_damage_txt_%s.prefab", skinId)
		local BattleUIBuffDamage = string.format("ui/views/battle/battleunitui_damage_text_txt_%s.prefab", skinId)
		local BattleBuffVigourText = string.format("ui/views/battle/battleunitui_vigour_txt_%s.prefab", skinId)

		UnitCompBattleUI.BattleDamages = BattleDamages
		UnitCompBattleUI.BattleUITotalDamageTxtPath = BattleUITotalDamageTxtPath
		UnitCompBattleUI.BattleUIDamageTxtPath = BattleUIDamageTxtPath
		UnitCompBattleUI.BattleUIBuffDamage = BattleUIBuffDamage
		UnitCompBattleUI.BattleBuffVigourText = BattleBuffVigourText
		UnitCompBattleUI.BattleUIShieldTxtPath = string.format("ui/views/battle/battleunitui_shield_txt_%s.prefab", skinId)

		self:_addNeedLoadResource(resourcesList, uniqueRecord, BattleDamages)
		self:_addNeedLoadResource(resourcesList, uniqueRecord, BattleUITotalDamageTxtPath)
		self:_addNeedLoadResource(resourcesList, uniqueRecord, BattleUIDamageTxtPath)
		self:_addNeedLoadResource(resourcesList, uniqueRecord, BattleUIBuffDamage)
		self:_addNeedLoadResource(resourcesList, uniqueRecord, BattleBuffVigourText)
		self:_addNeedLoadResource(resourcesList, uniqueRecord, UnitCompBattleUI.BattleUIShieldTxtPath)
	end
end

return BattleSceneStage
