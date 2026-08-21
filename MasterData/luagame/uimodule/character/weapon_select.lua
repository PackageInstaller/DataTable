local Base = require("ui.uibase")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local WeaponTongTiaoNew = require("uimodule.character.weapon_tongtiao_new")
local WeaponReplaceInfo = require("uimodule.character.weapon_replace")
local EQUIP_SELECT_KEY = "equip_select_key"
local WeaponModelRtView = require("ui.model_rt_view.model_rt_weapon_view")
local CHAR_HELPER = require("uimodule.character.char_helper")
local CommonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.BUTTON
  },
  v_btn_ret = {
    "BtnRet",
    BIND_TYPE.BUTTON
  },
  v_enhance_content = {
    "EnhanceContent",
    BIND_TYPE.OBJECT
  },
  v_item_template = {
    "ItemTemplate",
    BIND_TYPE.OBJECT
  },
  v_none_mat = {
    "NoneMat",
    BIND_TYPE.OBJECT
  },
  v_select_btn = {
    "SelectBtn",
    BIND_TYPE.BUTTON
  },
  v_show_weapon = {
    "ShowWeapon",
    BIND_TYPE.RAW_IMAGE
  },
  v_weapon_content = {
    "WeaponContent",
    BIND_TYPE.OBJECT
  },
  v_weapon_detail = {
    "WeaponDetail",
    BIND_TYPE.OBJECT
  },
  v_weapon_tongtiao = {
    "WeaponTongtiao",
    BIND_TYPE.OBJECT
  }
}
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local WEAPON_SELECT_TYPE = CHARACTER_CONFIG.WEAPON_SELECT_TYPE
local STAR_START_IDX = 1
local STAR_END_IDX = 3

function ui:ui_finish_load()
  self.v_weapon_attr_open_type = CHARACTER_CONFIG.WEAPON_ATTR_OPEN_TYPE.SELECT
  self:init_model(MODEL)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self:set_button("SelectBtn", function()
    if self.v_open_type == WEAPON_SELECT_TYPE.COST then
      self:select_weapon()
    elseif self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
      self:set_none_mat_visible(false)
      self:replace_weapon()
    end
  end)
  self.v_init_bg = Util.get_canvas_group("FullScreenBackground", self.v_object)
  self.v_weapon_replace_attr = WeaponReplaceInfo:ui_wrap_ex(self, self.v_weapon_detail, false)
  self.v_weapon_tongtiao_attr = WeaponTongTiaoNew:ui_wrap_ex(self, self.v_weapon_tongtiao, false)
  self:register_exist_auto_template(EQUIP_SELECT_KEY, self.v_uiobjects.WeaponTem, self.v_weapon_content)
end

function ui:select_weapon()
  if not self.v_last_uuid then
    return
  end
  local equip_info = CharacterMgr:get_equip_info(self.v_last_uuid)
  local has_develop = equip_info.lv > 1 or equip_info.break_lv > 1 or equip_info.advance > 1
  
  local function confirm_cb()
    if self.v_callback then
      local is_lock = CHAR_HELPER.is_equip_lock(self.v_last_uuid)
      if is_lock then
        Util.show_message_tip(2159)
        return
      end
      self.v_callback(self.v_last_uuid)
      self.v_callback = nil
    end
    self:ui_hide()
  end
  
  if has_develop then
    Util.show_notify_popup_message(confirm_cb, "当前武器已进行过培养，是否确认？")
  else
    confirm_cb()
  end
end

function ui:set_weapon_model_visible(is_on)
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:set_visible(is_on)
  end
end

function ui:replace_weapon()
  local equip = CharacterMgr:get_equip_info(self.v_last_uuid)
  if equip.owner and 0 ~= equip.owner then
    Util.show_message_tip(2160)
    return
  end
  local equip_uuid = self.v_last_uuid
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local buddy_config = ShareRes.create("buddy.buddy", self.v_buddy_id)
  if equip_cfg.SubType ~= buddy_config.WeaponSubType then
    Util.show_message_tip(1052)
    return
  end
  CharacterMgr:wear_equip(self.v_buddy_id, equip_uuid, function()
    Util.show_message_tip(2161)
    self:ui_hide()
  end)
