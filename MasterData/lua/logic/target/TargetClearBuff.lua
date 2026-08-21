local function getCloneTarget(list)
  local new_target = {}
  
  new_target.kind = list[3]
  
  function new_target.Update(statisticSelf, statisticEnemy)
    local buffList = statisticSelf.buffKindList
    if new_target.kind == 2 then
      buffList = statisticEnemy.buffKindList
    end
    local val = 0
    for i = 1, #buffList do
      if buffList[i] ~= 0 then
        val = val + 1
      end
    end
    return val
  end
  
  return new_target
end

return getCloneTarget
