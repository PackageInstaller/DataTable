-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/detailslotrolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DetailSlotRoleCell = class("DetailSlotRoleCell", Dialog)
DetailSlotRoleCell.AssetBundleName = "ui/layouts.yard"
DetailSlotRoleCell.AssetName = "YardExploreTaskCell2CharCell"
DetailSlotRoleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DetailSlotRoleCell
  ((DetailSlotRoleCell.super).Ctor)(self, ...)
end

DetailSlotRoleCell.OnCreate = function(self)
  -- function num : 0_1
  self._add = self:GetChild("Add")
  self._cell = self:GetChild("Cell")
  self._back = self:GetChild("Cell/Back")
  self._photo = self:GetChild("Cell/Photo")
  self._frame = self:GetChild("Cell/Frame")
  self._progressNum = self:GetChild("Cell/Loading/Num/Num")
  self._progress = self:GetChild("Cell/Loading/Loading/BackGround/Progress")
  self._mood = self:GetChild("Cell/Loading/Mood")
end

DetailSlotRoleCell.OnDestroy = function(self)
  -- function num : 0_2
end

DetailSlotRoleCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if not data then
    (self._add):SetActive(true)
    ;
    (self._cell):SetActive(false)
  else
    ;
    (self._add):SetActive(false)
    ;
    (self._cell):SetActive(true)
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(data)
    local imgRecord = (self._role):GetSmallRarityBackRecord()
    ;
    (self._back):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    imgRecord = (self._role):GetShapeLittleHeadImageRecord()
    ;
    (self._photo):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    imgRecord = (self._role):GetSmallRarityFrameRecord()
    ;
    (self._frame):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    self:RefreshEnergy()
  end
end

DetailSlotRoleCell.RefreshEnergy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local roleInfo = (((NekoData.BehaviorManager).BM_Explore):GetRoles())[(self._role):GetRoleId()]
  local restEnergy = (math.floor)(roleInfo.energy)
  ;
  (self._progressNum):SetText(tostring(restEnergy) .. "/" .. tostring(DataCommon.TotalEnergy))
  ;
  (self._progress):SetFillAmount(restEnergy / DataCommon.TotalEnergy)
  local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetImgRecordByEnergy(restEnergy)
  if imgRecord then
    (self._mood):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("imgRecord is nil.")
  end
end

DetailSlotRoleCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "RefreshEnergy" and self._role then
    self:RefreshEnergy()
  end
end

return DetailSlotRoleCell