end

function ui:refresh_wear_state()
  for key, data in pairs(self.v_equip_list) do
    local equip_info = CharacterMgr:get_equip_info(data.equip_data.uuid)
    local wear = Util.get_rect_transform("wear_layout_", data.object)
    wear.gameObject:SetActive(0 ~= equip_info.owner)
    if 0 ~= equip_info.owner then
      local owner_iocn = Util.get_image("wear_layout_/hero_head_icon_", data.object)
      local icon_path = UtilUI.get_hero_images(equip_info.owner, 1)
      ResMgr:load_set_icon(owner_iocn, icon_path)
    end
  end
end

function ui:ui_on_show(callback, buddy_id, type, cost_id_list, select_equip_uuid)
  self.v_init_bg.alpha = 1
  self.v_character_pnl = UIMgr:try_get_visible_ui("character")
  self.v_uicompents.SelectBtn_rect:SetActive(type == WEAPON_SELECT_TYPE.COST)
  self.v_open_type = type
  self.v_cost_id_list = cost_id_list
  self.v_select_equip_uuid = select_equip_uuid
  self.v_buddy_id = buddy_id
  if not buddy_id and self.v_character_pnl then
    local last_buddy_id = CharacterMgr.v_last_select_buddy_id
    self.v_buddy_id = last_buddy_id
  end
  if type == WEAPON_SELECT_TYPE.NORMAL then
    local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
    local element_icon = self.v_uicompents.element_icon_img
    local buddy_config = ShareRes.create("buddy.buddy", buddy_info.id)
    self.v_buddy_id = buddy_info.id
    local path = CharacterMgr:get_buddy_element_icon_path(buddy_info.id)
  end
  self.v_weapon_detail:SetActive(type == WEAPON_SELECT_TYPE.NORMAL)
  self.v_weapon_tongtiao:SetActive(type == WEAPON_SELECT_TYPE.COST)
  self.v_enhance = nil
  self.v_callback = callback
  self:_init_weapon_list()
  self:register_event()
end

function ui:register_event()
  Util.bind_msg(self, Const.MSG_ON_UPDATE_EQUIP_LOCK, self.response_refresh_equip_view, self)
end

function ui:_init_weapon_list()
  if not self.v_visible then
    return
  end
  self.v_uicompents.WeaponContent_rect:SetAnchoredPositionA(0, 0)
  self:give_back_auto_cache(EQUIP_SELECT_KEY)
  local new_equip_list = self:get_show_weapon_list()
  self:sort_weapon_list(new_equip_list)
  local init_uuid
  self.v_equip_list = {}
  self.select_equip_list = {}
  self.select_image_list = {}
  self.btn_del_list = {}
  local mat_count = 0
  for _, equip_info in pairs(new_equip_list) do
    mat_count = mat_count + 1
    local equip_ui = self:get_auto_cache(EQUIP_SELECT_KEY)
    self.v_equip_list[equip_info.uuid] = {object = equip_ui, equip_data = equip_info}
    init_uuid = init_uuid or equip_info.uuid
    self:refresh_equip_view(equip_info, equip_ui)
    local select_img = Util.get_image("Select_", equip_ui)
    select_img.gameObject:SetActive(false)
    self:set_button_listener(Util.get_button(nil, equip_ui), function()
      self:v_click_equip(equip_info.uuid)
    end)
  end
  self:set_none_mat_visible(mat_count <= 0)
  self.v_last_uuid = nil
  if self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
    self:v_click_equip(init_uuid)
  else
    self:v_click_equip(0)
  end
end

