local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local TOWER_TYPE = Config.TOWER_TYPE
local CommonDef = require("cs_share.common_define")
M.FIGHT_TYPE2TOWER = {
  [CommonDefine.CHALLENGE_TYPE.CHALLENGE_RING] = TOWER_TYPE.CHALLENGE_RING,
  [CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE] = TOWER_TYPE.CURSE_RING,
  [CommonDefine.CHALLENGE_TYPE.CUT_GRASS] = TOWER_TYPE.CUT_GRASS
}

function M:get_infinite_chapter_id(epi_id)
  local infinite_cfg_list = ShareRes.get_inf_chapter_cfg()
  for i, cfg in pairs(infinite_cfg_list) do
    if cfg.EpisodeId == epi_id then
      return cfg.Id
    end
  end
  return 0
end

function M:get_main_line_chapter_id(epi_id)
  local cfg_list = ShareRes.get_chapter_cfg()
  for i, cfg in pairs(cfg_list) do
    for _, cfg_epi_id in pairs(cfg.Point) do
      if cfg_epi_id == epi_id then
        return cfg.Id
      end
    end
  end
  return 0
end

function M:get_epi_is_open(epi_id, params2, is_show_tips)
  local epi_cfg = ShareRes.get_chapter_point_cfg(epi_id)
  if not epi_cfg then
    if is_show_tips then
      Log.Error("找不到副本id:" .. tostring(epi_id))
    end
    return false
  end
  local fight_type = epi_cfg.FightType
  if fight_type == CommonDef.CHALLENGE_TYPE.CHAPTER then
    return self:get_chapter_main_line_hard_is_can_fight(epi_id, is_show_tips)
  elseif fight_type == CommonDef.CHALLENGE_TYPE.INFINITE then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    return self:get_teach_is_can_fight(epi_id, true)
  elseif fight_type == CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    return self:get_challenge_ring_plus_is_can_fight(epi_id, is_show_tips)
  elseif fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER then
    return self:get_chapter_main_line_normal_is_can_fight(epi_id, params2, is_show_tips)
  elseif fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.NEW_MATERIAL then
    return self:get_chapter_material_is_can_fight(epi_id, is_show_tips)
  elseif fight_type == CommonDef.CHALLENGE_TYPE.LINEAR then
  end
  return true
end

function M:get_chapter_main_line_normal_is_can_fight(epi_id, node_id, is_show_tips)
  local chapter_cfg = self:get_chapter_cfg_with_epi_id(epi_id, is_show_tips)
  if not chapter_cfg then
    return false
  end
  local chapter_id = chapter_cfg.Id
  if not self:check_chapter_is_open(chapter_id, is_show_tips) then
    return false
  end
  local node_state, tips = ChapterMgr:get_chapter_point_state(chapter_id, epi_id)
  local is_lock = node_state == CommonDef.CHAPTER_NODE_STATE.LOCK
  if is_lock then
    if is_show_tips then
      Util.show_message_tip(tips)
    end
    return false
  end
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  local node_state = ChapterMgr:get_node_state(chapter_id, node_id)
  if node_state == CommonDefine.CHAPTER_NODE_STATE.LOCK then
    if is_show_tips then
      Util.show_message_tip(node_cfg.UnlockText)
    end
    return false
  elseif node_state == CommonDefine.CHAPTER_NODE_STATE.FINISHED and node_cfg.ExploreNode ~= node_id and is_show_tips then
    Util.show_message_tip(2083)
    return false
  end
  if node_cfg.NodeType == CommonDef.CHAPTER_NODE_TYPE.STORY_LINE then
    StoryMgr:on_start(node_cfg.Param)
    return false
  end
  return true
end

function M:check_chapter_is_open(chapter_id, is_show_tips)
  local chapter_cfg = ShareRes.create("chapter.chapter", chapter_id)
  local con_result_id = Condition:check_condition_list(chapter_cfg.Condition)
  if 0 ~= con_result_id then
    local con_cfg = ShareRes.create("condition.condition", con_result_id)
    if is_show_tips then
      Util.show_message_tip(con_cfg.Desc)
    end
    return false
  end
  return true
end

function M:get_chapter_cfg_with_epi_id(epi_id, is_show_tips)
  local chapter = ChapterMgr:get_chapter_by_episode(epi_id)
  if not chapter then
    if is_show_tips then
      Log.Error("未在章节表中找到关卡id：" .. tostring(epi_id))
    end
    return false
  end
  return chapter
