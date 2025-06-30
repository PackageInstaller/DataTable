-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/finishbrancheffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local FinishBranchEffect = class("FinishBranchEffect", EffectBase)
FinishBranchEffect.Ctor = function(self)
  -- function num : 0_0
end

FinishBranchEffect.Run = function(self, args)
  -- function num : 0_1 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if not controller then
    LogErrorFormat("finishbrancheffect", "finish branch outside scene")
    return 
  end
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.ccompletezone")
  req.floorId = controller:GetSceneID()
  req.outPoint = 1
  req:Send()
end

return FinishBranchEffect

