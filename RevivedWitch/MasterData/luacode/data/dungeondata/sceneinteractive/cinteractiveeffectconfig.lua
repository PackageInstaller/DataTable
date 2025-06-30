-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/sceneinteractive/cinteractiveeffectconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChangeTrapStateEffect = require("logic.scene.luaevent.effect.composed.changetrapstateeffect")
local effects = {[1] = function(args)
  -- function num : 0_0 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateEffectList)()
    root = composed
  else
    root = (EffectFactory.CreateEffectList)()
  end
  local upper = effect
  do
    local effect = (EffectFactory.CreateDialogEffect)(2, "4")
    effect:SetCfgID(10101)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBGMEffect)("play", 79)
        effect:SetCfgID(10103)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
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
    composed = (EffectFactory.CreateEffectList)()
    root = composed
  else
    root = (EffectFactory.CreateEffectList)()
  end
  local upper = effect
  do
    local effect = (EffectFactory.CreateDialogEffect)(2, "5")
    effect:SetCfgID(20101)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBGMEffect)("play", 79)
        effect:SetCfgID(20103)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
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
    composed = (EffectFactory.CreateEffectList)()
    root = composed
  else
    root = (EffectFactory.CreateEffectList)()
  end
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateDialogEffect)(2, "6")
      effect:SetCfgID(30101)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [4] = function(args)
  -- function num : 0_3 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateEffectList)()
    root = composed
  else
    root = (EffectFactory.CreateEffectList)()
  end
  local upper = effect
  do
    local effect = (EffectFactory.CreateDialogEffect)(2, "7")
    effect:SetCfgID(40101)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBGMEffect)("play", 1225)
        effect:SetCfgID(40103)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
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
    composed = (EffectFactory.CreateEffectList)()
    root = composed
  else
    root = (EffectFactory.CreateEffectList)()
  end
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateDialogEffect)(2, "8")
      effect:SetCfgID(50101)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [6] = function(args)
  -- function num : 0_5 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateEffectList)()
    root = composed
  else
    root = (EffectFactory.CreateEffectList)()
  end
  local upper = effect
  do
    local effect = (EffectFactory.CreateTimelineEffect)(1019, false, false)
    effect:SetCfgID(60000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateRemoveEventEffect)(100064)
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
    do
      local effect = (EffectFactory.CreateDialogEffect)(2, "12")
      effect:SetCfgID(70001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [8] = function(args)
  -- function num : 0_7 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "13")
      effect:SetCfgID(80001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [9] = function(args)
  -- function num : 0_8 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "14")
      effect:SetCfgID(90001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [10] = function(args)
  -- function num : 0_9 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "15")
      effect:SetCfgID(100001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [11] = function(args)
  -- function num : 0_10 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "16")
      effect:SetCfgID(110007)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [12] = function(args)
  -- function num : 0_11 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "17")
      effect:SetCfgID(120001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [13] = function(args)
  -- function num : 0_12 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(130000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("[sceneobject 14]/com_m_interactiveFlash", false)
      effect:SetCfgID(130000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateStartChatEffect)(267)
        effect:SetCfgID(130000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(130000)
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
, [14] = function(args)
  -- function num : 0_13 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "19")
      effect:SetCfgID(140000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [15] = function(args)
  -- function num : 0_14 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "20")
      effect:SetCfgID(150000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [16] = function(args)
  -- function num : 0_15 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "21")
      effect:SetCfgID(160000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [17] = function(args)
  -- function num : 0_16 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "22")
      effect:SetCfgID(170000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [18] = function(args)
  -- function num : 0_17 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "23")
      effect:SetCfgID(180000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [19] = function(args)
  -- function num : 0_18 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("[sceneobject 18]/com_m_interactiveFlash", false)
    effect:SetCfgID(190000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateDialogEffect)(4, "7")
        effect:SetCfgID(190000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [20] = function(args)
  -- function num : 0_19 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(4, "10")
      effect:SetCfgID(200000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [22] = function(args)
  -- function num : 0_20 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "28")
      effect:SetCfgID(220000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [23] = function(args)
  -- function num : 0_21 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "26")
      effect:SetCfgID(230000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [24] = function(args)
  -- function num : 0_22 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "27")
      effect:SetCfgID(240000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [25] = function(args)
  -- function num : 0_23 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("[sceneobject 19]/com_m_interactiveFlash", false)
    effect:SetCfgID(250000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateDialogEffect)(4, "10")
        effect:SetCfgID(250000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [26] = function(args)
  -- function num : 0_24 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(4, "18")
    effect:SetCfgID(260000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("[sceneobject 24]/com_m_interactiveFlash", false)
      effect:SetCfgID(260000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1295, false, false)
          effect:SetCfgID(260000)
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
, [27] = function(args)
  -- function num : 0_25 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(4, "19")
    effect:SetCfgID(270000)
    root:AddEffect(effect)
    local upper = effect
    local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("", "state", 1, "", 0)
    effect:SetCfgID(270000)
    effect:SetParam("runoninit")
    local upper = effect
    do
      do
        do
          local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("nil", "state", 1, "", 0)
          effect:SetCfgID(27000000)
          upper:SetParam("alternative", effect)
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
, [28] = function(args)
  -- function num : 0_26 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(280000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1194, false, false)
      effect:SetCfgID(280000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13001, 2)
        effect:SetCfgID(280000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(280000)
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
, [29] = function(args)
  -- function num : 0_27 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(290000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1194, false, false)
      effect:SetCfgID(290000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13001, 3)
        effect:SetCfgID(290000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(290000)
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
, [30] = function(args)
  -- function num : 0_28 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(300000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1194, false, false)
      effect:SetCfgID(300000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13001, 4)
        effect:SetCfgID(300000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(300000)
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
, [31] = function(args)
  -- function num : 0_29 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(310000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1194, false, false)
      effect:SetCfgID(310000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13001, 5)
        effect:SetCfgID(310000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(310000)
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
, [32] = function(args)
  -- function num : 0_30 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(320000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1222, false, false)
      effect:SetCfgID(320000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13101, 1)
        effect:SetCfgID(320000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(320000)
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
, [33] = function(args)
  -- function num : 0_31 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(330000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1223, false, false)
      effect:SetCfgID(330000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13102, 1)
        effect:SetCfgID(330000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(330000)
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
, [34] = function(args)
  -- function num : 0_32 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(340000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1224, false, false)
      effect:SetCfgID(340000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13103, 1)
        effect:SetCfgID(340000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(340000)
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
, [35] = function(args)
  -- function num : 0_33 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(350000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1225, false, false)
      effect:SetCfgID(350000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateJumpEffect)(13104, 1)
        effect:SetCfgID(350000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(350000)
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
, [36] = function(args)
  -- function num : 0_34 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "33")
      effect:SetCfgID(360000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [37] = function(args)
  -- function num : 0_35 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "34")
      effect:SetCfgID(370000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [38] = function(args)
  -- function num : 0_36 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "35")
      effect:SetCfgID(380000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [39] = function(args)
  -- function num : 0_37 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "36")
      effect:SetCfgID(390000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [40] = function(args)
  -- function num : 0_38 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "37")
      effect:SetCfgID(400000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [41] = function(args)
  -- function num : 0_39 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateEffectList)()
    root = composed
  else
    root = (EffectFactory.CreateEffectList)()
  end
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateDialogEffect)(2, "76")
      effect:SetCfgID(410101)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [42] = function(args)
  -- function num : 0_40 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(4, "32")
    effect:SetCfgID(420000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("[sceneobject 45]", "ChestState", 1, "", 0)
        effect:SetCfgID(420000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [43] = function(args)
  -- function num : 0_41 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(4, "33")
    effect:SetCfgID(430000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("[sceneobject 46]", "ChestState", 1, "", 0)
        effect:SetCfgID(430000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [44] = function(args)
  -- function num : 0_42 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(4, "34")
    effect:SetCfgID(440000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("[sceneobject 47]", "ChestState", 1, "", 0)
        effect:SetCfgID(440000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [45] = function(args)
  -- function num : 0_43 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(4, "35")
    effect:SetCfgID(450000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("[sceneobject 48]", "ChestState", 1, "", 0)
        effect:SetCfgID(450000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [46] = function(args)
  -- function num : 0_44 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(4, "36")
    effect:SetCfgID(460000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("[sceneobject 49]", "ChestState", 1, "", 0)
        effect:SetCfgID(460000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
}
return effects

