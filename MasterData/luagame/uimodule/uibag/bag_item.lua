local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BagCfg = require("uimodule.uibag.uibag_configs")
local TYPE_EQUIP = BagCfg.WEAPEN_IDX
local TYPE_ITEM = BagCfg.ITEM_IDX
local MAX_DURATION = BagCfg.MAX_ITEM_DURATION
local QUALITY_ICON_PREFIX = "UICommon/"
local ICON_PREFIX = {
  [TYPE_ITEM] = "Icon/Item/%s",
  [TYPE_EQUIP] = "Icon/Item/%s"
}
local TIME_UNIT = Config.TIME_UNIT
local TIMEUNIT2STR = {
  [TIME_UNIT.DAY] = "天",
  [TIME_UNIT.HOUR] = "小时",
  [TIME_UNIT.MINUTE] = "分钟"
}
local STAR_PATTERN = "Star%d_img"
local STAR_LIGHT_PATTERN = "Star%d_Light_img"

function ui:ui_finish_load()
  self.v_max_star_count = self.v_uiobjects.StarList.transform.childCount
end

function ui:ui_wrap(parent, gameobj)
  self = Base.ui_wrap(self, parent, gameobj)
  self.v_object:SetActive(true)
  return self
end

local EQUIP_COMPONENTS = {
  Choose_img = false,
  wear_layout_img = false,
  Lock_img = false,
  StarList_rect = true,
  ItemLvTag_img = true,
  RemainTimeTag_img = false,
  OverFlowTag_img = false,
  ItemNumTag_rect = false,
  ItemName_txt = false
}
local ITEM_COMPONENTS = {
  Choose_img = false,
  wear_layout_img = false,
  Lock_img = false,
  StarList_rect = false,
  ItemLvTag_img = false,
  RemainTimeTag_img = false,
  OverFlowTag_img = false,
  ItemNumTag_rect = true,
  ItemName_txt = true
}

local function _activate_elements(components, cfg)
  for name, acitive in pairs(cfg) do
    components[name].gameObject:SetActive(acitive)
  end
end

local InitHelper = {
  [TYPE_EQUIP] = function(self, components)
    _activate_elements(components, EQUIP_COMPONENTS)
    local data = self.v_data
    components.LvText_txt.text = data.lv
    components.Choose_img.gameObject:SetActive(data.selected)
    components.Lock_img.gameObject:SetActive(1 == data.lock)
    components.wear_layout_img.gameObject:SetActive(0 ~= data.owner)
    if 0 ~= data.owner then
      local path = UtilUI.get_hero_images(data.owner, 1)
      ResMgr:load_set_icon(components.hero_head_icon_img, path)
    end
    local max_break_lv = ShareRes.get_max_equip_break_lv(data.id)
    for i = 1, self.v_max_star_count do
      local star_obj = components[string.format(STAR_PATTERN, i)].gameObject
      if i <= max_break_lv then
        star_obj:SetActive(i <= max_break_lv)
        components[string.format(STAR_LIGHT_PATTERN, i)].gameObject:SetActive(i <= data.break_lv - 1)
      else
        star_obj:SetActive(false)
      end
    end
    self.v_uiobjects.AdvanceTag:SetActive(true)
    self.v_uicompents.AdvanceLv_txt.text = Util.format_str("同调{1}", Config.CommonDefine.ROME_NUM[self.v_data.advance])
    self.v_uiobjects.RedPoint:SetActive(false)
    self:set_button_listener(components.item_bg_btn, function()
      self:on_click_weapon()
    end)
    self:set_button_listener(components.bg_button_btn, function()
      self:on_click_weapon()
    end)
  end,
  [TYPE_ITEM] = function(self, components, bag_list_ui)
    _activate_elements(components, ITEM_COMPONENTS)
    local data = self.v_data
    local is_limit_time = data.end_time ~= nil and data.end_time > 0
    components.ItemNum_txt.text = data.count
    components.Choose_img.gameObject:SetActive(data.selected)
    components.RemainTimeTag_img.gameObject:SetActive(is_limit_time)
    components.consume_img.gameObject:SetActive(data.item_type == BagCfg.ITEM_TYPE.COMSUME)
    components.ItemName_txt.text = data.name
    if is_limit_time then
      local remain_time = data.end_time - Date.server_time()
      local num, time_unit = Util.sec2time(remain_time)
      if time_unit == TIME_UNIT.DAY and num >= 7 then
        components.Remain_Time_txt.text = Util.format_str(string.format("%d周", math.floor(num / 7)))
      else
        if 0 == num and time_unit == TIME_UNIT.MINUTE then
          num = 1
        end
        components.Remain_Time_txt.text = Util.format_str(string.format("%d%s", num, TIMEUNIT2STR[time_unit]))
      end
      components.RemainTimeTag_img.color = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))
    end
    self.v_uiobjects.RedPoint:SetActive(data.show_red)
    self.v_uiobjects.AdvanceTag:SetActive(false)
    self:set_button_listener(components.item_bg_btn, function()
      if data.show_red then
        BagMgr:close_item_not_tip(data.uuid)
        self.v_uiobjects.RedPoint:SetActive(false)
      end
      self:on_click_item()
    end)
    self:set_button_listener(components.bg_button_btn, function()
      if data.show_red then
        BagMgr:close_item_not_tip(data.uuid)
        self.v_uiobjects.RedPoint:SetActive(false)
      end
      self:on_click_item()
    end)
  end
}

