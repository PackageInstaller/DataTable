-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/scene/Va3ChessStoryReviewScene.lua

module("modules.logic.versionactivity1_3.va3chess.game.scene.Va3ChessStoryReviewScene", package.seeall)

local Va3ChessStoryReviewScene = class("Va3ChessStoryReviewScene", BaseViewExtended)

function Va3ChessStoryReviewScene:onInitView()
	self._viewAnimator = self.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

Va3ChessStoryReviewScene.BLOCK_KEY = "Va3ChessGameSceneLoading"

function Va3ChessStoryReviewScene:onDestroyView()
	self:_clearRes()
end

function Va3ChessStoryReviewScene:onOpen()
	self.addEventCb(self, Va3ChessController.instance, Va3ChessEvent.StoryReviewSceneActvie, self.showScene, self)
end

function Va3ChessStoryReviewScene:onClose()
	UIBlockMgr.instance:endBlock(Va3ChessStoryReviewScene.BLOCK_KEY)
	TaskDispatcher.cancelTask(self._onDelayClearRes, self)
end

function Va3ChessStoryReviewScene:showScene(show, mapPath)
	if show then
		if self._sceneActive then
			self:_clearRes()
		end

		self._sceneActive = true
		self._mapPath = mapPath

		self:createSceneRoot()
		self:loadRes()
	end
end

function Va3ChessStoryReviewScene:resetOpenAnim()
	if self._viewAnimator then
		self._viewAnimator:Play(self._sceneActive and "switch" or "open", 0, 0)
	end

	self._sceneActive = false

	self:_clearRes()
end

function Va3ChessStoryReviewScene:_clearRes()
	self:releaseRes()
	self:disposeSceneRoot()
end

function Va3ChessStoryReviewScene:loadRes()
	UIBlockMgr.instance:startBlock(Va3ChessStoryReviewScene.BLOCK_KEY)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getCurrentSceneUrl())
	self._loader:startLoad(self.loadResCompleted, self)
end

function Va3ChessStoryReviewScene:getCurrentSceneUrl()
	if self._mapPath then
		return string.format(Va3ChessEnum.SceneResPath.SceneFormatPath, self._mapPath)
	else
		return Va3ChessEnum.SceneResPath.DefaultScene
	end
end

function Va3ChessStoryReviewScene:loadResCompleted(loader)
	local assetItem = loader:getAssetItem(self:getCurrentSceneUrl())

	if assetItem then
		self._sceneGo = gohelper.clone(assetItem:GetResource(), self._sceneRoot, "scene")
		self._sceneEffect1 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/vx_click_quan")
		self._sceneEffect2 = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse/vx_click_eye")

		if self._sceneEffect1 and not gohelper.isNil(self._sceneEffect1) then
			gohelper.setActive(self._sceneEffect1, false)
			gohelper.setActive(self._sceneEffect2, false)
		end
	end

	UIBlockMgr.instance:endBlock(Va3ChessStoryReviewScene.BLOCK_KEY)
end

function Va3ChessStoryReviewScene:releaseRes()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function Va3ChessStoryReviewScene:createSceneRoot()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("StoryReviewScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, -10)

	self._sceneOffsetY = y

	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function Va3ChessStoryReviewScene:disposeSceneRoot()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end

	self._sceneGo = nil
end

function Va3ChessStoryReviewScene:playEnterAnim()
	if self._sceneAnim then
		self._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

return Va3ChessStoryReviewScene
