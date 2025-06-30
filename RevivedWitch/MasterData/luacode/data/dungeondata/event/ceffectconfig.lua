-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/event/ceffectconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChangeTrapStateEffect = require("logic.scene.luaevent.effect.composed.changetrapstateeffect")
local effects = {[100001] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10001, 1)
    effect:SetCfgID(1000010001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000010003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100002] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10002, 1)
    effect:SetCfgID(1000020001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000020003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100003] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10002, 2)
    effect:SetCfgID(1000030001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000030003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100004] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1038, false, false)
    effect:SetCfgID(1000040000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateThawEffect)(true)
      effect:SetCfgID(1000040001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateJumpEffect)(10003, 1)
          effect:SetCfgID(1000040002)
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
, [100005] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1038, false, false)
    effect:SetCfgID(1000050000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateThawEffect)(true)
      effect:SetCfgID(1000050001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateJumpEffect)(10003, 2)
          effect:SetCfgID(1000050002)
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
, [100006] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10004, 1)
    effect:SetCfgID(1000060001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000060003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100007] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1047, false, false)
    effect:SetCfgID(1000070000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateThawEffect)(true)
      effect:SetCfgID(1000070003)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateJumpEffect)(10005, 1)
          effect:SetCfgID(1000070003)
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
, [100008] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10006, 1)
    effect:SetCfgID(1000080001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000080003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100009] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10007, 1)
    effect:SetCfgID(1000090001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000090003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100010] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10008, 1)
    effect:SetCfgID(1000100001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000100003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100011] = function(args)
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
    effect:SetCfgID(1000110000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1030, false, false)
      effect:SetCfgID(1000110001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("ChairCat/Char_Cat", false)
        effect:SetCfgID(1000110002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1000110003)
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
, [100012] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(1000120000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1435, false, false)
      effect:SetCfgID(1000120000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_fs_01m", false)
        effect:SetCfgID(1000120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(false)
            effect:SetCfgID(1000120000)
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
, [100013] = function(args)
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
    do
      local effect = (EffectFactory.CreateVisualEffect)("mon_fs_01m", false)
      effect:SetCfgID(1000130000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100015] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000150000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1036, false, false)
      effect:SetCfgID(1000150001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000150003)
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
, [100019] = function(args)
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
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02", "trapState", 1, "", 0)
  effect:SetCfgID(1000190000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02", "loadState", 1, "", 0)
        effect:SetCfgID(100019000000)
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
, [100023] = function(args)
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
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_01 (2)", "trapState", 1, "", 0)
  effect:SetCfgID(1000230000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_01 (2)", "loadState", 1, "", 0)
        effect:SetCfgID(100023000000)
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
, [100025] = function(args)
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
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02 (3)", "trapState", 1, "", 0)
  effect:SetCfgID(1000250000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02 (3)", "loadState", 1, "", 0)
        effect:SetCfgID(100025000000)
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
, [100039] = function(args)
  -- function num : 0_17 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1004, false, false)
    effect:SetCfgID(1000390000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateSpeedChangeEffect)("[actor]", 0.5)
      effect:SetCfgID(1000390000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateAddEventEffect)(100045)
        effect:SetCfgID(1000390001)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_02", false)
            effect:SetCfgID(1000390002)
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
, [100040] = function(args)
  -- function num : 0_18 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(2, "1")
    effect:SetCfgID(1000400000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBGMEffect)("play", 20010002)
        effect:SetCfgID(1000400000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100041] = function(args)
  -- function num : 0_19 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateAnimationEffect)("firstscene_map_door", "DoorOpen")
    effect:SetCfgID(1000410000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("firstscene_map_button", "ButtonPushed")
      effect:SetCfgID(1000410001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateBlockChangeEffect)(25, 39, 1, 1, false)
          effect:SetCfgID(1000410002)
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
, [100042] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000420000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1049, false, false)
        effect:SetCfgID(1000420001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100043] = function(args)
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
    local effect = (EffectFactory.CreateDialogEffect)(1, "")
    effect:SetCfgID(1000430000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1025, false, false)
      effect:SetCfgID(1000430001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Char_Cat", false)
        effect:SetCfgID(1000430002)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1000430003)
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
, [100045] = function(args)
  -- function num : 0_22 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1008, false, false)
    effect:SetCfgID(1000450000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAddEventEffect)(100039)
      effect:SetCfgID(1000450001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_01", false)
          effect:SetCfgID(1000450002)
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
, [100046] = function(args)
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100045)
      effect:SetCfgID(1000460000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100054] = function(args)
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
    effect:SetCfgID(1000540000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1050, false, false)
      effect:SetCfgID(1000540001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000540003)
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
, [100055] = function(args)
  -- function num : 0_25 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_01", true)
    effect:SetCfgID(1000550000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_02", true)
        effect:SetCfgID(1000550001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100056] = function(args)
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "2")
      effect:SetCfgID(1000560000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100060] = function(args)
  -- function num : 0_27 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBGMEffect)("play", 56)
    effect:SetCfgID(1000600000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "3")
        effect:SetCfgID(1000600001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100061] = function(args)
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
    effect:SetCfgID(1000610000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1017, false, false)
      effect:SetCfgID(1000610001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000610003)
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
, [100062] = function(args)
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100061)
      effect:SetCfgID(1000620000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100063] = function(args)
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
    effect:SetCfgID(1000630000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1018, false, false)
      effect:SetCfgID(1000630001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000630003)
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
, [100064] = function(args)
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
    effect:SetCfgID(1000640000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBlockChangeEffect)(20, 8, 1, 1, true)
      effect:SetCfgID(1000640000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.85, 8, 0, -5.42, true)
        effect:SetCfgID(1000640001)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTurnEffect)(8, "[actor]")
          effect:SetCfgID(1000640002)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1118, false, false)
            effect:SetCfgID(1000640003)
            root:AddEffect(effect)
            local upper = effect
            do
              local effect = (EffectFactory.CreateDestroyEffect)("Story_1/Char_Cat")
              effect:SetCfgID(1000640004)
              effect:SetParam("runoninit")
              root:AddEffect(effect)
              local upper = effect
              do
                do
                  local effect = (EffectFactory.CreateThawEffect)(true)
                  effect:SetCfgID(1000640005)
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
  end
end
, [100071] = function(args)
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
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 97)
      effect:SetCfgID(1000710000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100075] = function(args)
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
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 70)
      effect:SetCfgID(1000750000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100076] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("pause", 2)
      effect:SetCfgID(1000760000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100077] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 59)
      effect:SetCfgID(1000770000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100078] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("pause", 2)
      effect:SetCfgID(1000780000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100079] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 61)
      effect:SetCfgID(1000790000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100080] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000800000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1021, false, false)
      effect:SetCfgID(1000800001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000800003)
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
, [100081] = function(args)
  -- function num : 0_39 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1022, false, false)
    effect:SetCfgID(1000810000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000810003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100082] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000820000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1023, false, false)
      effect:SetCfgID(1000820001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000820003)
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
, [100083] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1024, false, false)
    effect:SetCfgID(1000830000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000830003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100084] = function(args)
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
    do
      local effect = (EffectFactory.CreateAnimationEffect)("firstscene_rabbit", "rabbit_escape")
      effect:SetCfgID(1000840000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100085] = function(args)
  -- function num : 0_43 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateAnimationEffect)("firstscene_map_bird", "BirdFly")
    effect:SetCfgID(1000850000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBGMEffect)("play", 71)
        effect:SetCfgID(1000850001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100087] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000870000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 33)
      effect:SetCfgID(1000870001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1026, false, false)
        effect:SetCfgID(1000870002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("Firstsence_gate", "GateOpen")
          effect:SetCfgID(1000870003)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1027, false, false)
            effect:SetCfgID(1000870004)
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateThawEffect)(true)
                effect:SetCfgID(1000870005)
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
end
, [100089] = function(args)
  -- function num : 0_45 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 2)
      effect:SetCfgID(1000890001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100090] = function(args)
  -- function num : 0_46 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1028, false, false)
      effect:SetCfgID(1000900000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100091] = function(args)
  -- function num : 0_47 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1029, false, false)
      effect:SetCfgID(1000910000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100092] = function(args)
  -- function num : 0_48 , upvalues : _ENV
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
    effect:SetCfgID(1000920000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1031, false, false)
      effect:SetCfgID(1000920001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000920003)
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
, [100093] = function(args)
  -- function num : 0_49 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateJumpEffect)(11000, 1)
      effect:SetCfgID(1000930000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100094] = function(args)
  -- function num : 0_50 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1032, false, false)
      effect:SetCfgID(1000940000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100095] = function(args)
  -- function num : 0_51 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1033, false, false)
      effect:SetCfgID(1000950000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100096] = function(args)
  -- function num : 0_52 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1033, false, false)
      effect:SetCfgID(1000960000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100097] = function(args)
  -- function num : 0_53 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(9, 24, 2, 1, true)
      effect:SetCfgID(1000970000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100098] = function(args)
  -- function num : 0_54 , upvalues : _ENV
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
  local effect = (EffectFactory.CreateTimelineEffect)(1034, false, false)
  effect:SetCfgID(1000980000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1299, false, false)
      effect:SetCfgID(100098000000)
      upper:SetParam("alternative", effect)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateBlockChangeEffect)(9, 17, 3, 1, false)
        effect:SetCfgID(1000980001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1135, false, false)
            effect:SetCfgID(1000980002)
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
, [100100] = function(args)
  -- function num : 0_55 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateAnimationEffect)("EventItem/t1_m_ant_01", "ant_01")
    effect:SetCfgID(1001000001)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimationEffect)("EventItem/t1_m_ant_03", "ant_03")
        effect:SetCfgID(1001000002)
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
, [100101] = function(args)
  -- function num : 0_56 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(3, 10, 2, 1, true)
      effect:SetCfgID(1001010000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100102] = function(args)
  -- function num : 0_57 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1037, false, false)
      effect:SetCfgID(1001020000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100104] = function(args)
  -- function num : 0_58 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(8, 25, 8, 1, true)
      effect:SetCfgID(1001040000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100105] = function(args)
  -- function num : 0_59 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBlockChangeEffect)(9, 17, 3, 1, true)
    effect:SetCfgID(1001050000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateRemoveEventEffect)(100106)
        effect:SetCfgID(1001050001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100107] = function(args)
  -- function num : 0_60 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1039, false, false)
    effect:SetCfgID(1001070000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", false)
        effect:SetCfgID(1001070001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100108] = function(args)
  -- function num : 0_61 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1040, false, false)
      effect:SetCfgID(1001080000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100109] = function(args)
  -- function num : 0_62 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 59)
      effect:SetCfgID(1001090000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100112] = function(args)
  -- function num : 0_63 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateSpeedChangeEffect)("[actor]", 0.85)
      effect:SetCfgID(1001120000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100113] = function(args)
  -- function num : 0_64 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateSpeedChangeEffect)("[actor]", 0.85)
      effect:SetCfgID(1001130000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100115] = function(args)
  -- function num : 0_65 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", true)
      effect:SetCfgID(1001150000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100116] = function(args)
  -- function num : 0_66 , upvalues : _ENV
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
    effect:SetCfgID(1001160000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 59)
      effect:SetCfgID(1001160001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1042, false, false)
        effect:SetCfgID(1001160002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", false)
          effect:SetCfgID(1001160003)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(true)
              effect:SetCfgID(1001160004)
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
, [100117] = function(args)
  -- function num : 0_67 , upvalues : _ENV
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
    effect:SetCfgID(1001170000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 1, 8.6, 0, -3.13, true)
      effect:SetCfgID(1001170001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 1, 9.05, 0, -3.13, true)
        effect:SetCfgID(1001170003)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTurnEffect)(2, "[actor]")
          effect:SetCfgID(1001170004)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1052, false, false)
            effect:SetCfgID(1001170005)
            root:AddEffect(effect)
            local upper = effect
            do
              local effect = (EffectFactory.CreateDestroyEffect)("t1_m_item_03")
              effect:SetCfgID(1001170006)
              effect:SetParam("runoninit")
              root:AddEffect(effect)
              local upper = effect
              do
                do
                  local effect = (EffectFactory.CreateThawEffect)(true)
                  effect:SetCfgID(1001170008)
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
  end
end
, [100118] = function(args)
  -- function num : 0_68 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDestroyEffect)("[sceneobject 15]")
      effect:SetCfgID(1001180000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100119] = function(args)
  -- function num : 0_69 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1043, false, false)
      effect:SetCfgID(1001190000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100121] = function(args)
  -- function num : 0_70 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("EventItem", true)
    effect:SetCfgID(1001210000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBlockChangeEffect)(6, 7, 1, 1, true)
      effect:SetCfgID(1001210003)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateBlockChangeEffect)(11, 11, 1, 1, true)
        effect:SetCfgID(1001210005)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateBlockChangeEffect)(15, 12, 1, 1, true)
            effect:SetCfgID(1001210006)
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
, [100122] = function(args)
  -- function num : 0_71 , upvalues : _ENV
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
    effect:SetCfgID(1001220000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 1, 9, 0, -10.5, true)
      effect:SetCfgID(1001220001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTurnEffect)(2, "[actor]")
        effect:SetCfgID(1001220002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1051, false, false)
          effect:SetCfgID(1001220003)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateDestroyEffect)("t1_m_item_03")
            effect:SetCfgID(1001220004)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateThawEffect)(true)
                effect:SetCfgID(1001220005)
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
end
, [100123] = function(args)
  -- function num : 0_72 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBGMEffect)("play", 1224)
    effect:SetCfgID(1001230000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimationEffect)("EventItem/t1_m_npc_01c", "HandDown")
        effect:SetCfgID(1001230000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100127] = function(args)
  -- function num : 0_73 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(10, 38, 1, 1, true)
      effect:SetCfgID(1001270000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100128] = function(args)
  -- function num : 0_74 , upvalues : _ENV
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
    effect:SetCfgID(1001280000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.75, 6.8, 0, -10.19, true)
      effect:SetCfgID(1001280001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTurnEffect)(0, "[actor]")
        effect:SetCfgID(1001280002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1053, false, false)
          effect:SetCfgID(1001280003)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateDestroyEffect)("t1_m_item_05(Clone)")
            effect:SetCfgID(1001280004)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              local effect = (EffectFactory.CreateThawEffect)(true)
              effect:SetCfgID(1001280008)
              root:AddEffect(effect)
              local upper = effect
              do
                do
                  local effect = (EffectFactory.CreateJumpBackEffect)()
                  effect:SetCfgID(1001280009)
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
  end
