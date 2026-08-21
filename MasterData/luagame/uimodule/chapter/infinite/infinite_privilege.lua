local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local common_def = require("cs_share.common_define")
local INFINITE_EFFECT_TYPE = common_def.INFINITE_EFFECT_TYPE
local VALUE_TYPE = common_def.VALUE_TYPE
local INFINITE_PRIVILEGE_NODE_CLASS = require("uimodule.chapter.infinite.infinite_privilege_node_view")
local INFINITE_PRIVILEGE_CONTENT_KEY = "INFINITE_PRIVILEGE_CONTENT_KEY"
local MODEL = {
  v_bottom_layout = {
    "Bottom",
    BIND_TYPE.OBJECT
  },
  v_select_privilege_layout = {
    "SelectPrivilegeLayout",
    BIND_TYPE.OBJECT
  },
  v_btn_unlock = {
    "BtnUnlock",
    BIND_TYPE.BUTTON
  },
  v_unlock_layout = {
    "UnlockLayout",
    BIND_TYPE.OBJECT
  },
  v_consume_icon = {
    "ConsumeIcon",
    BIND_TYPE.IMAGE
  },
  v_consume_num = {
    "ConsumeNum",
    BIND_TYPE.TEXT
  },
  v_current_icon = {
    "CurrIcon",
    BIND_TYPE.IMAGE
  },
  v_current_num = {
    "CurrNum",
    BIND_TYPE.TEXT
  },
  v_point_parent = {
    "PointParent",
    BIND_TYPE.OBJECT
  },
  v_privilege_content = {
    "PrivilegeContent",
    BIND_TYPE.OBJECT
  },
  v_privilege_content_tem = {
    "PrivilegeContentTem",
    BIND_TYPE.OBJECT
  },
  v_select_item_icon = {
    "SelectItemIcon",
    BIND_TYPE.IMAGE
  },
  v_ani_vx_bottom_in = {
    "Ani_VX_Bottom_IN",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnUnlock", function()
    self:onclick_unlock_btn()
  end)
  self:set_button("CostItemBtn", function()
    local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = infinite_cfg.PrivilegeCostId
    })
  end)
  self:init_privilege_desc_list()
  self:register_exist_auto_template(INFINITE_PRIVILEGE_CONTENT_KEY, self.v_privilege_content_tem, self.v_privilege_content)
end

function ui:init_privilege_desc_list()
  self.privilege_desc_list = {}
  for i = 1, 2 do
    table.insert(self.privilege_desc_list, Util.get_text(nil, self.v_uiobjects["PrivilegeDesc" .. i]))
  end
end

function ui:ui_on_show(infinite_id)
  self.v_infinite_id = infinite_id
  self.v_bottom_layout:SetActive(false)
  self.v_ani_vx_bottom_in:SetActive(false)
  self:init_info()
end

function ui:ui_on_hide()
  if self.v_privilege_node_lua_obj then
    self:remove_wrap_ui(self.v_privilege_node_lua_obj)
  end
  if self.v_privilege_node_obj then
    ResMgr:destroy_gameobj(self.v_privilege_node_obj)
    self.v_privilege_node_obj = nil
  end
  self.v_privilege_node_cfg = nil
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_infinite_id
end

function ui:init_info()
  self:init_privilege_node_info()
  self:refresh_info()
end

function ui:init_privilege_node_info()
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local privilege_point_path = infinite_cfg.PrivilegePointPath
  local path = Path.get_full_prefab_path(privilege_point_path)
  local privilege_node_obj = ResMgr:load_gameobj(path)
  privilege_node_obj.transform:SetParent(self.v_point_parent.transform, false)
  self.v_privilege_node_obj = privilege_node_obj
  self:wrap_privilege_node_obj()
end

