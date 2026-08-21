local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}
local ITEM_AWARD_FISH_GAME = "ITEM_AWARD_FISH_GAME"

function ui:ui_finish_load()
  self:set_button("CtJump", function()
    if self.v_task_can_jump then
      SysOpenMgr:jump_to_sys(self.v_task_jump, true)
      self:ui_hide()
    end
  end)
  self:set_button("CtGet", function()
    self:on_click_task()
  end)
end

function ui:check_register_template(id)
  if not self.v_temp_key then
    self.v_temp_key = ITEM_AWARD_FISH_GAME .. id
    self:register_exist_auto_template(self.v_temp_key, self.v_uiobjects.AwardItem, self.v_uiobjects.AwardContent)
  end
end

function ui:set_data(go, data_list, index)
  self.v_task_cfg = data_list[index]
  self.v_task_id = self.v_task_cfg.Id
  self.v_item_id = index
  self.v_task_award_group = self.v_task_cfg.Award
  self.v_uicompents.CtContent_txt.text = self.v_task_cfg.Desc
  self.v_task_data = TaskMgr:get_task_by_id(self.v_task_id)
  if self.v_task_data then
    local condition_id = self.v_task_cfg.Condition[1]
    local condition_cfg = ShareRes.get_battle_task_condition_cfg(condition_id)
    local need_num = condition_cfg.Value
    local now_num = self.v_task_data.condition[condition_id]
    if need_num < now_num then
      now_num = need_num
    end
    self.v_uiobjects.Now:SetActive(true)
    self.v_uicompents.Now_txt.text = now_num
    self.v_uicompents.Need_txt.text = need_num
    self.v_uicompents.CtTaskDone_img.fillAmount = 0
    if nil ~= now_num and nil ~= need_num and need_num > 0 then
      self.v_uicompents.CtTaskDone_img.fillAmount = now_num / need_num
    end
  else
    self.v_uiobjects.Now:SetActive(false)
  end
  self.v_task_jump = self.v_task_cfg.Jump
  self.v_task_can_jump = 0 ~= self.v_task_jump
  self.v_task_status = TaskMgr:get_task_state(self.v_task_id)
  self.v_uiobjects.CtJump:SetActive(false)
  self.v_uiobjects.CtGet:SetActive(false)
  self.v_uiobjects.FinishText:SetActive(false)
  self.v_uiobjects.NowText:SetActive(false)
  if self.v_task_status == TASK_STATE.GET_REWARD then
    self.v_uiobjects.FinishText:SetActive(true)
  elseif self.v_task_status == TASK_STATE.COMPLETE then
    self.v_uiobjects.CtGet:SetActive(true)
  elseif self.v_task_can_jump then
    self.v_uiobjects.CtJump:SetActive(true)
  else
    self.v_uiobjects.NowText:SetActive(true)
  end
  self:refresh_stage_info()
  self:refresh_award()
end

function ui:refresh_award()
  self:check_register_template(self.v_item_id)
  self:give_back_auto_cache(self.v_temp_key)
  self.v_award_list = ShareRes.get_award_item_data(self.v_task_award_group)
  for _, data in ipairs(self.v_award_list) do
    local item = self:get_auto_cache(self.v_temp_key)
    self:set_award_info(item, data)
  end
end

function ui:refresh_stage_info()
end

function ui:set_award_info(set_obj, data)
  if nil == data then
    return
  end
  set_obj:SetActive(true)
  local item_btn = self:get_button(nil, set_obj)
  local item_id_param = data[1]
  local item_num_param = data[2]
  self:set_button_listener(item_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id_param})
  end)
  local ItemQuality_img = Util.get_image("CiPz", set_obj)
  ResMgr:load_set_icon(ItemQuality_img, UtilUI.get_item_quality_icon(item_id_param))
  local ItemIcon_img = Util.get_image("CiItemIcon", set_obj)
  ResMgr:load_set_icon(ItemIcon_img, UtilUI.get_item_icon(item_id_param))
  local ItemAmount_obj = Util.get_child_gameobj("AmoBg", set_obj)
  ItemAmount_obj:SetActive(item_num_param > 1)
  local ItemNum_txt = Util.get_text("AmoBg/CiItemAmount", set_obj)
  ItemNum_txt.text = item_num_param
  local mask_obj = Util.get_child_gameobj("Mask_", set_obj)
  mask_obj:SetActive(self.v_task_status == TASK_STATE.GET_REWARD)
end

function ui:on_click_task()
  if self.v_task_data ~= nil and self.v_task_data.state == TASK_STATE.COMPLETE then
    TaskMgr:submit_task(self.v_task_id, function()
    end)
  end
end

function ui:set_linked_parent(parent_ui)
  self.v_parent_ui = parent_ui
end

return ui
