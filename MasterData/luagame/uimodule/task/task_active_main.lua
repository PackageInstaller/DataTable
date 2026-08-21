local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local string_format = string.format
local BIND_TYPE = Config.BIND_TYPE
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local ToggleTab = require("ui.widget.widget_toggle_tab")
local LOOP_TASK_ITEM_KEY = "LOOP_TASK_ITEM_NEW"
local LOOP_TASK_REWARD_ITEM_KEY = "LOOP_TASK_REWARD_NEW"
local ITEM_ICON_PATH = "Icon/Item/"
local bagConfig = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local TASK_RED_ID = 1102
local MODEL = {
  v_award_list_content = {
    "AwardListContent",
    BIND_TYPE.OBJECT
  },
  v_award_tem = {
    "AwardTem",
    BIND_TYPE.OBJECT
  },
  v_bottom = {
    "Bottom",
    BIND_TYPE.BUTTON
  },
  v_get_all_point_num = {
    "GetAllPointNum",
    BIND_TYPE.TEXT
  },
  v_get_all = {
    "GetAll",
    BIND_TYPE.BUTTON
  },
  v_meiri = {
    "Meiri",
    BIND_TYPE.TOGGLE
  },
  v_meizhou = {
    "Meizhou",
    BIND_TYPE.TOGGLE
  },
  v_task_item_content = {
    "Task_Item_Content",
    BIND_TYPE.OBJECT
  },
  v_task_template = {
    "Task_template",
    BIND_TYPE.OBJECT
  }
}
local TASK_TYPE = {DAILY_TASK = 1, WEEKLY_TASK = 2}
local TOGGLE_LIST = {
  [1] = {
    tog_name = "Meiri",
    name = "每日任务",
    tog_show_name = "D A I L I E S",
    type_icon = "UITask/20230725/task_bg_hy_rc",
    sys_id = 2,
    redpoint_id = 10
  },
  [2] = {
    tog_name = "Meizhou",
    name = "每周任务",
    tog_show_name = "W E E K L Y",
    type_icon = "UITask/20230725/task_bg_hy_zc",
    sys_id = 3,
    redpoint_id = 11
  }
}
local TASK_TYPE_TEXT = {
  [1] = Util.format_str("每日任务"),
  [2] = Util.format_str("每周任务")
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:register_exist_auto_template(LOOP_TASK_ITEM_KEY, self.v_task_template, self.v_task_item_content)
  self:register_exist_auto_template(LOOP_TASK_REWARD_ITEM_KEY, self.v_award_tem, self.v_award_list_content, 20)
  self:set_button("GetAll", function()
    self:do_submit_all()
  end)
  self:init_toggle()
  self.v_player_active = 0
end

function ui:init_toggle()
  self.v_tag_toggles = {}
  self.v_tog_list = {}
  for i, v in ipairs(TOGGLE_LIST) do
    local tog = self:get_toggle(nil, self.v_uiobjects[v.tog_name])
    table.insert(self.v_tag_toggles, tog)
    self.v_tog_list[v.sys_id] = {
      lock = self:get_child_gameobj("Lock", tog.gameObject)
    }
    if v.redpoint_id then
      RedPointMgr:bind_redpoint(self, self:get_child_gameobj("Red", tog.gameObject), v.redpoint_id, TASK_RED_ID)
    end
  end
  for index, toggle in ipairs(self.v_tag_toggles) do
    local text = Util.get_text("Text", toggle.transform)
    text.text = TASK_TYPE_TEXT[index]
    self:refresh_toggle_text_alpha(toggle, 0.5)
  end
  self.v_toggle_tab = ToggleTab:new(self)
  self.v_toggle_tab:init_by_toggles(self.v_tag_toggles, function(select, last_select, select_toggle, last_select_toggle)
    self:select_tag_toggle(select, last_select, select_toggle, last_select_toggle)
  end, 2, false)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_view, self)
  self:bind_auto_mq(Const.MSG_NEW_SYS_OPEN, self.refresh_sys_open, self)
  self.v_receive_id_list = {}
  self.v_receive_item_list = {}
  local toggle_idx = TASK_TYPE.DAILY_TASK
  self:select_tag_toggle(toggle_idx)
  self.v_toggle_tab:set_toggle_by_index(toggle_idx)
  self:refresh_tag_lock()
  self:clear_Seq()
end

