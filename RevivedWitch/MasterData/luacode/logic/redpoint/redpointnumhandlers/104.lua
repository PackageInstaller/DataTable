-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/redpointnumhandlers/104.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SetUnChecked = function(checked, redPointKey)
  -- function num : 0_0 , upvalues : _ENV
  if checked then
    ((NekoData.BehaviorManager).BM_RedPoint):SetUnCheckedByRedPointKey(redPointKey)
  end
end

local func = function(params, childRedPointId, selfRedPointId)
  -- function num : 0_1 , upvalues : _ENV, SetUnChecked
  local redPointKey = selfRedPointId
  if params then
    for _,v in ipairs(params) do
      redPointKey = redPointKey .. "_" .. tostring(v)
    end
  end
  do
    local checked = ((NekoData.BehaviorManager).BM_RedPoint):IsCheckedByRedPointKey(redPointKey)
    local roleId = params[1]
    local nodeId = params[2]
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
    if not role then
      SetUnChecked(checked, redPointKey)
      return 0
    end
    local enableUnlock = role:IsShowSkillRedDotById(nodeId)
    if enableUnlock then
      if not checked then
        return 1
      else
        return 0
      end
    else
      SetUnChecked(checked, redPointKey)
      return 0
    end
  end
end

return func

