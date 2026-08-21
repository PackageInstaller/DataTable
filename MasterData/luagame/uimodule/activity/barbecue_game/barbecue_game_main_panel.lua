local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LocalStorage = require("utils.localstorage")
local BBQ_GAME_FOOD_ITEM_TEMP_KEY = "BBQ_GAME_FOOD_ITEM_TEMP_KEY"
local BBQ_GAME_MENU_ITEM_TEMP_KEY = "BBQ_GAME_MENU_ITEM_TEMP_KEY"
local BBQ_FIRST_GUIDE_STORAGE_KEY = "BBQ_FIRST_GUIDE_STORAGE_KEY"
local MenuListItem = require("uimodule.activity.barbecue_game.barbecue_game_menu_list_item")
local DishNodeItem = require("uimodule.activity.barbecue_game.barbecue_game_dish_item")
local CustomerItem = require("uimodule.activity.barbecue_game.barbecue_game_customer_item")
local MatContentClass = require("uimodule.activity.barbecue_game.barbecue_material_content")
local MatProduceClass = require("uimodule.activity.barbecue_game.barbecue_material_produce")
local MatCfg = ShareRes.create("activity.barbecue_materail")
local AllCustomerCfg = ShareRes.create("activity.barbecue_customer")
local MenuCfg = ShareRes.create("activity.barbecue_menu")
local _ceil = math.ceil
local _floor = math.floor
local _sort = table.sort
local PARAM = ShareRes.get_comm_string_value("BBQGuideParam")
local TASK_GUID_ID = PARAM and PARAM[1]
local GUIDE_STAGE_ID = PARAM and PARAM[2]

function ui:on_click_BtnRet1()
  if self.v_uiobjects.Main.activeSelf then
    self:ui_hide()
  else
    self:stop_ct()
    UIMgr:get_ui("barbecue_game_pause_tips"):ui_show(self.v_stage_cfg, self.v_cur_score)
  end
end

function ui:on_click_BtnUpgrade()
  UIMgr:get_ui("barbecue_game_upgrade"):ui_show(self.v_activity_id)
end

function ui:on_click_BtnTask()
  local cfg = ShareRes.create("activity.barbecue_stall_game", self.v_activity_id)
  UIMgr:get_ui("barbecue_game_task"):ui_show(cfg.TaskGroupId)
end

function ui:on_click_BtnMenu()
  if not self.v_uiobjects.Main.activeSelf then
    self:stop_ct()
  end
  self.v_uiobjects.MenuBox:SetActiveEx(true)
  self.v_uiobjects.Ani_MenuBox_Out:SetActiveEx(false)
end

function ui:on_click_BtnCloseMenu()
  if not self.v_uiobjects.Main.activeSelf then
    self:continue_ct()
  end
  self.v_uiobjects.Ani_MenuBox_Out:SetActiveEx(true)
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:set_button("StarTips", function()
    self:show_stage_list_tips()
  end)
  self:set_button("BtnUpgrade", function()
    self:on_click_BtnUpgrade()
  end)
  self:set_button("BtnTask", function()
    self:on_click_BtnTask()
  end)
  self:set_button("BtnMenu", function()
    self:on_click_BtnMenu()
  end)
  self:set_button("BtnCloseMenu", function()
    self:on_click_BtnCloseMenu()
  end)
  self.v_menu_map = {}
  for food_id, cfg in pairs(MenuCfg) do
    if not self.v_menu_map[cfg.PrefixMatId] then
      self.v_menu_map[cfg.PrefixMatId] = {}
    end
    self.v_menu_map[cfg.PrefixMatId][cfg.NextMatId] = food_id
  end
  self:register_exist_auto_template(BBQ_GAME_FOOD_ITEM_TEMP_KEY, self.v_uiobjects.FoodObj, self.v_uiobjects.TableContent)
  self:register_exist_auto_template(BBQ_GAME_MENU_ITEM_TEMP_KEY, self.v_uiobjects.RecipeTem, self.v_uiobjects.RecipeContent)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedDot, RedEnum.BBQ_GAME_NEW_STAGE)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.TaskRed, RedEnum.BBQ_GAME_TASK_AWARD)
end

