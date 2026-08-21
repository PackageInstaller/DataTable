local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local FightDefine = Config.FightDefine
local STATE_NPC_KEY = "JOURNAL_STATE_NPC_LIST"
local STATE_STATE_KEY = "JOURNAL_STATE_STATE_LIST"
local STATE_ATTR_KEY = "JOURNAL_STATE_ATTR_LIST"
local STATE_BUFF_KEY = "JOURNAL_STATE_BUFF_LIST"
local MODEL = {
  v_npc_content_obj = {
    "Npc_Content",
    BIND_TYPE.OBJECT
  },
  v_npc_item_obj = {
    "Npc_Item",
    BIND_TYPE.OBJECT
  },
  v_state_content_obj = {
    "State_Content",
    BIND_TYPE.OBJECT
  },
  v_state_item_obj = {
    "State_Item",
    BIND_TYPE.OBJECT
  },
  v_attr_content_obj = {
    "Attr_Content",
    BIND_TYPE.OBJECT
  },
  v_attr_item_obj = {
    "Attr_Item",
    BIND_TYPE.OBJECT
  },
  v_buff_content_obj = {
    "Buff_Content",
    BIND_TYPE.OBJECT
  },
  v_buff_item_obj = {
    "Buff_Item",
    BIND_TYPE.OBJECT
  },
  v_drag_panel = {
    "DragPanel",
    BIND_TYPE.OBJECT
  }
}
local _tinsert = table.insert

function ui:on_obj_leave(msg)
  if msg and msg.mm_obj and self.v_npc_obj_list and self.v_npc_obj_list[msg.mm_obj] then
    self:give_back_auto_cache_obj(nil, self.v_npc_obj_list[msg.mm_obj])
    self.v_npc_attr_refresh_list[msg.mm_obj] = nil
    self.v_npc_attr_param_list[msg.mm_obj] = nil
  end
end

function ui:do_search()
  local input = self:get_inputfield(nil, self.v_uiobjects.SearchInput)
  local input_str = input.component.text
  if Util.is_empty(input_str) then
    self.v_search_result_list = nil
    if self.v_select_npc then
      self.v_npc_attr_refresh_list[self.v_select_npc] = true
    end
    return
  end
  self.v_search_result_list = {}
  local convert_str = tonumber(input_str)
  if convert_str then
    local attr_cfg = ShareRes.get_attr_cfg(convert_str)
    if attr_cfg then
      self.v_search_result_list[convert_str] = true
    end
  else
    local all_cfg = ShareRes.create("equip.attr_type")
    for attr_id, cfg in pairs(all_cfg) do
      if string.find(cfg.Name, input_str) then
        self.v_search_result_list[attr_id] = true
      end
    end
  end
  if self.v_select_npc then
    self.v_npc_attr_refresh_list[self.v_select_npc] = true
  end
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("ChangeBtn", function()
    UIMgr:get_ui("uichangeattr"):ui_show(self.v_select_npc)
  end)
  self:set_button("SearchBtn", function()
    self:do_search()
  end)
  self:register_exist_auto_template(STATE_NPC_KEY, self.v_npc_item_obj, self.v_npc_content_obj)
  self:register_exist_auto_template(STATE_STATE_KEY, self.v_state_item_obj, self.v_state_content_obj)
  self:register_exist_auto_template(STATE_ATTR_KEY, self.v_attr_item_obj, self.v_attr_content_obj)
  self:register_exist_auto_template(STATE_BUFF_KEY, self.v_buff_item_obj, self.v_buff_content_obj)
end

function ui:ui_on_show()
  self.v_state_obj_list = {}
  self.v_attr_obj_list = {}
  self.v_buff_obj_list = {}
  self.v_npc_obj_list = {}
  self.v_npc_attr_param_list = {}
  self.v_npc_attr_refresh_list = {}
  self:refresh_npc_list()
  self:bind_auto_mq(Const.MSG_OBJ_LEAVE, self.on_obj_leave, self)
  self.v_drag_panel_pos = self.v_drag_panel.transform.localPosition
  Util.set_drag(self:get_object(), self, function(x, y)
    self.v_drag_panel_pos.x = self.v_drag_panel_pos.x + x
    self.v_drag_panel_pos.y = self.v_drag_panel_pos.y + y
    self.v_drag_panel.transform:SetLocalPositionA(self.v_drag_panel_pos.x, self.v_drag_panel_pos.y, self.v_drag_panel_pos.z)
  end)
end

