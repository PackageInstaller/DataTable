local Base = require("gamelogic.base_system")
local FightDefine = require("cs_share.fight_define")
local MagicDef = require("cs_share.magic_def")
local PathDefine = require("utils.path_define")
local time_temp = "%02d:%02d"
local time_temp2 = "%.4f"
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local ATTR_TYPE = FightDefine.ATTR_TYPE
local ATK2DEF_TYPES = FightDefine.ATK2DEF_TYPES
local SKILLTYPE2TYPES = FightDefine.SKILLTYPE2TYPES
local INFO_TYPE = {
  SKILL = 1,
  HURT = 2,
  ABNORMAL = 3
}
local TYPE_STR = {
  [INFO_TYPE.SKILL] = "技能",
  [INFO_TYPE.HURT] = "伤害",
  [INFO_TYPE.ABNORMAL] = "异常值"
}
local EFFECT_TYPE_STR = {
  [Config.DAMAGE_EFFECT_TYPE.NORMAL] = "普通伤害",
  [Config.DAMAGE_EFFECT_TYPE.SPECIAL] = "特殊伤害",
  [Config.DAMAGE_EFFECT_TYPE.ABNORMAL] = "异常伤害"
}
local LIST_MAX_NUM = 50

function M:init_sys()
  Base.init_sys(self)
  if not UNITY_EDITOR or not GAME_DEBUG then
    return
  end
  self.v_damage_info_list = {}
  self.v_damage_log_temp = {}
  self.v_skill_journal_list = {}
  self.v_hurt_journal_list = {}
  self.v_abnormal_journal_list = {}
  self.v_skill_journal_filted_results = {}
  self.v_hurt_journal_filted_results = {}
  self.v_abnormal_journal_filted_results = {}
  self.v_skill_journal_filter_uuid = nil
  self.v_hurt_journal_filter_uuid = nil
  self.v_abnormal_journal_filter_uuid = nil
  self.v_temp_log = {}
  self.v_info_list_max_num = 10
  self.v_oepn_record_jiournal_info = false
end

function M:insert_skill_journal(char, skill_id, skill_type, target)
  if not UNITY_EDITOR then
    return
  end
  if #self.v_skill_journal_list == LIST_MAX_NUM then
    table.remove(self.v_skill_journal_list, 50)
  end
  if #self.v_skill_journal_filted_results == LIST_MAX_NUM then
    table.remove(self.v_skill_journal_filted_results, 50)
  end
  local skill_cfg = ShareRes.create("skill.skill", skill_id)
  local animation = skill_cfg and skill_cfg.Animation or ""
  local params = {
    npc_uuid = char.uuid,
    npc_id = char.character_cfg.NpcId,
    skill_id = skill_id,
    skill_type = skill_type,
    animation = animation,
    super_attack = char.skill_mgr:get_armor_atk_lv(skill_id),
    super_take_beat = not (not target or target:is_destroy()) and target.skill_mgr:get_armor_def_lv() or "",
    type = INFO_TYPE.SKILL
  }
  _tinsert(self.v_skill_journal_list, 1, params)
  if self.v_oepn_record_jiournal_info then
    self:set_time_srt(params)
    self:insert_damage_skill_info(params)
  end
  if self.v_skill_journal_filter_uuid == char.uuid then
    _tinsert(self.v_skill_journal_filted_results, 1, params)
  end
  MsgGame:mq_publish2(Const.MSG_SKILL_JOURNAL_REFRESH)
end

function M:filter_skill(npc)
  if not npc then
    self.v_skill_journal_filter_uuid = nil
    self.v_skill_journal_filted_results = {}
    return
  end
  local uuid = npc.uuid
  if self.v_skill_journal_filter_uuid == uuid then
    return
  end
  self.v_skill_journal_filter_uuid = uuid
  self.v_skill_journal_filted_results = {}
  for _, data in ipairs(self.v_skill_journal_list) do
    if data.npc_uuid == uuid then
      table.insert(self.v_skill_journal_filted_results, data)
    end
  end
end

function M:get_skill_journal()
  return self.v_skill_journal_list
end