end
, [100129] = function(args)
  -- function num : 0_75 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 80)
      effect:SetCfgID(1001290000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100130] = function(args)
  -- function num : 0_76 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBlockChangeEffect)(11, 11, 1, 1, true)
    effect:SetCfgID(1001300000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 2)
      effect:SetCfgID(1001300001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1045, false, false)
        effect:SetCfgID(1001300002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1001300003)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateVisualEffect)("mon_t1_03m", true)
              effect:SetCfgID(1001300004)
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
end
, [100132] = function(args)
  -- function num : 0_77 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBlockChangeEffect)(9, 0, 2, 3, false)
    effect:SetCfgID(1001320100)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBlockChangeEffect)(13, 0, 2, 3, false)
      effect:SetCfgID(1001320100)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1038, false, false)
          effect:SetCfgID(1001320100)
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
, [100133] = function(args)
  -- function num : 0_78 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBlockChangeEffect)(30, 13, 2, 3, false)
    effect:SetCfgID(1001330100)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1044, false, false)
        effect:SetCfgID(1001330100)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100182] = function(args)
  -- function num : 0_79 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1102, false, false)
    effect:SetCfgID(100182010018200)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(100182010018202)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100183] = function(args)
  -- function num : 0_80 , upvalues : _ENV
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
    effect:SetCfgID(100183010018300)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1105, false, false)
      effect:SetCfgID(100183010018301)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(100183010018302)
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
, [100184] = function(args)
  -- function num : 0_81 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1104, false, false)
    effect:SetCfgID(100184010018400)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(100184010018400)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100186] = function(args)
  -- function num : 0_82 , upvalues : _ENV
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
    effect:SetCfgID(100186010018600)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3001, true, false)
      effect:SetCfgID(100186010018601)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(100186010018602)
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
, [100187] = function(args)
  -- function num : 0_83 , upvalues : _ENV
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
    effect:SetCfgID(100187010018700)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1121, false, false)
      effect:SetCfgID(100187010018700)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTurnEffect)(2, "[actor]")
        effect:SetCfgID(100187010018701)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(100187010018705)
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
, [100188] = function(args)
  -- function num : 0_84 , upvalues : _ENV
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
    effect:SetCfgID(100188010018800)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3002, true, false)
      effect:SetCfgID(100188010018801)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(100188010018802)
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
, [100189] = function(args)
  -- function num : 0_85 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "9")
      effect:SetCfgID(100189010018900)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100190] = function(args)
  -- function num : 0_86 , upvalues : _ENV
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
    effect:SetCfgID(100190010019000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1111, false, false)
      effect:SetCfgID(100190010019001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(100190010019002)
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
, [100191] = function(args)
  -- function num : 0_87 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1112, false, false)
      effect:SetCfgID(100191010019104)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100192] = function(args)
  -- function num : 0_88 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1113, false, false)
      effect:SetCfgID(1.001920100192e+19)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100194] = function(args)
  -- function num : 0_89 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(100194010019400)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_w1_38m", true)
        effect:SetCfgID(1.001940100194e+19)
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
, [100195] = function(args)
  -- function num : 0_90 , upvalues : _ENV
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
    effect:SetCfgID(1001950000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1115, false, false)
      effect:SetCfgID(1001950000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", false)
        effect:SetCfgID(1001950001)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1001950002)
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
, [100197] = function(args)
  -- function num : 0_91 , upvalues : _ENV
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
    effect:SetCfgID(100197010019700)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3003, true, false)
      effect:SetCfgID(100197010019700)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(100197010019700)
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
, [100199] = function(args)
  -- function num : 0_92 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1001990000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_w1_38m", false)
        effect:SetCfgID(1001990001)
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
, [100200] = function(args)
  -- function num : 0_93 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(25, 39, 1, 1, true)
      effect:SetCfgID(1002000000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100201] = function(args)
  -- function num : 0_94 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  local root = nil
  if not composed then
    composed = (EffectFactory.CreateComposedEffect)()
    root = composed
  else
    root = (EffectFactory.CreateComposedEffect)()
  end
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
    local effect = (EffectFactory.CreateTimelineEffect)(1035, false, false)
    effect:SetCfgID(100201000500)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1136, false, false)
      effect:SetCfgID(100201000500)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          do
            local effect = (EffectFactory.CreateBlockChangeEffect)(9, 24, 3, 1, false)
            effect:SetCfgID(100201000501)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            if upper then
              upper:AddEffect(root)
            end
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
, [100202] = function(args)
  -- function num : 0_95 , upvalues : _ENV
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
    effect:SetCfgID(1002020000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.65, 5.4, 0, -13, true)
      effect:SetCfgID(1002020000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1119, false, false)
        effect:SetCfgID(1002020000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1002020000)
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
, [100203] = function(args)
  -- function num : 0_96 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
    effect:SetCfgID(1002030000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Particle_XiaYu", true)
        effect:SetCfgID(1002030000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100204] = function(args)
  -- function num : 0_97 , upvalues : _ENV
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
    effect:SetCfgID(1002040000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1120, false, false)
      effect:SetCfgID(1002040001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1002040002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateJumpEffect)(12025, 2)
            effect:SetCfgID(1002040005)
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
, [100205] = function(args)
  -- function num : 0_98 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1109, false, false)
      effect:SetCfgID(1002050000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100206] = function(args)
  -- function num : 0_99 , upvalues : _ENV
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
    effect:SetCfgID(1002060000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", true)
      effect:SetCfgID(1002060001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1122, false, false)
        effect:SetCfgID(1002060002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
          effect:SetCfgID(1002060003)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(true)
              effect:SetCfgID(1002060004)
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
, [100207] = function(args)
  -- function num : 0_100 , upvalues : _ENV
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
    effect:SetCfgID(1002070000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1123, false, false)
      effect:SetCfgID(1002070000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002070000)
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
, [100208] = function(args)
  -- function num : 0_101 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateRemoveEventEffect)(100504)
    effect:SetCfgID(1002080000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateFreezeEffect)(true)
      effect:SetCfgID(1002080000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1420, false, false)
        effect:SetCfgID(1002080000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1002080000)
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
, [100209] = function(args)
  -- function num : 0_102 , upvalues : _ENV
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
    effect:SetCfgID(1002090000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1125, false, false)
      effect:SetCfgID(1002090000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1002090000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateDestroyEffect)("Story_1")
            effect:SetCfgID(1002090000)
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
, [100210] = function(args)
  -- function num : 0_103 , upvalues : _ENV
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
    effect:SetCfgID(1002100000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1126, false, false)
        effect:SetCfgID(1002100001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100211] = function(args)
  -- function num : 0_104 , upvalues : _ENV
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
    effect:SetCfgID(1002110000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1127, false, false)
        effect:SetCfgID(1002110000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100212] = function(args)
  -- function num : 0_105 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1002120000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1002120000)
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
, [100213] = function(args)
  -- function num : 0_106 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1002130000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1002130000)
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
, [100214] = function(args)
  -- function num : 0_107 , upvalues : _ENV
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
    effect:SetCfgID(1002140001)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1132, false, false)
      effect:SetCfgID(1002140002)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002140003)
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
, [100215] = function(args)
  -- function num : 0_108 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1149, false, false)
      effect:SetCfgID(1002150000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100216] = function(args)
  -- function num : 0_109 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1133, false, false)
      effect:SetCfgID(1002160000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100217] = function(args)
  -- function num : 0_110 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDestroyEffect)("Sence_TX_Prefab_ChuanSongJing")
    effect:SetCfgID(1002170000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateRemoveEventEffect)(100216)
      effect:SetCfgID(1002170000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("Tunnel/glass", true)
          effect:SetCfgID(1002170000)
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
, [100218] = function(args)
  -- function num : 0_111 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Sence_TX_Prefab_ChuanSongJing", true)
    effect:SetCfgID(1002180000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Tunnel/glass", true)
      effect:SetCfgID(1002180000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateBlockChangeEffect)(20, 8, 1, 1, false)
          effect:SetCfgID(1002180000)
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
, [100219] = function(args)
  -- function num : 0_112 , upvalues : _ENV
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
    effect:SetCfgID(1002190000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3006, true, false)
      effect:SetCfgID(1002190000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("t1_door_02a", false)
        effect:SetCfgID(1002190000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002190000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateTurnEffect)(8, "[actor]")
              effect:SetCfgID(1002190000)
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
, [100220] = function(args)
  -- function num : 0_113 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1002200000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100221] = function(args)
  -- function num : 0_114 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100220)
      effect:SetCfgID(1002210000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100223] = function(args)
  -- function num : 0_115 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBlockChangeEffect)(20, 23, 5, 1, false)
    effect:SetCfgID(1002230000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("t1_door_01a", false)
      effect:SetCfgID(1002230000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateRemoveEventEffect)(100109)
          effect:SetCfgID(1002230000)
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
, [100224] = function(args)
  -- function num : 0_116 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("char_010m_01", false)
    effect:SetCfgID(1002240000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("char_010m_02", false)
      effect:SetCfgID(1002240000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27obj", true)
        effect:SetCfgID(1002240001)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateBlockChangeEffect)(19, 10, 1, 1, true)
            effect:SetCfgID(1002240002)
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
, [100225] = function(args)
  -- function num : 0_117 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002250000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100226] = function(args)
  -- function num : 0_118 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002260000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100227] = function(args)
  -- function num : 0_119 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002270000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100228] = function(args)
  -- function num : 0_120 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002280000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100229] = function(args)
  -- function num : 0_121 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002290000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100230] = function(args)
  -- function num : 0_122 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002300000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100231] = function(args)
  -- function num : 0_123 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002310000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100232] = function(args)
  -- function num : 0_124 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002320000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100233] = function(args)
  -- function num : 0_125 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002330000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100234] = function(args)
  -- function num : 0_126 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002340000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100235] = function(args)
  -- function num : 0_127 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002350000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100236] = function(args)
  -- function num : 0_128 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002360000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100237] = function(args)
  -- function num : 0_129 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002370000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100238] = function(args)
  -- function num : 0_130 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002380000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100239] = function(args)
  -- function num : 0_131 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002390000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100240] = function(args)
  -- function num : 0_132 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002400000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100241] = function(args)
  -- function num : 0_133 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002410000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100242] = function(args)
  -- function num : 0_134 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002420000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100243] = function(args)
  -- function num : 0_135 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002430000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100244] = function(args)
  -- function num : 0_136 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002440000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100245] = function(args)
  -- function num : 0_137 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002450000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100246] = function(args)
  -- function num : 0_138 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002460000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100247] = function(args)
  -- function num : 0_139 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002470000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100248] = function(args)
  -- function num : 0_140 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", true)
      effect:SetCfgID(1002480000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100249] = function(args)
  -- function num : 0_141 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100185)
      effect:SetCfgID(1002490000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100250] = function(args)
  -- function num : 0_142 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(5, "3")
      effect:SetCfgID(1002500000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100251] = function(args)
  -- function num : 0_143 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Map Data/Ground/t1_m_statue_01(Clone)", "loadState", 1, "", 0)
    effect:SetCfgID(1002510001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Map Data/Ground/t1_m_statue_02(Clone)", "loadState", 1, "", 0)
        effect:SetCfgID(1002510002)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100253] = function(args)
  -- function num : 0_144 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(20, 8, 1, 1, true)
      effect:SetCfgID(1002530000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100254] = function(args)
  -- function num : 0_145 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(31, 6, 3, 1, false)
      effect:SetCfgID(1002540000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100255] = function(args)
  -- function num : 0_146 , upvalues : _ENV
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
    effect:SetCfgID(1002550000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 1, 2.79, 0, -10.15, true)
      effect:SetCfgID(1002550001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTurnEffect)(2, "[actor]")
        effect:SetCfgID(1002550002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1137, false, false)
          effect:SetCfgID(1002550003)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("t1_m_item_03", false)
            effect:SetCfgID(1002550004)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateThawEffect)(true)
                effect:SetCfgID(1002550005)
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
end
, [100256] = function(args)
  -- function num : 0_147 , upvalues : _ENV
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
    effect:SetCfgID(1002560000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1138, false, false)
      effect:SetCfgID(1002560001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.85, 8.35, 0, -9.08, true)
        effect:SetCfgID(1002560002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1198, false, false)
          effect:SetCfgID(1002560003)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("mon_t1_03m", false)
            effect:SetCfgID(1002560004)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateThawEffect)(true)
                effect:SetCfgID(1002560005)
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
end
, [100257] = function(args)
  -- function num : 0_148 , upvalues : _ENV
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
    effect:SetCfgID(1002570000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 1, 8.55, 0, -6.66, true)
      effect:SetCfgID(1002570001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1139, false, false)
        effect:SetCfgID(1002570002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("t1_m_item_03", false)
          effect:SetCfgID(1002570005)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1140, false, false)
            effect:SetCfgID(1002570006)
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateThawEffect)(true)
                effect:SetCfgID(1002570008)
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
end
, [100259] = function(args)
  -- function num : 0_149 , upvalues : _ENV
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
    effect:SetCfgID(1002590000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1144, false, false)
      effect:SetCfgID(1002590001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002590002)
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
, [100260] = function(args)
  -- function num : 0_150 , upvalues : _ENV
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
    effect:SetCfgID(1002600000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3010, true, false)
      effect:SetCfgID(1002600001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1002600002)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("char_013m", false)
            effect:SetCfgID(1002600003)
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
, [100261] = function(args)
  -- function num : 0_151 , upvalues : _ENV
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
    effect:SetCfgID(1002610000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1143, false, false)
      effect:SetCfgID(1002610001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002610002)
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
, [100262] = function(args)
  -- function num : 0_152 , upvalues : _ENV
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
    effect:SetCfgID(1002620000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3010, true, false)
      effect:SetCfgID(1002620001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002620002)
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
, [100263] = function(args)
  -- function num : 0_153 , upvalues : _ENV
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
    effect:SetCfgID(1002630001)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1156, false, false)
      effect:SetCfgID(1002630002)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002630003)
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
, [100264] = function(args)
  -- function num : 0_154 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("char_010m_01", false)
    effect:SetCfgID(1002640001)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("char_010m_02", true)
        effect:SetCfgID(1002640001)
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
, [100265] = function(args)
  -- function num : 0_155 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1145, false, false)
    effect:SetCfgID(1002650000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("char_001m2", false)
        effect:SetCfgID(1002650001)
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
, [100266] = function(args)
  -- function num : 0_156 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1146, false, false)
    effect:SetCfgID(1002660000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1/Char_Cat", false)
        effect:SetCfgID(1002660001)
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
, [100267] = function(args)
  -- function num : 0_157 , upvalues : _ENV
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
    effect:SetCfgID(1002670000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.8, 1, 0, -10.33, true)
      effect:SetCfgID(1002670000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1147, false, false)
        effect:SetCfgID(1002670000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
          effect:SetCfgID(1002670001)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
            effect:SetCfgID(1002670002)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateRemoveEventEffect)(100268)
                effect:SetCfgID(1002670003)
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
  end
end
, [100268] = function(args)
  -- function num : 0_158 , upvalues : _ENV
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
    effect:SetCfgID(1002680000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.8, 8.05, 0, -12.8, true)
      effect:SetCfgID(1002680000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1148, false, false)
        effect:SetCfgID(1002680000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
          effect:SetCfgID(1002680001)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
            effect:SetCfgID(1002680002)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateRemoveEventEffect)(100267)
                effect:SetCfgID(1002680003)
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
  end
end
, [100269] = function(args)
  -- function num : 0_159 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1002690001)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("mon_w1_48m", false)
      effect:SetCfgID(1002690001)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("mon_w1_49m", false)
          effect:SetCfgID(1002690001)
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
, [100270] = function(args)
  -- function num : 0_160 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", true)
      effect:SetCfgID(1002700001)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100271] = function(args)
  -- function num : 0_161 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(3009, true, false)
    effect:SetCfgID(1002710000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1002710000)
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
, [100272] = function(args)
  -- function num : 0_162 , upvalues : _ENV
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
    effect:SetCfgID(1002720000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.8, 5, 0, -6.845, true)
      effect:SetCfgID(1002720000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1150, false, false)
        effect:SetCfgID(1002720000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1002720000)
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
, [100274] = function(args)
  -- function num : 0_163 , upvalues : _ENV
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
    effect:SetCfgID(1002740000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 1, 4, 0, -12.32, true)
      effect:SetCfgID(1002740001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1152, false, false)
        effect:SetCfgID(1002740002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002740003)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1002740004)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateVisualEffect)("n_w2_11", false)
                effect:SetCfgID(1002740005)
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
  end
