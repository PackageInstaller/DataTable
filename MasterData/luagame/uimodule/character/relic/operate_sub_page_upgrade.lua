local Base = require("ui.uiobject")
local CommonDefine = require("cs_share.common_define")
local RELIC_ENTRY_TYPE = CommonDefine.RELIC_ENTRY_TYPE
local _tinsert = table.insert
local _tsort = table.sort
local RELIC_OPERATE_UPGRADE_ATTR_KEY = "RELIC_OPERATE_UPGRADE_ATTR_KEY"
local Shop_Helper = require("uimodule.shop.shop_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local COIN_ITEMID = Config.COIN_ITEMID
local Drop_Down_Type2_Quality = {
  [1] = 3,
  [2] = 4
}
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_asset_bar = {
    "AssetBar",
    BIND_TYPE.OBJECT
  },
  v_attr_content = {
    "AttrContent",
    BIND_TYPE.OBJECT
  },
  v_attr_temp = {
    "AttrTemp",
    BIND_TYPE.OBJECT
  },
  v_btn_clear = {
    "BtnClear",
    BIND_TYPE.BUTTON
  },
  v_btn_drop_down = {
    "BtnDropDown",
    BIND_TYPE.BUTTON
  },
  v_btn_enhance = {
    "BtnEnhance",
    BIND_TYPE.BUTTON
  },
  v_btn_quickput_in = {
    "BtnQuickputIn",
    BIND_TYPE.BUTTON
  },
  v_cost_tem1 = {
    "CostTem1",
    BIND_TYPE.OBJECT
  },
  v_cost_tem2 = {
    "CostTem2",
    BIND_TYPE.OBJECT
  },
  v_cost_tem3 = {
    "CostTem3",
    BIND_TYPE.OBJECT
  },
  v_cost_tem4 = {
    "CostTem4",
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
  v_drop_down_arrow = {
    "DropDownArrow",
    BIND_TYPE.IMAGE
  },
  v_drop_down_list = {
    "DropDownList",
    BIND_TYPE.IMAGE
  },
  v_drop_down_text = {
    "DropDownText",
    BIND_TYPE.TEXT
  },
  v_drop_down_tog1 = {
    "DropDownTog1",
    BIND_TYPE.TOGGLE
  },
  v_drop_down_tog2 = {
    "DropDownTog2",
    BIND_TYPE.TOGGLE
  },
  v_drop_down_txt1 = {
    "DropDownTxt1",
    BIND_TYPE.TEXT
  },
  v_drop_down_txt2 = {
    "DropDownTxt2",
    BIND_TYPE.TEXT
  },
  v_engrave_name = {
    "EngraveName",
    BIND_TYPE.TEXT
  },
  v_exp_add_num = {
    "ExpAddNum",
    BIND_TYPE.TEXT
  },
  v_exp_add = {
    "ExpAdd",
    BIND_TYPE.OBJECT
  },
  v_exp_add_silder = {
    "ExpAdd_Silder",
    BIND_TYPE.IMAGE
  },
  v_exp_max = {
    "ExpMax",
    BIND_TYPE.TEXT
  },
  v_exp_now = {
    "ExpNow",
    BIND_TYPE.TEXT
  },
  v_exp_silder = {
    "Exp_Silder",
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
  v_lv_max = {
    "LvMax",
    BIND_TYPE.TEXT
  },
  v_lv_now = {
    "LvNow",
    BIND_TYPE.TEXT
  },
  v_new_deputy_attr = {
    "NewDeputyAttr",
    BIND_TYPE.IMAGE
  },
  v_new_deputy_text = {
    "NewDeputyText",
    BIND_TYPE.TEXT
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
    self:on_click_up_lv()
  end)
  self:set_button("BtnClear", function()
    self:clear_all_consume()
  end)
  self:set_button("BtnQuickputIn", function()
    self:on_click_quick()
  end)
  self:set_button("BtnDropDown", function()
    self:set_drop_down_expand(not self.v_uiobjects.DropDownList.activeSelf)
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
  self:set_toggle("DropDownTog1", function(is_on)
    if not is_on then
      return
    end
    self:refresh_drop_down(1)
  end)
  self:set_toggle("DropDownTog2", function(is_on)
    if not is_on then
      return
    end
    self:refresh_drop_down(2)
  end)
  self.v_asset_bar_view = AssetBarView:new(self, self.v_asset_bar)
  self:register_exist_auto_template(RELIC_OPERATE_UPGRADE_ATTR_KEY, self.v_attr_temp, self.v_attr_content)
end

function ui:ui_on_hide()
  self:clear_all_consume()
  self.v_asset_bar_view:on_hide()
end

function ui:ui_on_destroy()
  self:clear_all_consume()
  self.v_asset_bar_view:on_destory()
end

function ui:ui_on_show()
  local list = Shop_Helper.get_asset_list({COIN_ITEMID})
  self.v_asset_bar_view:reset_config(list)
  self.v_asset_bar_view:on_create()
end

function ui:refresh(uuid, operate_buddy_id, is_bag)
  self.v_uuid = uuid
  self.v_buddy_id = operate_buddy_id
  self.v_is_bag = is_bag
  self:refresh_view()
end

function ui:refresh_view()
  self.v_relic_data = RelicMgr:get_relic_data_by_uuid(self.v_uuid)
  self.v_max_lv = ShareRes.get_relic_max_lv(self.v_relic_data.id)
  if self.v_max_lv <= self.v_relic_data.lv then
    self.v_parent_ui:on_click_return()
    return
  end
  self.v_relic_cfg = ShareRes.get_relic_cfg(self.v_relic_data.id)
  self.v_relic_lv_cfg = ShareRes.create("relic.relic_level", self.v_relic_cfg.Quality)
  local quality_cfg = ShareRes.get_equip_icon_cfg(self.v_relic_cfg.Quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  ResMgr:load_set_icon(self.vquality, path)
  self.v_engrave_name.text = self.v_relic_cfg.Name
  local is_lock = 1 == self.v_relic_data.lock
  self:update_lock_state(is_lock)
  self.v_add_exp, self.v_add_lv, self.v_cost_coin = self:calculate_add_exp()
  self:refresh_exp_bar()
  self:refresh_attr_list()
  self:refresh_attr_add()
  self:refresh_drop_down()
  self:refresh_consume_layout()
  self:refresh_btns()
end

function ui:update_lock_state(is_lock)
  self.v_uiobjects.UnlockIcon:SetActive(not is_lock)
  self.v_uiobjects.LockIcon:SetActive(is_lock)
end

function ui:refresh_exp_bar()
  local color = self.v_add_lv > 0 and "<color=#fda300>" or "<color=#ffffff>"
  self.v_lv_now.text = string.format("%s%s</color>", color, self.v_relic_data.lv + self.v_add_lv)
  self.v_lv_max.text = self.v_max_lv
  local cur_lv_max_exp = self.v_relic_lv_cfg[self.v_relic_data.lv].Exp
  local is_max = self.v_max_lv <= self.v_relic_data.lv
  self.v_exp_max.text = is_max and "--" or cur_lv_max_exp
  self.v_exp_now.text = is_max and "--" or self.v_relic_data.exp
  self.v_exp_add:SetActive(self.v_add_exp > 0)
  if self.v_add_exp > 0 then
    self.v_exp_add_num.text = "+" .. self.v_add_exp
  end
  self.v_exp_add_silder.fillAmount = is_max and 0 or (self.v_relic_data.exp + self.v_add_exp) / cur_lv_max_exp
  self.v_exp_silder.fillAmount = is_max and 1 or self.v_relic_data.exp / cur_lv_max_exp
end

function ui:calculate_add_exp()
  if self.v_max_lv <= self.v_relic_data.lv then
    return 0, 0, 0
  end
  self.v_consume_list = self.v_parent_ui:get_selected_consume_list()
  if not self.v_consume_list or not next(self.v_consume_list) then
    return 0, 0, 0
  end
  local add_exp = 0
  for _, consume in ipairs(self.v_consume_list) do
    if consume.relic_uuid then
      local relic_data = RelicMgr:get_relic_data_by_uuid(consume.relic_uuid)
      add_exp = add_exp + self:calculate_replace_exp(relic_data)
    else
      local exp_item_cfg = ShareRes.create("relic.relic_item", consume.exp_item_id)
      add_exp = add_exp + exp_item_cfg.Exp * consume.num
    end
  end
  local add_lv = 0
  local exp_count = self.v_relic_data.exp + add_exp
  for lv = self.v_relic_data.lv, self.v_max_lv - 1 do
    exp_count = exp_count - self.v_relic_lv_cfg[lv].Exp
    if exp_count < 0 then
      break
    end
    add_lv = add_lv + 1
  end
  local cost_coin = 0
  if 0 ~= add_lv then
    for lv = self.v_relic_data.lv, self.v_relic_data.lv + add_lv - 1 do
      cost_coin = cost_coin + self.v_relic_lv_cfg[lv].Gold
    end
  end
  return add_exp, add_lv, cost_coin
end

function ui:refresh_attr_list()
  local attr_list = {}
  for _, entry in ipairs(self.v_relic_data.entrys) do
    local relic_entry_cfg = ShareRes.create("relic.relic_entry", entry.entry_id)
    local attr_id, val, next_val = relic_entry_cfg.AttrId, relic_entry_cfg.BaseAttr
    if entry.type == RELIC_ENTRY_TYPE.PRINCIPAL then
      if self.v_add_lv > 0 then
        next_val = val + (self.v_relic_data.lv + self.v_add_lv) * relic_entry_cfg.LevelAttr
      end
      val = val + self.v_relic_data.lv * relic_entry_cfg.LevelAttr
    end
    _tinsert(attr_list, {
      attr_id = attr_id,
      val = val,
      next_val = next_val,
      type = entry.type,
      idx = entry.id
    })
  end
  self:give_back_auto_cache(RELIC_OPERATE_UPGRADE_ATTR_KEY)
  for _, attr_data in ipairs(attr_list) do
    local attr_id = attr_data.attr_id
    local val = attr_data.val
    local next_val = attr_data.next_val
    local item = self:get_auto_cache(RELIC_OPERATE_UPGRADE_ATTR_KEY)
    local main_attr_bg = Util.get_child_gameobj("MainAttrBg", item)
    local icon = Util.get_image("AttrIcon", item)
    local name_txt = Util.get_text("AttrName", item)
    local arrow_obj = Util.get_child_gameobj("Arrow", item)
    local pre_val_txt = Util.get_text("AttrValBefore", item)
    local next_val_txt = Util.get_text("AttrVal", item)
    main_attr_bg:SetActive(attr_data.type == RELIC_ENTRY_TYPE.PRINCIPAL)
    arrow_obj:SetActive(nil ~= next_val)
    pre_val_txt.gameObject:SetActive(nil ~= next_val)
    if not next_val then
      pre_val_txt, next_val_txt = next_val_txt, pre_val_txt
    end
    local icon_name = ShareRes.get_attr_icon(attr_id)
    if icon_name then
      Util.load_attr_icon(icon, icon_name)
    end
    local icon_color = attr_data.type == RELIC_ENTRY_TYPE.PRINCIPAL and "ffda9d" or "b19f89"
    icon.color = Util.get_unity_color_by_hex(tonumber(icon_color, 16))
    local color_str = attr_data.type == RELIC_ENTRY_TYPE.PRINCIPAL and "#ffda9d" or "#ffffff"
    name_txt.text = string.format("<color=%s>%s</color>", color_str, ShareRes.get_attr_name(attr_id))
    local is_ration = ShareRes.get_is_ration_attr(attr_id)
    local val_str = is_ration and string.format("%.2f%%", val / 100) or Util.round(val)
    pre_val_txt.text = string.format("<color=%s>%s</color>", color_str, val_str)
    if next_val then
      color_str = "#fda300"
      next_val = is_ration and string.format("%.2f%%", next_val / 100) or Util.round(next_val)
      next_val_txt.text = string.format("<color=%s>%s</color>", color_str, next_val)
    end
  end
end

function ui:refresh_attr_add()
  local cond_list = {
    10,
    20,
    30
  }
  local attr_unlock_num = 0
  local next_lv = self.v_relic_data.lv + self.v_add_lv
  for i, unlock_lv in pairs(cond_list) do
    if unlock_lv > self.v_relic_data.lv and unlock_lv <= next_lv then
      attr_unlock_num = attr_unlock_num + 1
    end
  end
  self.v_uiobjects.NewDeputyAttr:SetActive(attr_unlock_num > 0)
  self.v_new_deputy_text.text = Util.format_str("新增{1}条随机属性", attr_unlock_num)
end

function ui:refresh_drop_down(drop_down_type)
  if drop_down_type then
    self.v_drop_down_type = drop_down_type
  end
  self.v_drop_down_type = self.v_drop_down_type or 1
  self.v_drop_down_text.text = self["v_drop_down_txt" .. self.v_drop_down_type].text
  self:set_drop_down_expand(false)
end

function ui:refresh_consume_layout()
  self.v_consume_list = self.v_parent_ui:get_selected_consume_list()
  for idx = 1, 4 do
    self:set_consume_item(self["v_cost_tem" .. idx], self.v_consume_list[idx])
  end
end

function ui:set_consume_item(item, data)
  local null_obj = Util.get_child_gameobj("CostNull_", item)
  local item_obj = Util.get_child_gameobj("CostItem_", item)
  local quality_img = Util.get_image("CostItem_/ItemQuality_", item)
  local icon_img = Util.get_image("CostItem_/ItemIcon_", item)
  local lv_txt = Util.get_text("CostItem_/Lower/Lv_", item)
  local num_txt = Util.get_text("CostItem_/Lower/ItemNum_", item)
  local btn_del = Util.get_button("BtnDel_", item)
  local has_data = nil ~= data
  null_obj:SetActive(not has_data)
  item_obj:SetActive(has_data)
  btn_del.gameObject:SetActive(has_data)
  if not has_data then
    return
  end
  local is_exp_item = nil ~= data.exp_item_id
  lv_txt.gameObject:SetActive(not is_exp_item)
  num_txt.gameObject:SetActive(is_exp_item)
  if is_exp_item then
    local own_num = BagMgr:get_item_num(data.exp_item_id)
    local icon_path, quality_path = UtilUI.get_item_images(data.exp_item_id)
    ResMgr:load_set_icon(icon_img, icon_path)
    ResMgr:load_set_icon(quality_img, quality_path)
    num_txt.text = Util.format_str("{1}/{2}", data.num, own_num)
  else
    local relic_data = RelicMgr:get_relic_data_by_uuid(data.relic_uuid)
    local cfg = ShareRes.get_relic_cfg(relic_data.id)
    local icon_path, quality_path = UtilUI.get_item_images(relic_data.id)
    ResMgr:load_set_icon(quality_img, quality_path)
    ResMgr:load_set_icon(icon_img, icon_path)
    lv_txt.text = Util.format_str("LV.{1}", relic_data.lv)
  end
  self:set_button_listener(btn_del, function()
    if is_exp_item then
      self.v_parent_ui:on_click_exp_item(data.exp_item_id, true)
    else
      self.v_parent_ui:on_click_relic(data.relic_uuid)
    end
  end)
end

function ui:set_suit_desc_obj(idx, suit_sub_cfg)
  local suit_obj = Util.get_child_gameobj("SuitEffect" .. idx, self.v_suit_group)
  local need_num = suit_sub_cfg.Count[idx]
  suit_obj:SetActive(nil ~= suit_sub_cfg)
  local suit_desc = Util.get_text(nil, suit_obj)
  suit_desc.text = Util.format_str("{1}件套：{2}", need_num, suit_sub_cfg.Desc)
  local is_actiive = need_num <= self.v_suit_active_count
  local canvas_group = Util.get_canvas_group(nil, suit_obj)
  local act_obj = Util.get_child_gameobj("SuitState/Active", suit_obj)
  local not_act_obj = Util.get_child_gameobj("SuitState/NoActive", suit_obj)
  canvas_group.alpha = is_actiive and 1 or 0.3
  act_obj:SetActive(is_actiive)
  not_act_obj:SetActive(not is_actiive)
end

function ui:refresh_btns()
  local own_coin = BagMgr:get_item_num(COIN_ITEMID)
  self.v_coin_enough = own_coin >= self.v_cost_coin
  if self.v_coin_enough then
    local cost_str = 0 == self.v_cost_coin and "--------" or self.v_cost_coin
    self.v_curr_num.text = "<color=#ffffff>" .. cost_str .. "</color>"
  else
    self.v_curr_num.text = "<color=#e0212c>" .. self.v_cost_coin .. "</color>"
  end
  ResMgr:load_set_icon(self.v_curr_icon, UtilUI.get_item_icon(COIN_ITEMID))
  self.v_uiobjects.BtnClear:SetActive(0 ~= self.v_add_exp)
  self.v_uiobjects.BtnQuickputIn:SetActive(0 == self.v_add_exp)
  Util.apply_grey_ex(self.v_uiobjects.BtnEnhance, 0 == self.v_add_exp or not self.v_coin_enough)
end

function ui:on_click_up_lv()
  if 0 == self.v_add_exp then
    Util.show_message_tip(2352)
    return
  elseif not self.v_coin_enough then
    Util.show_message_tip(2314, UtilUI.get_item_name(COIN_ITEMID))
    return
  end
  local exp_item_list = {}
  local relic_item_list = {}
  for _, consume in ipairs(self.v_consume_list) do
    if consume.relic_uuid then
      _tinsert(relic_item_list, consume.relic_uuid)
    else
      _tinsert(exp_item_list, {
        id = consume.exp_item_id,
        count = consume.num
      })
    end
  end
  local old_lv = self.v_relic_data.lv
  self.v_parent_ui:set_cannot_touch(true)
  RelicMgr:req_c2gs_relic_up_level(self.v_uuid, exp_item_list, relic_item_list, function(ok)
    if ok then
      self:clear_all_consume()
      self.v_relic_data = RelicMgr:get_relic_data_by_uuid(self.v_uuid)
      if old_lv < self.v_relic_data.lv then
        Util.show_message_tip(2143)
      end
    end
    self.v_parent_ui:start_cannot_touch_timer()
  end)
end

function ui:clear_all_consume()
  self.v_parent_ui:clear_all_consume()
end

function ui:on_click_quick()
  local max_need_exp = -self.v_relic_data.exp
  for lv = self.v_relic_data.lv, self.v_max_lv - 1 do
    max_need_exp = max_need_exp + self.v_relic_lv_cfg[lv].Exp
  end
  local consume_list = {}
  local relic_item_cfg = UtilTable.copy_table(ShareRes.create("relic.relic_item"))
  _tsort(relic_item_cfg, function(a, b)
    return a.id > b.id
  end)
  for exp_item_id, cfg in pairs(relic_item_cfg) do
    local own_num = BagMgr:get_item_num(exp_item_id)
    if #consume_list <= 4 and max_need_exp > 0 and own_num > 0 then
      local use_num = 0
      for i = 1, own_num do
        if max_need_exp <= 0 then
          break
        end
        max_need_exp = max_need_exp - cfg.Exp
        use_num = use_num + 1
      end
      _tinsert(consume_list, {exp_item_id = exp_item_id, num = use_num})
    end
  end
  if #consume_list < 4 and max_need_exp > 0 then
    local relic_list = {}
    local all_relic_data = RelicMgr:get_all_relic_data()
    for _, data in pairs(all_relic_data) do
      if data.uuid ~= self.v_uuid and 1 ~= data.lock and 1 == data.lv and 0 == data.exp and 0 == data.buddy_id then
        local cfg = ShareRes.get_relic_cfg(data.id)
        local quality = cfg.Quality
        if quality <= Drop_Down_Type2_Quality[self.v_drop_down_type] then
          _tinsert(relic_list, {
            data = data,
            id = data.id,
            quality = quality,
            slot = cfg.Slot
          })
        end
      end
    end
    _tsort(relic_list, function(a, b)
      if a.quality ~= b.quality then
        return a.quality < b.quality
      end
      if a.slot ~= b.slot then
        return a.slot < b.slot
      end
      if a.id ~= b.id then
        return a.id < b.id
      end
      return a.data.uuid < b.data.uuid
    end)
    for _, data in ipairs(relic_list) do
      if #consume_list < 4 and max_need_exp > 0 then
        max_need_exp = max_need_exp - self:calculate_replace_exp(data.data)
        _tinsert(consume_list, {
          relic_uuid = data.data.uuid
        })
      end
    end
  end
  if 0 == #consume_list then
    Util.show_message_tip(2263)
  else
    self.v_parent_ui:set_consume_list(consume_list)
  end
end

function ui:calculate_replace_exp(relic_data)
  local relic_cfg = ShareRes.get_relic_cfg(relic_data.id)
  local cost_exp = relic_data.exp
  local exp_rev_cfg = ShareRes.create("relic.relic_replace_exp", relic_cfg.Quality)
  if relic_data.lv > 1 then
    local lv_cfg = ShareRes.create("relic.relic_level", relic_cfg.Quality)
    for lv = 1, relic_data.lv - 1 do
      cost_exp = cost_exp + lv_cfg[lv].Exp
    end
  end
  return exp_rev_cfg.BaseExp + Util.round(cost_exp * exp_rev_cfg.ExpPercent / 10000)
end

function ui:set_drop_down_expand(if_expand)
  self.v_uiobjects.DropDownList:SetActive(if_expand)
  local rot_z = if_expand and 270 or 0
  self.v_drop_down_arrow.transform:SetEuler(0, 0, rot_z)
end

return ui