function ui:wrap_privilege_node_obj()
  if not self.v_privilege_node_obj then
    return
  end
  if self.v_infinite_point_lua_obj then
    self:remove_wrap_ui(self.v_infinite_point_lua_obj)
  end
  self.v_privilege_node_lua_obj = INFINITE_PRIVILEGE_NODE_CLASS:ui_wrap_ex(self, self.v_privilege_node_obj, false)
  self.v_privilege_node_lua_obj:set_enable(true, self.v_infinite_id)
end

function ui:refresh_info()
  self:refresh_current_num()
  self:refresh_privilege_content()
end

function ui:refresh_current_num()
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  self.v_current_num.text = BagMgr:get_item_num(infinite_cfg.PrivilegeCostId)
end

function ui:refresh_privilege_content()
  self:give_back_auto_cache(INFINITE_PRIVILEGE_CONTENT_KEY)
  self:refresh_privilege_data()
  self:generate_all_content_item()
  self:generate_scene_skill_item()
end

function ui:refresh_privilege_data()
  local infinite_info = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  local infinite_privilege_cfg = ShareRes.create("chapter.infinite_privilege")
  local all_type_data = {}
  if infinite_info.privilege_ids and next(infinite_info.privilege_ids) then
    for _, id in pairs(infinite_info.privilege_ids) do
      local privilege_node_cfg = infinite_privilege_cfg[id]
      for index, type in ipairs(privilege_node_cfg.EffectType) do
        if 0 ~= type then
          if nil == all_type_data[type] then
            all_type_data[type] = {}
          end
          local single_type_data = all_type_data[type]
          if type == INFINITE_EFFECT_TYPE.HERO_ATTR or type == INFINITE_EFFECT_TYPE.GOD_ATTR then
            local param_list = privilege_node_cfg.EffectParam[index][1]
            local attr_id = param_list[1]
            local value = param_list[2]
            local value_type = param_list[3]
            local data = single_type_data[attr_id]
            if nil == data then
              data = {}
              data.attr_name = privilege_node_cfg.Desc[index]
              data.id = attr_id
              data[value_type] = value
              single_type_data[attr_id] = data
            elseif data[value_type] then
              data[value_type] = data[value_type] + value
            else
              data[value_type] = value
            end
          elseif type == INFINITE_EFFECT_TYPE.HERO_MAGIC or type == INFINITE_EFFECT_TYPE.GOD_MAGIC then
            local param_list = privilege_node_cfg.EffectParam[index]
            local attr_id = param_list[1]
            local data = single_type_data[attr_id]
            if nil == data then
              data = {}
              data.attr_name = privilege_node_cfg.Desc[index]
              data.id = attr_id
              single_type_data[attr_id] = data
            end
          elseif type == INFINITE_EFFECT_TYPE.CURRENCY_ADD then
            local param_list = privilege_node_cfg.EffectParam[index]
            local attr_id = param_list[1]
            local value = param_list[2]
            local data = single_type_data[attr_id]
            if nil == data then
              data = {}
              data.attr_name = privilege_node_cfg.Desc[index]
              data.id = attr_id
              data.value = value
              single_type_data[attr_id] = data
            else
              data.value = data.value + value
            end
          end
        end
      end
    end
  end
  self.v_all_type_data = {}
  for type = INFINITE_EFFECT_TYPE.HERO_ATTR, INFINITE_EFFECT_TYPE.CURRENCY_ADD do
    if all_type_data[type] and next(all_type_data[type]) then
      self.v_all_type_data[type] = {}
      for k, data in pairs(all_type_data[type]) do
        table.insert(self.v_all_type_data[type], data)
      end
      table.sort(self.v_all_type_data[type], function(a, b)
        return a.id < b.id
      end)
    end
  end
end

