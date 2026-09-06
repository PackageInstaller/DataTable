local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = BeanManager.GetTableByName("courtyard.ccourtyardname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TaskStateEnum = LuaNetManager.GetBeanDef("protocol.yard.task")
local DetailBuildingUnlockCell = class("DetailBuildingUnlockCell", Dialog)
DetailBuildingUnlockCell.AssetBundleName = "ui/layouts.yard"
DetailBuildingUnlockCell.AssetName = "MagicTreeCellLock"

function DetailBuildingUnlockCell:Ctor(...)
  DetailBuildingUnlockCell.super.Ctor(self, ...)
  self._meetCondition = false
end

function DetailBuildingUnlockCell:OnCreate()
  self._lock = self:GetChild("Lock")
  self._lockName = self:GetChild("Lock/Title")
  self._unlockCondition = self:GetChild("Lock/LV")
  self._unlock = self:GetChild("Unlock")
  self._unlockName = self:GetChild("Unlock/Title")
  self._image = self:GetChild("Unlock/Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
end

function DetailBuildingUnlockCell:OnDestroy()
end

function DetailBuildingUnlockCell:RefreshCell(data)
  self._data = data
  if data.taskId ~= 0 then
    local buildingId = data.buildingId
    local taskRecord = CCourtyardLvUpCfg:GetRecorder(data.taskId)
    if not taskRecord then
      LogErrorFormat("DetailBuildingUnlockCell", "Cant not find recorder By taskId：%s in ccourtyardlvup", data.taskId)
    end
    self._meetCondition = NekoData.BehaviorManager.BM_MagicTree:GetLevel() >= taskRecord.openCondition
    local courtYardRecord = CCourtyardNameCfg:GetRecorder(buildingId)
    if data.taskState == TaskStateEnum.LOCK then
      self._lock:SetActive(true)
      self._unlock:SetActive(false)
      self._lockName:SetText(TextManager.GetText(courtYardRecord.nameTextID))
      self._unlockCondition:SetText(NekoData.BehaviorManager.BM_Message:GetString(1110, taskRecord.openCondition))
    elseif data.taskState == TaskStateEnum.UNLOCK then
      self._lock:SetActive(false)
      self._unlock:SetActive(true)
      self._unlockName:SetText(TextManager.GetText(courtYardRecord.nameTextID))
    end
    local imageRecord = CImagePathTable:GetRecorder(courtYardRecord.yardconstructionicon) or DataCommon.DefaultImageAsset
    self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function DetailBuildingUnlockCell:OnUnlockBtnClicked()
  if NekoData.BehaviorManager.BM_MagicTree:GetWorkingTaskNum() < NekoData.BehaviorManager.BM_MagicTree:GetMaxTaskNum() then
    if self._meetCondition then
      local cstartTreeTask = LuaNetManager.CreateProtocol("protocol.yard.cstarttreetask")
      cstartTreeTask.buildId = self._data.buildingId
      cstartTreeTask:Send()
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100155)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100088)
  end
end

return DetailBuildingUnlockCell
