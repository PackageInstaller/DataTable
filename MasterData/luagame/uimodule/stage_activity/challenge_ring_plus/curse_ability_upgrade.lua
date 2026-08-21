local Base = require("ui.uibase")
local CURSE_ABILITY_UPGRADE_ITEM = require("uimodule.stage_activity.challenge_ring_plus.curse_ability_upgrade_item")
local DROP_ABILITY_ITEM = require("uimodule.stage_activity.challenge_ring_plus.drop_ability_item")
local AssetBarView = require("ui.asset_bar.asset_bar")
local curse_common_define = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local CURSE_CHOOSE_ITEM_TYPE = curse_common_define.CURSE_CHOOSE_ITEM_TYPE
local ABILITY_LV_UP_TEM = "ABILITY_LV_UP_TEM"
local ABILITY_LV_UP_GROUP_TOG_TEM = "ABILITY_LV_UP_GROUP_ITEM"
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm
local ui = Util.create_child_mt(Base)
local asset_bar_config = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}
local TOTAL_GROUP_ID = 0

function ui:on_genres_update()
  self:refresh_view(self.v_data)
  self:on_click_genres_tog(true, self.v_select_genres_id or TOTAL_GROUP_ID)
end

function ui:ui_finish_load()
  self.v_ability_lv_up_item_list = {}
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("Btnpay_Gold", function()
    self:on_click_upgrade_btn()
  end)
  self:set_button("BtnRebuild", function()
    self:on_click_BtnRebuild()
  end)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_bar_config)
  self:register_exist_auto_template(ABILITY_LV_UP_TEM, self.v_uiobjects.TalentTogTem, self.v_uiobjects.TalentContent)
  self:register_exist_auto_template(ABILITY_LV_UP_GROUP_TOG_TEM, self.v_uiobjects.ScreenTem, self.v_uiobjects.ScreenGroup)
  self.v_show_ability_item = DROP_ABILITY_ITEM:ui_wrap(self, self.v_uiobjects.TalentInfo, true)
  self.v_genres_ability_count_map = {}
end

function ui:ui_on_show(recuperation_data, rebuild)
  self:bind_auto_mq(Const.MSG_ON_GENRES_UPDATE, self.on_genres_update, self)
  self.v_is_rebuild = rebuild
  self.v_uiobjects.TalentTem:SetActive(false)
  self.v_uiobjects.Rebuild:SetActive(false)
  self.v_uiobjects.Btnpay_Gold:SetActive(true)
  if not self.v_is_rebuild then
    self.v_uiobjects.Max:SetActive(true)
  end
  self.v_uiobjects.BtnAward:SetActive(false)
  self.v_asset_bar:on_create()
  self:refresh_view(recuperation_data, true)
end

function ui:refresh_view(recuperation_data, init_show)
  self:clear_ability_lv_up_item()
  self.v_uiobjects.Rebuild:SetActive(self.v_is_rebuild == true)
  if not self.v_is_rebuild then
    self.v_data = recuperation_data
    self.v_recuperation_id = recuperation_data.id
  end
  self:refresh_ability_page(init_show)
  if self.v_is_rebuild then
    self:refresh_rebuild_time()
  end
end

function ui:ui_on_hide()
  self.v_is_rebuild = nil
  self.v_data = nil
  self.v_recuperation_id = nil
  self:clear_ability_lv_up_item()
  self.v_asset_bar:on_hide()
  if self.v_show_ability_item then
    self.v_show_ability_item:ui_hide()
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  if self.v_show_ability_item then
    self.v_show_ability_item:ui_destroy()
    self.v_show_ability_item = nil
  end
end

function ui:refresh_ability_page(init_show)
  self:give_back_auto_cache(ABILITY_LV_UP_GROUP_TOG_TEM)
  local genres_map = GenresMgr:get_genres_map()
  for key, genres_data in pairs(genres_map) do
    if genres_data.sect_ability and next(genres_data.sect_ability) then
      local obj = self:get_auto_cache(ABILITY_LV_UP_GROUP_TOG_TEM)
      self:refresh_ability_tog(obj, genres_data.sect_id)
    end
  end
  self:refresh_ability_tog(self.v_uiobjects.ScreenAll, TOTAL_GROUP_ID, init_show)
end

