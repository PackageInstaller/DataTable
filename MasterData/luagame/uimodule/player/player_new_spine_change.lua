local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local SIGNBOARD_PARAM = Config.SIGNBOARD_PARAM
local SIGNBOARD_BUDDY_ROLE_KEY = "signboard_buddy_role_key"
local SIGNBOARD_BUDDY_ROLE_FILTER_KEY = "signboard_buddy_role_filter_key"
local SIGNBOARD_BUDDY_ROLE_FILTER_LIST_KEY = "signboard_buddy_role_filter_list_key"
local Char_Helper = require("uimodule.character.char_helper")
local CharacterConfig = require("uimodule.character.character_config")
local SORT_RULE = CharacterConfig.SORT_RULE
local MODEL = {
  v_buddy_list = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_buddy_template = {
    "Template",
    BIND_TYPE.OBJECT
  },
  v_filter_content = {
    "FilterContent",
    BIND_TYPE.OBJECT
  },
  v_filter_template = {
    "FilterSelect",
    BIND_TYPE.OBJECT
  },
  v_filter_list = {
    "Filter_List",
    BIND_TYPE.OBJECT
  },
  v_filter_list_template = {
    "Template_Filter",
    BIND_TYPE.OBJECT
  },
  v_left_main_clear_btn = {
    "Button_clear",
    BIND_TYPE.BUTTON
  },
  v_filter_list_clear_btn = {
    "Button_Filter_clear",
    BIND_TYPE.BUTTON
  },
  v_sort_btn = {
    "BtnSortType",
    BIND_TYPE.BUTTON
  },
  v_buddy_sort_type = {
    "BuddySort",
    BIND_TYPE.OBJECT
  },
  v_sort_type_btn1 = {
    "BuddySortType1",
    BIND_TYPE.BUTTON
  },
  v_sort_type_btn2 = {
    "BuddySortType2",
    BIND_TYPE.BUTTON
  },
  v_sort_type_btn3 = {
    "BuddySortType3",
    BIND_TYPE.BUTTON
  }
}
local DEFAULT_POS = {
  x = 387,
  y = -14,
  scale = 1
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_buddy_spine_info = PlayerMgr:get_buddy_spine_info()
  self.v_is_selecting_fashion = false
  self.v_btn_text = Util.get_text("Text", self.v_uiobjects.BtnConfirm)
  self.v_is_confirm = false
  self:set_button("BtnConfirm", function()
    local id = self:get_select_buddy_id()
    if self.v_is_selecting_fashion then
      self.v_is_selecting_fashion = not self.v_is_selecting_fashion
      local fashion_id = PlayerMgr:get_cloth_fashion_cache()
      if id == self.v_buddy_spine_info.buddy_id and fashion_id == self.v_buddy_spine_info.fashion_id then
        Util.show_message_tip("不能重复设置同一立绘")
        self.v_is_selecting_fashion = not self.v_is_selecting_fashion
        return
      else
        local fashion_spine_cfg = ShareRes.create("player.player_spine", fashion_id)
        local data = self.v_buddy_spine_info
        local has_bought = FashionMgr:check_has_bought_fashion(fashion_id)
        if has_bought then
          data.fashion_id = fashion_id
          data.buddy_id = id
          if fashion_spine_cfg then
            data.px = fashion_spine_cfg.PosX or DEFAULT_POS.x
            data.py = fashion_spine_cfg.PosY or DEFAULT_POS.y
            data.scale = fashion_spine_cfg.Scale or DEFAULT_POS.scale
          else
            data.px = DEFAULT_POS.x
            data.py = DEFAULT_POS.y
            data.scale = DEFAULT_POS.scale
          end
          PlayerMgr:request_buddy_spine_info(data, true, true)
          self.v_is_confirm = true
          self:do_hide(true)
          self.v_is_confirm = false
        else
          Util.show_message_tip("暂未解锁")
          return
        end
      end
    else
      self.v_is_selecting_fashion = not self.v_is_selecting_fashion
      self.v_uiobjects.BtnOrderType:SetActive(false)
      self.v_uiobjects.BtnFilter:SetActive(false)
      self.v_btn_text.text = "更 换"
      self:_init_fashion_list(id)
    end
  end)
  self:set_button("BtnFilter", function()
    self:show_filter_info()
  end)
  self:set_button("BtnRet", function()
    self:do_hide(true)
  end)
  self:set_button("BtnOrderType", function()
    self:click_order_btn()
  end)
  self.v_sort_name_text = Util.get_text("Text", self.v_sort_btn.transform)
  self.v_out_ani = Util.get_child_gameobj("Animation/Ani_UISignBoard_Girl_ChangeL_Out", self.v_object)
  self:register_exist_auto_template(SIGNBOARD_BUDDY_ROLE_KEY, self.v_buddy_template, self.v_buddy_list)
  self:register_exist_auto_template(SIGNBOARD_BUDDY_ROLE_FILTER_KEY, self.v_filter_template, self.v_filter_content)
  self:register_exist_auto_template(SIGNBOARD_BUDDY_ROLE_FILTER_LIST_KEY, self.v_filter_list_template, self.v_filter_list)
  self.v_buddy_idx = nil
end

function ui:do_hide(do_tween)
  self.v_cache_buddy_list = nil
  self.v_order_type = nil
  CharacterMgr:set_screen_condtion(1)
  self.v_is_selecting_fashion = false
  self:clear_exit_seq()
  if do_tween then
    self.v_out_ani:SetActive(true)
    self.v_exit_seq = Util.create_sequence()
    self.v_exit_seq:AppendInterval(0.3)
    self.v_exit_seq:OnComplete(function()
      self:ui_hide()
      if not self.v_is_confirm then
        MsgGame:mq_publish2(Const.MSG_ON_PLAYER_SPINE_CHOOSE_HIDE)
      end
    end)
  else
    self:ui_hide()
    if not self.v_is_confirm then
      MsgGame:mq_publish2(Const.MSG_ON_PLAYER_SPINE_CHOOSE_HIDE)
    end
  end
end

function ui:click_order_btn()
  self.sort_by_dec = not self.sort_by_dec
  self:refresh_order_btn()
  local now_id = self:remove_select_and_get_model_id()
  local new_buddy_list = UtilTable.table_reverse(self.v_buddy_data_list)
  self:refresh_buddy_list(new_buddy_list, now_id, true)
end

function ui:refresh_order_btn()
  local order_btn_obj = self.v_uiobjects.BtnOrderType
  local up_active_obj = Util.get_child_gameobj("IconUpActive", order_btn_obj)
  local down_active_obj = Util.get_child_gameobj("IconDownActive", order_btn_obj)
  up_active_obj:SetActive(not self.sort_by_dec)
  down_active_obj:SetActive(self.sort_by_dec)
end

function ui:ui_on_show(hide_Confirm_btn)
  self.v_is_open_fashion = false
  self.v_buddy_sort_type.gameObject:SetActive(false)
  self:init_order_btn_ui()
  self:register_event()
  self.v_left_main_clear_btn.gameObject:SetActive(false)
  self:_init_buddy_list()
  self.v_out_ani:SetActive(false)
  self.v_uiobjects.BtnConfirm:SetActive(not hide_Confirm_btn)
  self.v_is_quick_select = hide_Confirm_btn
end

function ui:ui_on_hide()
  self.v_buddy_idx = nil
  self.v_buddy_data_list = nil
  self:clear_all_seq()
  self.v_uiobjects.BlackScreen:SetActive(false)
end

function ui:ui_on_destroy()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.refresh_char_select_list, self)
end

