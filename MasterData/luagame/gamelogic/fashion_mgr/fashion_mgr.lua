local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local _sort = table.sort
local all_fashionable_info = ShareRes.create("buddy.buddy_fashion")
local character_info = ShareRes.create("character.character")

function M:init_sys()
  Base.init_sys(self)
  self:init_main_scene_fashion_sys()
  self.v_fashion_buddy_data = nil
  self.v_request_table = {buddy_id = nil, id = nil}
  self.v_request_change_equip_fashion_table = {id = nil, is_wear = nil}
end

function M:on_destroy()
  self.v_equip_fashions_map = nil
  self.v_equip_fashions_data = nil
end

function M:is_have_not_read_fashion(fashions_data)
  for _, data in pairs(fashions_data) do
    if not data.is_read then
      RedPointMgr:enable_redpoint(RedEnum.ARCHIVES_FASHION, true)
      return true
    end
  end
  return false
end

function M:enable_fashion_red_point()
  for _, fashion_data in pairs(self.v_fashion_buddy_data) do
    local fashions = fashion_data.fashions
    if self:is_have_not_read_fashion(fashions) then
      return
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.ARCHIVES_FASHION, false)
end

function M:on_ret_fashion_data(fashion_data)
  self.v_fashion_buddy_data = fashion_data.buddy_fashions
  local buddy_fashions = fashion_data.buddy_fashions
  for _, data in pairs(buddy_fashions) do
    local fashions = data.fashions
    self:is_have_not_read_fashion(fashions)
  end
end

function M:on_ret_refresh_fashion_data(buddy_fashion_data)
  local buddy_id = buddy_fashion_data.id
  self.v_fashion_buddy_data[buddy_id] = buddy_fashion_data
  local fashions = buddy_fashion_data.fashions
  self:is_have_not_read_fashion(fashions)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_HERO_UPDATE_FASHION)
  msg.mm_obj = buddy_id
end

function M:get_fashion_model_id(buddy_id)
  local buddy_info = self.v_fashion_buddy_data[buddy_id]
  if buddy_info and buddy_info.wearing_id then
    return self:get_fashion_model_id_by_fashion_id(buddy_info.wearing_id)
  end
  return self:get_init_fashion_model_id(buddy_id)
end

function M:get_init_fashion_model_id(buddy_id)
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  if buddy_cfg then
    local wearing_fashion_id = buddy_cfg.FashionInitId
    return self:get_fashion_model_id_by_fashion_id(wearing_fashion_id)
  end
end

function M:get_fashion_model_id_by_fashion_id(wearing_fashion_id)
  if wearing_fashion_id and all_fashionable_info[wearing_fashion_id] then
    return all_fashionable_info[wearing_fashion_id].ModelId
  end
end

function M:get_fashion_wearing_id(buddy_id)
  local buddy_info = self.v_fashion_buddy_data[buddy_id]
  if not buddy_info then
    return nil
  end
  return buddy_info.wearing_id
end

function M:check_wearing_fashion(fashion_id)
  local buddy_id = all_fashionable_info[fashion_id].BuddyId
  return self:get_fashion_wearing_id(buddy_id) == fashion_id
end

function M:check_has_bought_fashion(fashion_id)
  local buddy_id = all_fashionable_info[fashion_id].BuddyId
  local buddy_fashion_info = self.v_fashion_buddy_data[buddy_id]
  if not buddy_fashion_info then
    return false
  end
  if not buddy_fashion_info.fashions[fashion_id] then
    return false
  end
  return true
end

function M:check_fashion_red_point(fashion_id)
  local buddy_id = all_fashionable_info[fashion_id].BuddyId
  local buddy_fashion_info = self.v_fashion_buddy_data and self.v_fashion_buddy_data[buddy_id]
  if not buddy_fashion_info then
    return false
  end
  local fashion_info = buddy_fashion_info.fashions[fashion_id]
  if not fashion_info then
    return false
  end
  return fashion_info.is_read ~= true
end

