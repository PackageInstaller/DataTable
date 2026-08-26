-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaMainScene.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaMainScene", package.seeall)

local LoperaMainScene = class("LoperaMainScene", TianShiNaNaBaseSceneView)

function LoperaMainScene:getScenePath()
	return "scenes/v2a1_m_s12_lsp_jshd/scenes_prefab/v2a1_m_s12_lsp_background_p.prefab"
end

return LoperaMainScene
