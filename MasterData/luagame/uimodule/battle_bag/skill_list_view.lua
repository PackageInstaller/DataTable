local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local SKILL_BAG_CHAR_CLASS = require("uimodule.battle_bag.skill_bag_hero_item")
local COMBO_TEM_CLASS = require("uimodule.battle_bag.combo_item")
local COMBO_TEM = "SKILL_CONTENT2_COMBO_TEM"
local SKILL_TEM = "COMBO_ITEM_SKILL_TEM"
local hero_item_go_list = {}

function ui:ui_finish_load()
  table.insert(hero_item_go_list, self.v_uiobjects.CharTem)
  table.insert(hero_item_go_list, self.v_uiobjects.CharTem1)
  table.insert(hero_item_go_list, self.v_uiobjects.CharTem2)
  for _, go in ipairs(hero_item_go_list) do
    go:SetActive(false)
  end
  self:register_exist_auto_template(COMBO_TEM, self.v_uiobjects.ComboTem, self.v_uiobjects.ComboContent)
  local skill_tem = Util.get_child_gameobj("SkillContent_/SkillTem_", self.v_uiobjects.ComboTem)
  self:register_exist_auto_template(SKILL_TEM, skill_tem)
  self.v_hero_icon_luaobj_list = {}
  self.v_combo_luaobj_list = {}
end

function ui:ui_on_show(hero)
  self.v_select_hero = hero
  self:clear_wrap()
  self:refresh_hero_tog()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
  UtilTable.clear_list(hero_item_go_list)
  self.v_hero_icon_luaobj_list = nil
  self.v_combo_luaobj_list = nil
end

function ui:refresh_view()
end

function ui:clear_equation_item()
end

function ui:on_switch_buddy(buddy_id)
  if self.v_combo_luaobj_list then
    self:remove_wrap_ui_list(self.v_combo_luaobj_list)
  end
  self:refresh_combo_list(buddy_id)
end

function ui:refresh_hero_tog()
  local hero_list = SceneMgr:get_hero_list()
  local hero_team_pos = SceneMgr:get_heros_team_pos()
  local hero_to_pos = {}
  local sort_hero_list = {}
  for _, pos_data in pairs(hero_team_pos) do
    hero_to_pos[pos_data.buddy_id] = pos_data.pos
  end
  for uuid, data in pairs(hero_list) do
    local insert_data = {}
    insert_data.uuid = uuid
    insert_data.buddy_type = data.v_type
    insert_data.buddy_id = data.buddy_cfg.Id
    insert_data.fashion_id = data:get_fashion_id()
    insert_data.pos = hero_to_pos[data.buddy_cfg.Id] or data.buddy_cfg.Id
    table.insert(sort_hero_list, insert_data)
  end
  table.sort(sort_hero_list, function(a, b)
    return a.pos < b.pos
  end)
  local index = 1
  local select_index
  for _, hero_data in pairs(sort_hero_list) do
    local hero_item_go = hero_item_go_list[index]
    local lua_obj = SKILL_BAG_CHAR_CLASS:ui_wrap_ex(self, hero_item_go, true)
    table.insert(self.v_hero_icon_luaobj_list, lua_obj)
    lua_obj:set_data(hero_data, index)
    if hero_data.uuid == self.v_select_hero.uuid then
      select_index = index
    end
    index = index + 1
  end
  self.v_hero_icon_luaobj_list[select_index]:on_select(select_index)
end

function ui:refresh_combo_list(buddy_id)
  self:give_back_auto_cache(COMBO_TEM)
  self:give_back_auto_cache(SKILL_TEM)
  local combo_list = ShareRes.get_buddy_cfg(buddy_id).ComboId
  for _, combo_id in ipairs(combo_list) do
    local combo_obj = self:get_auto_cache(COMBO_TEM)
    local combo_cfg = ShareRes.get_buddy_combo_cfg(combo_id)
    local skill_item_list = {}
    for i = 1, #combo_cfg.ComboIcon do
      local skill_item_obj = self:get_auto_cache(SKILL_TEM)
      table.insert(skill_item_list, skill_item_obj)
    end
    local lua_obj = COMBO_TEM_CLASS:ui_wrap_ex(self, combo_obj, true)
    table.insert(self.v_combo_luaobj_list, lua_obj)
    lua_obj:set_data(combo_id, skill_item_list)
  end
end

function ui:clear_wrap()
  if self.v_hero_icon_luaobj_list then
    self:remove_wrap_ui_list(self.v_hero_icon_luaobj_list)
  end
  if self.v_combo_luaobj_list then
    self:remove_wrap_ui_list(self.v_combo_luaobj_list)
  end
  UtilTable.clear_list(self.v_hero_icon_luaobj_list)
  UtilTable.clear_list(self.v_combo_luaobj_list)
end

return ui
