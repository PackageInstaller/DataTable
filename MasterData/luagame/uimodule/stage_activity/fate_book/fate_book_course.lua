local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local COURSE_NODE_ITEM_TEMP = "COURSE_NODE_ITEM_TEMP"
local COURSE_NODE_CODE_TEMP = "COURSE_NODE_CODE_TEMP"
local COURSE_NODE_TASK_TEMP = "COURSE_NODE_TASK_TEMP"
local COURSE_NODE_AWARD_TEMP = "COURSE_NODE_AWARD_TEMP"
local FATE_BOOK_COURSE_ITEM = require("uimodule.stage_activity.fate_book.fate_book_course_item")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local NODE_TYPE = {MAIN_NODE = 1, BRANCH_NODE = 2}
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE

local function sort(a, b)
  if a.Priority ~= b.Priority then
    return a.Priority < b.Priority
  elseif a.Id ~= b.Id then
    return a.Id < b.Id
  else
    return false
  end
end

function ui:on_select_course_item(select_course_id)
  if self.v_select_course_id == select_course_id then
    return
  end
  if self.v_select_course_id then
    local old_cfg = ShareRes.get_curse_course_node_cfg(self.v_select_course_id)
    local new_cfg = ShareRes.get_curse_course_node_cfg(select_course_id)
    if old_cfg.NodeType == NODE_TYPE.MAIN_NODE and new_cfg.NodeType == NODE_TYPE.MAIN_NODE then
      return
    end
  end
  local target_id
  local cfg = ShareRes.get_curse_course_node_cfg(select_course_id)
  if cfg.NodeType == NODE_TYPE.MAIN_NODE and self.v_all_main_node_list then
    local length = #self.v_all_main_node_list
    for index = 1, length do
      cfg = self.v_all_main_node_list[index]
      if TaskMgr:get_task_state(cfg.TaskId) < TASK_STATE.received or index == length then
        target_id = cfg.Id
        break
      end
    end
  end
  self.v_select_course_id = target_id or select_course_id
  for key, item in pairs(self.v_course_node_item_map) do
    item:on_select_item(select_course_id)
  end
  self:refresh_node_info()
end

function ui:on_click_num_btn(index, select_course_id)
  local select_img
  for key, obj in pairs(self.v_num_obj_list) do
    select_img = self:get_child_gameobj("Select", obj)
    select_img:SetActive(index == key)
  end
  self.v_select_course_id = select_course_id
  self:refresh_node_info(index)
end

function ui:on_click_story_btn()
  local cfg = ShareRes.get_curse_course_node_cfg(self.v_select_course_id)
  local story_id = cfg.StroyId
  if not story_id then
    return
  end
  StoryMgr:on_start(story_id)
end

function ui:on_click_receive_btn()
  local cfg = ShareRes.get_curse_course_node_cfg(self.v_select_course_id)
  local task_id = cfg.TaskId
  local task_data = TaskMgr:get_task_by_id(task_id)
  if task_data.state ~= TASK_STATE.receive then
    return
  end
  TaskMgr:submit_task(task_id, function()
    if not self:visible() then
      return
    end
    local is_main_suc = cfg.NodeType == NODE_TYPE.MAIN_NODE
    self:refresh_node_list(false, is_main_suc)
    if is_main_suc and self.v_main_node_id and self.v_course_node_item_map[self.v_main_node_id] then
      self.v_select_course_id = nil
      self.v_course_node_item_map[self.v_main_node_id]:on_click_btn()
      self:refresh_main_node_state()
    end
  end)
end

function ui:ui_finish_load()
  self:set_button("BtnReceive", function()
    self:on_click_receive_btn()
  end)
  self:set_button("BtnStory", function()
    self:on_click_story_btn()
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_course_node_item_map = {}
  self.v_all_main_node_list = {}
  self.v_lock_node_list = {}
  self.v_num_obj_list = {}
  self.v_award_item_list = {}
  self:register_exist_auto_template(COURSE_NODE_ITEM_TEMP, self.v_uiobjects.BranchNodeTem, self.v_uiobjects.NodeContent)
  self:register_exist_auto_template(COURSE_NODE_CODE_TEMP, self.v_uiobjects.CodeNumTem, self.v_uiobjects.MainCodeContent)
  self:register_exist_auto_template(COURSE_NODE_TASK_TEMP, self.v_uiobjects.Task, self.v_uiobjects.TaskContent)
  self:register_exist_auto_template(COURSE_NODE_AWARD_TEMP, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.AwardContent)
end

function ui:ui_on_show(course_chapter_id)
  self.v_course_chapter_id = course_chapter_id
  self.v_uiobjects.MainCodeContent:SetActive(false)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.on_task_update, self)
  self:refresh_node_list(true)