function ui:ui_on_show()
  self.v_activity_id = BarbecueGameMgr:get_activity_id()
  self.v_activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local cfg = ShareRes.create("activity.barbecue_stall_game", self.v_activity_id)
  if not cfg then
    Log.Error("烧烤小游戏 无对应活动id配置：", self.v_activity_id)
    return
  end
  self.v_task_group = cfg.TaskGroupId
  self.v_need_first_guide = 0 == LocalStorage:load_int(BBQ_FIRST_GUIDE_STORAGE_KEY, 0, true)
  if self.v_need_first_guide and GUIDE_STAGE_ID then
    self:init_customer_pool()
    self:init_operate_area()
    self:enter_stage(GUIDE_STAGE_ID)
    self:set_menu_box()
  else
    self:init_customer_pool()
    self:init_operate_area()
    self:show_main_view()
    self:set_menu_box()
  end
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
  self:bind_auto_mq(Const.MSG_ON_BBQ_STAGE_BACK_TO_MAIN, self.show_main_view, self)
  self:bind_auto_mq(Const.MSG_ON_BBQ_STAGE_ENTER_GAME, self.on_enter_stage, self)
  self:bind_auto_mq(Const.MSG_ON_BBQ_SYS_UPDATE, self.update_upgrade_red, self)
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self.update_upgrade_red, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.response_hide_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.response_show_ui_event, self)
end

function ui:check_close()
  if NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name) then
    self:stop_ct()
  end
end

function ui:response_hide_ui_event(msg)
  if nil == msg then
    return
  end
  if self.v_uiobjects.Main.activeSelf then
    return
  end
  local ui_name = msg.mm_obj
  if "ui_introduce" == ui_name then
    self:continue_ct()
  end
end

function ui:response_show_ui_event(msg)
  if nil == msg then
    return
  end
  if self.v_uiobjects.Main.activeSelf then
    return
  end
  local ui_name = msg.mm_obj
  if "ui_introduce" == ui_name then
    self:stop_ct()
  end
end

function ui:ui_on_hide()
  self:stop_ct()
  self:clear_wrap_menu_item_list()
  self:clear_wrap_dish_pool()
  self:clear_wrap_customer_pool()
  self:clear_warp_material_produce()
  self:clear_warp_material_contents()
end

function ui:ui_on_destroy()
end

function ui:show_main_view()
  local need_first_guide = 0 == LocalStorage:load_int(BBQ_FIRST_GUIDE_STORAGE_KEY, 0, true)
  if need_first_guide and GUIDE_STAGE_ID then
    LocalStorage:save_int(BBQ_FIRST_GUIDE_STORAGE_KEY, 1, true)
  end
  self.v_uiobjects.Main:SetActiveEx(true)
  self.v_uiobjects.CharGroup:SetActiveEx(false)
  self.v_uiobjects.TableContent:SetActiveEx(false)
  self.v_uiobjects.UpGroup:SetActiveEx(false)
  self.v_uiobjects.MenuBox:SetActiveEx(false)
  self.v_uiobjects.BtnMenu:SetActiveEx(true)
  self.v_uiobjects.BtnRet1:SetActiveEx(true)
  self:update_upgrade_red()
  self:reset_operate_area()
end

function ui:update_upgrade_red()
  self.v_uiobjects.UpgradeRed:SetActiveEx(BarbecueGameMgr:is_any_upgrade())
end

function ui:show_stage_list_tips()
  UIMgr:get_ui("barbecue_game_stage_panel"):ui_show(self.v_activity_id)
  self.v_uiobjects.Main:SetActiveEx(false)
  self.v_uiobjects.CharGroup:SetActiveEx(false)
  self.v_uiobjects.TableContent:SetActiveEx(false)
  self.v_uiobjects.UpGroup:SetActiveEx(false)
  self.v_uiobjects.MenuBox:SetActiveEx(false)
  self.v_uiobjects.BtnMenu:SetActiveEx(false)
  self.v_uiobjects.BtnRet1:SetActiveEx(false)
end

function ui:on_enter_stage(msg)
  self:enter_stage(msg.mm_x)
end

