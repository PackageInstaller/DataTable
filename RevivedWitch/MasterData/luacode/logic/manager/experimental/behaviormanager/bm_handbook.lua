-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_handbook.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_HandBook = class("BM_HandBook")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
BM_HandBook.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._handBookList = (NekoData.Data).handBookList
  self._allUnlock = nil
end

BM_HandBook.IsBookUnLock = function(self, bookid, booktype)
  -- function num : 0_1 , upvalues : HandBookTypeEnum, _ENV
  if self._allUnlock then
    return true
  end
  if booktype == HandBookTypeEnum.EQUIP then
    for index,id in pairs((self._handBookList).equipList) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.MONSTER then
    for index,id in pairs((self._handBookList).monsterList) do
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
    for _,v in pairs((self._handBookList).roleList) do
      if v.id == bookid then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.NPC then
    for index,id in pairs((self._handBookList).npcList) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.WORLD then
    for index,id in pairs((self._handBookList).worldList) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  if booktype == HandBookTypeEnum.FORCE then
    for index,id in pairs((self._handBookList).forceList) do
      if bookid == id then
        return true
      end
    end
    return true
  end
  if booktype == HandBookTypeEnum.ACTIVITY then
    for index,id in pairs((self._handBookList).activities) do
      if bookid == id then
        return true
      end
    end
    return false
  end
  return true
end

BM_HandBook.GetTuJianList = function(self)
  -- function num : 0_2
  return (self._handBookList).roleList
end

BM_HandBook.IsShowRoleFavorAwardRed = function(self)
  -- function num : 0_3
  return (self._handBookList)._favorAwardRed
end

BM_HandBook.IsCanDrawRoleFavorAward = function(self, roleid)
  -- function num : 0_4 , upvalues : _ENV
  for _,v in pairs((self._handBookList).roleList) do
    if v.id == roleid then
      return v.canDrawAward
    end
  end
  return false
end

BM_HandBook.GetUnlockSoulNum = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs((self._handBookList).soulNums) do
    if k == id then
      return v
    end
  end
  return 0
end

BM_HandBook.GetLockedRoleList = function(self)
  -- function num : 0_6
  return (self._handBookList).lockedRoleList
end

BM_HandBook.IsLockedRole = function(self, roleid)
  -- function num : 0_7 , upvalues : _ENV
  for _,id in pairs((self._handBookList).lockedRoleList) do
    if roleid == id then
      return true
    end
  end
  return false
end

return BM_HandBook

