-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/dialog/cdialogeffectconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChangeTrapStateEffect = require("logic.scene.luaevent.effect.composed.changetrapstateeffect")
local effects = {[1] = function(args)
  -- function num : 0_0 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateComposedEffect)()
    root = composed
  else
    root = (EffectFactory.CreateComposedEffect)()
  end
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateTurnEffect)(0, "[actor]")
      effect:SetCfgID(10000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [2] = function(args)
  -- function num : 0_1 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateComposedEffect)()
    root = composed
  else
    root = (EffectFactory.CreateComposedEffect)()
  end
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateTurnEffect)(2, "[actor]")
      effect:SetCfgID(20000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [3] = function(args)
  -- function num : 0_2 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateComposedEffect)()
    root = composed
  else
    root = (EffectFactory.CreateComposedEffect)()
  end
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateTurnEffect)(4, "[actor]")
      effect:SetCfgID(30000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
}
return effects

