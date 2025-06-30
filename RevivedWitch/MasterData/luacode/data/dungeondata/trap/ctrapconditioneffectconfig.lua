-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/trap/ctrapconditioneffectconfig.lua 

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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(10000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM02")
      effect:SetCfgID(10000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "74")
        effect:SetCfgID(10000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
          effect:SetCfgID(10000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(10000)
              root:AddEffect(effect)
              if upper then
                upper:AddEffect(root)
              end
              return composed
            end
          end
        end
      end
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(20000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM03")
      effect:SetCfgID(20000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "74")
        effect:SetCfgID(20000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
          effect:SetCfgID(20000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(20000)
              root:AddEffect(effect)
              if upper then
                upper:AddEffect(root)
              end
              return composed
            end
          end
        end
      end
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(30000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM03")
      effect:SetCfgID(30000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "74")
        effect:SetCfgID(30000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
          effect:SetCfgID(30000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(30000)
              root:AddEffect(effect)
              if upper then
                upper:AddEffect(root)
              end
              return composed
            end
          end
        end
      end
    end
  end
end
, [4] = function(args)
  -- function num : 0_3 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(40000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM07")
      effect:SetCfgID(40000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "74")
        effect:SetCfgID(40000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
          effect:SetCfgID(40000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(40000)
              root:AddEffect(effect)
              if upper then
                upper:AddEffect(root)
              end
              return composed
            end
          end
        end
      end
    end
  end
end
, [5] = function(args)
  -- function num : 0_4 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(50000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM08")
      effect:SetCfgID(50000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "74")
        effect:SetCfgID(50000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
          effect:SetCfgID(50000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(50000)
              root:AddEffect(effect)
              if upper then
                upper:AddEffect(root)
              end
              return composed
            end
          end
        end
      end
    end
  end
end
, [6] = function(args)
  -- function num : 0_5 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(60000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM07")
      effect:SetCfgID(60000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "75")
        effect:SetCfgID(60000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
          effect:SetCfgID(60000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(60000)
              root:AddEffect(effect)
              if upper then
                upper:AddEffect(root)
              end
              return composed
            end
          end
        end
      end
    end
  end
end
, [7] = function(args)
  -- function num : 0_6 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(70000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM08")
      effect:SetCfgID(70000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "75")
        effect:SetCfgID(70000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
          effect:SetCfgID(70000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(70000)
              root:AddEffect(effect)
              if upper then
                upper:AddEffect(root)
              end
              return composed
            end
          end
        end
      end
    end
  end
end
}
return effects