function M:get_filted_skill_journal()
  if self.v_skill_journal_filter_uuid then
    return self.v_skill_journal_filted_results
  else
    return self.v_skill_journal_list
  end
end

function M:clear_skill_journal()
  self.v_skill_journal_list = {}
  self.v_skill_journal_filted_results = {}
end

function M:insert_hurt_journal(atk_attr_mgr, atk_attrs, def_attr_mgr, def_attrs, pre_caculate_data, hurts, crit_info, magic_info)
  if not UNITY_EDITOR then
    return
  end
  if not atk_attrs then
    Log.Error("获取攻击者属性失败", magic_info.magic_id, debug.traceback())
    return
  end
  if #self.v_hurt_journal_list == LIST_MAX_NUM then
    table.remove(self.v_hurt_journal_list, 50)
  end
  if #self.v_hurt_journal_filted_results == LIST_MAX_NUM then
    table.remove(self.v_hurt_journal_filted_results, 50)
  end
  local attacker_uuid = atk_attr_mgr:get_char().uuid
  local target_uuid = def_attr_mgr:get_char().uuid
  local base_cal_types = ATK2DEF_TYPES[1]
  local element_cal_types = ATK2DEF_TYPES[pre_caculate_data.element_type]
  local base_hurt_src = pre_caculate_data.base_hurt_src
  local element_hurt_src = pre_caculate_data.element_hurt_src
  
  local function get_info(src, cal_types)
    return cal_types and src and 0 ~= src and "攻击属性" .. src .. " 值" .. atk_attrs[src]
  end
  
  local atk_dmg_increase, def_dmg_resi
  local skilltypes = SKILLTYPE2TYPES[pre_caculate_data.skill_type]
  if not skilltypes then
    atk_dmg_increase = 0
    def_dmg_resi = 0
  else
    atk_dmg_increase = skilltypes and atk_attrs[skilltypes.DMG_INCREASE] or "暂无信息"
    def_dmg_resi = skilltypes and def_attrs[skilltypes.DMG_RESI] or "暂无信息"
  end
  local base_hurt_info = get_info(base_hurt_src, base_cal_types)
  local element_hurt_src_info = get_info(element_hurt_src, element_cal_types)
  local types = ATK2DEF_TYPES[pre_caculate_data.element_type]
  local params = {
    attacker_uuid = attacker_uuid,
    target_uuid = target_uuid,
    attack_id = atk_attr_mgr:get_char().character_cfg.NpcId,
    target_id = def_attr_mgr:get_char().character_cfg.NpcId,
    hurt_Id = magic_info.magic_id,
    hurt_level = magic_info.magic_level,
    base_hurt = hurts.base_hurt,
    skill_type = pre_caculate_data.skill_type,
    element_type = pre_caculate_data.element_type,
    hurt_value = string.format("%.4f", -(hurts.base_hurt + hurts.element_hurt)),
    fix_value = string.format("%.4f", pre_caculate_data.damage_fix_value or 0),
    cirt_info = crit_info and tostring(crit_info.is_crit) .. "暴击修正：" .. crit_info.crit_fix_value,
    hurt_increase = atk_attrs[ATTR_TYPE.EX_HURT_ADD],
    hurt_decrease = def_attrs[ATTR_TYPE.EX_HURT_DERATE],
    kill_level_fix = pre_caculate_data.kill_level_fix,
    base_hurt_src_info = pre_caculate_data.base_hurt_src_info or magic_info.logic_cfg[4],
    base_hurt_src_factor = base_hurt_info and pre_caculate_data.base_hurt_factor,
    base_hurt_def_info = base_hurt_info and "防御值" .. def_attrs[ATTR_TYPE.CHAR_DEFENSE],
    base_hurt_increase = base_hurt_info and "物理增伤" .. atk_attrs[base_cal_types.EFFECT_ADD],
    base_hurt_decrease = base_hurt_info and "物理减伤" .. def_attrs[base_cal_types.EFFECT_OPPOSE],
    base_hurt_add = "暂未实装",
    base_hurt_block = "暂未实装",
    element_hurt_src_info = element_hurt_src_info,
    element_hurt_src_factor = element_hurt_src_info and pre_caculate_data.element_hurt_factor,
    element_hurt_def_info = element_hurt_src_info and "防御属性类型" .. ATTR_TYPE.CHAR_DEFENSE .. " 值" .. def_attrs[ATTR_TYPE.CHAR_DEFENSE],
    element_hurt_increase = element_hurt_src_info and "元素增伤类型" .. element_cal_types.EFFECT_ADD .. " 值" .. atk_attrs[element_cal_types.EFFECT_ADD],
    element_hurt_decrease = element_hurt_src_info and "元素减伤类型" .. element_cal_types.EFFECT_OPPOSE .. " 值" .. def_attrs[element_cal_types.EFFECT_OPPOSE],
    element_hurt_add = "暂未实装",
    element_hurt_block = "暂未实装",
    attack_atk = atk_attr_mgr:get_attr(ATTR_TYPE.CHAR_ATTACK),
    penetrate = atk_attr_mgr:get_attr(ATTR_TYPE.CHAR_PENETRATE),
    effect_type = EFFECT_TYPE_STR[pre_caculate_data.effect_type],
    atk_increase = types and atk_attrs[types.EFFECT_ADD] or "暂无信息",
    atk_dmg_increase = atk_dmg_increase,
    special_dmg_from = pre_caculate_data.special_dmg_from or magic_info.logic_cfg[8],
    damage_block = types and def_attrs[types.DEF_DMG] or "暂无信息",
    atk_attach_dmg = types and atk_attrs[types.ATTACH_DMG] or "暂无信息",
    def_decrease = types and def_attrs[types.EFFECT_OPPOSE] or "暂无信息",
    def_dmg_resi = def_dmg_resi,
    def_decrease2 = def_attrs[ATTR_TYPE.EX_HURT_DERATE],
    atk_increase2 = atk_attrs[ATTR_TYPE.EX_HURT_ADD],
    def = def_attrs[ATTR_TYPE.CHAR_DEFENSE],
    type = INFO_TYPE.HURT
  }
  if magic_info.logic_cfg.type == MagicDef.MAGIC_TYPE.HurtDamage then
    local list = magic_info.logic_cfg[3]
    params.dmg_crit = pre_caculate_data.dmg_crit or list[magic_info.magic_level] or list[#list]
  elseif magic_info.logic_cfg.type == MagicDef.MAGIC_TYPE.SPECAIL_DMG then
    params.dmg_crit = 0
  end
  _tinsert(self.v_hurt_journal_list, 1, params)
  if self.v_oepn_record_jiournal_info then
    self:set_time_srt(params)
    self:insert_damage_skill_info(params)
  end
  if self.v_hurt_journal_filter_uuid == attacker_uuid then
    _tinsert(self.v_hurt_journal_filted_results, 1, params)
  end
  MsgGame:mq_publish2(Const.MSG_HURT_JOURNA_REFRESH)
end

function M:get_hurt_journal()
  return self.v_hurt_journal_list
end

function M:get_filted_hurt_journal()
  if self.v_hurt_journal_filter_uuid then
    return self.v_hurt_journal_filted_results
  else
    return self.v_hurt_journal_list
  end
end

function M:clear_hurt_journal()
  self.v_hurt_journal_list = {}
  self.v_hurt_journal_filted_results = {}
end

function M:filter_hurt(npc)
  if not npc then
    self.v_hurt_journal_filter_uuid = nil
    self.v_hurt_journal_filted_results = {}
    return
  end
  local uuid = npc.uuid
  if self.v_hurt_journal_filter_uuid == uuid then
    return
  end
  self.v_hurt_journal_filter_uuid = uuid
  self.v_hurt_journal_filted_results = {}
  for _, data in ipairs(self.v_hurt_journal_list) do
    if data.attacker_uuid == uuid then
      table.insert(self.v_hurt_journal_filted_results, data)
    end
  end
end

function M:insert_abnormal_journal(atk_attr_mgr, def_attr_mgr, skill_mult, magic_info, exharsign, exhartype, hurt_value)
  if not UNITY_EDITOR then
    return
  end
  if #self.v_abnormal_journal_list == LIST_MAX_NUM then
    table.remove(self.v_abnormal_journal_list, 50)
  end
  if #self.v_abnormal_journal_filted_results == LIST_MAX_NUM then
    table.remove(self.v_abnormal_journal_filted_results, 50)
  end
  local attack = atk_attr_mgr.attrs[ATTR_TYPE.CHAR_ATTACK]
  local exharmadd = atk_attr_mgr.attrs[ATTR_TYPE.EX_HURT_ADD]
  local defense = def_attr_mgr.attrs[ATTR_TYPE.CHAR_DEFENSE]
  local types = FightDefine.ATK2DEF_TYPES2[exhartype]
  local element_add = atk_attr_mgr.attrs[types.EFFECT_ADD]
  local element_oppose = atk_attr_mgr.attrs[types.EFFECT_OPPOSE]
  local exharmredu = def_attr_mgr.attrs[ATTR_TYPE.EX_HURT_DERATE]
  local cd_attr_id = FightDefine.AB_ATTR_TO_TIME[exhartype]
  local cd = def_attr_mgr.attrs[cd_attr_id]
  local cur_value_attr_id = FightDefine.ELEMENT_TO_AB_ATTR[exhartype]
  local cur_value = def_attr_mgr.attrs[cur_value_attr_id]
  local max_value_attr_id = FightDefine.MONSTER_RES2MAX[cur_value_attr_id]
  local max_value = def_attr_mgr.attrs[max_value_attr_id]
  local attacker_uuid = def_attr_mgr:get_char().uuid
  local params = {
    attacker_uuid = attacker_uuid,
    attack_id = atk_attr_mgr:get_char().character_cfg.NpcId,
    target_id = def_attr_mgr:get_char().character_cfg.NpcId,
    hurt_Id = magic_info.magic_id,
    hurt_level = magic_info.magic_level,
    hurt_sign = exharsign,
    hurt_element_type = exhartype,
    hurt_value = -hurt_value,
    atk = attack,
    element_increase = element_add,
    extra_damage = exharmadd,
    damage_mul = skill_mult,
    def = defense,
    element_resistance = element_oppose,
    extra_reduction = exharmredu,
    cd = cd,
    cur_value = cur_value,
    max_value = max_value,
    type = INFO_TYPE.ABNORMAL
  }
  _tinsert(self.v_abnormal_journal_list, 1, params)
  if self.v_oepn_record_jiournal_info then
    self:set_time_srt(params)
    self:insert_damage_skill_info(params)
  end
  if self.v_abnormal_journal_filter_uuid == attacker_uuid then
    _tinsert(self.v_abnormal_journal_filted_results, 1, params)
  end
  MsgGame:mq_publish2(Const.MSG_ABNORMAL_JOURNA_REFRESH)
end

function M:get_abnormal_journal()
  return self.v_abnormal_journal_list
end

function M:get_filted_abnormal_journal()
  if self.v_abnormal_journal_filter_uuid then
    return self.v_abnormal_journal_filted_results
  else
    return self.v_abnormal_journal_list
  end
end

function M:clear_abnormal_journal()
  self.v_abnormal_journal_list = {}
  self.v_abnormal_journal_filted_results = {}
end

function M:filter_abnormal(npc)
  if not npc then
    self.v_abnormal_journal_filter_uuid = nil
    self.v_abnormal_journal_filted_results = {}
    return
  end
  local uuid = npc.uuid
  if self.v_abnormal_journal_filter_uuid == uuid then
    return
  end
  self.v_abnormal_journal_filter_uuid = uuid
  self.v_abnormal_journal_filted_results = {}
  for _, data in ipairs(self.v_abnormal_journal_list) do
    if data.attacker_uuid == uuid then
      table.insert(self.v_hurt_journal_filted_results, data)
    end
  end
end

local player_info_temp = "\n账号:{1}\n关卡ID:{2}\n战斗日志 %s/%s/%s %02d:%02d:%02d\n——————————————————START————————————————\n角色id,角色名,角色突破,角色等级,升阶等级,系统技能等级,技能等级,武器id,武器名,武器突破,武器等级,武器同调,战力\n"
local role_info_temp = "{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13}\n"
local journal_info_title = "———————————————————————————————————————\n时间,记录类型,释放者uuid,释放者,技能ID,技能类型,动作名,霸体攻击等级,霸体防御等级\n时间,记录类型,攻击者uuid,攻击者,受击者uuid,受击者,伤害id,伤害值,效果类型,伤害等级,伤害技能类型,伤害元素类型,伤害倍率,伤害来源,暴击,穿防,元素加深,攻击类型加深,附加伤害,全伤加深,特殊伤害取值,伤害格挡,元素抗性,攻击类型抗性,全伤抗性,防御\n来源,目标,异常Id,伤害等级,伤害标记,伤害元素类型,伤害值,攻击者异常增幅,受击者异常抗性,受击者异常CD,受击者储蓄值上限,受击者当前异常值\n"
local skill_journal_info_temp = "{1},{2},{3},{4},{5},{6}\n"
local hurt_journal_info_temp = "{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},{22},{23},{24},{25}\n"
local abnormal_journal_info_temp = "{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13}\n"
local end_title = "——————————————————END————————————————\n"

function M:record_cur_time(time)
  self.v_time = time
end

function M:insert_damage_skill_info(params)
  local length = #self.v_damage_info_list
  if length >= 10 then
    self:record_skill_log()
    length = #self.v_damage_info_list
  end
  self.v_damage_info_list[length + 1] = params
end

function M:record_start_log()
  local uuid = PlayerMgr and PlayerMgr:get_player_uid() or 0
  local point = "单机模式"
  if TowerMgr then
    local fight_info = TowerMgr:get_fight_info()
    if fight_info and fight_info.point_id then
      point = fight_info.point_id
    else
      point = 0
    end
  end
  local str = Util.format_str(player_info_temp, uuid, point)
  local date = Date.get_time_tbl()
  str = string.format(str, date.year, date.month, date.day, date.hour, date.min, date.sec)
  self:write_log_to_file(str)
end

function M:record_role_log()
  local hero_list = SceneMgr:get_hero_list()
  local role_id, name, break_lv, level, advance, skill_lv_list, default_skill_list, waepon_id, waepon_name, weapon_break_lv, weapon_level, weapon_advance, fight_power, buddy_data, equip_data, waepon_cfg, skill_id_list, temp_log, temp_default_skill_str
  skill_lv_list = {}
  UtilTable.clear_map(self.v_temp_log)
  for uuid, hero in pairs(hero_list) do
    buddy_data = hero:get_buddy_data()
    equip_data = buddy_data.equip_data
    role_id = hero:get_npc_id()
    name = hero:get_name()
    break_lv = buddy_data.break_lv
    level = buddy_data.lv
    advance = buddy_data.advance
    if equip_data then
      waepon_id = equip_data.id
      weapon_break_lv = equip_data.break_lv
      weapon_level = equip_data.lv
      weapon_advance = equip_data.advance_lv
      waepon_cfg = ShareRes.get_equip_cfg(waepon_id)
      waepon_name = waepon_cfg.Name
    else
      waepon_id = 0
      weapon_break_lv = 0
      weapon_level = 0
      weapon_advance = 0
      waepon_name = "未装备武器"
    end
    fight_power = CharacterMgr and CharacterMgr:journal_get_force_value(role_id, hero:get_team_pos()) or 0
    skill_id_list = ShareRes.get_skill_list(role_id)
    UtilTable.clear_map(skill_lv_list)
    for index, skill_id in ipairs(skill_id_list) do
      skill_lv_list[index] = hero.skill_mgr:get_skill_lv(skill_id)
    end
    default_skill_list = hero.skill_mgr:get_lskill_list()
    temp_default_skill_str = default_skill_list and table.concat(default_skill_list, "|") or "暂无信息"
    temp_log = Util.format_str(role_info_temp, role_id, name, break_lv, level, advance, temp_default_skill_str, table.concat(skill_lv_list, "|"), waepon_id, waepon_name, weapon_break_lv, weapon_level, weapon_advance, fight_power)
    table.insert(self.v_temp_log, temp_log)
  end
  table.insert(self.v_temp_log, journal_info_title)
  self:write_log_to_file(table.concat(self.v_temp_log))
end

function M:record_skill_log()
  local temp = self.v_temp_log
  local info_length = #self.v_damage_info_list
  if info_length < #temp then
    for index = info_length, #temp do
      temp[index] = nil
    end
  end
  for index = info_length, 1, -1 do
    local param = self.v_damage_info_list[index]
    if param.type == INFO_TYPE.SKILL then
      temp[index] = Util.format_str(skill_journal_info_temp, param.time_str, TYPE_STR[param.type], param.npc_uuid, param.npc_id, param.skill_id, param.skill_type, param.animation, param.super_attack, param.super_take_beat)
    elseif param.type == INFO_TYPE.HURT then
      temp[index] = Util.format_str(hurt_journal_info_temp, param.time_str, TYPE_STR[param.type], param.attacker_uuid, param.attack_id, param.target_uuid, param.target_id, param.hurt_Id, param.hurt_value, param.effect_type, param.hurt_level, param.skill_type, param.element_type, param.dmg_crit, param.base_hurt_src_info, param.cirt_info, param.attack_atk, param.penetrate, param.atk_increase, param.atk_dmg_increase, param.atk_attach_dmg, param.atk_increase2, param.special_dmg_from, param.element_hurt_block, param.def_decrease, param.def_dmg_resi, param.def_decrease2, param.def)
    elseif param.type == INFO_TYPE.ABNORMAL then
      temp[index] = Util.format_str(abnormal_journal_info_temp, param.time_str, TYPE_STR[param.type], param.attack_id, param.target_id, param.hurt_Id, param.hurt_level, param.hurt_sign, param.hurt_element_type, param.hurt_value, param.element_increase, param.element_resistance, param.cd, param.cur_value, param.max_value)
    end
    self.v_damage_info_list[index] = nil
  end
  self:write_log_to_file(table.concat(temp))
end

function M:end_print_log()
  self:record_skill_log()
  self:write_log_to_file(end_title)
end

function M:write_log_to_file(str)
  local path = PathDefine.updown_fight_log_dir
  local file = io.open(path, "a")
  io.output(file)
  io.write(str)
  io.close()
end

function M:set_fight_log_write_length(max_num)
  self.v_info_list_max_num = max_num
end

function M:set_time_srt(params)
  if not self.v_time then
    return
  end
  local int, float = math.modf(self.v_time)
  local sec = int % 60
  local min = math.floor(int / 60)
  local time_str = string.format(time_temp, min, sec) .. string.sub(string.format(time_temp2, float), 2)
  params.time_str = time_str
end

function M:oepn_record_jiournal_info(is_open)
  if self.v_oepn_record_jiournal_info ~= is_open then
    if is_open then
      self:record_start_log()
      self:record_role_log()
    else
      self:end_print_log()
    end
  end
  self.v_oepn_record_jiournal_info = is_open
end

function M:get_fight_log_write_length()
  return self.v_info_list_max_num
end

function M:get_oepn_record_jiournal_info()
  return self.v_oepn_record_jiournal_info
end

local DebugToolMgr, MagicActionType
if UNITY_EDITOR_WIN then
  DebugToolMgr = CS.Game.DebugToolMgr.Instance
  MagicActionType = CS.Game.MagicActionType
end

function M:collection_magic_info(missile_id, owner_skill_id, magic_id, magic_level, duration, rtid, npc_id, uuid, action_type)
  local owner_missile_id = missile_id
  local TempMagicInfo = DebugToolMgr.TempMagicInfo
  TempMagicInfo.MagicID = magic_id
  TempMagicInfo.MagicLevel = magic_level
  TempMagicInfo.OnwerMissileID = owner_missile_id
  TempMagicInfo.OwnerSkillID = owner_skill_id or 0
  TempMagicInfo.LeftDuration = duration
  TempMagicInfo.MagicActionType = action_type
  TempMagicInfo.OwnerID = npc_id
  TempMagicInfo.FrameID = Global.frame_id
  TempMagicInfo.RTID = rtid
  TempMagicInfo.OwnerUUID = uuid
  TempMagicInfo.TraceBack = Global.CollectionMagicTraceBack and debug.traceback() or nil
  DebugToolMgr:CollectionMagicInfo()
end

return M