function ui:enter_stage(stage_id)
  self.v_need_first_guide = 0 == LocalStorage:load_int(BBQ_FIRST_GUIDE_STORAGE_KEY, 0, true)
  local stage_cfg = ShareRes.create("activity.barbecue_stall_episode", stage_id)
  self.v_stage_id = stage_id
  self.v_stage_cfg = stage_cfg
  self.v_end_time = stage_cfg.Duration
  self.v_target_score = stage_cfg.TargetScore
  self.v_customer_interval = stage_cfg.Interval
  self.v_fix_customer_id_list = stage_cfg.FixCustomerList
  self:build_random_customers()
  self.v_cur_score = 0
  self.v_customer_idx = 0
  self:reset_dish_pool()
  self:reset_operate_area()
  self:reset_customer_pool()
  self:start_count_down()
  self.v_uicompents.CurrentScoreTxt_txt.text = 0
  self.v_uicompents.TargetScoreTxt_txt.text = self.v_target_score
  self.v_uiobjects.TargetScore:SetActiveEx(self.v_target_score ~= nil)
  self.v_uiobjects.Main:SetActiveEx(false)
  self.v_uiobjects.CharGroup:SetActiveEx(true)
  self.v_uiobjects.TableContent:SetActiveEx(true)
  self.v_uiobjects.UpGroup:SetActiveEx(true)
  self.v_uiobjects.MenuBox:SetActiveEx(false)
  self.v_uiobjects.BtnMenu:SetActiveEx(true)
  self.v_uiobjects.BtnRet1:SetActiveEx(true)
  local story_id = stage_cfg.StoryId
  local is_first_read_stage = BarbecueGameMgr:read_stage(stage_id)
  if is_first_read_stage and story_id then
    StoryMgr:on_start(story_id, nil, nil, nil, nil, function()
      UIMgr:get_ui("barbecue_game_start_tips"):ui_show(stage_cfg)
    end)
  else
    UIMgr:get_ui("barbecue_game_start_tips"):ui_show(stage_cfg)
  end
end

function ui:build_random_customers()
  local random_customers = self.v_stage_cfg.RandomCustomerList
  if not random_customers then
    return
  end
  self.v_random_customer_list = {}
  for i, customer_id in ipairs(random_customers) do
    local cfg = AllCustomerCfg[customer_id]
    self.v_random_customer_list[i] = {
      id = customer_id,
      buddy_id = cfg.BuddyId
    }
  end
end

function ui:ui_on_update(delta_time)
  if self.v_count_down_sec then
    if StoryMgr:is_playing_story() then
      return
    end
    self.v_count_down_sec = self.v_count_down_sec - delta_time
    self:refresh_count_down_txt()
    return
  end
  if not self.v_is_running then
    return
  end
  self:do_ct()
  self:do_customer_ct(delta_time)
  self:pass_ct_to_product(delta_time)
  self:pass_ct_to_customer(delta_time)
end

function ui:pass_ct_to_product(delta_time)
  if not self.v_is_running or not self.v_warp_material_produce then
    return
  end
  for _, item in pairs(self.v_warp_material_produce) do
    item:pass_ct(delta_time)
  end
end

function ui:pass_ct_to_customer(delta_time)
  if not self.v_is_running or not self.v_customer_pool then
    return
  end
  if StoryMgr:is_playing_story() then
    return
  end
  if GuideMgr:get_cur_guider() then
    return
  end
  for _, item in pairs(self.v_customer_pool) do
    item:pass_ct(delta_time)
  end
end

local time_format_key = "%02d:%02d"

function ui:get_time_txt(second)
  return string.format(time_format_key, _floor(second / 60), _floor(second % 60))
end

function ui:start_count_down()
  self.v_count_down_sec = 2.5
  self.v_uicompents.TimeBar_img.fillAmount = 1
  self.v_uicompents.TimeTxt_txt.text = self:get_time_txt(self.v_end_time)
end

function ui:refresh_count_down_txt()
  if self.v_count_down_sec < 0 then
    self.v_count_down_sec = nil
    self:start_ct()
    return
  end
end

function ui:add_score(add_score)
  if not self.v_cur_score then
    return
  end
  self.v_cur_score = self.v_cur_score + add_score
  self.v_uicompents.CurrentScoreTxt_txt.text = self.v_cur_score
  if self.v_target_score and self.v_target_score <= self.v_cur_score then
    self:stop_ct()
    self:send_score()
  end
end