end
, [100276] = function(args)
  -- function num : 0_164 , upvalues : _ENV
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
    effect:SetCfgID(1002760002)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1157, false, false)
      effect:SetCfgID(1002760003)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002760004)
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
, [100277] = function(args)
  -- function num : 0_165 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100263)
      effect:SetCfgID(1002770000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100278] = function(args)
  -- function num : 0_166 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(5, "5")
      effect:SetCfgID(1002780000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100279] = function(args)
  -- function num : 0_167 , upvalues : _ENV
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
    effect:SetCfgID(1002790000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1292, false, false)
      effect:SetCfgID(1002790000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "29")
        effect:SetCfgID(1002790000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1002790000)
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
, [100280] = function(args)
  -- function num : 0_168 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100279)
      effect:SetCfgID(1002800000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100281] = function(args)
  -- function num : 0_169 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1154, false, false)
      effect:SetCfgID(1002810001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100282] = function(args)
  -- function num : 0_170 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(3011, true, false)
      effect:SetCfgID(1002820000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100285] = function(args)
  -- function num : 0_171 , upvalues : _ENV
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
    effect:SetCfgID(1002850000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateRemoveEventEffect)(100268)
      effect:SetCfgID(1002850001)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1188, false, false)
        effect:SetCfgID(1002850002)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1002850003)
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
, [100286] = function(args)
  -- function num : 0_172 , upvalues : _ENV
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
    effect:SetCfgID(1002860000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateRemoveEventEffect)(100286)
      effect:SetCfgID(1002860000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1189, false, false)
        effect:SetCfgID(1002860002)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1002860003)
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
, [100287] = function(args)
  -- function num : 0_173 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", true)
      effect:SetCfgID(1002870000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100288] = function(args)
  -- function num : 0_174 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100289)
      effect:SetCfgID(1002880000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100289] = function(args)
  -- function num : 0_175 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateAddEventEffect)(100289)
      effect:SetCfgID(1002890000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100290] = function(args)
  -- function num : 0_176 , upvalues : _ENV
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
    effect:SetCfgID(1002900000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.85, 8.4, 0, -6.25, true)
      effect:SetCfgID(1002900000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1160, false, false)
        effect:SetCfgID(1002900000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1002900000)
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
, [100291] = function(args)
  -- function num : 0_177 , upvalues : _ENV
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
    effect:SetCfgID(1002910000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1162, false, false)
      effect:SetCfgID(1002910001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002910002)
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
, [100292] = function(args)
  -- function num : 0_178 , upvalues : _ENV
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
    effect:SetCfgID(1002920000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1161, false, false)
      effect:SetCfgID(1002920001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002920002)
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
, [100293] = function(args)
  -- function num : 0_179 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1002930000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100294] = function(args)
  -- function num : 0_180 , upvalues : _ENV
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
    effect:SetCfgID(1002940000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1163, false, false)
      effect:SetCfgID(1002940001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1002940003)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("n_w2_12", false)
            effect:SetCfgID(1002940004)
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
, [100295] = function(args)
  -- function num : 0_181 , upvalues : _ENV
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
    effect:SetCfgID(1002950000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3014, true, false)
      effect:SetCfgID(1002950000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002950000)
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
, [100296] = function(args)
  -- function num : 0_182 , upvalues : _ENV
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
    effect:SetCfgID(1002960000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1164, false, false)
      effect:SetCfgID(1002960000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002960000)
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
, [100297] = function(args)
  -- function num : 0_183 , upvalues : _ENV
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
    effect:SetCfgID(1002970000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1166, false, false)
      effect:SetCfgID(1002970000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1002970000)
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
, [100298] = function(args)
  -- function num : 0_184 , upvalues : _ENV
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
    effect:SetCfgID(1002980000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateFlyToEffect)("[actor]", 11, 5, true)
      effect:SetCfgID(1002980000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1165, false, false)
        effect:SetCfgID(1002980000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1002980000)
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
, [100299] = function(args)
  -- function num : 0_185 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1002990000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100300] = function(args)
  -- function num : 0_186 , upvalues : _ENV
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
    effect:SetCfgID(1003000000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3015, true, false)
      effect:SetCfgID(1003000000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003000000)
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
, [100301] = function(args)
  -- function num : 0_187 , upvalues : _ENV
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
    effect:SetCfgID(1003010000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1167, false, false)
      effect:SetCfgID(1003010000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003010000)
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
, [100302] = function(args)
  -- function num : 0_188 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  do
    local root = nil
    if not composed then
      composed = (EffectFactory.CreateComposedEffect)()
      root = composed
    else
      root = (EffectFactory.CreateComposedEffect)()
    end
    if upper then
      upper:AddEffect(root)
    end
    return composed
  end
