-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/chooserolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CCourtYardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local CYardSkillCfg = (BeanManager.GetTableByName)("courtyard.cyardskill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CDormFloorCfg = (BeanManager.GetTableByName)("courtyard.cdormfloor")
local SlotEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local ChooseRoleCell = class("ChooseRoleCell", Dialog)
ChooseRoleCell.AssetBundleName = "ui/layouts.yard"
ChooseRoleCell.AssetName = "YardSendCharCell"
ChooseRoleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChooseRoleCell
  ((ChooseRoleCell.super).Ctor)(self, ...)
end

ChooseRoleCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("CharacterCell/Back")
  self._photo = self:GetChild("CharacterCell/Photo")
  self._down = self:GetChild("CharacterCell/Down")
  self._job = self:GetChild("CharacterCell/Job")
  self._rank = self:GetChild("Rank")
  self._name = self:GetChild("Name")
  self._yardSkillIcon = self:GetChild("Place")
  self._frame = self:GetChild("CharacterCell/Frame")
  self._select = self:GetChild("CharacterCell/Select")
  self._selectTxt = self:GetChild("Choose")
  self._grey = self:GetChild("CharacterCell/Grey")
  self._progressPanel = self:GetChild("Loading")
  self._progressNum = self:GetChild("Loading/Num/Num")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._progressEnergyNotFull = self:GetChild("Loading/Loading/BackGround/Progress2")
  self._mood = self:GetChild("Loading/Mood")
  self._working = self:GetChild("Rest")
  self._buildingIcon = self:GetChild("Rest/Place")
  self._buildingName = self:GetChild("Rest/Building")
  self._line = self:GetChild("Rest/Line")
  self._workState = self:GetChild("Rest/Floor")
  self._trainPanel = self:GetChild("Training")
  self._lv = self:GetChild("Training/Level/Num")
  self._breakLevelBackBlack = self:GetChild("Training/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Training/BreakLevelBack")
  self._breakLevel = self:GetChild("Training/BreakLevelNum")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ChooseRoleCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChooseRoleCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CYardSkillCfg, CImagePathTable
  self._data = data
  local imgRecord = data:GetRarityBackRecord()
  ;
  (self._back):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  imgRecord = data:GetShapeBustImageRecord()
  ;
  (self._photo):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  imgRecord = data:GetVocationImageRecord()
  ;
  (self._job):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  if data:GetIsLeader() then
    (self._name):SetText((TextManager.GetText)(800332))
    ;
    (self._rank):SetActive(false)
  else
    ;
    (self._name):SetText(data:GetRoleName())
    ;
    (self._rank):SetActive(true)
    imgRecord = data:GetRarityImageRecord()
    ;
    (self._rank):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  imgRecord = data:GetRarityFrameRecord()
  ;
  (self._frame):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  if (self._delegate)._buildingId == DataCommon.TrainCamp then
    (self._progressPanel):SetActive(false)
    ;
    (self._trainPanel):SetActive(true)
    ;
    (self._lv):SetText(data:GetShowLv())
    local breakLv = data:GetBreakLv()
    ;
    (self._breakLevelBackBlack):SetActive(breakLv == 0)
    ;
    (self._breakLevelBack):SetActive(breakLv > 0)
    ;
    (self._breakLevel):SetActive(breakLv > 0)
    if breakLv > 0 then
      local imageRecord = data:GetCurBreakFrame2ImageRecord()
      ;
      (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._breakLevel):SetText(breakLv)
    end
  else
    (self._progressPanel):SetActive(true)
    ;
    (self._trainPanel):SetActive(false)
  end
  self:RefreshEnergy()
  self:RefreshWorkingState()
  local yardSkillList = data:GetYardSkillList()
  local yardSkillRecord = CYardSkillCfg:GetRecorder(yardSkillList[1])
  local imgRecord = CImagePathTable:GetRecorder(yardSkillRecord.image)
  ;
  (self._yardSkillIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ChooseRoleCell.RefreshEnergy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local imgRecord = nil
  local restEnergy = 0
  local buildingId = (self._data):GetBuildingId()
  if buildingId then
    if buildingId == DataCommon.Explore then
      local roleInfo = (((NekoData.BehaviorManager).BM_Explore):GetRoles())[(self._data):GetRoleId()]
      restEnergy = roleInfo.energy
    else
      do
        if buildingId == DataCommon.Alchemy or buildingId == DataCommon.TrainCamp then
          restEnergy = (self._data):GetEnergy()
        else
          if buildingId == DataCommon.Cabin then
            if (self._data):GetEnergy() < DataCommon.TotalEnergy then
              local roleInfo = (((NekoData.BehaviorManager).BM_Cabin):GetRoles())[(self._data):GetRoleId()]
              local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(roleInfo.roomId)
              restEnergy = (self._data):GetEnergy()
            else
              do
                restEnergy = DataCommon.TotalEnergy
                restEnergy = (self._data):GetEnergy()
                restEnergy = (math.floor)(restEnergy)
                if DataCommon.TotalEnergy <= restEnergy then
                  (self._progress):SetActive(true)
                  ;
                  (self._progressEnergyNotFull):SetActive(false)
                  ;
                  (self._progress):SetFillAmount(1)
                else
                  ;
                  (self._progress):SetActive(false)
                  ;
                  (self._progressEnergyNotFull):SetActive(true)
                  ;
                  (self._progressEnergyNotFull):SetFillAmount(restEnergy / DataCommon.TotalEnergy)
                end
                ;
                (self._progressNum):SetText(tostring(restEnergy) .. "/" .. tostring(DataCommon.TotalEnergy))
                imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetImgRecordByEnergy(restEnergy)
                if imgRecord then
                  (self._mood):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                else
                  LogError("imgRecord is nil.")
                end
              end
            end
          end
        end
      end
    end
  end
end

ChooseRoleCell.RefreshWorkingState = function(self)
  -- function num : 0_5 , upvalues : _ENV, CCourtYardNameCfg, CImagePathTable, CDormFloorCfg
  local index = (table.indexof)((self._delegate)._selectRoles, (self._data):GetRoleId())
  local initIndex = (table.indexof)((self._delegate)._curTaskRoles, (self._data):GetRoleId())
  ;
  (self._select):SetActive(index)
  ;
  (self._selectTxt):SetActive(index)
  local buildingId = (self._data):GetBuildingId()
  local tag = not buildingId or (buildingId ~= DataCommon.Alchemy and buildingId ~= DataCommon.Cabin)
  ;
  (self._grey):SetActive(index or buildingId)
  self._canNotSelect = (index or tag) and not initIndex
  local buildingId = (self._data):GetBuildingId()
  if buildingId then
    (self._working):SetActive(true)
    local courtYardRecord = CCourtYardNameCfg:GetRecorder(buildingId)
    if not CImagePathTable:GetRecorder(courtYardRecord.yardsheltericon) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._buildingIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if index then
      (self._buildingName):SetActive(false)
      ;
      (self._line):SetActive(false)
      ;
      (self._workState):SetActive(false)
    else
      (self._buildingName):SetActive(true)
      ;
      (self._line):SetActive(true)
      ;
      (self._workState):SetActive(true)
      local str = (TextManager.GetText)(courtYardRecord.nameTextID)
      ;
      (self._buildingName):SetText(str)
      if buildingId == DataCommon.Explore then
        str = ((NekoData.BehaviorManager).BM_Message):GetString(1326)
      elseif buildingId == DataCommon.Alchemy then
        str = ((NekoData.BehaviorManager).BM_Message):GetString(1325)
      elseif buildingId == DataCommon.Cabin then
        local cabinRoles = ((NekoData.BehaviorManager).BM_Cabin):GetRoles()
        local roomId = (cabinRoles[(self._data):GetRoleId()]).roomId
        str = ((NekoData.BehaviorManager).BM_Message):GetString(1324, {(TextManager.GetText)((CDormFloorCfg:GetRecorder(roomId)).stayingfloor)})
      elseif buildingId == DataCommon.TrainCamp then
        str = (TextManager.GetText)(800181)
      end
      ;
      (self._workState):SetText(str)
    end
  else
    (self._working):SetActive(false)
  end
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

ChooseRoleCell.OnCellClicked = function(self)
  -- function num : 0_6
  if not self._canNotSelect then
    (self._delegate):SelectRoles((self._data):GetRoleId())
  end
end

ChooseRoleCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7 , upvalues : _ENV
  if eventName == "SelectRoles" then
    self:RefreshWorkingState()
  end
  if eventName == "RefreshEnergy" then
    self:RefreshEnergy()
  end
  if eventName == "RefreshCell" and arg[(self._data):GetRoleId()] then
    self:RefreshCell(((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._data):GetRoleId()))
  end
end

return ChooseRoleCell

