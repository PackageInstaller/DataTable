local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local icon_path_prefix = "Icon/item/%s"
local Quality_Img = {
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}
local award_background_png = "Zhanlin_db_kzjl_02.png"
local AWARD_TYPE = {
  none = 1,
  receive = 2,
  received = 3
}
local bg_png = {
  "UIOrder/Zhanlin_db_kzjl_01",
  "UIOrder/Zhanlin_db_kzjl_02"
}
local prefix = {"SP1", "SP2"}

function ui:ui_finish_load()
  self.v_senior_award_obj_list = {
    self.v_uiobjects.SPAward1,
    self.v_uiobjects.SPAward2
  }
  self.v_senior_award_btn_list = {
    self.v_uicompents.SPAward1_btn,
    self.v_uicompents.SPAward2_btn
  }
end

function ui:ui_on_show()
end

function ui:ui_on_destroy()
end

function ui:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function ui:set_data(go, data_list, index, special)
  self.v_goods_data = data_list[index]
  self.v_obj = go
  self.v_goods_idx = index
  local go_name = go.name
  self.v_uicompents.Lv_txt.text = self.v_goods_data.Level
  local normal_award_select = self.v_goods_data.SelectAward or false
  local senior_award_select = self.v_goods_data.SelectSeniorAward or false
  local normal_award_list = ShareRes.get_awards(normal_award_select or self.v_goods_data.Award)
  local senior_award_list = ShareRes.get_awards(self.v_goods_data.SeniorAward)
  senior_award_list = senior_award_list or {}
  if senior_award_select then
    senior_award_list[2] = nil
    table.insert(senior_award_list, {isSelectAward = true, id = senior_award_select})
  end
  self.v_uiobjects.BasicAward:SetActive(false)
  self.v_uiobjects.SPAward1:SetActive(false)
  self.v_uiobjects.SPAward2:SetActive(false)
  local normal_award_got_map, senior_award_got_map, normal_select_award_got_map, senior_select_award_got_map = PassPortMgr:get_award_got_map()
  local passport_lv = PassPortMgr:get_lv()
  if not special then
    local idx = self.v_goods_data.Level == passport_lv and 2 or 1
    ResMgr:load_set_icon_sync(self.v_uicompents.Bg_img, bg_png[idx])
  end
  if normal_award_list then
    for _, value in ipairs(normal_award_list) do
      local item_id = value.ItemId
      local item_cfg = ShareRes.get_item_cfg(item_id)
      local item_quality = self.v_uicompents.BasicItemQuality_img
      local icon_img = self.v_uicompents.BasicItemIcon_img
      local amount_txt = self.v_uicompents.BasicAmount_txt
      local Fx_ItemIcon_Order = Util.get_child_gameobj("Fx_ItemIcon_Order_", self.v_uiobjects.BasicAward)
      if normal_award_select then
        ResMgr:load_set_icon_sync(item_quality, Quality_Img[5])
        ResMgr:load_set_icon_sync(icon_img, self.v_goods_data.SelectAwardIcon)
        amount_txt.text = 1
        Fx_ItemIcon_Order:SetActiveEx(true)
      else
        local icon_path = string.format(icon_path_prefix, item_cfg.Icon)
        ResMgr:load_set_icon_sync(item_quality, Quality_Img[item_cfg.Quality])
        ResMgr:load_set_icon_sync(icon_img, icon_path)
        amount_txt.text = value.Num
        Fx_ItemIcon_Order:SetActiveEx(false)
      end
      self.v_uiobjects.BasicAward:SetActive(true)
      local got_obj = self.v_uiobjects.BasicGot
      local redpoint_obj = self.v_uiobjects.BasicRedPoint
      local lock_obj = self.v_uiobjects.BasicLock
      got_obj:SetActive(normal_award_select and normal_select_award_got_map[index] or not normal_award_select and normal_award_got_map[self.v_goods_data.Level])
      lock_obj:SetActive(passport_lv < self.v_goods_data.Level)
      redpoint_obj:SetActive(not got_obj.activeSelf and not lock_obj.activeSelf)
      self:set_button_listener(self.v_uicompents.BasicAward_btn, function()
        if self.v_linked_parent:get_user_data().lv < self.v_goods_idx then
          if normal_award_select then
            UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(true, normal_award_select)
          else
            UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
          end
        else
          if got_obj.activeSelf then
            return
          end
          PassPortMgr:get_lv_award(self.v_goods_data.Level)
        end
      end)
    end
  end
  if senior_award_list then
    for index, value in ipairs(senior_award_list) do
      local item_id = value.ItemId
      local item_cfg = ShareRes.get_item_cfg(item_id)
      local item_quality = self.v_uicompents[prefix[index] .. "ItemQuality_img"]
      local icon_img = self.v_uicompents[prefix[index] .. "ItemIcon_img"]
      local amount_txt = self.v_uicompents[prefix[index] .. "Amount_txt"]
      local Fx_ItemIcon_Order = Util.get_child_gameobj("Fx_ItemIcon_Order_", self.v_senior_award_obj_list[index])
      if value.isSelectAward then
        ResMgr:load_set_icon_sync(item_quality, Quality_Img[5])
        ResMgr:load_set_icon_sync(icon_img, self.v_goods_data.SelectSeniorAwardIcon)
        amount_txt.text = 1
        Fx_ItemIcon_Order:SetActiveEx(true)
      else
        local icon_path = string.format(icon_path_prefix, item_cfg.Icon)
        ResMgr:load_set_icon_sync(item_quality, Quality_Img[item_cfg.Quality])
        ResMgr:load_set_icon_sync(icon_img, icon_path)
        amount_txt.text = value.Num
        Fx_ItemIcon_Order:SetActiveEx(false)
      end
      self.v_senior_award_obj_list[index]:SetActive(true)
      local got_obj = self.v_uiobjects[prefix[index] .. "Got"]
      local redpoint_obj = self.v_uiobjects[prefix[index] .. "RedPoint"]
      local lock_obj = self.v_uiobjects[prefix[index] .. "Lock"]
      got_obj:SetActive(value.isSelectAward and senior_select_award_got_map[self.v_goods_idx] or not value.isSelectAward and senior_award_got_map[self.v_goods_data.Level])
      lock_obj:SetActive(passport_lv < self.v_goods_data.Level or not PassPortMgr:is_senior())
      redpoint_obj:SetActive(not got_obj.activeSelf and not lock_obj.activeSelf)
      self:set_button_listener(self.v_senior_award_btn_list[index], function()
        if self.v_linked_parent:get_user_data().lv < self.v_goods_idx or not PassPortMgr:is_senior() then
          if value.isSelectAward then
            UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(true, value.id)
          else
            UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
          end
        else
          if got_obj.activeSelf then
            return
          end
          PassPortMgr:get_lv_award(self.v_goods_data.Level)
        end
      end)
    end
  end
