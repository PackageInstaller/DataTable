local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BUILDING_CONFIG = require("uimodule.building.building_config")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local AssetBarView = require("ui.asset_bar.asset_bar")
local Shop_Helper = require("uimodule.shop.shop_helper")
local BIND_TYPE = Config.BIND_TYPE
local CT_Timer = Global.ct_timer
local MIDICAMENT_KEY = "FORCE_CHARGE_MIDICAMENT_LIST"
local FORCE_CHARGE_ITEM_OBJ = "FORCE_CHARGE_ITEM_OBJ"
local SHOW_STR_COLOR = ShareRes.get_comm_string_value("ItemExchangeNumColor") or "EC7F00"
local DM_BUY_SYS_ID = 44
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm
local _tinsert = table.insert
local MODEL = {
  v_rec_item_toggle = {
    "RecItem",
    BIND_TYPE.TOGGLE
  },
  v_rec_dia_toggle = {
    "RecDia",
    BIND_TYPE.TOGGLE
  },
  v_use_item_obj = {
    "UseItem",
    BIND_TYPE.OBJECT
  },
  v_use_Dia_obj = {
    "UseDia",
    BIND_TYPE.OBJECT
  },
  v_dia_lock = {
    "DiaLock",
    BIND_TYPE.OBJECT
  },
  v_medicament_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_medicament_item = {
    "ItemTem",
    BIND_TYPE.OBJECT
  },
  v_recovery_time = {
    "RecoveryTime",
    BIND_TYPE.OBJECT
  },
  v_fullrecovery_time = {
    "FullRecoveryTime",
    BIND_TYPE.OBJECT
  },
  v_fullrecovery_tip = {
    "FullRecoveryTimeTip",
    BIND_TYPE.OBJECT
  },
  v_fullrecovery_text = {
    "FullRecovery",
    BIND_TYPE.OBJECT
  }
}
local TOGGLE_TYPE = {
  ITEM = 1,
  DIAMOND = 2,
  WAREHOUSE_EXCHANGE = 3
}
local DIA_ID = Config.DIAMOND_ITEMID
local SP_ID = Config.PLAYER_SP_ITEMID
local BSP_ID = BagMgr.RES_ENUM.BUILDING_STAMINA

local function medicament_cmp(medicament_item_a, medicament_item_b)
  local a_m_item = medicament_item_a
  local b_m_item = medicament_item_b
  local a_end_time = a_m_item.item_info.end_time or 0
  local b_end_time = b_m_item.item_info.end_time or 0
  if 0 == a_end_time or 0 == b_end_time then
    if 0 == a_end_time and 0 == b_end_time then
      return a_m_item.item_cfg.Priority > b_m_item.item_cfg.Priority
    elseif 0 == a_end_time then
      return false
    else
      return true
    end
  elseif a_end_time == a_end_time then
    return a_m_item.item_cfg.Priority > b_m_item.item_cfg.Priority
  else
    return a_end_time < a_end_time
  end
end

function ui:on_click_min_btn()
  self.v_exchange_count = 1
  self:refresh_count()
end

function ui:on_click_max_btn()
  self.v_exchange_count = math.max(BagMgr:get_item_num(self.v_cost_item), 1)
  self:refresh_count()
end

function ui:on_click_add_btn()
  self:operation_count(true)
end

