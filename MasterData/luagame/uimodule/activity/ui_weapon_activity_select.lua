local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local WEAPONCONTENT_WEAPONTEM_TEMP_KEY = "WEAPONCONTENT_WEAPONTEM_TEMP_KEY"
local UI_WEAPON_ACTIVITY_SELECT_ITEM = require("uimodule.activity.ui_weapon_activity_select_item")

function ui:on_buddy_change(msg)
  if not msg.mm_x then
    return
  end
  local buddy_list = msg.mm_x
  local all_weapon_list = ShareRes.get_gold_equip_group_cfg(self.v_weapon_group_id)
  self.v_show_weapon_list = {}
  if #buddy_list > 0 then
    local buddy_map = {}
    for key, data in pairs(buddy_list) do
      buddy_map[data.id] = true
    end
    for weapon_id, cfg in pairs(all_weapon_list) do
      local char_id = ShareRes.get_equip_user(weapon_id)
      if buddy_map[char_id] then
        self.v_show_weapon_list[weapon_id] = cfg
      end
    end
  end
  self:refresh_weapon_list()
end

function ui:on_weapon_activity_update()
  local remain_count = NoviceMgr:get_weapon_select_count(self.v_activity_id)
  if remain_count <= 0 then
    self:ui_hide()
    return
  end
  self:clear_data()
  self:refresh_view()
end

function ui:on_click_waepon_item(weapon_id)
  if self.v_select_weapon_id == weapon_id then
    return
  end
  self.v_select_weapon_id = weapon_id
  self:refresh_weapon_select()
end

function ui:on_click_BtnRet1()
  self:ui_hide()
end

function ui:on_click_BtnScreen()
  local screen_buddy_tips = UIMgr:get_ui("screen_buddy_tips")
  screen_buddy_tips:ui_show(nil, nil, nil, nil, true)
end

function ui:on_click_BtnChoose()
  if not (self.v_activity_id and self.v_select_index) or not self.v_select_weapon_id then
    return
  end
  if not NoviceMgr:get_cur_open_weapon_activity_id() then
    return
  end
  if NoviceMgr:get_weapon_select_count(self.v_activity_id) <= 0 then
    return
  end
  
  local function suc_cb()
    local function request_cb()
      local remain_count = NoviceMgr:get_weapon_select_count(self.v_activity_id)
      
      if remain_count <= 0 then
        UIMgr:remove_stace_by_ui_name(self.v_cfg.name)
      end
    end
    
    NoviceMgr:request_activity_gold_equip_gain(self.v_activity_id, self.v_select_index, self.v_select_weapon_id, request_cb)
  end
  
  Util.show_conform_tip("是否选择武器", nil, nil, nil, suc_cb)
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("BtnScreen", function()
    self:on_click_BtnScreen()
  end)
  self:set_button("BtnChoose", function()
    self:on_click_BtnChoose()
  end)
  self.v_scroll_rect = self:get_scrollrect(nil, self.v_uiobjects.ScrollView)
  self:set_scrollrect_listener(self.v_scroll_rect, function()
    self:refresh_arrow()
  end)
  self:register_exist_auto_template(WEAPONCONTENT_WEAPONTEM_TEMP_KEY, self.v_uiobjects.WeaponTem, self.v_uiobjects.WeaponContent)
  self.v_waepon_item_map = {}
  self.v_init_content_y = self.v_uicompents.WeaponContent_rect.anchoredPosition.y
  self.v_init_weapon_tem_width = self.v_uicompents.WeaponTem_rect.rect.width
  self.v_init_view_width = self.v_uicompents.Viewport_rect.rect.width
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.on_buddy_change, self)
  self:bind_auto_mq(Const.MSG_ON_WEAPON_ACTIVITY_UPDATE, self.on_weapon_activity_update, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
  self:refresh_view()
  self:check_close(true)
end

function ui:check_close(force_close)
  local is_close = NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, true == force_close)
  if is_close then
    UIMgr:try_hide_ui("screen_buddy_tips")
  end
end