function ui:select_tag_toggle(select, last_select, select_toggle, last_select_toggle)
  self:refresh_view(select)
  self.v_tag_select = select
  self.v_last_tag_select = select
  if select_toggle then
    self:refresh_toggle_text_alpha(select_toggle, 1)
  end
  if last_select_toggle and select ~= last_select then
    self:refresh_toggle_text_alpha(last_select_toggle, 0.5)
  end
end

function ui:refresh_toggle_text_alpha(toggle, alpha)
  local text = Util.get_text("Text", toggle.transform)
  local color = text.color
  color.a = alpha
  text.color = color
end

function ui:refresh_task_reward_list()
  local daily_task_reward_list = ShareRes.create("task.daily_task_reward")
  local weekly_task_reward_list = ShareRes.create("task.weekly_task_reward")
  local reward_list_config
  if self.v_tag_select == TASK_TYPE.DAILY_TASK then
    reward_list_config = daily_task_reward_list
  elseif self.v_tag_select == TASK_TYPE.WEEKLY_TASK then
    reward_list_config = weekly_task_reward_list
  end
  local new_reward = {}
  for _, data in pairs(reward_list_config) do
    local task_info = TaskMgr:get_task_by_id(data.TaskId)
    local sort_index = 1
    if task_info.state == TASK_STATE.receive then
      sort_index = 2
    elseif task_info.state == TASK_STATE.received then
      sort_index = 0
    end
    data.sort_index = sort_index
    table.insert(new_reward, data)
  end
  table.sort(new_reward, function(a, b)
    if a.sort_index == b.sort_index then
      return a.TaskId < b.TaskId
    end
    return a.sort_index > b.sort_index
  end)
  local task_config = ShareRes.create("condition.task")
  local condition_config = ShareRes.create("condition.condition")
  local award_group_config = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  self:release_items_by_template_key(LOOP_TASK_REWARD_ITEM_KEY)
  self:give_back_auto_cache(LOOP_TASK_REWARD_ITEM_KEY)
  self.v_complete_task_id = {}
  for i, config in ipairs(new_reward) do
    local reward_item = self:get_auto_cache(LOOP_TASK_REWARD_ITEM_KEY)
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    local task_info = TaskMgr:get_task_by_id(task_id)
    local condition_id = task_item_config.Condition[1]
    local need_value = condition_config[condition_id].Value
    local curr_text = Util.get_text("PointAmount/PointNow_", reward_item)
    local need_text = Util.get_text("PointAmount/PointNeed_", reward_item)
    curr_text.text = self.complete_active
    need_text.text = need_value
    local progress_icon = Util.get_image("PointIcon", reward_item)
    local progress_icon_color = progress_icon.color
    if need_value <= self.complete_active then
      progress_icon_color.a = 1
    else
      progress_icon_color.a = 0.5
    end
    progress_icon.color = progress_icon_color
    if task_info.state == TASK_STATE.received then
    elseif task_info.state == TASK_STATE.receive then
      table.insert(self.v_complete_task_id, task_id)
    end
    local award_group_id = task_item_config.Award
    local award_list = ShareRes.get_awards(award_group_id)
    for i = 1, 3 do
      local item_obj = Util.get_child_gameobj(Util.format_str("ItemList/Item{1}_", i), reward_item)
      local award = award_list[i]
      if award then
        local reward_item_obj = Util.get_child_gameobj(Util.format_str("ItemObjCom{1}_", i), item_obj)
        local finished_obj = Util.get_child_gameobj(Util.format_str("Check{1}_", i), item_obj)
        finished_obj:SetActive(false)
        local item_cfg = Item_Helper.get_item_cfg(award.ItemId)
        local quality_icon = Util.get_image("ItemQuality_", reward_item_obj)
        ResMgr:load_set_icon(quality_icon, bagConfig.Quality_Img[item_cfg.Quality])
        local item_icon = Util.get_image("ItemIcon_", reward_item_obj)
        local icon_path = ITEM_ICON_PATH .. item_cfg.Icon
        ResMgr:load_set_icon(item_icon, icon_path)
        local count_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", reward_item_obj)
        count_txt.text = award.Num
        local award_btn = Util.get_button(nil, reward_item_obj)
        self:set_button_listener(award_btn, function()
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = award.ItemId,
            jump_cb = function()
              UIMgr:try_hide_ui("material_stage_info")
            end
          })
        end)
        if need_value <= self.complete_active then
          finished_obj:SetActive(true)
        end
        item_obj:SetActive(true)
      else
        item_obj:SetActive(false)
      end
    end
  end
  if self.v_complete_task_id and #self.v_complete_task_id > 0 and not self.v_timer_index then
    self.v_timer_index = Timer:add_timer("uilooptask.decide_request_reward", 0.5, function()
      TaskMgr:submit_task_list(self.v_complete_task_id, function()
        self:refresh_view(self.v_tag_select)
      end)
      self.v_complete_task_id = {}
      if self.v_timer_index then
        Timer:remove_timer(self.v_timer_index)
        self.v_timer_index = nil
      end
    end)
  end
