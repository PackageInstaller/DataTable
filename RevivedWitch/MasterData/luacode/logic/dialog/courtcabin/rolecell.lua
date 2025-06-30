-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/rolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleCell = class("RoleCell", Dialog)
RoleCell.AssetBundleName = "ui/layouts.yard"
RoleCell.AssetName = "HouseCharDetailCell"
RoleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleCell
  ((RoleCell.super).Ctor)(self, ...)
end

RoleCell.OnCreate = function(self)
  -- function num : 0_1
  self._charPanel = self:GetChild("Panel")
  self._empty = self:GetChild("Empty")
  self._back = self:GetChild("Panel/CharacterCell/Back")
  self._photo = self:GetChild("Panel/CharacterCell/Photo")
  self._energyNotFullPanel = self:GetChild("Panel/CharIn")
  self._progressNum = self:GetChild("Panel/CharIn/Num/Num")
  self._progress = self:GetChild("Panel/CharIn/Loading/BackGround/Progress")
  self._mood = self:GetChild("Panel/CharIn/Mood")
  self._energyUp = self:GetChild("Panel/CharIn/MoodUp")
  self._relationUp = self:GetChild("Panel/RelationUp")
  self._energyFullPanel = self:GetChild("Panel/CharOut")
  self._progressNum1 = self:GetChild("Panel/CharOut/Num/Num")
  self._progress1 = self:GetChild("Panel/CharOut/Loading/BackGround/Progress")
  self._mood1 = self:GetChild("Panel/CharOut/Mood")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RoleCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  if not data.role then
    (self._charPanel):SetActive(false)
    ;
    (self._empty):SetActive(true)
  else
    ;
    (self._charPanel):SetActive(true)
    ;
    (self._empty):SetActive(false)
    local imgRecord = (data.role):GetRarityBackRecord()
    ;
    (self._back):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    imgRecord = (data.role):GetShapeBustImageRecord()
    ;
    (self._photo):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    self:RefreshEnergyAndRelation()
  end
end

RoleCell.RefreshEnergyAndRelation = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local info = (((NekoData.BehaviorManager).BM_Cabin):GetRoles())[((self._data).role):GetRoleId()]
  local energy = ((self._data).role):GetEnergy()
  local totalEnergy = DataCommon.TotalEnergy
  local imgRecord = nil
  if energy < totalEnergy then
    (self._energyNotFullPanel):SetActive(true)
    ;
    (self._energyFullPanel):SetActive(false)
    local relationLevel = ((self._data).role):GetRelationLevel()
    self._maxRelationLevel = ((self._data).role):GetRelationMaxLevel()
    ;
    (self._relationUp):SetActive(relationLevel < self._maxRelationLevel)
    local restEnergy = (math.floor)(energy)
    imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetImgRecordByEnergy(restEnergy)
    if imgRecord then
      (self._mood):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      LogError("imgRecord is nil.")
    end
    ;
    (self._progressNum):SetText(restEnergy .. "/" .. totalEnergy)
    ;
    (self._progress):SetFillAmount(restEnergy / totalEnergy)
  else
    (self._energyNotFullPanel):SetActive(false)
    ;
    (self._energyFullPanel):SetActive(true)
    ;
    (self._relationUp):SetActive(false)
    imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetImgRecordByEnergy(totalEnergy)
    if imgRecord then
      (self._mood1):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      LogError("imgRecord is nil.")
    end
    ;
    (self._progressNum1):SetText(totalEnergy .. "/" .. totalEnergy)
    ;
    (self._progress1):SetFillAmount(1)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

RoleCell.OnCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._delegate)._canOperate and not (self._delegate)._willDestroy then
    local dialog = (DialogManager.CreateSingletonDialog)("magictree.chooseroledialog")
    if dialog then
      dialog:Init(nil, DataCommon.Cabin, (self._delegate)._roomId)
    end
  end
end

RoleCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6
  if eventName == "RefreshEnergyAndRelation" and (self._data).role then
    self:RefreshEnergyAndRelation()
  end
end

return RoleCell