function ui:ui_on_hide()
  self.v_select_npc = nil
  self.v_state_obj_list = nil
  self.v_attr_obj_list = nil
  self.v_npc_obj_list = nil
  self.v_npc_attr_param_list = nil
  self.v_npc_attr_refresh_list = nil
  self:give_back_auto_cache(STATE_STATE_KEY)
  self:give_back_auto_cache(STATE_BUFF_KEY)
  self:give_back_auto_cache(STATE_NPC_KEY)
  self:give_back_auto_cache(STATE_ATTR_KEY)
end

function ui:ui_on_update()
  self:refresh_npc_list()
  if self.v_select_npc and not self.v_select_npc:is_destroy() then
    self:refresh_state_list(self.v_select_npc)
    self:refresh_attr_list(self.v_select_npc)
    self:refresh_buff_list(self.v_select_npc)
  else
    self.v_select_npc = nil
  end
end

function ui:refresh_npc_list()
  local npc_list = SceneMgr:get_all_char()
  self:check_ui_obj(self.v_npc_obj_list, npc_list)
  for _, npc in pairs(npc_list) do
    if npc:is_functional_npc() or npc:is_scene_obj() then
    else
      local tag_item = self.v_npc_obj_list[npc.uuid]
      if not tag_item then
        tag_item = self:get_auto_cache(STATE_NPC_KEY)
        self.v_npc_obj_list[npc.uuid] = tag_item
      end
      Util.get_text("Text", tag_item).text = npc:get_name()
      self:set_button_listener(self:get_button(nil, tag_item), function()
        if not npc:is_destroy() then
          if self.v_select_npc then
            self.v_npc_attr_refresh_list[self.v_select_npc] = nil
            self.v_npc_attr_param_list[self.v_select_npc] = nil
          end
          self.v_npc_attr_refresh_list[npc] = true
          self.v_select_npc = npc
          self:refresh_state_list(npc)
          self:refresh_attr_list(npc)
          self:refresh_buff_list(npc)
        end
      end)
    end
  end
end

function ui:refresh_state_list(npc)
  local state_params_list = self:get_state_params(npc)
  self:check_ui_obj(self.v_state_obj_list, state_params_list)
  for index, params in ipairs(state_params_list) do
    local tag_item = self.v_state_obj_list[index]
    if nil == tag_item then
      tag_item = self:get_auto_cache(STATE_STATE_KEY)
      self.v_state_obj_list[index] = tag_item
    end
    self:refresh_state_item(tag_item, params)
  end
  self:refresh_state_item(self.v_uiobjects.ScriptItem, {
    key = "脚本ID",
    value = npc:get_born_magics()
  })
end

function ui:refresh_state_item(tag_item, params)
  Util.get_text("Key", tag_item).text = params.key
  Util.get_text("Value", tag_item).text = tostring(params.value)
end

function ui:refresh_attr_list(npc)
  local attr_params_list = self:get_attr_list(npc)
  self:check_ui_obj(self.v_attr_obj_list, attr_params_list)
  for index, params in ipairs(attr_params_list) do
    local tag_item = self.v_attr_obj_list[index]
    if nil == tag_item then
      tag_item = self:get_auto_cache(STATE_ATTR_KEY)
      self.v_attr_obj_list[index] = tag_item
    end
    Util.get_text("Key", tag_item).text = params.key
    local value = self:get_attr_value(npc, params.attr_id)
    Util.get_text("Value", tag_item).text = value
  end
end

function ui:refresh_buff_list(npc)
  local buff_params_list = self:get_buff_list(npc)
  self:check_ui_obj(self.v_buff_obj_list, buff_params_list)
  for index, params in ipairs(buff_params_list) do
    local tag_item = self.v_buff_obj_list[index]
    if not tag_item then
      tag_item = self:get_auto_cache(STATE_BUFF_KEY)
      self.v_buff_obj_list[index] = tag_item
    end
    Util.get_text("ID", tag_item).text = params.id
    Util.get_text("Time", tag_item).text = params.time
    Util.get_text("Count", tag_item).text = params.count
    Util.get_text("Lv", tag_item).text = params.magic_lv_info
  end
end