local SORT_RULE = {
  [WEAPON_SELECT_TYPE.NORMAL] = {
    "quality",
    "break_lv",
    "lv",
    "advance",
    "uuid"
  },
  [WEAPON_SELECT_TYPE.COST] = {
    "break_lv",
    "lv",
    "advance"
  }
}

function ui:sort_weapon_list(equip_list)
  if self.v_open_type == WEAPON_SELECT_TYPE.COST then
    table.sort(equip_list, function(a, b)
      for key, type in ipairs(SORT_RULE[WEAPON_SELECT_TYPE.COST]) do
        if a[type] ~= b[type] then
          return a[type] < b[type]
        end
      end
      return a.uuid > b.uuid
    end)
  else
    table.sort(equip_list, function(a, b)
      if 0 ~= a.owner or 0 ~= b.owner then
        return 0 ~= a.owner
      end
      for key, type in ipairs(SORT_RULE[WEAPON_SELECT_TYPE.NORMAL]) do
        if a[type] ~= b[type] then
          return a[type] > b[type]
        end
      end
    end)
  end
end

function ui:get_show_weapon_list()
  local new_equip_list = {}
  local equip_list = CharacterMgr:get_equip_list()
  if not self.v_open_type or self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
    local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
    local buddy_config = ShareRes.create("buddy.buddy", buddy_info.id)
    for _, equip_info in pairs(equip_list) do
      local id = equip_info.id
      local equip_cfg = ShareRes.create("equip.equip", id)
      equip_info.quality = equip_cfg.Quality
      if equip_cfg.SubType == buddy_config.WeaponSubType then
        table.insert(new_equip_list, equip_info)
      end
    end
  elseif self.v_open_type == WEAPON_SELECT_TYPE.COST then
    for _, equip_info in pairs(equip_list) do
      local id = equip_info.id
      local equip_cfg = ShareRes.create("equip.equip", id)
      equip_info.quality = equip_cfg.Quality
      if self.v_cost_id_list[id] and (not equip_info.owner or 0 == equip_info.owner) and self.v_select_equip_uuid ~= equip_info.uuid then
        table.insert(new_equip_list, equip_info)
      end
    end
  end
  return new_equip_list
end

