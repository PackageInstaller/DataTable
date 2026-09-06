local ChangeTrapStateEffect = require("logic.scene.luaevent.effect.composed.changetrapstateeffect")
local effects = {
  [100001] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10001, 1)
        effect:SetCfgID(1000010001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000010003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100002] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10002, 1)
        effect:SetCfgID(1000020001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000020003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100003] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10002, 2)
        effect:SetCfgID(1000030001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000030003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100004] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1038, false, false)
        effect:SetCfgID(1000040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000040001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(10003, 1)
        effect:SetCfgID(1000040002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100005] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1038, false, false)
        effect:SetCfgID(1000050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000050001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(10003, 2)
        effect:SetCfgID(1000050002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100006] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10004, 1)
        effect:SetCfgID(1000060001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000060003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100007] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1047, false, false)
        effect:SetCfgID(1000070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000070003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(10005, 1)
        effect:SetCfgID(1000070003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100008] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10006, 1)
        effect:SetCfgID(1000080001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000080003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100009] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10007, 1)
        effect:SetCfgID(1000090001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000090003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100010] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10008, 1)
        effect:SetCfgID(1000100001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000100003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100011] = function(args)
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
        effect:SetCfgID(1000110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1030, false, false)
        effect:SetCfgID(1000110001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("ChairCat/Char_Cat", false)
        effect:SetCfgID(1000110002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000110003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100012] = function(args)
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
        effect:SetCfgID(1000120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1435, false, false)
        effect:SetCfgID(1000120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_fs_01m", false)
        effect:SetCfgID(1000120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1000120000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100013] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("mon_fs_01m", false)
        effect:SetCfgID(1000130000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100015] = function(args)
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
        effect:SetCfgID(1000150000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1036, false, false)
        effect:SetCfgID(1000150001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000150003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100019] = function(args)
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
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("Statue/t1_m_statue_02", "trapState", 1, "", 0)
        effect:SetCfgID(1000190000)
        effect:SetParam("runoninit")
        do
          local upper = effect
          local effect = EffectFactory.CreateAnimatorStateChangeEffect("Statue/t1_m_statue_02", "loadState", 1, "", 0)
          effect:SetCfgID(100019000000)
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
  [100023] = function(args)
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
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("Statue/t1_m_statue_01 (2)", "trapState", 1, "", 0)
        effect:SetCfgID(1000230000)
        effect:SetParam("runoninit")
        do
          local upper = effect
          local effect = EffectFactory.CreateAnimatorStateChangeEffect("Statue/t1_m_statue_01 (2)", "loadState", 1, "", 0)
          effect:SetCfgID(100023000000)
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
  [100025] = function(args)
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
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("Statue/t1_m_statue_02 (3)", "trapState", 1, "", 0)
        effect:SetCfgID(1000250000)
        effect:SetParam("runoninit")
        do
          local upper = effect
          local effect = EffectFactory.CreateAnimatorStateChangeEffect("Statue/t1_m_statue_02 (3)", "loadState", 1, "", 0)
          effect:SetCfgID(100025000000)
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
  [100039] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1004, false, false)
        effect:SetCfgID(1000390000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateSpeedChangeEffect("[actor]", 0.5)
        effect:SetCfgID(1000390000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAddEventEffect(100045)
        effect:SetCfgID(1000390001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("T1_Area_07_ForBuild_02", false)
        effect:SetCfgID(1000390002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100040] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "1")
        effect:SetCfgID(1000400000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 20010002)
        effect:SetCfgID(1000400000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100041] = function(args)
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
        local effect = EffectFactory.CreateAnimationEffect("firstscene_map_door", "DoorOpen")
        effect:SetCfgID(1000410000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("firstscene_map_button", "ButtonPushed")
        effect:SetCfgID(1000410001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(25, 39, 1, 1, false)
        effect:SetCfgID(1000410002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100042] = function(args)
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
        effect:SetCfgID(1000420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1049, false, false)
        effect:SetCfgID(1000420001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100043] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(1, "")
        effect:SetCfgID(1000430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1025, false, false)
        effect:SetCfgID(1000430001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Char_Cat", false)
        effect:SetCfgID(1000430002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000430003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100045] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1008, false, false)
        effect:SetCfgID(1000450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAddEventEffect(100039)
        effect:SetCfgID(1000450001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("T1_Area_07_ForBuild_01", false)
        effect:SetCfgID(1000450002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100046] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100045)
        effect:SetCfgID(1000460000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100054] = function(args)
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
        effect:SetCfgID(1000540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1050, false, false)
        effect:SetCfgID(1000540001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000540003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100055] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("T1_Area_07_ForBuild_01", true)
        effect:SetCfgID(1000550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("T1_Area_07_ForBuild_02", true)
        effect:SetCfgID(1000550001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100056] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "2")
        effect:SetCfgID(1000560000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100060] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 56)
        effect:SetCfgID(1000600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "3")
        effect:SetCfgID(1000600001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100061] = function(args)
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
        effect:SetCfgID(1000610000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1017, false, false)
        effect:SetCfgID(1000610001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000610003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100062] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100061)
        effect:SetCfgID(1000620000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100063] = function(args)
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
        effect:SetCfgID(1000630000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1018, false, false)
        effect:SetCfgID(1000630001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000630003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100064] = function(args)
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
        effect:SetCfgID(1000640000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(20, 8, 1, 1, true)
        effect:SetCfgID(1000640000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.85, 8, 0, -5.42, true)
        effect:SetCfgID(1000640001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(8, "[actor]")
        effect:SetCfgID(1000640002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1118, false, false)
        effect:SetCfgID(1000640003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDestroyEffect("Story_1/Char_Cat")
        effect:SetCfgID(1000640004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000640005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100071] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 97)
        effect:SetCfgID(1000710000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100075] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 70)
        effect:SetCfgID(1000750000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100076] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("pause", 2)
        effect:SetCfgID(1000760000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100077] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 59)
        effect:SetCfgID(1000770000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100078] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("pause", 2)
        effect:SetCfgID(1000780000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100079] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 61)
        effect:SetCfgID(1000790000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100080] = function(args)
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
        effect:SetCfgID(1000800000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1021, false, false)
        effect:SetCfgID(1000800001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000800003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100081] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1022, false, false)
        effect:SetCfgID(1000810000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000810003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100082] = function(args)
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
        effect:SetCfgID(1000820000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1023, false, false)
        effect:SetCfgID(1000820001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000820003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100083] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1024, false, false)
        effect:SetCfgID(1000830000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000830003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100084] = function(args)
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
        local effect = EffectFactory.CreateAnimationEffect("firstscene_rabbit", "rabbit_escape")
        effect:SetCfgID(1000840000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100085] = function(args)
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
        local effect = EffectFactory.CreateAnimationEffect("firstscene_map_bird", "BirdFly")
        effect:SetCfgID(1000850000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 71)
        effect:SetCfgID(1000850001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100087] = function(args)
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
        effect:SetCfgID(1000870000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 33)
        effect:SetCfgID(1000870001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1026, false, false)
        effect:SetCfgID(1000870002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("Firstsence_gate", "GateOpen")
        effect:SetCfgID(1000870003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1027, false, false)
        effect:SetCfgID(1000870004)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000870005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100089] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 2)
        effect:SetCfgID(1000890001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100090] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1028, false, false)
        effect:SetCfgID(1000900000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100091] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1029, false, false)
        effect:SetCfgID(1000910000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100092] = function(args)
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
        effect:SetCfgID(1000920000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1031, false, false)
        effect:SetCfgID(1000920001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1000920003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100093] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(11000, 1)
        effect:SetCfgID(1000930000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100094] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1032, false, false)
        effect:SetCfgID(1000940000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100095] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1033, false, false)
        effect:SetCfgID(1000950000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100096] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1033, false, false)
        effect:SetCfgID(1000960000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100097] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(9, 24, 2, 1, true)
        effect:SetCfgID(1000970000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100098] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1034, false, false)
        effect:SetCfgID(1000980000)
        effect:SetParam("runoninit")
        do
          local upper = effect
          local effect = EffectFactory.CreateTimelineEffect(1299, false, false)
          effect:SetCfgID(100098000000)
          upper:SetParam("alternative", effect)
        end
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(9, 17, 3, 1, false)
        effect:SetCfgID(1000980001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1135, false, false)
        effect:SetCfgID(1000980002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100100] = function(args)
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
        local effect = EffectFactory.CreateAnimationEffect("EventItem/t1_m_ant_01", "ant_01")
        effect:SetCfgID(1001000001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("EventItem/t1_m_ant_03", "ant_03")
        effect:SetCfgID(1001000002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100101] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(3, 10, 2, 1, true)
        effect:SetCfgID(1001010000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100102] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1037, false, false)
        effect:SetCfgID(1001020000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100104] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(8, 25, 8, 1, true)
        effect:SetCfgID(1001040000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100105] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(9, 17, 3, 1, true)
        effect:SetCfgID(1001050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100106)
        effect:SetCfgID(1001050001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100107] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1039, false, false)
        effect:SetCfgID(1001070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_t1_27m", false)
        effect:SetCfgID(1001070001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100108] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1040, false, false)
        effect:SetCfgID(1001080000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100109] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 59)
        effect:SetCfgID(1001090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100112] = function(args)
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
        local effect = EffectFactory.CreateSpeedChangeEffect("[actor]", 0.85)
        effect:SetCfgID(1001120000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100113] = function(args)
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
        local effect = EffectFactory.CreateSpeedChangeEffect("[actor]", 0.85)
        effect:SetCfgID(1001130000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100115] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("mon_t1_27m", true)
        effect:SetCfgID(1001150000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100116] = function(args)
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
        effect:SetCfgID(1001160000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 59)
        effect:SetCfgID(1001160001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1042, false, false)
        effect:SetCfgID(1001160002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_t1_27m", false)
        effect:SetCfgID(1001160003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1001160004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100117] = function(args)
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
        effect:SetCfgID(1001170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 1, 8.6, 0, -3.13, true)
        effect:SetCfgID(1001170001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 1, 9.05, 0, -3.13, true)
        effect:SetCfgID(1001170003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(2, "[actor]")
        effect:SetCfgID(1001170004)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1052, false, false)
        effect:SetCfgID(1001170005)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDestroyEffect("t1_m_item_03")
        effect:SetCfgID(1001170006)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1001170008)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100118] = function(args)
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
        local effect = EffectFactory.CreateDestroyEffect("[sceneobject 15]")
        effect:SetCfgID(1001180000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100119] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1043, false, false)
        effect:SetCfgID(1001190000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100121] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("EventItem", true)
        effect:SetCfgID(1001210000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(6, 7, 1, 1, true)
        effect:SetCfgID(1001210003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(11, 11, 1, 1, true)
        effect:SetCfgID(1001210005)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(15, 12, 1, 1, true)
        effect:SetCfgID(1001210006)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100122] = function(args)
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
        effect:SetCfgID(1001220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 1, 9, 0, -10.5, true)
        effect:SetCfgID(1001220001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(2, "[actor]")
        effect:SetCfgID(1001220002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1051, false, false)
        effect:SetCfgID(1001220003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDestroyEffect("t1_m_item_03")
        effect:SetCfgID(1001220004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1001220005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100123] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 1224)
        effect:SetCfgID(1001230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("EventItem/t1_m_npc_01c", "HandDown")
        effect:SetCfgID(1001230000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100127] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(10, 38, 1, 1, true)
        effect:SetCfgID(1001270000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100128] = function(args)
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
        effect:SetCfgID(1001280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.75, 6.8, 0, -10.19, true)
        effect:SetCfgID(1001280001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(0, "[actor]")
        effect:SetCfgID(1001280002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1053, false, false)
        effect:SetCfgID(1001280003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDestroyEffect("t1_m_item_05(Clone)")
        effect:SetCfgID(1001280004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1001280008)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpBackEffect()
        effect:SetCfgID(1001280009)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100129] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 80)
        effect:SetCfgID(1001290000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100130] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(11, 11, 1, 1, true)
        effect:SetCfgID(1001300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBGMEffect("play", 2)
        effect:SetCfgID(1001300001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1045, false, false)
        effect:SetCfgID(1001300002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1001300003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_t1_03m", true)
        effect:SetCfgID(1001300004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100132] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(9, 0, 2, 3, false)
        effect:SetCfgID(1001320100)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(13, 0, 2, 3, false)
        effect:SetCfgID(1001320100)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1038, false, false)
        effect:SetCfgID(1001320100)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100133] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(30, 13, 2, 3, false)
        effect:SetCfgID(1001330100)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1044, false, false)
        effect:SetCfgID(1001330100)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100182] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1102, false, false)
        effect:SetCfgID(100182010018200)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100182010018202)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100183] = function(args)
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
        effect:SetCfgID(100183010018300)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1105, false, false)
        effect:SetCfgID(100183010018301)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100183010018302)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100184] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1104, false, false)
        effect:SetCfgID(100184010018400)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100184010018400)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100186] = function(args)
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
        effect:SetCfgID(100186010018600)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3001, true, false)
        effect:SetCfgID(100186010018601)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100186010018602)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100187] = function(args)
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
        effect:SetCfgID(100187010018700)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1121, false, false)
        effect:SetCfgID(100187010018700)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(2, "[actor]")
        effect:SetCfgID(100187010018701)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100187010018705)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100188] = function(args)
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
        effect:SetCfgID(100188010018800)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3002, true, false)
        effect:SetCfgID(100188010018801)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100188010018802)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100189] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "9")
        effect:SetCfgID(100189010018900)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100190] = function(args)
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
        effect:SetCfgID(100190010019000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1111, false, false)
        effect:SetCfgID(100190010019001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100190010019002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100191] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1112, false, false)
        effect:SetCfgID(100191010019104)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100192] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1113, false, false)
        effect:SetCfgID(1.00192010019201E19)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100194] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(100194010019400)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_w1_38m", true)
        effect:SetCfgID(1.0019401001940101E19)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100195] = function(args)
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
        effect:SetCfgID(1001950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1115, false, false)
        effect:SetCfgID(1001950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_t1_27m", false)
        effect:SetCfgID(1001950001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1001950002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100197] = function(args)
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
        effect:SetCfgID(100197010019700)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3003, true, false)
        effect:SetCfgID(100197010019700)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(100197010019700)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100199] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1001990000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_w1_38m", false)
        effect:SetCfgID(1001990001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100200] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(25, 39, 1, 1, true)
        effect:SetCfgID(1002000000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100201] = function(args)
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
          local effect = EffectFactory.CreateTimelineEffect(1035, false, false)
          effect:SetCfgID(100201000500)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
        end
        do
          local upper = effect
          local effect = EffectFactory.CreateTimelineEffect(1136, false, false)
          effect:SetCfgID(100201000500)
          root:AddEffect(effect)
        end
        do
          local upper = effect
          local effect = EffectFactory.CreateBlockChangeEffect(9, 24, 3, 1, false)
          effect:SetCfgID(100201000501)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
        end
        if upper then
          upper:AddEffect(root)
        end
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100202] = function(args)
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
        effect:SetCfgID(1002020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.65, 5.4, 0, -13, true)
        effect:SetCfgID(1002020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1119, false, false)
        effect:SetCfgID(1002020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002020000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100203] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1002030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Particle_XiaYu", true)
        effect:SetCfgID(1002030000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100204] = function(args)
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
        effect:SetCfgID(1002040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1120, false, false)
        effect:SetCfgID(1002040001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1002040002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(12025, 2)
        effect:SetCfgID(1002040005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100205] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1109, false, false)
        effect:SetCfgID(1002050000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100206] = function(args)
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
        effect:SetCfgID(1002060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", true)
        effect:SetCfgID(1002060001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1122, false, false)
        effect:SetCfgID(1002060002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002060003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002060004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100207] = function(args)
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
        effect:SetCfgID(1002070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1123, false, false)
        effect:SetCfgID(1002070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002070000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100208] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100504)
        effect:SetCfgID(1002080000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(1002080000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1420, false, false)
        effect:SetCfgID(1002080000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002080000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100209] = function(args)
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
        effect:SetCfgID(1002090000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1125, false, false)
        effect:SetCfgID(1002090000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002090000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDestroyEffect("Story_1")
        effect:SetCfgID(1002090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100210] = function(args)
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
        effect:SetCfgID(1002100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1126, false, false)
        effect:SetCfgID(1002100001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100211] = function(args)
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
        effect:SetCfgID(1002110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1127, false, false)
        effect:SetCfgID(1002110000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100212] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1002120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100213] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002130000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1002130000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100214] = function(args)
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
        effect:SetCfgID(1002140001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1132, false, false)
        effect:SetCfgID(1002140002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002140003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100215] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1149, false, false)
        effect:SetCfgID(1002150000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100216] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1133, false, false)
        effect:SetCfgID(1002160000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100217] = function(args)
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
        local effect = EffectFactory.CreateDestroyEffect("Sence_TX_Prefab_ChuanSongJing")
        effect:SetCfgID(1002170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100216)
        effect:SetCfgID(1002170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Tunnel/glass", true)
        effect:SetCfgID(1002170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100218] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Sence_TX_Prefab_ChuanSongJing", true)
        effect:SetCfgID(1002180000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Tunnel/glass", true)
        effect:SetCfgID(1002180000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(20, 8, 1, 1, false)
        effect:SetCfgID(1002180000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100219] = function(args)
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
        effect:SetCfgID(1002190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3006, true, false)
        effect:SetCfgID(1002190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("t1_door_02a", false)
        effect:SetCfgID(1002190000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(8, "[actor]")
        effect:SetCfgID(1002190000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100220] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002200000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100221] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100220)
        effect:SetCfgID(1002210000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100223] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(20, 23, 5, 1, false)
        effect:SetCfgID(1002230000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("t1_door_01a", false)
        effect:SetCfgID(1002230000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100109)
        effect:SetCfgID(1002230000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100224] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("char_010m_01", false)
        effect:SetCfgID(1002240000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("char_010m_02", false)
        effect:SetCfgID(1002240000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_t1_27obj", true)
        effect:SetCfgID(1002240001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(19, 10, 1, 1, true)
        effect:SetCfgID(1002240002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100225] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002250000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100226] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002260000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100227] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002270000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100228] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002280000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100229] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002290000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100230] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002300000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100231] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002310000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100232] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002320000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100233] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002330000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100234] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002340000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100235] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002350000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100236] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002360000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100237] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002370000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100238] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002380000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100239] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002390000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100240] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002400000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100241] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002410000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100242] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002420000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100243] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002430000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100244] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002440000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100245] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002450000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100246] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002460000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100247] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002470000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100248] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", true)
        effect:SetCfgID(1002480000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100249] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100185)
        effect:SetCfgID(1002490000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100250] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(5, "3")
        effect:SetCfgID(1002500000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100251] = function(args)
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
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("Map Data/Ground/t1_m_statue_01(Clone)", "loadState", 1, "", 0)
        effect:SetCfgID(1002510001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("Map Data/Ground/t1_m_statue_02(Clone)", "loadState", 1, "", 0)
        effect:SetCfgID(1002510002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100253] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(20, 8, 1, 1, true)
        effect:SetCfgID(1002530000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100254] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(31, 6, 3, 1, false)
        effect:SetCfgID(1002540000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100255] = function(args)
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
        effect:SetCfgID(1002550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 1, 2.79, 0, -10.15, true)
        effect:SetCfgID(1002550001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTurnEffect(2, "[actor]")
        effect:SetCfgID(1002550002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1137, false, false)
        effect:SetCfgID(1002550003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("t1_m_item_03", false)
        effect:SetCfgID(1002550004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002550005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100256] = function(args)
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
        effect:SetCfgID(1002560000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1138, false, false)
        effect:SetCfgID(1002560001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.85, 8.35, 0, -9.08, true)
        effect:SetCfgID(1002560002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1198, false, false)
        effect:SetCfgID(1002560003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_t1_03m", false)
        effect:SetCfgID(1002560004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002560005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100257] = function(args)
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
        effect:SetCfgID(1002570000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 1, 8.55, 0, -6.66, true)
        effect:SetCfgID(1002570001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1139, false, false)
        effect:SetCfgID(1002570002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("t1_m_item_03", false)
        effect:SetCfgID(1002570005)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1140, false, false)
        effect:SetCfgID(1002570006)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002570008)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100259] = function(args)
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
        effect:SetCfgID(1002590000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1144, false, false)
        effect:SetCfgID(1002590001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002590002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100260] = function(args)
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
        effect:SetCfgID(1002600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3010, true, false)
        effect:SetCfgID(1002600001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002600002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("char_013m", false)
        effect:SetCfgID(1002600003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100261] = function(args)
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
        effect:SetCfgID(1002610000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1143, false, false)
        effect:SetCfgID(1002610001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002610002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100262] = function(args)
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
        effect:SetCfgID(1002620000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3010, true, false)
        effect:SetCfgID(1002620001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002620002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100263] = function(args)
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
        effect:SetCfgID(1002630001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1156, false, false)
        effect:SetCfgID(1002630002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002630003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100264] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("char_010m_01", false)
        effect:SetCfgID(1002640001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("char_010m_02", true)
        effect:SetCfgID(1002640001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100265] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1145, false, false)
        effect:SetCfgID(1002650000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("char_001m2", false)
        effect:SetCfgID(1002650001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100266] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1146, false, false)
        effect:SetCfgID(1002660000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/Char_Cat", false)
        effect:SetCfgID(1002660001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100267] = function(args)
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
        effect:SetCfgID(1002670000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.8, 1, 0, -10.33, true)
        effect:SetCfgID(1002670000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1147, false, false)
        effect:SetCfgID(1002670000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002670001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1002670002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100268)
        effect:SetCfgID(1002670003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100268] = function(args)
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
        effect:SetCfgID(1002680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.8, 8.05, 0, -12.8, true)
        effect:SetCfgID(1002680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1148, false, false)
        effect:SetCfgID(1002680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002680001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1002680002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100267)
        effect:SetCfgID(1002680003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100269] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002690001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_w1_48m", false)
        effect:SetCfgID(1002690001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_w1_49m", false)
        effect:SetCfgID(1002690001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100270] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", true)
        effect:SetCfgID(1002700001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100271] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(3009, true, false)
        effect:SetCfgID(1002710000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002710000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100272] = function(args)
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
        effect:SetCfgID(1002720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.8, 5, 0, -6.845, true)
        effect:SetCfgID(1002720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1150, false, false)
        effect:SetCfgID(1002720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002720000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100274] = function(args)
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
        effect:SetCfgID(1002740000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 1, 4, 0, -12.32, true)
        effect:SetCfgID(1002740001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1152, false, false)
        effect:SetCfgID(1002740002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002740003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002740004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("n_w2_11", false)
        effect:SetCfgID(1002740005)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100276] = function(args)
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
        effect:SetCfgID(1002760002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1157, false, false)
        effect:SetCfgID(1002760003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002760004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100277] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100263)
        effect:SetCfgID(1002770000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100278] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(5, "5")
        effect:SetCfgID(1002780000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100279] = function(args)
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
        effect:SetCfgID(1002790000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1292, false, false)
        effect:SetCfgID(1002790000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "29")
        effect:SetCfgID(1002790000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002790000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100280] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100279)
        effect:SetCfgID(1002800000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100281] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1154, false, false)
        effect:SetCfgID(1002810001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100282] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(3011, true, false)
        effect:SetCfgID(1002820000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100285] = function(args)
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
        effect:SetCfgID(1002850000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100268)
        effect:SetCfgID(1002850001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1188, false, false)
        effect:SetCfgID(1002850002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002850003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100286] = function(args)
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
        effect:SetCfgID(1002860000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100286)
        effect:SetCfgID(1002860000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1189, false, false)
        effect:SetCfgID(1002860002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002860003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100287] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", true)
        effect:SetCfgID(1002870000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100288] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100289)
        effect:SetCfgID(1002880000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100289] = function(args)
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
        local effect = EffectFactory.CreateAddEventEffect(100289)
        effect:SetCfgID(1002890000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100290] = function(args)
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
        effect:SetCfgID(1002900000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.85, 8.4, 0, -6.25, true)
        effect:SetCfgID(1002900000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1160, false, false)
        effect:SetCfgID(1002900000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002900000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100291] = function(args)
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
        effect:SetCfgID(1002910000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1162, false, false)
        effect:SetCfgID(1002910001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002910002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100292] = function(args)
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
        effect:SetCfgID(1002920000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1161, false, false)
        effect:SetCfgID(1002920001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002920002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100293] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002930000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100294] = function(args)
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
        effect:SetCfgID(1002940000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1163, false, false)
        effect:SetCfgID(1002940001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002940003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("n_w2_12", false)
        effect:SetCfgID(1002940004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100295] = function(args)
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
        effect:SetCfgID(1002950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3014, true, false)
        effect:SetCfgID(1002950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002950000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100296] = function(args)
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
        effect:SetCfgID(1002960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1164, false, false)
        effect:SetCfgID(1002960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002960000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100297] = function(args)
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
        effect:SetCfgID(1002970000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1166, false, false)
        effect:SetCfgID(1002970000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002970000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100298] = function(args)
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
        effect:SetCfgID(1002980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFlyToEffect("[actor]", 11, 5, true)
        effect:SetCfgID(1002980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1165, false, false)
        effect:SetCfgID(1002980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1002980000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100299] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1002990000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100300] = function(args)
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
        effect:SetCfgID(1003000000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3015, true, false)
        effect:SetCfgID(1003000000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003000000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100301] = function(args)
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
        effect:SetCfgID(1003010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1167, false, false)
        effect:SetCfgID(1003010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003010000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100302] = function(args)
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
  [100303] = function(args)
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
        effect:SetCfgID(1003030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1168, false, false)
        effect:SetCfgID(1003030001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDestroyEffect("mon_t1_03m")
        effect:SetCfgID(1003030002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003030003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100304] = function(args)
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
        effect:SetCfgID(1003040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.85, 3.8, 0, -5.62, true)
        effect:SetCfgID(1003040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1169, false, false)
        effect:SetCfgID(1003040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003040000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100305] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1170, false, false)
        effect:SetCfgID(1003050000)
        effect:SetParam("runoninit")
        do
          local upper = effect
          local effect = EffectFactory.CreateTimelineEffect(1300, false, false)
          effect:SetCfgID(100305000000)
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
  [100306] = function(args)
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
        effect:SetCfgID(1003060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1171, false, false)
        effect:SetCfgID(1003060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/Char_Cat", false)
        effect:SetCfgID(1003060000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003060000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100307] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(17, 26, 1, 2, true)
        effect:SetCfgID(1003070000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100308] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1003080000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(18, 25, 1, 1, true)
        effect:SetCfgID(1003080000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100309] = function(args)
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
        effect:SetCfgID(1003090000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1003090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(18, 25, 1, 1, true)
        effect:SetCfgID(1003090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2/Char_Cat", true)
        effect:SetCfgID(1003090001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1173, false, false)
        effect:SetCfgID(1003090003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2/Char_Cat", false)
        effect:SetCfgID(1003090004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
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
          local effect = EffectFactory.CreateTimelineEffect(1212, false, false)
          effect:SetCfgID(100309000506)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
        end
        do
          local upper = effect
          local effect = EffectFactory.CreateTimelineEffect(1216, false, false)
          effect:SetCfgID(100309000507)
          root:AddEffect(effect)
        end
        if upper then
          upper:AddEffect(root)
        end
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(17, 26, 1, 2, false)
        effect:SetCfgID(1003090008)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003090009)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100310] = function(args)
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
        effect:SetCfgID(1003100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1174, false, false)
        effect:SetCfgID(1003100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003100000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100311] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1003110000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003110001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100312] = function(args)
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
        effect:SetCfgID(1003120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFlyToEffect("[actor]", 9, 16, true)
        effect:SetCfgID(1003120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1175, false, false)
        effect:SetCfgID(1003120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003120000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100313] = function(args)
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
        effect:SetCfgID(1003130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1176, false, false)
        effect:SetCfgID(1003130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003130000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100314] = function(args)
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
        effect:SetCfgID(1003140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1177, false, false)
        effect:SetCfgID(1003140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003140000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003140000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100315] = function(args)
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
        effect:SetCfgID(1003150000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1178, false, false)
        effect:SetCfgID(1003150000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003150000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100316] = function(args)
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
        effect:SetCfgID(1003160000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1179, false, false)
        effect:SetCfgID(1003160000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003160000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100317] = function(args)
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
        effect:SetCfgID(1003170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1180, false, false)
        effect:SetCfgID(1003170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("boss_w2_04m", false)
        effect:SetCfgID(1003170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003170000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100318] = function(args)
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
        effect:SetCfgID(1003180000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1181, false, false)
        effect:SetCfgID(1003180000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003180000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100319] = function(args)
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
        effect:SetCfgID(1003190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3017, true, false)
        effect:SetCfgID(1003190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003190000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100320] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003200000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1003200000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100321] = function(args)
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
        effect:SetCfgID(1003210000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1183, false, false)
        effect:SetCfgID(1003210000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/Char_Cat", false)
        effect:SetCfgID(1003210001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003210002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100322] = function(args)
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
        effect:SetCfgID(1003220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1184, false, false)
        effect:SetCfgID(1003220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003220000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100323] = function(args)
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
        effect:SetCfgID(1003230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1185, false, false)
        effect:SetCfgID(1003230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003230000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100324] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003240000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100325] = function(args)
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
        effect:SetCfgID(1003250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1186, false, false)
        effect:SetCfgID(1003250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003250000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100326] = function(args)
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
        effect:SetCfgID(1003260000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1187, false, false)
        effect:SetCfgID(1003260000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003260000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100327] = function(args)
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
        effect:SetCfgID(1003270000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1190, false, false)
        effect:SetCfgID(1003270000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003270000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100328] = function(args)
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
        effect:SetCfgID(1003280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1192, false, false)
        effect:SetCfgID(1003280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003280000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100329] = function(args)
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
        effect:SetCfgID(1003290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1191, false, false)
        effect:SetCfgID(1003290001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003290003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "14")
        effect:SetCfgID(1003290004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100330] = function(args)
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
        effect:SetCfgID(1003300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1193, false, false)
        effect:SetCfgID(1003300002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003300004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003300005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100335] = function(args)
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
        effect:SetCfgID(1003350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1195, false, false)
        effect:SetCfgID(1003350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003350000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100336] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1003360000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003360000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100337] = function(args)
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
        effect:SetCfgID(1003370000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1196, false, false)
        effect:SetCfgID(1003370000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003370000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100338] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1003380000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003380000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100339] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1197, false, false)
        effect:SetCfgID(1003390000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100340] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100339)
        effect:SetCfgID(1003400000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100341] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1003410000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003410001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100342] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003420000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100343] = function(args)
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
        local effect = EffectFactory.CreateFlyToEffect("actor", 12, 13, true)
        effect:SetCfgID(1003430001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100344] = function(args)
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
        effect:SetCfgID(1003440001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1213, false, false)
        effect:SetCfgID(1003440002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003440007)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100345] = function(args)
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
        effect:SetCfgID(1003450001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1215, false, false)
        effect:SetCfgID(1003450002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003450003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100346] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("[portal 17]", false)
        effect:SetCfgID(1003460000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("[portal 18]", false)
        effect:SetCfgID(1003460000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100347] = function(args)
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
        local effect = EffectFactory.CreateBlockChangeEffect(31, 6, 3, 1, true)
        effect:SetCfgID(1003470000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100348] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("n_w2_11", true)
        effect:SetCfgID(1003480000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100349] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_3", true)
        effect:SetCfgID(1003490000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100350] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 243)
        effect:SetCfgID(1003500000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100351] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100350)
        effect:SetCfgID(1003510000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100352] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1217, false, false)
        effect:SetCfgID(1003520000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100353] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1218, false, false)
        effect:SetCfgID(1003530000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100354] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("SceneBreak", true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("SceneBreak2", true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("SceneBreak3", true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("SceneBreak4", true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Sence_TX_W2_guochang_fazhen", false)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(7, 15, 2, 2, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(9, 16, 3, 2, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(12, 17, 2, 2, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(18, 16, 2, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(17, 17, 3, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(7, 9, 1, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(7, 10, 2, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(9, 10, 2, 2, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(18, 11, 2, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(12, 21, 1, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(12, 32, 1, 2, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(16, 44, 1, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(15, 53, 1, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(15, 54, 2, 1, true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100355] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1003550000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100356] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(4, "24")
        effect:SetCfgID(1003560000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100357] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1220, false, false)
        effect:SetCfgID(1003570000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100358] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003580000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100359] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003590000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100360] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003600000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100361] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003610000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100362] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003620000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100363] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003630000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100364] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003640000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100365] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003650000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100366] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003660000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100367] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003670000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100368] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003680000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100369] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003690000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100370] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003700000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100371] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003710000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100372] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003720000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100373] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003730000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100374] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003740000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100375] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003750000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100376] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003760000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100377] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003770000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100378] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003780000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100379] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003790000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100380] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003800000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100381] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003810000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100382] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003820000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100383] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003830000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100384] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003840000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100385] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003850000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100386] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003860000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100387] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003870000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100388] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003880000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100389] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003890000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100390] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003900000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100391] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003910000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100392] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("DungeonCameraGroup/MainCamera/Effect", false)
        effect:SetCfgID(1003920000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100393] = function(args)
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
        effect:SetCfgID(1003930000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1221, false, false)
        effect:SetCfgID(1003930000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1003930000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100395] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 256)
        effect:SetCfgID(1003950000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100396] = function(args)
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
        local effect = EffectFactory.CreateBGMEffect("play", 234)
        effect:SetCfgID(1003960000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100401] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("mon_t1_27m", false)
        effect:SetCfgID(1004010000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1226, false, false)
        effect:SetCfgID(1004010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(11, "1")
        effect:SetCfgID(1004010001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100402] = function(args)
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
        effect:SetCfgID(1004020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1172, false, false)
        effect:SetCfgID(1004020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004020000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100403] = function(args)
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
        effect:SetCfgID(1004030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1227, false, false)
        effect:SetCfgID(1004030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004030000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100404] = function(args)
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
        effect:SetCfgID(1004040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1228, false, false)
        effect:SetCfgID(1004040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004040000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100405] = function(args)
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
        effect:SetCfgID(1004050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1230, false, false)
        effect:SetCfgID(1004050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004050000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100406] = function(args)
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
        effect:SetCfgID(1004060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1229, false, false)
        effect:SetCfgID(1004060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004060000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100407] = function(args)
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
        effect:SetCfgID(1004070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1232, false, false)
        effect:SetCfgID(1004070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004070000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100408] = function(args)
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
        effect:SetCfgID(1004080000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3019, true, false)
        effect:SetCfgID(1004080000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004080000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100409] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100410] = function(args)
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
        effect:SetCfgID(1004100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1235, false, false)
        effect:SetCfgID(1004100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004100000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100411] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1004110000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100412] = function(args)
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
        effect:SetCfgID(1004120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1236, false, false)
        effect:SetCfgID(1004120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "13")
        effect:SetCfgID(1004120000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100413] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004130000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100414] = function(args)
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
        effect:SetCfgID(1004140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1238, false, false)
        effect:SetCfgID(1004140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004140000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100415] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004150000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1004150000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100416] = function(args)
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
        effect:SetCfgID(1004160000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1239, false, false)
        effect:SetCfgID(1004160000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004160000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100417] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100418] = function(args)
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
        effect:SetCfgID(1004180000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1240, false, false)
        effect:SetCfgID(1004180000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004180000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100419] = function(args)
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
        effect:SetCfgID(1004190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToEffect("[actor]", 0.85, 9, 12, true)
        effect:SetCfgID(1004190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1241, false, false)
        effect:SetCfgID(1004190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004190000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100420] = function(args)
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
        effect:SetCfgID(1004200000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1242, false, false)
        effect:SetCfgID(1004200000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1004200000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004200000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100421] = function(args)
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
        effect:SetCfgID(1004210000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1243, false, false)
        effect:SetCfgID(1004210000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("Sence_TX_GuoChang_Jingzi_binghuo", "trapState", 1, "", 0)
        effect:SetCfgID(1004210000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004210000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4/ChairCat/Char_Cat", false)
        effect:SetCfgID(1004210000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(10031, 1)
        effect:SetCfgID(1004210000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100422] = function(args)
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
        effect:SetCfgID(1004220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 1, 4.8, 0, -5.8, true)
        effect:SetCfgID(1004220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1244, false, false)
        effect:SetCfgID(1004220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(14, 10, 1, 1, true)
        effect:SetCfgID(1004220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004220000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100423] = function(args)
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
        effect:SetCfgID(1004230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1245, false, false)
        effect:SetCfgID(1004230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004230000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100424] = function(args)
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
        effect:SetCfgID(1004240000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1246, false, false)
        effect:SetCfgID(1004240000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004240000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004240000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100426] = function(args)
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
  [100427] = function(args)
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
        effect:SetCfgID(1004270000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1249, false, false)
        effect:SetCfgID(1004270000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004270000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100428] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004280000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", true)
        effect:SetCfgID(1004280000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100429] = function(args)
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
        effect:SetCfgID(1004290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1250, false, false)
        effect:SetCfgID(1004290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004290000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100430] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004300000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1004300000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100431] = function(args)
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
        effect:SetCfgID(1004310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1254, false, false)
        effect:SetCfgID(1004310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004310000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100432] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004320000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", true)
        effect:SetCfgID(1004320000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100433] = function(args)
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
        effect:SetCfgID(1004330000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1255, false, false)
        effect:SetCfgID(1004330000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004330000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100434] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_4", false)
        effect:SetCfgID(1004340000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004340000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100435] = function(args)
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
        effect:SetCfgID(1004350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1253, false, false)
        effect:SetCfgID(1004350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004350000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100436] = function(args)
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
        effect:SetCfgID(1004360000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1257, false, false)
        effect:SetCfgID(1004360000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004360000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100437] = function(args)
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
        effect:SetCfgID(1004370000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1258, false, false)
        effect:SetCfgID(1004370000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004370000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004370000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100438] = function(args)
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
        effect:SetCfgID(1004380000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1259, false, false)
        effect:SetCfgID(1004380000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004380000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100439] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004390000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", true)
        effect:SetCfgID(1004390000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100440] = function(args)
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
        effect:SetCfgID(1004400000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1260, false, false)
        effect:SetCfgID(1004400000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004400000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100441] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004410000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", false)
        effect:SetCfgID(1004410000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100442] = function(args)
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
        effect:SetCfgID(1004420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1262, false, false)
        effect:SetCfgID(1004420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004420000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100443] = function(args)
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
        effect:SetCfgID(1004430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1263, false, false)
        effect:SetCfgID(1004430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004430000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100444] = function(args)
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
        effect:SetCfgID(1004440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1264, false, false)
        effect:SetCfgID(1004440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004440000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100445] = function(args)
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
        effect:SetCfgID(1004450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1265, false, false)
        effect:SetCfgID(1004450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004450000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100446] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004460000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1004460000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100447] = function(args)
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
        effect:SetCfgID(1004470000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1266, false, false)
        effect:SetCfgID(1004470000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004470000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100448] = function(args)
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
        effect:SetCfgID(1004480000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1267, false, false)
        effect:SetCfgID(1004480000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004480000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100449] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004490000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004490000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", true)
        effect:SetCfgID(1004490000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100450] = function(args)
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
        effect:SetCfgID(1004500000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1269, false, false)
        effect:SetCfgID(1004500000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004500000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004500000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "23")
        effect:SetCfgID(1004500000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100451] = function(args)
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
        effect:SetCfgID(1004510000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1270, false, false)
        effect:SetCfgID(1004510000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004510000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100452] = function(args)
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
        effect:SetCfgID(1004520000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1271, false, false)
        effect:SetCfgID(1004520000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004520000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100453] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004530000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100454] = function(args)
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
        effect:SetCfgID(1004540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1273, false, false)
        effect:SetCfgID(1004540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004540000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100455] = function(args)
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
        effect:SetCfgID(1004550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1274, false, false)
        effect:SetCfgID(1004550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004550000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100456] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004560000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100457] = function(args)
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
        effect:SetCfgID(1004570000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1276, false, false)
        effect:SetCfgID(1004570000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004570000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004570000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100458] = function(args)
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
        effect:SetCfgID(1004580000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1277, false, false)
        effect:SetCfgID(1004580000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004580000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100459] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Broken", false)
        effect:SetCfgID(1004590000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_6", true)
        effect:SetCfgID(1004590000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(16, 50, 1, 2, true)
        effect:SetCfgID(1004590000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(17, 49, 1, 4, true)
        effect:SetCfgID(1004590000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100460] = function(args)
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
        effect:SetCfgID(1004600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1278, false, false)
        effect:SetCfgID(1004600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(14028, 1)
        effect:SetCfgID(1004600000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100461] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_6", false)
        effect:SetCfgID(1004610000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1004610000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Broken", false)
        effect:SetCfgID(1004610000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(16, 50, 1, 2, true)
        effect:SetCfgID(1004610000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBlockChangeEffect(17, 49, 1, 4, true)
        effect:SetCfgID(1004610000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100462] = function(args)
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
        effect:SetCfgID(1004620000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateMoveToWorldPosEffect("[actor]", 0.85, 8.94, 0, -11.93, true)
        effect:SetCfgID(1004620000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1280, false, false)
        effect:SetCfgID(1004620000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1004620000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004620000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100463] = function(args)
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
        effect:SetCfgID(1004630000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1281, false, false)
        effect:SetCfgID(1004630000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004630000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100464] = function(args)
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
        effect:SetCfgID(1004640000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1282, false, false)
        effect:SetCfgID(1004640000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004640000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100465] = function(args)
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
        effect:SetCfgID(1004650000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1283, false, false)
        effect:SetCfgID(1004650000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004650000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100466] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004660000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100467] = function(args)
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
        effect:SetCfgID(1004670000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1284, false, false)
        effect:SetCfgID(1004670000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004670000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100468] = function(args)
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
        effect:SetCfgID(1004680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1285, false, false)
        effect:SetCfgID(1004680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpBackEffect(false)
        effect:SetCfgID(1004680000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100469] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004690000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1004690000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100470] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004700000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1004700000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", true)
        effect:SetCfgID(1004700000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFreezeEffect(true)
        effect:SetCfgID(1004700000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1288, false, false)
        effect:SetCfgID(1004700000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004700000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100471] = function(args)
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
        effect:SetCfgID(1004710000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1289, false, false)
        effect:SetCfgID(1004710000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1004710000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004710000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100472] = function(args)
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
        effect:SetCfgID(1004720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1290, false, false)
        effect:SetCfgID(1004720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Sence_TX_W2_BaoShiPingZhangMen", false)
        effect:SetCfgID(1004720000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(4, "22")
        effect:SetCfgID(1004720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(14037, 1)
        effect:SetCfgID(1004720001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100473] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1291, false, false)
        effect:SetCfgID(1004730000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateStartChatEffect(1223)
        effect:SetCfgID(1004730000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100474] = function(args)
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
        effect:SetCfgID(1004740000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1293, false, false)
        effect:SetCfgID(1004740000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "30")
        effect:SetCfgID(1004740000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004740000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100475] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100474)
        effect:SetCfgID(1004750000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("w2_m_village_13", false)
        effect:SetCfgID(1004750000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100476] = function(args)
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
        effect:SetCfgID(1004760000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1248, false, false)
        effect:SetCfgID(1004760000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("n_w2_11", false)
        effect:SetCfgID(1004760000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004760000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100477] = function(args)
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
        effect:SetCfgID(1004770000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1294, false, false)
        effect:SetCfgID(1004770000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1004770000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004770000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100478] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1/char_017m", false)
        effect:SetCfgID(1004780000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1004780000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100479] = function(args)
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
        effect:SetCfgID(1004790000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100480] = function(args)
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
  [100481] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1004810000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100482] = function(args)
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
        local effect = EffectFactory.CreateStartChatEffect(1228)
        effect:SetCfgID(1004820000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100483] = function(args)
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
        effect:SetCfgID(1004830000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1296, false, false)
        effect:SetCfgID(1004830000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("mon_t1_03m", false)
        effect:SetCfgID(1004830000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004830000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100484] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100485)
        effect:SetCfgID(1004840000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100485] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100487)
        effect:SetCfgID(1004850000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100502)
        effect:SetCfgID(1004850002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100486] = function(args)
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
        effect:SetCfgID(1004860000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1297, false, false)
        effect:SetCfgID(1004860000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004860000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBattleEffect(1171)
        effect:SetCfgID(1004860000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100487] = function(args)
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
        effect:SetCfgID(1004870000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1298, false, false)
        effect:SetCfgID(1004870000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004870000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBattleEffect(1172)
        effect:SetCfgID(1004870000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100488] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100463)
        effect:SetCfgID(1004880000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100489] = function(args)
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
  [100490] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1004900000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100491] = function(args)
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
        local effect = EffectFactory.CreateFlyToWorldPosEffect("[actor]", 13, 0, -20, true)
        effect:SetCfgID(1004910000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100492] = function(args)
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
        effect:SetCfgID(1004920000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100493] = function(args)
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
        effect:SetCfgID(1004930000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1128, false, false)
        effect:SetCfgID(1004930000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004930000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100494] = function(args)
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
        effect:SetCfgID(1004940000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1129, false, false)
        effect:SetCfgID(1004940000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004940000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100495] = function(args)
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
        effect:SetCfgID(1004950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(3005, true, false)
        effect:SetCfgID(1004950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimatorStateChangeEffect("[npc 10005]", "NPCstate", 9, "", 0)
        effect:SetCfgID(1004950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004950000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100496] = function(args)
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
        local effect = EffectFactory.CreateFreezeEffect()
        effect:SetCfgID(1004960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1123, false, false)
        effect:SetCfgID(1004960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect()
        effect:SetCfgID(1004960000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100497] = function(args)
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
        effect:SetCfgID(1004970000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1124, false, false)
        effect:SetCfgID(1004970001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateBattleEffect(10008)
        effect:SetCfgID(1004970002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1004970003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100498] = function(args)
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
        effect:SetCfgID(1004980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1285, false, false)
        effect:SetCfgID(1004980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpEffect(13035, 2)
        effect:SetCfgID(1004980003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100499] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1301, false, false)
        effect:SetCfgID(1004990000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1004990000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100500] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(5, "27")
        effect:SetCfgID(1005000000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100501] = function(args)
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
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM02")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "31")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM05")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM06")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM07")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM08")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateAnimationEffect("CM StateDrivenCamera1", "CM01")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100502] = function(args)
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
        local effect = EffectFactory.CreateBattleEffect(1172)
        effect:SetCfgID(1005020000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100503] = function(args)
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
        effect:SetCfgID(1005030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1302, false, false)
        effect:SetCfgID(1005030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005030000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005030000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100504] = function(args)
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
        local effect = EffectFactory.CreateBattleEffect(10008)
        effect:SetCfgID(1005040002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100509] = function(args)
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
        local effect = EffectFactory.CreateBattleEffect(1171)
        effect:SetCfgID(1005090000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100510] = function(args)
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
        effect:SetCfgID(1005100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1308, false, false)
        effect:SetCfgID(1005100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005100000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100511] = function(args)
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
        effect:SetCfgID(1005110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1309, false, false)
        effect:SetCfgID(1005110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005110000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005110000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100512] = function(args)
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
        effect:SetCfgID(1005120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1310, false, false)
        effect:SetCfgID(1005120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005120000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100513] = function(args)
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
        effect:SetCfgID(1005130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1394, false, false)
        effect:SetCfgID(1005130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005130000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005130000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100514] = function(args)
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
        effect:SetCfgID(1005140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1312, false, false)
        effect:SetCfgID(1005140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005140000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100515] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005150000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", true)
        effect:SetCfgID(1005150000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100516] = function(args)
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
        effect:SetCfgID(1005160000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1314, false, false)
        effect:SetCfgID(1005160000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005160000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100517] = function(args)
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
        effect:SetCfgID(1005170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1313, false, false)
        effect:SetCfgID(1005170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("StaticBridge", true)
        effect:SetCfgID(1005170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("AnimationBridge", false)
        effect:SetCfgID(1005170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100518] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005180000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", false)
        effect:SetCfgID(1005180000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100519] = function(args)
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
        effect:SetCfgID(1005190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(0, false, false)
        effect:SetCfgID(1005190000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005190000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100520] = function(args)
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
        effect:SetCfgID(1005200000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(0, false, false)
        effect:SetCfgID(1005200000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005200000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100521] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1316, false, false)
        effect:SetCfgID(1005210001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005210002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100522] = function(args)
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
        effect:SetCfgID(1005220000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1317, false, false)
        effect:SetCfgID(1005220001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005220002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005220003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100523] = function(args)
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
        effect:SetCfgID(1005230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1411, false, false)
        effect:SetCfgID(1005230000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005230000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100524] = function(args)
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
        effect:SetCfgID(1005240000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Tunnel/Cloud/Black", false)
        effect:SetCfgID(1005240000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Tunnel/Cloud/Loop", true)
        effect:SetCfgID(1005240000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1318, false, false)
        effect:SetCfgID(1005240000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005240000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100525] = function(args)
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
        effect:SetCfgID(1005250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1319, false, false)
        effect:SetCfgID(1005250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005250000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100526] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1005260000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005260000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100527] = function(args)
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
        effect:SetCfgID(1005270000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1320, false, false)
        effect:SetCfgID(1005270000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005270000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100528] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005280000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005280000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100529] = function(args)
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
        effect:SetCfgID(1005290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1322, false, false)
        effect:SetCfgID(1005290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1005290000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100530] = function(args)
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
        effect:SetCfgID(1005300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1323, false, false)
        effect:SetCfgID(1005300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005300000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100531] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005310000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1005310000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100532] = function(args)
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
        effect:SetCfgID(1005320000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1324, false, false)
        effect:SetCfgID(1005320000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005320000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100533] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005330000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005330000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100534] = function(args)
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
        effect:SetCfgID(1005340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1326, false, false)
        effect:SetCfgID(1005340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005340000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100535] = function(args)
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
        effect:SetCfgID(1005350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1327, false, false)
        effect:SetCfgID(1005350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005350000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100536] = function(args)
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
        effect:SetCfgID(1005360000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1328, false, false)
        effect:SetCfgID(1005360000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005360000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100537] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005370000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", true)
        effect:SetCfgID(1005370000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005370000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100538] = function(args)
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
        effect:SetCfgID(1005380000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1329, false, false)
        effect:SetCfgID(1005380000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005380000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100539] = function(args)
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
        effect:SetCfgID(1005390000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1330, false, false)
        effect:SetCfgID(1005390000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005390000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100540] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005400000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005400000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1005400000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100541] = function(args)
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
        effect:SetCfgID(1005410000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1332, false, false)
        effect:SetCfgID(1005410000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005410000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100542] = function(args)
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
        effect:SetCfgID(1005420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1333, false, false)
        effect:SetCfgID(1005420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1005420000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100543] = function(args)
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
        effect:SetCfgID(1005430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1334, false, false)
        effect:SetCfgID(1005430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005430000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100544] = function(args)
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
        effect:SetCfgID(1005440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1335, false, false)
        effect:SetCfgID(1005440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005440000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100545] = function(args)
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
        effect:SetCfgID(1005450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1336, false, false)
        effect:SetCfgID(1005450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005450000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100546] = function(args)
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
        local effect = EffectFactory.CreateRemoveEventEffect(100545)
        effect:SetCfgID(1005460000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100547] = function(args)
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
        effect:SetCfgID(1005470000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1337, false, false)
        effect:SetCfgID(1005470000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005470000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100548] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005480000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", true)
        effect:SetCfgID(1005480000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100549] = function(args)
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
        effect:SetCfgID(1005490000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1338, false, false)
        effect:SetCfgID(1005490000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005490000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100550] = function(args)
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
        effect:SetCfgID(1005500000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1339, false, false)
        effect:SetCfgID(1005500000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005500000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100551] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005510000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1005510000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100552] = function(args)
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
        effect:SetCfgID(1005520000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1341, false, false)
        effect:SetCfgID(1005520000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005520000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100553] = function(args)
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
        effect:SetCfgID(1005530000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1342, false, false)
        effect:SetCfgID(1005530000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005530000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100554] = function(args)
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
        effect:SetCfgID(1005540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1343, false, false)
        effect:SetCfgID(1005540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005540000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100555] = function(args)
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
        effect:SetCfgID(1005550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1344, false, false)
        effect:SetCfgID(1005550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005550000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100556] = function(args)
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
        effect:SetCfgID(1005560000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1348, false, false)
        effect:SetCfgID(1005560000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005560000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100557] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005570000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1005570000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100558] = function(args)
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
        effect:SetCfgID(1005580000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1349, false, false)
        effect:SetCfgID(1005580000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005580000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", false)
        effect:SetCfgID(1005580000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100559] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005590000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005590000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", false)
        effect:SetCfgID(1005590000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100560] = function(args)
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
        effect:SetCfgID(1005600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1351, false, false)
        effect:SetCfgID(1005600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005600000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_5", false)
        effect:SetCfgID(1005600000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100561] = function(args)
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
        effect:SetCfgID(1005610000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1352, false, false)
        effect:SetCfgID(1005610000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005610000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005610000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100562] = function(args)
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
        effect:SetCfgID(1005620000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1353, false, false)
        effect:SetCfgID(1005620000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005620000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005620000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100563] = function(args)
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
        effect:SetCfgID(1005630000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1354, false, false)
        effect:SetCfgID(1005630000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005630000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005630000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100564] = function(args)
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
        effect:SetCfgID(1005640000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1355, false, false)
        effect:SetCfgID(1005640000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005640000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005640000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1005640000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100565] = function(args)
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
        effect:SetCfgID(1005650000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1356, false, false)
        effect:SetCfgID(1005650000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005650000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005650000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100566] = function(args)
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
        effect:SetCfgID(1005660000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1357, false, false)
        effect:SetCfgID(1005660000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005660000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100567] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005670000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", true)
        effect:SetCfgID(1005670000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100568] = function(args)
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
        effect:SetCfgID(1005680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1358, false, false)
        effect:SetCfgID(1005680000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005680000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100569] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1005690000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005690000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100570] = function(args)
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
        effect:SetCfgID(1005700000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1360, false, false)
        effect:SetCfgID(1005700000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005700000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1005700000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100571] = function(args)
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
        effect:SetCfgID(1005710000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1361, false, false)
        effect:SetCfgID(1005710000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005710000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100572] = function(args)
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
        effect:SetCfgID(1005720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1362, false, false)
        effect:SetCfgID(1005720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005720000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005720000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100573] = function(args)
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
        effect:SetCfgID(1005730000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1363, false, false)
        effect:SetCfgID(1005730000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005730000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005730000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100574] = function(args)
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
        effect:SetCfgID(1005740000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1364, false, false)
        effect:SetCfgID(1005740000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005740000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100575] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005750000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1005750000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100576] = function(args)
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
        effect:SetCfgID(1005760000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1365, false, false)
        effect:SetCfgID(1005760000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005760000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100577] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005770000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005770000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100578] = function(args)
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
        effect:SetCfgID(1005780000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1379, false, false)
        effect:SetCfgID(1005780000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005780000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005780000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100579] = function(args)
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
        effect:SetCfgID(1005790000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1380, false, false)
        effect:SetCfgID(1005790000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005790000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005790000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100580] = function(args)
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
        effect:SetCfgID(1005800000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1381, false, false)
        effect:SetCfgID(1005800000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005800000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1005800000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100581] = function(args)
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
        effect:SetCfgID(1005810000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1384, false, false)
        effect:SetCfgID(1005810000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005810000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100582] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1005820000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100583] = function(args)
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
        effect:SetCfgID(1005830000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1385, false, false)
        effect:SetCfgID(1005830000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005830000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005830000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100584] = function(args)
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
        effect:SetCfgID(1005840001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1386, false, false)
        effect:SetCfgID(1005840002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005840003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100585] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005850000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005850000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100586] = function(args)
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
        effect:SetCfgID(1005860000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1388, false, false)
        effect:SetCfgID(1005860000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005860000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_5/ChairCat/Char_Cat", false)
        effect:SetCfgID(1005860000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100587] = function(args)
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
        effect:SetCfgID(1005870000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1345, false, false)
        effect:SetCfgID(1005870000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005870000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100588] = function(args)
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
        effect:SetCfgID(1005880000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1346, false, false)
        effect:SetCfgID(1005880000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005880000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100612)
        effect:SetCfgID(1005880000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100589] = function(args)
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
        effect:SetCfgID(1005890000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1347, false, false)
        effect:SetCfgID(1005890000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005890000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1005890000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100590] = function(args)
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
        effect:SetCfgID(1005900000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1367, false, false)
        effect:SetCfgID(1005900000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005900000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100591] = function(args)
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
        effect:SetCfgID(1005910000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1368, false, false)
        effect:SetCfgID(1005910000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005910000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100613)
        effect:SetCfgID(1005910000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100592] = function(args)
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
        effect:SetCfgID(1005920000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1369, false, false)
        effect:SetCfgID(1005920000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005920000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100593] = function(args)
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
        effect:SetCfgID(1005930000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1389, false, false)
        effect:SetCfgID(1005930000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005930000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100594] = function(args)
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
        effect:SetCfgID(1005940000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFlyToEffect("[actor]", 8, 14, true)
        effect:SetCfgID(1005940000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1370, false, false)
        effect:SetCfgID(1005940000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1005940000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1005940000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100595] = function(args)
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
        effect:SetCfgID(1005950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1371, false, false)
        effect:SetCfgID(1005950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005950000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005950000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100596] = function(args)
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
        effect:SetCfgID(1005960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1372, false, false)
        effect:SetCfgID(1005960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005960000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateRemoveEventEffect(100614)
        effect:SetCfgID(1005960000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100597] = function(args)
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
        effect:SetCfgID(1005970000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1373, false, false)
        effect:SetCfgID(1005970000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1005970000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005970000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1005970000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100598] = function(args)
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
        effect:SetCfgID(1005980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1374, false, false)
        effect:SetCfgID(1005980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005980000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1005980000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100599] = function(args)
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
        effect:SetCfgID(1005990000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1375, false, false)
        effect:SetCfgID(1005990000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1005990000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1005990000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100600] = function(args)
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
        effect:SetCfgID(1006000000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1376, false, false)
        effect:SetCfgID(1006000000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006000000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1006000000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100601] = function(args)
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
        effect:SetCfgID(1006010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1377, false, false)
        effect:SetCfgID(1006010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_4", false)
        effect:SetCfgID(1006010000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006010000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100602] = function(args)
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
        effect:SetCfgID(1006020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFlyToEffect("[actor]", 12, 2, true)
        effect:SetCfgID(1006020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1378, false, false)
        effect:SetCfgID(1006020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1006020000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_5", false)
        effect:SetCfgID(1006020000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100603] = function(args)
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
        effect:SetCfgID(1006030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1382, false, false)
        effect:SetCfgID(1006030000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006030000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100604] = function(args)
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
        local effect = EffectFactory.CreateFlyToEffect("[actor]", 12, 2, true)
        effect:SetCfgID(1006040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1006040000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006040000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100605] = function(args)
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
        effect:SetCfgID(1006050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1383, false, false)
        effect:SetCfgID(1006050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1006050000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpBackEffect()
        effect:SetCfgID(1006050000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100606] = function(args)
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
        effect:SetCfgID(1006060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1390, false, false)
        effect:SetCfgID(1006060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006060000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006060000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100607] = function(args)
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
        effect:SetCfgID(1006070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1391, false, false)
        effect:SetCfgID(1006070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006070000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006070000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100608] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("char_001_v1m", false)
        effect:SetCfgID(1006080000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1006080000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100609] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("char_001_v1m", false)
        effect:SetCfgID(1006090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100610] = function(args)
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
        effect:SetCfgID(1006100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1392, false, false)
        effect:SetCfgID(1006100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006100000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1006100000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006100000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("char_001_v1m", false)
        effect:SetCfgID(1006100000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100611] = function(args)
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
        effect:SetCfgID(1006110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1311, false, false)
        effect:SetCfgID(1006110000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006110000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100612] = function(args)
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
        effect:SetCfgID(1006120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1395, false, false)
        effect:SetCfgID(1006120000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006120000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100613] = function(args)
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
        effect:SetCfgID(1006130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1396, false, false)
        effect:SetCfgID(1006130000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006130000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100614] = function(args)
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
        effect:SetCfgID(1006140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1402, false, false)
        effect:SetCfgID(1006140000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006140000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100615] = function(args)
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
        effect:SetCfgID(1006150000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1397, false, false)
        effect:SetCfgID(1006150000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006150000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100616] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("char_001_v1m", false)
        effect:SetCfgID(1006160000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", true)
        effect:SetCfgID(1006160000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100617] = function(args)
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
        effect:SetCfgID(1006170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1398, false, false)
        effect:SetCfgID(1006170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006170000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1006170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100618] = function(args)
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
        local effect = EffectFactory.CreateVisualEffect("char_001_v1m", false)
        effect:SetCfgID(1006180000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006180000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100619] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1403, false, false)
        effect:SetCfgID(1006190000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100620] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1404, false, false)
        effect:SetCfgID(1006200000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100621] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1405, false, false)
        effect:SetCfgID(1006210000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100622] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1406, false, false)
        effect:SetCfgID(1006220000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100623] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1407, false, false)
        effect:SetCfgID(1006230000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100624] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1408, false, false)
        effect:SetCfgID(1006240000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100625] = function(args)
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
        effect:SetCfgID(1006250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1409, false, false)
        effect:SetCfgID(1006250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006250000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006250000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100626] = function(args)
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
        effect:SetCfgID(1006260000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1410, false, false)
        effect:SetCfgID(1006260000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006260000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006260000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100627] = function(args)
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
        local effect = EffectFactory.CreateDialogEffect(2, "39")
        effect:SetCfgID(1006270000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100628] = function(args)
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
        effect:SetCfgID(1006280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1412, false, false)
        effect:SetCfgID(1006280000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006280000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100629] = function(args)
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
        effect:SetCfgID(1006290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1413, false, false)
        effect:SetCfgID(1006290000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006290000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100630] = function(args)
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
        effect:SetCfgID(1006300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(2, "72")
        effect:SetCfgID(1006300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006300000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1134, false, false)
        effect:SetCfgID(1006300001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/Char_Cat", false)
        effect:SetCfgID(1006300002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100631] = function(args)
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
        effect:SetCfgID(1006310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1414, false, false)
        effect:SetCfgID(1006310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006310000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006310000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100632] = function(args)
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
        effect:SetCfgID(1006320000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1415, false, false)
        effect:SetCfgID(1006320000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006320000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100633] = function(args)
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
        effect:SetCfgID(1006330000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1416, false, false)
        effect:SetCfgID(1006330000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006330000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100634] = function(args)
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
        effect:SetCfgID(1006340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1417, false, false)
        effect:SetCfgID(1006340000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006340000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100635] = function(args)
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
        effect:SetCfgID(1006350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1421, false, false)
        effect:SetCfgID(1006350000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006350000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100636] = function(args)
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
        effect:SetCfgID(1006360000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1422, false, false)
        effect:SetCfgID(1006360000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006360000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100637] = function(args)
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
        effect:SetCfgID(1006370000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1423, false, false)
        effect:SetCfgID(1006370000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/char_055m", false)
        effect:SetCfgID(1006370000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006370000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100638] = function(args)
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
        effect:SetCfgID(1006380000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1424, false, false)
        effect:SetCfgID(1006380000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006380000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100639] = function(args)
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
        effect:SetCfgID(1006390000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1425, false, false)
        effect:SetCfgID(1006390000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006390000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006390000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100640] = function(args)
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
        effect:SetCfgID(1006400000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1426, false, false)
        effect:SetCfgID(1006400000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006400000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006400000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100641] = function(args)
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
        effect:SetCfgID(1006410000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1427, false, false)
        effect:SetCfgID(1006410000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006410000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1006410000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006410000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100642] = function(args)
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
        effect:SetCfgID(1006420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1419, false, false)
        effect:SetCfgID(1006420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006420000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006420000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100643] = function(args)
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
        effect:SetCfgID(1006430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1418, false, false)
        effect:SetCfgID(1006430000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006430000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100644] = function(args)
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
        effect:SetCfgID(1006440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1428, false, false)
        effect:SetCfgID(1006440000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006440000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006440000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100645] = function(args)
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
        effect:SetCfgID(1006450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1429, false, false)
        effect:SetCfgID(1006450000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006450000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006450000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100646] = function(args)
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
        effect:SetCfgID(1006460000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1430, false, false)
        effect:SetCfgID(1006460000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006460000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006460000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100647] = function(args)
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
        effect:SetCfgID(1006470000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1431, false, false)
        effect:SetCfgID(1006470000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006470000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006470000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100648] = function(args)
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
        effect:SetCfgID(1006480000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1432, false, false)
        effect:SetCfgID(1006480000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006480000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006480000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100649] = function(args)
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
        effect:SetCfgID(1006490000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1433, false, false)
        effect:SetCfgID(1006490000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006490000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006490000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100650] = function(args)
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
        effect:SetCfgID(1006500000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1434, false, false)
        effect:SetCfgID(1006500000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006500000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006500000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100651] = function(args)
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
        effect:SetCfgID(1006510000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1436, false, false)
        effect:SetCfgID(1006510000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006510000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006510000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100652] = function(args)
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
        effect:SetCfgID(1006520000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1437, false, false)
        effect:SetCfgID(1006520000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006520000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100653] = function(args)
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
        effect:SetCfgID(1006530000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1438, false, false)
        effect:SetCfgID(1006530000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006530000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100654] = function(args)
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
        effect:SetCfgID(1006540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1439, false, false)
        effect:SetCfgID(1006540000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006540000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100655] = function(args)
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
        effect:SetCfgID(1006550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1440, false, false)
        effect:SetCfgID(1006550000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006550000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100656] = function(args)
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
        local effect = EffectFactory.CreateJumpEffect(10041, 1)
        effect:SetCfgID(1006560000)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100657] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1441, false, false)
        effect:SetCfgID(1006570002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100658] = function(args)
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
        effect:SetCfgID(1006580001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1442, false, false)
        effect:SetCfgID(1006580002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006580003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1006580004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100659] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1443, false, false)
        effect:SetCfgID(1006590002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100660] = function(args)
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
        effect:SetCfgID(1006600001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1444, false, false)
        effect:SetCfgID(1006600002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006600003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1006600004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100661] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1445, false, false)
        effect:SetCfgID(1006610002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100662] = function(args)
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
        effect:SetCfgID(1006620001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1446, false, false)
        effect:SetCfgID(1006620002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006620003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1006620004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100663] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1447, false, false)
        effect:SetCfgID(1006630002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100664] = function(args)
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
        effect:SetCfgID(1006640001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1448, false, false)
        effect:SetCfgID(1006640002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006640003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFinishBranchEffect()
        effect:SetCfgID(1006640004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100665] = function(args)
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
        effect:SetCfgID(1006650001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1449, false, false)
        effect:SetCfgID(1006650002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006650003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100666] = function(args)
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
        effect:SetCfgID(1006660001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1450, false, false)
        effect:SetCfgID(1006660002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006660003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100667] = function(args)
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
        effect:SetCfgID(1006670001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1451, false, false)
        effect:SetCfgID(1006670002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006670003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100668] = function(args)
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
        effect:SetCfgID(1006680001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1452, false, false)
        effect:SetCfgID(1006680002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006680003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100669] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1453, false, false)
        effect:SetCfgID(1006690002)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100670] = function(args)
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
        effect:SetCfgID(1006700001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFlyToEffect("[actor]", 23, 11, false)
        effect:SetCfgID(1006700002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006700003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1455, false, false)
        effect:SetCfgID(1006700004)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateJumpBackEffect(false)
        effect:SetCfgID(1006700005)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006700006)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateDialogEffect(6, "0")
        effect:SetCfgID(10067000010)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100671] = function(args)
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
        effect:SetCfgID(1006710001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1456, false, false)
        effect:SetCfgID(1006710002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/char_052m", false)
        effect:SetCfgID(1006710003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006710004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100672] = function(args)
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
        effect:SetCfgID(1006720001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1457, false, false)
        effect:SetCfgID(1006720002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006720003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100673] = function(args)
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
        effect:SetCfgID(1006730001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1458, false, false)
        effect:SetCfgID(1006730002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006730003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100674] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1459, false, false)
        effect:SetCfgID(1006740001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100675] = function(args)
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
        effect:SetCfgID(1006750000)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateFlyToEffect("[actor]", 24, 19, false)
        effect:SetCfgID(1006750001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006750002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1460, false, false)
        effect:SetCfgID(1006750003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1006750004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100676] = function(args)
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
        effect:SetCfgID(1006760001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1462, false, false)
        effect:SetCfgID(1006760002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006760003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100677] = function(args)
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
        effect:SetCfgID(1006770001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1463, false, false)
        effect:SetCfgID(1006770002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006770003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100678] = function(args)
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
        effect:SetCfgID(1006780001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1464, false, false)
        effect:SetCfgID(1006780002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006780003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006780004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100679] = function(args)
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
        effect:SetCfgID(1006790001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1465, false, false)
        effect:SetCfgID(1006790002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_3", false)
        effect:SetCfgID(1006790003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006790004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100680] = function(args)
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
        effect:SetCfgID(1006800001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1466, false, false)
        effect:SetCfgID(1006800002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006800004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100682] = function(args)
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
        effect:SetCfgID(1006820001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1468, false, false)
        effect:SetCfgID(1006820002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006820003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100683] = function(args)
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
        effect:SetCfgID(1006830001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1469, false, false)
        effect:SetCfgID(1006830002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006830003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100684] = function(args)
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
        effect:SetCfgID(1006840001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1470, false, false)
        effect:SetCfgID(1006840002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006840003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100685] = function(args)
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
        effect:SetCfgID(1006850001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1471, false, false)
        effect:SetCfgID(1006850002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006850003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100686] = function(args)
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
        effect:SetCfgID(1006860001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1472, false, false)
        effect:SetCfgID(1006860002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006860003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100687] = function(args)
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
        effect:SetCfgID(1006870001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1474, false, false)
        effect:SetCfgID(1006870002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006870003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100688] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1475, false, false)
        effect:SetCfgID(1006880001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100689] = function(args)
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
        effect:SetCfgID(1006890001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1476, false, false)
        effect:SetCfgID(1006890002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006890003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100690] = function(args)
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
        effect:SetCfgID(1006900001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1477, false, false)
        effect:SetCfgID(1006900002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story", false)
        effect:SetCfgID(1006900003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006900004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100691] = function(args)
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
        effect:SetCfgID(1006910001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1478, false, false)
        effect:SetCfgID(1006910002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story", false)
        effect:SetCfgID(1006910003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006910003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100692] = function(args)
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
        effect:SetCfgID(1006920001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1479, false, false)
        effect:SetCfgID(1006920002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006920003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100693] = function(args)
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
        effect:SetCfgID(1006930001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1482, false, false)
        effect:SetCfgID(1006930002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006930003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100694] = function(args)
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
        effect:SetCfgID(1006940001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1473, false, false)
        effect:SetCfgID(1006940002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006940003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100695] = function(args)
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
        effect:SetCfgID(1006950001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1483, false, false)
        effect:SetCfgID(1006950002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006950003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100696] = function(args)
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
        effect:SetCfgID(1006960001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1484, false, false)
        effect:SetCfgID(1006960002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_2", false)
        effect:SetCfgID(1006960003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006960004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100697] = function(args)
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
        effect:SetCfgID(1006970001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1487, false, false)
        effect:SetCfgID(1006970002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006970003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100698] = function(args)
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
        effect:SetCfgID(1006980001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1488, false, false)
        effect:SetCfgID(1006980002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1006980003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(false)
        effect:SetCfgID(1006980004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100699] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1485, false, false)
        effect:SetCfgID(1006990001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100700] = function(args)
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
        effect:SetCfgID(1007000001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1/w3_up_switch_03", false)
        effect:SetCfgID(1007000002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1486, false, false)
        effect:SetCfgID(1007000003)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story_1", false)
        effect:SetCfgID(1007000004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1007000005)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100701] = function(args)
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
        local effect = EffectFactory.CreateTimelineEffect(1489, false, false)
        effect:SetCfgID(1007010001)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100702] = function(args)
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
        effect:SetCfgID(1007020001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1490, false, false)
        effect:SetCfgID(1007020002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateVisualEffect("Story", false)
        effect:SetCfgID(1007020003)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1007020004)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100703] = function(args)
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
        effect:SetCfgID(1007030001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1453, false, false)
        effect:SetCfgID(1007030002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1007030003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100704] = function(args)
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
        effect:SetCfgID(1007040001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1459, false, false)
        effect:SetCfgID(1007040002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1007040003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100705] = function(args)
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
        effect:SetCfgID(1007050001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1475, false, false)
        effect:SetCfgID(1007050002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1007050003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100706] = function(args)
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
        effect:SetCfgID(1007060001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1485, false, false)
        effect:SetCfgID(1007060002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1007060003)
        root:AddEffect(effect)
      end
      if upper then
        upper:AddEffect(root)
      end
    end
    return composed
  end,
  [100707] = function(args)
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
        effect:SetCfgID(1007070001)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateTimelineEffect(1489, false, false)
        effect:SetCfgID(1007070002)
        root:AddEffect(effect)
      end
      do
        local upper = effect
        local effect = EffectFactory.CreateThawEffect(true)
        effect:SetCfgID(1007070003)
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
