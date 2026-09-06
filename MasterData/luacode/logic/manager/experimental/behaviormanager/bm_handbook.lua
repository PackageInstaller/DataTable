local BM_HandBook = class("BM_HandBook")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")

function BM_HandBook:Ctor()
  self._handBookList = NekoData.Data.handBookList
  self._allUnlock = nil
end

function BM_HandBook:IsBookUnLock(bookid, booktype)
  if self._allUnlock then
    return true
  end
  if booktype == HandBookTypeEnum.EQUIP then
    for index, id in pairs(self._handBookList.equipList) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.MONSTER then
    for index, id in pairs(self._handBookList.monsterList) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.ROLE then
    if bookid == 1 then
      return true
    end
    for _, v in pairs(self._handBookList.roleList) do
      if v.id == bookid then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.NPC then
    for index, id in pairs(self._handBookList.npcList) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.WORLD then
    for index, id in pairs(self._handBookList.worldList) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.FORCE then
    for index, id in pairs(self._handBookList.forceList) do
      if bookid == id then
        return true
      end
    end
    return true
  end
  if booktype == HandBookTypeEnum.ACTIVITY then
    for index, id in pairs(self._handBookList.activities) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  return true
end

function BM_HandBook:GetTuJianList()
  return self._handBookList.roleList
end

function BM_HandBook:IsShowRoleFavorAwardRed()
  return self._handBookList._favorAwardRed
end

function BM_HandBook:IsCanDrawRoleFavorAward(roleid)
  for _, v in pairs(self._handBookList.roleList) do
    if v.id == roleid then
      return v.canDrawAward
    end
  end
  return false
end

function BM_HandBook:GetUnlockSoulNum(id)
  for k, v in pairs(self._handBookList.soulNums) do
    if k == id then
      return v
    end
  end
  return 0
end

function BM_HandBook:GetLockedRoleList()
  return self._handBookList.lockedRoleList
end

function BM_HandBook:IsLockedRole(roleid)
  for _, id in pairs(self._handBookList.lockedRoleList) do
    if roleid == id then
      return true
    end
  end
  return false
end

return BM_HandBook
