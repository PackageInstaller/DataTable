local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local ILLUSTARATED_ABILITY_TEMP = "ILLUSTARATED_ABILITY_TEMP"
local ILLUSTRATED_ABILITY_ITEM = require("uimodule.stage_activity.fate_book.fate_book_illustrated_ability_item")
local ABILITY_ILLUSTRATED_TOG_TEM = "ABILITY_ILLUSTRATED_TOG_TEM"
local TOTAL_GROUP_ID = 0

function ui:on_click_genres_tog(is_on, genres_id)
  if not is_on or genres_id == self.v_select_genres_id or self.v_is_init then
    return
  end
  self.v_select_genres_id = genres_id
  self:refresh_ability_view()
end

function ui:on_select_ability(item)
  if self.v_select_ability_id == item.v_ability_id then
    return
  end
  self.v_select_ability_id = item.v_ability_id
  if self.v_static_sv then
    self.v_static_sv:on_select_change(item)
  end
  self:set_show_ability_info()
end

function ui:ui_finish_load()
  self:set_button("BtnAward", function()
    local task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT)
    UIMgr:get_ui("chapter_task"):ui_show(nil, task_group_id, "收集进度")
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.TalentContent, ILLUSTRATED_ABILITY_ITEM, ILLUSTARATED_ABILITY_TEMP)
  self.v_static_sv:set_batch_refresh(10, 0.1)
  self.v_show_ability_item = ILLUSTRATED_ABILITY_ITEM:ui_wrap(self, self.v_uiobjects.TalentInfo, true)
  self:register_exist_auto_template(ABILITY_ILLUSTRATED_TOG_TEM, self.v_uiobjects.ScreenTem, self.v_uiobjects.ScreenGroup)
end

function ui:ui_before_show()
end

function ui:ui_on_show()
  self.v_uiobjects.TalentTogTem:SetActive(false)
  self.v_uiobjects.AssetBar:SetActive(false)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_redpoint, self)
  self:set_show_ability_visible(true)
  self.v_uiobjects.Btnpay_Gold:SetActive(false)
  self.v_uiobjects.Max:SetActive(false)
  self.v_uiobjects.BtnAward:SetActive(true)
  self:refresh_ability_page()
  self:refresh_task_redpoint()
end

function ui:ui_on_hide()
  if self.v_show_ability_item then
    self.v_show_ability_item:ui_hide()
  end
  self.v_select_genres_id = nil
  self.v_select_ability_id = nil
  self.v_static_sv:on_hide()
end

function ui:ui_on_destroy()
  if self.v_show_ability_item then
    self.v_show_ability_item:ui_destroy()
    self.v_show_ability_item = nil
  end
  self.v_static_sv = nil
end

function ui:refresh_ability_page()
  self:give_back_auto_cache(ABILITY_ILLUSTRATED_TOG_TEM)
  local all_genres_cfg = ShareRes.get_all_genres_cfg()
  local temp_list = {}
  for key, cfg in pairs(all_genres_cfg) do
    temp_list[#temp_list + 1] = cfg
  end
  temp_list[#temp_list + 1] = {Id = TOTAL_GROUP_ID, Priority = 99999}
  table.sort(temp_list, function(a, b)
    if a.Priority ~= b.Priority then
      return a.Priority > b.Priority
    else
      return false
    end
  end)
  local obj, tog, first_tog
  for key, genres_cfg in ipairs(temp_list) do
    if genres_cfg.Id == TOTAL_GROUP_ID then
      obj = self.v_uiobjects.ScreenAll
    else
      obj = self:get_auto_cache(ABILITY_ILLUSTRATED_TOG_TEM)
    end
    tog = self:refresh_ability_tog(obj, genres_cfg.Id, 1 == key)
    if not first_tog and tog then
      first_tog = tog
    end
  end
  if first_tog then
    first_tog.isOn = false
    first_tog.isOn = true
  end
end

function ui:refresh_ability_tog(obj, genres_id, init_show)
  local all_ability_cfg = ShareRes.get_ability_id_list_by_genres_id(genres_id)
  local num = self:get_text("TalentNum", obj)
  num.text = UtilTable.hash_lenth(all_ability_cfg)
  if genres_id ~= TOTAL_GROUP_ID then
    local icon = self:get_image("Icon", obj)
    local cfg = ShareRes.get_genres_cfg(genres_id)
    ResMgr:load_set_icon(icon, cfg.IconPath, nil, true)
  end
  local tog = self:get_toggle(nil, obj)
  tog.isOn = true
  tog.isOn = false
  self:set_toggle_listener(tog, function(is_on)
    tog.interactable = not is_on
    self:on_click_genres_tog(is_on, genres_id)
  end)
  if init_show then
    self.v_genres_id = genres_id
    return tog
  end
end

function ui:refresh_ability_view()
  self.v_select_ability_id = nil
  self:set_show_ability_visible(true)
  local all_ability_list = ShareRes.get_ability_id_list_by_genres_id(self.v_select_genres_id)
  local temp_list = {}
  local total_unlock_count = 0
  for key, id in ipairs(all_ability_list) do
    temp_list[key] = ShareRes.get_ability_cfg(id)
    if FateBookMgr:check_illustrated_is_unlock(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT, id) then
      total_unlock_count = total_unlock_count + 1
    end
  end
  local init_x = self.v_uicompents.TalentContent_rect.anchoredPosition.x
  self.v_uicompents.TalentContent_rect:SetAnchoredPositionA(init_x, 0)
  self.v_static_sv:update_list(temp_list)
  local cfg = ShareRes.get_genres_cfg(self.v_select_genres_id)
  self.v_uicompents.Title_txt.text = self.v_select_genres_id == TOTAL_GROUP_ID and "全部" or cfg.Name
  local str = "（%d/%d）"
  self.v_uicompents.Progress_txt.text = string.format(str, total_unlock_count, #temp_list)
end

function ui:refresh_task_redpoint()
  local task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT)
  local have_red = TaskMgr:get_task_group_red(task_group_id)
  self.v_uiobjects.RedPoint:SetActive(have_red)
  local bg = self:get_child_gameobj("ActBg", self.v_uiobjects.BtnAward)
  if bg then
    bg.gameObject:SetActive(have_red)
  end
end

function ui:set_show_ability_info()
  local cfg = ShareRes.get_ability_cfg(self.v_select_ability_id)
  self.v_show_ability_item:set_data(cfg)
  self:set_show_ability_visible(true)
end

function ui:set_show_ability_visible(visible)
  self.v_show_ability_item:set_enable(visible)
end

return ui
