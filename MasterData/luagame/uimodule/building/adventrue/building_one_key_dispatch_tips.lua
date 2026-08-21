local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ITEMOBJ_COM_BOX_ITEM_TEMP = "ITEMOBJ_COM_BOX_ITEM_TEMP"
local BUILDING_CONFIG = require("uimodule.building.building_config")
local BUILDING_ONE_KEY_TIPS_ITEM = require("uimodule.building.adventrue.building_one_key_tips_item")
local ADVENTURE_TASK_STATE = Config.CommonDefine.ADVENTURE_TASK_STATE
local BUILDING_BUDDY_LIMIT = Config.CommonDefine.BUILDING_BUDDY_LIMIT

function ui:on_click_BgClose()
  self:ui_hide()
end

function ui:on_click_BtnDispatch()
  if self.v_can_dispatch_count <= 0 then
    return
  end
  
  local function conform_cb()
    BuildingMgr:requst_building_adventure_batch_accept_task(self.v_can_dispatch_task_list, function()
      self:ui_hide()
      UIMgr:try_call_ui_func("building_adventrue_main", "show_dispatch_tips")
    end)
  end
  
  local tips_str
  if self.v_can_dispatch_count <= 0 then
    tips_str = "派遣记录已更改，请重新派遣"
  elseif self.v_all_dispatch_count > self.v_can_dispatch_count and self.v_role_change_count > 0 then
    tips_str = "角色配置发生变动，部分任务无法派遣成功，是否仍要一键派遣"
  end
  if tips_str then
    Util.show_conform_tip(tips_str, nil, nil, nil, conform_cb)
  else
    conform_cb()
  end
end

function ui:on_click_Btn_Cancel()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:on_click_BgClose()
  end)
  self:set_button("BtnDispatch", function()
    self:on_click_BtnDispatch()
  end)
  self:set_button("Btn_Cancel", function()
    self:on_click_Btn_Cancel()
  end)
  self:register_exist_auto_template(ITEMOBJ_COM_BOX_ITEM_TEMP, self.v_uiobjects.ItemObjComBox, self.v_uiobjects.ItemObjComBoxContent)
  self.v_item_list = {}
end

