local FightDefine = require("cs_share.fight_define")
local Base = require("ui.uibase")
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
  v_char_icon = {
    "CharIcon",
    BIND_TYPE.IMAGE
  },
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_desc = {
    "Desc",
    BIND_TYPE.TEXT
  },
  v_name = {
    "Name",
    BIND_TYPE.TEXT
  },
  v_no_skill = {
    "NoSkill",
    BIND_TYPE.OBJECT
  },
  v_quality_bg = {
    "QualityBg",
    BIND_TYPE.IMAGE
  },
  v_quality = {
    "Quality",
    BIND_TYPE.IMAGE
  },
  v_skill_detail = {
    "SkillDetail",
    BIND_TYPE.OBJECT
  },
  v_tips = {
    "Tips",
    BIND_TYPE.TEXT
  },
  v_weapon_icon = {
    "WeaponIcon",
    BIND_TYPE.IMAGE
  }
}
local DRAWCARD_SELECT_ITEM_TEMP_KEY = "DRAWCARD_SELECT_ITEM_TEMP_KEY"
local DRAWCARD_SELECT_ITEM_ATTR_TEMP_KEY = "DRAWCARD_SELECT_ITEM_ATTR_TEMP_KEY"
local TogColor_Off = Util.get_unity_color_by_hex(tonumber("ae9577", 16))
local TogColor_On = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnChoose", function()
    self:on_choose()
  end)
  self:set_toggle("TogOnlyOwn", function(isOn)
    self.v_uicompents.TxtOnlyOwn_txt.color = isOn and TogColor_On or TogColor_Off
    if self.v_init_done then
      self:set_list()
    end
  end)
  self:register_exist_auto_template(DRAWCARD_SELECT_ITEM_TEMP_KEY, self.v_uiobjects.Item_template, self.v_content)
  self:register_exist_auto_template(DRAWCARD_SELECT_ITEM_ATTR_TEMP_KEY, self.v_attr_temp, self.v_attr_content)
  self.v_tog_group = self:get_toggle_group(nil, self.v_content)
end

function ui:on_choose()
  local function confirm_cb()
    DrawCardMgr:send_draw_choose_id(self.v_group_id, self.v_pool_id, self.v_new_choose_id, function()
      self:ui_hide()
    end)
  end
  
  local is_max = CharacterMgr:is_equip_advance_max(self.v_new_choose_equip_id)
  if is_max then
    Util.show_notify_popup_message(confirm_cb, "该武器已经可以达到最高同调等级，是否继续选择")
  else
    confirm_cb()
  end
end

function ui:ui_on_show(pool_id)
  self.v_init_done = false
  if self.v_uicompents.TogOnlyOwn_tog then
    self.v_uicompents.TogOnlyOwn_tog.isOn = false
  end
  self.v_uicompents.Content_rect:SetLocalPositionA(0, 0, 0)
  self.v_pool_config = ShareRes.get_drawcard_pool(pool_id)
  if 4 ~= self.v_pool_config.Type then
    return
  end
  self.v_pool_id = pool_id
  self.v_group_id = self.v_pool_config.Group
  if self:check_pool_status(true) then
    return
  end
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  self.v_choose_id = pool_vo.choose_id
  self.v_new_choose_id = self.v_choose_id
  self:set_tips()
  self:set_list()
  self.v_init_done = true
  self:bind_auto_mq(Const.MSG_DRAW_GROUP_LIST_UPDATE, self.check_pool_status, self)
end

function ui:check_pool_status(force_hide)
  force_hide = true == force_hide
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if not pool_vo then
    local confirmCb
    if not force_hide then
      function confirmCb()
        self:ui_hide()
      end
    end
    NextFrameMgr:add_next_update(function()
      if force_hide then
        self:ui_hide()
      end
      Util.show_notify_popup_message(confirmCb, "活动已结束", nil, "确定", nil, nil, true)
    end)
    return true
  end
end

function ui:ui_on_hide()
  self.v_init_done = false
end

function ui:ui_on_destroy()
end

function ui:set_tips()
  local tips = self.v_pool_config.MoreTips
  self.v_tips.gameObject:SetActiveEx(nil ~= tips)
  if tips then
    self.v_tips.text = tips
  end