function ui:send_score()
  if self.v_stage_id == GUIDE_STAGE_ID then
    UIMgr:get_ui("barbecue_game_result_tips"):ui_show(self.v_stage_cfg, true)
    LocalStorage:save_int(BBQ_FIRST_GUIDE_STORAGE_KEY, 1, true)
  else
    BarbecueGameMgr:report_score(self.v_stage_id, self.v_cur_score, function()
      UIMgr:get_ui("barbecue_game_result_tips"):ui_show(self.v_stage_cfg, true)
    end)
  end
end

function ui:do_ct()
  if StoryMgr:is_playing_story() or GuideMgr:get_cur_guider() then
    if not self.v_ex_stop_time_flag then
      self.v_ex_stop_time_flag = Global.real_time
    end
    return
  end
  if self.v_ex_stop_time_flag then
    self.v_start_time_flag = Global.real_time - self.v_ex_stop_time_flag + self.v_start_time_flag
    self.v_ex_stop_time_flag = nil
  end
  local pass_second = Global.real_time - self.v_start_time_flag
  pass_second = pass_second > 0 and pass_second or 0
  self.v_uicompents.TimeBar_img.fillAmount = 1 - pass_second / self.v_end_time
  local left_time = self.v_end_time - pass_second
  left_time = left_time > 0 and _ceil(left_time * 10) / 10 or 0
  if left_time ~= self.v_showing_second then
    self.v_showing_second = left_time
    self.v_uicompents.TimeTxt_txt.text = self:get_time_txt(left_time)
  end
  if 0 == left_time then
    if self.v_target_score then
      UIMgr:get_ui("barbecue_game_result_tips"):ui_show(self.v_stage_cfg, false)
    else
      self:send_score()
    end
    self.v_is_running = false
    return
  end
end

function ui:start_ct()
  self.v_is_running = true
  self.v_start_time_flag = Global.real_time
  self.v_showing_second = nil
  self.v_customer_refresh_flag = self.v_customer_interval
end

function ui:stop_ct()
  self.v_is_running = false
  self.v_stop_time_flag = Global.real_time
  if StoryMgr:is_playing_story() or GuideMgr:get_cur_guider() then
    self.v_stop_time_flag = nil
  end
end

function ui:continue_ct()
  self.v_is_running = true
  if self.v_stop_time_flag then
    self.v_start_time_flag = Global.real_time - self.v_stop_time_flag + self.v_start_time_flag
  end
end

function ui:do_customer_ct(delta_time)
  if not self.v_is_running or not self.v_customer_pool then
    return
  end
  local is_full = true
  for _, customer in ipairs(self.v_customer_pool) do
    if not customer:get_enable() then
      is_full = false
      break
    end
  end
  if is_full then
    self.v_customer_refresh_flag = 0
    return
  end
  self.v_customer_refresh_flag = self.v_customer_refresh_flag + delta_time
  if self.v_customer_refresh_flag < self.v_customer_interval then
    return
  end
  self.v_customer_refresh_flag = 0
  for _, customer in ipairs(self.v_customer_pool) do
    if not customer:get_enable() then
      local new_customer_id = self:get_new_customer_id()
      if new_customer_id then
        customer:set_new_customer(new_customer_id)
      end
      if self.v_need_first_guide and TASK_GUID_ID then
      else
        return
      end
    end
  end
  if self.v_need_first_guide and TASK_GUID_ID then
    GuideMgr:enter_guide(TASK_GUID_ID)
    self.v_need_first_guide = false
  end
end

