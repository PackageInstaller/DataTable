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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(10100)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(163)
        effect:SetCfgID(10100)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(10100)
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
        local effect = EffectFactory.CreateTimelineEffect(1110, false, false)
        effect:SetCfgID(20200)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(30300)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(163)
        effect:SetCfgID(30300)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(30300)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(40400)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1106, false, false)
        effect:SetCfgID(40401)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(40402)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(50001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1107, false, false)
        effect:SetCfgID(50002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "2")
        effect:SetCfgID(50003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(50006)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(114)
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(70000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(31, 6, 3, 1, false)
        effect:SetCfgID(70002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3004, true, false)
        effect:SetCfgID(70003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Sence_TX_Prefab_MoFaMen", false)
        effect:SetCfgID(70004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [8] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(80000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(251)
        effect:SetCfgID(80000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(80000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [9] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(90000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1123, false, false)
        effect:SetCfgID(90000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(90000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [10] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1128, false, false)
        effect:SetCfgID(100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [11] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1129, false, false)
        effect:SetCfgID(110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(110000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [12] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3005, true, false)
        effect:SetCfgID(120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("[npc 10005]", "NPCstate", 9, "", 0)
        effect:SetCfgID(120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(120000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [13] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(130001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(1599)
        effect:SetCfgID(130002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(130003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBattleEffect(10008)
        effect:SetCfgID(130004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [14] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(802)
        effect:SetCfgID(140000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [15] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(811)
        effect:SetCfgID(150000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [16] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(819)
        effect:SetCfgID(160000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [17] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(833)
        effect:SetCfgID(170000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [18] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(589)
        effect:SetCfgID(180000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [19] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(657)
        effect:SetCfgID(190000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [20] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(842)
        effect:SetCfgID(200000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [21] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(3016, true, false)
        effect:SetCfgID(210000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [22] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1099)
        effect:SetCfgID(220000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [23] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1165)
        effect:SetCfgID(230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "20")
        effect:SetCfgID(230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(1166)
        effect:SetCfgID(230000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [24] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1167)
        effect:SetCfgID(240000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [25] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3018, true, false)
        effect:SetCfgID(250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(14018, 1)
        effect:SetCfgID(250000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [26] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1226)
        effect:SetCfgID(260000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [27] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1545)
        effect:SetCfgID(270000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [28] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1546)
        effect:SetCfgID(280000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [29] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1547)
        effect:SetCfgID(290000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [30] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1615)
        effect:SetCfgID(300000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [31] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1616)
        effect:SetCfgID(310000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [32] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1617)
        effect:SetCfgID(320000)
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
