local FightDefine = require("cs_share.fight_define")
local CHAR_ATTR_TYPE = FightDefine.ATTR_TYPE
local TRIGGER_DAMAGE_CFG_INDEX = 1
local DURATION_DAMAGE_CFG_INDEX = 2
local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  self.v_need_deduct_tough = false
  Base._init(self, owner, magic_info)
  self.element_id = self.cfg[1]
  local attacker = self.magic_info.attacker
  local lv = attacker:get_level()
  local break_lv = attacker:get_break_level()
  self.level_param = ShareRes.get_abnormal_level_param(break_lv, lv)
  self.v_abnor_pure_essen = attacker:get_attr_value(CHAR_ATTR_TYPE.ABNORMAL_PURE_ESSENCE)
end

local ELEMENT_ABNORMAL_FUNC = {
  [FightDefine.ELEMENT_TYPE.WATER] = function(self, on_remove)
    if not on_remove and self.owner.element_abnormal_mgr then
      local duration = -self.owner.element_abnormal_mgr:cal_abnormal_damage(self.element_id, self.magic_info.attacker, 1, 1, 2, false, false)
      self.owner.element_abnormal_mgr:add_time_scale(duration)
    end
  end,
  [FightDefine.ELEMENT_TYPE.FIRE] = function(self, on_remove)
    if not on_remove then
      self.owner.element_abnormal_mgr:add_duration_damage(self.magic_id, self.rtid, self.element_id, self.magic_info.attacker)
    end
  end,
  [FightDefine.ELEMENT_TYPE.THUNDER] = function(self, on_remove)
    if not on_remove then
      self.owner.element_abnormal_mgr:add_additional_damage(self.magic_id, self.element_id, self.magic_info.attacker, self.rtid)
    end
  end,
  [FightDefine.ELEMENT_TYPE.LIGHT] = function(self, on_remove)
    if on_remove then
      self:trigger_damage(self.element_id, self.magic_info.attacker, self.level_param, DURATION_DAMAGE_CFG_INDEX, true)
      self:play_effect(false)
    end
  end,
  [FightDefine.ELEMENT_TYPE.DARK] = function(self, on_remove)
    if not on_remove then
      self.owner.element_abnormal_mgr:record_first_trigger_dark_magic_rtid(self.rtid)
      self.owner:set_record_hurt_flag_state(true)
    else
      local total_hurt = self.owner:get_dark_abnormal_total_hurt()
      local record_rtid = self.owner.element_abnormal_mgr:get_first_trigger_dark_magic_rtid()
      if record_rtid == self.rtid then
        self:trigger_dark_remove_damage(-total_hurt)
        self:play_effect(false)
        self.owner:set_record_hurt_flag_state(false)
      end
    end
    self.owner:reset_dark_abnormal_total_hurt()
  end
}

function M:on_effect()
  self.owner.element_abnormal_mgr:add_abnormal_attr_uuid(FightDefine.ELEMENT_TO_AB_ATTR[self.element_id], self.magic_info.attacker)
  local f = ELEMENT_ABNORMAL_FUNC[self.element_id]
  if not Util.is_destroy(self.owner) and not self.owner:is_die() and f then
    f(self, false)
  end
  self:play_effect(nil, nil, true)
end

function M:on_effect_after(magic_list)
  if self.v_need_deduct_tough then
    self:deduct_tough()
    self.v_need_deduct_tough = false
  end
end

function M:on_remove()
  local f = ELEMENT_ABNORMAL_FUNC[self.element_id]
  if not Util.is_destroy(self.owner) and not self.owner:is_die() and f then
    f(self, true)
  end
end

function M:trigger_damage(element_id, attacker, level_param, cfg_index, is_sustain)
  self.owner.element_abnormal_mgr:trigger_damage(element_id, attacker, level_param, self, cfg_index, is_sustain)
  if cfg_index == TRIGGER_DAMAGE_CFG_INDEX then
    self.v_need_deduct_tough = true
  end
end

function M:trigger_dark_remove_damage(total_hurt)
  self.owner.element_abnormal_mgr:trigger_dark_remove_damage(self.magic_info.attacker, self.element_id, self.level_param, total_hurt, self)
end

function M:deduct_tough()
  if self.owner:is_npc() then
    self.owner:change_tough_value(Config.ABNORMAL_DAMAGE_DEDUCT_TOUGH[self.element_id])
  end
end

function M:play_effect(is_trigger, len, play_delay)
  self.owner.element_abnormal_mgr:play_effect(self.element_id, is_trigger, len, play_delay)
end

return M