function ui:refresh_char_select_list()
  self.sort_by_dec = false
  self:refresh_order_btn()
  local tag_list = CharacterMgr.v_tag_screen_list
  local element_list = CharacterMgr.v_attr_screen_list
  local job_list = CharacterMgr.v_job_screen_list
  local buddy_list = {}
  local buddy_config = ShareRes.create("buddy.buddy")
  local own_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  for _, info in pairs(own_list) do
    local cfg = buddy_config[info.id]
    if 1 ~= cfg.IsShow then
      local element_cond = not element_list or 0 == #element_list or UtilTable.contains(element_list, cfg.Element)
      local tag_cond = not (not UtilTable.is_empty(tag_list) and cfg.Tag) or UtilTable.contains(tag_list, cfg.Tag[1]) or UtilTable.contains(tag_list, cfg.Tag[2])
      local job_cond = not job_list or 0 == #job_list or UtilTable.contains(job_list, cfg.Job)
      if element_cond and job_cond and tag_cond then
        table.insert(buddy_list, info)
      end
    end
  end
  self.v_order_type = CharacterMgr.v_screen_type or 1
  local now_id = self:remove_select_and_get_model_id()
  self:refresh_buddy_list(buddy_list, now_id)
end

function ui:refresh_buddy_list(buddy_list, buddy_id, not_sort)
  if not self.v_visible then
    return
  end
  self:refresh_buddy_data_list(buddy_list, buddy_id, nil, not_sort)
  if not self.v_buddy_idx then
    self.v_buddy_idx = 1
  end
  self:refresh_buddy_choose_view()
