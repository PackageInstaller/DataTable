local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local TagManagerComp, Super = System.NewClass("TagManagerComp", BattleComponent)

function TagManagerComp:ctor(entity, tags)
  Super.ctor(self, entity)
  self.tags = tags
  self._initTagState = false
end

function TagManagerComp:InitTagState()
  self._initTagState = true
  for tag, num in pairs(self.tags) do
    if num <= 0 then
    else
      self:AddTagStateList(tag)
    end
  end
end

function TagManagerComp:AddTag(tag, num)
  local tags = self.tags
  local oldNum = tags[tag] or 0
  tags[tag] = oldNum + (num or 1)
  if not self._initTagState then
    return
  end
  if oldNum <= 0 and tags[tag] > 0 then
    self:AddTagStateList(tag)
  end
end

function TagManagerComp:RemoveTag(tag, num)
  local tags = self.tags
  local oldNum = tags[tag] or 0
  tags[tag] = oldNum - (num or 1)
  if not self._initTagState then
    return
  end
  if oldNum > 0 and tags[tag] <= 0 then
    self:RemoveTagStateList(tag)
  end
end

function TagManagerComp:HasTag(tag)
  local tags = self.tags
  return tags[tag] and tags[tag] > 0
end

function TagManagerComp:AddTagStateList(tag)
  local DT = self.entity.battleEngine.battleDT
  local config = DT.TagConfig[tag]
  if not config or not config.StateList then
    return
  end
  local stateList = {}
  for _, stateId in ipairs(config.StateList) do
    table.insert(stateList, {
      stateId = stateId,
      castRoleUid = self.entity.uid,
      layer = 1,
      source = {
        {
          tid = tag,
          sourceType = "Tag",
          layer = 1
        }
      }
    })
  end
  if #stateList > 0 then
    local stateMgr = self.entity.battleEngine.stateMgr
    for _, state in ipairs(stateList) do
      stateMgr:CreateState(self.entity, state)
    end
  end
end

function TagManagerComp:RemoveTagStateList(tag)
  local DT = self.entity.battleEngine.battleDT
  local config = DT.TagConfig[tag]
  if not config or not config.StateList then
    return
  end
  local stateMgr = self.entity.battleEngine.stateMgr
  local stateList = stateMgr:GetStateListByOwnerUid(self.entity.uid)
  for _, state in ipairs(stateList) do
    if not state.source then
    else
      local source = state.source[1]
      if source and source.sourceType == "Tag" and source.tid == tag then
        stateMgr:RemoveState(state)
      end
    end
  end
end

return TagManagerComp