end
, [100303] = function(args)
  -- function num : 0_189 , upvalues : _ENV
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
    effect:SetCfgID(1003030000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1168, false, false)
      effect:SetCfgID(1003030001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDestroyEffect)("mon_t1_03m")
        effect:SetCfgID(1003030002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003030003)
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
, [100304] = function(args)
  -- function num : 0_190 , upvalues : _ENV
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
    effect:SetCfgID(1003040000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.85, 3.8, 0, -5.62, true)
      effect:SetCfgID(1003040000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1169, false, false)
        effect:SetCfgID(1003040000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003040000)
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
, [100305] = function(args)
  -- function num : 0_191 , upvalues : _ENV
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
  local effect = (EffectFactory.CreateTimelineEffect)(1170, false, false)
  effect:SetCfgID(1003050000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1300, false, false)
        effect:SetCfgID(100305000000)
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
, [100306] = function(args)
  -- function num : 0_192 , upvalues : _ENV
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
    effect:SetCfgID(1003060000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1171, false, false)
      effect:SetCfgID(1003060000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1/Char_Cat", false)
        effect:SetCfgID(1003060000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003060000)
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
, [100307] = function(args)
  -- function num : 0_193 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(17, 26, 1, 2, true)
      effect:SetCfgID(1003070000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100308] = function(args)
  -- function num : 0_194 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
    effect:SetCfgID(1003080000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBlockChangeEffect)(18, 25, 1, 1, true)
        effect:SetCfgID(1003080000)
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
, [100309] = function(args)
  -- function num : 0_195 , upvalues : _ENV
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
    effect:SetCfgID(1003090000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
      effect:SetCfgID(1003090000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateBlockChangeEffect)(18, 25, 1, 1, true)
        effect:SetCfgID(1003090000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_2/Char_Cat", true)
          effect:SetCfgID(1003090001)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1173, false, false)
            effect:SetCfgID(1003090003)
            root:AddEffect(effect)
            local upper = effect
            do
              local effect = (EffectFactory.CreateVisualEffect)("Story_2/Char_Cat", false)
              effect:SetCfgID(1003090004)
              effect:SetParam("runoninit")
              root:AddEffect(effect)
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
                local effect = (EffectFactory.CreateTimelineEffect)(1212, false, false)
                effect:SetCfgID(100309000506)
                effect:SetParam("runoninit")
                root:AddEffect(effect)
                local upper = effect
                do
                  do
                    local effect = (EffectFactory.CreateTimelineEffect)(1216, false, false)
                    effect:SetCfgID(100309000507)
                    root:AddEffect(effect)
                    if upper then
                      upper:AddEffect(root)
                    end
                    local upper = effect
                    do
                      local effect = (EffectFactory.CreateBlockChangeEffect)(17, 26, 1, 2, false)
                      effect:SetCfgID(1003090008)
                      effect:SetParam("runoninit")
                      root:AddEffect(effect)
                      local upper = effect
                      do
                        do
                          local effect = (EffectFactory.CreateThawEffect)(true)
                          effect:SetCfgID(1003090009)
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
          end
        end
      end
    end
  end
end
, [100310] = function(args)
  -- function num : 0_196 , upvalues : _ENV
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
    effect:SetCfgID(1003100000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1174, false, false)
      effect:SetCfgID(1003100000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003100000)
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
, [100311] = function(args)
  -- function num : 0_197 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
    effect:SetCfgID(1003110000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1003110001)
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
, [100312] = function(args)
  -- function num : 0_198 , upvalues : _ENV
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
    effect:SetCfgID(1003120000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateFlyToEffect)("[actor]", 9, 16, true)
      effect:SetCfgID(1003120000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1175, false, false)
        effect:SetCfgID(1003120000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003120000)
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
, [100313] = function(args)
  -- function num : 0_199 , upvalues : _ENV
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
    effect:SetCfgID(1003130000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1176, false, false)
      effect:SetCfgID(1003130000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003130000)
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
, [100314] = function(args)
  -- function num : 0_200 , upvalues : _ENV
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
    effect:SetCfgID(1003140000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1177, false, false)
      effect:SetCfgID(1003140000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1003140000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003140000)
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
, [100315] = function(args)
  -- function num : 0_201 , upvalues : _ENV
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
    effect:SetCfgID(1003150000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1178, false, false)
      effect:SetCfgID(1003150000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003150000)
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
, [100316] = function(args)
  -- function num : 0_202 , upvalues : _ENV
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
    effect:SetCfgID(1003160000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1179, false, false)
      effect:SetCfgID(1003160000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003160000)
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
, [100317] = function(args)
  -- function num : 0_203 , upvalues : _ENV
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
    effect:SetCfgID(1003170000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1180, false, false)
      effect:SetCfgID(1003170000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("boss_w2_04m", false)
        effect:SetCfgID(1003170000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003170000)
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
, [100318] = function(args)
  -- function num : 0_204 , upvalues : _ENV
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
    effect:SetCfgID(1003180000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1181, false, false)
      effect:SetCfgID(1003180000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003180000)
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
, [100319] = function(args)
  -- function num : 0_205 , upvalues : _ENV
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
    effect:SetCfgID(1003190000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3017, true, false)
      effect:SetCfgID(1003190000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003190000)
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
, [100320] = function(args)
  -- function num : 0_206 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1003200000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1003200000)
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
, [100321] = function(args)
  -- function num : 0_207 , upvalues : _ENV
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
    effect:SetCfgID(1003210000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1183, false, false)
      effect:SetCfgID(1003210000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1/Char_Cat", false)
        effect:SetCfgID(1003210001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003210002)
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
, [100322] = function(args)
  -- function num : 0_208 , upvalues : _ENV
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
    effect:SetCfgID(1003220000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1184, false, false)
      effect:SetCfgID(1003220000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003220000)
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
, [100323] = function(args)
  -- function num : 0_209 , upvalues : _ENV
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
    effect:SetCfgID(1003230000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1185, false, false)
      effect:SetCfgID(1003230000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003230000)
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
, [100324] = function(args)
  -- function num : 0_210 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1003240000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100325] = function(args)
  -- function num : 0_211 , upvalues : _ENV
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
    effect:SetCfgID(1003250000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1186, false, false)
      effect:SetCfgID(1003250000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003250000)
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
, [100326] = function(args)
  -- function num : 0_212 , upvalues : _ENV
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
    effect:SetCfgID(1003260000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1187, false, false)
      effect:SetCfgID(1003260000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003260000)
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
, [100327] = function(args)
  -- function num : 0_213 , upvalues : _ENV
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
    effect:SetCfgID(1003270000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1190, false, false)
      effect:SetCfgID(1003270000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003270000)
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
, [100328] = function(args)
  -- function num : 0_214 , upvalues : _ENV
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
    effect:SetCfgID(1003280000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1192, false, false)
      effect:SetCfgID(1003280000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003280000)
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
, [100329] = function(args)
  -- function num : 0_215 , upvalues : _ENV
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
    effect:SetCfgID(1003290000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1191, false, false)
      effect:SetCfgID(1003290001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1003290003)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateDialogEffect)(4, "14")
            effect:SetCfgID(1003290004)
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
, [100330] = function(args)
  -- function num : 0_216 , upvalues : _ENV
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
    effect:SetCfgID(1003300000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1193, false, false)
      effect:SetCfgID(1003300002)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1003300004)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1003300005)
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
, [100335] = function(args)
  -- function num : 0_217 , upvalues : _ENV
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
    effect:SetCfgID(1003350000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1195, false, false)
      effect:SetCfgID(1003350000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003350000)
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
, [100336] = function(args)
  -- function num : 0_218 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
    effect:SetCfgID(1003360000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1003360000)
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
, [100337] = function(args)
  -- function num : 0_219 , upvalues : _ENV
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
    effect:SetCfgID(1003370000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1196, false, false)
      effect:SetCfgID(1003370000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003370000)
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
, [100338] = function(args)
  -- function num : 0_220 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1003380000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1003380000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100339] = function(args)
  -- function num : 0_221 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1197, false, false)
      effect:SetCfgID(1003390000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100340] = function(args)
  -- function num : 0_222 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100339)
      effect:SetCfgID(1003400000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100341] = function(args)
  -- function num : 0_223 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1003410000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1003410001)
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
, [100342] = function(args)
  -- function num : 0_224 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1003420000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100343] = function(args)
  -- function num : 0_225 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateFlyToEffect)("actor", 12, 13, true)
      effect:SetCfgID(1003430001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100344] = function(args)
  -- function num : 0_226 , upvalues : _ENV
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
    effect:SetCfgID(1003440001)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1213, false, false)
      effect:SetCfgID(1003440002)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003440007)
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
, [100345] = function(args)
  -- function num : 0_227 , upvalues : _ENV
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
    effect:SetCfgID(1003450001)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1215, false, false)
      effect:SetCfgID(1003450002)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003450003)
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
, [100346] = function(args)
  -- function num : 0_228 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("[portal 17]", false)
    effect:SetCfgID(1003460000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("[portal 18]", false)
        effect:SetCfgID(1003460000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100347] = function(args)
  -- function num : 0_229 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(31, 6, 3, 1, true)
      effect:SetCfgID(1003470000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100348] = function(args)
  -- function num : 0_230 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("n_w2_11", true)
      effect:SetCfgID(1003480000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100349] = function(args)
  -- function num : 0_231 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_3", true)
      effect:SetCfgID(1003490000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100350] = function(args)
  -- function num : 0_232 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 243)
      effect:SetCfgID(1003500000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100351] = function(args)
  -- function num : 0_233 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100350)
      effect:SetCfgID(1003510000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100352] = function(args)
  -- function num : 0_234 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1217, false, false)
      effect:SetCfgID(1003520000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100353] = function(args)
  -- function num : 0_235 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1218, false, false)
      effect:SetCfgID(1003530000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100354] = function(args)
  -- function num : 0_236 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("SceneBreak", true)
    effect:SetCfgID(1003540000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("SceneBreak2", true)
      effect:SetCfgID(1003540000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("SceneBreak3", true)
        effect:SetCfgID(1003540000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("SceneBreak4", true)
          effect:SetCfgID(1003540000)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("Sence_TX_W2_guochang_fazhen", false)
            effect:SetCfgID(1003540000)
            root:AddEffect(effect)
            local upper = effect
            do
              local effect = (EffectFactory.CreateBlockChangeEffect)(7, 15, 2, 2, true)
              effect:SetCfgID(1003540000)
              root:AddEffect(effect)
              local upper = effect
              do
                local effect = (EffectFactory.CreateBlockChangeEffect)(9, 16, 3, 2, true)
                effect:SetCfgID(1003540000)
                root:AddEffect(effect)
                local upper = effect
                do
                  local effect = (EffectFactory.CreateBlockChangeEffect)(12, 17, 2, 2, true)
                  effect:SetCfgID(1003540000)
                  root:AddEffect(effect)
                  local upper = effect
                  do
                    local effect = (EffectFactory.CreateBlockChangeEffect)(18, 16, 2, 1, true)
                    effect:SetCfgID(1003540000)
                    root:AddEffect(effect)
                    local upper = effect
                    do
                      local effect = (EffectFactory.CreateBlockChangeEffect)(17, 17, 3, 1, true)
                      effect:SetCfgID(1003540000)
                      root:AddEffect(effect)
                      local upper = effect
                      do
                        local effect = (EffectFactory.CreateBlockChangeEffect)(7, 9, 1, 1, true)
                        effect:SetCfgID(1003540000)
                        root:AddEffect(effect)
                        local upper = effect
                        do
                          local effect = (EffectFactory.CreateBlockChangeEffect)(7, 10, 2, 1, true)
                          effect:SetCfgID(1003540000)
                          root:AddEffect(effect)
                          local upper = effect
                          do
                            local effect = (EffectFactory.CreateBlockChangeEffect)(9, 10, 2, 2, true)
                            effect:SetCfgID(1003540000)
                            root:AddEffect(effect)
                            local upper = effect
                            do
                              local effect = (EffectFactory.CreateBlockChangeEffect)(18, 11, 2, 1, true)
                              effect:SetCfgID(1003540000)
                              root:AddEffect(effect)
                              local upper = effect
                              do
                                local effect = (EffectFactory.CreateBlockChangeEffect)(12, 21, 1, 1, true)
                                effect:SetCfgID(1003540000)
                                root:AddEffect(effect)
                                local upper = effect
                                do
                                  local effect = (EffectFactory.CreateBlockChangeEffect)(12, 32, 1, 2, true)
                                  effect:SetCfgID(1003540000)
                                  root:AddEffect(effect)
                                  local upper = effect
                                  do
                                    local effect = (EffectFactory.CreateBlockChangeEffect)(16, 44, 1, 1, true)
                                    effect:SetCfgID(1003540000)
                                    root:AddEffect(effect)
                                    local upper = effect
                                    do
                                      local effect = (EffectFactory.CreateBlockChangeEffect)(15, 53, 1, 1, true)
                                      effect:SetCfgID(1003540000)
                                      root:AddEffect(effect)
                                      local upper = effect
                                      do
                                        do
                                          local effect = (EffectFactory.CreateBlockChangeEffect)(15, 54, 2, 1, true)
                                          effect:SetCfgID(1003540000)
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
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
, [100355] = function(args)
  -- function num : 0_237 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1003550000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100356] = function(args)
  -- function num : 0_238 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(4, "24")
      effect:SetCfgID(1003560000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100357] = function(args)
  -- function num : 0_239 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1220, false, false)
      effect:SetCfgID(1003570000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100358] = function(args)
  -- function num : 0_240 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003580000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100359] = function(args)
  -- function num : 0_241 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003590000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100360] = function(args)
  -- function num : 0_242 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003600000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100361] = function(args)
  -- function num : 0_243 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003610000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100362] = function(args)
  -- function num : 0_244 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003620000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100363] = function(args)
  -- function num : 0_245 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003630000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100364] = function(args)
  -- function num : 0_246 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003640000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100365] = function(args)
  -- function num : 0_247 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003650000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100366] = function(args)
  -- function num : 0_248 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003660000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100367] = function(args)
  -- function num : 0_249 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003670000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100368] = function(args)
  -- function num : 0_250 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003680000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100369] = function(args)
  -- function num : 0_251 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003690000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100370] = function(args)
  -- function num : 0_252 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003700000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100371] = function(args)
  -- function num : 0_253 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003710000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100372] = function(args)
  -- function num : 0_254 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003720000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100373] = function(args)
  -- function num : 0_255 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003730000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100374] = function(args)
  -- function num : 0_256 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003740000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100375] = function(args)
  -- function num : 0_257 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003750000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100376] = function(args)
  -- function num : 0_258 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003760000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100377] = function(args)
  -- function num : 0_259 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003770000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100378] = function(args)
  -- function num : 0_260 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003780000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100379] = function(args)
  -- function num : 0_261 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003790000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100380] = function(args)
  -- function num : 0_262 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003800000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100381] = function(args)
  -- function num : 0_263 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003810000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100382] = function(args)
  -- function num : 0_264 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003820000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100383] = function(args)
  -- function num : 0_265 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003830000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100384] = function(args)
  -- function num : 0_266 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003840000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100385] = function(args)
  -- function num : 0_267 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003850000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100386] = function(args)
  -- function num : 0_268 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003860000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100387] = function(args)
  -- function num : 0_269 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003870000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100388] = function(args)
  -- function num : 0_270 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003880000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100389] = function(args)
  -- function num : 0_271 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003890000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100390] = function(args)
  -- function num : 0_272 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003900000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100391] = function(args)
  -- function num : 0_273 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003910000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100392] = function(args)
  -- function num : 0_274 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("DungeonCameraGroup/MainCamera/Effect", false)
      effect:SetCfgID(1003920000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100393] = function(args)
  -- function num : 0_275 , upvalues : _ENV
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
    effect:SetCfgID(1003930000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1221, false, false)
      effect:SetCfgID(1003930000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1003930000)
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
, [100395] = function(args)
  -- function num : 0_276 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 256)
      effect:SetCfgID(1003950000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100396] = function(args)
  -- function num : 0_277 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 234)
      effect:SetCfgID(1003960000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100401] = function(args)
  -- function num : 0_278 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", false)
    effect:SetCfgID(1004010000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1226, false, false)
      effect:SetCfgID(1004010000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateDialogEffect)(11, "1")
          effect:SetCfgID(1004010001)
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
, [100402] = function(args)
  -- function num : 0_279 , upvalues : _ENV
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
    effect:SetCfgID(1004020000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1172, false, false)
      effect:SetCfgID(1004020000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004020000)
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
, [100403] = function(args)
  -- function num : 0_280 , upvalues : _ENV
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
    effect:SetCfgID(1004030000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1227, false, false)
      effect:SetCfgID(1004030000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004030000)
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
, [100404] = function(args)
  -- function num : 0_281 , upvalues : _ENV
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
    effect:SetCfgID(1004040000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1228, false, false)
      effect:SetCfgID(1004040000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004040000)
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
, [100405] = function(args)
  -- function num : 0_282 , upvalues : _ENV
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
    effect:SetCfgID(1004050000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1230, false, false)
      effect:SetCfgID(1004050000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004050000)
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
, [100406] = function(args)
  -- function num : 0_283 , upvalues : _ENV
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
    effect:SetCfgID(1004060000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1229, false, false)
      effect:SetCfgID(1004060000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004060000)
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
, [100407] = function(args)
  -- function num : 0_284 , upvalues : _ENV
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
    effect:SetCfgID(1004070000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1232, false, false)
      effect:SetCfgID(1004070000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004070000)
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
, [100408] = function(args)
  -- function num : 0_285 , upvalues : _ENV
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
    effect:SetCfgID(1004080000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3019, true, false)
      effect:SetCfgID(1004080000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004080000)
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
, [100409] = function(args)
  -- function num : 0_286 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1004090000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100410] = function(args)
  -- function num : 0_287 , upvalues : _ENV
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
    effect:SetCfgID(1004100000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1235, false, false)
      effect:SetCfgID(1004100000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004100000)
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
, [100411] = function(args)
  -- function num : 0_288 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
      effect:SetCfgID(1004110000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100412] = function(args)
  -- function num : 0_289 , upvalues : _ENV
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
    effect:SetCfgID(1004120000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1236, false, false)
      effect:SetCfgID(1004120000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004120000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateDialogEffect)(4, "13")
            effect:SetCfgID(1004120000)
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
, [100413] = function(args)
  -- function num : 0_290 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
      effect:SetCfgID(1004130000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100414] = function(args)
  -- function num : 0_291 , upvalues : _ENV
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
    effect:SetCfgID(1004140000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1238, false, false)
      effect:SetCfgID(1004140000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004140000)
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
, [100415] = function(args)
  -- function num : 0_292 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004150000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1004150000)
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
, [100416] = function(args)
  -- function num : 0_293 , upvalues : _ENV
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
    effect:SetCfgID(1004160000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1239, false, false)
      effect:SetCfgID(1004160000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004160000)
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
, [100417] = function(args)
  -- function num : 0_294 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004170000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1004170000)
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
, [100418] = function(args)
  -- function num : 0_295 , upvalues : _ENV
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
    effect:SetCfgID(1004180000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1240, false, false)
      effect:SetCfgID(1004180000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004180000)
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
, [100419] = function(args)
  -- function num : 0_296 , upvalues : _ENV
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
    effect:SetCfgID(1004190000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToEffect)("[actor]", 0.85, 9, 12, true)
      effect:SetCfgID(1004190000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1241, false, false)
        effect:SetCfgID(1004190000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004190000)
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
, [100420] = function(args)
  -- function num : 0_297 , upvalues : _ENV
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
    effect:SetCfgID(1004200000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1242, false, false)
      effect:SetCfgID(1004200000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1004200000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004200000)
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
, [100421] = function(args)
  -- function num : 0_298 , upvalues : _ENV
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
    effect:SetCfgID(1004210000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1243, false, false)
      effect:SetCfgID(1004210000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Sence_TX_GuoChang_Jingzi_binghuo", "trapState", 1, "", 0)
        effect:SetCfgID(1004210000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004210000)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_4/ChairCat/Char_Cat", false)
            effect:SetCfgID(1004210000)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateJumpEffect)(10031, 1)
                effect:SetCfgID(1004210000)
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
end
, [100422] = function(args)
  -- function num : 0_299 , upvalues : _ENV
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
    effect:SetCfgID(1004220000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 1, 4.8, 0, -5.8, true)
      effect:SetCfgID(1004220000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1244, false, false)
        effect:SetCfgID(1004220000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateBlockChangeEffect)(14, 10, 1, 1, true)
          effect:SetCfgID(1004220000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(true)
              effect:SetCfgID(1004220000)
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
, [100423] = function(args)
  -- function num : 0_300 , upvalues : _ENV
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
    effect:SetCfgID(1004230000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1245, false, false)
      effect:SetCfgID(1004230000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004230000)
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
, [100424] = function(args)
  -- function num : 0_301 , upvalues : _ENV
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
    effect:SetCfgID(1004240000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1246, false, false)
      effect:SetCfgID(1004240000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1004240000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004240000)
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
, [100426] = function(args)
  -- function num : 0_302 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  do
    local root = nil
    if not composed then
      composed = (EffectFactory.CreateComposedEffect)()
      root = composed
    else
      root = (EffectFactory.CreateComposedEffect)()
    end
    if upper then
      upper:AddEffect(root)
    end
    return composed
  end
end
, [100427] = function(args)
  -- function num : 0_303 , upvalues : _ENV
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
    effect:SetCfgID(1004270000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1249, false, false)
      effect:SetCfgID(1004270000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004270000)
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
, [100428] = function(args)
  -- function num : 0_304 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004280000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", true)
        effect:SetCfgID(1004280000)
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
, [100429] = function(args)
  -- function num : 0_305 , upvalues : _ENV
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
    effect:SetCfgID(1004290000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1250, false, false)
      effect:SetCfgID(1004290000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004290000)
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
, [100430] = function(args)
  -- function num : 0_306 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004300000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
        effect:SetCfgID(1004300000)
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
, [100431] = function(args)
  -- function num : 0_307 , upvalues : _ENV
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
    effect:SetCfgID(1004310000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1254, false, false)
      effect:SetCfgID(1004310000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004310000)
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
, [100432] = function(args)
  -- function num : 0_308 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1004320000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_4", true)
        effect:SetCfgID(1004320000)
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
, [100433] = function(args)
  -- function num : 0_309 , upvalues : _ENV
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
    effect:SetCfgID(1004330000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1255, false, false)
      effect:SetCfgID(1004330000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004330000)
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
, [100434] = function(args)
  -- function num : 0_310 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_4", false)
    effect:SetCfgID(1004340000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1004340000)
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
, [100435] = function(args)
  -- function num : 0_311 , upvalues : _ENV
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
    effect:SetCfgID(1004350000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1253, false, false)
      effect:SetCfgID(1004350000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004350000)
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
, [100436] = function(args)
  -- function num : 0_312 , upvalues : _ENV
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
    effect:SetCfgID(1004360000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1257, false, false)
      effect:SetCfgID(1004360000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004360000)
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
, [100437] = function(args)
  -- function num : 0_313 , upvalues : _ENV
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
    effect:SetCfgID(1004370000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1258, false, false)
      effect:SetCfgID(1004370000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1004370000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004370000)
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
, [100438] = function(args)
  -- function num : 0_314 , upvalues : _ENV
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
    effect:SetCfgID(1004380000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1259, false, false)
      effect:SetCfgID(1004380000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004380000)
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
, [100439] = function(args)
  -- function num : 0_315 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1004390000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_4", true)
        effect:SetCfgID(1004390000)
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
, [100440] = function(args)
  -- function num : 0_316 , upvalues : _ENV
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
    effect:SetCfgID(1004400000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1260, false, false)
      effect:SetCfgID(1004400000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004400000)
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
, [100441] = function(args)
  -- function num : 0_317 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1004410000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_4", false)
        effect:SetCfgID(1004410000)
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
, [100442] = function(args)
  -- function num : 0_318 , upvalues : _ENV
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
    effect:SetCfgID(1004420000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1262, false, false)
      effect:SetCfgID(1004420000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004420000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1004420000)
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
, [100443] = function(args)
  -- function num : 0_319 , upvalues : _ENV
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
    effect:SetCfgID(1004430000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1263, false, false)
      effect:SetCfgID(1004430000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004430000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1004430000)
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
, [100444] = function(args)
  -- function num : 0_320 , upvalues : _ENV
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
    effect:SetCfgID(1004440000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1264, false, false)
      effect:SetCfgID(1004440000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004440000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
            effect:SetCfgID(1004440000)
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
, [100445] = function(args)
  -- function num : 0_321 , upvalues : _ENV
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
    effect:SetCfgID(1004450000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1265, false, false)
      effect:SetCfgID(1004450000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004450000)
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
, [100446] = function(args)
  -- function num : 0_322 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004460000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1004460000)
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
, [100447] = function(args)
  -- function num : 0_323 , upvalues : _ENV
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
    effect:SetCfgID(1004470000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1266, false, false)
      effect:SetCfgID(1004470000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004470000)
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
, [100448] = function(args)
  -- function num : 0_324 , upvalues : _ENV
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
    effect:SetCfgID(1004480000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1267, false, false)
      effect:SetCfgID(1004480000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004480000)
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
, [100449] = function(args)
  -- function num : 0_325 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004490000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
      effect:SetCfgID(1004490000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_3", true)
          effect:SetCfgID(1004490000)
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
, [100450] = function(args)
  -- function num : 0_326 , upvalues : _ENV
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
    effect:SetCfgID(1004500000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1269, false, false)
      effect:SetCfgID(1004500000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004500000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
          effect:SetCfgID(1004500000)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateDialogEffect)(4, "23")
              effect:SetCfgID(1004500000)
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
, [100451] = function(args)
  -- function num : 0_327 , upvalues : _ENV
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
    effect:SetCfgID(1004510000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1270, false, false)
      effect:SetCfgID(1004510000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004510000)
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
, [100452] = function(args)
  -- function num : 0_328 , upvalues : _ENV
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
    effect:SetCfgID(1004520000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1271, false, false)
      effect:SetCfgID(1004520000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004520000)
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
, [100453] = function(args)
  -- function num : 0_329 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1004530000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100454] = function(args)
  -- function num : 0_330 , upvalues : _ENV
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
    effect:SetCfgID(1004540000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1273, false, false)
      effect:SetCfgID(1004540000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004540000)
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
, [100455] = function(args)
  -- function num : 0_331 , upvalues : _ENV
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
    effect:SetCfgID(1004550000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1274, false, false)
      effect:SetCfgID(1004550000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004550000)
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
, [100456] = function(args)
  -- function num : 0_332 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1004560000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100457] = function(args)
  -- function num : 0_333 , upvalues : _ENV
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
    effect:SetCfgID(1004570000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1276, false, false)
      effect:SetCfgID(1004570000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1004570000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004570000)
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
, [100458] = function(args)
  -- function num : 0_334 , upvalues : _ENV
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
    effect:SetCfgID(1004580000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1277, false, false)
      effect:SetCfgID(1004580000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004580000)
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
, [100459] = function(args)
  -- function num : 0_335 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Broken", false)
    effect:SetCfgID(1004590000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_6", true)
      effect:SetCfgID(1004590000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateBlockChangeEffect)(16, 50, 1, 2, true)
        effect:SetCfgID(1004590000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateBlockChangeEffect)(17, 49, 1, 4, true)
            effect:SetCfgID(1004590000)
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
, [100460] = function(args)
  -- function num : 0_336 , upvalues : _ENV
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
    effect:SetCfgID(1004600000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1278, false, false)
      effect:SetCfgID(1004600000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004600000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateJumpEffect)(14028, 1)
            effect:SetCfgID(1004600000)
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
, [100461] = function(args)
  -- function num : 0_337 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_6", false)
    effect:SetCfgID(1004610000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
      effect:SetCfgID(1004610000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Broken", false)
        effect:SetCfgID(1004610000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateBlockChangeEffect)(16, 50, 1, 2, true)
          effect:SetCfgID(1004610000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateBlockChangeEffect)(17, 49, 1, 4, true)
              effect:SetCfgID(1004610000)
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
, [100462] = function(args)
  -- function num : 0_338 , upvalues : _ENV
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
    effect:SetCfgID(1004620000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.85, 8.94, 0, -11.93, true)
      effect:SetCfgID(1004620000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1280, false, false)
        effect:SetCfgID(1004620000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_1/ChairCat/Char_Cat", false)
          effect:SetCfgID(1004620000)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(true)
              effect:SetCfgID(1004620000)
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
, [100463] = function(args)
  -- function num : 0_339 , upvalues : _ENV
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
    effect:SetCfgID(1004630000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1281, false, false)
      effect:SetCfgID(1004630000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004630000)
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
, [100464] = function(args)
  -- function num : 0_340 , upvalues : _ENV
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
    effect:SetCfgID(1004640000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1282, false, false)
      effect:SetCfgID(1004640000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004640000)
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
, [100465] = function(args)
  -- function num : 0_341 , upvalues : _ENV
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
    effect:SetCfgID(1004650000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1283, false, false)
      effect:SetCfgID(1004650000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004650000)
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
, [100466] = function(args)
  -- function num : 0_342 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
      effect:SetCfgID(1004660000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100467] = function(args)
  -- function num : 0_343 , upvalues : _ENV
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
    effect:SetCfgID(1004670000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1284, false, false)
      effect:SetCfgID(1004670000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004670000)
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
, [100468] = function(args)
  -- function num : 0_344 , upvalues : _ENV
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
    effect:SetCfgID(1004680000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1285, false, false)
      effect:SetCfgID(1004680000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004680000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateJumpBackEffect)(false)
            effect:SetCfgID(1004680000)
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
, [100469] = function(args)
  -- function num : 0_345 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004690000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
        effect:SetCfgID(1004690000)
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
, [100470] = function(args)
  -- function num : 0_346 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1004700000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
      effect:SetCfgID(1004700000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", true)
        effect:SetCfgID(1004700000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateFreezeEffect)(true)
          effect:SetCfgID(1004700000)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1288, false, false)
            effect:SetCfgID(1004700000)
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateThawEffect)(true)
                effect:SetCfgID(1004700000)
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
end
, [100471] = function(args)
  -- function num : 0_347 , upvalues : _ENV
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
    effect:SetCfgID(1004710000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1289, false, false)
      effect:SetCfgID(1004710000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
        effect:SetCfgID(1004710000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004710000)
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
, [100472] = function(args)
  -- function num : 0_348 , upvalues : _ENV
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
    effect:SetCfgID(1004720000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1290, false, false)
      effect:SetCfgID(1004720000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Sence_TX_W2_BaoShiPingZhangMen", false)
        effect:SetCfgID(1004720000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateDialogEffect)(4, "22")
          effect:SetCfgID(1004720000)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004720000)
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateJumpEffect)(14037, 1)
                effect:SetCfgID(1004720001)
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
end
, [100473] = function(args)
  -- function num : 0_349 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1291, false, false)
    effect:SetCfgID(1004730000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateStartChatEffect)(1223)
        effect:SetCfgID(1004730000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100474] = function(args)
  -- function num : 0_350 , upvalues : _ENV
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
    effect:SetCfgID(1004740000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1293, false, false)
      effect:SetCfgID(1004740000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "30")
        effect:SetCfgID(1004740000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004740000)
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
, [100475] = function(args)
  -- function num : 0_351 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateRemoveEventEffect)(100474)
    effect:SetCfgID(1004750000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("w2_m_village_13", false)
        effect:SetCfgID(1004750000)
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
, [100476] = function(args)
  -- function num : 0_352 , upvalues : _ENV
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
    effect:SetCfgID(1004760000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1248, false, false)
      effect:SetCfgID(1004760000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("n_w2_11", false)
        effect:SetCfgID(1004760000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004760000)
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
, [100477] = function(args)
  -- function num : 0_353 , upvalues : _ENV
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
    effect:SetCfgID(1004770000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1294, false, false)
      effect:SetCfgID(1004770000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1004770000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004770000)
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
, [100478] = function(args)
  -- function num : 0_354 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1/char_017m", false)
    effect:SetCfgID(1004780000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1/ChairCat/Char_Cat", false)
        effect:SetCfgID(1004780000)
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
, [100479] = function(args)
  -- function num : 0_355 , upvalues : _ENV
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
      effect:SetCfgID(1004790000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100480] = function(args)
  -- function num : 0_356 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  do
    local root = nil
    if not composed then
      composed = (EffectFactory.CreateComposedEffect)()
      root = composed
    else
      root = (EffectFactory.CreateComposedEffect)()
    end
    if upper then
      upper:AddEffect(root)
    end
    return composed
  end
end
, [100481] = function(args)
  -- function num : 0_357 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
      effect:SetCfgID(1004810000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100482] = function(args)
  -- function num : 0_358 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateStartChatEffect)(1228)
      effect:SetCfgID(1004820000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100483] = function(args)
  -- function num : 0_359 , upvalues : _ENV
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
    effect:SetCfgID(1004830000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1296, false, false)
      effect:SetCfgID(1004830000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_t1_03m", false)
        effect:SetCfgID(1004830000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004830000)
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
, [100484] = function(args)
  -- function num : 0_360 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100485)
      effect:SetCfgID(1004840000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100485] = function(args)
  -- function num : 0_361 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateRemoveEventEffect)(100487)
    effect:SetCfgID(1004850000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateRemoveEventEffect)(100502)
        effect:SetCfgID(1004850002)
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
, [100486] = function(args)
  -- function num : 0_362 , upvalues : _ENV
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
    effect:SetCfgID(1004860000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1297, false, false)
      effect:SetCfgID(1004860000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004860000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateBattleEffect)(1171)
            effect:SetCfgID(1004860000)
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
, [100487] = function(args)
  -- function num : 0_363 , upvalues : _ENV
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
    effect:SetCfgID(1004870000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1298, false, false)
      effect:SetCfgID(1004870000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1004870000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateBattleEffect)(1172)
            effect:SetCfgID(1004870000)
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
, [100488] = function(args)
  -- function num : 0_364 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100463)
      effect:SetCfgID(1004880000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100489] = function(args)
  -- function num : 0_365 , upvalues : _ENV
  local composed = nil
  local upper = root or composed
  do
    local root = nil
    if not composed then
      composed = (EffectFactory.CreateComposedEffect)()
      root = composed
    else
      root = (EffectFactory.CreateComposedEffect)()
    end
    if upper then
      upper:AddEffect(root)
    end
    return composed
  end
end
, [100490] = function(args)
  -- function num : 0_366 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
      effect:SetCfgID(1004900000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100491] = function(args)
  -- function num : 0_367 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateFlyToWorldPosEffect)("[actor]", 13, 0, -20, true)
      effect:SetCfgID(1004910000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100492] = function(args)
  -- function num : 0_368 , upvalues : _ENV
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
      effect:SetCfgID(1004920000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100493] = function(args)
  -- function num : 0_369 , upvalues : _ENV
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
    effect:SetCfgID(1004930000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1128, false, false)
      effect:SetCfgID(1004930000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004930000)
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
, [100494] = function(args)
  -- function num : 0_370 , upvalues : _ENV
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
    effect:SetCfgID(1004940000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1129, false, false)
      effect:SetCfgID(1004940000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1004940000)
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
, [100495] = function(args)
  -- function num : 0_371 , upvalues : _ENV
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
    effect:SetCfgID(1004950000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(3005, true, false)
      effect:SetCfgID(1004950000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("[npc 10005]", "NPCstate", 9, "", 0)
        effect:SetCfgID(1004950000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004950000)
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
, [100496] = function(args)
  -- function num : 0_372 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFreezeEffect)()
    effect:SetCfgID(1004960000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1123, false, false)
      effect:SetCfgID(1004960000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)()
          effect:SetCfgID(1004960000)
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
, [100497] = function(args)
  -- function num : 0_373 , upvalues : _ENV
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
    effect:SetCfgID(1004970000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1124, false, false)
      effect:SetCfgID(1004970001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateBattleEffect)(10008)
        effect:SetCfgID(1004970002)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1004970003)
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
, [100498] = function(args)
  -- function num : 0_374 , upvalues : _ENV
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
    effect:SetCfgID(1004980000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1285, false, false)
      effect:SetCfgID(1004980000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateJumpEffect)(13035, 2)
          effect:SetCfgID(1004980003)
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
, [100499] = function(args)
  -- function num : 0_375 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1301, false, false)
    effect:SetCfgID(1004990000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(false)
        effect:SetCfgID(1004990000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100500] = function(args)
  -- function num : 0_376 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(5, "27")
      effect:SetCfgID(1005000000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100501] = function(args)
  -- function num : 0_377 , upvalues : _ENV
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
    effect:SetCfgID(1005010000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM02")
      effect:SetCfgID(1005010000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "31")
        effect:SetCfgID(1005010000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM05")
          effect:SetCfgID(1005010000)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM06")
            effect:SetCfgID(1005010000)
            root:AddEffect(effect)
            local upper = effect
            do
              local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM07")
              effect:SetCfgID(1005010000)
              root:AddEffect(effect)
              local upper = effect
              do
                local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM08")
                effect:SetCfgID(1005010000)
                root:AddEffect(effect)
                local upper = effect
                do
                  local effect = (EffectFactory.CreateAnimationEffect)("CM StateDrivenCamera1", "CM01")
                  effect:SetCfgID(1005010000)
                  root:AddEffect(effect)
                  local upper = effect
                  do
                    do
                      local effect = (EffectFactory.CreateThawEffect)(false)
                      effect:SetCfgID(1005010000)
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
      end
    end
  end
end
, [100502] = function(args)
  -- function num : 0_378 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBattleEffect)(1172)
      effect:SetCfgID(1005020000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100503] = function(args)
  -- function num : 0_379 , upvalues : _ENV
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
    effect:SetCfgID(1005030000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1302, false, false)
      effect:SetCfgID(1005030000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1005030000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(false)
            effect:SetCfgID(1005030000)
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
, [100504] = function(args)
  -- function num : 0_380 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBattleEffect)(10008)
      effect:SetCfgID(1005040002)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100509] = function(args)
  -- function num : 0_381 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBattleEffect)(1171)
      effect:SetCfgID(1005090000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100510] = function(args)
  -- function num : 0_382 , upvalues : _ENV
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
    effect:SetCfgID(1005100000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1308, false, false)
      effect:SetCfgID(1005100000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005100000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005100000)
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
, [100511] = function(args)
  -- function num : 0_383 , upvalues : _ENV
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
    effect:SetCfgID(1005110000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1309, false, false)
      effect:SetCfgID(1005110000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1005110000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1005110000)
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
, [100512] = function(args)
  -- function num : 0_384 , upvalues : _ENV
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
    effect:SetCfgID(1005120000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1310, false, false)
      effect:SetCfgID(1005120000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1005120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1005120000)
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
, [100513] = function(args)
  -- function num : 0_385 , upvalues : _ENV
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
    effect:SetCfgID(1005130000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1394, false, false)
      effect:SetCfgID(1005130000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1005130000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1005130000)
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
, [100514] = function(args)
  -- function num : 0_386 , upvalues : _ENV
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
    effect:SetCfgID(1005140000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1312, false, false)
      effect:SetCfgID(1005140000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005140000)
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
, [100515] = function(args)
  -- function num : 0_387 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005150000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_4", true)
        effect:SetCfgID(1005150000)
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
, [100516] = function(args)
  -- function num : 0_388 , upvalues : _ENV
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
    effect:SetCfgID(1005160000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1314, false, false)
      effect:SetCfgID(1005160000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005160000)
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
, [100517] = function(args)
  -- function num : 0_389 , upvalues : _ENV
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
    effect:SetCfgID(1005170000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1313, false, false)
      effect:SetCfgID(1005170000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005170000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("StaticBridge", true)
          effect:SetCfgID(1005170000)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateVisualEffect)("AnimationBridge", false)
              effect:SetCfgID(1005170000)
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
end
, [100518] = function(args)
  -- function num : 0_390 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005180000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_4", false)
        effect:SetCfgID(1005180000)
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
, [100519] = function(args)
  -- function num : 0_391 , upvalues : _ENV
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
    effect:SetCfgID(1005190000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(0, false, false)
      effect:SetCfgID(1005190000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(false)
          effect:SetCfgID(1005190000)
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
, [100520] = function(args)
  -- function num : 0_392 , upvalues : _ENV
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
    effect:SetCfgID(1005200000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(0, false, false)
      effect:SetCfgID(1005200000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(false)
          effect:SetCfgID(1005200000)
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
, [100521] = function(args)
  -- function num : 0_393 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1316, false, false)
    effect:SetCfgID(1005210001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1005210002)
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
, [100522] = function(args)
  -- function num : 0_394 , upvalues : _ENV
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
    effect:SetCfgID(1005220000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1317, false, false)
      effect:SetCfgID(1005220001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1005220002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(false)
            effect:SetCfgID(1005220003)
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
, [100523] = function(args)
  -- function num : 0_395 , upvalues : _ENV
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
    effect:SetCfgID(1005230000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1411, false, false)
      effect:SetCfgID(1005230000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(false)
          effect:SetCfgID(1005230000)
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
, [100524] = function(args)
  -- function num : 0_396 , upvalues : _ENV
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
    effect:SetCfgID(1005240000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Tunnel/Cloud/Black", false)
      effect:SetCfgID(1005240000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Tunnel/Cloud/Loop", true)
        effect:SetCfgID(1005240000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1318, false, false)
          effect:SetCfgID(1005240000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(false)
              effect:SetCfgID(1005240000)
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
, [100525] = function(args)
  -- function num : 0_397 , upvalues : _ENV
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
    effect:SetCfgID(1005250000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1319, false, false)
      effect:SetCfgID(1005250000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005250000)
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
, [100526] = function(args)
  -- function num : 0_398 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
    effect:SetCfgID(1005260000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1005260000)
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
, [100527] = function(args)
  -- function num : 0_399 , upvalues : _ENV
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
    effect:SetCfgID(1005270000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1320, false, false)
      effect:SetCfgID(1005270000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005270000)
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
, [100528] = function(args)
  -- function num : 0_400 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005280000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1005280000)
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
, [100529] = function(args)
  -- function num : 0_401 , upvalues : _ENV
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
    effect:SetCfgID(1005290000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1322, false, false)
      effect:SetCfgID(1005290000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005290000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
            effect:SetCfgID(1005290000)
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
, [100530] = function(args)
  -- function num : 0_402 , upvalues : _ENV
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
    effect:SetCfgID(1005300000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1323, false, false)
      effect:SetCfgID(1005300000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005300000)
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
, [100531] = function(args)
  -- function num : 0_403 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005310000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1005310000)
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
, [100532] = function(args)
  -- function num : 0_404 , upvalues : _ENV
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
    effect:SetCfgID(1005320000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1324, false, false)
      effect:SetCfgID(1005320000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005320000)
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
, [100533] = function(args)
  -- function num : 0_405 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005330000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1005330000)
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
, [100534] = function(args)
  -- function num : 0_406 , upvalues : _ENV
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
    effect:SetCfgID(1005340000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1326, false, false)
      effect:SetCfgID(1005340000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005340000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005340000)
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
, [100535] = function(args)
  -- function num : 0_407 , upvalues : _ENV
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
    effect:SetCfgID(1005350000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1327, false, false)
      effect:SetCfgID(1005350000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005350000)
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
, [100536] = function(args)
  -- function num : 0_408 , upvalues : _ENV
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
    effect:SetCfgID(1005360000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1328, false, false)
      effect:SetCfgID(1005360000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005360000)
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
, [100537] = function(args)
  -- function num : 0_409 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005370000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_3", true)
      effect:SetCfgID(1005370000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
          effect:SetCfgID(1005370000)
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
, [100538] = function(args)
  -- function num : 0_410 , upvalues : _ENV
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
    effect:SetCfgID(1005380000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1329, false, false)
      effect:SetCfgID(1005380000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005380000)
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
, [100539] = function(args)
  -- function num : 0_411 , upvalues : _ENV
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
    effect:SetCfgID(1005390000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1330, false, false)
      effect:SetCfgID(1005390000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005390000)
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
, [100540] = function(args)
  -- function num : 0_412 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005400000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
      effect:SetCfgID(1005400000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
          effect:SetCfgID(1005400000)
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
, [100541] = function(args)
  -- function num : 0_413 , upvalues : _ENV
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
    effect:SetCfgID(1005410000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1332, false, false)
      effect:SetCfgID(1005410000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005410000)
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
, [100542] = function(args)
  -- function num : 0_414 , upvalues : _ENV
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
    effect:SetCfgID(1005420000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1333, false, false)
      effect:SetCfgID(1005420000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005420000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1/ChairCat/Char_Cat", false)
            effect:SetCfgID(1005420000)
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
, [100543] = function(args)
  -- function num : 0_415 , upvalues : _ENV
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
    effect:SetCfgID(1005430000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1334, false, false)
      effect:SetCfgID(1005430000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005430000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005430000)
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
, [100544] = function(args)
  -- function num : 0_416 , upvalues : _ENV
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
    effect:SetCfgID(1005440000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1335, false, false)
      effect:SetCfgID(1005440000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005440000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005440000)
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
, [100545] = function(args)
  -- function num : 0_417 , upvalues : _ENV
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
    effect:SetCfgID(1005450000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1336, false, false)
      effect:SetCfgID(1005450000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(false)
          effect:SetCfgID(1005450000)
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
, [100546] = function(args)
  -- function num : 0_418 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100545)
      effect:SetCfgID(1005460000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100547] = function(args)
  -- function num : 0_419 , upvalues : _ENV
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
    effect:SetCfgID(1005470000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1337, false, false)
      effect:SetCfgID(1005470000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005470000)
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
, [100548] = function(args)
  -- function num : 0_420 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1005480000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", true)
        effect:SetCfgID(1005480000)
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
, [100549] = function(args)
  -- function num : 0_421 , upvalues : _ENV
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
    effect:SetCfgID(1005490000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1338, false, false)
      effect:SetCfgID(1005490000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005490000)
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
, [100550] = function(args)
  -- function num : 0_422 , upvalues : _ENV
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
    effect:SetCfgID(1005500000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1339, false, false)
      effect:SetCfgID(1005500000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005500000)
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
, [100551] = function(args)
  -- function num : 0_423 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1005510000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
        effect:SetCfgID(1005510000)
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
, [100552] = function(args)
  -- function num : 0_424 , upvalues : _ENV
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
    effect:SetCfgID(1005520000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1341, false, false)
      effect:SetCfgID(1005520000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005520000)
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
, [100553] = function(args)
  -- function num : 0_425 , upvalues : _ENV
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
    effect:SetCfgID(1005530000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1342, false, false)
      effect:SetCfgID(1005530000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005530000)
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
, [100554] = function(args)
  -- function num : 0_426 , upvalues : _ENV
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
    effect:SetCfgID(1005540000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1343, false, false)
      effect:SetCfgID(1005540000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005540000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
            effect:SetCfgID(1005540000)
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
, [100555] = function(args)
  -- function num : 0_427 , upvalues : _ENV
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
    effect:SetCfgID(1005550000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1344, false, false)
      effect:SetCfgID(1005550000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005550000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005550000)
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
, [100556] = function(args)
  -- function num : 0_428 , upvalues : _ENV
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
    effect:SetCfgID(1005560000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1348, false, false)
      effect:SetCfgID(1005560000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005560000)
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
, [100557] = function(args)
  -- function num : 0_429 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005570000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1005570000)
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
, [100558] = function(args)
  -- function num : 0_430 , upvalues : _ENV
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
    effect:SetCfgID(1005580000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1349, false, false)
      effect:SetCfgID(1005580000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005580000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_4", false)
            effect:SetCfgID(1005580000)
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
, [100559] = function(args)
  -- function num : 0_431 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005590000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
      effect:SetCfgID(1005590000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_4", false)
          effect:SetCfgID(1005590000)
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
, [100560] = function(args)
  -- function num : 0_432 , upvalues : _ENV
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
    effect:SetCfgID(1005600000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1351, false, false)
      effect:SetCfgID(1005600000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005600000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_5", false)
            effect:SetCfgID(1005600000)
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
, [100561] = function(args)
  -- function num : 0_433 , upvalues : _ENV
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
    effect:SetCfgID(1005610000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1352, false, false)
      effect:SetCfgID(1005610000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005610000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005610000)
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
, [100562] = function(args)
  -- function num : 0_434 , upvalues : _ENV
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
    effect:SetCfgID(1005620000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1353, false, false)
      effect:SetCfgID(1005620000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005620000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005620000)
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
, [100563] = function(args)
  -- function num : 0_435 , upvalues : _ENV
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
    effect:SetCfgID(1005630000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1354, false, false)
      effect:SetCfgID(1005630000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005630000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005630000)
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
, [100564] = function(args)
  -- function num : 0_436 , upvalues : _ENV
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
    effect:SetCfgID(1005640000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1355, false, false)
      effect:SetCfgID(1005640000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005640000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
          effect:SetCfgID(1005640000)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
              effect:SetCfgID(1005640000)
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
, [100565] = function(args)
  -- function num : 0_437 , upvalues : _ENV
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
    effect:SetCfgID(1005650000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1356, false, false)
      effect:SetCfgID(1005650000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005650000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005650000)
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
, [100566] = function(args)
  -- function num : 0_438 , upvalues : _ENV
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
    effect:SetCfgID(1005660000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1357, false, false)
      effect:SetCfgID(1005660000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005660000)
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
, [100567] = function(args)
  -- function num : 0_439 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1005670000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_3", true)
        effect:SetCfgID(1005670000)
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
, [100568] = function(args)
  -- function num : 0_440 , upvalues : _ENV
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
    effect:SetCfgID(1005680000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1358, false, false)
      effect:SetCfgID(1005680000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005680000)
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
, [100569] = function(args)
  -- function num : 0_441 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
    effect:SetCfgID(1005690000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1005690000)
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
, [100570] = function(args)
  -- function num : 0_442 , upvalues : _ENV
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
    effect:SetCfgID(1005700000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1360, false, false)
      effect:SetCfgID(1005700000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005700000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1/ChairCat/Char_Cat", false)
            effect:SetCfgID(1005700000)
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
, [100571] = function(args)
  -- function num : 0_443 , upvalues : _ENV
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
    effect:SetCfgID(1005710000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1361, false, false)
      effect:SetCfgID(1005710000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005710000)
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
, [100572] = function(args)
  -- function num : 0_444 , upvalues : _ENV
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
    effect:SetCfgID(1005720000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1362, false, false)
      effect:SetCfgID(1005720000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005720000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005720000)
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
, [100573] = function(args)
  -- function num : 0_445 , upvalues : _ENV
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
    effect:SetCfgID(1005730000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1363, false, false)
      effect:SetCfgID(1005730000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005730000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005730000)
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
, [100574] = function(args)
  -- function num : 0_446 , upvalues : _ENV
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
    effect:SetCfgID(1005740000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1364, false, false)
      effect:SetCfgID(1005740000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005740000)
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
, [100575] = function(args)
  -- function num : 0_447 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005750000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1005750000)
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
, [100576] = function(args)
  -- function num : 0_448 , upvalues : _ENV
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
    effect:SetCfgID(1005760000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1365, false, false)
      effect:SetCfgID(1005760000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005760000)
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
, [100577] = function(args)
  -- function num : 0_449 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
    effect:SetCfgID(1005770000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1005770000)
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
, [100578] = function(args)
  -- function num : 0_450 , upvalues : _ENV
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
    effect:SetCfgID(1005780000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1379, false, false)
      effect:SetCfgID(1005780000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005780000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005780000)
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
, [100579] = function(args)
  -- function num : 0_451 , upvalues : _ENV
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
    effect:SetCfgID(1005790000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1380, false, false)
      effect:SetCfgID(1005790000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005790000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005790000)
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
, [100580] = function(args)
  -- function num : 0_452 , upvalues : _ENV
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
    effect:SetCfgID(1005800000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1381, false, false)
      effect:SetCfgID(1005800000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005800000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1/ChairCat/Char_Cat", false)
            effect:SetCfgID(1005800000)
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
, [100581] = function(args)
  -- function num : 0_453 , upvalues : _ENV
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
    effect:SetCfgID(1005810000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1384, false, false)
      effect:SetCfgID(1005810000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005810000)
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
, [100582] = function(args)
  -- function num : 0_454 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
      effect:SetCfgID(1005820000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100583] = function(args)
  -- function num : 0_455 , upvalues : _ENV
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
    effect:SetCfgID(1005830000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1385, false, false)
      effect:SetCfgID(1005830000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1005830000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1005830000)
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
, [100584] = function(args)
  -- function num : 0_456 , upvalues : _ENV
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
    effect:SetCfgID(1005840001)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1386, false, false)
      effect:SetCfgID(1005840002)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005840003)
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
, [100585] = function(args)
  -- function num : 0_457 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1005850000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1005850000)
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
, [100586] = function(args)
  -- function num : 0_458 , upvalues : _ENV
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
    effect:SetCfgID(1005860000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1388, false, false)
      effect:SetCfgID(1005860000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005860000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_5/ChairCat/Char_Cat", false)
            effect:SetCfgID(1005860000)
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
, [100587] = function(args)
  -- function num : 0_459 , upvalues : _ENV
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
    effect:SetCfgID(1005870000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1345, false, false)
      effect:SetCfgID(1005870000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005870000)
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
, [100588] = function(args)
  -- function num : 0_460 , upvalues : _ENV
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
    effect:SetCfgID(1005880000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1346, false, false)
      effect:SetCfgID(1005880000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005880000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateRemoveEventEffect)(100612)
            effect:SetCfgID(1005880000)
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
, [100589] = function(args)
  -- function num : 0_461 , upvalues : _ENV
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
    effect:SetCfgID(1005890000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1347, false, false)
      effect:SetCfgID(1005890000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005890000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateFinishBranchEffect)()
            effect:SetCfgID(1005890000)
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
, [100590] = function(args)
  -- function num : 0_462 , upvalues : _ENV
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
    effect:SetCfgID(1005900000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1367, false, false)
      effect:SetCfgID(1005900000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005900000)
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
, [100591] = function(args)
  -- function num : 0_463 , upvalues : _ENV
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
    effect:SetCfgID(1005910000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1368, false, false)
      effect:SetCfgID(1005910000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005910000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateRemoveEventEffect)(100613)
            effect:SetCfgID(1005910000)
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
, [100592] = function(args)
  -- function num : 0_464 , upvalues : _ENV
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
    effect:SetCfgID(1005920000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1369, false, false)
      effect:SetCfgID(1005920000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005920000)
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
, [100593] = function(args)
  -- function num : 0_465 , upvalues : _ENV
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
    effect:SetCfgID(1005930000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1389, false, false)
      effect:SetCfgID(1005930000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005930000)
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
, [100594] = function(args)
  -- function num : 0_466 , upvalues : _ENV
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
    effect:SetCfgID(1005940000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateFlyToEffect)("[actor]", 8, 14, true)
      effect:SetCfgID(1005940000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1370, false, false)
        effect:SetCfgID(1005940000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateThawEffect)(false)
          effect:SetCfgID(1005940000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateFinishBranchEffect)()
              effect:SetCfgID(1005940000)
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
, [100595] = function(args)
  -- function num : 0_467 , upvalues : _ENV
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
    effect:SetCfgID(1005950000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1371, false, false)
      effect:SetCfgID(1005950000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005950000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005950000)
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
, [100596] = function(args)
  -- function num : 0_468 , upvalues : _ENV
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
    effect:SetCfgID(1005960000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1372, false, false)
      effect:SetCfgID(1005960000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005960000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
          effect:SetCfgID(1005960000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateRemoveEventEffect)(100614)
              effect:SetCfgID(1005960000)
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
end
, [100597] = function(args)
  -- function num : 0_469 , upvalues : _ENV
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
    effect:SetCfgID(1005970000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1373, false, false)
      effect:SetCfgID(1005970000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateFinishBranchEffect)()
        effect:SetCfgID(1005970000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1005970000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
              effect:SetCfgID(1005970000)
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
, [100598] = function(args)
  -- function num : 0_470 , upvalues : _ENV
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
    effect:SetCfgID(1005980000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1374, false, false)
      effect:SetCfgID(1005980000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005980000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1005980000)
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
, [100599] = function(args)
  -- function num : 0_471 , upvalues : _ENV
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
    effect:SetCfgID(1005990000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1375, false, false)
      effect:SetCfgID(1005990000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1005990000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
            effect:SetCfgID(1005990000)
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
, [100600] = function(args)
  -- function num : 0_472 , upvalues : _ENV
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
    effect:SetCfgID(1006000000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1376, false, false)
      effect:SetCfgID(1006000000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006000000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
            effect:SetCfgID(1006000000)
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
, [100601] = function(args)
  -- function num : 0_473 , upvalues : _ENV
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
    effect:SetCfgID(1006010000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1377, false, false)
      effect:SetCfgID(1006010000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_4", false)
        effect:SetCfgID(1006010000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1006010000)
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
, [100602] = function(args)
  -- function num : 0_474 , upvalues : _ENV
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
    effect:SetCfgID(1006020000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateFlyToEffect)("[actor]", 12, 2, true)
      effect:SetCfgID(1006020000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1378, false, false)
        effect:SetCfgID(1006020000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateThawEffect)(false)
          effect:SetCfgID(1006020000)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateFinishBranchEffect)()
            effect:SetCfgID(1006020000)
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateVisualEffect)("Story_5", false)
                effect:SetCfgID(1006020000)
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
end
, [100603] = function(args)
  -- function num : 0_475 , upvalues : _ENV
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
    effect:SetCfgID(1006030000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1382, false, false)
      effect:SetCfgID(1006030000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006030000)
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
, [100604] = function(args)
  -- function num : 0_476 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateFlyToEffect)("[actor]", 12, 2, true)
    effect:SetCfgID(1006040000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateFinishBranchEffect)()
      effect:SetCfgID(1006040000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(false)
          effect:SetCfgID(1006040000)
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
, [100605] = function(args)
  -- function num : 0_477 , upvalues : _ENV
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
    effect:SetCfgID(1006050000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1383, false, false)
      effect:SetCfgID(1006050000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006050000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateFinishBranchEffect)()
          effect:SetCfgID(1006050000)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateJumpBackEffect)()
              effect:SetCfgID(1006050000)
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
, [100606] = function(args)
  -- function num : 0_478 , upvalues : _ENV
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
    effect:SetCfgID(1006060000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1390, false, false)
      effect:SetCfgID(1006060000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006060000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1006060000)
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
, [100607] = function(args)
  -- function num : 0_479 , upvalues : _ENV
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
    effect:SetCfgID(1006070000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1391, false, false)
      effect:SetCfgID(1006070000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006070000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
            effect:SetCfgID(1006070000)
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
, [100608] = function(args)
  -- function num : 0_480 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("char_001_v1m", false)
    effect:SetCfgID(1006080000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1006080000)
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
, [100609] = function(args)
  -- function num : 0_481 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
    effect:SetCfgID(1006090000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("char_001_v1m", false)
        effect:SetCfgID(1006090000)
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
, [100610] = function(args)
  -- function num : 0_482 , upvalues : _ENV
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
    effect:SetCfgID(1006100000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1392, false, false)
      effect:SetCfgID(1006100000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006100000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
          effect:SetCfgID(1006100000)
          effect:SetParam("runoninit")
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
            effect:SetCfgID(1006100000)
            effect:SetParam("runoninit")
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateVisualEffect)("char_001_v1m", false)
                effect:SetCfgID(1006100000)
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
  end
end
, [100611] = function(args)
  -- function num : 0_483 , upvalues : _ENV
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
    effect:SetCfgID(1006110000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1311, false, false)
      effect:SetCfgID(1006110000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006110000)
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
, [100612] = function(args)
  -- function num : 0_484 , upvalues : _ENV
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
    effect:SetCfgID(1006120000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1395, false, false)
      effect:SetCfgID(1006120000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006120000)
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
, [100613] = function(args)
  -- function num : 0_485 , upvalues : _ENV
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
    effect:SetCfgID(1006130000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1396, false, false)
      effect:SetCfgID(1006130000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006130000)
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
, [100614] = function(args)
  -- function num : 0_486 , upvalues : _ENV
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
    effect:SetCfgID(1006140000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1402, false, false)
      effect:SetCfgID(1006140000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006140000)
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
, [100615] = function(args)
  -- function num : 0_487 , upvalues : _ENV
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
    effect:SetCfgID(1006150000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1397, false, false)
      effect:SetCfgID(1006150000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006150000)
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
, [100616] = function(args)
  -- function num : 0_488 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("char_001_v1m", false)
    effect:SetCfgID(1006160000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", true)
        effect:SetCfgID(1006160000)
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
, [100617] = function(args)
  -- function num : 0_489 , upvalues : _ENV
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
    effect:SetCfgID(1006170000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1398, false, false)
      effect:SetCfgID(1006170000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006170000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_3", false)
            effect:SetCfgID(1006170000)
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
, [100618] = function(args)
  -- function num : 0_490 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("char_001_v1m", false)
    effect:SetCfgID(1006180000)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1006180000)
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
, [100619] = function(args)
  -- function num : 0_491 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1403, false, false)
      effect:SetCfgID(1006190000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100620] = function(args)
  -- function num : 0_492 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1404, false, false)
      effect:SetCfgID(1006200000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100621] = function(args)
  -- function num : 0_493 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1405, false, false)
      effect:SetCfgID(1006210000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100622] = function(args)
  -- function num : 0_494 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1406, false, false)
      effect:SetCfgID(1006220000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100623] = function(args)
  -- function num : 0_495 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1407, false, false)
      effect:SetCfgID(1006230000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100624] = function(args)
  -- function num : 0_496 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1408, false, false)
      effect:SetCfgID(1006240000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100625] = function(args)
  -- function num : 0_497 , upvalues : _ENV
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
    effect:SetCfgID(1006250000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1409, false, false)
      effect:SetCfgID(1006250000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006250000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1006250000)
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
, [100626] = function(args)
  -- function num : 0_498 , upvalues : _ENV
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
    effect:SetCfgID(1006260000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1410, false, false)
      effect:SetCfgID(1006260000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006260000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
            effect:SetCfgID(1006260000)
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
, [100627] = function(args)
  -- function num : 0_499 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "39")
      effect:SetCfgID(1006270000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100628] = function(args)
  -- function num : 0_500 , upvalues : _ENV
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
    effect:SetCfgID(1006280000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1412, false, false)
      effect:SetCfgID(1006280000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006280000)
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
, [100629] = function(args)
  -- function num : 0_501 , upvalues : _ENV
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
    effect:SetCfgID(1006290000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1413, false, false)
      effect:SetCfgID(1006290000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006290000)
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
, [100630] = function(args)
  -- function num : 0_502 , upvalues : _ENV
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
    effect:SetCfgID(1006300000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateDialogEffect)(2, "72")
      effect:SetCfgID(1006300000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1006300000)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTimelineEffect)(1134, false, false)
          effect:SetCfgID(1006300001)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateVisualEffect)("Story_1/Char_Cat", false)
              effect:SetCfgID(1006300002)
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
end
, [100631] = function(args)
  -- function num : 0_503 , upvalues : _ENV
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
    effect:SetCfgID(1006310000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1414, false, false)
      effect:SetCfgID(1006310000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_2", false)
        effect:SetCfgID(1006310000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1006310000)
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
, [100632] = function(args)
  -- function num : 0_504 , upvalues : _ENV
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
    effect:SetCfgID(1006320000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1415, false, false)
      effect:SetCfgID(1006320000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006320000)
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
, [100633] = function(args)
  -- function num : 0_505 , upvalues : _ENV
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
    effect:SetCfgID(1006330000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1416, false, false)
      effect:SetCfgID(1006330000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006330000)
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
, [100634] = function(args)
  -- function num : 0_506 , upvalues : _ENV
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
    effect:SetCfgID(1006340000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1417, false, false)
      effect:SetCfgID(1006340000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006340000)
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
, [100635] = function(args)
  -- function num : 0_507 , upvalues : _ENV
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
    effect:SetCfgID(1006350000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1421, false, false)
      effect:SetCfgID(1006350000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006350000)
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
, [100636] = function(args)
  -- function num : 0_508 , upvalues : _ENV
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
    effect:SetCfgID(1006360000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1422, false, false)
      effect:SetCfgID(1006360000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006360000)
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
, [100637] = function(args)
  -- function num : 0_509 , upvalues : _ENV
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
    effect:SetCfgID(1006370000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1423, false, false)
      effect:SetCfgID(1006370000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1/char_055m", false)
        effect:SetCfgID(1006370000)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1006370000)
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
, [100638] = function(args)
  -- function num : 0_510 , upvalues : _ENV
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
    effect:SetCfgID(1006380000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1424, false, false)
      effect:SetCfgID(1006380000)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1006380000)
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
, [100639] = function(args)
  -- function num : 0_511 , upvalues : _ENV
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
    effect:SetCfgID(1006390000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1425, false, false)
      effect:SetCfgID(1006390000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Story_1", false)
        effect:SetCfgID(1006390000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1006390000)
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
, [100640] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10001, 1)
    effect:SetCfgID(1000010001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000010003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100641] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10002, 1)
    effect:SetCfgID(1000020001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000020003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100642] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10002, 2)
    effect:SetCfgID(1000030001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000030003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100643] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1038, false, false)
    effect:SetCfgID(1000040000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateThawEffect)(true)
      effect:SetCfgID(1000040001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateJumpEffect)(10003, 1)
          effect:SetCfgID(1000040002)
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
, [100644] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1038, false, false)
    effect:SetCfgID(1000050000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateThawEffect)(true)
      effect:SetCfgID(1000050001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateJumpEffect)(10003, 2)
          effect:SetCfgID(1000050002)
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
, [100645] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10004, 1)
    effect:SetCfgID(1000060001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000060003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100646] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1047, false, false)
    effect:SetCfgID(1000070000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateThawEffect)(true)
      effect:SetCfgID(1000070003)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateJumpEffect)(10005, 1)
          effect:SetCfgID(1000070003)
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
, [100647] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10006, 1)
    effect:SetCfgID(1000080001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000080003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100648] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10007, 1)
    effect:SetCfgID(1000090001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000090003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100649] = function(args)
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
    local effect = (EffectFactory.CreateJumpEffect)(10008, 1)
    effect:SetCfgID(1000100001)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000100003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100650] = function(args)
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
    effect:SetCfgID(1000110000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1030, false, false)
      effect:SetCfgID(1000110001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("ChairCat/Char_Cat", false)
        effect:SetCfgID(1000110002)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1000110003)
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
, [100651] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(false)
    effect:SetCfgID(1000120000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1435, false, false)
      effect:SetCfgID(1000120000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_fs_01m", false)
        effect:SetCfgID(1000120000)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(false)
            effect:SetCfgID(1000120000)
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
, [100652] = function(args)
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
    do
      local effect = (EffectFactory.CreateVisualEffect)("mon_fs_01m", false)
      effect:SetCfgID(1000130000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100653] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000150000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1036, false, false)
      effect:SetCfgID(1000150001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000150003)
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
, [100654] = function(args)
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
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02", "trapState", 1, "", 0)
  effect:SetCfgID(1000190000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02", "loadState", 1, "", 0)
        effect:SetCfgID(100019000000)
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
, [100655] = function(args)
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
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_01 (2)", "trapState", 1, "", 0)
  effect:SetCfgID(1000230000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_01 (2)", "loadState", 1, "", 0)
        effect:SetCfgID(100023000000)
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
, [100656] = function(args)
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
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02 (3)", "trapState", 1, "", 0)
  effect:SetCfgID(1000250000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      do
        local effect = (EffectFactory.CreateAnimatorStateChangeEffect)("Statue/t1_m_statue_02 (3)", "loadState", 1, "", 0)
        effect:SetCfgID(100025000000)
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
, [100657] = function(args)
  -- function num : 0_17 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1004, false, false)
    effect:SetCfgID(1000390000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateSpeedChangeEffect)("[actor]", 0.5)
      effect:SetCfgID(1000390000)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateAddEventEffect)(100045)
        effect:SetCfgID(1000390001)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_02", false)
            effect:SetCfgID(1000390002)
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
, [100658] = function(args)
  -- function num : 0_18 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateDialogEffect)(2, "1")
    effect:SetCfgID(1000400000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBGMEffect)("play", 20010002)
        effect:SetCfgID(1000400000)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100659] = function(args)
  -- function num : 0_19 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateAnimationEffect)("firstscene_map_door", "DoorOpen")
    effect:SetCfgID(1000410000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAnimationEffect)("firstscene_map_button", "ButtonPushed")
      effect:SetCfgID(1000410001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateBlockChangeEffect)(25, 39, 1, 1, false)
          effect:SetCfgID(1000410002)
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
, [100660] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000420000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1049, false, false)
        effect:SetCfgID(1000420001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100661] = function(args)
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
    local effect = (EffectFactory.CreateDialogEffect)(1, "")
    effect:SetCfgID(1000430000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1025, false, false)
      effect:SetCfgID(1000430001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateVisualEffect)("Char_Cat", false)
        effect:SetCfgID(1000430002)
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateThawEffect)(true)
            effect:SetCfgID(1000430003)
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
, [100662] = function(args)
  -- function num : 0_22 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1008, false, false)
    effect:SetCfgID(1000450000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateAddEventEffect)(100039)
      effect:SetCfgID(1000450001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_01", false)
          effect:SetCfgID(1000450002)
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
, [100663] = function(args)
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100045)
      effect:SetCfgID(1000460000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100664] = function(args)
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
    effect:SetCfgID(1000540000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1050, false, false)
      effect:SetCfgID(1000540001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000540003)
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
, [100665] = function(args)
  -- function num : 0_25 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_01", true)
    effect:SetCfgID(1000550000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("T1_Area_07_ForBuild_02", true)
        effect:SetCfgID(1000550001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100666] = function(args)
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
      local effect = (EffectFactory.CreateDialogEffect)(2, "2")
      effect:SetCfgID(1000560000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100667] = function(args)
  -- function num : 0_27 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBGMEffect)("play", 56)
    effect:SetCfgID(1000600000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateDialogEffect)(2, "3")
        effect:SetCfgID(1000600001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100668] = function(args)
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
    effect:SetCfgID(1000610000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1017, false, false)
      effect:SetCfgID(1000610001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000610003)
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
, [100669] = function(args)
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
      local effect = (EffectFactory.CreateRemoveEventEffect)(100061)
      effect:SetCfgID(1000620000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100670] = function(args)
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
    effect:SetCfgID(1000630000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1018, false, false)
      effect:SetCfgID(1000630001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000630003)
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
, [100671] = function(args)
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
    effect:SetCfgID(1000640000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBlockChangeEffect)(20, 8, 1, 1, true)
      effect:SetCfgID(1000640000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateMoveToWorldPosEffect)("[actor]", 0.85, 8, 0, -5.42, true)
        effect:SetCfgID(1000640001)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateTurnEffect)(8, "[actor]")
          effect:SetCfgID(1000640002)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1118, false, false)
            effect:SetCfgID(1000640003)
            root:AddEffect(effect)
            local upper = effect
            do
              local effect = (EffectFactory.CreateDestroyEffect)("Story_1/Char_Cat")
              effect:SetCfgID(1000640004)
              effect:SetParam("runoninit")
              root:AddEffect(effect)
              local upper = effect
              do
                do
                  local effect = (EffectFactory.CreateThawEffect)(true)
                  effect:SetCfgID(1000640005)
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
  end
