-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameScene.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameScene", package.seeall)

local ArcadeGameScene = class("ArcadeGameScene")

function ArcadeGameScene:onEnterArcadeGame(isRestartGame)
	self:_clearComps()
	self:_clearScene()

	self._isRestartGame = isRestartGame

	local root = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = gohelper.create3d(root, ArcadeGameEnum.Const.GameSceneName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	self._sceneOffsetY = y

	self:_disposeSceneLoader()

	local gameSceneResName = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.GameSceneResName)
	local sceneUrl = ResUrl.getArcadeSceneRes(gameSceneResName)

	if not string.nilorempty(sceneUrl) then
		UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.LoadGameScene)

		local sceneAnimUrl = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.GameSceneAnimationControllerRes)
		local _resList = {
			sceneUrl,
			sceneAnimUrl
		}

		self._sceneLoader = MultiAbLoader.New()

		self._sceneLoader:setPathList(_resList)
		self._sceneLoader:startLoad(self._onLoadSceneFinish, self)
	end
end

function ArcadeGameScene:_onLoadSceneFinish()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.LoadGameScene)

	if not self._sceneLoader then
		return
	end

	local gameSceneResName = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.GameSceneResName)
	local sceneUrl = ResUrl.getArcadeSceneRes(gameSceneResName)
	local sceneAsset = self._sceneLoader:getAssetItem(sceneUrl)
	local sceneRes = sceneAsset and sceneAsset:GetResource(sceneUrl)

	if sceneRes then
		self._goScene = gohelper.clone(sceneRes, self._sceneRoot)
	end

	local animUrl = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.GameSceneAnimationControllerRes)
	local animAsset = self._sceneLoader:getAssetItem(animUrl)
	local animRes = animAsset and animAsset:GetResource(animUrl)

	if animRes then
		self._sceneAnimator = gohelper.onceAddComponent(self._sceneRoot, typeof(UnityEngine.Animator))
		self._sceneAnimator.runtimeAnimatorController = animRes
		self._sceneAnimator.enabled = true
	end

	self:_initScene()
end

function ArcadeGameScene:_initScene()
	self:_addComp("loader", ArcadeLoader)
	self:_addComp("roomMgr", ArcadeRoomMgr)
	self:_addComp("entityMgr", ArcadeEntityMgr, true)
	self:_addComp("effectMgr", ArcadeEffectMgr, true)
	self:_addComp("flyingEffectMgr", ArcadeFlyingEffectMgr, true)
	self:_disposePreGameStartFlow()

	self._preGameStartFlow = FlowSequence.New()

	self._preGameStartFlow:addWork(ArcadePreGameStartWork.New(self.entityMgr, ArcadeGameController.instance, ArcadeEvent.OnLoadFinishGameCharacter))

	local gameViewName = ViewName.ArcadeGameView
	local isOpen = ViewMgr.instance:isOpen(gameViewName)

	if not isOpen then
		self._preGameStartFlow:addWork(WaitEventWork.New("ViewMgr;ViewEvent;OnOpenView;" .. gameViewName))
	end

	self._preGameStartFlow:registerDoneListener(self._initSceneFinish, self)
	self._preGameStartFlow:start()
end

function ArcadeGameScene:_addComp(compName, compClass, useNewGO)
	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo((useNewGO or nil) and gohelper.create3d(self._sceneRoot, compName), compClass, {
		scene = self,
		compName = compName
	})

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeGameScene:_initSceneFinish()
	self:_disposePreGameStartFlow()
	ArcadeGameController.instance:startGame(self._isRestartGame)

	self._isRestartGame = nil
end

function ArcadeGameScene:checkNeedShake(effectId)
	local isNeedShake = ArcadeConfig.instance:getIsNeedShake(effectId)

	if isNeedShake then
		self:playShakeEff()
	end
end

function ArcadeGameScene:playShakeEff()
	if not self._sceneAnimator then
		return
	end

	self._sceneAnimator:Play("shake", 0, 0)
end

function ArcadeGameScene:onExitArcadeGame()
	self:_disposeSceneLoader()
	self:_disposePreGameStartFlow()
	self:_clearComps()
	self:_clearScene()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.LoadGameScene)
end

function ArcadeGameScene:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			local compName = comp:getCompName()

			self[compName] = nil

			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeGameScene:_clearScene()
	if self._goScene then
		gohelper.destroy(self._goScene)
	end

	self._goScene = nil

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)
	end

	self._sceneRoot = nil
end

function ArcadeGameScene:_disposeSceneLoader()
	if self._sceneLoader then
		self._sceneLoader:dispose()
	end

	self._sceneLoader = nil
end

function ArcadeGameScene:_disposePreGameStartFlow()
	if not self._preGameStartFlow then
		return
	end

	self._preGameStartFlow:unregisterDoneListener(self._initSceneFinish, self)
	self._preGameStartFlow:destroy()

	self._preGameStartFlow = nil
end

function ArcadeGameScene:getSceneRoot()
	return self._sceneRoot
end

function ArcadeGameScene:getSceneGO()
	return self._goScene
end

function ArcadeGameScene:getSceneOffsetY()
	return self._sceneOffsetY
end

return ArcadeGameScene
