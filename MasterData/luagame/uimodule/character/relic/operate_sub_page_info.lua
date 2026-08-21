local Base = require("ui.uiobject")
local CommonDefine = require("cs_share.common_define")
local RELIC_ENTRY_TYPE = CommonDefine.RELIC_ENTRY_TYPE
local _tinsert = table.insert
local _tsort = table.sort
local RELIC_OPERATE_INFO_ATTR_KEY = "RELIC_OPERATE_INFO_ATTR_KEY"
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_attr_content = {
    "AttrContent",
    BIND_TYPE.OBJECT
  },
  v_attr_temp = {
    "AttrTemp",
    BIND_TYPE.OBJECT
  },
  v_btn_enhance = {
    "BtnEnhance",
    BIND_TYPE.BUTTON
  },
  v_btn_remove = {
    "BtnRemove",
    BIND_TYPE.BUTTON
  },
  v_btn_replace = {
    "BtnReplace",
    BIND_TYPE.BUTTON
  },
  v_btn_roll_attr_red = {
    "BtnRollAttrRed",
    BIND_TYPE.IMAGE
  },
  v_btn_roll_attr = {
    "BtnRollAttr",
    BIND_TYPE.BUTTON
  },
  v_engrave_name = {
    "EngraveName",
    BIND_TYPE.TEXT
  },
  v_enhance_max = {
    "EnhanceMax",
    BIND_TYPE.IMAGE
  },
  v_lock_icon = {
    "LockIcon",
    BIND_TYPE.IMAGE
  },
  v_lock = {
    "Lock",
    BIND_TYPE.BUTTON
  },
  v_red_replace = {
    "RedReplace",
    BIND_TYPE.IMAGE
  },
  v_suit_group = {
    "SuitGroup",
    BIND_TYPE.OBJECT
  },
  v_unlock_icon = {
    "UnlockIcon",
    BIND_TYPE.IMAGE
  },
  vquality = {
    "quality",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnEnhance", function()
    self.v_parent_ui:switch_page(true)
  end)
  self:set_button("BtnRemove", function()
    RelicMgr:req_take_off_relic(self.v_uuid)
  end)
  self:set_button("BtnReplace", function()
    local function confirm_cb()
      RelicMgr:req_wear_relic(self.v_uuid, self.v_buddy_id)
    end
    
    local owner_id = self.v_relic_data.buddy_id or 0
    if 0 ~= owner_id then
      Util.show_notify_popup_message(confirm_cb, "已被其他角色装备，是否替换？")
    else
      confirm_cb()
    end
  end)
  self:set_button("BtnRollAttr", function()
    if not self.v_can_go_refine then
      Util.show_message_tip(2262)
      return
    end
    UIMgr:get_ui("relic_refine_panel"):ui_show(self.v_uuid)
  end)
  self:set_button("Lock", function()
    local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_uuid)
    if 1 ~= relic_data.lock then
      RelicMgr:req_lock_relic(self.v_uuid, function()
        self:update_lock_state(true)
      end)
    else
      RelicMgr:req_unlock_relic(self.v_uuid, function()
        self:update_lock_state(false)
      end)
    end
  end)
  self.v_uiobjects.RedReplace:SetActive(false)
  self:register_exist_auto_template(RELIC_OPERATE_INFO_ATTR_KEY, self.v_attr_temp, self.v_attr_content)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:ui_on_show()
end

function ui:refresh(operate_relic_uuid, operate_buddy_id, is_bag)
  self.v_uuid = operate_relic_uuid
  self.v_buddy_id = operate_buddy_id
  self.v_is_bag = is_bag
  self:refresh_view()
end