function ui:on_click_reduce_btn()
  self:operation_count(false)
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Back", function()
    self:ui_hide()
  end)
  self:set_button("Confirm", function()
    if self.v_select == TOGGLE_TYPE.ITEM then
      if next(self.v_select_table) == nil then
        UIMgr:get_ui("uimessagetip"):ui_show("请选择道具")
        return
      end
      local item_type_config = ShareRes.create("item.item_subtype").stamina_item
      local item_list = {}
      for uuid, item_data in pairs(self.v_select_table) do
        _tinsert(item_list, {
          uuid = uuid,
          count = item_data.num
        })
      end
      local consume_list = {
        bag_type = item_type_config.TypeId,
        item_list = item_list
      }
      BagMgr:request_use_item(consume_list, function(ok)
        if ok then
          Util.show_message_tip(2070)
        else
          self:refresh_view()
        end
        self:ui_hide()
      end)
    elseif self.v_select == TOGGLE_TYPE.DIAMOND then
      if self:get_cost() <= BagMgr:get_item_num(DIA_ID) then
        local exchange_config = CharacterMgr:get_exchange_config(Config.EXCHANGE_TYPE.DEFAULT, SP_ID, DIA_ID)
        CharacterMgr:request_exchange_item(exchange_config.Id, 1, function()
          Util.show_message_tip(2229)
          self:ui_hide()
        end)
      else
        local cfg = UtilUI.get_item_cfg(DIA_ID)
        Util.show_message_tip(2314, cfg.Name)
      end
    elseif self.v_select == TOGGLE_TYPE.WAREHOUSE_EXCHANGE then
      if self.v_exchange_count <= 0 then
        return
      end
      local exchange_config = ShareRes.get_item_exchange_cfg(self.v_exchange_id)
      local target_id = exchange_config.TargetId
      local item_cfg = ShareRes.get_item_cfg(target_id)
      local max_count = item_cfg.MaxCount
      local target_item_count = exchange_config.Count * self.v_exchange_count
      if max_count < target_item_count + BagMgr:get_item_num(target_id) then
        local item_name = Util.get_item_name(target_id)
        Util.show_message_tip(2320, item_name, max_count)
        return
      end
      CharacterMgr:request_exchange_item(self.v_exchange_id, self.v_exchange_count, function()
        Util.show_message_tip(2234)
        self:ui_hide()
      end)
    end
  end)
  self:set_button("BtnClear", function()
    self:show_item_use_panel()
  end)
  self:set_button("BtnMin", function()
    self:on_click_min_btn()
  end)
  self:set_button("BtnMax", function()
    self:on_click_max_btn()
  end)
  self:set_button("BtnReduce", function()
    self:on_click_reduce_btn()
  end)
  self:set_button("BtnAdd", function()
    self:on_click_add_btn()
  end)
  self:set_button("BtnAddition", function()
    self.v_uiobjects.AdditionGroup:SetActive(true)
    BUILDING_CONFIG.REFRESH_ADDTION_GROUP_FUNC(self, Config.CommonDefine.BUILDING_TYPE.STAMINA)
  end)
  self:set_button("BtnCloseTips", function()
    self.v_uiobjects.AdditionGroup:SetActive(false)
  end)
  self:set_slider_listener(self.v_uicompents.SetNumSlider_sld, function()
    local value = self.v_uicompents.SetNumSlider_sld.value
    self:refresh_count(value)
  end)
  self:init_normal_info()
  self:register_exist_auto_template(MIDICAMENT_KEY, self.v_medicament_item, self.v_medicament_content)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show(deafult_index, need_sp_count)
  self.v_uiobjects.AdditionGroup:SetActive(false)
  local list = Shop_Helper.get_asset_list({
    Config.DIAMOND_ITEMID
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
  local is_open_dm_buy = SysOpenMgr:get_sys_is_open(DM_BUY_SYS_ID)
  self.v_dia_lock:SetActive(not is_open_dm_buy)
  local is_unlock = BuildingMgr:get_building_level(Config.CommonDefine.BUILDING_TYPE.STAMINA) > 0
  self.v_uiobjects.RecStore:SetActive(is_unlock)
  self.v_uiobjects.StoreLock:SetActive(false)
  self.v_toggle_tab = ToggleTab:new(self)
  local toggles = {
    self.v_rec_item_toggle,
    self.v_rec_dia_toggle,
    self.v_uicompents.RecStore_tog
  }
  self.v_toggle_tab:init_by_toggles(toggles, function(idx)
    local not_click = false
    if idx == TOGGLE_TYPE.DIAMOND then
      not_click = not SysOpenMgr:get_sys_is_open(DM_BUY_SYS_ID, true)
    elseif idx == TOGGLE_TYPE.WAREHOUSE_EXCHANGE then
      not_click = BuildingMgr:get_building_level(Config.CommonDefine.BUILDING_TYPE.STAMINA) <= 0
    end
    if not_click then
      local last_idx = self.v_last_index or 1
      toggles[last_idx].isOn = true
      return
    end
    self.v_last_index = idx
    self:on_select_toggle(idx)
  end)
  self.v_medicament_item_list = {}
  self.v_select_table = {}
  local item_type_config = ShareRes.create("item.item_subtype").stamina_item
  local type_id = item_type_config.TypeId
  local sub_type_id = item_type_config.SubtypeId
  if deafult_index then
    self.v_select = deafult_index
  elseif next(BagMgr:get_item_list_by_type(type_id, sub_type_id, 2)) == nil and is_open_dm_buy then
    self.v_select = TOGGLE_TYPE.DIAMOND
  else
    self.v_select = TOGGLE_TYPE.ITEM
  end
  self:refresh_view()
  self:bind_auto_mq(Const.MSG_ON_PLAYER_SP_UPDATE, self.refresh_view, self)
  self:bind_auto_mq(Const.MSG_ON_APPLICATION_PAUSE, self.refresh_view, self)
  self:show_item_use_panel()
  self:select_item_with_win_open(need_sp_count)
end

function ui:select_item_with_win_open(need_sp_count)
  if self.v_medicament_item_list and #self.v_medicament_item_list > 0 and self.need_select_item_ui then
    self.v_is_sp_enough = false
    self.v_curr_need_sp_count = need_sp_count
    for i = 1, #self.v_medicament_item_list do
      if not self.v_is_sp_enough then
        local item = self.v_medicament_item_list[i]
        self:_select_medicament_item(true, item.item_info, self.v_medicament_item_list[i].item_ui, self.v_curr_need_sp_count)
      else
        break
      end
    end
  end
end

function ui:on_update_item()
  if self.v_select == TOGGLE_TYPE.DIAMOND then
    return
  end
  self:refresh_view()
end

function ui:ui_update(time)
  if self.v_is_down then
    self.v_down_time = self.v_down_time + time
    if self.v_down_time > 0.2 then
      self:_select_medicament_item(true, self.v_cur_item_info, self.v_cur_item_ui)
      self.v_down_time = 0
    end
  end
  if self.v_select == TOGGLE_TYPE.DIAMOND then
    return
  end
  if next(self.v_medicament_item_list) == nil then
    return
  end
  self:update_item_time()
end

function ui:ui_on_hide()
  self.v_toggle_tab = nil
  self.v_select_table = nil
  self.v_medicament_item_list = nil
  self.v_select = nil
  self.v_exchange_count = nil
  self.v_down_time = 0
  self.v_is_down = false
  if self.v_asset_bar then
    self.v_asset_bar:on_hide()
  end
  self:release_items_by_template_key(FORCE_CHARGE_ITEM_OBJ)
  self:remove_recover_timer()
end

function ui:ui_on_destroy()
  if self.v_asset_bar then
    self.v_asset_bar:on_destory()
    self.v_asset_bar = nil
  end
  self:remove_recover_timer()
end

function ui:get_sp_info(cur_show_id)
  local sp_num = CharacterMgr:get_res_val(cur_show_id)
  local sp_max_num
  if cur_show_id == SP_ID then
    sp_max_num = ShareRes.create("item.item", cur_show_id).MaxCount
    local role_lv = PlayerMgr:get_role_lv()
    local player_upgrade_config = ShareRes.create("player.player_upgrade")
    for _, data in pairs(player_upgrade_config) do
      if role_lv == data.Level then
        sp_max_num = data.RecLimit
        break
      end
    end
  elseif cur_show_id == BSP_ID then
    if not self.v_max_value then
      self:get_building_exchange_param()
    end
    sp_max_num = self.v_max_value
  end
  return sp_num, sp_max_num
end

function ui:refresh_view()
  local sp_num, sp_max_num = self:get_sp_info(SP_ID)
  self.v_uicompents.ForceNow_txt.text = sp_num
  self.v_uicompents.ForceMax_txt.text = sp_max_num
  self.v_uicompents.ForcePreview_txt.text = sp_num
  self:refresh_view_info()
  if not self.v_toggle_tab then
    return
  end
  self.v_toggle_tab:set_toggle_by_index(self.v_select)
  self:on_select_toggle(self.v_select)
end

function ui:refresh_view_info()
  local cur_show_id = self.v_select == TOGGLE_TYPE.WAREHOUSE_EXCHANGE and BSP_ID or SP_ID
  local sp_num, sp_max_num = self:get_sp_info(cur_show_id)
  if sp_num < sp_max_num then
    BagMgr:request_item_recover_time(cur_show_id, function(resp)
      if resp.errcode and 0 == resp.errcode then
        self:refresh_recover_time(resp.last_recover_time, sp_max_num - sp_num, cur_show_id)
      end
    end)
  else
    self.v_recovery_time:SetActiveEx(false)
    self.v_uiobjects.RecoveryTimeTip:SetActiveEx(false)
    self.v_uiobjects.RecoveryTimeBg:SetActiveEx(false)
    self.v_fullrecovery_time:SetActiveEx(false)
    self.v_fullrecovery_tip:SetActiveEx(false)
    self.v_fullrecovery_text:SetActiveEx(true)
  end
end

function ui:init_normal_info()
  local dia_cfg = ShareRes.get_item_cfg(DIA_ID)
  local dia_name = dia_cfg.Name
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local use_dia_txt = Util.get_text("TogName", uobj.RecDia)
  local force_icon_1 = ucom.ForceIcon1_img
  local force_icon_2 = ucom.ForceIcon2_img
  local dia_icon = ucom.DiaIcon_img
  use_dia_txt.text = Util.format_str("{1}恢复", dia_name)
  local force_path = UtilUI.get_item_icon(SP_ID)
  local dia_path = UtilUI.get_item_icon(DIA_ID)
  ResMgr:load_set_icon(force_icon_1, force_path)
  ResMgr:load_set_icon(force_icon_2, force_path)
  ResMgr:load_set_icon(dia_icon, dia_path)
end

function ui:on_select_toggle(idx)
  local last_idx = self.v_select
  self.v_select = idx
  self.v_uiobjects.UseItem:SetActive(idx == TOGGLE_TYPE.ITEM)
  self.v_uiobjects.UseDia:SetActive(idx == TOGGLE_TYPE.DIAMOND)
  self.v_uiobjects.ForceStore:SetActive(idx == TOGGLE_TYPE.WAREHOUSE_EXCHANGE)
  if idx == TOGGLE_TYPE.ITEM then
    self:show_item_use_panel()
  elseif idx == TOGGLE_TYPE.DIAMOND then
    self:show_diamond_use_panel()
  elseif idx == TOGGLE_TYPE.WAREHOUSE_EXCHANGE then
    self:show_warehouse_exchange_panel()
  end
  if last_idx ~= idx then
    self:refresh_view_info()
  end
end

function ui:get_building_exchange_param()
  local building_level = BuildingMgr:get_building_level(Config.CommonDefine.BUILDING_TYPE.STAMINA)
  local cfg = ShareRes.get_stamina_warehouse_level_cfg(building_level)
  if not cfg then
    Log.Error("获取体力仓库等级配置失败， 等级为:", tostring(building_level))
    return
  end
  local exchange_id = cfg.StaminaExchangeId
  local exchange_config = ShareRes.get_item_exchange_cfg(exchange_id)
  if exchange_config then
    local cost_item, max_value = exchange_config.Material[1], cfg.Capacity
    self.v_exchange_id = exchange_id
    self.v_cost_item = cost_item
    self.v_max_value = max_value
  else
    Log.Error("获取兑换配置失败， 兑换id为:", tostring(exchange_id))
  end
end

function ui:show_warehouse_exchange_panel()
  self:get_building_exchange_param()
  local cur_count = BagMgr:get_item_num(self.v_cost_item)
  self.v_exchange_count = self.v_exchange_count or cur_count
  self.v_uicompents.StoreNow_txt.text = cur_count
  self.v_uicompents.StoreMax_txt.text = self.v_max_value
  self:refresh_count()
end

function ui:show_diamond_use_panel()
  local exchange_config = CharacterMgr:get_exchange_config(Config.EXCHANGE_TYPE.DEFAULT, SP_ID, DIA_ID)
  local left_time = CharacterMgr:get_exchange_remain_time(exchange_config.Id)
  local exchange_cost = self:get_cost()
  local exchange_num = exchange_config.Count
  local max_exchange_num = exchange_config.TriesLimit
  local force_cfg = ShareRes.get_item_cfg(SP_ID)
  local force_name = force_cfg.Name
  local dia_cfg = ShareRes.get_item_cfg(DIA_ID)
  local dia_name = dia_cfg.Name
  local str
  if left_time < max_exchange_num then
    str = Util.format_str("是否花费<color=#{1}>{2}</color>{3}增加<color=#{4}>{5}</color>{6}？(<color=#{7}>{8}</color> / {9})", SHOW_STR_COLOR, exchange_cost, dia_name, SHOW_STR_COLOR, exchange_num, force_name, SHOW_STR_COLOR, left_time, max_exchange_num)
  else
    str = Util.format_str("是否花费<color=#{1}>{2}</color>{3}增加<color=#{4}>{5}</color>{6}？({7} / {8})", SHOW_STR_COLOR, exchange_cost, dia_name, SHOW_STR_COLOR, exchange_num, force_name, left_time, max_exchange_num)
  end
  if left_time <= 0 then
    str = Util.format_str("今日次数已用完({1} / {2})", left_time, max_exchange_num)
  end
  local is_enough = BagMgr:get_cost_enough(DIA_ID, exchange_cost)
  self.v_uicompents.DiaAmount_txt.color = is_enough and enough_color or not_enough_color
  self.v_uicompents.CostText_txt.text = str
  self.v_uicompents.DiaAmount_txt.text = exchange_cost
  self.v_uicompents.ForceGet_txt.text = exchange_num
  local quality_path1 = ShareRes.get_quality_path(force_cfg.Quality)
  ResMgr:load_set_icon(self.v_uicompents.ForceBg2_img, quality_path1)
  local quality_path2 = ShareRes.get_quality_path(dia_cfg.Quality)
  ResMgr:load_set_icon(self.v_uicompents.DiaBg_img, quality_path2)
  local sp_num = CharacterMgr:get_res_val(SP_ID)
  self.v_uicompents.ForcePreview_txt.text = sp_num + exchange_num
end

function ui:get_cost()
  local exchange_config = CharacterMgr:get_exchange_config(Config.EXCHANGE_TYPE.DEFAULT, SP_ID, DIA_ID)
  local left_time = CharacterMgr:get_exchange_remain_time(exchange_config.Id)
  local exchange_cost_list = exchange_config.Num
  local exchange_cost_list_length = #exchange_config.Num
  local exchange_cost_index = exchange_config.TriesLimit - left_time + 1
  local cost
  if exchange_cost_list_length < exchange_cost_index then
    cost = exchange_cost_list[exchange_cost_list_length]
  else
    cost = exchange_cost_list[exchange_cost_index]
  end
  return cost
end

function ui:show_item_use_panel()
  local item_type_config = ShareRes.create("item.item_subtype").stamina_item
  local type_id = item_type_config.TypeId
  local sub_type_id = item_type_config.SubtypeId
  local list = BagMgr:get_item_list_by_type(type_id, sub_type_id, 2)
  local all_item_cfg = ShareRes.create("item.item")
  self.v_uiobjects.NoneItem:SetActive(0 == #list)
  table.sort(list, function(a, b)
    if all_item_cfg[a.id].Priority ~= all_item_cfg[b.id].Priority then
      return all_item_cfg[a.id].Priority > all_item_cfg[b.id].Priority
    end
    return a.id > b.id
  end)
  self.v_medicament_item_list = {}
  for _, item_info in ipairs(list) do
    local item_id = item_info.id
    local item_count = item_info.count
    if item_count > 0 then
      local item_cfg = ShareRes.create("item.item", item_id)
      local item_quality_config = ShareRes.create("item.item_quality")
      local params = {item_cfg = item_cfg, item_info = item_info}
      _tinsert(self.v_medicament_item_list, params)
    end
  end
  table.sort(self.v_medicament_item_list, medicament_cmp)
  self:give_back_auto_cache(MIDICAMENT_KEY)
  self:release_items_by_template_key(FORCE_CHARGE_ITEM_OBJ)
  self.need_select_item_ui = nil
  self.v_uicompents.WiForceGet_txt.text = ""
  for i, item in pairs(self.v_medicament_item_list) do
    local item_id = item.item_info.id
    local item_count = item.item_info.count
    if item_count > 0 then
      local item_ui = self:get_auto_cache(MIDICAMENT_KEY)
      if not self.need_select_item_ui then
        self.need_select_item_ui = item_ui
      end
      Util.get_text("ItemAmount", Util.get_child_gameobj("AmountBg", item_ui)).text = item_count
      local quality_img = Util.get_image("ItemPz", item_ui)
      self:create_item_obj(nil, quality_img.gameObject, FORCE_CHARGE_ITEM_OBJ, {item_id = item_id})
      Util.get_child_gameobj("ItemReduce", item_ui):SetActive(false)
      Util.get_child_gameobj("ItemRemain", item_ui):SetActive(false)
      self.v_medicament_item_list[i].item_ui = item_ui
      local select_btn = Util.get_button_ex("ItemAdd", item_ui)
      self:set_button_listener(select_btn, function()
        local info = BagMgr:get_grid(item.item_info.uuid)
        self:_select_medicament_item(true, item.item_info, item_ui)
      end)
      self:set_button_ex_listener(select_btn, function()
        self.v_is_down = true
        self.v_down_time = 0
        self.v_cur_item_info = item.item_info
        self.v_cur_item_ui = item_ui
      end, function()
        self.v_is_down = false
      end, function()
        self.v_is_down = false
      end, function()
        self.v_is_down = false
      end)
      local de_select_btn = Util.get_button("ItemReduce", item_ui)
      self:set_button_listener(de_select_btn, function()
        local info = BagMgr:get_grid(item.item_info.uuid)
        self:_select_medicament_item(false, item.item_info, item_ui)
      end)
      self:_update_item_select_info(item.item_info.uuid, item_ui)
    end
  end
end

function ui:_select_medicament_item(is_add, item_info, item_ui, need_sp_count)
  local item_count = item_info.count
  local item_uuid = item_info.uuid
  local item_num = self:_calculate_item_num(item_info, need_sp_count)
  if not self.v_select_table[item_uuid] then
    local params = {
      num = item_num or 1,
      item_info = item_info
    }
    self.v_select_table[item_uuid] = params
  elseif is_add then
    if self.v_select_table[item_uuid].num == item_count then
      return
    else
      self.v_select_table[item_uuid].num = self.v_select_table[item_uuid].num + 1
    end
  else
    if not self.v_select_table[item_uuid].num or 0 == self.v_select_table[item_uuid].num then
      self.v_select_table[item_uuid] = nil
      return
    end
    local num = self.v_select_table[item_uuid].num
    if num > 1 then
      self.v_select_table[item_uuid].num = num - 1
    else
      self.v_select_table[item_uuid] = nil
    end
  end
  self:_update_item_select_info(item_uuid, item_ui)
end

function ui:_update_item_select_info(item_uuid, item_ui)
  if not self.v_select_table then
    return
  end
  local item_config = ShareRes.create("item.item")
  if self.v_select_table[item_uuid] ~= nil and self.v_select_table[item_uuid].num > 0 then
    Util.get_text("ItemReduce/ItemChoAmount", item_ui).text = self.v_select_table[item_uuid].num
    Util.get_child_gameobj("ItemReduce", item_ui):SetActive(true)
  else
    Util.get_child_gameobj("ItemReduce", item_ui):SetActive(false)
  end
  local add_sp_num = 0
  for _, item_data in pairs(self.v_select_table) do
    if item_data.num > 0 then
      local add_num_by_item = item_config[item_data.item_info.id].Arg[1]
      add_sp_num = add_sp_num + add_num_by_item * item_data.num
    end
  end
  local force_cfg = item_config[SP_ID]
  local force_name = force_cfg.Name
  if nil == next(self.v_select_table) then
    self.v_uicompents.WiForceGet_txt.text = ""
  else
    self.v_uicompents.WiForceGet_txt.text = Util.format_str("是否花费以上道具增加<color=#FF3030>{1}</color>{2}？", add_sp_num, force_name)
  end
  local sp_num = CharacterMgr:get_res_val(SP_ID)
  self.v_uicompents.ForcePreview_txt.text = sp_num + add_sp_num
end

function ui:update_item_time()
  for index, item_data in ipairs(self.v_medicament_item_list) do
    local item_ui = item_data.item_ui
    local item_cfg = item_data.item_cfg
    local item_info = item_data.item_info
    if item_info.end_time ~= nil and item_info.end_time > 0 then
      Util.get_child_gameobj("ItemRemain", item_ui):SetActive(true)
      Util.get_text("ItemRemain/ItemTime", item_ui).text = self:get_item_left_time(item_info)
    end
  end
end

function ui:get_item_left_time(item_info)
  local left_time = item_info.end_time - Date.server_time()
  if left_time < 0 then
    left_time = 0
  end
  return Util.format_str("{1}", Date.get_time_desc2(left_time, false))
end

function ui:remove_recover_timer()
  if self.v_recover_timer then
    CT_Timer:remove_timer(self.v_recover_timer)
    self.v_recover_timer = nil
  end
end

function ui:_add_recover_timer(remain_time, cur_show_id)
  self:remove_recover_timer()
  local RecoveryTime = ShareRes.create("item.item", cur_show_id).RecoveryTime
  local recovery_time_txt = Util.get_text(nil, self.v_recovery_time)
  local fullrecovery_time_txt = Util.get_text(nil, self.v_fullrecovery_time)
  recovery_time_txt.text = Date.get_print_count_down(remain_time % RecoveryTime, true)
  fullrecovery_time_txt.text = Date.get_print_count_down(remain_time, true)
  self.v_recover_timer = CT_Timer:add_timer("force_recover_timer", remain_time - 1, function(sec)
    local show_count = sec > 0
    if show_count and self.v_select == TOGGLE_TYPE.WAREHOUSE_EXCHANGE then
      local sp_num, sp_max_num = self:get_sp_info(SP_ID)
      if sp_num < sp_max_num then
        self.v_uiobjects.RecoveryTimeBg:SetActiveEx(false)
        fullrecovery_time_txt.text = Date.get_print_count_down(sec, true)
        return
      end
    end
    if show_count then
      recovery_time_txt.text = Date.get_print_count_down(sec % RecoveryTime, true)
      fullrecovery_time_txt.text = Date.get_print_count_down(sec, true)
    else
      self.v_recovery_time:SetActiveEx(false)
      self.v_uiobjects.RecoveryTimeTip:SetActiveEx(false)
      self.v_uiobjects.RecoveryTimeBg:SetActiveEx(false)
      self.v_fullrecovery_time:SetActiveEx(false)
      self.v_fullrecovery_tip:SetActiveEx(false)
      self.v_fullrecovery_text:SetActiveEx(true)
      self:remove_recover_timer()
    end
  end)
end

function ui:refresh_recover_time(last_recover_time, differ_force, cur_show_id)
  local RecoveryTime = ShareRes.create("item.item", cur_show_id).RecoveryTime
  local through_time = Date.server_time() - last_recover_time
  local remain_time = differ_force * RecoveryTime - through_time
  self:_add_recover_timer(remain_time, cur_show_id)
  if self.v_select == TOGGLE_TYPE.WAREHOUSE_EXCHANGE then
    self:show_warehouse_exchange_panel()
    local sp_num, sp_max_num = self:get_sp_info(SP_ID)
    self.v_uiobjects.RecoveryTimeBg:SetActiveEx(sp_max_num <= sp_num)
  else
    self.v_uiobjects.RecoveryTimeBg:SetActiveEx(true)
  end
  self.v_recovery_time:SetActiveEx(true)
  self.v_uiobjects.RecoveryTimeTip:SetActiveEx(true)
  self.v_fullrecovery_time:SetActiveEx(true)
  self.v_fullrecovery_tip:SetActiveEx(true)
  self.v_fullrecovery_text:SetActiveEx(false)
end

function ui:operation_count(is_add)
  local cur_count = self.v_exchange_count
  local target_count = is_add and cur_count + 1 or cur_count - 1
  local max_count = BagMgr:get_item_num(self.v_cost_item)
  if target_count < 1 or target_count > max_count then
    return
  end
  self.v_exchange_count = target_count
  self:refresh_count()
end

function ui:refresh_count(value)
  local max_count = BagMgr:get_item_num(self.v_cost_item)
  if value then
    self.v_exchange_count = math.floor(value)
  else
    self.v_uicompents.SetNumSlider_sld:SetValueWithoutNotify(self.v_exchange_count)
  end
  local max_value = math.max(1, max_count)
  if 1 ~= max_value then
    self.v_uicompents.SetNumSlider_sld.minValue = 1
    self.v_uicompents.SetNumSlider_sld.interactable = true
  else
    self.v_uicompents.SetNumSlider_sld.minValue = 0
    self.v_uicompents.SetNumSlider_sld.interactable = false
  end
  self.v_uicompents.SetNumSlider_sld.maxValue = max_value
  self.v_uicompents.TakeOutStoreNum_txt.text = self.v_exchange_count
  local sp_num = CharacterMgr:get_res_val(SP_ID)
  local exchange_config = ShareRes.get_item_exchange_cfg(self.v_exchange_id)
  local exchange_num = exchange_config.Count
  self.v_uicompents.ForcePreview_txt.text = sp_num + exchange_num * self.v_exchange_count
end

function ui:_calculate_item_num(item_info, need_sp_count)
  if not need_sp_count then
    self.v_is_sp_enough = true
    return nil
  else
    local item_can_get_sp_num = ShareRes.get_item_cfg(item_info.id).Arg[1]
    local need_num = math.ceil(need_sp_count / item_can_get_sp_num)
    if not need_sp_count then
      return nil
    elseif need_num > item_info.count then
      self.v_curr_need_sp_count = need_sp_count - item_can_get_sp_num * item_info.count
      return item_info.count
    else
      self.v_is_sp_enough = true
      return need_num
    end
  end
end

return ui