end

function ui:ui_on_hide()
  self.v_select_course_id = nil
  UtilTable.clear_map(self.v_all_main_node_list)
  self:clear_anima_timer()
  self:clear_node_item()
  self:clear_num_obj()
  self:clear_award_item()
end

function ui:ui_on_destroy()
end

function ui:refresh_node_list(init_show, play_unlock_anima)
  if play_unlock_anima then
    UtilTable.clear_map(self.v_last_lock_node_list)
    self.v_last_lock_node_list = UtilTable.copy_table(self.v_lock_node_list)
  end
  UtilTable.clear_map(self.v_lock_node_list)
  local all_node_cfg = ShareRes.get_curse_course_node_by_chapter_id(self.v_course_chapter_id)
  local temp_list = {}
  for key, cfg in pairs(all_node_cfg) do
    if cfg.NodeType == NODE_TYPE.MAIN_NODE then
      table.insert(temp_list, cfg)
    elseif FateBookMgr:check_curse_node_is_unlock(cfg.Id) then
      table.insert(temp_list, cfg)
    else
      self.v_lock_node_list[cfg.Id] = cfg
    end
  end
  table.sort(temp_list, sort)
  self.v_main_node_id = nil
  self:clear_node_item()
  UtilTable.clear_map(self.v_all_main_node_list)
  if play_unlock_anima or play_unlock_anima then
    self:anima_refresh_node_list(temp_list)
  else
    self:nor_refresh_node_list(temp_list)
  end
  if init_show then
    if not self.v_main_node_id then
      Log.Error("历程章节", self.v_course_chapter_id, "未配置主节点，请检查配置")
    else
      self.v_course_node_item_map[self.v_main_node_id]:on_click_btn()
      self:refresh_main_node_state()
    end
  end
end

function ui:anima_refresh_node_list(temp_list)
  local is_main_node, obj, item
  local branch_node_list = {}
  for key, cfg in ipairs(temp_list) do
    is_main_node = cfg.NodeType == NODE_TYPE.MAIN_NODE
    if is_main_node then
      if not self.v_main_node_id then
        self.v_main_node_id = cfg.Id
        item = FATE_BOOK_COURSE_ITEM:ui_wrap_ex(self, self.v_uiobjects.MainNodeTem, true)
        item:set_data(cfg, is_main_node)
        self.v_course_node_item_map[cfg.Id] = item
      end
      table.insert(self.v_all_main_node_list, cfg)
    elseif self.v_last_lock_node_list[cfg.Id] and not self.v_lock_node_list[cfg.Id] then
      table.insert(branch_node_list, cfg)
    else
      obj = self:get_auto_cache(COURSE_NODE_ITEM_TEMP)
      item = FATE_BOOK_COURSE_ITEM:ui_wrap_ex(self, obj, true)
      item:set_data(cfg, is_main_node)
      self.v_course_node_item_map[cfg.Id] = item
    end
  end
  UtilTable.clear_map(self.v_last_lock_node_list)
  self.v_cur_count = 1
  self.v_max_count = #branch_node_list
  self:clear_anima_timer()
  
  local function cycle_cb()
    obj = self:get_auto_cache(COURSE_NODE_ITEM_TEMP)
    local cfg = branch_node_list[self.v_cur_count]
    item = FATE_BOOK_COURSE_ITEM:ui_wrap_ex(self, obj, true)
    item:set_data(cfg, cfg.NodeType == NODE_TYPE.MAIN_NODE)
    self.v_course_node_item_map[cfg.Id] = item
    if self.v_cur_count >= self.v_max_count then
      self:clear_anima_timer()
      return false
    end
    self.v_cur_count = self.v_cur_count + 1
    return true
  end
  
  self.v_anima_timer = Timer:add_timer("anima_refresh_node_list", 0.5, cycle_cb, nil, nil, 0.5)