function ui:refresh_view()
  self.v_relic_data = RelicMgr:get_relic_data_by_uuid(self.v_uuid)
  self.v_relic_cfg = ShareRes.get_relic_cfg(self.v_relic_data.id)
  local quality_cfg = ShareRes.get_equip_icon_cfg(self.v_relic_cfg.Quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  ResMgr:load_set_icon(self.vquality, path)
  self.v_engrave_name.text = self.v_relic_cfg.Name
  self.v_uiobjects.BtnRollAttrRed:SetActive(RelicMgr:check_new_entry_by_uuid(self.v_uuid))
  local is_lock = 1 == self.v_relic_data.lock
  self:update_lock_state(is_lock)
  self:refresh_attr_list()
  self:refresh_suit_info()
  self:refresh_btns()
end

function ui:update_lock_state(is_lock)
  self.v_uiobjects.UnlockIcon:SetActive(not is_lock)
  self.v_uiobjects.LockIcon:SetActive(is_lock)
end

function ui:refresh_attr_list()
  local can_go_refine = false
  local attr_list = {}
  for _, entry in ipairs(self.v_relic_data.entrys) do
    local relic_entry_cfg = ShareRes.create("relic.relic_entry", entry.entry_id)
    local attr_id, val = relic_entry_cfg.AttrId, relic_entry_cfg.BaseAttr
    assert(attr_id, "attr_id为空，词条id：" .. entry.entry_id)
    if entry.type == RELIC_ENTRY_TYPE.PRINCIPAL then
      val = val + self.v_relic_data.lv * relic_entry_cfg.LevelAttr
    else
      can_go_refine = true
    end
    _tinsert(attr_list, {
      attr_id = attr_id,
      val = val,
      type = entry.type,
      idx = entry.id
    })
  end
  _tsort(attr_list, function(a, b)
    if a.type ~= b.type then
      return a.type < b.type
    end
    return a.idx < b.idx
  end)
  self:give_back_auto_cache(RELIC_OPERATE_INFO_ATTR_KEY)
  for _, attr_data in ipairs(attr_list) do
    local attr_id = attr_data.attr_id
    local val = attr_data.val
    local item = self:get_auto_cache(RELIC_OPERATE_INFO_ATTR_KEY)
    local main_attr_bg = Util.get_child_gameobj("MainAttrBg", item)
    local icon = Util.get_image("AttrIcon", item)
    local name_txt = Util.get_text("AttrName", item)
    local val_txt = Util.get_text("AttrVal", item)
    main_attr_bg:SetActive(attr_data.type == RELIC_ENTRY_TYPE.PRINCIPAL)
    local icon_name = ShareRes.get_attr_icon(attr_id)
    if icon_name then
      Util.load_attr_icon(icon, icon_name)
    end
    local icon_color = attr_data.type == RELIC_ENTRY_TYPE.PRINCIPAL and "ffda9d" or "b19f89"
    icon.color = Util.get_unity_color_by_hex(tonumber(icon_color, 16))
    local color = attr_data.type == RELIC_ENTRY_TYPE.PRINCIPAL and "ffda9d" or "ffffff"
    name_txt.text = string.format("<color=#%s>%s</color>", color, ShareRes.get_attr_name(attr_id))
    local is_ration = ShareRes.get_is_ration_attr(attr_id)
    local val_str = is_ration and string.format("%.2f%%", val / 100) or Util.round(val)
    val_txt.text = string.format("<color=#%s>%s</color>", color, val_str)
  end
  self.v_can_go_refine = can_go_refine
  Util.apply_grey_ex(self.v_uiobjects.BtnRollAttr, not can_go_refine)
end

function ui:refresh_suit_info()
  local suit_id = self.v_relic_cfg.SuitId
  local suit_cfg = ShareRes.create("relic.relic_suit", suit_id)
  self.v_suit_active_count = RelicMgr:get_suit_active_count_ex(suit_id, self.v_buddy_id)
  local suit_name = Util.get_text("SuitName/SuitName_", self.v_suit_group)
  if self.v_is_bag then
    suit_name.text = Util.format_str("{1}", suit_cfg.Name)
  else
    suit_name.text = Util.format_str("{1}({2})", suit_cfg.Name, self.v_suit_active_count)
  end
  local suit_sub_cfg_list = {}
  for _, data in pairs(suit_cfg.Suit) do
    _tinsert(suit_sub_cfg_list, data)
  end
  _tsort(suit_sub_cfg_list, function(a, b)
    return a.Count < b.Count
  end)
  for idx, data in ipairs(suit_sub_cfg_list) do
    self:set_suit_desc_obj(idx, data)
  end
end

function ui:set_suit_desc_obj(idx, suit_sub_cfg)
  local suit_obj = Util.get_child_gameobj("SuitEffect" .. idx, self.v_suit_group)
  local need_num = suit_sub_cfg.Count
  suit_obj:SetActive(nil ~= suit_sub_cfg)
  local suit_desc = Util.get_text(nil, suit_obj)
  suit_desc.text = Util.format_str("{1}件套：{2}", need_num, suit_sub_cfg.Desc)
  local is_actiive = need_num <= self.v_suit_active_count
  local canvas_group = Util.get_canvas_group(nil, suit_obj)
  local act_obj = Util.get_child_gameobj("SuitState/Active", suit_obj)
  local not_act_obj = Util.get_child_gameobj("SuitState/NoActive", suit_obj)
  canvas_group.alpha = (is_actiive or self.v_is_bag) and 1 or 0.3
  act_obj:SetActive(is_actiive and not self.v_is_bag)
  not_act_obj:SetActive(not is_actiive and not self.v_is_bag)
end

function ui:refresh_btns()
  local buddy_id = self.v_relic_data.buddy_id or 0
  local is_self_wear = self.v_buddy_id == buddy_id
  self.v_uiobjects.BtnReplace:SetActive(not is_self_wear and not self.v_is_bag)
  self.v_uiobjects.BtnRemove:SetActive(is_self_wear and not self.v_is_bag)
  local relic_max_lv = ShareRes.get_relic_max_lv(self.v_relic_data.id)
  local is_max = relic_max_lv <= self.v_relic_data.lv
  self.v_uiobjects.BtnEnhance:SetActive(not is_max)
  self.v_uiobjects.EnhanceMax:SetActive(is_max)
end

return ui