end
, [100672] = function(args)
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
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 97)
      effect:SetCfgID(1000710000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100673] = function(args)
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
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 70)
      effect:SetCfgID(1000750000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100674] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("pause", 2)
      effect:SetCfgID(1000760000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100675] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 59)
      effect:SetCfgID(1000770000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100676] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("pause", 2)
      effect:SetCfgID(1000780000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100677] = function(args)
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 61)
      effect:SetCfgID(1000790000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100678] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000800000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1021, false, false)
      effect:SetCfgID(1000800001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000800003)
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
, [100679] = function(args)
  -- function num : 0_39 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1022, false, false)
    effect:SetCfgID(1000810000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000810003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100680] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000820000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1023, false, false)
      effect:SetCfgID(1000820001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000820003)
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
, [100682] = function(args)
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
    local effect = (EffectFactory.CreateTimelineEffect)(1024, false, false)
    effect:SetCfgID(1000830000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateThawEffect)(true)
        effect:SetCfgID(1000830003)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100683] = function(args)
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
    do
      local effect = (EffectFactory.CreateAnimationEffect)("firstscene_rabbit", "rabbit_escape")
      effect:SetCfgID(1000840000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100684] = function(args)
  -- function num : 0_43 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateAnimationEffect)("firstscene_map_bird", "BirdFly")
    effect:SetCfgID(1000850000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateBGMEffect)("play", 71)
        effect:SetCfgID(1000850001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100685] = function(args)
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
    local effect = (EffectFactory.CreateFreezeEffect)(true)
    effect:SetCfgID(1000870000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 33)
      effect:SetCfgID(1000870001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1026, false, false)
        effect:SetCfgID(1000870002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateAnimationEffect)("Firstsence_gate", "GateOpen")
          effect:SetCfgID(1000870003)
          root:AddEffect(effect)
          local upper = effect
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1027, false, false)
            effect:SetCfgID(1000870004)
            root:AddEffect(effect)
            local upper = effect
            do
              do
                local effect = (EffectFactory.CreateThawEffect)(true)
                effect:SetCfgID(1000870005)
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
end
, [100686] = function(args)
  -- function num : 0_45 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 2)
      effect:SetCfgID(1000890001)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100687] = function(args)
  -- function num : 0_46 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1028, false, false)
      effect:SetCfgID(1000900000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100688] = function(args)
  -- function num : 0_47 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1029, false, false)
      effect:SetCfgID(1000910000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100689] = function(args)
  -- function num : 0_48 , upvalues : _ENV
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
    effect:SetCfgID(1000920000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1031, false, false)
      effect:SetCfgID(1000920001)
      root:AddEffect(effect)
      local upper = effect
      do
        do
          local effect = (EffectFactory.CreateThawEffect)(true)
          effect:SetCfgID(1000920003)
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
, [100690] = function(args)
  -- function num : 0_49 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateJumpEffect)(11000, 1)
      effect:SetCfgID(1000930000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100691] = function(args)
  -- function num : 0_50 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1032, false, false)
      effect:SetCfgID(1000940000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100692] = function(args)
  -- function num : 0_51 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1033, false, false)
      effect:SetCfgID(1000950000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100693] = function(args)
  -- function num : 0_52 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1033, false, false)
      effect:SetCfgID(1000960000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100694] = function(args)
  -- function num : 0_53 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(9, 24, 2, 1, true)
      effect:SetCfgID(1000970000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100695] = function(args)
  -- function num : 0_54 , upvalues : _ENV
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
  local effect = (EffectFactory.CreateTimelineEffect)(1034, false, false)
  effect:SetCfgID(1000980000)
  effect:SetParam("runoninit")
  local upper = effect
  do
    do
      local effect = (EffectFactory.CreateTimelineEffect)(1299, false, false)
      effect:SetCfgID(100098000000)
      upper:SetParam("alternative", effect)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateBlockChangeEffect)(9, 17, 3, 1, false)
        effect:SetCfgID(1000980001)
        effect:SetParam("runoninit")
        root:AddEffect(effect)
        local upper = effect
        do
          do
            local effect = (EffectFactory.CreateTimelineEffect)(1135, false, false)
            effect:SetCfgID(1000980002)
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
, [100696] = function(args)
  -- function num : 0_55 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateAnimationEffect)("EventItem/t1_m_ant_01", "ant_01")
    effect:SetCfgID(1001000001)
    effect:SetParam("runoninit")
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateAnimationEffect)("EventItem/t1_m_ant_03", "ant_03")
        effect:SetCfgID(1001000002)
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
, [100697] = function(args)
  -- function num : 0_56 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(3, 10, 2, 1, true)
      effect:SetCfgID(1001010000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100698] = function(args)
  -- function num : 0_57 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1037, false, false)
      effect:SetCfgID(1001020000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100699] = function(args)
  -- function num : 0_58 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBlockChangeEffect)(8, 25, 8, 1, true)
      effect:SetCfgID(1001040000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100700] = function(args)
  -- function num : 0_59 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateBlockChangeEffect)(9, 17, 3, 1, true)
    effect:SetCfgID(1001050000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateRemoveEventEffect)(100106)
        effect:SetCfgID(1001050001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100701] = function(args)
  -- function num : 0_60 , upvalues : _ENV
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
    local effect = (EffectFactory.CreateTimelineEffect)(1039, false, false)
    effect:SetCfgID(1001070000)
    root:AddEffect(effect)
    local upper = effect
    do
      do
        local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", false)
        effect:SetCfgID(1001070001)
        root:AddEffect(effect)
        if upper then
          upper:AddEffect(root)
        end
        return composed
      end
    end
  end