end

function ui:init_order_btn_ui()
  self.sort_by_dec = false
  self:refresh_order_btn()
end

function ui:_init_buddy_list()
  if not self.v_visible then
    return
  end
  self.v_uiobjects.BtnFilter:SetActive(true)
  self.v_uiobjects.BtnOrderType:SetActive(true)
  self.v_btn_text.text = "确 定"
  local signboard_id = PlayerMgr:get_cloth_buddy_cache() or PlayerMgr:get_buddy_role_id()
  if self.v_cache_buddy_list then
    self:refresh_buddy_data_list(self.v_cache_buddy_list, nil, signboard_id, true)
    self.v_cache_buddy_list = nil
  else
    local buddy_list = self.v_cache_buddy_list or UtilTable.copy_table(CharacterMgr:get_buddy_list_show())
    self:refresh_buddy_data_list(buddy_list, nil, signboard_id)
  end
  if not self.v_buddy_idx then
    self.v_buddy_idx = 1
  end
  self:refresh_buddy_choose_view()
end

function ui:_init_fashion_list(buddy_id)
  if not self.v_visible then
    return
  end
  local fashion_cfg = ShareRes.create("buddy.buddy_fashion")
  local fashion_list = {}
  for i, v in pairs(fashion_cfg) do
    if v.BuddyId == buddy_id and self:check_fashion_released(v) then
      table.insert(fashion_list, 1, v)
    end
  end
  self:sort_fashion_list(fashion_list)
  self:refresh_fashion_data_list(fashion_list, nil, buddy_id)
  if not self.v_fashion_idx then
    self.v_fashion_idx = 1
  end
  self:refresh_fashion_choose_view()
end

function ui:refresh_buddy_data_list(buddy_list, buddy_id, signboard_id, not_sort)
  self:give_back_auto_cache(SIGNBOARD_BUDDY_ROLE_KEY)
  self.v_buddy_data_list = {}
  local buddy_config = ShareRes.create("buddy.buddy")
  for _, buddy in ipairs(buddy_list) do
    local now_id = buddy.id
    buddy.power = CharacterMgr:get_buddy_combat_effectiveness(now_id)
    buddy.element = buddy_config[now_id].Element
    buddy.favor_lv = buddy.favor_lv
  end
  if not not_sort then
    self:sort_type(self.v_order_type, buddy_list)
  end
  for buddy_idx, buddy in ipairs(buddy_list) do
    local now_id = buddy.id
    if signboard_id == now_id and not self.v_buddy_idx then
      self.v_buddy_idx = buddy_idx
    elseif now_id == buddy_id then
      self.v_buddy_idx = buddy_idx
    end
    local buddy_obj = self:get_auto_cache(SIGNBOARD_BUDDY_ROLE_KEY)
    self:refresh_buddy_icon_info(buddy_obj, buddy)
    self.v_buddy_data_list[buddy_idx] = buddy
    self.v_buddy_data_list[buddy_idx].buddy_obj = buddy_obj
    local unlock = Util.get_child_gameobj("UnLock", buddy_obj.transform)
    unlock:SetActive(false)
    local choose_img = Util.get_image("Choose", buddy_obj.transform)
    choose_img.gameObject:SetActive(false)
    self:set_button_listener(Util.get_button(nil, buddy_obj), function()
      self:click_char_item(buddy_idx)
      if self.v_is_quick_select then
        self:do_hide(true)
      end
    end)
  end
end