end

function M:get_chapter_main_line_hard_is_can_fight(epi_id, is_show_tips)
  local chapter_cfg = self:get_chapter_cfg_with_epi_id(epi_id, is_show_tips)
  if not chapter_cfg then
    return false
  end
  local chapter_id = chapter_cfg.Id
  if not self:check_chapter_is_open(chapter_id, true) then
    return false
  end
  local state, tips = ChapterMgr:get_chapter_point_state(chapter_id, epi_id)
  if state == CommonDef.CHAPTER_NODE_STATE.LOCK then
    if is_show_tips then
      Util.show_message_tip(tips)
    end
    return false
  end
  return true
end

function M:get_chapter_material_is_can_fight(epi_id, is_show_tips)
  local cfg_list = ChapterMaterialMgr:get_material_epi_list()
  local mat_epi_cfg
  for i, cfg in pairs(cfg_list) do
    if cfg.EpisodeId == epi_id then
      mat_epi_cfg = cfg
      break
    end
  end
  if not mat_epi_cfg then
    if is_show_tips then
      Log.Error("材料副本中不存在关卡Id：" .. tostring(epi_id))
    end
    return false
  end
  local mat_type_cfg
  local mat_type_list = ShareRes.get_chapter_material_type_cfg()
  for i, type_cfg in pairs(mat_type_list) do
    if type_cfg.MaterialType == mat_epi_cfg.MaterialType then
      mat_type_cfg = type_cfg
      break
    end
  end
  if not mat_type_cfg then
    if is_show_tips then
      Log.Error("材料副本类型表中不存在材料副本Id：" .. tostring(mat_epi_cfg.Id))
    end
    return false
  end
  local open, material_type = ChapterMaterialMgr:check_chapter_material_type_is_open(mat_type_cfg.Id, is_show_tips)
  if not open then
    return false
  end
  local open_child = ChapterMaterialMgr:check_chapter_material_epi_is_open(mat_epi_cfg.Id, is_show_tips)
  if not open_child then
    return false
  end
  return true
end

function M:get_teach_is_can_fight(epi_id, is_show_tips)
  local cfg = ShareRes.get_buddy_teach_cfg_by_point_id(epi_id)
  local buddy_id = cfg and cfg.BuddyID
  local is_open = CharacterMgr:is_open_teaching(buddy_id)
  if not is_open and is_show_tips then
    Util.show_message_tip(2084)
  end
  return is_open
end

function M:get_challenge_ring_plus_is_can_fight(epi_id, is_show_tips)
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  local stage_cfg = ShareRes.get_chapter_point_cfg(epi_id)
  local index = 0
  for idx, episode_id in ipairs(main_cfg.EpisodeIds) do
    if epi_id == episode_id then
      index = idx
      break
    end
  end
  local lock = true
  if index <= ChallengeRingPlusMgr:get_acty_level() + 1 then
    lock = false
  end
  if lock then
    local tips = string.format("通关%s关后解锁", ShareRes.get_chapter_point_cfg(stage_cfg.FrontPointId).PointName)
    if is_show_tips then
      Util.show_message_tip(tips)
    end
    return false
  end
  return true
end

function M:get_epi_star(epi_id)
  local epi_cfg = ShareRes.get_chapter_point_cfg(epi_id)
  if not epi_cfg then
    return true
  end
  local star_count = -1
  local fight_type = epi_cfg.FightType
  if fight_type == CommonDef.CHALLENGE_TYPE.CHAPTER then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.INFINITE then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    return self:get_teach_is_can_fight(epi_id, true)
  elseif fight_type == CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI then
    local is_lock = WeeklyMgr:check_hurdle_lock(epi_id)
    if not is_lock then
      local star_map = WeeklyMgr:get_hurdle_star_map(epi_id)
      star_count = 0
      for idx = 1, 3 do
        if star_map[idx] then
          star_count = star_count + 1
        end
      end
    end
  elseif fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
  elseif fight_type == CommonDef.CHALLENGE_TYPE.NEW_MATERIAL then
    star_count = ChapterMaterialMgr:get_material_star_num_with_epi_id(epi_id)
  elseif fight_type == CommonDef.CHALLENGE_TYPE.INDEPENDENT then
  end
  return star_count
end

return M
