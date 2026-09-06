local ChangeTrapStateEffect = require("logic.scene.luaevent.effect.composed.changetrapstateeffect")
local effects = {
  [1] = function(args)
    local composed
    do
      local upper = root or composed
      local root
      if not composed then
        composed = EffectFactory.CreateComposedEffect()
        root = composed
      else
        root = EffectFactory.CreateComposedEffect()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(0, "[actor]")
        effect:SetCfgID(10000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [2] = function(args)
    local composed
    do
      local upper = root or composed
      local root
      if not composed then
        composed = EffectFactory.CreateComposedEffect()
        root = composed
      else
        root = EffectFactory.CreateComposedEffect()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(2, "[actor]")
        effect:SetCfgID(20000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [3] = function(args)
    local composed
    do
      local upper = root or composed
      local root
      if not composed then
        composed = EffectFactory.CreateComposedEffect()
        root = composed
      else
        root = EffectFactory.CreateComposedEffect()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(4, "[actor]")
        effect:SetCfgID(30000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end
}
return effects
