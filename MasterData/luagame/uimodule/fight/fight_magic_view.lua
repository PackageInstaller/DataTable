local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local MagicDefine = require("cs_share.magic_def")
local FightDefine = require("cs_share.fight_define")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_tips_view = {
    "Magic_Tips",
    BIND_TYPE.OBJECT
  },
  v_tips_content = {
    "Maigc_Desc",
    BIND_TYPE.TEXT
  }
}
local KIND_STR = {
  [1] = Util.format_str("增加"),
  [2] = Util.format_str("减少")
}
local UPDATE_INTERVAL = 1
local PAGE_ITEM_COUNT = 7
local PER_ITEM_WIDTH = 68
local TWEEN_EASE_OUT_EXPO = CS.DG.Tweening.Ease.OutExpo

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Magic_Tips", function()
    self.v_tips_view:SetActive(false)
  end)
  self.v_template_key = {
    magic_item = "magic_item_" .. self.v_object.name
  }
  self.v_scroll = self.v_uiobjects.ScrollView:GetComponent(typeof(CS.Game.ScrollRectEx))
  
  local function start_cb(offset)
    self:_on_start_drag(offset)
  end
  
  local function end_cb(offset)
    self:_on_end_drag(offset)
  end
  
  local function change_cb(offset)
    self:_on_change_cb(offset)
  end
  
  self:set_scrollrect_ex_listener(self.v_scroll, start_cb, nil, end_cb)
  self.v_content_rect = self:get_rect_transform(nil, self.v_uiobjects.Content)
  self:register_exist_auto_template(self.v_template_key.magic_item, self.v_uiobjects.Magic_Item, self.v_uiobjects.Content)
end

function ui:ui_on_show(...)
  self.v_cur_idx = 0
  self.v_delta_time = 0
  self.v_magic_change = false
  self.v_cur_page = 1
  self.v_total_pages = 0
  self:_refresh_magic_list()
  self:_regist_client_event()
end

function ui:ui_on_update(delta_time)
  self.v_delta_time = self.v_delta_time + delta_time
  if self.v_delta_time > UPDATE_INTERVAL then
    if self.v_magic_change == true then
      self.v_tips_view:SetActive(false)
      self:_refresh_magic_list()
      self.v_magic_change = false
    end
    self.v_delta_time = self.v_delta_time - UPDATE_INTERVAL
  end
end

function ui:ui_on_hide()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ADD_MAGIC, self._on_add_magic_event, self)
  self:bind_auto_mq(Const.MSG_REMOVE_MAGIC, self._on_remove_magic_event, self)
end

function ui:_on_add_magic_event()
  self.v_magic_change = true
end

function ui:_on_remove_magic_event()
  self.v_magic_change = true
end