function ui:refresh_fashion_data_list(fashion_list, fashion_id, signboard_id)
  self:give_back_auto_cache(SIGNBOARD_BUDDY_ROLE_KEY)
  self.v_fashion_data_list = {}
  for fashion_idx, fashion in ipairs(fashion_list) do
    local now_id = fashion.Id
    self.v_fashion_idx = 1
    local fashion_obj = self:get_auto_cache(SIGNBOARD_BUDDY_ROLE_KEY)
    self:refresh_fashion_icon_info(fashion_obj, fashion)
    self.v_fashion_data_list[fashion_idx] = fashion
    self.v_fashion_data_list[fashion_idx].fashion_obj = fashion_obj
    local unlock = Util.get_child_gameobj("UnLock", fashion_obj)
    local choose_img = Util.get_image("Choose", fashion_obj.transform)
    choose_img.gameObject:SetActive(false)
    local has_bought = FashionMgr:check_has_bought_fashion(now_id)
    if has_bought then
      unlock:SetActive(false)
      self:set_button_listener(Util.get_button(nil, fashion_obj), function()
        self:click_fashion_item(fashion_idx)
        if self.v_is_quick_select then
          self:do_hide(true)
        end
      end)
    else
      unlock:SetActive(true)
      self:set_button_listener(Util.get_button(nil, fashion_obj), function()
        Util.show_message_tip("暂未解锁")
      end)
    end
  end
end

function ui:refresh_buddy_choose_view()
  local now_id
  local buddy_info = self.v_buddy_data_list[self.v_buddy_idx]
  if buddy_info then
    now_id = buddy_info.id
  else
    Log.Error("buddy is not exist, buddy idx = ", self.v_buddy_idx)
    return
  end
  PlayerMgr:set_cloth_buddy_cache(now_id)
  for index, buddy_data in pairs(self.v_buddy_data_list) do
    local choose_img = Util.get_image("Choose", buddy_data.buddy_obj.transform)
    choose_img.gameObject:SetActive(false)
    if index == self.v_buddy_idx then
      choose_img.gameObject:SetActive(true)
    end
  end
end

function ui:refresh_fashion_choose_view()
  local now_id, buddy_id
  local fashion_info = self.v_fashion_data_list[self.v_fashion_idx]
  if fashion_info then
    now_id = fashion_info.Id
    buddy_id = fashion_info.BuddyId
  else
    Log.Error("fashion is not exist, fashion idx = ", self.v_fashion_idx)
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_BROWSE_PLAYER_SPINE)
  msg.mm_x = buddy_id
  msg.mm_y = now_id
  msg.mm_obj = true
  PlayerMgr:set_cloth_buddy_cache(nil, now_id)
  for index, fashion_data in pairs(self.v_fashion_data_list) do
    local choose_img = Util.get_image("Choose", fashion_data.fashion_obj.transform)
    choose_img.gameObject:SetActive(false)
    if index == self.v_fashion_idx then
      choose_img.gameObject:SetActive(true)
    end
  end
end

function ui:refresh_buddy_icon_info(buddy_obj, buddy_data)
  local id = buddy_data.id
  local signboard_id = PlayerMgr:get_buddy_role_id()
  local icon_path = UtilUI.get_hero_images(id, Config.CHAR_QUALITY_TYPE.SMALL)
  local buddy_icon = Util.get_image("Head", buddy_obj)
  self:set_buddy_icon_by_id(buddy_icon, icon_path)
  local buddy_quality_path = Char_Helper.get_char_icon_quality(id, Config.CHAR_QUALITY_TYPE.SMALL)
  local buddy_quality = Util.get_image("Pz", buddy_obj)
  self:set_buddy_icon_by_id(buddy_quality, buddy_quality_path)
  local path = CharacterMgr:get_buddy_element_icon_path(id)
  local buddy_element = Util.get_image("Type/Icon", buddy_obj)
  self:set_buddy_icon_by_id(buddy_element, path)
  local now_image = Util.get_image("Now", buddy_obj)
  now_image:SetActive(signboard_id == id)
  local favor = Util.get_child_gameobj("Favorability", buddy_obj)
  favor:SetActive(false)
end

