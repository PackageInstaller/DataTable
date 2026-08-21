-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/extend/SceneTagExtend.lua

module("logic.common.datadef.extend.SceneTagExtend", package.seeall)

local SceneTagExtend = {}

function SceneTagExtend.extend()
	SceneTag.Untagged = "Untagged"
	SceneTag.RendererFeatureCamera = "RendererFeatureCamera"
	SceneTag.MainCamera = "MainCamera"
	SceneTag.RTCamera = "RTCamera"
	SceneTag.UICamera = "UICamera"
	SceneTag.CommonGamePlay = "CommonGamePlay"
end

return SceneTagExtend
