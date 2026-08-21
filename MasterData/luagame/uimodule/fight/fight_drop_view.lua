local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY = {
  DROP_DESC_ITEM = "DROP_DESC_ITEM"
}
local ITEM_QUALITY_PATH = "UICommon/tx_zb_0%d"
local DROP_STRATRGY = {
  [1] = ""
}
local _insert = table.insert
local Vec2 = require("base.vec2")
local MAX_COUNT = 2

function ui:ui_finish_load()
  self.v_drop_queue = {}
  self.v_cur_count = 0
  self.v_cur_index = 0
  self.v_drop_show_list = {}
  self.v_drop_count = 0
  self.v_is_show = false
  self:register_exist_auto_template(TEMPLATE_KEY.DROP_DESC_ITEM, self.v_uiobjects.DropItemTemp, self.v_uiobjects.Queue)
end

function ui:ui_on_show(data, ...)
  self:ui_on_hide()
  self:_regist_client_event()
  self.v_drop_queue = FightBagMgr:get_drop_queue()
  self.v_drop_count = #self.v_drop_queue
  self:_refresh_drop_queue()
end

function ui:ui_on_hide()
  for k, v in pairs(self.v_drop_show_list) do
    if v.timer ~= nil then
      Timer:remove_timer(v.timer)
      v.timer = nil
    end
    if v.sequence then
      v.sequence:Kill(false)
      v.sequence = nil
    end
    if nil ~= v.obj then
      self:_hide_drop_item(v.obj)
    end
  end
  self.v_is_show = false
  self.v_drop_queue = {}
  self.v_cur_count = 0
  self.v_cur_index = 0
  self.v_drop_show_list = {}
  if self.v_local_move_seq then
    self:clear_ani_seq(self.v_local_move_seq)
  end
  self.v_local_move_seq = nil
  if self.v_timer_out_seq then
    self:clear_ani_seq(self.v_timer_out_seq)
  end
  self.v_timer_out_seq = nil
end

function ui:ui_on_destroy()
end

function ui:_regist_client_event()
end

function ui:_refresh_drop_queue()
  if next(self.v_drop_queue) == nil then
    self:set_enable(false)
    return
  end
  if self.v_cur_count == MAX_COUNT then
    self:set_enable(false)
    return
  end
  while self.v_cur_count < MAX_COUNT and next(self.v_drop_queue) ~= nil do
    local data = self.v_drop_queue[1]
    table.remove(self.v_drop_queue, 1)
    self.v_cur_index = self.v_cur_index + 1
    self.v_cur_count = self.v_cur_count + 1
    local obj = self:get_auto_cache(TEMPLATE_KEY.DROP_DESC_ITEM)
    self:_set_data(obj, data)
  end
end

function ui:_set_data(obj, data)
  local count = self.v_cur_index
  if self.v_drop_show_list[count] == nil then
    self.v_drop_show_list[count] = {}
  else
    return
  end
  self.v_drop_show_list[count].obj = obj
  obj.name = "Drop_" .. count
  local quality_img = self:get_image("Bg/DropPz", obj.transform)
  local item_desc = self:get_text("Bg/DropItem", obj.transform)
  local text = Util.format_str("{1}", data.cfg.Name)
  text = Util.format_quality_color(text, data.cfg.Quality)
  item_desc.text = text .. "*" .. data.count
  ResMgr:load_set_icon(quality_img, string.format(ITEM_QUALITY_PATH, data.cfg.Quality))
  if self.v_drop_count <= MAX_COUNT then
    local function timer_callback(index)
      self:_just_exit(index)
    end
    
    self:_set_obj_tween_end_with_timer(true, count, timer_callback, 2, self.v_drop_count, true)
  elseif 1 == count then
    local function timer_callback(index)
      self:_timer_out_one_by_one(index)
    end
    
    self:_set_obj_tween_end_with_timer(true, count, timer_callback, 1, count)
  elseif self.v_drop_count == count then
    local function callback(index)
      self:_last_three_callback(index)
    end
    
    self:_set_drop_obj_tween(true, count, callback, count)
  else
    self:_set_drop_obj_tween(true, count)
  end
end

function ui:_just_exit(count)
  for i = 1, count do
    if self.v_drop_show_list[i] ~= nil then
      self:_set_drop_obj_tween(false, i, function()
        self:_refresh_drop_queue()
      end)
    end
  end
end

