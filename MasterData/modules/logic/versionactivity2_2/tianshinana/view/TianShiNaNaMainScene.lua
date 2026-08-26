-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaMainScene.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainScene", package.seeall)

local TianShiNaNaMainScene = class("TianShiNaNaMainScene", TianShiNaNaBaseSceneView)

function TianShiNaNaMainScene:addEvents()
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.DragMainScene, self._onSetScenePos, self)
end

function TianShiNaNaMainScene:removeEvents()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.DragMainScene, self._onSetScenePos, self)
end

function TianShiNaNaMainScene:getScenePath()
	return "scenes/v2a2_m_s12_tsnn_jshd/scenes_prefab/v2a2_m_s12_tsnn_jshd_background_p.prefab"
end

function TianShiNaNaMainScene:_onSetScenePos(posX)
	transformhelper.setPosXY(self._sceneRoot.transform, posX + 16.14, 6.63)
end

return TianShiNaNaMainScene