function ui:refresh_fashion_icon_info(fashion_obj, fashion_data)
  local id = fashion_data.BuddyId
  local fashion_id = fashion_data.Id
  local curr_fashion_id = self.v_buddy_spine_info.fashion_id
  local icon_path
  if 1 == fashion_data.IsBase then
    icon_path = UtilUI.get_hero_images(id, Config.CHAR_QUALITY_TYPE.SMALL)
  else
    local icon_name = fashion_data.ItemIcon or fashion_data.Icon[Config.CHAR_QUALITY_TYPE.SMALL]
    icon_path = string.format("Icon/Profile/%s", icon_name)
  end
  local fashion_icon = Util.get_image("Head", fashion_obj)
  ResMgr:load_set_icon(fashion_icon, icon_path)
  local now_image = Util.get_image("Now", fashion_obj)
  now_image:SetActive(fashion_id == curr_fashion_id)
  local favor = Util.get_child_gameobj("Favorability", fashion_obj)
  favor:SetActive(false)
end

function ui:show_filter_info()
  UIMgr:get_ui("screen_buddy_tips"):ui_show(true)
end

function ui:set_buddy_icon_by_id(icon, path)
  ResMgr:load_set_icon(icon, path)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
end

function ui:get_select_buddy_id()
  return self.v_buddy_data_list[self.v_buddy_idx].id
end

function ui:get_select_fashion_id()
  return self.v_fashion_data_list[self.v_fashion_idx].Id
end

function ui:clear_all_seq()
  self:clear_enter_seq()
  self:clear_exit_seq()
  self:clear_black_fade_close_seq()
end

function ui:clear_enter_seq()
  if self.v_enter_seq then
    self.v_enter_seq:Kill(false)
    self.v_enter_seq = nil
  end
end

function ui:clear_black_fade_close_seq()
  if self.v_black_fade_close_seq then
    self.v_black_fade_close_seq:Kill(false)
    self.v_black_fade_close_seq = nil
  end
end

function ui:clear_black_fade_open_seq()
  if self.v_black_fade_open_seq then
    self.v_black_fade_open_seq:Kill(false)
    self.v_black_fade_open_seq = nil
  end
end

function ui:clear_exit_seq()
  if self.v_exit_seq then
    self.v_exit_seq:Kill(false)
    self.v_exit_seq = nil
  end
end

function ui:click_char_item(buddy_idx)
  SignBoardGirlMgr:try_clear_sound_immediately()
  self.v_buddy_idx = buddy_idx
  self:refresh_buddy_choose_view()
end

function ui:click_fashion_item(fashion_idx)
  SignBoardGirlMgr:try_clear_sound_immediately()
  self.v_fashion_idx = fashion_idx
  self:refresh_fashion_choose_view()
end

function ui:sort_type(order_type, buddy_list)
  local sort_rule = SORT_RULE[order_type or 1]
  table.sort(buddy_list, function(a, b)
    for _, type in ipairs(sort_rule) do
      if a[type] ~= b[type] then
        return a[type] > b[type]
      end
    end
    if a.element ~= b.element then
      return a.element > b.element
    end
    return a.id > b.id
  end)
end

function ui:remove_select_and_get_model_id()
  local buddy_data = self.v_buddy_data_list[self.v_buddy_idx]
  local buddy_id = buddy_data.id
  self.v_buddy_idx = nil
  return buddy_id
end

function ui:sort_fashion_list(fashion_list)
  table.sort(fashion_list, function(a, b)
    local a_unlock = FashionMgr:check_has_bought_fashion(a.Id)
    local b_unlock = FashionMgr:check_has_bought_fashion(b.Id)
    if a.IsBase ~= b.IsBase then
      if 1 == a.IsBase then
        return true
      end
      if 1 == b.IsBase then
        return false
      end
    end
    if a_unlock and not b_unlock then
      return true
    end
    if not a_unlock and b_unlock then
      return false
    end
    if a.Quality ~= b.Quality then
      return a.Quality < b.Quality
    elseif a.Quality == b.Quality and a.ShowPriority ~= b.ShowPriority then
      return a.ShowPriority < b.ShowPriority
    end
    return a.Id < b.Id
  end)
end

function ui:check_fashion_released(fashion_cfg)
  local cur_time = Date.server_time()
  if fashion_cfg.ReleaseTime then
    local is_unlock
    local date = fashion_cfg.ReleaseTime and Date.get_time_stamp_by_scheme_id(fashion_cfg.ReleaseTime) or 0
    if date then
      local dif_time = date - cur_time
      is_unlock = dif_time <= 0
    else
      is_unlock = true
    end
    return is_unlock
  else
    return 1 ~= fashion_cfg.IsHide
  end
end

return ui
