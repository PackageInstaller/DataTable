local Base = require("ui.uiobject")
local CHAPTER_POINT_ITEM_CLASS = require("uimodule.chapter.chapter_point_item")
local CommonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local _insert = table.insert
local ACTY_TYPE = CommonDef.ACTY_TYPE
local item_show_time = 0.2
local show_item_interval_time = 0.1
local single_point_cost_time = 0.5
local CHAPTER_TYPE = {MULTI_POINT = 1, SINGLE_POINT = 2}
local OVERLAY_STATE = {NONE = 1, CHANGE = 2}

function ui:ui_finish_load()
end

function ui:ui_on_show(chapter_id, points, fight_type, ...)
  self:register_event()
  if chapter_id then
    self.v_chapter_id = chapter_id
    self.v_chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
    self.v_point_data = self.v_chapter_cfg.Point
  else
    self.v_point_data = points
    self.v_fight_type = fight_type
  end
  if self.v_chapter_cfg and 1 == self.v_chapter_cfg.ChapterType and self.v_uiobjects.ContentLayout then
    self.v_content_trans = Util.get_rect_transform(nil, self.v_uiobjects.ContentLayout)
  end
  self:refresh_chapter_point_list()
end

function ui:ui_on_hide()
  self.v_point_data = nil
  self.v_chapter_cfg = nil
  self:clear_chapter_point_list()
  self:clear_sequence()
end

function ui:register_event()
end

function ui:response_select_stage_tem(msg)
  if nil == msg then
    return
  end
  local overlay_state = msg.mm_y
  local index = msg.mm_z
  if overlay_state and overlay_state == OVERLAY_STATE.CHANGE then
    local select_item = self.v_uiobjects["StageTem" .. index]
    if not select_item then
      return
    end
    local finally_x = math.min(0, -1 * (select_item.transform.anchoredPosition.x - 1000))
    if self.v_content_min_pos_x then
      finally_x = math.max(finally_x, self.v_content_min_pos_x)
    end
    self:clear_sequence()
    self.v_sequence = Util.create_sequence()
    self.v_sequence:Append(self.v_content_trans:DOLocalMoveX(finally_x, 0.5))
  end
end

function ui:clear_chapter_point_list()
  if self.v_chapter_point_list then
    self:remove_wrap_ui_list(self.v_chapter_point_list)
  end
end

function ui:refresh_chapter_point_list()
  self:clear_chapter_point_list()
  self.v_chapter_point_list = {}
  self.v_show_item_count = 0
  for index = 1, 10 do
    local point_id = self.v_point_data[index]
    local item_obj = self.v_uiobjects["StageTem" .. index]
    if not item_obj then
    elseif point_id and 0 ~= point_id and self:check_point_open(point_id) then
      local lua_obj = CHAPTER_POINT_ITEM_CLASS:ui_wrap_ex(self, item_obj, false)
      lua_obj:set_self_lock(false)
      if not self:_check_chapter_additional_conditions(point_id) then
        lua_obj:set_self_lock(true)
      end
      lua_obj:set_enable(true, point_id, self.v_chapter_id, self.v_fight_type, index)
      _insert(self.v_chapter_point_list, lua_obj)
      self:calculate_show_item_count(item_obj)
    else
      item_obj:SetActive(false)
    end
  end
  self:update_cur_fight_mark()
end

function ui:calculate_show_item_count(item_obj)
  if self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.BEST_CONF and self.v_chapter_cfg and 1 == self.v_chapter_cfg.ChapterType then
    self.v_show_item_count = self.v_show_item_count + 1
  end
end

function ui:get_show_item_count()
  return self.v_show_item_count
end

function ui:get_show_all_item_time()
  if self.v_chapter_cfg.ChapterType == CHAPTER_TYPE.MULTI_POINT then
    return item_show_time + self.v_show_item_count * show_item_interval_time
  else
    return single_point_cost_time
  end
end

function ui:check_point_open(point_id)
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BEST_CONF then
    return self:_check_best_point_open(point_id)
  end
  return self:_check_chapter_point_open(point_id)
end

function ui:_check_best_point_open(point_id)
  return true
end

function ui:_check_chapter_point_open(point_id)
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local FrontPointId = point_cfg.FrontPointId
  if 0 ~= FrontPointId then
    local no_first_suc = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, FrontPointId)
    if no_first_suc then
      return
    end
  end
  return true
end

function ui:_check_chapter_additional_conditions(point_id)
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local condition = Condition:check_condition(point_cfg.Condition)
  if not condition then
    return false
  end
  return true
end

function ui:update_cur_fight_mark()
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BEST_CONF then
    self:_set_best_point_mark()
  else
    self:_set_chapter_point_mark()
  end
end

function ui:_set_best_point_mark()
  local last_id = 1
  for i = 1, 10 do
    local point_id = self.v_point_data[i]
    if not point_id then
      break
    end
    if 2 == ActivityMgr:invoke(ACTY_TYPE.BEST_CONFIG_FIGHT, "get_stage_state", point_id) then
      last_id = i
    end
  end
  local lua_obj = self.v_chapter_point_list[last_id]
  if lua_obj then
    lua_obj:refresh_mark_state(true)
  end
end

function ui:_set_chapter_point_mark()
  local cur_fight_index = ChapterMgr:get_cur_fight_index(self.v_chapter_id)
  if not cur_fight_index then
    return
  end
  local lua_obj = self.v_chapter_point_list[cur_fight_index]
  if lua_obj then
    lua_obj:refresh_mark_state(true)
  end
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:set_content_layout_min_pos()
  self.v_content_min_pos_x = self.v_content_trans.anchoredPosition.x
end

return ui
