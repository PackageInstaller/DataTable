local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ITEM_OBJ_CLASS = require("uimodule.item.item_obj_com")
local TextMeshProType = typeof(CS.TMPro.TextMeshProUGUI)
local TASK_ACTIVITY_ITEM_TEMP_KEY = "TASK_ACTIVITY_ITEM_TEMP_KEY1"
local RED_ID = RedEnum.FATE_BOOK_TASK_AWARD
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")

function ui:ui_finish_load()
  self:set_button("BtnJump", function()
    SysOpenMgr:jump_to_sys(self.v_jump_id, true)
  end)
  self:set_button("BtnTask", function()
    UIMgr:get_ui("chapter_task"):ui_show(nil, self.v_task_group, "活动任务", true, true)
  end)
  self.v_desc_txt = self.v_uiobjects.ActivityDesc:GetComponent(TextMeshProType)
  self:register_exist_auto_template(TASK_ACTIVITY_ITEM_TEMP_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.Content)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedPoint, RED_ID)
end

function ui:ui_on_show(task_activity_id)
  self.v_activity_id = task_activity_id
  local cfg = ShareRes.create("activity.activity_task")[task_activity_id]
  if not cfg then
    Log.Error("任务活动表无对应id配置：", task_activity_id)
    return
  end
  self.v_jump_id = cfg.JumpId
  self.v_award_group = cfg.AwardGroupId
  self.v_task_group = cfg.TaskGroup
  self.v_desc_txt.text = cfg.Desc
  self:update_info()
  self:create_spine()
  NoviceMgr:read_novice_activity(self.v_activity_id)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.update_info, self)
end

function ui:ui_on_hide()
  self:clear_wrap_award()
  self:clear_spine_rt()
  UIMgr:try_hide_ui("chapter_task")
end

function ui:ui_on_destroy()
end

function ui:update_info()
  self:refresh_state()
  self:refresh_award()
end

function ui:refresh_state()
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local is_unlock = nil ~= activity_data
  if not is_unlock then
    local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
    self.v_uicompents.UnLockDesc_txt.text = ShareRes.get_condition_desc(activity_cfg.Condition)
  end
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.Unlock:SetActive(is_unlock)
end

function ui:refresh_award()
  if not self.v_award_group then
    return
  end
  self:give_back_auto_cache(TASK_ACTIVITY_ITEM_TEMP_KEY)
  self:clear_wrap_award()
  self.v_item_list = {}
  local awards = {}
  ShareRes.get_item_obj_use_award_list(self.v_award_group, awards)
  for _, award_data in ipairs(awards) do
    local item_obj = self:get_auto_cache(TASK_ACTIVITY_ITEM_TEMP_KEY)
    local item = ITEM_OBJ_CLASS:ui_wrap_ex(self, item_obj, true)
    item:set_data(award_data, true, true)
    table.insert(self.v_item_list, item)
  end
end

function ui:clear_wrap_award()
  if self.v_item_list then
    for key, item in pairs(self.v_item_list) do
      item:ui_hide()
      item:ui_destroy()
      self.v_item_list[key] = nil
    end
    self.v_item_list = nil
  end
end

function ui:create_spine()
  local spine_id = 202
  self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpineRaw)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  local role_res = spine_cfg.SpineRes
  local loop_anim_name = spine_cfg.DefaultAnim
  local pos_info = spine_cfg.Pos
  local raw = self:get_rawimage(nil, self.v_uiobjects.SpineRaw)
  raw.enabled = false
  
  local function load_cb(obj)
    if Util.is_nil(raw) then
      return
    end
    obj:ResetAttr()
    obj.transform:SetLocalScaleA(pos_info[4], pos_info[4], pos_info[4])
    obj.transform:SetLocalPositionA(pos_info[1], pos_info[2], pos_info[3])
    local spine_component = obj:GetComponent(typeof(CS.Game.SpineController))
    if Util.is_nil(spine_component) then
      return
    end
    spine_component:ClearTrackIndex()
    self.v_spine_rt:play_loop_anim(role_res, loop_anim_name)
    raw.enabled = true
  end
  
  self.v_spine_rt:load_spine_res(role_res, load_cb)
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

return ui