function ui:on_click_weapon()
  if self.v_uibag:is_selecting_weapon() then
    local selected = self:get_is_selected()
    if not selected then
      local is_rich_max = self.v_uibag.bag_list:check_is_select_rich_max(true, TYPE_EQUIP)
      if is_rich_max then
        return
      end
    end
    self:on_item_selected(nil)
  else
    UIMgr:get_ui("char_weapon", true):ui_show(nil, nil, self.v_data.uuid, nil)
  end
end

function ui:on_click_item()
  if self.v_uibag:is_selecting_item() then
    local select_num = #self.v_uibag.bag_list:get_selected_list(TYPE_ITEM)
    local select_uuid_list = self.v_uibag.bag_list:get_selected_list(TYPE_ITEM)
    if select_num < 1 then
      self:on_item_selected(nil, TYPE_ITEM)
    elseif select_uuid_list[1] == self.v_data.uuid then
      self:on_item_selected(false, TYPE_ITEM)
    else
      self.v_uibag.bag_list:clear_select()
      self:on_item_selected(nil, TYPE_ITEM)
      self.v_uibag.bag_list:update_bag(nil, TYPE_ITEM, nil, true, true)
    end
  else
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = self.v_data.id,
      tips_type = Config.ITEM_TIPS_TYPE.BAG,
      create_time = self.v_data.create_time,
      item_uuid = self.v_data.uuid
    })
  end
end

function ui:set_data(data, idx, type, bag_list_ui)
  if nil == data then
    return
  end
  self.v_data = data
  self.v_idx = idx
  self.v_uibag = UIMgr:get_ui("uibag")
  local components = self.v_uicompents
  local icon_path = ShareRes.create("item.item_quality", data.quality).QualityIcon
  ResMgr:load_set_icon(components.item_bg_img, QUALITY_ICON_PREFIX .. icon_path)
  ResMgr:load_set_icon(components.Item_icon_img, string.format(ICON_PREFIX[type], data.icon))
  assert(InitHelper[type], "no such bag_item_type" .. type)
  InitHelper[type](self, components, bag_list_ui)
end

function ui:get_is_selected()
  local selected_img = self.v_uicompents.Choose_img
  local selected = selected_img.gameObject.activeInHierarchy
  return selected
end

function ui:on_item_selected(param)
  local selected_img = self.v_uicompents.Choose_img
  local selected = selected_img.gameObject.activeInHierarchy
  local next_select
  if nil == param then
    next_select = not selected
  else
    next_select = param
  end
  selected_img.gameObject:SetActive(next_select)
  self.v_data.selected = next_select
  MsgGame:mq_publish2(Const.MSG_BAG_ITEM_SELECT_CHANGE)
end

return ui
