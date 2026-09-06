local ChangeTrapStateEffect = require("logic.scene.luaevent.effect.composed.changetrapstateeffect")
local effects = {
  [1] = function(args)
    local composed
    do
      local upper = root or composed
      local root
      if not composed then
        composed = EffectFactory.CreateEffectList()
        root = composed
      else
        root = EffectFactory.CreateEffectList()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "4")
        effect:SetCfgID(10101)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 79)
        effect:SetCfgID(10103)
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
        composed = EffectFactory.CreateEffectList()
        root = composed
      else
        root = EffectFactory.CreateEffectList()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "5")
        effect:SetCfgID(20101)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 79)
        effect:SetCfgID(20103)
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
        composed = EffectFactory.CreateEffectList()
        root = composed
      else
        root = EffectFactory.CreateEffectList()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "6")
        effect:SetCfgID(30101)
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
        composed = EffectFactory.CreateEffectList()
        root = composed
      else
        root = EffectFactory.CreateEffectList()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "7")
        effect:SetCfgID(40101)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 1225)
        effect:SetCfgID(40103)
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
        composed = EffectFactory.CreateEffectList()
        root = composed
      else
        root = EffectFactory.CreateEffectList()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "8")
        effect:SetCfgID(50101)
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
        composed = EffectFactory.CreateEffectList()
        root = composed
      else
        root = EffectFactory.CreateEffectList()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1019, false, false)
        effect:SetCfgID(60000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100064)
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
        local effect = EffectFactory.CreateDialogEffect(2, "12")
        effect:SetCfgID(70001)
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
        local effect = EffectFactory.CreateDialogEffect(2, "13")
        effect:SetCfgID(80001)
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
        local effect = EffectFactory.CreateDialogEffect(2, "14")
        effect:SetCfgID(90001)
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
        local effect = EffectFactory.CreateDialogEffect(2, "15")
        effect:SetCfgID(100001)
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
        local effect = EffectFactory.CreateDialogEffect(2, "16")
        effect:SetCfgID(110007)
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
        local effect = EffectFactory.CreateDialogEffect(2, "17")
        effect:SetCfgID(120001)
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
        effect:SetCfgID(130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("[sceneobject 14]/com_m_interactiveFlash", false)
        effect:SetCfgID(130000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(267)
        effect:SetCfgID(130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(130000)
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
        local effect = EffectFactory.CreateDialogEffect(2, "19")
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
        local effect = EffectFactory.CreateDialogEffect(2, "20")
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
        local effect = EffectFactory.CreateDialogEffect(2, "21")
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
        local effect = EffectFactory.CreateDialogEffect(2, "22")
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
        local effect = EffectFactory.CreateDialogEffect(2, "23")
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
        local effect = EffectFactory.CreateVisualEffect("[sceneobject 18]/com_m_interactiveFlash", false)
        effect:SetCfgID(190000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "7")
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
        local effect = EffectFactory.CreateDialogEffect(4, "10")
        effect:SetCfgID(200000)
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
        local effect = EffectFactory.CreateDialogEffect(2, "28")
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
        local effect = EffectFactory.CreateDialogEffect(2, "26")
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
        local effect = EffectFactory.CreateDialogEffect(2, "27")
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
        local effect = EffectFactory.CreateVisualEffect("[sceneobject 19]/com_m_interactiveFlash", false)
        effect:SetCfgID(250000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "10")
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
        local effect = EffectFactory.CreateDialogEffect(4, "18")
        effect:SetCfgID(260000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("[sceneobject 24]/com_m_interactiveFlash", false)
        effect:SetCfgID(260000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1295, false, false)
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
        local effect = EffectFactory.CreateDialogEffect(4, "19")
        effect:SetCfgID(270000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("", "state", 1, "", 0)
        effect:SetCfgID(270000)
        effect:SetParam("runoninit")
        do
          local upper = effect
          local effect = EffectFactory.CreateAnimatorStateChangeEffect("nil", "state", 1, "", 0)
          effect:SetCfgID(27000000)
          upper:SetParam("alternative", effect)
        end
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1194, false, false)
        effect:SetCfgID(280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13001, 2)
        effect:SetCfgID(280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1194, false, false)
        effect:SetCfgID(290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13001, 3)
        effect:SetCfgID(290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1194, false, false)
        effect:SetCfgID(300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13001, 4)
        effect:SetCfgID(300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1194, false, false)
        effect:SetCfgID(310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13001, 5)
        effect:SetCfgID(310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
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
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(320000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1222, false, false)
        effect:SetCfgID(320000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13101, 1)
        effect:SetCfgID(320000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(320000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [33] = function(args)
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
        effect:SetCfgID(330000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1223, false, false)
        effect:SetCfgID(330000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13102, 1)
        effect:SetCfgID(330000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(330000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [34] = function(args)
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
        effect:SetCfgID(340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1224, false, false)
        effect:SetCfgID(340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13103, 1)
        effect:SetCfgID(340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(340000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [35] = function(args)
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
        effect:SetCfgID(350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1225, false, false)
        effect:SetCfgID(350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13104, 1)
        effect:SetCfgID(350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(350000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [36] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "33")
        effect:SetCfgID(360000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [37] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "34")
        effect:SetCfgID(370000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [38] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "35")
        effect:SetCfgID(380000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [39] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "36")
        effect:SetCfgID(390000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [40] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "37")
        effect:SetCfgID(400000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [41] = function(args)
    local composed
    do
      local upper = root or composed
      local root
      if not composed then
        composed = EffectFactory.CreateEffectList()
        root = composed
      else
        root = EffectFactory.CreateEffectList()
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "76")
        effect:SetCfgID(410101)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [42] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(4, "32")
        effect:SetCfgID(420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("[sceneobject 45]", "ChestState", 1, "", 0)
        effect:SetCfgID(420000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [43] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(4, "33")
        effect:SetCfgID(430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("[sceneobject 46]", "ChestState", 1, "", 0)
        effect:SetCfgID(430000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [44] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(4, "34")
        effect:SetCfgID(440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("[sceneobject 47]", "ChestState", 1, "", 0)
        effect:SetCfgID(440000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [45] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(4, "35")
        effect:SetCfgID(450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("[sceneobject 48]", "ChestState", 1, "", 0)
        effect:SetCfgID(450000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [46] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(4, "36")
        effect:SetCfgID(460000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("[sceneobject 49]", "ChestState", 1, "", 0)
        effect:SetCfgID(460000)
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