function M:read_all_fashion_red_point()
  local buddy_fashion_info = self.v_fashion_buddy_data
  if not self.v_fashion_buddy_data then
    return false
  end
  local data_list = {}
  for _, data in pairs(buddy_fashion_info) do
    local fashions = data.fashions
    for _, fashion_info in pairs(fashions) do
      if fashion_info.is_read ~= true then
        _tinsert(data_list, {
          buddy_id = data.id,
          id = fashion_info.id
        })
      end
    end
  end
  if next(data_list) then
    self:batch_read_red_point_request(data_list)
  end
end

function M:change_fashion_request(buddy_id, id, callback)
  self.v_request_table.buddy_id = buddy_id
  self.v_request_table.id = id
  Network:call("c2gs_change_buddy_fashion", self.v_request_table, function(msg)
    if callback then
      callback(msg)
    end
  end)
end

function M:protect_change_fashion_request(fashion_id, callback)
  local fashion_cfg = ShareRes.get_fashion_cfg(fashion_id)
  local buddy_id = fashion_cfg.BuddyId
  Network:protect_call("c2gs_change_buddy_fashion", {buddy_id = buddy_id, id = fashion_id}, function(msg)
    if callback then
      callback(msg)
    end
  end)
end

function M:read_red_point_request(buddy_id, id, callback)
  self.v_request_table.buddy_id = buddy_id
  self.v_request_table.id = id
  Network:call("c2gs_read_buddy_fashion", self.v_request_table, function(msg)
    if callback then
      callback(msg)
    end
  end)
end

function M:batch_read_red_point_request(data_list, callback)
  Network:call("c2gs_batch_read_buddy_fashion", {buddy_fashions = data_list}, function(msg)
    if callback then
      callback(msg)
    end
  end)
end

function M:on_equip_fashion_list(data)
  local weapon_fashion_cfg = ShareRes.create("equip.equip_fashion")
  self.v_equip_fashions_data = data.equip_fashions
  self.v_equip_fashions_map = {}
  for _, equip_fashion in pairs(data.equip_fashions) do
    local fashion_cfg = weapon_fashion_cfg[equip_fashion.id]
    if fashion_cfg.IsHide then
    else
      local sub_type = fashion_cfg.EquipSubType
      if not self.v_equip_fashions_map[sub_type] then
        self.v_equip_fashions_map[sub_type] = {}
      end
      table.insert(self.v_equip_fashions_map[sub_type], equip_fashion)
    end
  end
end

function M:on_equip_fashion_update(data)
  local weapon_fashion_cfg = ShareRes.get_weapon_fashion_cfg(data.equip_fashion.id)
  if weapon_fashion_cfg.IsHide then
    Log.Error("更新了武器时装，但武器时装表配置了IsHide屏蔽，请检查获取途径配置")
    return
  end
  local weapon_sub_type = weapon_fashion_cfg.EquipSubType
  if not self.v_equip_fashions_map[weapon_sub_type] then
    self.v_equip_fashions_map[weapon_sub_type] = {}
  end
  local has_fashion = false
  for index, equip_fashion in ipairs(self.v_equip_fashions_map[weapon_sub_type]) do
    if data.equip_fashion.id == equip_fashion.id then
      self.v_equip_fashions_map[weapon_sub_type][index] = data.equip_fashion
      has_fashion = true
      break
    end
  end
  if not has_fashion then
    table.insert(self.v_equip_fashions_map[weapon_sub_type], data.equip_fashion)
  end
  self.v_equip_fashions_data[data.equip_fashion.id] = data.equip_fashion
  MsgGame:mq_publish2(Const.MSG_ON_WEAPEN_FASHION_CHANGE)
end

function M:change_equip_fashion(fashion_id, is_wear, callback)
  self.v_request_change_equip_fashion_table.id = fashion_id
  self.v_request_change_equip_fashion_table.is_wear = is_wear
  Network:call("c2gs_change_equip_fashion", self.v_request_change_equip_fashion_table, function(ok, resp)
    if true == ok and 0 == resp.errcode and callback then
      callback()
    end
  end)
end

function M:protect_change_equip_fashion(fashion_id, callback)
  local weapon_fashion_cfg = ShareRes.get_weapon_fashion_cfg(fashion_id)
  local wearing_fashion_id = FashionMgr:get_wearing_weapon_fashion_id(weapon_fashion_cfg.EquipSubType)
  local is_wear = wearing_fashion_id ~= fashion_id
  Network:protect_call("c2gs_change_equip_fashion", {id = fashion_id, is_wear = is_wear}, function(ok, resp)
    if true == ok and 0 == resp.errcode and callback then
      callback()
    end
  end)
