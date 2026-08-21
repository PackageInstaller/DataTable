local CHARACTER_CONFIG = require("uimodule.character.character_config")
local helper = {}
local WEAPON_LOCK = {NOT_LOCK = 0, LOCK = 1}
local UICharPath = "UIChar/%s"
local UIItemPath = "Item/%s"
local UICharacterPath = "UICharacter/%s"
local UIWeaponPath = "UICharacter/Char_arms/%s"
local UICommon2Path = "UICommon2/Com/%s"
local UIPlayerPath = "UIPlayer/20230724/%s"
local UIElementPath = "Icon/Element/%s"
local UIArchivePath = "UICharacter/Char_dnfm/%s"
local UISkillPath = "Skill/%s"
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local FightDefind = require("cs_share.fight_define")
local CONFIG_NAME_ATTR_ID = FightDefind.CONFIG_NAME_ATTR_ID
local _min = math.min

function helper.get_char_select_quality_icon(buddy_id)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local icon_name = ShareRes.get_buddy_qualityIcon_Small(buddy_cfg.Quality)
  local icon_path = string.format(UICharPath, icon_name)
  return icon_path
end

function helper.get_char_line_quality_icon(quality_num)
  local icon_name = CHARACTER_CONFIG.CHAR_SELECT_LINE_QUALITY[quality_num]
  local icon_path = string.format(UICharPath, icon_name)
  return icon_path
end

function helper.get_char_advance_icon(advance_lv)
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", advance_lv)
  local icon_path = advance_icon_cfg.AdvacneAfter
  return icon_path
end

function helper.get_weapon_small_icon(weapon_id)
  local weapon_cfg = ShareRes.get_equip(weapon_id)
  local icon_name = weapon_cfg.SmallIcon
  local icon_path = string.format(UIWeaponPath, icon_name)
  return icon_path
end

function helper.get_char_skill_icon(skill_id)
  local skill_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
  local icon_name = skill_cfg.Icon
  local icon_path = string.format(UISkillPath, icon_name)
  return icon_path
end

function helper.get_char_battle_skill_icon(skill_id)
  local skill_cfg = ShareRes.get_battle_skill_cfg(skill_id)
  local icon_name = skill_cfg.Icon
  local icon_path = string.format(UISkillPath, icon_name)
  return icon_path
end

function helper.get_skill_icon_by_name(skill_name)
  local icon_path = string.format(UISkillPath, skill_name)
  return icon_path
end

function helper.get_char_element_icon(buddy_id)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local element_id = buddy_cfg.Element
  local element_cfg = ShareRes.get_element_cfg(element_id)
  local icon_path = element_cfg.ElementIconPath
  return icon_path
end

function helper.get_char_job_icon(buddy_id, is_texture)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  if is_texture then
    return ShareRes.get_job_cfg(buddy_cfg.Job).TexturePath
  end
  return ShareRes.get_job_cfg(buddy_cfg.Job).IconPath
end

function helper.get_page_icon(icon_name)
  local icon_path = string.format(UICharacterPath, icon_name)
  return icon_path
end

function helper.get_char_icon_quality(buddy_id, type)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local icon_path
  if type == Config.CHAR_QUALITY_TYPE.SMALL then
    icon_path = string.format(UICharPath, ShareRes.get_buddy_qualityIcon_Small(buddy_cfg.Quality))
  elseif type == Config.CHAR_QUALITY_TYPE.BIG then
    icon_path = string.format(UICharPath, ShareRes.get_buddy_qualityIcon_Big(buddy_cfg.Quality))
  elseif type == Config.CHAR_QUALITY_TYPE.NAME then
    icon_path = string.format(UICommon2Path, ShareRes.get_buddy_qualityIcon_Name(buddy_cfg.Quality))
  elseif type == Config.CHAR_QUALITY_TYPE.LONG then
    icon_path = string.format(UIPlayerPath, ShareRes.get_buddy_qualityIcon_Long(buddy_cfg.Quality))
  elseif type == Config.CHAR_QUALITY_TYPE.SHORT then
    icon_path = string.format(UIPlayerPath, ShareRes.get_buddy_qualityIcon_Short(buddy_cfg.Quality))
  end
  return icon_path
end

function helper.get_char_quality(buddy_id, type)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  return buddy_cfg.Quality
end