end

function ui:nor_refresh_node_list(temp_list)
  local is_main_node, obj, item, main_cfg, first_main_index, task_state
  for index, cfg in ipairs(temp_list) do
    item = nil
    task_state = TaskMgr:get_task_state(cfg.TaskId)
    is_main_node = cfg.NodeType == NODE_TYPE.MAIN_NODE
    if is_main_node then
      if not first_main_index then
        self.v_main_node_id = cfg.Id
        first_main_index = index
      end
      if FateBookMgr:check_curse_node_is_unlock(cfg.Id) and task_state ~= TASK_STATE.received then
        self.v_main_node_id = cfg.Id
        main_cfg = cfg
      end
      table.insert(self.v_all_main_node_list, cfg)
    elseif FateBookMgr:check_curse_node_is_unlock(cfg.Id) then
      obj = self:get_auto_cache(COURSE_NODE_ITEM_TEMP)
      item = FATE_BOOK_COURSE_ITEM:ui_wrap_ex(self, obj, true)
    end
    if item then
      item:set_data(cfg, is_main_node)
      self.v_course_node_item_map[cfg.Id] = item
    end
  end
  main_cfg = main_cfg or temp_list[first_main_index]
  if main_cfg then
    item = FATE_BOOK_COURSE_ITEM:ui_wrap_ex(self, self.v_uiobjects.MainNodeTem, true)
    item:set_data(main_cfg, true)
    self.v_course_node_item_map[main_cfg.Id] = item
  end
end

function ui:refresh_main_node_state()
  local task_state
  local complete, can_get = true, false
  for key, cfg in pairs(self.v_all_main_node_list) do
    task_state = TaskMgr:get_task_state(cfg.TaskId)
    if task_state == TASK_STATE.receive then
      can_get = true
    end
    if task_state ~= TASK_STATE.received then
      complete = false
    end
    if not complete and can_get then
      break
    end
  end
  self.v_course_node_item_map[self.v_main_node_id]:refresh_main_node_data(can_get, complete)
end

function ui:refresh_node_info(index)
  local cfg = ShareRes.get_curse_course_node_cfg(self.v_select_course_id)
  if not index then
    if cfg.NodeType == NODE_TYPE.MAIN_NODE then
      self:refersh_num_obj()
      self.v_uiobjects.MainCodeContent:SetActive(true)
      self.v_uiobjects.MainCodeNum:SetActive(true)
    else
      self:clear_num_obj()
      self.v_uiobjects.MainCodeContent:SetActive(false)
      self.v_uiobjects.MainCodeNum:SetActive(false)
    end
    index = self.v_main_course_index
  end
  local chapter_cfg = ShareRes.get_curse_course_chapter_cfg(self.v_course_chapter_id)
  self.v_uicompents.ChapName_txt.text = chapter_cfg.Name
  self.v_uicompents.NodeName_txt.text = cfg.Name
  if cfg.NodeType == NODE_TYPE.MAIN_NODE then
    self.v_uicompents.MainCodeNum_txt.text = index .. "/" .. #self.v_all_main_node_list
  end
  self.v_uicompents.NodeDesc_txt.text = cfg.UnfinishedDesc
  self:refresh_task(cfg)
  self:refresh_button_state(cfg)
  self.v_select_index = index
end

function ui:refresh_task(cfg)
  self:give_back_auto_cache(COURSE_NODE_TASK_TEMP)
  local obj, text
  local task_cfg = ShareRes.get_task_cfg(cfg.TaskId)
  local str = "%s(%d/%d)"
  if task_cfg then
    obj = self:get_auto_cache(COURSE_NODE_TASK_TEMP)
    text = self:get_text(nil, obj)
    local finish_count, all_count = TaskMgr:get_task_progress_by_id(cfg.TaskId)
    text.text = string.format(str, task_cfg.Desc, finish_count, all_count)
    self:refresh_task_award(task_cfg.Award)
  end
end

function ui:refresh_task_award(award_id)
  self:clear_award_item()
  local award_data = ShareRes.get_award_item_data(award_id)
  for index, data in ipairs(award_data) do
    local obj = self:get_auto_cache(COURSE_NODE_AWARD_TEMP)
    local item = ITEM_OBJ_COM:ui_wrap(self, obj)
    item:set_data(data, true)
    self.v_award_item_list[index] = item
  end