function ui:generate_all_content_item()
  for type = INFINITE_EFFECT_TYPE.HERO_ATTR, INFINITE_EFFECT_TYPE.CURRENCY_ADD do
    if self.v_all_type_data[type] and next(self.v_all_type_data[type]) then
      if type == INFINITE_EFFECT_TYPE.HERO_ATTR or type == INFINITE_EFFECT_TYPE.GOD_ATTR then
        for _, data in ipairs(self.v_all_type_data[type]) do
          if data[VALUE_TYPE.FIXED] then
            local content_item = self:get_auto_cache(INFINITE_PRIVILEGE_CONTENT_KEY)
            local desc = Util.get_text("PrivilegeDesc", content_item)
            local num = Util.get_text("AdditionNum", content_item)
            num.gameObject:SetActive(true)
            desc.text = data.attr_name
            num.text = "+" .. data[VALUE_TYPE.FIXED]
          end
          if data[VALUE_TYPE.RATIO] then
            local content_item = self:get_auto_cache(INFINITE_PRIVILEGE_CONTENT_KEY)
            local desc = Util.get_text("PrivilegeDesc", content_item)
            local num = Util.get_text("AdditionNum", content_item)
            num.gameObject:SetActive(true)
            desc.text = data.attr_name
            num.text = "+" .. math.modf(data[VALUE_TYPE.RATIO] / 100) .. "%"
          end
        end
      elseif type == INFINITE_EFFECT_TYPE.HERO_MAGIC or type == INFINITE_EFFECT_TYPE.GOD_MAGIC then
        for _, data in ipairs(self.v_all_type_data[type]) do
          local content_item = self:get_auto_cache(INFINITE_PRIVILEGE_CONTENT_KEY)
          local desc = Util.get_text("PrivilegeDesc", content_item)
          local num = Util.get_text("AdditionNum", content_item)
          num.gameObject:SetActive(false)
          desc.text = data.attr_name
        end
      elseif type == INFINITE_EFFECT_TYPE.CURRENCY_ADD then
        for _, data in ipairs(self.v_all_type_data[type]) do
          local content_item = self:get_auto_cache(INFINITE_PRIVILEGE_CONTENT_KEY)
          local desc = Util.get_text("PrivilegeDesc", content_item)
          local num = Util.get_text("AdditionNum", content_item)
          num.gameObject:SetActive(true)
          desc.text = data.attr_name
          num.text = "+" .. math.modf(data.value / 100) .. "%"
        end
      end
    end
  end
end

function ui:generate_scene_skill_item()
  local infinite_info = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  local infinite_privilege_cfg = ShareRes.create("chapter.infinite_privilege")
  local scene_skill_list = {}
  if infinite_info.privilege_ids and next(infinite_info.privilege_ids) then
    for _, id in pairs(infinite_info.privilege_ids) do
      local privilege_node_cfg = infinite_privilege_cfg[id]
      if privilege_node_cfg.EffectType[1] == INFINITE_EFFECT_TYPE.SCENE_SKILL then
        local scene_skill = {}
        scene_skill.skill_level = privilege_node_cfg.EffectParam[1][1]
        scene_skill.skill_desc = privilege_node_cfg.Desc[1]
        table.insert(scene_skill_list, scene_skill)
      end
    end
  end
  if #scene_skill_list > 0 then
    table.sort(scene_skill_list, function(a, b)
      return a.skill_level < b.skill_level
    end)
    for _, scene_skill in ipairs(scene_skill_list) do
      local content_item = self:get_auto_cache(INFINITE_PRIVILEGE_CONTENT_KEY)
      local desc = Util.get_text("PrivilegeDesc", content_item)
      local num = Util.get_text("AdditionNum", content_item)
      num.gameObject:SetActive(false)
      desc.text = scene_skill.skill_desc
    end
  end
end