function ui:get_state_params(npc)
  local skill_mgr = npc.skill_mgr
  local skill_id
  if skill_mgr.v_cur_skill then
    skill_id = skill_mgr.v_cur_skill.skill_id
  end
  local state_manager = npc.state_manager
  local beattack_type = ""
  if state_manager:is_behitfly_state() or state_manager:is_beattack_state() then
    beattack_type = state_manager.beattack_type
  end
  local character_cfg = npc.character_cfg
  local params = {
    {
      key = "Npc状态",
      value = npc:get_status()
    },
    {
      key = "受击状态",
      value = beattack_type
    },
    {
      key = "当前霸体攻击等级",
      value = skill_mgr:get_armor_atk_lv(skill_id)
    },
    {
      key = "当前霸体受击等级",
      value = skill_mgr:get_armor_def_lv()
    },
    {
      key = "UUID",
      value = npc:get_uuid()
    },
    {
      key = "NpcID",
      value = npc:get_npc_id()
    },
    {
      key = "属性Id",
      value = character_cfg.AttribId
    },
    {
      key = "成长属性Id",
      value = character_cfg.PromotedId
    },
    {
      key = "等级",
      value = npc:get_level()
    },
    {
      key = "Npc类型",
      value = character_cfg.Kind
    },
    {
      key = "Npc阵营",
      value = npc:get_camp()
    },
    {
      key = "时间缩放",
      value = npc.time_mgr:get_time_scale()
    }
  }
  if npc:is_npc() then
    local behitfly = npc.state_manager:get_behitfly_state()
    local cur_action = npc.act_ctrl:get_cur_action()
    local info = npc.v_behavior.dead_remove_timeout_output and npc.v_behavior:dead_remove_timeout_output()
    table.insert(params, {
      key = "是否调用set_npc_dead",
      value = npc.v_is_set_dead
    })
    table.insert(params, {
      key = "是否击飞后死亡",
      value = npc.v_is_after_behitfly_die
    })
    table.insert(params, {
      key = "是否有未启用的死亡回调",
      value = behitfly:check_have_die_callback()
    })
    table.insert(params, {
      key = "是否处于击飞状态机",
      value = behitfly.in_state
    })
    table.insert(params, {
      key = "实际动画",
      value = cur_action
    })
    table.insert(params, {
      key = "策划脚本打印信息：",
      value = info
    })
  end
  return params
end

function ui:try_add_show_attr_list(params, attr_id, name)
  if self.v_search_result_list == nil or self.v_search_result_list[attr_id] then
    params[#params + 1] = {key = name, attr_id = attr_id}
  end
end

local function get_attr_value_func(npc, attr_id)
  if npc:is_npc() then
    local element_id = FightDefine.AB_ATTR_TO_ELEMENT[attr_id]
    if element_id then
      return npc.element_abnormal_mgr:get_display_abnormal_value(element_id)
    end
    local tough_info = npc:get_toughness_info()
    if tough_info then
      if attr_id == FightDefine.ATTR_TYPE.TOUGHNESS then
        return tough_info.cur_tough_value
      elseif attr_id == FightDefine.ATTR_TYPE.TOUGHNESS_UPPER_LIMIT then
        return tough_info.max_tough_value
      end
    end
  end
  if attr_id == FightDefine.ATTR_TYPE.CHAR_HP_SHIELD then
    return npc:get_shield_num()
  end
end

function ui:get_attr_value(npc, attr_id)
  return get_attr_value_func(npc, attr_id) or npc:get_attr_value(attr_id)
end

function ui:get_attr_list(npc)
  if self.v_npc_attr_param_list[npc] and not self.v_npc_attr_refresh_list[npc] then
    return self.v_npc_attr_param_list[npc]
  end
  local params = {}
  for key, _ in pairs(npc.attr_mgr.attrs) do
    local name = ShareRes.equip_attr_str(key)
    self:try_add_show_attr_list(params, key, name)
  end
  self.v_npc_attr_param_list[npc] = params
  self.v_npc_attr_refresh_list[npc] = nil
  return params
end

function ui:get_buff_list(npc)
  local params = {}
  local temp1, temp2
  for magic_id, magic_map in pairs(npc.magic_mgr.v_magic_id_map) do
    local first_magic = npc.magic_mgr:get_magic_by_id(magic_id)
    for key, magic in pairs(magic_map) do
      if first_magic == magic then
        local left_time = magic.left_duration
        local duration = magic.duration
        if left_time >= 0 or -1 == left_time then
          local time_str = string.format("%.2f/%s", left_time, duration)
          local count = UtilTable.hash_lenth(magic_map)
          temp1 = {
            id = magic_id,
            time = time_str,
            count = count
          }
          _tinsert(params, temp1)
        end
      end
      temp2 = temp2 or {}
      _tinsert(temp2, magic.magic_level)
    end
    if temp1 and temp2 and next(temp2) then
      temp1.magic_lv_info = table.concat(temp2, "|")
      temp2 = nil
    end
  end
  return params
end

function ui:check_ui_obj(obj_list, params_list)
  local buff_obj_count = #obj_list
  local buff_param_count = UtilTable.hash_lenth(params_list)
  if buff_obj_count > buff_param_count then
    for index = buff_obj_count, buff_param_count + 1, -1 do
      self:give_back_auto_cache_obj(nil, obj_list[index])
      obj_list[index] = nil
    end
  end
end

return ui