function ui:ui_on_hide()
  self.v_show_left = nil
  self.v_show_right = nil
  self:clear_data()
  self:clear_weapon_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_view()
  self.v_uicompents.WeaponContent_rect:SetAnchoredPositionA(0, self.v_init_content_y)
  self.v_uicompents.LessNum_txt.text = NoviceMgr:get_weapon_select_count(self.v_activity_id)
  self.v_weapon_group_id, self.v_select_index = NoviceMgr:get_waepon_select_weapon_gourd_id(self.v_activity_id)
  if not Util.is_more_than_zero(self.v_weapon_group_id) then
    return
  end
  self.v_show_weapon_list = ShareRes.get_gold_equip_group_cfg(self.v_weapon_group_id)
  self:refresh_weapon_list()
  local remain_count = NoviceMgr:get_weapon_select_count(self.v_activity_id)
  Util.apply_grey_ex(self.v_uiobjects.BtnChoose, remain_count <= 0)
end

function ui:refresh_weapon_list()
  self:clear_weapon_item()
  if UtilTable.is_empty(self.v_show_weapon_list) then
    return
  end
  local temp_list = UtilTable.map2list(self.v_show_weapon_list, function(a, b)
    if a.Priority ~= b.Priority then
      return a.Priority < b.Priority
    end
    return false
  end)
  for index, group_cfg in ipairs(temp_list) do
    local weapon_id = group_cfg.EquipId
    local obj = self:get_auto_cache(WEAPONCONTENT_WEAPONTEM_TEMP_KEY)
    self.v_waepon_item_map[weapon_id] = UI_WEAPON_ACTIVITY_SELECT_ITEM:ui_wrap_ex(self, obj, true)
    self.v_waepon_item_map[weapon_id]:set_data(group_cfg.Id, weapon_id)
    self.v_waepon_item_map[weapon_id]:on_select(self.v_select_weapon_id)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.WeaponContent_rect)
  self:refresh_arrow(true)
end

function ui:refresh_arrow(is_init)
  local x = -self.v_uicompents.WeaponContent_rect:GetAnchoredPositionA()
  local width = self.v_uicompents.WeaponContent_rect.rect.width
  local last_show_left = self.v_show_left
  self.v_show_left = x > self.v_init_weapon_tem_width
  if last_show_left ~= self.v_show_left then
    self.v_uicompents.Ani_Arrow_Appear_L_pd:ResetPD()
    self.v_uicompents.Ani_Arrow_Disappear_L_pd:ResetPD()
    if self.v_show_left then
      self.v_uicompents.Ani_Arrow_Appear_L_pd:Play()
    else
      self.v_uicompents.Ani_Arrow_Disappear_L_pd:Play()
      if is_init then
        Util.change_component_alpha2(self.v_uicompents.ArrowLeft_img, 0)
      end
    end
  end
  local max_x = width - self.v_init_weapon_tem_width - 200 - self.v_init_view_width
  local last_show_right = self.v_show_right
  self.v_show_right = x < max_x
  if last_show_right ~= self.v_show_right then
    self.v_uicompents.Ani_Arrow_Appear_R_pd:ResetPD()
    self.v_uicompents.Ani_Arrow_Disappear_R_pd:ResetPD()
    if self.v_show_right then
      self.v_uicompents.Ani_Arrow_Appear_R_pd:Play()
    else
      self.v_uicompents.Ani_Arrow_Disappear_R_pd:Play()
      if is_init then
        Util.change_component_alpha2(self.v_uicompents.ArrowRight_img, 0)
      end
    end
  end
end

function ui:refresh_weapon_select()
  for key, item in pairs(self.v_waepon_item_map) do
    item:on_select(self.v_select_weapon_id)
  end
end

function ui:clear_weapon_item()
  self:give_back_auto_cache(WEAPONCONTENT_WEAPONTEM_TEMP_KEY)
  for key, item in pairs(self.v_waepon_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_waepon_item_map[key] = nil
  end
end

function ui:clear_data()
  self.v_select_weapon_id = nil
  self.v_weapon_group_id = nil
  self.v_show_weapon_list = nil
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id
end

return ui