function ui:_refresh_magic_list()
  if not Global.hero then
    return
  end
  local map = Global.hero.magic_mgr:get_magic_map()
  local tb = {}
  local attr_tb = {}
  for magic_id, magic_map in pairs(map) do
    local _, one = next(magic_map)
    if not (one and one.cfg.AffixId) or one.cfg.AffixId == "" then
    elseif one.is_mark_remove == false and one.magic_type ~= MagicDefine.MAGIC_TYPE.ChangeAttribAdditive then
      table.insert(tb, {
        magic_id = magic_id,
        cfg = one.cfg,
        sort_id = 2
      })
    else
      for _, magic in pairs(magic_map) do
        if magic.is_mark_remove == false and magic.cfg.AffixGroup then
          local attr_id = magic.cfg[1]
          if not attr_tb[magic.cfg.AffixGroup] then
            attr_tb[magic.cfg.AffixGroup] = {}
            table.insert(tb, {
              magic_id = magic_id,
              cfg = magic.cfg,
              sort_id = 1,
              attr_id = attr_id,
              attr_list = attr_tb[magic.cfg.AffixGroup]
            })
          end
          local attr_list = attr_tb[magic.cfg.AffixGroup]
          if not attr_list[attr_id] then
            attr_list[attr_id] = FightDefine.init_single_attr()
          end
          local lv = 0 == magic.magic_level and 1 or magic.magic_level
          if 1 == magic.cfg[3] then
            attr_list[attr_id].FIXED = attr_list[attr_id].FIXED + magic.cfg[2][lv]
          elseif 2 == magic.cfg[3] then
            attr_list[attr_id].RATIO = attr_list[attr_id].RATIO + magic.cfg[2][lv]
          end
        end
      end
    end
  end
  table.sort(tb, function(a, b)
    if a.sort_id == b.sort_id then
      local group_a = a.cfg.AffixGroup
      local group_b = b.cfg.AffixGroup
      if group_a and group_b then
        return group_a < group_b
      else
        return a.magic_id < b.magic_id
      end
    else
      return a.sort_id < b.sort_id
    end
  end)
  self.v_magic_list = tb
  self.v_data_length = #tb
  self.v_total_pages = math.ceil(#tb / PAGE_ITEM_COUNT)
  self:give_back_auto_cache(self.v_template_key.magic_item, false)
  for i, v in ipairs(tb) do
    local obj = self:get_auto_cache(self.v_template_key.magic_item)
    v.obj = obj
    self:_set_magic_item(obj, i)
  end
end

function ui:_set_magic_item(item, idx)
  local data = self.v_magic_list[idx]
  local icon = self:get_image("Icon", item)
  local path = string.format("UIFight/BuffIcon/%s", data.cfg.AffixId)
  ResMgr:load_set_icon(icon, path)
  local tog = self:get_toggle(nil, item)
  self:set_toggle_listener(tog, function(isOn)
    self:_on_click_tog(isOn, idx)
  end)
end

function ui:_on_click_tog(isOn, idx)
  if not isOn then
    return
  end
  self.v_cur_idx = idx
  self:_show_magic_tips()
end

function ui:_show_magic_tips()
  self.v_tips_view:SetActive(true)
  local data = self.v_magic_list[self.v_cur_idx]
  if data.cfg.type == MagicDefine.MAGIC_TYPE.ChangeAttribAdditive then
    self.v_tips_content.text = self:_get_attrs(data.attr_list, data.cfg.AffixGroup)
  elseif data.cfg.SkillDesc and data.cfg.SkillDesc ~= "" then
    self.v_tips_content.text = data.cfg.SkillDesc
  else
    self.v_tips_view:SetActive(false)
  end
end

function ui:_get_attrs(attr_list, AffixGroup)
  local str = ""
  for attr_id, v in pairs(attr_list) do
    if "" == str then
      str = self:_formate_attr(attr_id, v, AffixGroup)
    else
      str = str .. "\n" .. self:_formate_attr(attr_id, v, AffixGroup)
    end
  end
  return str
end

function ui:_formate_attr(attr_id, attr, kind)
  if not KIND_STR[kind] then
    return
  end
  local str
  if 0 == attr.RATIO and math.abs(attr.FIXED) > 0 then
    str = string.format("%s:%s（%d）", ShareRes.equip_attr_str(attr_id), KIND_STR[kind], math.abs(attr.FIXED))
  elseif math.abs(attr.RATIO) > 0 and 0 == attr.FIXED then
    str = string.format("%s:%s（%d%%）", ShareRes.equip_attr_str(attr_id), KIND_STR[kind], math.abs(attr.RATIO / 100))
  else
    str = string.format("%s:%s（%d%% + %d）", ShareRes.equip_attr_str(attr_id), KIND_STR[kind], math.abs(attr.RATIO / 100), math.abs(attr.FIXED))
  end
  return str
end

function ui:_on_start_drag(offset)
  self.v_start_pos = offset.x
end

function ui:_on_end_drag(offset)
  if math.abs(offset.x - self.v_start_pos) < 1 / self.v_data_length then
    return
  end
  local can_scroll = false
  local is_right = offset.x > self.v_start_pos
  if is_right and self.v_cur_page < self.v_total_pages then
    self.v_cur_page = self.v_cur_page + 1
    can_scroll = true
  elseif not is_right and self.v_cur_page > 1 then
    self.v_cur_page = self.v_cur_page - 1
    can_scroll = true
  end
  if not can_scroll then
    return
  end
  local pass_num = 0
  if self.v_cur_page < self.v_total_pages then
    pass_num = PAGE_ITEM_COUNT * (self.v_cur_page - 1)
  else
    pass_num = self.v_data_length - PAGE_ITEM_COUNT
  end
  self.v_scroll.enabled = false
  local sequence = Util.create_sequence()
  sequence:Append(self.v_content_rect:DOAnchorPosX(pass_num * -PER_ITEM_WIDTH, 0.2):SetEase(TWEEN_EASE_OUT_EXPO))
  sequence:OnComplete(function()
    self.v_scroll.enabled = true
    sequence:Kill(false)
    sequence = nil
  end)
end

return ui
