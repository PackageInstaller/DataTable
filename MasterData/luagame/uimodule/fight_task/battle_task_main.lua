local Base = require("ui.uibase")
local Math = require("base.mathx")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local TaskTogItemClass = require("uimodule.fight_task.battle_task_main_tog_item")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {}
local BATTLE_TASK_CFG = require("uimodule.fight_task.battle_task_config")
local BATTLE_TASK_TYPE = BATTLE_TASK_CFG.TASK_TYPE
local SHOW_TASK_LIST = BATTLE_TASK_CFG.SHOW_TASK_LIST
local TASK_STATE = BATTLE_TASK_CFG.TASK_STATE
local Group_State = {
  Tracking = 1,
  Processing = 2,
  Complete = 3
}
local INITLAYER = 2
local _insert = table.insert
local _sort = table.sort

function ui:ui_finish_load(...)
  self:init_model(MODEL)
  self.v_template_key = {
    GROUP_ITEM = "GROUP_ITEM" .. self:ui_get_name(),
    TASK_TYPE_ITEM = "TASK_TYPE_ITEM" .. self:ui_get_name(),
    REWARD_ITEM = "REWARD_ITEM" .. self:ui_get_name()
  }
  self:register_exist_auto_template(self.v_template_key.TASK_TYPE_ITEM, self.v_uiobjects.TypeItem, self.v_uiobjects.TaskList)
  self:register_exist_auto_template(self.v_template_key.GROUP_ITEM, self.v_uiobjects.TaskItem, self.v_uiobjects.TaskList)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self:set_button("BtnTrack", function()
    self:_onclick_track_btn()
  end)
end

function ui:_onclick_track_btn()
  if not self.v_cur_task_id then
    return
  end
  BattleTaskMgr:change_tack_task_id(self.v_cur_task_id)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_ID, self.msg_change_track_id, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_TRACK_BATTLE_TASK_PRO, self.refresh_content_info, self)
  self.v_cache_data = {}
  self:_refresh_task_list()
end

function ui:ui_on_hide()
  self:clear_wrap_item()
  self.v_group_list = {}
  self.v_toggle_list = {}
  self.v_toggle_data = {}
  self.v_select_index = 1
  self.v_select_group_id = nil
end

function ui:_refresh_task_list()
  self.v_group_list = {}
  self.v_toggle_list = {}
  self.v_toggle_data = {}
  self.v_select_index = 1
  self.v_select_group_id = nil
  self.v_task_obj_layer = INITLAYER
  local task_list = BattleTaskMgr:get_task()
  self:give_back_auto_cache(self.v_template_key.TASK_TYPE_ITEM)
  self:give_back_auto_cache(self.v_template_key.GROUP_ITEM)
  self:clear_wrap_item()
  for task_type, _ in ipairs(SHOW_TASK_LIST) do
    self.v_group_list[task_type] = self:_categorize_task(task_list, task_type)
    self:_create_template(task_type)
  end
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(self.v_toggle_list, function(idx)
    self:_onclick_group_tog(idx)
  end, -1)
  self.v_page_toggle_tab:set_toggle_by_index(self.v_select_index)
end

function ui:msg_change_track_id()
  local cur_track_id = BattleTaskMgr:get_track_task_id()
  local task = BattleTaskMgr:get_task(cur_track_id)
  local task_cfg = task:get_task_cfg()
  local group_id = task_cfg.Group
  for index, task_item_data in ipairs(self.v_toggle_data) do
    local last_state = task_item_data.state
    if task_item_data.group_id == group_id then
      self.v_select_index = index
      task_item_data.data.state = Group_State.Tracking
    else
      task_item_data.data.state = last_state >= Group_State.Complete and Group_State.Complete or Group_State.Processing
    end
    self:update_task_item_info(task_item_data.item, task_item_data, group_id)
  end
  self.v_select_group_id = nil
  self:_onclick_group_tog(self.v_select_index)
end

function ui:_create_template(task_type)
  self.v_cache_data[task_type] = self.v_cache_data[task_type] or {}
  local cache_data = self.v_cache_data[task_type]
  local group_list = self.v_group_list[task_type]
  for index, data in ipairs(group_list) do
    local group_id = data.group_id
    cache_data[group_id] = data
    self:new_task_group_item(task_type, data, index)
  end
end

