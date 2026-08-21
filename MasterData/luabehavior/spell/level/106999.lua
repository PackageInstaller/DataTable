local M = Util.create_class()
local now_room = 0

function M:_init()
  now_room = get_cur_room_id()
  self.heavy_guide = false
end

function M:on_enter_area(npc, area)
  if get_npc_id(npc) ~= 3001074 then
    return
  end
  if area.Key ~= "switch" and area.Key ~= "switch2" then
    return
  end
  if area.count == nil then
    area.count = 0
  end
  area.count = area.count + 1
  if 1 ~= area.count then
    return
  end
  if 106205 == now_room and self.heavy_guide then
    self.heavy_guide = false
    return
  end
  set_sync_var(area.Key, true)
  print(area.Key, area.count, get_sync_var(area.Key))
  if 106202 == now_room or 106205 == now_room then
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre/TL_PressPlate", 1)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_build_31a_pre/TL_door1", 1)
    set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
  end
  if 106303 == now_room or 106306 == now_room or 106701 == now_room then
    set_scene_effect("/Root/Level/Level_01/plat_group/Plat2_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
    set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat2_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", 1)
    set_scene_plat_speed("plat2", 1, "Sc06_plat2", true)
  end
  if 106703 == now_room then
    set_scene_effect("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
    set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", 1)
    set_scene_plat_speed("plat3", 1, "Sc06_plat3", true)
  end
  if 106702 == now_room or 106705 == now_room or 106302 == now_room then
    set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre (2)/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_build_31a_pre (1)/TL_door1", 1)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre (2)/TL_PressPlate", 1)
  end
  if 106706 == now_room then
    set_scene_effect("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
    set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate/tl_PressPlate", 1)
    set_scene_plat_speed("plat3", 1, "Sc06_plat3", true)
  end
  if 106203 == now_room and 1 == area.count then
    if get_sync_var("switch") == true then
      set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre (1)/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
      set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre (1)/TL_PressPlate", 1)
    end
    if get_sync_var("switch2") == true then
      set_scene_effect("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
      set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", 1)
    end
    if get_sync_var("switch") == true and get_sync_var("switch2") == true then
      set_scene_plat_speed("plat1", 1, "Sc06_plat1", true)
    end
  end
  if 106304 == now_room and 1 == area.count then
    if area.Key == "switch" and get_sync_var("switch") == true then
      set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre (1)/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
      set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre (1)/TL_PressPlate", 1)
      set_scene_timeline_speed("/Root/Level/Level_01/sc06_build_31a_pre (2)/TL_door1", 1)
    end
    if area.Key == "switch2" and get_sync_var("switch2") == true then
      set_scene_effect("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
      set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", 1)
      set_scene_plat_speed("plat1", 1, "Sc06_plat1", true)
    end
  end
end

function M:on_leave_area(npc, area)
  if get_npc_id(npc) ~= 3001074 then
    return
  end
  if area.Key ~= "switch" and area.Key ~= "switch2" then
    return
  end
  if area.count == nil then
    area.count = 0
  end
  area.count = area.count - 1
  if 0 == area.count then
    set_sync_var(area.Key, false)
    print(area.Key, area.count, get_sync_var(area.Key))
  else
    return
  end
  if 106202 == now_room or 106205 == now_room then
    set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre/TL_PressPlate", -1)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_build_31a_pre/TL_door1", -1)
  end
  if 106203 == now_room then
    if get_sync_var("switch") == false then
      set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre (1)/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
      set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre (1)/TL_PressPlate", -1)
    end
    if get_sync_var("switch2") == false then
      set_scene_effect("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
      set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", -1)
    end
    if get_sync_var("switch") == false or get_sync_var("switch2") == false then
      if get_sync_var("switch") == false and get_sync_var("switch2") == false then
        return
      end
      set_scene_plat_speed("plat1", -1, "Sc06_plat1", true)
    end
  end
  if 106304 == now_room then
    if area.Key == "switch" and get_sync_var("switch") == false then
      set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre (1)/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
      set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre (1)/TL_PressPlate", -1)
      set_scene_timeline_speed("/Root/Level/Level_01/sc06_build_31a_pre (2)/TL_door1", -1)
    end
    if area.Key == "switch2" and get_sync_var("switch2") == false then
      set_scene_effect("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
      set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat1_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", -1)
      set_scene_plat_speed("plat1", -1, "Sc06_plat1", true)
    end
  end
  if 106303 == now_room or 106306 == now_room or 106701 == now_room then
    set_scene_effect("/Root/Level/Level_01/plat_group/Plat2_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
    set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat2_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", -1)
    set_scene_plat_speed("plat2", -1, "Sc06_plat2", true)
  end
  if 106703 == now_room then
    set_scene_effect("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
    set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate", -1)
    set_scene_plat_speed("plat3", -1, "Sc06_plat3", true)
  end
  if 106702 == now_room or 106705 == now_room or 106302 == now_room then
    set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre (2)/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_build_31a_pre (1)/TL_door1", -1)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre (2)/TL_PressPlate", -1)
  end
  if 106706 == now_room then
    set_scene_effect("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", false, true)
    set_scene_timeline_speed("/Root/Level/Level_01/plat_group/Plat3_/sc06_prop_50b_pre/sc06_prop_51_pre/TL_PressPlate/tl_PressPlate", -1)
    set_scene_plat_speed("plat3", -1, "Sc06_plat3", true)
  end
end

function M:on_frame()
  if 106205 ~= now_room then
    return
  end
  if get_sync_var("heavy_on") then
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_prop_51_pre/TL_PressPlate", 1)
    set_scene_timeline_speed("/Root/Level/Level_01/sc06_build_31a_pre/TL_door1", 1)
    set_scene_effect("/Root/Level/Level_01/sc06_prop_51_pre/sc06_prop_51_m1/FX_Sc0601_PressurePlate", true, true)
    set_sync_var("heavy_on", false)
    self.heavy_guide = true
  end
end

return M