end

function ui:refresh_sys_open(msg)
  if not msg or not msg.mm_obj then
    return
  end
  local sys_id = msg.mm_obj
  local lock = self.v_tog_list[sys_id].lock
  if lock then
    lock:SetActive(not SysOpenMgr:get_sys_is_open(sys_id))
  end
end

function ui:refresh_tag_lock()
  for sys_id, v in pairs(self.v_tog_list) do
    local open = SysOpenMgr:get_sys_is_open(sys_id)
    v.lock:SetActive(not open)
  end
end

function ui:refresh_view(idx)
  self:clear_Seq()
  self.v_tag_select = idx
  self:refresh_task_view(idx)
  self:refresh_task_reward_list()
end

function ui:refresh_task_view()
  if self.v_tag_select == TASK_TYPE.DAILY_TASK then
    if not self.v_daily_task_list then
      self.v_daily_task_list = ShareRes.create("task.daily_task")
    end
    self:_refresh_task_item(self.v_daily_task_list)
  elseif self.v_tag_select == TASK_TYPE.WEEKLY_TASK then
    if not self.v_weekly_task_list then
      self.v_weekly_task_list = ShareRes.create("task.weekly_task")
    end
    self:_refresh_task_item(self.v_weekly_task_list)
  end
end

function ui:_refresh_task_item(task_list_config)
  local condition_config = ShareRes.create("condition.condition")
  local task_config = ShareRes.create("condition.task")
  local award_group = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  local new_data = {}
  self.v_receive_id_list = {}
  self.v_receive_item_list = {}
  self.v_player_active = 0
  local complete_active = 0
  for _, config in ipairs(task_list_config) do
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    local task_info = TaskMgr:get_task_by_id(task_id)
    local state = task_info.state
    local sort_index = 1
    if state == TASK_STATE.receive then
      sort_index = 2
    elseif state == TASK_STATE.received then
      sort_index = 0
    end
    config.sort_index = sort_index
    _tinsert(new_data, config)
  end
  table.sort(new_data, function(a, b)
    if a.sort_index == b.sort_index then
      return a.Id < b.Id
    end
    return a.sort_index > b.sort_index
  end)
  self:release_items_by_template_key(LOOP_TASK_ITEM_KEY)
  self:give_back_auto_cache(LOOP_TASK_ITEM_KEY)
  for i, config in ipairs(new_data) do
    local task_item = self:get_auto_cache(LOOP_TASK_ITEM_KEY)
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    Util.get_text("TItle", task_item).text = task_item_config.Name
    Util.get_text("Detil", task_item).text = ""
    local type_icon = Util.get_image("TypeIcon_", task_item)
    ResMgr:load_set_icon(type_icon, TOGGLE_LIST[self.v_tag_select].type_icon)
    local task_info = TaskMgr:get_task_by_id(task_id)
    local task_state = task_info.state
    Util.get_child_gameobj("Panel/NotFinish", task_item):SetActive(task_state == TASK_STATE.none)
    Util.get_child_gameobj("Panel/HasFinish", task_item):SetActive(task_state == TASK_STATE.received)
    Util.get_child_gameobj("Panel/Finish", task_item):SetActive(task_state == TASK_STATE.receive)
    Util.get_child_gameobj("Animation/Ani_VX_Finsh", task_item):SetActive(false)
    local award_id = award_group[task_item_config.Award][1]
    local award_num = award_config[award_id].Num
    local canvas_bg = Util.get_child_gameobj("Bg", task_item):GetComponent("CanvasGroup")
    local canvas_tit = Util.get_child_gameobj("TItle", task_item):GetComponent("CanvasGroup")
    local canvas_pbg = Util.get_child_gameobj("Panel/PointBg", task_item):GetComponent("CanvasGroup")
    local canvas_pro = Util.get_child_gameobj("ProgressNow", task_item):GetComponent("CanvasGroup")
    local canvas_probar = Util.get_child_gameobj("ProgressBar", task_item):GetComponent("CanvasGroup")
    local canvas_fin = Util.get_child_gameobj("Panel/Finish", task_item):GetComponent("CanvasGroup")
    canvas_bg.alpha = 1
    canvas_tit.alpha = 1
    canvas_pbg.alpha = 1
    canvas_pro.alpha = 1
    canvas_probar.alpha = 1
    canvas_fin.alpha = 1
    local progress = task_info and task_info.progress and #task_info.progress > 0 and task_info.progress[1].progress or 0
    local condition_id = task_item_config.Condition[1]
    local condition = condition_config[condition_id].Value
    Util.get_text("ProgressNow/interval/ProgressMax", task_item).text = condition
    Util.get_text("ProgressNow", task_item).text = progress
    Util.get_slider("ProgressBar", task_item).value = progress / condition
    if task_state == TASK_STATE.none then
      Util.get_text("Panel/NotFinish/Amount", task_item).text = award_num
    elseif task_state == TASK_STATE.receive then
      Util.get_child_gameobj("Panel/Finish/Mask", task_item):SetActive(false)
      Util.get_text("Panel/Finish/Amount", task_item).text = award_num
      local recive_btn = Util.get_button("Panel/Finish/GetBtn", task_item)
      self:set_button_listener(recive_btn, function()
        self:do_submit_single(task_item, task_id)
      end)
      _tinsert(self.v_receive_id_list, task_id)
      _tinsert(self.v_receive_item_list, {id = task_id, item = task_item})
      self.v_player_active = self.v_player_active + award_num
    elseif task_state == TASK_STATE.received then
      Util.get_text("Panel/HasFinish/Amount", task_item).text = award_num
      canvas_bg.alpha = 0.6
      self.v_player_active = self.v_player_active + award_num
      complete_active = complete_active + award_num
    end
    Util.get_child_gameobj("Animation/Ani_VX_HasFinsh", task_item):SetActive(task_state == TASK_STATE.received)
  end
  self.complete_active = complete_active
  local is_show_one_key_receive = false
  if self.v_receive_id_list and #self.v_receive_id_list > 1 then
    is_show_one_key_receive = true
    self.v_get_all_point_num.text = #self.v_receive_id_list
  end
  self.v_bottom.gameObject:SetActive(is_show_one_key_receive)
  self:update_btn_img()
  self:clear_Seq()
