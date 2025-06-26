-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_sign.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Sign = class("BM_Sign")
BM_Sign.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).sign
end

BM_Sign.GetSignActivityState = function(self)
  -- function num : 0_1
  return (self._data).signActivityState
end

BM_Sign.GetReturnActivityState = function(self)
  -- function num : 0_2
  return (self._data).returnsignActivityState
end

BM_Sign.ShowWelfareEntrance_Sign = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for _,activity in pairs((self._data).signActivity) do
    if activity.iswelfare then
      for i,award in ipairs(activity.awards) do
        if not award.receive then
          return true
        end
      end
    end
  end
end

BM_Sign.ShowReturnWelfareEntrance_Sign = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for _,activity in pairs((self._data).signActivity) do
    if not activity.iswelfare then
      for i,award in ipairs(activity.awards) do
        if not award.receive then
          return true
        end
      end
    end
  end
end

BM_Sign.GetSignActivities = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local list = {}
  for _,activity in pairs((self._data).signActivity) do
    if activity.iswelfare then
      (table.insert)(list, activity)
    end
  end
  return list
end

BM_Sign.GetReturnSignActivities = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local list = {}
  for _,activity in pairs((self._data).signActivity) do
    if not activity.iswelfare then
      (table.insert)(list, activity)
    end
  end
  return list
end

BM_Sign.GetSignActivityById = function(self, id)
  -- function num : 0_7
  return ((self._data).signActivity)[id]
end

return BM_Sign

