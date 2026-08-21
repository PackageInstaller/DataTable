local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local HP_BG_DISAPPEAR_TIME = 0.8
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local ABNORMAL_BP_START = 1
local ABNORMAL_BP_END = 6
local BIND_TYPE = Config.BIND_TYPE
local SEQ_MAX_NUM = 1000
local EB_SCALE_X = 1.002

function ui:ui_finish_load()
  self.v_abnormal_list = {}
  self.v_abnormal_image_list = {}
  for i = ABNORMAL_BP_START, ABNORMAL_BP_END do
    self.v_abnormal_list[i] = self:get_uiobject("Buff" .. i, BIND_TYPE.OBJECT)
    self.v_abnormal_image_list[i] = Util.get_image("Fill", self.v_abnormal_list[i])
  end
  self.v_init_blood_pos_x, self.v_init_blood_pos_y = self.v_uicompents.Blood_rect:GetAnchoredMinMax()
  self.v_dt_count = 0
end

function ui:ui_on_show()
  self.v_hp_bg_disappear_seq = {}
end

function ui:ui_on_hide()
  self:clear_dotween_seq()
  self.v_last_frame_hp = nil
end

function ui:ui_on_destroy()
  self.v_abnormal_list = nil
  self.v_abnormal_image_list = nil
  self.v_init_blood_pos = nil
end

function ui:create_dotween()
  self.v_dt_count = (self.v_dt_count + 1) % SEQ_MAX_NUM
  local new_seq = Util.create_sequence()
  self.v_hp_bg_disappear_seq[self.v_dt_count] = new_seq
  return self.v_dt_count
end

function ui:clear_seq(dt_count)
  self.v_hp_bg_disappear_seq[dt_count]:Kill()
  self.v_hp_bg_disappear_seq[dt_count] = nil
end

function ui:clear_dotween_seq()
  for _, dt_obj in pairs(self.v_hp_bg_disappear_seq) do
    dt_obj:Kill()
  end
  self.v_hp_bg_disappear_seq = nil
end

function ui:update_enemy_blood(part_obj)
  local hp = part_obj.attrs[ATTR_TYPE.CHAR_HP]
  local hp_max = part_obj.attrs[ATTR_TYPE.CHAR_HP_MAX]
  local percent = hp / hp_max
  self.v_uicompents.Blood_Hp_img.fillAmount = percent
  local npc = SceneMgr:get_npc_by_id(part_obj.part_uuid)
  local cur_target = npc
  local target_cfg = cur_target.character_cfg
  if not self:check_show_targetd_hp(cur_target) then
    self.v_uicompents.Blood_Dong_img.fillAmount = percent
    self:update_ui_visible(self.v_uiobjects.Display, false)
    self.v_last_frame_hp = nil
    return
  end
  self:update_ui_visible(self.v_uiobjects.Display, true)
  local name = cur_target:get_name()
  self.v_uicompents.enemy_txt.text = name
  self.v_last_frame_hp = self.v_last_frame_hp or hp
  if self.v_last_frame_hp ~= hp then
    self.v_last_frame_hp = hp
    local dt_count = self:create_dotween()
    self.v_hp_bg_disappear_seq[dt_count]:Append(self.v_uicompents.Blood_Dong_img:DOFillAmount(percent, HP_BG_DISAPPEAR_TIME))
    local blood_trans = self.v_uicompents.Blood_rect
    self.v_hp_bg_disappear_seq[dt_count]:Join(blood_trans:DOShakeAnchorPos(0.2, 10, 40, 50, true):OnComplete(function()
      blood_trans:SetAnchoredPositionA(self.v_init_blood_pos_x, self.v_init_blood_pos_y)
      self:clear_seq(dt_count)
    end))
  else
    self.v_uicompents.Blood_Dong_img.fillAmount = percent
  end
end

function ui:update_enemy_abnormal(target)
  local attrs = target.attrs
  local abnormal_bp_list = {
    attrs[ATTR_TYPE.CHAR_ABNORMAL_BP1],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_BP2],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_BP3],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_BP4],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_BP5],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_BP6]
  }
  local abnormal_max_list = {
    attrs[ATTR_TYPE.CHAR_ABNORMAL_MAX1],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_MAX2],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_MAX3],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_MAX4],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_MAX5],
    attrs[ATTR_TYPE.CHAR_ABNORMAL_MAX6]
  }
  for index, abnormal_obj in ipairs(self.v_abnormal_list) do
    local abnormal_cur_value = math.floor(abnormal_bp_list[index])
    local abnormal_max_vlaue = math.floor(abnormal_max_list[index])
    if abnormal_max_vlaue ~= abnormal_cur_value and 0 ~= abnormal_cur_value then
      self:update_ui_visible(abnormal_obj, true)
      self.v_abnormal_image_list[index].fillAmount = (abnormal_max_vlaue - abnormal_cur_value) / abnormal_max_vlaue
    else
      self:update_ui_visible(abnormal_obj, false)
    end
  end
end

function ui:check_show_targetd_hp(target)
  local hp_bar_type = target:get_hp_bar_type()
  local _, _, show_big_bar = Util.check_show_hp_bar_type(hp_bar_type)
  return show_big_bar
end

function ui:on_update_part()
  self:update_part_bar()
end

function ui:update_part_bar(part_obj)
  self:update_enemy_blood(part_obj)
  self:update_enemy_abnormal(part_obj)
end

function ui:disable_enemy_bar()
  self:update_ui_visible(self.v_uiobjects.Display, false)
  self.v_last_frame_hp = nil
end

function ui:set_effect_bar_show(is_show)
  self.v_uiobjects.Blood_Hp_Effect:SetActive(is_show)
end

function ui:set_effect_bar_length(percent)
  local _, scaley, scalez = self.v_uicompents.EffectBar_rect
  local scalex = percent * EB_SCALE_X
  self.v_uicompents.EffectBar_rect:SetLocalScaleA(scalex, scaley, scalez)
  self.v_uicompents.EffectLine1_rect:SetPositionA(self.v_uicompents.EffectLineNode_rect:GetPositionA())
end

return ui