function ui:get_new_customer_id()
  self.v_customer_idx = self.v_customer_idx + 1
  if self.v_fix_customer_id_list and self.v_customer_idx <= #self.v_fix_customer_id_list then
    return self.v_fix_customer_id_list[self.v_customer_idx]
  end
  if not self.v_exclude_tbl then
    self.v_exclude_tbl = {}
  else
    UtilTable.clear_map(self.v_exclude_tbl)
  end
  for _, customer in ipairs(self.v_customer_pool) do
    if customer.v_buddy_id then
      self.v_exclude_tbl[customer.v_buddy_id] = true
    end
  end
  if not self.v_temp_ramdom_tbl then
    self.v_temp_ramdom_tbl = {}
  else
    UtilTable.clear_map(self.v_temp_ramdom_tbl)
  end
  if self.v_random_customer_list then
    for _, v in ipairs(self.v_random_customer_list) do
      if not self.v_exclude_tbl[v.buddy_id] then
        self.v_temp_ramdom_tbl[#self.v_temp_ramdom_tbl + 1] = v.id
      end
    end
  end
  if #self.v_temp_ramdom_tbl > 0 then
    math.randomseed(os.time())
    return self.v_temp_ramdom_tbl[math.random(1, #self.v_temp_ramdom_tbl)]
  end
end

function ui:on_click_customer(idx)
  for i, customer in ipairs(self.v_customer_pool) do
    customer:set_selected(idx == i)
  end
end

function ui:try_use_mat(mat_id, from_trans)
  if not self.v_is_running then
    return false
  end
  local mat_cfg = MatCfg[mat_id]
  local mat_type = mat_cfg.Type
  if 1 == mat_type then
    return self:move_first_mat_to_table(mat_id, from_trans)
  elseif 2 == mat_type then
    return self:move_next_mat_to_table(mat_id, from_trans)
  elseif 3 == mat_type and self.v_menu_map[mat_id] then
    self:move_result_mat_to_customer(self.v_menu_map[mat_id][0], from_trans)
  end
end

function ui:move_first_mat_to_table(mat_id, from_trans)
  local length = #self.v_active_dish_idx_list
  if length >= 3 then
    local flow_dish_idx = self.v_active_dish_idx_list[1]
    self:release_dish(flow_dish_idx)
    table.remove(self.v_active_dish_idx_list, 1)
  end
  local free_dish_idx = self:get_free_dish_idx()
  self.v_active_dish_idx_list[#self.v_active_dish_idx_list + 1] = free_dish_idx
  self.v_dish_pool[free_dish_idx]:set_mat_id(mat_id, from_trans)
  return true
end

function ui:move_next_mat_to_table(next_mat_id, from_trans)
  for idx, dish_idx in ipairs(self.v_active_dish_idx_list) do
    local dish = self.v_dish_pool[dish_idx]
    local first_mat_id = dish.v_mat_id
    local result_food_id = self.v_menu_map[first_mat_id][next_mat_id]
    if result_food_id then
      self:release_dish(dish_idx)
      table.remove(self.v_active_dish_idx_list, idx)
      dish:set_next_mat_id(next_mat_id, result_food_id, from_trans)
      return true
    end
  end
  return false
end

function ui:move_result_mat_to_customer(result_food_id, from_trans)
  for _, customer in ipairs(self.v_customer_pool) do
    if customer:get_enable() and customer:get_selected() then
      customer:get_food(result_food_id, from_trans)
      return
    end
  end
  local sort_customers = {}
  for _, customer in ipairs(self.v_customer_pool) do
    if customer:get_enable() then
      sort_customers[#sort_customers + 1] = customer
    end
  end
  _sort(sort_customers, function(a, b)
    return a:get_left_time() < b:get_left_time()
  end)
  for _, customer in ipairs(sort_customers) do
    if customer:get_food(result_food_id, from_trans) then
      return
    end
  end
end

function ui:reset_dish_pool()
  self:clear_wrap_dish_pool()
  self:give_back_auto_cache(BBQ_GAME_FOOD_ITEM_TEMP_KEY)
  self.v_free_dish = {}
  self.v_dish_pool = {}
  self.v_active_dish_idx_list = {}
  for i = 1, 5 do
    local obj = self:get_auto_cache(BBQ_GAME_FOOD_ITEM_TEMP_KEY)
    local item = DishNodeItem:ui_wrap_ex(self, obj, false)
    item:set_idx(i)
    self.v_dish_pool[i] = item
    self.v_free_dish[i] = true
  end
end

function ui:get_free_dish_idx()
  local free_dish_idx = next(self.v_free_dish)
  if not free_dish_idx then
    free_dish_idx = #self.v_dish_pool + 1
    local obj = self:get_auto_cache(BBQ_GAME_FOOD_ITEM_TEMP_KEY)
    local item = DishNodeItem:ui_wrap_ex(self, obj, false)
    item:set_idx(free_dish_idx)
    self.v_dish_pool[free_dish_idx] = item
  end
  self.v_free_dish[free_dish_idx] = nil
  for _, idx in ipairs(self.v_active_dish_idx_list) do
    if free_dish_idx == idx then
      return self:get_free_dish_idx()
    end
  end
  return free_dish_idx
end

function ui:release_dish(dish_idx)
  self.v_free_dish[dish_idx] = true
end

function ui:clear_wrap_dish_pool()
  self:clear_warp_list(self.v_dish_pool)
  self.v_dish_pool = nil
end

function ui:clear_warp_list(list)
  if list then
    for idx = #list, 1, -1 do
      local item = list[idx]
      item:ui_destroy()
      list[idx] = nil
    end
  end
end

function ui:init_customer_pool()
  self:clear_wrap_customer_pool()
  self.v_customer_pool = {}
  for i = 1, 3 do
    local obj = self.v_uiobjects["CharTem" .. i]
    local item = CustomerItem:ui_wrap_ex(self, obj, false)
    item:set_idx(i)
    self.v_customer_pool[i] = item
  end
end

function ui:reset_customer_pool()
  if not self.v_customer_pool then
    return
  end
  for _, customer in ipairs(self.v_customer_pool) do
    customer:set_enable(false)
  end
end

function ui:clear_wrap_customer_pool()
  self:clear_warp_list(self.v_customer_pool)
  self.v_customer_pool = nil
end

function ui:init_operate_area()
  self:clear_warp_material_produce()
  self:clear_warp_material_contents()
  self.v_warp_material_produce = {}
  self.v_warp_material_contents = {}
  for mat_id, cfg in pairs(MatCfg) do
    if cfg.OutputSysId then
      local obj = self.v_uiobjects["Produce" .. mat_id]
      if obj then
        local produce_item = MatProduceClass:ui_wrap_ex(self, obj, true)
        produce_item:set_data(cfg)
        self.v_warp_material_produce[mat_id] = produce_item
      else
        Log.Error("未找到对应食材Id的预制节点", "Produce" .. mat_id)
      end
    end
    local obj = self.v_uiobjects["Material" .. mat_id]
    if obj then
      local item = MatContentClass:ui_wrap_ex(self, obj, true)
      item:set_data(cfg)
      self.v_warp_material_contents[mat_id] = item
    else
      Log.Error("未找到对应食材Id的预制节点", "Material" .. mat_id)
    end
  end
end

function ui:reset_operate_area()
  if self.v_warp_material_produce then
    for _, item in pairs(self.v_warp_material_produce) do
      item:reset_ui()
    end
  end
  if self.v_warp_material_contents then
    for _, item in pairs(self.v_warp_material_contents) do
      item:reset_ui()
    end
  end
end

function ui:clear_warp_material_produce()
  if not self.v_warp_material_produce then
    return
  end
  for key, item in pairs(self.v_warp_material_produce) do
    item:ui_destroy()
    self.v_warp_material_produce[key] = nil
  end
  self.v_warp_material_produce = nil
end

function ui:clear_warp_material_contents()
  if not self.v_warp_material_contents then
    return
  end
  for key, item in pairs(self.v_warp_material_contents) do
    item:ui_destroy()
    self.v_warp_material_contents[key] = nil
  end
  self.v_warp_material_contents = nil
end

function ui:set_menu_box()
  local menu_list = {}
  for _, cfg in pairs(MenuCfg) do
    menu_list[#menu_list + 1] = cfg
  end
  table.sort(menu_list, function(a, b)
    return a.Order < b.Order
  end)
  self:clear_wrap_menu_item_list()
  self:give_back_auto_cache(BBQ_GAME_MENU_ITEM_TEMP_KEY)
  self.v_menu_item_list = {}
  for _, cfg in ipairs(menu_list) do
    local obj = self:get_auto_cache(BBQ_GAME_MENU_ITEM_TEMP_KEY)
    local item = MenuListItem:ui_wrap_ex(self, obj, true)
    item:set_data(cfg)
    self.v_menu_item_list[#self.v_menu_item_list + 1] = item
  end
  self.v_uiobjects.Ani_MenuBox_Out:SetActiveEx(false)
end

function ui:clear_wrap_menu_item_list()
  self:clear_warp_list(self.v_menu_item_list)
  self.v_menu_item_list = nil
end

return ui
