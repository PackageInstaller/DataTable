-- chunkname: @modules/logic/versionactivity3_6/yami/view/scene/V3a6YaMiScene.lua

module("modules.logic.versionactivity3_6.yami.view.scene.V3a6YaMiScene", package.seeall)

local V3a6YaMiScene = class("V3a6YaMiScene")

function V3a6YaMiScene:onEnterScene(isReturn)
	self._isReturn = isReturn

	if gohelper.isNil(self._sceneRoot) then
		local root = CameraMgr.instance:getSceneRoot()

		self._sceneRoot = gohelper.create3d(root, V3a6YaMiSceneEnum.SceneRootName)

		local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
		local _, y, _ = transformhelper.getLocalPos(mainTrans)

		transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
		self:_disposeSceneLoader()

		if gohelper.isNil(self.go) then
			local sceneUrl = ResUrl.getDungeonMapRes(V3a6YaMiSceneEnum.SceneResPath)

			self._deskTb = {}

			if not string.nilorempty(sceneUrl) then
				UIBlockMgr.instance:startBlock(V3a6YaMiSceneEnum.LoadScene)

				self._sceneLoader = MultiAbLoader.New()

				self._sceneLoader:addPath(sceneUrl)

				for i = 1, 2 do
					self._deskTb[i] = {}

					local deskPath = self:_getDestPath(i)

					self._sceneLoader:addPath(deskPath)
				end

				self._sceneLoader:startLoad(self._onLoadSceneFinish, self)
			end
		end
	end
end

function V3a6YaMiScene:_onLoadSceneFinish()
	UIBlockMgr.instance:endBlock(V3a6YaMiSceneEnum.LoadScene)

	if not self._sceneLoader then
		return
	end

	local sceneUrl = ResUrl.getDungeonMapRes(V3a6YaMiSceneEnum.SceneResPath)
	local sceneAsset = self._sceneLoader:getAssetItem(sceneUrl)
	local sceneRes = sceneAsset and sceneAsset:GetResource(sceneUrl)

	if sceneRes then
		self.go = gohelper.clone(sceneRes, self._sceneRoot)

		transformhelper.setLocalPos(self.go.transform, -16, 7, 3.6)
		gohelper.setActive(self.go, self._isReturn)
	end

	for i = 1, 2 do
		local deskPath = self:_getDestPath(i)
		local deskAsset = self._sceneLoader:getAssetItem(deskPath)
		local deskRes = deskAsset and deskAsset:GetResource(deskPath)

		if deskRes then
			local root = gohelper.findChild(self.go, "root/desk/desk" .. i)
			local deskGo = gohelper.clone(deskRes, root)

			gohelper.setActive(deskGo, self._isReturn)

			self._deskTb[i].go = deskGo
		end
	end

	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onFinishLoadScene)
end

function V3a6YaMiScene:showScene()
	gohelper.setActive(self.go, true)

	if self._deskTb then
		for _, desk in pairs(self._deskTb) do
			gohelper.setActive(desk.go, true)
		end
	end
end

function V3a6YaMiScene:onExitScene()
	self:_disposeSceneLoader()
	self:_clearScene()
	UIBlockMgr.instance:endBlock(V3a6YaMiSceneEnum.LoadScene)
end

function V3a6YaMiScene:_clearScene()
	self:_clearDesk()

	if self.go then
		gohelper.destroy(self.go)
	end

	self.go = nil

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)
	end

	self._sceneRoot = nil
end

function V3a6YaMiScene:_disposeSceneLoader()
	if self._sceneLoader then
		self._sceneLoader:dispose()
	end

	self._sceneLoader = nil
end

function V3a6YaMiScene:getSceneRoot()
	return self._sceneRoot
end

function V3a6YaMiScene:getSceneGO()
	return self.go
end

function V3a6YaMiScene:_clearDesk()
	if self._deskTb then
		for _, tb in ipairs(self._deskTb) do
			if not gohelper.isNil(tb.go) then
				gohelper.destroy(tb.go)
			end
		end
	end

	self._deskTb = nil
end

function V3a6YaMiScene:_getDestPath(i)
	return (ResUrl.getDungeonMapRes(V3a6YaMiSceneEnum.DeskResPaths[i]))
end

return V3a6YaMiScene
