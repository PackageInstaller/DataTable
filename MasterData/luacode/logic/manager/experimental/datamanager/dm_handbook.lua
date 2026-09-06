local DM_HandBook = class("DM_HandBook")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")

function DM_HandBook:Ctor()
  self._handBookList = NekoData.Data.handBookList
  self._handBookList._favorAwardRed = false
  self._handBookList.soulNums = {}
end

function DM_HandBook:Clear()
  while self._handBookList.equipList[#self._handBookList.equipList] do
    table.remove(self._handBookList.equipList, #self._handBookList.equipList)
  end
  while self._handBookList.monsterList[#self._handBookList.monsterList] do
    table.remove(self._handBookList.monsterList, #self._handBookList.monsterList)
  end
  while self._handBookList.roleList[#self._handBookList.roleList] do
    table.remove(self._handBookList.roleList, #self._handBookList.roleList)
  end
  while self._handBookList.npcList[#self._handBookList.npcList] do
    table.remove(self._handBookList.npcList, #self._handBookList.npcList)
  end
  while self._handBookList.worldList[#self._handBookList.worldList] do
    table.remove(self._handBookList.worldList, #self._handBookList.worldList)
  end
  while self._handBookList.forceList[#self._handBookList.forceList] do
    table.remove(self._handBookList.forceList, #self._handBookList.forceList)
  end
  while self._handBookList.activities[#self._handBookList.activities] do
    table.remove(self._handBookList.activities, #self._handBookList.activities)
  end
  while self._handBookList.soulNums[#self._handBookList.soulNums] do
    table.remove(self._handBookList.soulNums, #self._handBookList.soulNums)
  end
  while self._handBookList.lockedRoleList[#self._handBookList.lockedRoleList] do
    table.remove(self._handBookList.lockedRoleList, #self._handBookList.lockedRoleList)
  end
end

function DM_HandBook:OnSHandBook(protocol)
  self:Clear()
  for k, v in pairs(protocol.equips) do
    table.insert(self._handBookList.equipList, v)
  end
  for k, v in pairs(protocol.monsters) do
    table.insert(self._handBookList.monsterList, v)
  end
  for k, v in pairs(protocol.npc) do
    table.insert(self._handBookList.npcList, v)
  end
  for k, v in pairs(protocol.worlds) do
    table.insert(self._handBookList.worldList, v)
  end
  for k, v in pairs(protocol.forces) do
    table.insert(self._handBookList.forceList, v)
  end
  for id, favorAwardStatus in pairs(protocol.roles) do
    local favorInfo = {}
    favorInfo.id = id
    favorInfo.canDrawAward = favorAwardStatus == 1
    table.insert(self._handBookList.roleList, favorInfo)
  end
  for k, v in pairs(protocol.activities) do
    table.insert(self._handBookList.activities, v)
  end
  self._handBookList.soulNums = protocol.soulNums
  for _, id in pairs(protocol.lockedRoles) do
    table.insert(self._handBookList.lockedRoleList, id)
  end
  self:CheckFavorAwardRedState()
end

function DM_HandBook:OnSRefreshHandBook(protocol)
  if protocol.bookType == HandBookTypeEnum.EQUIP then
    table.insert(self._handBookList.equipList, protocol.id)
  end
  if protocol.bookType == HandBookTypeEnum.MONSTER then
    table.insert(self._handBookList.monsterList, protocol.id)
  end
  if protocol.bookType == HandBookTypeEnum.NPC then
    table.insert(self._handBookList.npcList, protocol.id)
  end
  if protocol.bookType == HandBookTypeEnum.WORLD then
    table.insert(self._handBookList.worldList, protocol.id)
  end
  if protocol.bookType == HandBookTypeEnum.FORCE then
    table.insert(self._handBookList.forceList, protocol.id)
  end
  if protocol.bookType == HandBookTypeEnum.ACTIVITY then
    table.insert(self._handBookList.activities, protocol.id)
    LuaNotificationCenter.PostNotification(Common.n_RefreshAcitivityHandBook, nil, nil)
  end
end

function DM_HandBook:OnSRefreshRoleFavorAwardStatus(protocol)
  local bHasRole = false
  for _, value in pairs(self._handBookList.roleList) do
    if value.id == protocol.id then
      value.canDrawAward = protocol.canDrawAward
      local data = {}
      data.id = protocol.id
      data.canDrawAward = value.canDrawAward
      bHasRole = true
      break
    end
  end
  if not bHasRole then
    local favorInfo = {}
    favorInfo.id = protocol.id
    favorInfo.canDrawAward = protocol.canDrawAward
    table.insert(self._handBookList.roleList, favorInfo)
  end
  self:CheckFavorAwardRedState()
end

function DM_HandBook:CheckFavorAwardRedState()
  local bHasRed = false
  for _, value in pairs(self._handBookList.roleList) do
    if value.canDrawAward and not bHasRed then
      bHasRed = true
      break
    end
  end
  if bHasRed ~= self._handBookList._favorAwardRed then
    self._handBookList._favorAwardRed = bHasRed
  end
end

function DM_HandBook:OnSRefreshHandBookSoulNum(protocol)
  self._handBookList.soulNums[protocol.HandBookId] = protocol.soulNum
  if protocol.soulNums == 0 then
    self._handBookList.soulNums[protocol.HandBookId] = nil
  end
end

return DM_HandBook