function ui:_timer_out_one_by_one(index)
  local obj = self.v_drop_show_list[index] ~= nil and self.v_drop_show_list[index].obj or nil
  if nil == obj then
    self:set_enable(false)
    return
  end
  if self.v_drop_show_list[index].sequence then
    self.v_drop_show_list[index].sequence:Kill(false)
    self.v_drop_show_list[index].sequence = nil
  end
  Timer:remove_timer(self.v_drop_show_list[index].timer)
  self.v_drop_show_list[index].timer = nil
  if self.v_timer_out_seq then
    self:clear_ani_seq(self.v_timer_out_seq)
  end
  self.v_timer_out_seq = {}
  local moveObj = self:get_rect_transform("Bg", obj.transform)
  local sequence = Util.create_sequence()
  _insert(self.v_timer_out_seq, sequence)
  sequence:Append(moveObj:DOLocalMoveX(-300, 0.3))
  sequence:AppendCallback(function()
    if self.v_drop_count - index > MAX_COUNT then
      if self.v_drop_show_list[index + 1] ~= nil then
        self.v_drop_show_list[index + 1].timer = Timer:add_timer("drop_show_timer", 1, self._timer_out_one_by_one, self, index + 1)
      elseif nil ~= next(self.v_drop_queue) then
        self:set_enable(false)
        return
      end
      sequence:Kill(false)
      sequence = nil
    end
    self.v_cur_count = self.v_cur_count - 1
    if sequence then
      self.v_drop_show_list[index].sequence = sequence
    end
    self:_hide_drop_item(obj)
    self:_refresh_drop_queue()
  end)
end

function ui:_last_three_callback(index)
  for i = index - MAX_COUNT, index do
    local obj = self.v_drop_show_list[i] ~= nil and self.v_drop_show_list[i].obj or nil
    if nil == obj then
      self:set_enable(false)
      return
    end
    
    local function func(idx)
      self:_set_drop_obj_tween(false, idx, function()
        self:_refresh_drop_queue()
      end)
    end
    
    self.v_drop_show_list[i].timer = Timer:add_timer("drop_show_timer", 2, func, i)
  end
end

function ui:_set_obj_tween_end_with_callback(is_enter, obj, callback, param, kill_tween)
  if self.v_local_move_seq then
    self:clear_ani_seq(self.v_local_move_seq)
  end
  local moveObj = self:get_rect_transform("Bg", obj.transform)
  local sequence = Util.create_sequence()
  self.v_local_move_seq = {}
  _insert(self.v_local_move_seq, sequence)
  local start_value = true == is_enter and -300 or 0
  local end_value = true == is_enter and 0 or -300
  moveObj.anchoredPosition = Vec2.New(start_value, 0)
  sequence:Append(moveObj:DOLocalMoveX(end_value, 0.3))
  if callback then
    sequence:AppendCallback(function()
      callback(param)
      if true == kill_tween then
        sequence:Kill(false)
        sequence = nil
      end
    end)
  else
    if true == kill_tween then
    end
    sequence:Kill(false)
    sequence = nil
  end
end

function ui:_set_drop_obj_tween(is_enter, index, callback, tween_param, kill_tween)
  if self.v_drop_show_list[index] == nil then
    return
  end
  local obj = self.v_drop_show_list[index].obj
  self:_set_obj_tween_end_with_callback(is_enter, obj, callback, tween_param, kill_tween)
end

function ui:_set_obj_tween_end_with_timer(is_enter, index, timer_callback, time_lengh, param, kill_tween)
  if self.v_drop_show_list[index] == nil then
    return
  end
  if nil ~= self.v_drop_show_list[index].timer then
    return
  end
  
  local function callback()
    if not self.v_drop_show_list or self.v_drop_show_list[index] == nil then
      if timer_callback then
        timer_callback(param)
      end
      return
    end
    self.v_drop_show_list[index].timer = Timer:add_timer("drop_show_timer", time_lengh, timer_callback, param)
  end
  
  self:_set_drop_obj_tween(is_enter, index, callback, nil, kill_tween)
end

function ui:_hide_drop_item(obj)
  obj.transform.parent = self.v_uiobjects.NewParent.transform
  obj.transform:SetPositionA(0, 0, 0)
  obj.transform:SetLocalPositionA(1, 1, 1)
end

function ui:clear_ani_seq(seq_list)
  if not seq_list then
    return
  end
  for _, seq in pairs(seq_list) do
    seq:Kill()
  end
end

return ui
