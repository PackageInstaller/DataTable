-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaMapScene.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapScene", package.seeall)

local LanShouPaMapScene = class("LanShouPaMapScene", BaseView)

function LanShouPaMapScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaMapScene:addEvents()
	self.addEventCb(self, LanShouPaController.instance, LanShouPaEvent.SetScenePos, self._onSetScenePos, self)
end

function LanShouPaMapScene:removeEvents()
	self.removeEventCb(self, LanShouPaController.instance, LanShouPaEvent.SetScenePos, self._onSetScenePos, self)
end

function LanShouPaMapScene:_editableInitView()
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("LanShouPaScene")

	gohelper.addChild(sceneRoot, self._sceneRoot)

	self._loader = PrefabInstantiate.Create(self._sceneRoot)

	self._loader:startLoad("scenes/v2a1_m_s12_lsp_jshd/scenes_prefab/v2a1_m_s12_lsp_background_p.prefab")
	transformhelper.setLocalPos(self._sceneRoot.transform, 0, 5.8, 0)
end

function LanShouPaMapScene:onOpen()
	self._sceneGos = self:getUserDataTb_()

	MainCameraMgr.instance:addView(ViewName.LanShouPaMapView, self._initCamera, nil, self)
end

function LanShouPaMapScene:_initCamera()
	local camera = CameraMgr.instance:getMainCamera()
	local scale = GameUtil.getAdapterScale(true)

	camera.orthographic = true
	camera.orthographicSize = 7.5 * scale
end

function LanShouPaMapScene:setSceneVisible(isVisible)
	gohelper.setActive(self._sceneRoot, isVisible)
end

function LanShouPaMapScene:_onSetScenePos(posX)
	transformhelper.setPosXY(self._sceneRoot.transform, posX, 5.8)
end

function LanShouPaMapScene:onClose()
	return
end

function LanShouPaMapScene:onDestroyView()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

return LanShouPaMapScene
