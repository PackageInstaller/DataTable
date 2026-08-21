local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local climbing_tower_type_key = "climbing_tower_type_key"
local ITEM_CLASS = require("uimodule.climbing_tower.ui_climbing_tower_type_item")
local CLIMBING_TOWER_TYPE_AWARD_KEY = "CLIMBING_TOWER_TYPE_AWARD_KEY"
local ITEM_OBJ_CLASS = require("uimodule.item.item_obj_com")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local spine_id = ShareRes.get_comm_value("ClimbingTowerSpineId")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnStart", function()
    self:on_btn_start_click()
  end)
  self:register_exist_auto_template(climbing_tower_type_key, self.v_uiobjects.StageTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(CLIMBING_TOWER_TYPE_AWARD_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.AwardContent)
  local cfg_list = ShareRes.create("chapter.climbing_tower")
  self.climbing_tower_type_list = {}
  for i, cfg in pairs(cfg_list) do
    table.insert(self.climbing_tower_type_list, cfg)
  end
  table.sort(self.climbing_tower_type_list, function(a, b)
    return a.Order < b.Order
  end)
end

function ui:ui_on_show(select_type)
  self.v_select_type = select_type
  if not self.v_select_type then
    self.v_select_type = ClimbingTowerMgr:get_new_group_id()
  end
  self.v_select_item = nil
  self:refresh_list(select_type)
  self:update_spine()
  ClimbingTowerMgr:on_climbing_tower_opened()
end

function ui:refresh_list()
  self:give_back_auto_cache(climbing_tower_type_key)
  self:clear_warp_type_item()
  self.v_type_item_list = {}
  for _, cfg in ipairs(self.climbing_tower_type_list) do
    local item_obj = self:get_auto_cache(climbing_tower_type_key)
    local item = ITEM_CLASS:ui_wrap_ex(self, item_obj, true)
    item:set_data(cfg)
    table.insert(self.v_type_item_list, item)
  end
end

function ui:refresh_select_item(item)
  self.v_select_item = item
  self.v_select_type = item:get_cfg_id()
  local is_open = item:get_is_open()
  self.v_uiobjects.UnLockObj:SetActive(is_open)
  self.v_uiobjects.LockObj:SetActive(not is_open)
  self.v_uiobjects.Progress:SetActive(is_open)
  self:refresh_award()
  self:refresh_select_icon(item:get_big_icon())
  if not is_open then
    local tips = item:get_tips()
    self.v_uicompents.Condition_txt.text = tips
    return
  end
  self:refresh_star()
end

function ui:refresh_select_icon(icon_path)
  ResMgr:load_set_icon(self.v_uicompents.StageIcon_img, icon_path)
end

function ui:get_select_type()
  return self.v_select_type
end

function ui:refresh_award()
  local awards = {}
  ShareRes.get_item_obj_use_award_list(self.v_select_item:get_award_group_id(), awards)
  self:give_back_auto_cache(CLIMBING_TOWER_TYPE_AWARD_KEY)
  self:clear_warp_award_item()
  self.v_award_item_list = {}
  for _, award_data in ipairs(awards) do
    local item_obj = self:get_auto_cache(CLIMBING_TOWER_TYPE_AWARD_KEY)
    local item = ITEM_OBJ_CLASS:ui_wrap_ex(self, item_obj, true)
    item:set_data(award_data, true)
    table.insert(self.v_award_item_list, item)
  end
end

function ui:on_btn_start_click()
  local is_open = self.v_select_item:get_is_open()
  if not is_open then
    return
  end
  UIMgr:get_ui("ui_climbing_tower_stage"):ui_show(self.v_select_type)
end

function ui:refresh_star()
  local now_star = ClimbingTowerMgr:get_group_star(self.v_select_type)
  local max_star = ClimbingTowerMgr:get_group_max_star(self.v_select_type)
  self.v_uicompents.ProgressNow_txt.text = now_star
  self.v_uicompents.ProgressMax_txt.text = max_star
end

function ui:refresh_anim(index)
end

function ui:ui_on_hide()
  self:clear_warp_type_item()
  self:clear_warp_award_item()
end

function ui:update_spine()
  if not spine_id or spine_id <= 0 then
    return
  end
  self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpinePhoto)
  if self.v_spine_id ~= spine_id then
    self.v_spine_id = spine_id
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.SpinePhoto, true)
  else
    self.v_uiobjects.SpinePhoto:SetActive(true)
  end
end

function ui:ui_on_destroy()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_select_type
end

function ui:clear_warp_type_item()
  if self.v_type_item_list then
    for key, item in pairs(self.v_type_item_list) do
      item:ui_destroy()
      self.v_type_item_list[key] = nil
    end
    self.v_type_item_list = nil
  end
end

function ui:clear_warp_award_item()
  if self.v_award_item_list then
    for key, item in pairs(self.v_award_item_list) do
      item:ui_destroy()
      self.v_award_item_list[key] = nil
    end
    self.v_award_item_list = nil
  end
end

return ui
