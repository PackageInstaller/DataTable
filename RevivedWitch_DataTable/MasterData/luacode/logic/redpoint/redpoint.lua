-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/redpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRedPointLinkConfig = (BeanManager.GetTableByName)("role.credpointlinkconfig")
local RedPoint = class("RedPoint")
RedPoint.Ctor = function(self, id, params)
  -- function num : 0_0 , upvalues : CRedPointLinkConfig
  self._id = id
  self._params = params
  self._redPointRecord = CRedPointLinkConfig:GetRecorder(self._id)
  self._num = 0
  self._calculating = false
end

RedPoint.UpdateRedPointNum = function(self, func)
  -- function num : 0_1 , upvalues : _ENV
  self._calculating = true
  self._func = func
  local lastNum = self._num
  self._num = 0
  if #(self._redPointRecord).childs > 0 then
    for i,v in ipairs((self._redPointRecord).childs) do
      self._num = self._num + func(v)
    end
  else
    do
      if (self._redPointRecord).calculateDetailNum ~= 0 or self._num <= 0 then
        self._num = self._num + func()
      end
      if lastNum ~= self._num then
        (LuaNotificationCenter.PostNotification)(Common.n_RedPointNumChanged, self, {redPointID = self._id, redPointParams = clone(self._params), deltaNum = self._num - lastNum, curNum = self._num, lastNum = lastNum})
      end
      self._calculating = false
    end
  end
end

RedPoint.ChangeRedPointNum = function(self, deltaNum)
  -- function num : 0_2 , upvalues : _ENV
  if self._calculating then
    return 
  end
  local lastNum = self._num
  self._num = self._num + deltaNum
  if deltaNum ~= 0 then
    (LuaNotificationCenter.PostNotification)(Common.n_RedPointNumChanged, self, {redPointID = self._id, redPointParams = clone(self._params), deltaNum = deltaNum, curNum = self._num, lastNum = lastNum})
  end
end

RedPoint.GetRedPointNum = function(self)
  -- function num : 0_3
  return self._num
end

RedPoint.IsCalculating = function(self)
  -- function num : 0_4
  return self._calculating
end

return RedPoint