function ui:refresh_ability_tog(obj, genres_id, init_show)
  local num = self:get_text("TalentNum", obj)
  local ability_count = GenresMgr:get_ability_count(genres_id)
  self.v_genres_ability_count_map[genres_id] = ability_count
  num.text = ability_count
  if genres_id ~= TOTAL_GROUP_ID then
    local icon = self:get_image("Icon", obj)
    local cfg = ShareRes.get_genres_cfg(genres_id)
    ResMgr:load_set_icon(icon, cfg.IconPath, nil, true)
  end
  local tog = self:get_toggle(nil, obj)
  self:set_toggle_listener(tog, function(is_on)
    tog.interactable = not is_on
    self:on_click_genres_tog(is_on, genres_id)
  end)
  if init_show and genres_id == TOTAL_GROUP_ID then
    tog.isOn = false
    tog.isOn = true
  end
end

function ui:clear_ability_lv_up_item()
  for key, item in pairs(self.v_ability_lv_up_item_list) do
    item:ui_destroy()
    self.v_ability_lv_up_item_list[key] = nil
  end
end

function ui:on_click_genres_tog(is_on, genres_id)
  if not is_on then
    return
  end
  self.v_select_genres_id = genres_id
  self:change_select_genres(is_on, genres_id)
end

function ui:change_select_genres(is_on, genres_id)
  self:give_back_auto_cache(ABILITY_LV_UP_TEM)
  self:clear_ability_lv_up_item()
  local sort_list = GenresMgr:get_show_ability_list(genres_id)
  local total_unlock_count = #sort_list
  local a_cfg, b_cfg
  table.sort(sort_list, function(a, b)
    a_cfg = ShareRes.get_ability_cfg(a.ability_id)
    b_cfg = ShareRes.get_ability_cfg(b.ability_id)
    if a_cfg.Quality ~= b_cfg.Quality then
      return a_cfg.Quality > b_cfg.Quality
    elseif a_cfg.Id ~= b_cfg.Id then
      return a_cfg.Id > b_cfg.Id
    else
      return false
    end
  end)
  self:create_ability_item(sort_list)
  local cfg = ShareRes.get_genres_cfg(self.v_select_genres_id)
  self.v_uicompents.Title_txt.text = self.v_select_genres_id == TOTAL_GROUP_ID and "全部" or cfg.Name
  local str = "（%d/%d）"
  self.v_uicompents.Progress_txt.text = string.format(str, total_unlock_count, GenresMgr:get_ability_count())
end

function ui:create_ability_item(sort_list)
  self.v_show_type = self.v_is_rebuild and CURSE_CHOOSE_ITEM_TYPE.REBUILD_ABILITY or CURSE_CHOOSE_ITEM_TYPE.COST_UPDAGRADE_ABILITY
  local first_tog, tog
  for index, ability_data in ipairs(sort_list) do
    local obj = self:get_auto_cache(ABILITY_LV_UP_TEM)
    local item = CURSE_ABILITY_UPGRADE_ITEM:ui_wrap(self, obj, true)
    tog = item:set_data(ability_data.ability_id, nil, false, self.v_show_type)
    first_tog = first_tog or tog
    self.v_ability_lv_up_item_list[ability_data.ability_id] = item
  end
  if first_tog then
    first_tog.isOn = false
    first_tog.isOn = true
  end
end

function ui:on_click_BtnRebuild()
  if not self.v_select_ability_id then
    return
  end
  local ability_cfg = ShareRes.get_ability_cfg(self.v_select_ability_id)
  local genres_id = ability_cfg.Sect
  
  local function comform_cb()
    FateBookMgr:request_battle_curse_repeat_ability({
      self.v_select_ability_id
    }, function(ok, resp)
      if ok then
        Util.show_message_tip("重铸成功")
        if self:visible() then
          self:refresh_rebuild_time()
        end
      end
    end)
  end
  
  local check_pass, equation_id = self:check_rebuild_make_equation_level_down(genres_id)
  if check_pass then
    local equation_cfg = ShareRes.get_curse_equation_cfg(equation_id)
    Util.show_conform_tip(string.format("重塑该片语，会导致片段【%s】降低，是否确认", equation_cfg.Name), nil, nil, nil, comform_cb)
  else
    comform_cb()
  end
end