end

function M:get_wearing_weapon_fashion_id(sub_type)
  local fashion_list = self.v_equip_fashions_map[sub_type]
  if fashion_list then
    for _, data in ipairs(fashion_list) do
      if data.is_wear then
        return data.id
      end
    end
  end
  return nil
end

function M:has_weapon_fashion(fashion_id)
  return self.v_equip_fashions_data[fashion_id] ~= nil
end

function M:check_wearing_weapon_fashion(fashion_id)
  local fashion_data = self.v_equip_fashions_data[fashion_id]
  return nil ~= fashion_data and fashion_data.is_wear == true
end

function M:check_wearing_default_weapon_fashion(sub_type)
  local wearing_fashion_id = self:get_wearing_weapon_fashion_id(sub_type)
  return nil == wearing_fashion_id
end

function M:check_during_special_jump(fashion_cfg)
  if not (fashion_cfg and fashion_cfg.SpecialJumpId and fashion_cfg.SpecialJumpStartTime) or not fashion_cfg.SpecialJumpEndTime then
    return false
  end
  local server_time = Date.server_time()
  local start_time = Date.get_time_stamp_by_scheme_id(fashion_cfg.SpecialJumpStartTime)
  local end_time = Date.get_time_stamp_by_scheme_id(fashion_cfg.SpecialJumpEndTime)
  local is_during = server_time > start_time and server_time < end_time
  return is_during
end

function M:init_main_scene_fashion_sys()
  self.v_use_main_scene_fashion = nil
  self.v_all_main_scene_fashion = nil
  self.v_scene_illumination_index = nil
  self.v_clicked_red_fashion_list = {}
end

function M:on_main_scene_fashion_list_init(data)
  self:init_all_fashion()
  if data.clicked_red_fashion_list then
    for _, id in pairs(data.clicked_red_fashion_list) do
      self.v_clicked_red_fashion_list[id] = 1
    end
  end
  if data.fashion_list then
    for _, id in pairs(data.fashion_list) do
      self.v_all_main_scene_fashion[id].state = Config.CommonDefine.MAIN_SCENE_FASHION_STATE.OWN
    end
  end
  if data.wear_fashion and 0 ~= data.wear_fashion then
    self.v_use_main_scene_fashion = self.v_all_main_scene_fashion[data.wear_fashion]
  end
  self:refresh_main_scene_red()
end

function M:init_all_fashion()
  if not self.v_all_main_scene_fashion then
    self.v_all_main_scene_fashion = {}
    local all_cfg = ShareRes.create("main_scene.main_scene_fashion")
    for id, cfg in pairs(all_cfg) do
      self.v_all_main_scene_fashion[id] = {}
      self.v_all_main_scene_fashion[id].id = id
      self.v_all_main_scene_fashion[id].name = cfg.AtmosphereName
      self.v_all_main_scene_fashion[id].pd_name = cfg.DrawcardPDName
      self.v_all_main_scene_fashion[id].anim_name = cfg.ClockAnimName
      self.v_all_main_scene_fashion[id].state = Config.CommonDefine.MAIN_SCENE_FASHION_STATE.None
    end
  end
end

function M:check_is_own_fashion(scene_fashion_id)
  if 0 == scene_fashion_id then
    return true
  end
  return self.v_all_main_scene_fashion and self.v_all_main_scene_fashion[scene_fashion_id] and self.v_all_main_scene_fashion[scene_fashion_id].state == Config.CommonDefine.MAIN_SCENE_FASHION_STATE.OWN
end

function M:get_is_new_fashion(scene_fashion_id)
  if 0 == scene_fashion_id then
    return false
  end
  local info = self.v_all_main_scene_fashion[scene_fashion_id]
  if not info then
    return false
  end
  if info.state == Config.CommonDefine.MAIN_SCENE_FASHION_STATE.OWN and not self.v_clicked_red_fashion_list[scene_fashion_id] then
    return true
  end
  return false
end

function M:get_main_scene_fashion_info(scene_fashion_id)
  return self.v_all_main_scene_fashion and self.v_all_main_scene_fashion[scene_fashion_id]
