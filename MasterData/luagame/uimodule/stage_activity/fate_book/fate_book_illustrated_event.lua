local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ILLUSTARATED_EVENT_GROUP_TEMP = "ILLUSTARATED_EVENT_GROUP_TEMP"
local ILLUSTARATED_EVENT_TEMP = "ILLUSTARATED_EVENT_TEMP"
local SaticSv = require("ui.widget.static_scroll_view")
local ILLUSTRATED_EVENT_ITEM = require("uimodule.stage_activity.fate_book.illustrated_event_item")
local TOTAL_GROUP_ID = 0

function ui:on_select_group(isOn, group_id)
  if not isOn or self.v_group_id == group_id then
    return
  end
  self.v_group_id = group_id
  self:refresh_select_group_info()
end

function ui:ui_finish_load()
  self:set_button("BtnAward", function()
    local task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT)
    UIMgr:get_ui("chapter_task"):ui_show(nil, task_group_id, "收集进度")
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_all_event_id_list = {}
  self:register_exist_auto_template(ILLUSTARATED_EVENT_GROUP_TEMP, self.v_uiobjects.EventGroupTem, self.v_uiobjects.EventGroupContent)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.EventContent, ILLUSTRATED_EVENT_ITEM, ILLUSTARATED_EVENT_TEMP)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_redpoint, self)
  self:refresh_event_tog()
  self:refresh_task_redpoint()
end

function ui:ui_on_hide()
  self.v_all_event_id_list = {}
  self.v_group_id = nil
end

function ui:ui_on_destroy()
end

function ui:refresh_event_tog()
  local all_group_cfg = ShareRes.get_curse_event_group_cfg()
  local temp_list = {}
  for key, cfg in pairs(all_group_cfg) do
    if #cfg.EventId >= 1 and cfg.Id > 0 and Util.is_more_than_zero(cfg.Ifshow) then
      temp_list[#temp_list + 1] = cfg
      for key, event_id in pairs(cfg.EventId) do
        self.v_all_event_id_list[#self.v_all_event_id_list + 1] = event_id
      end
    end
  end
  temp_list[#temp_list + 1] = {
    Priority = -1,
    Name = "全部",
    Id = 0
  }
  table.sort(temp_list, function(a, b)
    if a.Priority ~= b.Priority then
      return a.Priority < b.Priority
    end
  end)
  self:give_back_auto_cache(ILLUSTARATED_EVENT_GROUP_TEMP)
  local obj, tog, txt, first_tog
  for _, gruop_cfg in ipairs(temp_list) do
    obj = self:get_auto_cache(ILLUSTARATED_EVENT_GROUP_TEMP)
    tog = self:get_toggle(nil, obj)
    first_tog = first_tog or tog
    self:set_toggle_listener(tog, function(isOn)
      self:on_select_group(isOn, gruop_cfg.Id)
    end)
    tog.isOn = false
    txt = self:get_text("GroupName", obj)
    txt.text = gruop_cfg.Name
  end
  self.v_is_in_init = false
  first_tog.isOn = false
  first_tog.isOn = true
end

function ui:refresh_select_group_info()
  local gourp_cfg = ShareRes.get_curse_event_group_cfg(self.v_group_id)
  local total_count = 0
  local unlock_total_count = 0
  local event_unlock_data = FateBookMgr:get_illustrated_data(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT)
  local cfg
  local not_total_group = self.v_group_id ~= TOTAL_GROUP_ID
  local event_list = not_total_group and gourp_cfg.EventId or self.v_all_event_id_list
  local temp_list = {}
  for key, event_id in pairs(event_list) do
    cfg = ShareRes.get_curse_event_cfg(event_id)
    table.insert(temp_list, cfg)
    total_count = total_count + 1
    if event_unlock_data[cfg.Id] then
      unlock_total_count = unlock_total_count + 1
    end
  end
  local all_group_cfg = ShareRes.get_curse_event_group_cfg()
  local a_group_pri, b_group_pri
  table.sort(temp_list, function(a, b)
    if not_total_group then
      if a.Priority ~= b.Priority then
        return a.Priority < b.Priority
      end
    else
      a_group_pri = all_group_cfg[a.Group].Priority
      b_group_pri = all_group_cfg[b.Group].Priority
      if a_group_pri ~= b_group_pri then
        return a_group_pri < b_group_pri
      elseif a.Priority ~= b.Priority then
        return a.Priority < b.Priority
      end
    end
    return false
  end)
  self.v_uicompents.EventNow_txt.text = unlock_total_count
  self.v_uicompents.EventMax_txt.text = total_count
  self.v_static_sv:update_list(temp_list)
  self:refresh_group_redpoint(temp_list)
end

function ui:refresh_task_redpoint()
  local task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT)
  local have_red = TaskMgr:get_task_group_red(task_group_id)
  local bg = self:get_child_gameobj("ActBg", self.v_uiobjects.BtnAward)
  if bg then
    bg.gameObject:SetActive(have_red)
  end
  self.v_uiobjects.RedPoint:SetActive(have_red)
end

function ui:refresh_group_redpoint(temp_list)
  local count = 0
  local total_count = 0
  for key, cfg in pairs(temp_list) do
    local event_id = cfg.Id
    if event_id > 0 then
      if FateBookMgr:get_red_state(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT, event_id) then
        count = count + 1
        FateBookMgr:close_redpoint(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT, event_id, total_count <= count)
      end
      total_count = total_count + 1
    end
  end
end

return ui
