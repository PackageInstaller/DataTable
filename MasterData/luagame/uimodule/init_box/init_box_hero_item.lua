local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local CHAR_HELPER = require("uimodule.character.char_helper")
local INIT_BOX_HERO_BOX_ITEM_KEY = "INIT_BOX_HERO_BOX_ITEM_KEY"
local _insert = table.insert
local _tsort = table.sort
local ITEM_OBJ = require("uimodule.battle_bag.battle_item")

function M:ui_finish_load()
end

function M:init_template(idx)
  self.v_idx = idx
  self:register_exist_auto_template(INIT_BOX_HERO_BOX_ITEM_KEY .. idx, self.v_uiobjects.HeroItemObj, self.v_uiobjects.HeroItemList)
  self.v_register_end = true
end

function M:ui_on_show()
  self:refresh_hero_list_ui()
end

function M:set_data(hero_id, idx)
  self.v_hero_id = hero_id
  self.v_cfg = ShareRes.get_buddy_cfg(hero_id)
  self:init_template(idx)
  self:refresh_ui()
end

function M:refresh_ui()
  self:refresh_hero_info()
  self:refresh_init_box_info()
end

function M:refresh_hero_list_ui()
  local list_obj = self.v_uiobjects.HeroItemList
  local rect = Util.get_rect_transform(nil, list_obj)
  rect:SetAnchoredPositionA(0, 0)
end

function M:refresh_hero_info()
  local ucom = self.v_uicompents
  local hero_img = ucom.HeadIcon_img
  local hero_icon = UtilUI.get_hero_images(self.v_hero_id, 1)
  ResMgr:load_set_icon(hero_img, hero_icon)
  local potential_img = ucom.PotentialIcon_img
  local potential_icon = CHAR_HELPER.get_battle_char_potential_icon(self.v_hero_id)
  ResMgr:load_set_icon(potential_img, potential_icon, nil, true)
end

function M:refresh_init_box_info()
  local advance_born_item_cfg = ShareRes.get_buddy_advance_born_item_cfg(self.v_hero_id)
  local none_obj = self.v_uiobjects.None
  none_obj:SetActive(false)
  if advance_born_item_cfg then
    self:give_back_auto_cache(INIT_BOX_HERO_BOX_ITEM_KEY .. self.v_idx)
    self:clear_box_item_list()
    self.v_box_item_list = {}
    local item_list = self:_build_item_list(advance_born_item_cfg)
    for idx, _ in ipairs(item_list) do
      local go = self:get_auto_cache(INIT_BOX_HERO_BOX_ITEM_KEY .. self.v_idx)
      local item_obj = ITEM_OBJ:ui_wrap_ex(self, go, true)
      item_obj.go = go
      item_obj:set_data(go, item_list, idx, Config.ITEM_OBJ_TYPE.INIT_BOX_HERO_ITEM)
      _insert(self.v_box_item_list, item_obj)
    end
  else
    none_obj:SetActive(true)
  end
end

function M:_build_item_list(advance_born_item_cfg)
  local item_list = {}
  local list = SceneMgr:get_hero_list()
  local hero_advance_lv
  for _, hero in pairs(list) do
    local BuddyId = hero.buddy_cfg.Id
    if self.v_hero_id == BuddyId then
      hero_advance_lv = hero:get_hero_advance()
      break
    end
  end
  for _, data in pairs(advance_born_item_cfg) do
    local temp_data = {
      id = data.ItemId[1],
      item_num = data.ItemCnt[1],
      advance_lv = data.AdvanceLv,
      hero_advance_lv = hero_advance_lv
    }
    _insert(item_list, temp_data)
  end
  _tsort(item_list, function(a, b)
    return a.advance_lv < b.advance_lv
  end)
  return item_list
end

function M:ui_on_hide()
  self:clear_box_item_list()
end

function M:on_clear()
  self:unbind_all_auto_mq()
  if self.v_register_end then
    self:give_back_all_auto_cache(INIT_BOX_HERO_BOX_ITEM_KEY .. self.v_idx)
    self:unregister_template(INIT_BOX_HERO_BOX_ITEM_KEY .. self.v_idx)
    self.v_register_end = false
  end
end

function M:clear_box_item_list()
  if self.v_box_item_list then
    self:remove_wrap_ui_list(self.v_box_item_list)
  end
end

return M