function ui:show_bottom_layout(privilege_node_cfg)
  self.v_bottom_layout:SetActive(true)
  self.v_privilege_node_cfg = privilege_node_cfg
  self.v_consume_num.text = privilege_node_cfg.CostCnt
  ResMgr:load_set_icon(self.v_select_item_icon, privilege_node_cfg.Icon)
  self:refresh_unlock_btn_state()
  for index, type in ipairs(privilege_node_cfg.EffectType) do
    if 0 ~= type then
      self.privilege_desc_list[index].gameObject:SetActive(true)
      if type == INFINITE_EFFECT_TYPE.HERO_ATTR or type == INFINITE_EFFECT_TYPE.GOD_ATTR then
        local param_list = privilege_node_cfg.EffectParam[index][1]
        local value = param_list[2]
        local value_type = param_list[3]
        if value_type == VALUE_TYPE.FIXED then
          self.privilege_desc_list[index].text = privilege_node_cfg.Desc[index] .. "  +" .. value
        elseif value_type == VALUE_TYPE.RATIO then
          value = math.modf(value / 100)
          self.privilege_desc_list[index].text = privilege_node_cfg.Desc[index] .. "  +" .. value .. "%"
        end
      elseif type == INFINITE_EFFECT_TYPE.HERO_MAGIC or type == INFINITE_EFFECT_TYPE.GOD_MAGIC then
        self.privilege_desc_list[index].text = privilege_node_cfg.Desc[index]
      elseif type == INFINITE_EFFECT_TYPE.CURRENCY_ADD then
        local param_list = privilege_node_cfg.EffectParam[index]
        local value = math.modf(param_list[2] / 100)
        self.privilege_desc_list[index].text = privilege_node_cfg.Desc[index] .. "  +" .. value .. "%"
      elseif type == INFINITE_EFFECT_TYPE.SCENE_SKILL then
        self.privilege_desc_list[index].text = privilege_node_cfg.Desc[1]
      end
    else
      self.privilege_desc_list[index].gameObject:SetActive(false)
    end
  end
  self.v_ani_vx_bottom_in:SetActive(false)
  self.v_ani_vx_bottom_in:SetActive(true)
end

function ui:onclick_unlock_btn()
  local fight_progress = TowerMgr:get_tower_progress()
  if fight_progress then
    local fight_tower_id = fight_progress.tower_id
    local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
    local chapter_point_cfg = ShareRes.create("chapter.chapter_point", infinite_cfg.EpisodeId)
    local tower_cfg = ShareRes.create("tower.tower", chapter_point_cfg.FightId)
    local tower_id = tower_cfg.TowerID
    if fight_tower_id == tower_id then
      Util.show_message_tip(2256)
      return
    end
  end
  Network:call("c2gs_unlock_infinite_privilege", {
    infinite_id = self.v_infinite_id,
    privilege_id = self.v_privilege_node_cfg.Id
  }, function(ok, resp)
    if ok then
      ChapterMgr:update_inf_privilege_unlock_id(self.v_infinite_id, self.v_privilege_node_cfg.Id)
      self:refresh_current_num()
      self:refresh_privilege_content()
      self:refresh_unlock_btn_state()
      self.v_privilege_node_lua_obj:refresh_node_activate_state()
      self.v_privilege_node_lua_obj:play_unlock_eff()
    end
  end)
end

function ui:refresh_unlock_btn_state()
  local is_unlock = false
  local infinite_info = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  if infinite_info.privilege_ids and next(infinite_info.privilege_ids) then
    for _, id in pairs(infinite_info.privilege_ids) do
      if self.v_privilege_node_cfg.Id == id then
        is_unlock = true
        break
      end
    end
  end
  if is_unlock then
    self.v_unlock_layout:SetActive(true)
    self.v_btn_unlock.gameObject:SetActive(false)
  else
    self.v_unlock_layout:SetActive(false)
    self.v_btn_unlock.gameObject:SetActive(true)
    local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
    if BagMgr:get_item_num(infinite_cfg.PrivilegeCostId) < self.v_privilege_node_cfg.CostCnt or ChapterMgr:inf_privilege_pre_node_is_unlock(self.v_infinite_id, self.v_privilege_node_cfg) == false then
      self.v_btn_unlock.interactable = false
    else
      self.v_btn_unlock.interactable = true
    end
  end
end

return ui
