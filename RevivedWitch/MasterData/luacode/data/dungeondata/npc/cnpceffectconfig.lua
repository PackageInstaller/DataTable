-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/npc/cnpceffectconfig.lua 

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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(10100)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateStartChatEffect)(163)
      effect:SetCfgID(10100)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(10100)
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
      local effect = (EffectFactory.CreateTimelineEffect)(1110, false, false)
      effect:SetCfgID(20200)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(30300)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateStartChatEffect)(163)
      effect:SetCfgID(30300)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(30300)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(40400)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1106, false, false)
      effect:SetCfgID(40401)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(40402)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(50001)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1107, false, false)
      effect:SetCfgID(50002)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(4, "2")
        effect:SetCfgID(50003)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(50006)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(60000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateStartChatEffect)(114)
      effect:SetCfgID(60000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(70000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBlockChangeEffect)(31, 6, 3, 1, false)
      effect:SetCfgID(70002)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(3004, true, false)
        effect:SetCfgID(70003)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Sence_TX_Prefab_MoFaMen", false)
            effect:SetCfgID(70004)
            effect:SetParam("runoninit")
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(80000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateStartChatEffect)(251)
      effect:SetCfgID(80000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(80000)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(90000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1123, false, false)
      effect:SetCfgID(90000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(90000)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(100000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1128, false, false)
      effect:SetCfgID(100000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(100000)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(110000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1129, false, false)
      effect:SetCfgID(110000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(110000)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(120000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3005, true, false)
      effect:SetCfgID(120000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("[npc 10005]", "NPCstate", 9, "", 0)
        effect:SetCfgID(120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(120000)
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
    effect:SetCfgID(130001)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1599)
      effect:SetCfgID(130002)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(130003)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateBattleEffect)(10008)
            effect:SetCfgID(130004)
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
      local effect = (EffectFactory.CreateStartChatEffect)(802)
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
      local effect = (EffectFactory.CreateStartChatEffect)(811)
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
      local effect = (EffectFactory.CreateStartChatEffect)(819)
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
      local effect = (EffectFactory.CreateStartChatEffect)(833)
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
      local effect = (EffectFactory.CreateStartChatEffect)(589)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(657)
      effect:SetCfgID(190000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
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
      local effect = (EffectFactory.CreateStartChatEffect)(842)
      effect:SetCfgID(200000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [21] = function(args)
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
      local effect = (EffectFactory.CreateTimelineEffect)(3016, true, false)
      effect:SetCfgID(210000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [22] = function(args)
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
      local effect = (EffectFactory.CreateStartChatEffect)(1099)
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
    local effect = (EffectFactory.CreateStartChatEffect)(1165)
    effect:SetCfgID(230000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateDialogEffect)(4, "20")
      effect:SetCfgID(230000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateStartChatEffect)(1166)
          effect:SetCfgID(230000)
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
, [24] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1167)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(250000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3018, true, false)
      effect:SetCfgID(250000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(250000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateJumpEffect)(14018, 1)
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
  end
end
, [26] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1226)
      effect:SetCfgID(260000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [27] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1545)
      effect:SetCfgID(270000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [28] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1546)
      effect:SetCfgID(280000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [29] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1547)
      effect:SetCfgID(290000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [30] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1615)
      effect:SetCfgID(300000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [31] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1616)
      effect:SetCfgID(310000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [32] = function(args)
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
    do
      local effect = (EffectFactory.CreateStartChatEffect)(1617)
      effect:SetCfgID(320000)
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