end

function ui:do_submit_single(task_item, task_id)
  if self.v_sequence then
    return
  end
  Util.get_child_gameobj("Animation/Ani_VX_Finsh", task_item):SetActive(true)
  self:clear_Seq()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:InsertCallback(0.3, function()
    self.v_uiobjects.FX_UI_Bloom:SetActive(true)
  end)
  self.v_sequence:InsertCallback(0.5, function()
    TaskMgr:submit_task(task_id, function()
      self:refresh_view(self.v_tag_select)
    end)
    self:clear_Seq()
  end)
end

function ui:do_submit_all()
  if not self.v_receive_id_list or not next(self.v_receive_id_list) then
    return
  end
  if not self.v_receive_item_list or not next(self.v_receive_item_list) then
    return
  end
  self:clear_Seq()
  self.v_sequence = Util.create_sequence()
  for idx, task_item in pairs(self.v_receive_item_list) do
    if UtilTable.contains(self.v_receive_id_list, task_item.id) then
      task_item = task_item.item
      Util.get_child_gameobj("Animation/Ani_VX_Finsh", task_item):SetActive(true)
    end
  end
  self.v_sequence:InsertCallback(0.3, function()
    self.v_uiobjects.FX_UI_Bloom:SetActive(true)
  end)
  self.v_sequence:InsertCallback(0.5, function()
    TaskMgr:submit_task_list(self.v_receive_id_list, function()
      self:refresh_view(self.v_tag_select)
    end)
    self:clear_Seq()
    self.v_receive_id_list = {}
  end)
  self.v_receive_item_list = {}
end

function ui:update_btn_img()
  local btn = Util.get_button(nil, self.v_uiobjects.Bottom)
  if next(self.v_receive_id_list) == nil then
    Util.disable_btn(btn, true)
  else
    Util.enable_btn(btn)
  end
end

function ui:clear_Seq()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:ui_on_hide()
end

return ui
