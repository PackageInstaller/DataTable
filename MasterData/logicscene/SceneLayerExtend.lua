-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneLayerExtend.lua

module("logicscene.scene.SceneLayerExtend", package.seeall)

local SceneLayerExtend = {}

function SceneLayerExtend.extend()
	SceneLayer.FindWay = "FindWay"
	SceneLayer.GuestureGround = "GuestureGround"
	SceneLayer.Ground = "Ground"
	SceneLayer.Ground3D = "Ground3D"
	SceneLayer.GroundHeight = "GroundHeight"
	SceneLayer.Invisible = "Invisible"
	SceneLayer.MainPlayerInvisible = "MainPlayerInvisible"
	SceneLayer.SkillAnimation = "SkillAnimation"
	SceneLayer.SkillEffects = "SkillEffects"
	SceneLayer.SkillEffects_II = "SkillEffects2"
	SceneLayer.UI1 = "UI1"
	SceneLayer.UI2 = "UI2"
	SceneLayer.UI3DEx = "UI3DEx"
	SceneLayer.CommonLayer = "CommonLayer"
	SceneLayer.SceneElem = "SceneElem"
	SceneLayer.Water = "Water"
	SceneLayer.Default_Value = Framework.LayerUtil.NameToLayer(SceneLayer.Default)
	SceneLayer.UI_Value = Framework.LayerUtil.NameToLayer(SceneLayer.UI)
	SceneLayer.UI3D_Value = Framework.LayerUtil.NameToLayer(SceneLayer.UI3D)
	SceneLayer.Unit_Value = Framework.LayerUtil.NameToLayer(SceneLayer.Unit)
	SceneLayer.MainPlayer_Value = Framework.LayerUtil.NameToLayer(SceneLayer.MainPlayer)
	SceneLayer.SceneTrigger_Value = Framework.LayerUtil.NameToLayer(SceneLayer.SceneTrigger)
	SceneLayer.InteractiveObject_Value = Framework.LayerUtil.NameToLayer(SceneLayer.InteractiveObject)
	SceneLayer.FindWay_Value = Framework.LayerUtil.NameToLayer(SceneLayer.FindWay)
	SceneLayer.GuestureGround_Value = Framework.LayerUtil.NameToLayer(SceneLayer.GuestureGround)
	SceneLayer.Ground_Value = Framework.LayerUtil.NameToLayer(SceneLayer.Ground)
	SceneLayer.GroundHeight_Value = Framework.LayerUtil.NameToLayer(SceneLayer.GroundHeight)
	SceneLayer.Invisible_Value = Framework.LayerUtil.NameToLayer(SceneLayer.Invisible)
	SceneLayer.MainPlayerInvisible_Value = Framework.LayerUtil.NameToLayer(SceneLayer.MainPlayerInvisible)
	SceneLayer.SkillAnimation_Value = Framework.LayerUtil.NameToLayer(SceneLayer.SkillAnimation)
	SceneLayer.SkillEffects_Value = Framework.LayerUtil.NameToLayer(SceneLayer.SkillEffects)
	SceneLayer.SkillEffects_II_Value = Framework.LayerUtil.NameToLayer(SceneLayer.SkillEffects_II)
	SceneLayer.UI1_Value = Framework.LayerUtil.NameToLayer(SceneLayer.UI1)
	SceneLayer.UI2_Value = Framework.LayerUtil.NameToLayer(SceneLayer.UI2)
	SceneLayer.SceneElem_Value = Framework.LayerUtil.NameToLayer(SceneLayer.SceneElem)
	SceneLayer.Ground3D_Value = Framework.LayerUtil.NameToLayer(SceneLayer.Ground3D)
	SceneLayer.Water_Value = Framework.LayerUtil.NameToLayer(SceneLayer.Water)
	SceneLayer.UI3DEx_Value = Framework.LayerUtil.NameToLayer(SceneLayer.UI3DEx)
	SceneLayer.CommonLayer_Value = Framework.LayerUtil.NameToLayer(SceneLayer.CommonLayer)
end

return SceneLayerExtend