end

function M:get_using_main_scene_fashion_id()
  return self.v_use_main_scene_fashion and self.v_use_main_scene_fashion.id or 0
end

function M:refresh_main_scene_fashion_index(change_names)
  if not self.v_all_main_scene_fashion then
    return
  end
  for name, index in pairs(change_names) do
    for _, data in pairs(self.v_all_main_scene_fashion) do
      if data.name == name then
        data.index = index
      end
    end
  end
end

function M:get_use_main_scene_fashion_index()
  if self.v_use_main_scene_fashion then
    return self.v_use_main_scene_fashion.index
  end
  return 0
end

function M:refresh_main_scene_fashion(id, is_use)
  if not self.v_all_main_scene_fashion then
    return
  end
  if 0 == id then
    self:set_main_scene_ill_index(0)
    if is_use then
      self.v_use_main_scene_fashion = nil
    end
  else
    local info = self.v_all_main_scene_fashion[id]
    info = info or self.v_use_main_scene_fashion
    if not info then
      return
    end
    self:set_main_scene_ill_index(info.index)
    if is_use then
      self.v_use_main_scene_fashion = info
    end
  end
end

function M:reset_main_scene_fashion()
  local index = self:get_use_main_scene_fashion_index()
  self:set_main_scene_ill_index(index)
end

function M:set_main_scene_ill_index(index)
  if not index then
    index = 0
    return
  end
  local scene_effect_obj = UnityFind("SceneEffect")
  if not scene_effect_obj then
    return
  end
  local scene_illumination = scene_effect_obj:GetComponent(typeof(CS.SceneIllumination))
  scene_illumination.curLightDataIndex = index
  scene_illumination:ApplySceneEffect()
  Global.scene_mgr:_init_diff_light(index)
  self.v_scene_illumination_index = index
end

function M:change_main_scene_fashion(scene_fashion_id, cb)
  if not self.v_use_main_scene_fashion and 0 == scene_fashion_id or self.v_use_main_scene_fashion and self.v_use_main_scene_fashion.id == scene_fashion_id then
    return
  end
  Network:call("c2gs_main_scene_wear_fashion", {fashion_id = scene_fashion_id}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self.v_use_main_scene_fashion = self.v_all_main_scene_fashion[scene_fashion_id]
      if cb then
        cb()
      end
    end
  end)
end

function M:on_new_main_scene_fashion_click(scene_fashion_id)
  Network:call("c2gs_main_scene_fashion_click_red", {fashion_id = scene_fashion_id}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self.v_clicked_red_fashion_list[scene_fashion_id] = 1
      self:refresh_main_scene_red()
    end
  end)
end

function M:refresh_main_scene_red()
  local is_need_red = false
  if self.v_all_main_scene_fashion then
    for id, info in pairs(self.v_all_main_scene_fashion) do
      if info.state == Config.CommonDefine.MAIN_SCENE_FASHION_STATE.OWN and not self.v_clicked_red_fashion_list[id] then
        is_need_red = true
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.SCENE_FASHION, is_need_red)
end

function M:get_scene_illumination_index()
  return self.v_scene_illumination_index or 0
end

function M:set_scene_illumination_index(index)
  self.v_scene_illumination_index = index
end

function M:get_curr_fashion_draw_card_pd_name()
  if self.v_use_main_scene_fashion then
    return self.v_use_main_scene_fashion.pd_name
  end
  return "Drawcard_PD"
end

function M:get_curr_fashion_clock_anim_name()
  if self.v_use_main_scene_fashion then
    return self.v_use_main_scene_fashion.anim_name
  end
  return "FocusOnClock_clock"
end

function M:show_fashion_draw_card_pd(pd_name, camera_control)
  local tarns = camera_control.transform
  for i = 0, tarns.childCount - 1 do
    local child_trans = tarns:GetChild(i)
    local name = child_trans.name
    if name == pd_name then
      child_trans.gameObject:SetActive(true)
    elseif "CM_vcam" ~= name then
      child_trans.gameObject:SetActive(false)
    end
    local shuttle = Util.get_child_gameobj("Shuttle", child_trans.gameObject)
    if shuttle then
      shuttle:SetActive(false)
    end
  end
end

return M
