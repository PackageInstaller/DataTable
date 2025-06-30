-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/detailbuildingunlockcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local DetailBuildingUnlockCell = class("DetailBuildingUnlockCell", Dialog)
DetailBuildingUnlockCell.AssetBundleName = "ui/layouts.yard"
DetailBuildingUnlockCell.AssetName = "MagicTreeCellLock"
DetailBuildingUnlockCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DetailBuildingUnlockCell
  ((DetailBuildingUnlockCell.super).Ctor)(self, ...)
  self._meetCondition = false
end

DetailBuildingUnlockCell.OnCreate = function(self)
  -- function num : 0_1
  self._lock = self:GetChild("Lock")
  self._lockName = self:GetChild("Lock/Title")
  self._unlockCondition = self:GetChild("Lock/LV")
  self._unlock = self:GetChild("Unlock")
  self._unlockName = self:GetChild("Unlock/Title")
  self._image = self:GetChild("Unlock/Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
end

DetailBuildingUnlockCell.OnDestroy = function(self)
  -- function num : 0_2
end

DetailBuildingUnlockCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCourtyardLvUpCfg, _ENV, CCourtyardNameCfg, TaskStateEnum, CImagePathTable
  self._data = data
  if data.taskId ~= 0 then
    local buildingId = data.buildingId
    local taskRecord = CCourtyardLvUpCfg:GetRecorder(data.taskId)
    if not taskRecord then
      LogErrorFormat("DetailBuildingUnlockCell", "Cant not find recorder By taskId：%s in ccourtyardlvup", data.taskId)
    end
    self._meetCondition = taskRecord.openCondition <= ((NekoData.BehaviorManager).BM_MagicTree):GetLevel()
    local courtYardRecord = CCourtyardNameCfg:GetRecorder(buildingId)
    if data.taskState == TaskStateEnum.LOCK then
      (self._lock):SetActive(true)
      ;
      (self._unlock):SetActive(false)
      ;
      (self._lockName):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
      ;
      (self._unlockCondition):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1110, taskRecord.openCondition))
    elseif data.taskState == TaskStateEnum.UNLOCK then
      (self._lock):SetActive(false)
      ;
      (self._unlock):SetActive(true)
      ;
      (self._unlockName):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
    end
    if not CImagePathTable:GetRecorder(courtYardRecord.yardconstructionicon) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

DetailBuildingUnlockCell.OnUnlockBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_MagicTree):GetWorkingTaskNum() < ((NekoData.BehaviorManager).BM_MagicTree):GetMaxTaskNum() then
    if self._meetCondition then
      local cstartTreeTask = (LuaNetManager.CreateProtocol)("protocol.yard.cstarttreetask")
      cstartTreeTask.buildId = (self._data).buildingId
      cstartTreeTask:Send()
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100155)
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100088)
      end
    end
  end
end

return DetailBuildingUnlockCell