end

function ui:set_list()
  local choose_group_cfg = ShareRes.create("draw.draw_pool_choose_group")
  self.v_data_list = {}
  local args = self.v_pool_config.Arg
  for _, group in pairs(args) do
    if 0 ~= group then
      for _, cfg in ipairs(choose_group_cfg) do
        if group == cfg.Group then
          local begin_time = cfg.BeginTime and Date.get_time_stamp_by_scheme_id(cfg.BeginTime)
          if not begin_time or begin_time < Date.server_time() then
            self.v_data_list[#self.v_data_list + 1] = cfg
          end
        end
      end
    end
  end
  table.sort(self.v_data_list, function(a, b)
    if a.Order ~= b.Order then
      return a.Order > b.Order
    end
    return a.Id < b.Id
  end)
  local only_own = self.v_uicompents.TogOnlyOwn_tog.isOn
  self.v_tog_group.allowSwitchOff = true
  local init_on_tog_idx = 1
  local idx = 0
  self.v_tog_list = {}
  self:give_back_auto_cache(DRAWCARD_SELECT_ITEM_TEMP_KEY, false)
  for _, cfg in ipairs(self.v_data_list) do
    local buddy_id = cfg.BuddyId
    if only_own and not CharacterMgr:get_buddy_by_id(buddy_id) then
    else
      idx = idx + 1
      local item_id = cfg.ItemId
      local item = self:get_auto_cache(DRAWCARD_SELECT_ITEM_TEMP_KEY)
      local new_tag = Util.get_child_gameobj("NewTag_", item)
      if new_tag then
        local begin_time = cfg.BeginTime and Date.get_time_stamp_by_scheme_id(cfg.BeginTime)
        new_tag:SetActive(DrawCardMgr:check_selectable_item_new(item_id, begin_time))
      end
      local tog = Util.get_toggle(nil, item)
      table.insert(self.v_tog_list, tog)
      self:set_toggle_listener(tog, function(is_on)
        if is_on then
          self.v_new_choose_id = cfg.Id
          self.v_new_choose_equip_id = cfg.ItemId
          self:set_info(cfg.Id)
          local begin_time = cfg.BeginTime and Date.get_time_stamp_by_scheme_id(cfg.BeginTime)
          DrawCardMgr:clear_selectable_item_new(item_id, begin_time)
          if new_tag then
            new_tag:SetActive(false)
          end
        end
      end, false)
      local now_tag = Util.get_child_gameobj("NowTag_", item)
      now_tag:SetActive(self.v_choose_id == cfg.Id)
      if self.v_choose_id == cfg.Id then
        init_on_tog_idx = idx
      end
      local head_icon = Util.get_image("FitChar/CharBg/Mask/CharIcon_", item)
      ResMgr:load_set_icon(head_icon, CharacterMgr:get_buddy_icon_path(buddy_id))
      local item_name = Util.get_text("ItemName_", item)
      local item_cfg = UtilUI.get_item_cfg(item_id)
      item_name.text = item_cfg.Name
      local item_icon = Util.get_image("Item_icon_", item)
      local quality_bg = Util.get_image("item_bg_", item)
      local icon_path, quality_path = UtilUI.get_item_images(item_id)
      ResMgr:load_set_icon(item_icon, icon_path)
      ResMgr:load_set_icon(quality_bg, quality_path)
    end
  end
  self.v_tog_list[init_on_tog_idx].isOn = true
  self.v_tog_group.allowSwitchOff = false
end

function ui:set_info(choose_id)
  local choose_cfg = ShareRes.create("draw.draw_pool_choose_group", choose_id)
  local item_id = choose_cfg.ItemId
  local buddy_id = choose_cfg.BuddyId
  local icon_path, quality_path = UtilUI.get_item_images(item_id)
  ResMgr:load_set_icon(self.v_weapon_icon, icon_path)
  ResMgr:load_set_icon(self.v_quality_bg, quality_path)
  local item_cfg = UtilUI.get_item_cfg(item_id)
  self.v_name.text = item_cfg.Name
  local quality_cfg = ShareRes.get_equip_icon_cfg(item_cfg.Quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  ResMgr:load_set_icon(self.v_quality, path)
  ResMgr:load_set_icon(self.v_char_icon, CharacterMgr:get_buddy_icon_path(buddy_id))
  self.v_uicompents.FitName_txt.text = ShareRes.get_buddy_name(buddy_id)
  self:refresh_attr_list(item_id)
  self:refresh_cur_skill(item_id)
end

function ui:refresh_attr_list(equip_id)
  self:give_back_auto_cache(DRAWCARD_SELECT_ITEM_ATTR_TEMP_KEY)
  local attrs = CharacterMgr.cal_equip_attr(equip_id, 1, 1)
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local attr_key_list = {}
  for i, v in ipairs(equip_cfg.BaseAttrList) do
    local attr_cfg = ShareRes.get_buddy_attr_cfg(v)
    attr_key_list[#attr_key_list + 1] = attr_cfg.Name
  end
  if 0 == #attr_key_list then
    attr_key_list = {"hp", "attack"}
  end
  for index, attr_key in ipairs(attr_key_list) do
    local attr_value = attrs[attr_key] or 0
    local attr_ui = self:get_auto_cache(DRAWCARD_SELECT_ITEM_ATTR_TEMP_KEY)
    self:update_attr_item(attr_ui, attr_key, attr_value)
  end
end

function ui:update_attr_item(attr_ui, attr_key, attr_value)
  local attr_id = FightDefine.CONFIG_NAME_ATTR_ID[attr_key]
  local attr_cfg = ShareRes.get_buddy_attr_cfg(attr_id)
  assert(attr_cfg, "ATTR_CFG NULL = " .. attr_id)
  local attr_name_txt = Util.get_text("AttrName", attr_ui)
  local attr_name = ShareRes.get_buddy_attr_name(attr_id)
  attr_name_txt.text = attr_name
  local attr_icon = Util.get_image("AttrIcon", attr_ui)
  Util.load_attr_icon(attr_icon, attr_cfg.IconName)
  local is_ration = ShareRes.get_is_ration_attr(attr_id)
  local attr_val_txt = Util.get_text("AttrVal", attr_ui)
  attr_val_txt.text = Util.format_number(attr_value, is_ration)
end

local desc_format_str = [[
<color=#D56D2E>+%s %s</color>
%s]]
local desc_format_str_percent = [[
<color=#D56D2E>+%s%% %s</color>
%s]]

function ui:refresh_cur_skill(equip_id)
  local advance_lv = 1
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  local skill_id = advance_cfg[advance_lv].SkillId
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  local no_skill = nil == skill_cfg or skill_cfg.Name == ""
  local no_attr = 0 == skill_cfg.AttrId or 0 == skill_cfg.AttrValue
  if no_skill and no_attr then
    self.v_uiobjects.SkillName:SetActive(false)
    self.v_uiobjects.Desc:SetActive(false)
    self.v_uiobjects.NoSkill:SetActive(true)
    return
  end
  local skill_now_level = skill_cfg.Lv
  self.v_uiobjects.Desc:SetActive(true)
  self.v_uiobjects.NoSkill:SetActive(false)
  self.v_uiobjects.SkillName:SetActive(true)
  self.v_uicompents.SkillName_txt.text = skill_cfg.Name
  self.v_uicompents.SkillLvNum_txt.text = Util.format_str("Lv.{1}", skill_now_level)
  if not no_attr then
    local attribute_name = ShareRes.get_attr_name(skill_cfg.AttrId)
    local attribute_isratio = ShareRes.get_is_ration_attr(skill_cfg.AttrId)
    local isratio = attribute_isratio or 1 == skill_cfg.AttrType
    local value = isratio and skill_cfg.AttrValue / 100 or skill_cfg.AttrValue
    local format_key = isratio and desc_format_str_percent or desc_format_str
    self.v_uicompents.Desc_txt.text = string.format(format_key, value, attribute_name, skill_cfg.Desc)
  else
    self.v_uicompents.Desc_txt.text = skill_cfg.Desc
  end
end

return ui
