-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinesweep/offlinesweepdetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local OfflineSweepDetailDialog = class("OfflineSweepDetailDialog", Dialog)
OfflineSweepDetailDialog.AssetBundleName = "ui/layouts.dispatchbattle"
OfflineSweepDetailDialog.AssetName = "DispatchBattleWindowDetail"
OfflineSweepDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflineSweepDetailDialog, _ENV
  ((OfflineSweepDetailDialog.super).Ctor)(self, ...)
  self._bm = (NekoData.BehaviorManager).BM_OfflineSweep
  self._groupName = "SecondConfirm"
  self._data = {}
end

OfflineSweepDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("Back/TitleBack/Title")
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1866))
  self._timesTxt = self:GetChild("Back/Frame/Text1")
  self._leftTimeTxt = self:GetChild("Back/Frame/Text2")
  self._levelTxt = self:GetChild("Back/Frame/Icon/Text")
  self._levelIcon = self:GetChild("Back/Frame/Icon")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._stopBtn = self:GetChild("Back/Frame/StopBtn")
  self._stopbtn_text = self:GetChild("Back/Frame/StopBtn/_Text")
  self._wordText = self:GetChild("Back/Frame/WordText")
  ;
  (self._stopBtn):Subscribe_PointerClickEvent(self.OnStopBtnClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

OfflineSweepDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

OfflineSweepDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

OfflineSweepDetailDialog.Init = function(self)
  -- function num : 0_4 , upvalues : CImagePathTable, _ENV
  local levelInfo = (self._bm):GetLevelInfo()
  ;
  (self._levelTxt):SetText(levelInfo.name)
  if levelInfo.littleImg then
    if not CImagePathTable:GetRecorder(levelInfo.littleImg) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._levelIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._levelIcon):SetActive(true)
    ;
    (self._wordText):SetActive(false)
  else
    do
      ;
      (self._levelIcon):SetActive(false)
      ;
      (self._wordText):SetActive(true)
      ;
      (self._wordText):SetText(levelInfo.name)
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._data).status = (self._bm):GetStatus()
      if (self._data).status == 1 then
        if self._task then
          (GameTimer.RemoveTask)(self._task)
          self._task = nil
        end
        self._task = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_4_0 , upvalues : self
    self:OnRefreshProcessShow()
  end
, nil)
      end
      self:OnRefreshProcessShow()
    end
  end
end

OfflineSweepDetailDialog.OnRefreshProcessShow = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).status = (self._bm):GetStatus()
  ;
  (self._timesTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1863, (self._bm):GetProcessNum()))
  if (self._data).status == 1 then
    (self._leftTimeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1864, {(self._bm):GetTimeStr()}))
    ;
    (self._stopbtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1861))
  else
    if (self._data).status == 2 then
      (self._leftTimeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1868))
      ;
      (self._stopbtn_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1865))
    end
  end
  if (self._data).status ~= 1 and self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

OfflineSweepDetailDialog.OnStopBtnClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self._data).status == 1 then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(138, {}, function()
    -- function num : 0_6_0 , upvalues : _ENV
    local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cinterruptsweep")
    csend:Send()
  end
, {}, function()
    -- function num : 0_6_1 , upvalues : _ENV
    ((DialogManager.CreateSingletonDialog)("mainline.offlinesweep.offlinesweepdetaildialog")):Init()
  end
, {})
  else
    if (self._data).status == 2 then
      local csend = (LuaNetManager.CreateProtocol)("protocol.battle.creceivesweep")
      csend:Send()
    end
  end
  do
    self:Destroy()
  end
end

return OfflineSweepDetailDialog