end

function ui:set_data_old(param, parent, special)
  self.v_parent_luaclass = parent
  self.v_uicompents.Lv_txt.text = param.Level
  local normal_award_select = param.SelectAward or false
  local senior_award_select = param.SelectSeniorAward or false
  local normal_award_list = ShareRes.get_awards(normal_award_select or param.Award)
  local senior_award_list = ShareRes.get_awards(param.SeniorAward)
  senior_award_list = senior_award_list or {}
  if senior_award_select then
    senior_award_list[2] = nil
    table.insert(senior_award_list, {isSelectAward = true, id = senior_award_select})
  end
  self.v_uiobjects.BasicAward:SetActive(false)
  self.v_uiobjects.SPAward1:SetActive(false)
  self.v_uiobjects.SPAward2:SetActive(false)
  local normal_award_got_map, senior_award_got_map, normal_select_award_got_map, senior_select_award_got_map = PassPortMgr:get_award_got_map()
  local passport_lv = PassPortMgr:get_lv()
  if not special then
    local idx = param.Level == passport_lv and 2 or 1
    ResMgr:load_set_icon(self.v_uicompents.Bg_img, bg_png[idx])
  end
  if normal_award_list then
    for _, value in ipairs(normal_award_list) do
      local item_id = value.ItemId
      local item_cfg = ShareRes.get_item_cfg(item_id)
      local item_quality = Util.get_image("ItemQuality", self.v_uiobjects.BasicAward)
      local icon_img = Util.get_image("ItemIcon", self.v_uiobjects.BasicAward)
      local amount_txt = Util.get_text("Amount", self.v_uiobjects.BasicAward)
      if normal_award_select then
        ResMgr:load_set_icon(item_quality, Quality_Img[5])
        ResMgr:load_set_icon(icon_img, param.SelectAwardIcon)
        amount_txt.text = 1
      else
        local icon_path = string.format(icon_path_prefix, item_cfg.Icon)
        ResMgr:load_set_icon(item_quality, Quality_Img[item_cfg.Quality])
        ResMgr:load_set_icon(icon_img, icon_path)
        amount_txt.text = value.Num
      end
      self.v_uiobjects.BasicAward:SetActive(true)
      local got_obj = Util.get_child_gameobj("Got", self.v_uiobjects.BasicAward)
      local redpoint_obj = Util.get_child_gameobj("RedPoint", self.v_uiobjects.BasicAward)
      local lock_obj = Util.get_child_gameobj("Lock", self.v_uiobjects.BasicAward)
      got_obj:SetActive(normal_award_select and normal_select_award_got_map[param.Level] or not normal_award_select and normal_award_got_map[param.Level])
      lock_obj:SetActive(passport_lv < param.Level)
      redpoint_obj:SetActive(not got_obj.activeSelf and not lock_obj.activeSelf)
      self:set_button_listener(self.v_uicompents.BasicAward_btn, function()
        if self.v_parent_luaclass:get_user_data().lv < param.Level then
          if normal_award_select then
            UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(true, normal_award_select)
          else
            UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
          end
        else
          if got_obj.activeSelf then
            return
          end
          PassPortMgr:get_lv_award(param.Level)
        end
      end)
    end
  end
  if senior_award_list then
    for index, value in ipairs(senior_award_list) do
      local item_id = value.ItemId
      local item_cfg = ShareRes.get_item_cfg(item_id)
      local item_quality = Util.get_image("ItemQuality", self.v_senior_award_obj_list[index])
      local icon_img = Util.get_image("ItemIcon", self.v_senior_award_obj_list[index])
      local amount_txt = Util.get_text("Amount", self.v_senior_award_obj_list[index])
      if value.isSelectAward then
        ResMgr:load_set_icon(item_quality, Quality_Img[5])
        ResMgr:load_set_icon(icon_img, param.SelectSeniorAwardIcon)
        amount_txt.text = 1
      else
        local icon_path = string.format(icon_path_prefix, item_cfg.Icon)
        ResMgr:load_set_icon(item_quality, Quality_Img[item_cfg.Quality])
        ResMgr:load_set_icon(icon_img, icon_path)
        amount_txt.text = value.Num
      end
      self.v_senior_award_obj_list[index]:SetActive(true)
      local got_obj = Util.get_child_gameobj("Got", self.v_senior_award_obj_list[index])
      local redpoint_obj = Util.get_child_gameobj("RedPoint", self.v_senior_award_obj_list[index])
      local lock_obj = Util.get_child_gameobj("Lock", self.v_senior_award_obj_list[index])
      got_obj:SetActive(value.isSelectAward and senior_select_award_got_map[param.Level] or not value.isSelectAward and senior_award_got_map[param.Level])
      lock_obj:SetActive(passport_lv < param.Level or not PassPortMgr:is_senior())
      redpoint_obj:SetActive(not got_obj.activeSelf and not lock_obj.activeSelf)
      self:set_button_listener(self.v_senior_award_btn_list[index], function()
        if self.v_parent_luaclass:get_user_data().lv < param.Level or not PassPortMgr:is_senior() then
          if value.isSelectAward then
            UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(true, value.id)
          else
            UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
          end
        else
          if got_obj.activeSelf then
            return
          end
          PassPortMgr:get_lv_award(param.Level)
        end
      end)
    end
  end
end

function ui:request_get_passport_award_callback(lv, is_senior)
  local battle_passport_cfg = ShareRes.get_battle_passport_cfg(PassPortMgr:get_passport_data().id)
  local cfg = ShareRes.get_battle_passport_group_cfg(battle_passport_cfg.Group)[lv]
  UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(false, is_senior and cfg.SelectSeniorAward or cfg.SelectAward, lv, is_senior)
end

function ui:check_select_award(lv)
  local battle_passport_cfg = ShareRes.get_battle_passport_cfg(PassPortMgr:get_passport_data().id)
  local cfg = ShareRes.get_battle_passport_group_cfg(battle_passport_cfg.Group)[lv]
  if cfg.SelectAward then
    UIMgr:get_ui("ui_monthtask_award_choice"):ui_show(false, cfg.SelectAward, lv, false)
  end
end

return ui
