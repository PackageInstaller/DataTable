local CRedPointLinkConfig = BeanManager.GetTableByName("role.credpointlinkconfig")
local RedPoint = class("RedPoint")

function RedPoint:Ctor(id, params)
  self._id = id
  self._params = params
  self._redPointRecord = CRedPointLinkConfig:GetRecorder(self._id)
  self._num = 0
  self._calculating = false
end

function RedPoint:UpdateRedPointNum(func)
  self._calculating = true
  self._func = func
  local lastNum = self._num
  self._num = 0
  if 0 < #self._redPointRecord.childs then
    for i, v in ipairs(self._redPointRecord.childs) do
      self._num = self._num + func(v)
      if self._redPointRecord.calculateDetailNum == 0 and self._num > 0 then
        break
      end
    end
  else
    self._num = self._num + func()
  end
  if lastNum ~= self._num then
    LuaNotificationCenter.PostNotification(Common.n_RedPointNumChanged, self, {
      redPointID = self._id,
      redPointParams = clone(self._params),
      deltaNum = self._num - lastNum,
      curNum = self._num,
      lastNum = lastNum
    })
  end
  self._calculating = false
end

function RedPoint:ChangeRedPointNum(deltaNum)
  if self._calculating then
    return
  end
  local lastNum = self._num
  self._num = self._num + deltaNum
  if deltaNum ~= 0 then
    LuaNotificationCenter.PostNotification(Common.n_RedPointNumChanged, self, {
      redPointID = self._id,
      redPointParams = clone(self._params),
      deltaNum = deltaNum,
      curNum = self._num,
      lastNum = lastNum
    })
  end
end

function RedPoint:GetRedPointNum()
  return self._num
end

function RedPoint:IsCalculating()
  return self._calculating
end

return RedPoint