function ui:ui_on_show()
  if not self.v_clue_list then
    self.v_clue_list = {}
    local all_clue = ShareRes.get_building_clue_cfg()
    if all_clue then
      for id in pairs(all_clue) do
        self.v_clue_list[#self.v_clue_list + 1] = id
      end
    end
  end
  self:refresh_view()
end

function ui:refresh_view()
  self.v_can_dispatch_task_list = {}
  self:refresh_task_list()
end

function ui:ui_on_hide()
  for index, item in pairs(self.v_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_item_list[index] = nil
  end
end

function ui:ui_on_destroy()
end

local function sort_func(a, b)
  local a_task_cfg, b_task_cfg = ShareRes.get_adventrue_task_cfg(a.id), ShareRes.get_adventrue_task_cfg(b.id)
  if a_task_cfg and b_task_cfg and a_task_cfg.Quality ~= b_task_cfg.Quality then
    return a_task_cfg.Quality > b_task_cfg.Quality
  end
  return false
end

function ui:get_limit_list(limit_info)
  local char_limit, element_limit, job_limit
  if limit_info and limit_info then
    if limit_info.BuddyLimit then
      for buddy_id in pairs(limit_info.BuddyLimit) do
        char_limit = char_limit or {}
        char_limit[#char_limit + 1] = buddy_id
      end
    end
    if limit_info.ElementLimit then
      for element_id, count in pairs(limit_info.ElementLimit) do
        element_limit = element_limit or {}
        element_limit[element_id] = count
      end
    end
    if limit_info.JobLimit then
      for job_id, count in pairs(limit_info.JobLimit) do
        job_limit = job_limit or {}
        job_limit[job_id] = count
      end
    end
  end
  return char_limit, element_limit, job_limit
end

function ui:refresh_task_list()
  local all_task_data, all_count = self:get_all_task_data()
  local temp_select_map = {}
  self.v_all_dispatch_count = all_count
  self.v_can_dispatch_count = 0
  self.v_role_change_count = 0
  table.sort(all_task_data, sort_func)
  local temp_select_clue_uuid_map = {}
  for index, task_data in ipairs(all_task_data) do
    local quality_cfg = ShareRes.get_adventrue_task_quality_cfg_by_task_id(task_data.id)
    local use_buddy_id_list, slot_data_list = {}, {}
    local can_use_char_count, need_char_count = 0, quality_cfg.BuddyCount
    local target_clue_id = self:random_clue_id()
    local cfg = ShareRes.get_adventrue_task_cfg(task_data.id)
    local char_limit, element_limit, job_limit = self:get_limit_list(cfg.LimitInfo)
    self.v_buddy_list = BuildingMgr:get_sort_char_list_by_task_id(task_data.id, target_clue_id, nil, nil, true)
    for i = 1, 3 do
      local slot_data = {
        is_ban = need_char_count < i,
        fixed_char_id = char_limit and char_limit[i] or nil
      }
      if not slot_data.is_ban and not slot_data.char_id then
        self:fill_slot_data(slot_data, temp_select_map, cfg.LimitInfo, element_limit, job_limit)
      end
      if slot_data.char_id then
        use_buddy_id_list[#use_buddy_id_list + 1] = {
          buddy_id = slot_data.char_id
        }
        can_use_char_count = can_use_char_count + 1
      end
      slot_data_list[i] = slot_data
    end
    if need_char_count <= can_use_char_count then
      self:fill_dispatch_task_data(task_data, use_buddy_id_list, target_clue_id, temp_select_clue_uuid_map)
      self:create_task_item(task_data, target_clue_id, slot_data_list)
    else
      for _, data in pairs(use_buddy_id_list) do
        temp_select_map[data.buddy_id] = nil
      end
      self.v_all_can_dispatch = false
      self.v_all_dispatch_count = self.v_all_dispatch_count - 1
    end
  end
  self:refresh_dispatch_state()
end

function ui:refresh_dispatch_state()
  local can_dispatch = self.v_can_dispatch_count > 0
  if can_dispatch then
    self.v_uicompents.DispatchCurrent_txt.text = self.v_can_dispatch_count
    self.v_uicompents.DispatchAll_txt.text = self.v_all_dispatch_count
  end
  self.v_uiobjects.NoList:SetActive(not can_dispatch)
  CSHelper.SetUIGray(self.v_uiobjects.BtnDispatch, not can_dispatch)
  self.v_uiobjects.ScrollView:SetActive(can_dispatch)
end

function ui:create_task_item(task_data, target_clue_id, slot_data_list)
  local obj = self:get_auto_cache(ITEMOBJ_COM_BOX_ITEM_TEMP)
  local item = BUILDING_ONE_KEY_TIPS_ITEM:ui_wrap_ex(self, obj, true)
  table.insert(self.v_item_list, item)
  item:set_data(task_data.id, target_clue_id, slot_data_list, task_data.type)
end

function ui:fill_dispatch_task_data(task_data, use_buddy_id_list, target_clue_id, temp_select_clue_uuid_map)
  self.v_can_dispatch_count = self.v_can_dispatch_count + 1
  local dispatch_data = {
    type = task_data.type,
    index = task_data.index,
    buddy_list = use_buddy_id_list,
    target_clue_id = target_clue_id
  }
  local task_type_cfg = ShareRes.get_building_adventure_type(task_data.type)
  if task_type_cfg.ClueCount then
    dispatch_data.using_clue_ids = {}
    BuildingMgr:fill_select_clue_by_count(dispatch_data.using_clue_ids, task_type_cfg.ClueCount, temp_select_clue_uuid_map)
  end
  self.v_can_dispatch_task_list[#self.v_can_dispatch_task_list + 1] = dispatch_data
end

function ui:fill_slot_data(slot_data, temp_select_map, limit_info, element_limit, job_limit)
  self.v_role_change_count = self.v_role_change_count + 1
  for _, buddy_data in ipairs(self.v_buddy_list) do
    local buddy_id = buddy_data.id
    if temp_select_map[buddy_data.id] or limit_info and not self:check_buddy_can_select(buddy_id, slot_data.fixed_char_id, limit_info, element_limit, job_limit) then
    else
      slot_data.char_id = buddy_data.id
      temp_select_map[slot_data.char_id] = true
      break
    end
  end
end

local function _check_limit_table(limit_table, check_map, key)
  if not limit_table then
    return true
  end
  if limit_table[key] then
    if not check_map[key] then
      return false
    end
    check_map[key] = check_map[key] - 1
    if check_map[key] <= 0 then
      check_map[key] = nil
    end
    return true
  end
  if not UtilTable.is_empty(check_map) then
    return false
  end
  return true
end

function ui:check_buddy_can_select(buddy_id, fixed_char_id, limit_info, element_check_map, job_check_map)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local element_id = buddy_cfg.Element
  local job = buddy_cfg.Job
  if BuildingMgr:check_char_is_dispatch(buddy_id) then
    return false
  end
  if fixed_char_id and fixed_char_id ~= buddy_id then
    return false
  end
  local element_limit = limit_info.ElementLimit
  local limit_result = _check_limit_table(element_limit, element_check_map, element_id)
  if not limit_result then
    return limit_result
  end
  local job_limit = limit_info.JobLimit
  limit_result = _check_limit_table(job_limit, job_check_map, job)
  return limit_result
end

local function _get_all_task_data(task_map, all_task_data, max_count)
  for _, task_data in pairs(task_map) do
    if task_data.state == ADVENTURE_TASK_STATE.INIT then
      all_task_data[#all_task_data + 1] = task_data
      max_count = max_count + 1
    end
  end
  return max_count
end

function ui:get_all_task_data()
  local all_task_data = {}
  local max_count = 0
  self.v_all_can_dispatch = true
  local task_map = BuildingMgr:get_adventrue_type_data(BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.NORMAL)
  max_count = _get_all_task_data(task_map, all_task_data, max_count)
  task_map = BuildingMgr:get_adventrue_type_data(BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE.BRANCH)
  max_count = _get_all_task_data(task_map, all_task_data, max_count)
  return all_task_data, max_count
end

function ui:random_clue_id()
  local len = #self.v_clue_list
  if len <= 0 then
    return
  end
  return self.v_clue_list[math.random(1, len)]
end

return ui
