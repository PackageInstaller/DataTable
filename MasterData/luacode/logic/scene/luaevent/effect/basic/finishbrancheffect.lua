local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FinishBranchEffect = class("FinishBranchEffect", EffectBase)

function FinishBranchEffect:Ctor()
end

function FinishBranchEffect:Run(args)
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if not controller then
    LogErrorFormat("finishbrancheffect", "finish branch outside scene")
    return
  end
  local req = LuaNetManager.CreateProtocol("protocol.battle.ccompletezone")
  req.floorId = controller:GetSceneID()
  req.outPoint = 1
  req:Send()
end

return FinishBranchEffect
