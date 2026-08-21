local toolBase = import("common.tool")
local monsterTool = Util.create_child_mt(toolBase)
local skillBase = import("character.base.base_monster_skill")
local nodeBase = import("character.base.base_monster_stateTreeNode")
local actMoveBase = import("character.base.base_monster_actionMove")
local actSkillBase = import("character.base.base_monster_actionSkill")
local groupBase = import("character.base.base_monster_group")
local magicBase = import("character.base.base_magic").monster
local statesMT = {
  __index = function(tbl, key)
    return Log.Error("节点列表中不存在名为" .. tostring(key) .. "的节点，请检查节点名拼写(尤其是大小写)", debug.traceback())
  end
}

function monsterTool.genStates(monster, _nodes, _actMoves, _actSkills)
  local states = monster.states or setmetatable({}, GAME_DEBUG and statesMT or nil)
  if _nodes then
    for _, nodeName in ipairs(_nodes) do
      states[nodeName] = nodeBase:new(nodeName, monster)
    end
  end
  if _actMoves then
    for _, moveName in ipairs(_actMoves) do
      states[moveName] = actMoveBase:new(moveName, monster)
    end
  end
  if _actSkills then
    local skills = monster.skills
    for actName, cfg in pairs(_actSkills) do
      local skillKey = cfg[1] or actName
      local skill = skills[skillKey]
      if cfg[1] and not skill then
        Log.Error("monster skill " .. tostring(cfg[1]) .. " not found, ", debug.traceback())
      end
      cfg[1] = skill
      local actSkill = actSkillBase:new(actName, monster, table.unpack(cfg))
      states[actName] = actSkill
      actSkill.attack = states.attack
    end
  end
  monster.states = states
  monster.tree.root = monster.states.root
end

function monsterTool.genSkills(monster)
  local skills = {}
  local npc_id = monster.npc.id
  local skillIdList = ShareRes.get_skill_list(npc_id)
  if not skillIdList then
    local character_mgr_cfg = ShareRes.create("character.character_mgr", npc_id)
    local org_npc_id = character_mgr_cfg and character_mgr_cfg.OriginalNpcId
    if org_npc_id then
      skillIdList = ShareRes.get_skill_list(org_npc_id)
      if not skillIdList then
        Log.Error("技能列表找不到单位id为", org_npc_id, "的配置！怪物初始化失败")
        return
      end
    else
      Log.Error("技能列表找不到单位id为", npc_id, "的配置！怪物初始化失败")
      return
    end
  end
  for _, skId in ipairs(skillIdList) do
    local cfg = ShareRes.create("skill.skill", skId)
    if not cfg then
    else
      local skill = skillBase:new(monster, cfg)
      skills[cfg.Name] = skill
      skills[cfg.Id] = skill
    end
  end
  for _, skill in pairs(skills) do
    local cfg = skill.cfg
    if cfg.AutoDeriveSkills then
      for i, deriveName in ipairs(cfg.AutoDeriveSkills) do
        skill.derives.auto[i] = skills[deriveName]
      end
    end
    if cfg.ManualDeriveSkills then
      for i, deriveName in ipairs(cfg.ManualDeriveSkills) do
        skill.derives.manual[i] = skills[deriveName]
      end
    end
  end
  monster.skills = skills
end

function monsterTool.genMagics(tool, monster, magicIds)
  local monster = monster
  monster.magics = tool.base.genMagics(monster, magicIds, magicBase)
end

function monsterTool.updateSkillCd(skill, offset)
  if offset then
    skill.timer = skill.timer + offset
  else
    skill.timer = get_npc_time(skill.monster.npc) + skill.cd
  end
end

function monsterTool.randByTime(monster, possibility, period)
  period = period or 1
  math.randomseed(math.ceil(get_npc_time(monster.npc) / period + monster.npc.uuid))
  return possibility > math.random()
end

function monsterTool.roleFaint(npc, faintTime, maskTime)
  local role = npc:get_behavior()
  if not role or not role.faint then
    return
  end
  role:faint(faintTime, maskTime)
end

function monsterTool.roleFaintFinish(npc)
  local role = npc:get_behavior()
  if not role or not role.faintFinish then
    return
  end
  role:faintFinish()
end

function monsterTool.table2Str(t)
  local str = tostring(t) .. ", meta is " .. tostring(getmetatable(t)) .. "\n"
  if t then
    for key, value in pairs(t) do
      str = str .. tostring(key) .. " = " .. tostring(value) .. "\n"
    end
  end
  return str
end

monsterTool.searchQueueId = 0

function monsterTool.getSearchStartFrame(tool)
  local id = tool.searchQueueId
  tool.searchQueueId = tool.searchQueueId + 1
  return id
end

monsterTool.groups = {}
if Util.is_client_only() then
  function monsterTool.getGroup(tool, monster)
    local aiId, groupId = get_npc_group_ai(monster.npc)
    
    aiId = aiId or get_common_value("BaheviorAiId")
    groupId = groupId or -1
    local campId = monster.npc:get_camp()
    local groups = tool.groups
    if not groups[campId] then
      groups[campId] = {}
    end
    if not groups[campId][aiId] then
      groups[campId][aiId] = {}
    end
    local group = groups[campId][aiId][groupId]
    if not group then
      group = groupBase:new(aiId)
      groups[campId][aiId][groupId] = group
      group.groupId = groupId
    end
    return group
  end
else
  function monsterTool.getGroup(tool, monster)
    local aiId, groupId = get_npc_group_ai(monster.npc)
    
    if not aiId then
      return
    end
    groupId = groupId or -1
    local campId = monster.npc:get_camp()
    local groups = tool.groups
    if not groups[campId] then
      groups[campId] = {}
    end
    if not groups[campId][aiId] then
      groups[campId][aiId] = {}
    end
    local group = groups[campId][aiId][groupId]
    if not group then
      group = groupBase:new(aiId)
      groups[campId][aiId][groupId] = group
      group.groupId = groupId
    end
    return group
  end
end
monsterTool.elementAbornCamPullTimer = 0
monsterTool.elementAbornCamPullInterval = 2
return monsterTool
