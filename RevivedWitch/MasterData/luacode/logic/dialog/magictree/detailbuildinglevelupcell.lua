-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/detailbuildinglevelupcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local ClickType = {Lock = 0, CanLevelUp = 1, CanFinish = 2, BeMaxLevel = 3}
local DetailBuildingLevelUpCell = class("DetailBuildingLevelUpCell", Dialog)
DetailBuildingLevelUpCell.AssetBundleName = "ui/layouts.yard"
DetailBuildingLevelUpCell.AssetName = "MagicTreeCell"
DetailBuildingLevelUpCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DetailBuildingLevelUpCell
  ((DetailBuildingLevelUpCell.super).Ctor)(self, ...)
end

DetailBuildingLevelUpCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Normal/Image")
  self._name = self:GetChild("Normal/Title")
  self._level = self:GetChild("Normal/LVNum")
  self._levelUpBtn = self:GetChild("Normal/LevelUpBtn")
  self._levelUpIng = self:GetChild("LevelUpState")
  self._levelUpRestTime = self:GetChild("LevelUpState/Time")
  self._finish = self:GetChild("FinishState")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

DetailBuildingLevelUpCell.OnDestroy = function(self)
  -- function num : 0_2
end

DetailBuildingLevelUpCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCourtyardNameCfg, _ENV, CImagePathTable, ClickType, TaskStateEnum
  self._data = data
  local buildingId = data.buildingId
  local courtYardRecord = CCourtyardNameCfg:GetRecorder(buildingId)
  ;
  (self._name):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
  if not CImagePathTable:GetRecorder(courtYardRecord.yardconstructionicon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._clickType = nil
  if data.taskId == 0 then
    self._clickType = ClickType.BeMaxLevel
    ;
    (self._level):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1287, {"MAX"}))
    ;
    (self._levelUpBtn):SetActive(false)
    ;
    (self._levelUpIng):SetActive(false)
    ;
    (self._finish):SetActive(false)
  else
    local bm_building = nil
    if buildingId == DataCommon.MagicTree then
      bm_building = (NekoData.BehaviorManager).BM_MagicTree
    else
      if buildingId == DataCommon.Explore then
        bm_building = (NekoData.BehaviorManager).BM_Explore
      else
        if buildingId == DataCommon.Firefly then
          bm_building = (NekoData.BehaviorManager).BM_Firefly
        else
          if buildingId == DataCommon.Alchemy then
            bm_building = (NekoData.BehaviorManager).BM_Alchemy
          else
            if buildingId == DataCommon.Cabin then
              bm_building = (NekoData.BehaviorManager).BM_Cabin
            end
          end
        end
      end
    end
    ;
    (self._level):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1287, {bm_building:GetLevel()}))
    local taskState = data.taskState
    if taskState == TaskStateEnum.LOCK then
      self._clickType = ClickType.Lock
      ;
      (self._levelUpBtn):SetActive(false)
      ;
      (self._levelUpIng):SetActive(false)
      ;
      (self._finish):SetActive(false)
    else
      if taskState == TaskStateEnum.UNLOCK then
        self._clickType = ClickType.CanLevelUp
        ;
        (self._levelUpBtn):SetActive(true)
        ;
        (self._levelUpIng):SetActive(false)
        ;
        (self._finish):SetActive(false)
      else
        ;
        (self._levelUpBtn):SetActive(false)
        if taskState == TaskStateEnum.PROCESSING then
          (self._level):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1288, {bm_building:GetLevel(), data.taskId - buildingId}))
          self:RefreshTime()
          ;
          (self._levelUpIng):SetActive(true)
          ;
          (self._finish):SetActive(false)
        else
          if taskState == TaskStateEnum.UnReceive then
            self._clickType = ClickType.CanFinish
            ;
            (self._levelUpIng):SetActive(false)
            ;
            (self._finish):SetActive(true)
          end
        end
      end
    end
  end
end

DetailBuildingLevelUpCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : ClickType, _ENV
  if self._clickType == ClickType.BeMaxLevel then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100118)
  else
    if self._clickType == ClickType.CanLevelUp or self._clickType == ClickType.Lock then
      if ((NekoData.BehaviorManager).BM_MagicTree):GetWorkingTaskNum() < ((NekoData.BehaviorManager).BM_MagicTree):GetMaxTaskNum() then
        ((DialogManager.CreateSingletonDialog)("magictree.buildinglevelupdialog")):Init((self._data).taskId)
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100088)
      end
    else
      if self._clickType == ClickType.CanFinish then
        local ccompleteTask = (LuaNetManager.CreateProtocol)("protocol.yard.ccompletetask")
        ccompleteTask.id = (self._data).buildingId
        ccompleteTask:Send()
      end
    end
  end
end

DetailBuildingLevelUpCell.RefreshTime = function(self)
  -- function num : 0_5 , upvalues : _ENV, CStringres
  local taskInfo = ((NekoData.BehaviorManager).BM_MagicTree):GetTaskInfoByBuildingId((self._data).buildingId)
  local leftTime = taskInfo.leftTime
  local str = ""
  if leftTime // 1000 > 0 then
    str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", leftTime // 1000))
    str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", leftTime // 1000))
    str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", leftTime // 1000))
  else
    str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", "00")
    str = (string.gsub)(str, "%$parameter2%$", "00")
    str = (string.gsub)(str, "%$parameter3%$", "00")
  end
  ;
  (self._levelUpRestTime):SetText(str)
end

DetailBuildingLevelUpCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6 , upvalues : TaskStateEnum
  if eventName == "RefreshTime" and (self._data).taskState == TaskStateEnum.PROCESSING then
    self:RefreshTime()
  end
end

return DetailBuildingLevelUpCell