function ui:new_task_type_item(task_type)
  local item = self:get_auto_cache(self.v_template_key.TASK_TYPE_ITEM)
  item.transform:SetSiblingIndex(self.v_task_obj_layer)
  self.v_task_obj_layer = self.v_task_obj_layer + 1
  local type_cfg = ShareRes.get_battle_task_type_cfg(task_type)
  local name_txt = Util.get_text("Content/TypeName", item)
  name_txt.text = type_cfg.TypeName
  local type_img = Util.get_image("Content/TypeIcon", item)
  ResMgr:load_set_icon(type_img, type_cfg.IconPath)
end

function ui:new_task_group_item(task_type, data, index)
  local obj = self:get_auto_cache(self.v_template_key.GROUP_ITEM)
  obj.transform:SetSiblingIndex(self.v_task_obj_layer)
  self.v_task_obj_layer = self.v_task_obj_layer + 1
  local group_id = data.group_id
  local state = data.state
  local is_track = state == Group_State.Tracking
  local item = TaskTogItemClass:ui_wrap_ex(self, obj, true)
  local data = {
    task_type = task_type,
    group_id = group_id,
    data = data,
    obj = obj,
    state = state,
    item = item
  }
  _insert(self.v_toggle_data, data)
  self:update_task_item_info(item, data, group_id)
  local tog = self:get_toggle(nil, obj)
  _insert(self.v_toggle_list, tog)
  if is_track then
    self.v_select_index = #self.v_toggle_list
  end
end

function ui:update_task_item_info(item, task_item_data, group_id)
  local complete_num, all_num = self:get_task_group_info(group_id)
  item:set_data(task_item_data, complete_num, all_num)
end

function ui:clear_wrap_item()
  if self.v_toggle_data then
    for _, v in pairs(self.v_toggle_data) do
      if v.item then
        self:remove_wrap_ui(v.item)
        v.item = nil
      end
    end
  end
end

function ui:get_task_group_info(group_id)
  local group_cfg = ShareRes.get_battle_task_group_list(group_id)
  if not group_cfg then
    return
  end
  local max_num = UtilTable.hash_lenth(group_cfg)
  local complete = 0
  if self.v_select_task_type == BATTLE_TASK_TYPE.CHALLENGE then
    max_num = 1
  end
  for _, data in ipairs(self.v_toggle_data) do
    if data.group_id == group_id and data.state >= Group_State.Complete then
      complete = max_num
      return complete, max_num
    end
  end
  for task_id, _ in pairs(group_cfg) do
    local task = BattleTaskMgr:get_task(task_id)
    if task and task:get_state() >= TASK_STATE.COMPLETE then
      complete = complete + 1
    end
  end
  complete = complete + 1
  complete = Math.Clamp(complete, 1, max_num)
  return complete, max_num
end

function ui:_onclick_group_tog(index)
  local data = self.v_toggle_data[index]
  local group_id = data.group_id
  local task_type = data.task_type
  if self.v_select_group_id == group_id then
    return
  end
  for _, toggle_data in pairs(self.v_toggle_data) do
    local id = toggle_data.group_id
    local toggle_obj = toggle_data.obj
    local select_obj = Util.get_rect_transform("Select", toggle_obj)
    select_obj.gameObject:SetActive(id == group_id)
  end
  self.v_select_group_id = group_id
  self.v_select_task_type = task_type
  self:refresh_content_info()
end

