local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local MONTHTASK_AWARD_SHOW_PANEL_AWARD = "MONTHTASK_AWARD_SHOW_PANEL_AWARD"
local MONTHTASK_DOWN_AWARD_SHOW_PANEL_AWARD = "MONTHTASK_DOWN_AWARD_SHOW_PANEL_AWARD"

function ui:ui_finish_load()
  self:set_button("Button_no", function()
    self:ui_hide()
  end)
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnActivateOrder", function()
    local ui_monthtask_award_choice = UIMgr:try_get_visible_ui("ui_monthtask_award_choice")
    if ui_monthtask_award_choice then
      ui_monthtask_award_choice:ui_hide()
    end
    UIMgr:get_ui("ui_monthtask_buy"):ui_show()
    self:ui_hide()
  end)
  self:register_exist_auto_template(MONTHTASK_AWARD_SHOW_PANEL_AWARD, self.v_uiobjects.Single_Row_Template, self.v_uiobjects.Single_Row_Content)
  self:register_exist_auto_template(MONTHTASK_DOWN_AWARD_SHOW_PANEL_AWARD, self.v_uiobjects.DownAwardItem, self.v_uiobjects.Content)
end

function ui:ui_on_show(award_list)
  self:give_back_auto_cache(MONTHTASK_AWARD_SHOW_PANEL_AWARD)
  self:give_back_auto_cache(MONTHTASK_DOWN_AWARD_SHOW_PANEL_AWARD)
  for i, v in pairs(award_list) do
    local item_cfg = ShareRes.get_item_cfg(v.id)
    v.Quality = item_cfg.Quality
    v.Priority = item_cfg.Priority or 0
  end
  table.sort(award_list, function(a, b)
    if a.Quality ~= b.Quality then
      return a.Quality > b.Quality
    end
    if a.Priority ~= b.Priority then
      return a.Priority > b.Priority
    end
    return a.id > b.id
  end)
  for _, cfg in ipairs(award_list) do
    local item_obj = self:get_auto_cache(MONTHTASK_AWARD_SHOW_PANEL_AWARD)
    self:set_data(item_obj, cfg)
  end
  local passport_id = PassPortMgr:get_passport_data().id
  local passport_cfg = ShareRes.get_battle_passport_cfg(passport_id)
  local buy_award_group_id = passport_cfg.BuyAwardGroup[1]
  local award_item_list = {}
  local buy_awards = ShareRes.get_awards(buy_award_group_id)
  for _, value in ipairs(buy_awards) do
    if award_item_list[value.ItemId] then
      award_item_list[value.ItemId] = award_item_list[value.ItemId] + value.Num
    else
      award_item_list[value.ItemId] = value.Num
    end
  end
  local cur_lv = PassPortMgr:get_passport_data().lv
  local group_cfg = ShareRes.get_battle_passport_group_cfg(passport_cfg.Group)
  for i = 1, cur_lv do
    local awards = ShareRes.get_awards(group_cfg[i].SeniorAward)
    for _, value in ipairs(awards) do
      if award_item_list[value.ItemId] then
        award_item_list[value.ItemId] = award_item_list[value.ItemId] + value.Num
      else
        award_item_list[value.ItemId] = value.Num
      end
    end
    local selectSeniorAwardId = group_cfg[i].SelectSeniorAwardId
    if selectSeniorAwardId then
      local select_item_id = ShareRes.create("award.award")[selectSeniorAwardId].ItemId
      if award_item_list[select_item_id] then
        award_item_list[select_item_id] = award_item_list[select_item_id] + 1
      else
        award_item_list[select_item_id] = 1
      end
    end
  end
  local sort_table = {}
  for item_id, count in pairs(award_item_list) do
    local temp = {id = item_id, count = count}
    table.insert(sort_table, temp)
  end
  table.sort(sort_table, function(a, b)
    local cfg_a = ShareRes.get_item_cfg(a.id)
    local cfg_b = ShareRes.get_item_cfg(b.id)
    if cfg_a.Quality ~= cfg_b.Quality then
      return cfg_a.Quality > cfg_b.Quality
    end
    if cfg_a.Priority ~= cfg_b.Priority then
      return cfg_a.Priority > cfg_b.Priority
    end
    return cfg_a.Id > cfg_b.Id
  end)
  if not UtilTable.is_empty(sort_table) then
    for _, cfg in ipairs(sort_table) do
      local item_obj = self:get_auto_cache(MONTHTASK_DOWN_AWARD_SHOW_PANEL_AWARD)
      self:set_data_b(item_obj, cfg.id, cfg.count)
    end
  end
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(item_obj, cfg)
  local item_quality = Util.get_image("Main_Content/Bg", item_obj)
  local item_icon = Util.get_image("Main_Content/Icon", item_obj)
  local item_amount = Util.get_text("Main_Content/amount/Text", item_obj)
  local item_icon_path = ShareRes.get_item_icon_path(cfg.id)
  local item_quality_path = ShareRes.get_item_quality_path(cfg.id)
  item_amount.text = cfg.count
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  local btn = Util.get_button(nil, item_obj)
  self:set_button_listener(btn, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = cfg.id,
      is_exist_jump = false
    })
  end)
end

function ui:set_data_b(item_obj, item_id, count)
  local item_quality = Util.get_image("ItemQuality_", item_obj)
  local item_icon = Util.get_image("ItemIcon_", item_obj)
  local item_amount = Util.get_text("ItemAmount_/Bg/ItemNum_", item_obj)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_item_quality_path(item_id)
  item_amount.text = count
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  local btn = Util.get_button(nil, item_obj)
  self:set_button_listener(btn, function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id, is_exist_jump = false})
  end)
end

return ui