function helper.get_char_potential_icon(buddy_info)
  local buddy_id = buddy_info.id
  local advance_skill_list = buddy_info.lAdvanceSkill or {}
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", buddy_id)
  local max_advance_lv = #advance_skill_cfg
  local cur_advance_lv = #advance_skill_list + 1
  local result_skill_lv = _min(max_advance_lv, cur_advance_lv)
  local skill_cfg = advance_skill_cfg[result_skill_lv]
  assert(skill_cfg, "ADVANCE LV CFG ERROR = " .. buddy_id .. "/" .. result_skill_lv)
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", result_skill_lv)
  local icon_path = string.format("Item/%s", advance_icon_cfg.AdvacneAfter)
  return icon_path
end

function helper.get_char_potential_icon_by_advance(advance)
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", advance)
  local icon_path = string.format("%s", advance_icon_cfg.AdvacneAfter)
  return icon_path
end

function helper.get_battle_char_potential_icon(hero_id)
  local list = SceneMgr:get_hero_list()
  local hero_advance_lv = 1
  for _, hero in pairs(list) do
    local BuddyId = hero.buddy_cfg.Id
    if hero_id == BuddyId then
      hero_advance_lv = hero:get_hero_advance()
      break
    end
  end
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", hero_id)
  local skill_cfg = advance_skill_cfg[hero_advance_lv]
  assert(skill_cfg, "ADVANCE LV CFG ERROR = " .. hero_id .. "/" .. hero_advance_lv)
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", hero_advance_lv)
  return advance_icon_cfg.AdvacneAfter
end

function helper.get_archive_cover_icon_path(icon_name)
  local icon_path = string.format(UIArchivePath, icon_name)
  return icon_path
end

function helper.get_equip_icon(equip_id, level)
  local equip_cfg = ShareRes.get_equip(equip_id)
  local path = UtilUI.get_weapon_tex(equip_cfg.Painting[level])
  return path
end

function helper.is_skill_task_show_red(buddy_id, idx)
  local buddy_skill_cfg = ShareRes.get_buddy_skill_list_cfg(buddy_id)
  local task_group_list = buddy_skill_cfg.TaskGroup
  local task_group_id = task_group_list[idx]
  local task_list = ShareRes.get_task_group_cfg(task_group_id)
  local is_show_red = false
  for task_id, _ in pairs(task_list) do
    local task_data = TaskMgr:get_task_by_id(task_id)
    local state = task_data.state
    if state == TASK_STATE.receive then
      is_show_red = true
      break
    end
  end
  return is_show_red
end

function helper.get_battle_skill_icon(skill_id)
  local skill_cfg = ShareRes.get_battle_skill_cfg(skill_id)
  local icon = skill_cfg.Icon
  local path = string.format(UISkillPath, icon)
  return path
end

function helper.get_equip_max_break_star_num(equip_id)
  local max_break_num = ShareRes.get_max_equip_break_lv(equip_id)
  local result = 1
  if max_break_num > 1 then
    result = max_break_num
  end
  return result
end

function helper.is_equip_reach_max_break(equip_uuid)
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  local equip_id = equip_info.id
  local max_break_num = ShareRes.get_max_equip_break_lv(equip_id)
  local now_break_num = equip_info.break_lv
  return max_break_num <= now_break_num
end

function helper.is_equip_lock(equip_uuid)
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  local lock = equip_info.lock
  if lock == WEAPON_LOCK.LOCK then
    return true
  end
  return false
end

function helper.get_rune_icon(buddy_id, rune_index)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  local icon_name = buddy_cfg.RuneIcon[rune_index]
  local icon_path = string.format(UISkillPath, icon_name)
  return icon_path
end

function helper.get_attr_info_by_name(attr_name)
  local attr_id = CONFIG_NAME_ATTR_ID[attr_name]
  if not attr_id then
    return
  end
  return ShareRes.get_buddy_attr_cfg(attr_id)
end

function helper.set_buddy_tag_txt(txt1, txt2, buddy_cfg)
  local tag_cfg = buddy_cfg.Tag
  local tag1 = tag_cfg and tag_cfg[1]
  local tag2 = tag_cfg and tag_cfg[2]
  txt1.gameObject:SetActiveEx(nil ~= tag_cfg and nil ~= tag_cfg[1])
  txt2.gameObject:SetActiveEx(nil ~= tag_cfg and nil ~= tag_cfg[2])
  txt1.text = ShareRes.get_buddy_tag_str(tag1)
  txt2.text = ShareRes.get_buddy_tag_str(tag2)
end

function helper.set_buddy_quality_star(uiobj, quality, buddy_id)
  quality = quality or ShareRes.get_buddy_cfg(buddy_id).Quality
  for index = 1, 5 do
    local star_obj = uiobj["QualityStar" .. index]
    if star_obj then
      star_obj:SetActive(index <= quality)
    end
  end
end

return helper
