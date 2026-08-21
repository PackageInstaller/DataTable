---自动生成代码----start----
local BridgeScene = BaseClass( 'BridgeScene' , BaseView )
local M = BridgeScene 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.CameraNode = UIUtil.FindComponent( trans , typeof(CS.GameX.MainSceneCamerContent) , "CameraNode" )
  self.ball = UIUtil.FindComponent( trans , typeof(CS.UnityEngine.Transform) , "effect_sence_xingqiu/Ani/ef_mesh_all" )
end
return BridgeScene
---自动生成代码----end----