local Base = require("ui.uibase")
local LoopListClass = require("ui.widget.infinite_loop_list")
local RelicItemClass = require("uimodule.character.relic.relic_operate_item")
local _tinsert = table.insert
local _tsort = table.sort
local _tremove = table.remove
local RELIC_REFINE_ENTRY_TEMP_KEY = "RELIC_REFINE_ENTRY_TEMP_KEY"
local RELIC_REFINE_INFO_ATTR_KEY = "RELIC_REFINE_INFO_ATTR_KEY"
local CommonDefine = require("cs_share.common_define")
local RELIC_ENTRY_TYPE = CommonDefine.RELIC_ENTRY_TYPE
local Shop_Helper = require("uimodule.shop.shop_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local COIN_ITEMID = Config.COIN_ITEMID
local Timer = Global.timer
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local TypeCSPlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
local MODEL = {
  v_asset_bar = {
    "AssetBar",
    BIND_TYPE.OBJECT
  },
  v_attr_content = {
    "AttrContent",
    BIND_TYPE.OBJECT
  },
  v_attr_select_root = {
    "AttrSelectRoot",
    BIND_TYPE.OBJECT
  },
  v_attr_temp = {
    "AttrTemp",
    BIND_TYPE.OBJECT
  },
  v_btn_confirm_red = {
    "BtnConfirmRed",
    BIND_TYPE.IMAGE
  },
  v_btn_confirm = {
    "BtnConfirm",
    BIND_TYPE.BUTTON
  },
  v_btn_cost_engrave_detail = {
    "BtnCostEngraveDetail",
    BIND_TYPE.BUTTON
  },
  v_btn_main = {
    "BtnMain",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_btn_roll = {
    "BtnRoll",
    BIND_TYPE.BUTTON
  },
  v_btn_screen_up_down = {
    "Btn_screenUpDown",
    BIND_TYPE.BUTTON
  },
  v_btn_screen = {
    "Btn_screen",
    BIND_TYPE.BUTTON
  },
  v_compare_layout_mid = {
    "CompareLayoutMid",
    BIND_TYPE.OBJECT
  },
  v_cost_engrave_info = {
    "CostEngraveInfo",
    BIND_TYPE.OBJECT
  },
  v_cost_tem = {
    "CostTem",
    BIND_TYPE.OBJECT
  },
  v_curr_cost = {
    "CurrCost",
    BIND_TYPE.OBJECT
  },
  v_curr_icon = {
    "CurrIcon",
    BIND_TYPE.IMAGE
  },
  v_curr_num = {
    "CurrNum",
    BIND_TYPE.TEXT
  },
  v_engrave_info = {
    "EngraveInfo",
    BIND_TYPE.OBJECT
  },
  v_engrave_tem = {
    "EngraveTem",
    BIND_TYPE.BUTTON
  },
  v_left_list_view = {
    "LeftListView",
    BIND_TYPE.OBJECT
  },
  v_middle = {
    "Middle",
    BIND_TYPE.OBJECT
  },
  v_name = {
    "Name",
    BIND_TYPE.TEXT
  },
  v_no_item = {
    "NoItem",
    BIND_TYPE.IMAGE
  },
  v_part1 = {
    "Part1",
    BIND_TYPE.TOGGLE
  },
  v_part2 = {
    "Part2",
    BIND_TYPE.TOGGLE
  },
  v_part3 = {
    "Part3",
    BIND_TYPE.TOGGLE
  },
  v_part4 = {
    "Part4",
    BIND_TYPE.TOGGLE
  },
  v_roll_attr_content = {
    "RollAttrContent",
    BIND_TYPE.OBJECT
  },
  v_roll_attr_tem = {
    "RollAttrTem",
    BIND_TYPE.TOGGLE
  },
  v_screen_up_down = {
    "ScreenUpDown",
    BIND_TYPE.OBJECT
  },
  v_scroll_view = {
    "ScrollView",
    BIND_TYPE.IMAGE
  },
  v_show_engrave = {
    "ShowEngrave",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:init_compare_layout()
  self.v_roll_suc_ani = Util.get_child_gameobj("Animation/Ani_UIEngraveRoll_Roll", self.v_object)
  self.v_apply_suc_ani = Util.get_child_gameobj("Animation/Ani_UIEngraveRoll_Confirm", self.v_object)
  self:set_button("BtnRet1", function()
    self:on_click_return()
  end)
  self:set_button("Btn_screenUpDown", function()
    RelicMgr.v_is_drop = not RelicMgr.v_is_drop
    local rot_z = RelicMgr.v_is_drop and 0 or 180
    self.v_screen_up_down.transform:SetEuler(0, 0, rot_z)
    self:refresh_left_list()
  end)
  self:set_button("Btn_screen", function()
    self:refresh_left_list()
    UIMgr:get_ui("relic_filter_tips"):ui_show(self.v_slot_idx, self.v_operate_relic_uuid, self.v_relic_cfg.Quality)
  end)
  self:set_button("BtnConfirm", function()
    self.v_delay_sec = 0.7
    self:on_click_apply()
  end)
  self:set_button("BtnRoll", function()
    self.v_delay_sec = 1
    self:on_click_roll()
  end)
  for i = 1, 4 do
    self:set_toggle("Part" .. i, function(is_on)
      if is_on then
        self:refresh_left_list(i)
        self["v_part" .. i].interactable = false
      end
    end, false)
  end
  self.v_asset_bar_view = AssetBarView:new(self, self.v_asset_bar)
  self.v_left_scroll_list = LoopListClass:new(self, self.v_uiobjects.ScrollView, RelicItemClass)
  self:register_exist_auto_template(RELIC_REFINE_ENTRY_TEMP_KEY, self.v_uiobjects.RollAttrTem, self.v_roll_attr_content)
  self:register_exist_auto_template(RELIC_REFINE_INFO_ATTR_KEY, self.v_uiobjects.AttrTemp, self.v_attr_content)
end

function ui:init_compare_layout()
  local root = self.v_compare_layout_mid
  local name_now_txt = Util.get_text("AttrNow_/AttrNameNow_", root)
  local num_now_txt = Util.get_text("AttrNow_/AttrNumNow_", root)
  local no_now_obj = Util.get_child_gameobj("AttrNow_/NoNowAttr_", root)
  local name_new_txt = Util.get_text("AttrNew_/AttrNameNew_", root)
  local num_new_txt = Util.get_text("AttrNew_/AttrNumNew_", root)
  local no_new_obj = Util.get_child_gameobj("AttrNew_/NoNewAttr_", root)
  self.v_compare_node = {
    now = {
      name_txt = name_now_txt,
      num_txt = num_now_txt,
      none_obj = no_now_obj
    },
    new = {
      name_txt = name_new_txt,
      num_txt = num_new_txt,
      none_obj = no_new_obj
    }
  }
end

function ui:on_click_return()
  self:ui_hide()
end

function ui:on_go_to_main()
end

function ui:ui_on_hide()
  self.v_consume_list = {}
  self.v_left_scroll_list:ui_on_hide()
  self.v_asset_bar_view:on_hide()
  if self.v_delay_show_timer then
    Timer:remove_timer(self.v_delay_show_timer)
    self.v_delay_show_timer = nil
  end
end

function ui:ui_on_destroy()
  self.v_consume_list = {}
  self.v_left_scroll_list:ui_on_destroy()
  self.v_asset_bar_view:on_destory()
end

function ui:ui_on_show(relic_uuid)
  self.v_operate_relic_uuid = relic_uuid
  self.v_operate_entry_idx = 0
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  self.v_relic_cfg = ShareRes.get_relic_cfg(relic_data.id)
  self.v_selected_relic_uuid = nil
  self.v_consume_relic_uuid = 0
  self.v_roll_suc_ani:SetActive(false)
  self.v_apply_suc_ani:SetActive(false)
  self:init_left_list_show()
  self:init_entry_list()
  self:refresh_static_info()
  self:refresh_dynamic_info()
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.refresh_btns, self)
  self:bind_auto_mq(Const.MSG_ON_RELIC_UPDATE, self.on_relic_update, self)
  self:bind_auto_mq(Const.MSG_ON_RELIC_FILTER_UPDATE, self.refresh_left_list_by_msg, self)
  local list = Shop_Helper.get_asset_list({COIN_ITEMID})
  self.v_asset_bar_view:reset_config(list)
  self.v_asset_bar_view:on_create()
end

function ui:init_entry_list()
  local entry_unlock_cfg = ShareRes.create("relic.relic_entry_unlock")
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  local relic_lv = relic_data.lv
  self.v_entry_list = {}
  self:give_back_auto_cache(RELIC_REFINE_ENTRY_TEMP_KEY)
  for idx, cfg in ipairs(entry_unlock_cfg) do
    local item = self:get_auto_cache(RELIC_REFINE_ENTRY_TEMP_KEY)
    local is_unlock = relic_lv >= cfg.OpenLevel
    local tog = Util.get_toggle(nil, item)
    local unlock_obj = Util.get_child_gameobj("UnLock_", item)
    local select_obj = Util.get_child_gameobj("UnLock_/Select", item)
    local lock_obj = Util.get_child_gameobj("Lock_", item)
    local red_obj = Util.get_child_gameobj("Red_", item)
    local icon = Util.get_image("UnLock_/AttrIcon_", item)
    local name_txt = Util.get_text("UnLock_/AttrName_", item)
    local val_now_txt = Util.get_text("UnLock_/AttrNum_", item)
    local btn_reset = Util.get_button("UnLock_/BtnReSet_", item)
    local cond_txt = Util.get_text("Lock_/Condition_", item)
    unlock_obj:SetActive(is_unlock)
    lock_obj:SetActive(not is_unlock)
    red_obj:SetActive(false)
    tog.interactable = is_unlock
    if is_unlock then
      _tinsert(self.v_entry_list, {
        tog = tog,
        icon = icon,
        name_txt = name_txt,
        val_now_txt = val_now_txt,
        red_obj = red_obj,
        select_obj = select_obj,
        btn_reset = btn_reset
      })
      local target_idx = #self.v_entry_list
      if 0 == self.v_operate_entry_idx then
        self.v_operate_entry_idx = target_idx
      end
      local is_on = self.v_operate_entry_idx == target_idx
      self:set_toggle_listener(tog, function(isOn)
        if isOn then
          self:switch_entry_selected(target_idx)
        end
      end, is_on)
    else
      cond_txt.text = Util.format_str("{1}级解锁", cfg.OpenLevel)
    end
  end
end

function ui:refresh_static_info()
  self:set_operate_relic()
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  local owner_id = relic_data.buddy_id or 0
  self:set_owner(self.v_compare_layout_mid, owner_id)
end

function ui:set_operate_relic()
  local center_root = self.v_uiobjects.ShowEngrave
  local center_slot_txt = Util.get_text("Part_", center_root)
  local center_lv_txt = Util.get_text("LV_", center_root)
  local center_bg_img = Util.get_image("QualityBg_", center_root)
  local center_icon = Util.get_image("EngraveIcon_", center_root)
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  center_slot_txt.text = Util.format_str("{1}号位", self.v_relic_cfg.Slot)
  center_lv_txt.text = Util.format_str("LV.{1}", relic_data.lv)
  local quality_path = ShareRes.get_item_quality_cfg(self.v_relic_cfg.Quality).RelicCircleBgBigIcon
  ResMgr:load_set_icon(center_bg_img, quality_path)
  local icon_path = UtilUI.get_item_icon(relic_data.id)
  ResMgr:load_set_icon(center_icon, icon_path)
end

function ui:set_owner(root, owner_id)
  local owner_root = Util.get_child_gameobj("Equipment_", root)
  local owner_head_img = Util.get_image("EquipCharIcon_", owner_root)
  local owner_ele_img = Util.get_image("Ele/EquipEleIcon_", owner_root)
  owner_root:SetActive(0 ~= owner_id)
  if 0 ~= owner_id then
    local buddy_config = ShareRes.create("buddy.buddy", owner_id)
    local icon_name = buddy_config.Icon[2]
    local path = string.format("Icon/Profile/%s", icon_name)
    ResMgr:load_set_icon(owner_head_img, path)
    local element_id = buddy_config.Element
    local element_cfg = ShareRes.create("buddy.buddy_element", element_id)
    ResMgr:load_set_icon(owner_ele_img, element_cfg.ElementIconPath)
  end
end

function ui:on_relic_update(msg)
  if msg and msg.mm_x == self.v_operate_relic_uuid then
    self:refresh_dynamic_info(true)
    self:refresh_left_list()
  end
end

function ui:refresh_dynamic_info(delay)
  self:refresh_entry_list()
  self:refresh_attr_list_main()
  self:switch_entry_selected(self.v_operate_entry_idx, delay)
  self:refresh_consume_item()
end

function ui:refresh_entry_list()
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  local pos = 0
  for _, entry in ipairs(relic_data.entrys) do
    if entry.type ~= RELIC_ENTRY_TYPE.PRINCIPAL then
      pos = pos + 1
      local left_entry_item = self.v_entry_list[pos]
      if left_entry_item then
        local is_red = entry.new_entry_id and 0 ~= entry.new_entry_id
        local color = is_red and "ec7f00" or "ffffff"
        local relic_entry_cfg = ShareRes.create("relic.relic_entry", is_red and entry.new_entry_id or entry.entry_id)
        local attr_id, val = relic_entry_cfg.AttrId, relic_entry_cfg.BaseAttr
        left_entry_item.name_txt.text = string.format("<color=#%s>%s</color>", color, ShareRes.get_attr_name(attr_id))
        local icon_name = ShareRes.get_attr_icon(attr_id)
        if icon_name then
          Util.load_attr_icon(left_entry_item.icon, icon_name)
        end
        local is_ration = ShareRes.get_is_ration_attr(attr_id)
        local val_str = is_ration and string.format("%.2f", val / 100) .. "%" or Util.round(val)
        left_entry_item.val_now_txt.text = string.format("<color=#%s>%s</color>", color, val_str)
        left_entry_item.red_obj:SetActive(is_red)
        left_entry_item.entry_data = entry
        left_entry_item.btn_reset.gameObject:SetActiveEx(is_red)
        if is_red then
          self:set_button_listener(left_entry_item.btn_reset, function()
            self:on_click_clear_entry(entry.id)
          end)
        end
      end
    end
  end
end

function ui:switch_entry_selected(idx, delay)
  self.v_operate_entry_idx = idx
  self:refresh_compare_info(delay)
  self:refresh_attr_selected()
  self:refresh_btns()
  self:refresh_tog_interactable()
end

function ui:refresh_tog_interactable()
  for k, v in ipairs(self.v_entry_list) do
    v.tog.interactable = k ~= self.v_operate_entry_idx
  end
end

function ui:refresh_compare_info(delay)
  local now_entry_id, new_entry_id = self:get_selected_entry_id()
  self:_refresh_compare_info(self.v_compare_node.now, now_entry_id)
  if delay then
    if self.v_delay_show_timer then
      Timer:remove_timer(self.v_delay_show_timer)
    end
    self.v_delay_show_timer = Timer:add_timer("relic_refine_delay_show_timer", self.v_delay_sec, function()
      self:_refresh_compare_info(self.v_compare_node.new, new_entry_id)
    end)
  else
    self:_refresh_compare_info(self.v_compare_node.new, new_entry_id)
  end
end

function ui:_refresh_compare_info(root, entry_id)
  local is_empty = 0 == entry_id
  root.name_txt.gameObject:SetActiveEx(not is_empty)
  root.num_txt.gameObject:SetActiveEx(not is_empty)
  root.none_obj:SetActiveEx(is_empty)
  if not is_empty then
    local entry_cfg = ShareRes.create("relic.relic_entry", entry_id)
    local is_ration = ShareRes.get_is_ration_attr(entry_cfg.AttrId)
    root.name_txt.text = ShareRes.get_buddy_attr_name(entry_cfg.AttrId)
    root.num_txt.text = is_ration and string.format("%.2f", entry_cfg.BaseAttr / 100) .. "%" or Util.round(entry_cfg.BaseAttr)
  end
end

function ui:get_selected_entry_id()
  local idx = self.v_operate_entry_idx
  local entry_data = idx and self.v_entry_list[idx] and self.v_entry_list[idx].entry_data
  local now_entry_id, new_entry_id, entry_uid = 0, 0, 0
  if entry_data then
    entry_uid = entry_data.id or 0
    now_entry_id = entry_data.entry_id or 0
    new_entry_id = entry_data.new_entry_id or 0
  end
  return now_entry_id, new_entry_id, entry_uid
end

function ui:refresh_attr_selected()
  for i, v in pairs(self.v_entry_list) do
    v.select_obj:SetActiveEx(i == self.v_operate_entry_idx)
  end
end

function ui:refresh_attr_list_main()
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_operate_relic_uuid)
  self.v_attr_selected_obj_list = {}
  self:give_back_auto_cache(RELIC_REFINE_INFO_ATTR_KEY)
  for _, entry in ipairs(relic_data.entrys) do
    if entry.type == RELIC_ENTRY_TYPE.PRINCIPAL then
      local item = self:get_auto_cache(RELIC_REFINE_INFO_ATTR_KEY)
      local icon = Util.get_image("AttrIcon", item)
      local name_txt = Util.get_text("AttrName", item)
      local val_now_txt = Util.get_text("AttrVal", item)
      local entry_id = entry.entry_id
      local relic_entry_cfg = ShareRes.create("relic.relic_entry", entry_id)
      local attr_id, val = relic_entry_cfg.AttrId, relic_entry_cfg.BaseAttr
      val = val + relic_data.lv * relic_entry_cfg.LevelAttr
      local icon_name = ShareRes.get_attr_icon(attr_id)
      if icon_name then
        Util.load_attr_icon(icon, icon_name)
      end
      name_txt.text = ShareRes.get_attr_name(attr_id)
      local is_ration = ShareRes.get_is_ration_attr(attr_id)
      local val_str = is_ration and string.format("%.2f", val / 100) .. "%" or Util.round(val)
      val_now_txt.text = val_str
    end
  end
end

function ui:refresh_left_list_by_msg()
  self:refresh_left_list()
end

function ui:refresh_left_list(slot_idx)
  if slot_idx then
    self.v_slot_idx = slot_idx
  end
  self.v_left_list_data = RelicMgr:get_filter_sort_list(self.v_slot_idx, self.v_operate_relic_uuid, self.v_relic_cfg.Quality)
  self.v_left_scroll_list:refresh_data(self.v_left_list_data)
  local is_list_empty = 0 == #self.v_left_list_data
  self.v_uiobjects.NoItem:SetActive(is_list_empty)
end

function ui:on_click_relic(uuid)
  self:on_click_relic_consume(uuid)
end

function ui:on_click_exp_item()
end

function ui:on_click_relic_consume(uuid)
  if self.v_consume_relic_uuid ~= uuid and 0 ~= uuid then
    local temp_relic_data = RelicMgr:get_relic_data_by_uuid(uuid)
    local owner_id = temp_relic_data.buddy_id or 0
    local need_unlock = 1 == temp_relic_data.lock
    local need_unwear = 0 ~= owner_id
    if need_unlock or need_unwear then
      local function confirm_cb()
        if need_unlock then
          RelicMgr:req_unlock_relic(uuid, function()
            if not need_unwear then
              self:on_click_relic_consume(uuid)
            end
          end)
        end
        if need_unwear then
          RelicMgr:req_take_off_relic(uuid, function()
            self:on_click_relic_consume(uuid)
          end)
        end
      end
      
      Util.show_notify_popup_message(confirm_cb, "物品已锁定/已装备，是否解锁/卸下并选中作为消耗？")
      return
    end
  end
  self.v_consume_relic_uuid = self.v_consume_relic_uuid == uuid and 0 or uuid
  self:on_consume_selected_update()
end

function ui:clear_relic_consume()
  self.v_consume_relic_uuid = 0
  self:on_consume_selected_update()
end

function ui:get_is_relic_selected(uuid)
  return self.v_consume_relic_uuid == uuid
end

function ui:get_is_exp_item_selected(exp_item_id)
end

function ui:on_consume_selected_update()
  local all_itmes = self.v_left_scroll_list:get_all_uis()
  for _, ui_item in pairs(all_itmes) do
    if ui_item:is_visible_item() then
      ui_item:update_selected()
    end
  end
  self:refresh_btns()
  self:refresh_consume_item()
end

function ui:refresh_btns()
  local own_coin = BagMgr:get_item_num(COIN_ITEMID)
  local entry_unlock_cfg = ShareRes.create("relic.relic_entry_unlock", self.v_operate_entry_idx)
  local cost_coin = entry_unlock_cfg and entry_unlock_cfg.GoldConsume or 0
  self.v_coin_enough = own_coin >= cost_coin
  if self.v_coin_enough then
    self.v_curr_num.text = "<color=#ffffff>" .. cost_coin .. "</color>"
  else
    self.v_curr_num.text = "<color=#e0212c>" .. cost_coin .. "</color>"
  end
  ResMgr:load_set_icon(self.v_curr_icon, UtilUI.get_item_icon(COIN_ITEMID))
  local now_entry_id, new_entry_id = self:get_selected_entry_id()
  self.v_uiobjects.BtnConfirmRed:SetActive(0 ~= new_entry_id)
  self.v_btn_confirm.interactable = 0 ~= new_entry_id
  local txt_color = 0 == new_entry_id and "828282" or "ffffff"
  Util.get_text("Text", self.v_uiobjects.BtnConfirm).color = Util.get_unity_color_by_hex(tonumber(txt_color, 16))
  self.v_btn_roll.interactable = 0 ~= self.v_consume_relic_uuid
  txt_color = 0 == self.v_consume_relic_uuid and "828282" or "ffffff"
  Util.get_text("Text", self.v_uiobjects.BtnRoll).color = Util.get_unity_color_by_hex(tonumber(txt_color, 16))
end

function ui:refresh_consume_item()
  local item = self.v_cost_tem
  local null_obj = Util.get_child_gameobj("CostNull_", item)
  local item_obj = Util.get_child_gameobj("CostItem_", item)
  local btn_del = Util.get_button("BtnDel_", item)
  local has_data = 0 ~= self.v_consume_relic_uuid
  null_obj:SetActive(not has_data)
  item_obj:SetActive(has_data)
  btn_del.gameObject:SetActive(has_data)
  self.v_cost_engrave_info:SetActive(has_data)
  if not has_data then
    return
  end
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_consume_relic_uuid)
  local relic_cfg = ShareRes.get_relic_cfg(relic_data.id)
  local main_entry_attr_id = self:get_relic_main_entry_attr_id(relic_data)
  local quality_img = Util.get_image("CostItem_/ItemQuality_", item)
  local icon_img = Util.get_image("CostItem_/ItemIcon_", item)
  local lv_txt = Util.get_text("CostItem_/Lower/Lv_", item)
  local icon_path, quality_path = UtilUI.get_item_images(relic_data.id)
  ResMgr:load_set_icon(quality_img, quality_path)
  ResMgr:load_set_icon(icon_img, icon_path)
  lv_txt.text = Util.format_str("LV.{1}", relic_data.lv)
  local info_item = self.v_cost_engrave_info
  local relic_name_txt = Util.get_text("Name_", info_item)
  local attr_name_txt = Util.get_text("MainAttr", info_item)
  local attr_icon = Util.get_image("AttrIcon", info_item)
  local detail_btn = Util.get_button("BtnCostEngraveDetail_", info_item)
  relic_name_txt.text = relic_cfg.Name
  attr_name_txt.text = ShareRes.get_attr_name(main_entry_attr_id)
  Util.load_attr_icon(attr_icon, ShareRes.get_attr_icon(main_entry_attr_id))
  self:set_button_listener(btn_del, function()
    self:on_click_relic(self.v_consume_relic_uuid)
  end)
  self:set_button_listener(detail_btn, function()
    Util.show_relic_tip(self.v_consume_relic_uuid)
  end)
end

function ui:get_relic_main_entry_attr_id(relic_data)
  for _, entry in ipairs(relic_data.entrys) do
    if entry.type == RELIC_ENTRY_TYPE.PRINCIPAL then
      local relic_entry_cfg = ShareRes.create("relic.relic_entry", entry.entry_id)
      return relic_entry_cfg.AttrId
    end
  end
end

function ui:on_click_clear_entry(entry_uid)
  local function confirm_cb()
    RelicMgr:req_c2gs_relic_remove_temp_entry(self.v_operate_relic_uuid, entry_uid)
  end
  
  Util.show_notify_popup_message(confirm_cb, "移除后无法复原，是否继续？")
end

function ui:on_click_apply()
  local now_entry_id, new_entry_id, entry_uid = self:get_selected_entry_id()
  if 0 == new_entry_id then
    return
  end
  
  local function confirm_cb()
    RelicMgr:req_c2gs_relic_repeat_entry(self.v_operate_relic_uuid, entry_uid, function()
      self.v_apply_suc_ani:SetActive(false)
      self.v_apply_suc_ani:SetActive(true)
    end)
  end
  
  if now_entry_id ~= new_entry_id then
    Util.show_notify_popup_message(confirm_cb, "是否将新属性覆盖原属性？")
  else
    confirm_cb()
  end
end

function ui:on_click_roll()
  if 0 == self.v_consume_relic_uuid then
    Util.show_message_tip(2352)
    return
  elseif not self.v_coin_enough then
    Util.show_message_tip(2314, UtilUI.get_item_name(COIN_ITEMID))
    return
  end
  local now_entry_id, new_entry_id, entry_uid = self:get_selected_entry_id()
  
  local function confirm_cb()
    RelicMgr:req_c2gs_relic_reflush_entry(self.v_operate_relic_uuid, entry_uid, {
      self.v_consume_relic_uuid
    }, function()
      self:clear_relic_consume()
      self.v_roll_suc_ani:SetActive(false)
      self.v_roll_suc_ani:SetActive(true)
      Util.show_message_tip(2266)
    end)
  end
  
  local relic_data = RelicMgr:get_relic_data_by_uuid(self.v_consume_relic_uuid)
  if relic_data.lv > 1 then
    Util.show_notify_popup_message(confirm_cb, "消耗后不返还养成材料，是否继续？")
  else
    confirm_cb()
  end
end

function ui:init_left_list_show()
  local idx = self:get_not_empty_slot()
  self["v_part" .. idx].isOn = false
  self["v_part" .. idx].isOn = true
end

function ui:get_not_empty_slot()
  for idx = 1, 4 do
    local temp_sort_list = RelicMgr:get_filter_sort_list(idx, self.v_operate_relic_uuid, self.v_relic_cfg.Quality)
    if temp_sort_list and next(temp_sort_list) ~= nil then
      return idx
    end
  end
  return 1
end

return ui