end

function ui:refresh_button_state(cfg)
  self.v_uiobjects.UnLock:SetActive(false)
  self.v_uiobjects.BtnReceive:SetActive(false)
  self.v_uiobjects.UnFinish:SetActive(false)
  self.v_uiobjects.Finish:SetActive(false)
  self.v_uiobjects.BtnStory:SetActive(false)
  local no_pass_condition
  if not FateBookMgr:check_curse_node_is_unlock(cfg.Id) then
    for key, condition in ipairs(cfg.Condition) do
      if condition > 0 and not FateBookMgr:check_course_condition_pass(condition) then
        no_pass_condition = condition
        break
      end
    end
  end
  if no_pass_condition then
    self.v_uicompents.Condition_txt.text = ShareRes.get_condition_desc(no_pass_condition)
    self.v_uiobjects.UnLock:SetActive(true)
    return
  end
  local task_state = TaskMgr:get_task_state(cfg.TaskId)
  if task_state < TASK_STATE.receive then
    self.v_uiobjects.UnFinish:SetActive(true)
    return
  elseif task_state == TASK_STATE.receive then
    self.v_uiobjects.BtnReceive:SetActive(true)
    return
  else
    self.v_uicompents.NodeDesc_txt.text = cfg.Desc
    if cfg.StroyId then
      self.v_uiobjects.BtnStory:SetActive(true)
    else
      self.v_uiobjects.Finish:SetActive(true)
    end
  end
end

function ui:refersh_num_obj()
  self:clear_num_obj()
  local obj, num, line, select_img, btn
  local max_count = #self.v_all_main_node_list
  for index = 1, max_count do
    local cfg = self.v_all_main_node_list[index]
    obj = self:get_auto_cache(COURSE_NODE_CODE_TEMP)
    self.v_num_obj_list[index] = obj
    num = self:get_text("Num", obj)
    num.text = index
    select_img = self:get_child_gameobj("Select", obj)
    if cfg.Id == self.v_select_course_id then
      self.v_main_course_index = index
      select_img:SetActive(true)
    else
      select_img:SetActive(false)
    end
    btn = self:get_button(nil, obj)
    self:set_button_listener(btn, function()
      self:on_click_num_btn(index, cfg.Id)
    end)
    line = self:get_child_gameobj("Line", obj)
    line:SetActive(index ~= max_count)
  end
end

function ui:clear_num_obj()
  self:give_back_auto_cache(COURSE_NODE_CODE_TEMP)
  self.v_num_obj_list = {}
end

function ui:clear_node_item()
  self:give_back_auto_cache(COURSE_NODE_ITEM_TEMP)
  for key, item in pairs(self.v_course_node_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_course_node_item_map[key] = nil
  end
end

function ui:clear_award_item()
  self:give_back_auto_cache(COURSE_NODE_AWARD_TEMP)
  for key, item in pairs(self.v_award_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_award_item_list[key] = nil
  end
end

function ui:close_story_full_bg()
  self.v_uiobjects.FullBg2:SetActive(false)
end

function ui:clear_anima_timer()
  if self.v_anima_timer then
    Timer:remove_timer(self.v_anima_timer)
    self.v_anima_timer = nil
  end
end

function ui:open_story_full_bg(story_bg)
  if story_bg then
    ResMgr:load_set_icon(self.v_uicompents.FullBg2_img, story_bg, function()
      self.v_uiobjects.FullBg2:SetActive(true)
    end, true, self)
  end
end

function ui:on_task_update(msg)
  self:refresh_node_info(self.v_select_index)
end

function ui:check_need_select_new_main_node(select_course_id)
  local cfg = ShareRes.get_curse_course_node_cfg(select_course_id)
  if cfg.NodeType == NODE_TYPE.MAIN_NODE and self.v_all_main_node_list then
    local length = #self.v_all_main_node_list
    for index = 1, length do
      cfg = self.v_all_main_node_list[index]
      if TaskMgr:get_task_state(cfg.TaskId) < TASK_STATE.received or index == length then
        select_course_id = cfg.Id
        break
      end
    end
  end
  return select_course_id
end

return ui
