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
        local effect = EffectFactory.CreateFreezeEffect(false)
        effect:SetCfgID(10000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM02")
        effect:SetCfgID(10000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "74")
        effect:SetCfgID(10000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(10000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
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
        local effect = EffectFactory.CreateFreezeEffect(false)
        effect:SetCfgID(20000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM03")
        effect:SetCfgID(20000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "74")
        effect:SetCfgID(20000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(20000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
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
        local effect = EffectFactory.CreateFreezeEffect(false)
        effect:SetCfgID(30000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM03")
        effect:SetCfgID(30000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "74")
        effect:SetCfgID(30000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(30000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(30000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [4] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(false)
        effect:SetCfgID(40000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM07")
        effect:SetCfgID(40000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "74")
        effect:SetCfgID(40000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(40000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(40000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [5] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(false)
        effect:SetCfgID(50000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM08")
        effect:SetCfgID(50000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "74")
        effect:SetCfgID(50000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(50000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(50000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [6] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(false)
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM07")
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "75")
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [7] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(false)
        effect:SetCfgID(70000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM08")
        effect:SetCfgID(70000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "75")
        effect:SetCfgID(70000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(70000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(70000)
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
