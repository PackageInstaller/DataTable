local Base = require("ui.uibase")
local GoodsItemClass = require("uimodule.battle_bag.battle_item")
local ui = Util.create_child_mt(Base)
local TEMP_KEY = "POP_TEXT_TIP_KEY"
local TYPE_DOTWEEN_ANIM = typeof(CS.DG.Tweening.DOTweenAnimation)

function ui:ui_finish_load()
  self:register_exist_auto_template(TEMP_KEY, self.v_uiobjects.DropItemTemp, self.v_uiobjects.TextRoot)
  self.v_anim_counter = 0
  self.v_cur_idx = 0
  local battle_item_go = Util.get_child_gameobj("ItemObj", self.v_uiobjects.SeniorItemTem)
  local battle_item_obj = GoodsItemClass:ui_wrap_ex(self, battle_item_go, false)
  self.v_battle_item_obj = battle_item_obj
end

function ui:ui_on_show()
  if self.v_senior_cb then
    self.v_senior_cb()
    self.v_senior_cb = nil
  end
  self.v_show_cb = self.v_show_cb or {}
  for cb, _ in pairs(self.v_show_cb) do
    cb()
  end
  self.v_show_cb = {}
end

function ui:ui_on_hide()
  self.v_is_show_senior = false
  if self.v_senior_sequence then
    self.v_senior_sequence:Kill(false)
    self.v_senior_sequence = nil
  end
  self.v_pop_task_list = {}
end

function ui:add_pop_task(string)
  if self.v_is_show_senior then
    self.v_pop_task_list = self.v_pop_task_list or {}
    table.insert(self.v_pop_task_list, string)
    return
  end
  
  local function cb()
    self:pop_text(string)
    self.v_uiobjects.SeniorItemRoot:SetActive(false)
  end
  
  if self.v_visible then
    cb()
  else
    self.v_show_cb = self.v_show_cb or {}
    self.v_show_cb[cb] = true
  end
end

function ui:check_start_pop_task()
  if not self.v_pop_task_list or #self.v_pop_task_list <= 0 then
    return
  end
  for _, string in ipairs(self.v_pop_task_list) do
    self:add_pop_task(string)
  end
  self.v_pop_task_list = {}
end

function ui:add_senior_pop_task(drop_data)
  self.v_senior_list = self.v_senior_list or {}
  table.insert(self.v_senior_list, drop_data)
  if self.v_is_show_pop then
    return
  end
  
  function self.v_senior_cb()
    self:senior_pop_task()
  end
  
  if self.v_visible then
    self.v_senior_cb()
    self.v_senior_cb = nil
  end
end

function ui:check_start_senior_pop_task()
  self.v_senior_list = self.v_senior_list or {}
  if #self.v_senior_list <= 0 then
    return
  end
  self:senior_pop_task()
end

function ui:pop_text(string)
  self.v_uiobjects.TextRoot:SetActive(true)
  if 0 == self.v_cur_count then
    self:ui_show()
  end
  self.v_is_show_pop = true
  local item = self:get_auto_cache(TEMP_KEY)
  local rect = Util.get_rect_transform(nil, item)
  local cur_idel_idx = self:get_idx()
  rect:SetAnchoredPositionA(0, 50 * cur_idel_idx, 0)
  Util.get_text("Text_", item).text = string
  local tween = item:GetComponent(TYPE_DOTWEEN_ANIM)
  tween:CreateTween()
  item:SetActive(true)
  tween.onComplete:AddListener(function()
    tween.onComplete:RemoveAllListeners()
    if self.v_visible then
      self:give_back_auto_cache_obj(nil, item)
    end
    self:back_idx()
    self.v_is_show_pop = false
    self:check_start_senior_pop_task()
  end)
end

function ui:senior_pop_task()
  if not self.v_senior_list or 0 == #self.v_senior_list then
    self.v_uiobjects.SeniorItemRoot:SetActive(false)
    self.v_is_show_senior = false
    self:check_start_pop_task()
    return
  end
  self.v_is_show_senior = true
  self.v_uiobjects.TextRoot:SetActive(false)
  if self.v_senior_sequence then
    self.v_senior_sequence:Kill(false)
    self.v_senior_sequence = nil
  end
  self.v_uiobjects.SeniorItemRoot:SetActive(true)
  local show_data = self.v_senior_list[1]
  local item = self.v_uiobjects.SeniorItemTem
  item:SetActive(true)
  local config = show_data.cfg
  self.v_uicompents.ItemName_txt.text = config.Name
  self.v_uicompents.ItemDesc_txt.text = config.Desc
  
  local function click_cb()
    if TowerMgr then
      TowerMgr:open_fight_bag_panel()
    end
  end
  
  local item_param = {
    show_num = show_data.count,
    is_show_new_tag = true,
    click_cb = click_cb
  }
  self.v_battle_item_obj:set_enable(true, show_data.id, item_param)
  local canvas_group = self:get_canvas_group(nil, item.transform)
  local sequence = Util.create_sequence()
  sequence:Append(item.transform:DOLocalMoveX(281, 0.5))
  sequence:Join(canvas_group:DOFade(1, 0.5))
  sequence:Append(item.transform:DOLocalMoveX(-283, 0.5):SetDelay(1.5))
  sequence:Join(canvas_group:DOFade(0, 0.5))
  sequence:OnComplete(function()
    item:SetActive(false)
    self.v_battle_item_obj:set_enable(false)
    table.remove(self.v_senior_list, 1)
    if self.v_visible then
      self:senior_pop_task()
    else
      self.v_is_show_senior = false
    end
  end)
  self.v_senior_sequence = sequence
end

function ui:get_idx()
  if 0 == self.v_anim_counter then
    self.v_cur_idx = 0
  end
  self.v_anim_counter = self.v_anim_counter + 1
  self.v_cur_idx = self.v_cur_idx + 1
  return self.v_cur_idx
end

function ui:back_idx()
  self.v_anim_counter = self.v_anim_counter - 1
end

return ui