function ui:on_click_upgrade_btn()
  local ability_id = self.v_select_ability_id
  local ability_grade = GenresMgr:get_ability_grade(ability_id)
  local max_lv = ShareRes.get_ability_max_lv(ability_id)
  if ability_grade >= max_lv then
    Util.show_message_tip(2288)
    return
  end
  local recuperation_id = self.v_data.id
  local cfg = ShareRes.get_ability_upgrade_cfg(ability_id, ability_grade + 1)
  if not (cfg and ability_id) or not recuperation_id then
    return
  end
  if cfg.CostItem and cfg.CostItem > 0 and cfg.CostItemCount and cfg.CostItemCount > 0 then
    local final_cost = ChallengeRingPlusMgr:get_after_discount_price(cfg.CostItemCount)
    if not Util.check_item_cost_enough(cfg.CostItem, final_cost) then
      Util.show_message_tip(2314, UtilUI.get_item_name(cfg.CostItem))
      return
    end
  end
  ChallengeRingPlusMgr:set_choose_recuperation_id(recuperation_id)
  GenresMgr:request_upgrade_ability(recuperation_id, ability_id)
end

function ui:on_select_drop_ability(index, ability_id)
  self.v_select_ability_id = ability_id
  self:set_show_ability_info()
  local ability_grade = GenresMgr:get_ability_grade(ability_id)
  self:set_button_state(ability_id, ability_grade)
  self:set_button_cost(ability_id, ability_grade)
  for key, item in pairs(self.v_ability_lv_up_item_list) do
    item:on_select(ability_id)
  end
end

function ui:set_show_ability_info()
  self.v_show_ability_item:set_data(self.v_select_ability_id, nil, true, true, nil, nil, self.v_show_type)
end

function ui:set_button_state(ability_id, ability_grade)
  if self.v_is_rebuild then
    self.v_uiobjects.Btnpay_Gold:SetActive(false)
  else
    local max_lv = ShareRes.get_ability_max_lv(ability_id)
    self.v_uiobjects.Max:SetActive(ability_grade >= max_lv)
    self.v_uiobjects.Btnpay_Gold:SetActive(ability_grade < max_lv)
  end
end

function ui:set_button_cost(ability_id, ability_grade)
  local cfg = ShareRes.get_ability_upgrade_cfg(ability_id, ability_grade + 1)
  if cfg and cfg.CostItem and cfg.CostItem > 0 and cfg.CostItemCount and cfg.CostItemCount > 0 then
    local path = UtilUI.get_item_icon(cfg.CostItem)
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, path)
    local final_cost = ChallengeRingPlusMgr:get_after_discount_price(cfg.CostItemCount)
    local is_enough = Util.check_item_cost_enough(cfg.CostItem, final_cost)
    self.v_uicompents.GoldNeed_txt.text = final_cost
    self.v_uicompents.GoldNeed_txt.color = is_enough and enough_color or not_enough_color
    self.v_uiobjects.AmountBg:SetActive(true)
  else
    self.v_uiobjects.AmountBg:SetActive(false)
  end
end

function ui:refresh_rebuild_time()
  local point = TowerMgr:get_cur_point_id()
  local ring_id = ShareRes.get_ring_id_by_point_id(point)
  local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  local count = ring_cfg.RemodelingCount
  local use_count = ChallengeRingPlusMgr:get_ability_remodel_count()
  self.v_uicompents.RebuildMaxNum_txt.text = count
  self.v_uicompents.RebuildNum_txt.text = count - use_count
  local has_remain = count - use_count > 0
  self.v_uiobjects.RebuildMax:SetActive(not has_remain)
  self.v_uiobjects.BtnRebuild:SetActive(has_remain)
end

function ui:check_rebuild_make_equation_level_down(check_genres_id)
  local equation_data_map = FateBookMgr:get_equation_data_map()
  if equation_data_map then
    for _, equation_data in pairs(equation_data_map) do
      local sect_info_list = FateBookMgr:get_equation_level_change_sect_info(equation_data.id)
      if sect_info_list then
        for _, sect_info in ipairs(sect_info_list) do
          local genres_id, ability_need_count = sect_info.Sect, sect_info.Count
          if check_genres_id == genres_id and ability_need_count == (self.v_genres_ability_count_map[genres_id] or 0) then
            return true, equation_data.id
          end
        end
      end
    end
  end
  return false
end

return ui
