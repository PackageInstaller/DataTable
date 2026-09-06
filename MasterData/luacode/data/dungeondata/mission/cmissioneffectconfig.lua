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
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end
}
return effects