function ui:change_select_list_with_id(uuid, select_obj, btn_del_obj)
  if not self.max_select_count then
    self.select_equip_list[1] = uuid
    self.select_image_list[1] = select_obj
    self.btn_del_list[1] = btn_del_obj
    select_obj:SetActive(true)
    btn_del_obj:SetActive(true)
    return
  end
  local index = self:check_is_selected(uuid)
  if index > 0 then
    self.select_image_list[index]:SetActive(false)
    self.btn_del_list[index]:SetActive(false)
    table.remove(self.select_equip_list, index)
    table.remove(self.select_image_list, index)
    table.remove(self.btn_del_list, index)
    return
  end
  if #self.select_equip_list == self.max_select_count then
    self.select_image_list[1]:SetActive(false)
    self.btn_del_list[1]:SetActive(false)
    table.remove(self.select_equip_list, 1)
    table.remove(self.select_image_list, 1)
    table.remove(self.btn_del_list, 1)
  end
  self.select_equip_list[#self.select_equip_list + 1] = uuid
  self.select_image_list[#self.select_image_list + 1] = select_obj
  self.btn_del_list[#self.btn_del_list + 1] = btn_del_obj
  for i, v in pairs(self.select_image_list) do
    v:SetActive(true)
  end
  for i, v in pairs(self.btn_del_list) do
    v:SetActive(true)
  end
end

function ui:un_select_all(is_need_refresh_weapon_list)
  local count = #self.select_equip_list
  for i = count, 1, -1 do
    self:change_select_list_with_id(self.select_equip_list[i])
  end
  if is_need_refresh_weapon_list then
    self.ignore_refresh_model = true
    self:_init_weapon_list(true)
  else
    self.ignore_refresh_model = nil
  end
  self.v_weapon_tongtiao_attr:refresh_equip_info(self:get_curr_equip_info(), self.select_equip_list, self)
end

function ui:auto_add()
  local new_equip_list = self:get_show_weapon_list()
  self:sort_weapon_list(new_equip_list)
  local need_select_list = {}
  local need_count = self:get_rich_max_need_count()
  for i, equip_info in pairs(new_equip_list) do
    if need_count <= #need_select_list then
      break
    end
    need_select_list[#need_select_list + 1] = equip_info.uuid
  end
  local new_list = {}
  for i, v in pairs(need_select_list) do
    new_list[v] = true
  end
  for _, equip in pairs(self.v_equip_list) do
    local uuid = equip.equip_data.uuid
    if true == new_list[uuid] then
      local equip_ui = equip.object
      local select_img = Util.get_image("Choose_", equip_ui.transform)
      local btn_del_obj = Util.get_child_gameobj("BtnDel_", equip_ui.transform)
      self:change_select_list_with_id(uuid, select_img.gameObject, btn_del_obj)
    end
  end
  self.v_weapon_tongtiao_attr:refresh_equip_info(self:get_curr_equip_info(), self.select_equip_list, self)
end

function ui:un_select_with_index(index)
  local uuid = self.select_equip_list[index]
  self:v_click_equip(uuid)
end

function ui:check_is_rich_max_tong_tiao(uuid)
  local index = self:check_is_selected(uuid)
  if index > 0 then
    return false
  end
  local equip_info = self:get_curr_equip_info()
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  assert(advance_cfg, "no such equip_advance, id " .. equip_info.id)
  local advance_lv = equip_info.advance
  local max_advance_lv = #advance_cfg
  if max_advance_lv <= advance_lv + #self.select_equip_list then
    Util.show_message_tip(2162)
    return true
  end
  return false
end

function ui:get_rich_max_need_count()
  local equip_info = self:get_curr_equip_info()
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  assert(advance_cfg, "no such equip_advance, id " .. equip_info.id)
  local advance_lv = equip_info.advance
  local max_advance_lv = #advance_cfg
  return max_advance_lv - advance_lv
end

function ui:check_is_selected(uuid)
  local index = 0
  for i = 1, #self.select_equip_list do
    if self.select_equip_list[i] == uuid then
      index = i
      break
    end
  end
  return index
end

function ui:v_click_equip(uuid)
  if self.v_last_uuid == uuid and self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
    return
  end
  if self.v_open_type == WEAPON_SELECT_TYPE.COST and self:check_is_rich_max_tong_tiao(uuid) then
    return
  end
  for _, equip in pairs(self.v_equip_list) do
    local equip_ui = equip.object
    local select_img = Util.get_image("Select_", equip_ui.transform)
    local btn_del_obj = Util.get_child_gameobj("Select_/BtnDel_", equip_ui.transform)
    if self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
      select_img.gameObject:SetActive(false)
      if equip.equip_data.uuid == uuid then
        select_img.gameObject:SetActive(true)
      end
    elseif equip.equip_data.uuid == uuid then
      self:change_select_list_with_id(uuid, select_img.gameObject, btn_del_obj)
    end
  end
  self.v_last_uuid = uuid
  local equip = CharacterMgr:get_equip_info(uuid)
  if self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
    self.v_weapon_replace_attr:refresh_equip_info(self:get_curr_equip_info(), equip)
  else
    self.v_weapon_tongtiao_attr:refresh_equip_info(self:get_curr_equip_info(), self.select_equip_list, self)
  end
  self:update_weapon_view()
  self.v_uiobjects.Equipped:SetActive(nil ~= equip and 0 ~= equip.owner)
  self.v_uiobjects.SelectBtn:SetActive(nil ~= equip and 0 == equip.owner and self.v_open_type == WEAPON_SELECT_TYPE.NORMAL)
end

function ui:set_max_select_count(value)
  self.max_select_count = value
end

function ui:get_curr_equip_info()
  local curr_equip_info = CharacterMgr:get_equip_info_by_buddy_id(self.v_buddy_id)
  if nil == curr_equip_info then
    curr_equip_info = CharacterMgr:get_equip_info(self.v_select_equip_uuid)
  end
  return curr_equip_info
end

function ui:set_none_mat_visible(value)
  self.v_none_mat.gameObject:SetActive(value)
end

function ui:refresh_equip_view(equip_data, object)
  local uuid = equip_data.uuid
  local equip_info = CharacterMgr:get_equip_info(uuid)
  local id = equip_info.id
  local icon = Util.get_image("ItemIcon_", object)
  local equip_cfg = ShareRes.create("equip.equip", id)
  local path = string.format("Icon/Item/%s", equip_cfg.Icon)
  ResMgr:load_set_icon(icon, path)
  local quality_icon = Util.get_image("ItemQuality_", object)
  local quality_cfg = ShareRes.get_equip_icon_cfg(equip_cfg.Quality)
  path = string.format("UICommon/%s", quality_cfg.Quality_Bg)
  ResMgr:load_set_icon(quality_icon, path)
  local advance_obj = Util.get_child_gameobj("AdvanceLv", object)
  advance_obj:SetActive(true)
  local advanceLv_txt = Util.get_text("AdvanceLv/AdvanceLv_", object)
  advanceLv_txt.text = Util.format_str("同调{1}", CommonDef.ROME_NUM[equip_info.advance])
  local break_lv = equip_info.break_lv
  break_lv = break_lv - 1
  local lv_text = Util.get_text("Lower/Weapon_/WeaponLV_", object)
  lv_text.text = equip_info.lv
  local wear = Util.get_rect_transform("wear_layout_", object)
  wear.gameObject:SetActive(0 ~= equip_info.owner)
  if 0 ~= equip_info.owner then
    local owner_iocn = Util.get_image("wear_layout_/hero_head_icon_", object)
    local icon_path = UtilUI.get_hero_images(equip_info.owner, 1)
    ResMgr:load_set_icon(owner_iocn, icon_path)
  end
end

function ui:ui_on_hide()
  self.v_last_uuid = nil
  if not self.v_enhance and self.v_open_type ~= WEAPON_SELECT_TYPE.COST and self.v_character_pnl then
    local character_main = self.v_character_pnl:get_panel("char_main")
    character_main:ui_show(false)
  end
  if self.v_open_type == WEAPON_SELECT_TYPE.COST and self.v_callback then
    self.v_callback()
  end
  self.v_callback = nil
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:on_destroy()
    self.v_weapon_model_rt = nil
  end
  self.v_equip_list = {}
end

function ui:update_weapon_view()
  if self.ignore_refresh_model then
    self.ignore_refresh_model = nil
    return
  end
  local equip
  if self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
    equip = CharacterMgr:get_equip_info(self.v_last_uuid)
  else
    equip = self:get_curr_equip_info()
  end
  if not equip then
    return
  end
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:change_weapon(equip.id)
    self.v_weapon_model_rt:set_rotate_weapon()
    return
  end
  self.v_weapon_model_rt = WeaponModelRtView:new(nil, false, nil, nil, true, "UIModelRtViewWeapon")
  self.v_weapon_model_rt:init_weapon_info(equip.id)
  self.v_weapon_model_rt:set_rotate_weapon()
  self.v_init_bg.alpha = 0
end

function ui:set_model_visible(value)
  self.v_weapon_model_rt:set_model_visible(value)
end

function ui:response_refresh_equip_view(msg)
  if nil == msg then
    return
  end
  local equip_uuid = msg.mm_x
  local item_data = self.v_equip_list[equip_uuid]
  if item_data then
    local equip_info = item_data.equip_data
    local equip_ui = item_data.object
    self:refresh_equip_view(equip_info, equip_ui)
  end
end

function ui:ui_on_update()
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:update()
  end
end

return ui