end
, [100702] = function(args)
  -- function num : 0_61 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateTimelineEffect)(1040, false, false)
      effect:SetCfgID(1001080000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100703] = function(args)
  -- function num : 0_62 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateBGMEffect)("play", 59)
      effect:SetCfgID(1001090000)
      effect:SetParam("runoninit")
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100704] = function(args)
  -- function num : 0_63 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateSpeedChangeEffect)("[actor]", 0.85)
      effect:SetCfgID(1001120000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100705] = function(args)
  -- function num : 0_64 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateSpeedChangeEffect)("[actor]", 0.85)
      effect:SetCfgID(1001130000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100706] = function(args)
  -- function num : 0_65 , upvalues : _ENV
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
      local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", true)
      effect:SetCfgID(1001150000)
      root:AddEffect(effect)
      if upper then
        upper:AddEffect(root)
      end
      return composed
    end
  end
end
, [100707] = function(args)
  -- function num : 0_66 , upvalues : _ENV
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
    effect:SetCfgID(1001160000)
    root:AddEffect(effect)
    local upper = effect
    do
      local effect = (EffectFactory.CreateBGMEffect)("play", 59)
      effect:SetCfgID(1001160001)
      root:AddEffect(effect)
      local upper = effect
      do
        local effect = (EffectFactory.CreateTimelineEffect)(1042, false, false)
        effect:SetCfgID(1001160002)
        root:AddEffect(effect)
        local upper = effect
        do
          local effect = (EffectFactory.CreateVisualEffect)("mon_t1_27m", false)
          effect:SetCfgID(1001160003)
          root:AddEffect(effect)
          local upper = effect
          do
            do
              local effect = (EffectFactory.CreateThawEffect)(true)
              effect:SetCfgID(1001160004)
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