function ui:refresh_content_info()
  local group_id = self.v_select_group_id
  local task_type = self.v_select_task_type
  local group_data = self.v_cache_data[task_type][group_id]
  local task_list = group_data.task_list
  local cur_track_id = BattleTaskMgr:get_track_task_id()
  local cur_task
  for _, task in ipairs(task_list) do
    if task:get_state() < TASK_STATE.COMPLETE then
      cur_task = task
    elseif task:get_task_id() == cur_track_id then
      cur_task = task
      break
    end
  end
  if not cur_task then
    if not group_data.is_sort then
      _sort(task_list, function(a, b)
        return a:get_sort_val() < b:get_sort_val()
      end)
      group_data.is_sort = true
    end
    cur_task = task_list[#task_list]
  end
  local task_id = cur_task:get_task_id()
  self.v_cur_task_id = task_id
  self:refresh_task_content(group_id, cur_task)
  self:_refresh_task_reward(cur_task)
  local task_state = cur_task:get_state()
  local is_complete = task_state >= TASK_STATE.COMPLETE
  self.v_uiobjects.Complete:SetActive(is_complete)
  local cur_track_id = BattleTaskMgr:get_track_task_id()
  local is_track = cur_track_id == task_id
  self.v_uiobjects.Tracking:SetActive(is_track and not is_complete)
  self.v_uiobjects.BtnTrack:SetActive(not is_track and not is_complete)
  local cur_type = cur_task:get_task_cfg().Type
  for _type, _ in pairs(SHOW_TASK_LIST) do
    local type_icon_obj = self.v_uiobjects["SelectType" .. _type]
    local type_icon = self.v_uicompents["TaskType" .. _type .. "_img"]
    if type_icon_obj then
      type_icon_obj:SetActive(_type == cur_type)
      local color = type_icon.color
      color.a = _type == cur_type and 1 or 0.4
      type_icon.color = color
    end
  end
end

function ui:refresh_task_content(group_id, task)
  local cur_complete, max_num = self:get_task_group_info(group_id)
  local desc = "(" .. cur_complete .. "/" .. max_num .. ")"
  local group_cfg = ShareRes.get_battle_task_group_cfg(group_id)
  self.v_uicompents.InfoTitle_txt.text = group_cfg.GroupName .. desc
  local task_cfg = task:get_task_cfg()
  self.v_uicompents.TaskDesc_txt.text = task_cfg.Desc
  local condition_list = task_cfg.Condition
  local all_pro = 0
  local cur_pro = 0
  for _, condition_id in ipairs(condition_list) do
    if 0 ~= condition_id then
      local con_cfg = ShareRes.get_battle_task_condition_cfg(condition_id)
      if 1 == _ then
        all_pro = con_cfg.Value
      end
      local progress = task:get_task_progress(condition_id)
      cur_pro = cur_pro + progress
    end
  end
  local condition_id = task_cfg.Condition[1]
  if all_pro <= 0 then
    self.v_uicompents.TaskName_txt.text = task_cfg.Name
    return
  end
  local pro_desc = "[" .. cur_pro .. "/" .. all_pro .. "]"
  local desc = task_cfg.Name .. pro_desc
  self.v_uicompents.TaskName_txt.text = desc
end

function ui:_refresh_task_reward(task)
  local task_cfg = task:get_task_cfg()
  local show_id = task_cfg.ShowAwardId
  local reward_cfg = ShareRes.get_battle_task_show_award_data(show_id)
  if not reward_cfg then
    for i = 1, 8 do
      local path = "ItemObj" .. tostring(i)
      local replace_obj = self:get_child_gameobj(path, self.v_uiobjects.RewardList)
      replace_obj:SetActive(false)
    end
    return
  end
  local item_id_list = reward_cfg.ItemId
  local item_num_list = reward_cfg.ItemNum
  for i = 1, 8 do
    local path = "ItemObj" .. tostring(i)
    local replace_obj = self:get_child_gameobj(path, self.v_uiobjects.RewardList)
    local item_id = item_id_list[i]
    if item_id and 0 ~= item_id then
      replace_obj:SetActive(true)
      local param = {
        show_num = item_num_list[i],
        is_click = true,
        tips_source = BagCfg.TIPS_SOURCE.OTHER
      }
      self:create_item_obj(nil, replace_obj, self.v_template_key.REWARD_ITEM, {item_id = item_id, param = param})
    else
      replace_obj:SetActive(false)
    end
  end
end

function ui:_categorize_task(list, task_type)
  local cur_track_id = BattleTaskMgr:get_track_task_id()
  local group_list = {}
  for _, task in pairs(list) do
    local cfg = task:get_task_cfg()
    if cfg.Type == task_type then
      local group_id = cfg.Group
      if not group_list[group_id] then
        group_list[group_id] = {
          group_id = group_id,
          task_list = {}
        }
      end
      _insert(group_list[group_id].task_list, task)
    end
  end
  local task_list = {}
  for group_id, data in pairs(group_list) do
    local state = Group_State.Complete
    for _, task in ipairs(data.task_list) do
      local task_state = task:get_state()
      local task_id = task:get_task_id()
      if task_id == cur_track_id and task_state < TASK_STATE.COMPLETE then
        state = Group_State.Tracking
        break
      elseif task_state < TASK_STATE.COMPLETE then
        state = Group_State.Processing
      end
    end
    data.state = state
    _insert(task_list, data)
  end
  _sort(task_list, function(a, b)
    if a.state == b.state then
      return a.group_id < b.group_id
    end
    return a.state < b.state
  end)
  return task_list
end

return ui
