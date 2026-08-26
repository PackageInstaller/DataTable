-- chunkname: @modules/logic/sodache/view/outside/SodacheMainScene.lua

module("modules.logic.sodache.view.outside.SodacheMainScene", package.seeall)

local SodacheMainScene = class("SodacheMainScene", BaseView)

function SodacheMainScene:onInitView()
	self._goBuildItem = gohelper.findChild(self.viewGO, "SceneUIRoot/go_BuildItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheMainScene:_editableInitView()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("SodacheMainScene")

	gohelper.addChild(sceneRoot, self._sceneRoot)

	local path = self.viewContainer:getSetting().otherRes[1]

	self.goScene = self:getResInst(path, self._sceneRoot)

	transformhelper.setLocalPos(self.goScene.transform, SodacheEnum.MainSceneOffset.x, SodacheEnum.MainSceneOffset.y, 0)

	self.buildingBox = SodacheModel.instance:getOutsideMo().buildingBox

	for _, mo in ipairs(self.buildingBox.buildings) do
		local go = gohelper.cloneInPlace(self._goBuildItem, "Build_" .. mo.type)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheBuildingItem)

		item:setData(mo, self.goScene)
	end

	gohelper.setActive(self._goBuildItem, false)
end

function SodacheMainScene:onOpen()
	MainCameraMgr.instance:addView(ViewName.SodacheMainView, self._initCamera, nil, self)
end

function SodacheMainScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 5 * scale
end

function SodacheMainScene:onDestroyView()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return SodacheMainScene
