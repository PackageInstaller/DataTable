local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local OfflineSweepDetailDialog = class("OfflineSweepDetailDialog", Dialog)
OfflineSweepDetailDialog.AssetBundleName = "ui/layouts.dispatchbattle"
OfflineSweepDetailDialog.AssetName = "DispatchBattleWindowDetail"

function OfflineSweepDetailDialog:Ctor(...)
  OfflineSweepDetailDialog.super.Ctor(self, ...)
  self._bm = NekoData.BehaviorManager.BM_OfflineSweep
  self._groupName = "SecondConfirm"
  self._data = {}
end

function OfflineSweepDetailDialog:OnCreate()
  self._title = self:GetChild("Back/TitleBack/Title")
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1866))
  self._timesTxt = self:GetChild("Back/Frame/Text1")
  self._leftTimeTxt = self:GetChild("Back/Frame/Text2")
  self._levelTxt = self:GetChild("Back/Frame/Icon/Text")
  self._levelIcon = self:GetChild("Back/Frame/Icon")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._stopBtn = self:GetChild("Back/Frame/StopBtn")
  self._stopbtn_text = self:GetChild("Back/Frame/StopBtn/_Text")
  self._wordText = self:GetChild("Back/Frame/WordText")
  self._stopBtn:Subscribe_PointerClickEvent(self.OnStopBtnClick, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function OfflineSweepDetailDialog:OnDestroy()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function OfflineSweepDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

function OfflineSweepDetailDialog:Init()
  local levelInfo = self._bm:GetLevelInfo()
  self._levelTxt:SetText(levelInfo.name)
  if levelInfo.littleImg then
    local imageRecord = CImagePathTable:GetRecorder(levelInfo.littleImg) or DataCommon.DefaultImageAsset
    self._levelIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._levelIcon:SetActive(true)
    self._wordText:SetActive(false)
  else
    self._levelIcon:SetActive(false)
    self._wordText:SetActive(true)
    self._wordText:SetText(levelInfo.name)
  end
  self._data.status = self._bm:GetStatus()
  if self._data.status == 1 then
    if self._task then
      GameTimer.RemoveTask(self._task)
      self._task = nil
    end
    self._task = GameTimer.AddTask(0, 1, function()
      self:OnRefreshProcessShow()
    end, nil)
  end
  self:OnRefreshProcessShow()
end

function OfflineSweepDetailDialog:OnRefreshProcessShow()
  self._data.status = self._bm:GetStatus()
  self._timesTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1863, self._bm:GetProcessNum()))
  if self._data.status == 1 then
    self._leftTimeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1864, {
      self._bm:GetTimeStr()
    }))
    self._stopbtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1861))
  elseif self._data.status == 2 then
    self._leftTimeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1868))
    self._stopbtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1865))
  end
  if self._data.status ~= 1 and self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function OfflineSweepDetailDialog:OnStopBtnClick()
  if self._data.status == 1 then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(138, {}, function()
      local csend = LuaNetManager.CreateProtocol("protocol.battle.cinterruptsweep")
      csend:Send()
    end, {}, function()
      DialogManager.CreateSingletonDialog("mainline.offlinesweep.offlinesweepdetaildialog"):Init()
    end, {})
  elseif self._data.status == 2 then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.creceivesweep")
    csend:Send()
  end
  self:Destroy()
end

return OfflineSweepDetailDialog
