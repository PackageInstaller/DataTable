local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local _tsort = table.sort
local _tremove = table.remove
local SUIT_TYPE_TEMP_KEY = "RELIC_SCREEN_SUIT_TYPE_TEMP_KEY"
local ATTR_TYPE_TEMP_KEY = "RELIC_SCREEN_ATTR_TYPE_TEMP_KEY"
local SORT_TYPE = {
  quality = 1,
  lv = 2,
  time = 3
}
local SORT_TYPE2_TOGGLE = {
  [SORT_TYPE.quality] = "v_quanilty",
  [SORT_TYPE.lv] = "v_level",
  [SORT_TYPE.time] = "v_time"
}
local MODEL = {
  v_attr_content = {
    "AttrContent",
    BIND_TYPE.OBJECT
  },
  v_attr_tem = {
    "AttrTem",
    BIND_TYPE.TOGGLE
  },
  v_btn_back = {
    "BtnBack",
    BIND_TYPE.BUTTON
  },
  v_btn_cancel = {
    "Btn_Cancel",
    BIND_TYPE.BUTTON
  },
  v_btn_close = {
    "Btn_Close",
    BIND_TYPE.BUTTON
  },
  v_btn_set_default = {
    "Btn_SetDefault",
    BIND_TYPE.BUTTON
  },
  v_btn_sure = {
    "Btn_Sure",
    BIND_TYPE.BUTTON
  },
  v_level = {
    "Level",
    BIND_TYPE.TOGGLE
  },
  v_quanilty = {
    "Quanilty",
    BIND_TYPE.TOGGLE
  },
  v_suit_content = {
    "SuitContent",
    BIND_TYPE.OBJECT
  },
  v_suit_tem = {
    "SuitTem",
    BIND_TYPE.TOGGLE
  },
  v_tag_list = {
    "TagList",
    BIND_TYPE.OBJECT
  },
  v_time = {
    "Time",
    BIND_TYPE.TOGGLE
  },
  v_tips_tag = {
    "TipsTag",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnBack", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Close", function()
    self:ui_hide()
  end)
  self:set_button("Btn_SetDefault", function()
    self:reset_data()
  end)
  self:set_button("Btn_Sure", function()
    self:try_save_data()
  end)
  self:register_exist_auto_template(SUIT_TYPE_TEMP_KEY, self.v_uiobjects.SuitTem, self.v_suit_content)
  self:register_exist_auto_template(ATTR_TYPE_TEMP_KEY, self.v_uiobjects.AttrTem, self.v_attr_content)
end

function ui:ui_on_show(slot_idx, exclude_uuid, need_quality)
  self.v_slot_idx = slot_idx
  self.v_exclude_uuid = exclude_uuid
  self.v_need_quality = need_quality
  self:init_sort_list()
  self:init_suit_list()
  self:init_attr_list()
  self:refresh_tog_by_mgr_data()
  self.v_uicompents.TagList_rect:SetLocalPositionA(0, 0, 0)
end

function ui:init_sort_list()
  for sort_type, tog_name in ipairs(SORT_TYPE2_TOGGLE) do
    self:set_toggle_listener(self[tog_name], function(is_on)
      if not is_on then
        return
      end
      self.v_new_sort_type = sort_type
    end)
  end
end

function ui:init_suit_list()
  local suit_cfg = ShareRes.create("relic.relic_suit")
  self.v_suit_list = {}
  for _, cfg in pairs(suit_cfg) do
    _tinsert(self.v_suit_list, {cfg = cfg})
  end
  _tsort(self.v_suit_list, function(a, b)
    return a.cfg.Id < b.cfg.Id
  end)
  self:give_back_auto_cache(SUIT_TYPE_TEMP_KEY)
  for _, data in ipairs(self.v_suit_list) do
    local cfg = data.cfg
    local item = self:get_auto_cache(SUIT_TYPE_TEMP_KEY)
    local txt = Util.get_text("Label", item)
    local txt2 = Util.get_text("Checkmark/Label", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    txt.text = cfg.Name
    txt2.text = cfg.Name
    data.tog = tog
  end
end

function ui:init_attr_list()
  local relic_entry_cfg = ShareRes.create("relic.relic_entry")
  local attr_id_map = {}
  self.v_attr_list = {}
  for _, cfg in pairs(relic_entry_cfg) do
    local attr_id = cfg.AttrId
    if not attr_id_map[attr_id] then
      attr_id_map[attr_id] = true
      _tinsert(self.v_attr_list, {attr_id = attr_id})
    end
  end
  _tsort(self.v_attr_list, function(a, b)
    return a.attr_id < b.attr_id
  end)
  self:give_back_auto_cache(ATTR_TYPE_TEMP_KEY)
  for _, data in ipairs(self.v_attr_list) do
    local attr_id = data.attr_id
    local item = self:get_auto_cache(ATTR_TYPE_TEMP_KEY)
    local txt = Util.get_text("Label", item)
    local txt2 = Util.get_text("Checkmark/Label", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    txt.text = ShareRes.get_attr_name(attr_id)
    txt2.text = ShareRes.get_attr_name(attr_id)
    data.tog = tog
    local icon = Util.get_image("Icon", item)
    local icon_name = ShareRes.get_attr_icon(attr_id)
    if icon_name then
      Util.load_attr_icon(icon, icon_name)
    end
  end
end

function ui:refresh_tog_by_mgr_data()
  self.v_new_sort_type = RelicMgr.v_sort_type or SORT_TYPE.quality
  self[SORT_TYPE2_TOGGLE[self.v_new_sort_type]].isOn = true
  self.v_new_filter_suit = RelicMgr.v_filter_suit
  for _, data in ipairs(self.v_suit_list) do
    local is_on = false
    local suit_id = data.cfg.Id
    if self.v_new_filter_suit and self.v_new_filter_suit[suit_id] then
      is_on = true
    end
    data.tog.isOn = is_on
  end
  self.v_new_filter_attr = RelicMgr.v_filter_attr
  for _, data in ipairs(self.v_attr_list) do
    local is_on = false
    local attr_id = data.attr_id
    if self.v_new_filter_attr and self.v_new_filter_attr[attr_id] then
      is_on = true
    end
    data.tog.isOn = is_on
  end
end

function ui:reset_data()
  self.v_new_sort_type = SORT_TYPE.quality
  self[SORT_TYPE2_TOGGLE[self.v_new_sort_type]].isOn = true
  self.v_new_filter_suit = nil
  for _, data in ipairs(self.v_suit_list) do
    data.tog.isOn = false
  end
  self.v_new_filter_attr = nil
  for _, data in ipairs(self.v_attr_list) do
    data.tog.isOn = false
  end
end

function ui:load_data()
  self.v_new_filter_suit = nil
  for _, data in ipairs(self.v_suit_list) do
    local suit_id = data.cfg.Id
    if data.tog.isOn then
      if not self.v_new_filter_suit then
        self.v_new_filter_suit = {}
      end
      self.v_new_filter_suit[suit_id] = true
    end
  end
  self.v_new_filter_attr = nil
  for _, data in ipairs(self.v_attr_list) do
    local attr_id = data.attr_id
    if data.tog.isOn then
      if not self.v_new_filter_attr then
        self.v_new_filter_attr = {}
      end
      self.v_new_filter_attr[attr_id] = true
    end
  end
end

function ui:try_save_data()
  self:load_data()
  if not RelicMgr:check_filter_suc(false, self.v_exclude_uuid, self.v_slot_idx, self.v_new_filter_suit, self.v_new_filter_attr, self.v_need_quality) then
    Util.show_message_tip(2259)
    return
  end
  RelicMgr.v_sort_type = self.v_new_sort_type or SORT_TYPE.quality
  RelicMgr.v_filter_suit = self.v_new_filter_suit
  RelicMgr.v_filter_attr = self.v_new_filter_attr
  MsgGame:mq_publish2(Const.MSG_ON_RELIC_FILTER_UPDATE)
  self:ui_hide()
end

function ui:ui_on_hide()
end

return ui
