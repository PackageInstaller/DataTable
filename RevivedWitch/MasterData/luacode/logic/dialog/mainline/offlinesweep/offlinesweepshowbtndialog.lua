-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinesweep/offlinesweepshowbtndialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local OfflineSweepShowBtnDialog = class("OfflineSweepShowBtnDialog", Dialog)
OfflineSweepShowBtnDialog.AssetBundleName = "ui/layouts.dispatchbattle"
OfflineSweepShowBtnDialog.AssetName = "DispatchBattleWindow"
OfflineSweepShowBtnDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflineSweepShowBtnDialog, _ENV
  ((OfflineSweepShowBtnDialog.super).Ctor)(self, ...)
  self._bm = (NekoData.BehaviorManager).BM_OfflineSweep
  self._data = {}
end

OfflineSweepShowBtnDialog.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._redDot = self:GetChild("Back/RedDot")
  self._icon = self:GetChild("Back/Frame/Icon")
  self._titleTxt = self:GetChild("Back/Frame/TitleTxt")
  self._text = self:GetChild("Back/Frame/Text")
  self._effect = self:GetChild("Back/Effect")
  ;
  (self._icon):Subscribe_PointerClickEvent(self.OpenDetail, self)
  ;
  (self._effect):SetActive(false)
  ;
  (self._redDot):SetActive(false)
  self:Init()
end

OfflineSweepShowBtnDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

OfflineSweepShowBtnDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

OfflineSweepShowBtnDialog.Init = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._titleTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1854))
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

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

OfflineSweepShowBtnDialog.OnRefreshProcessShow = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).status = (self._bm):GetStatus()
  ;
  (self._effect):SetActive((self._bm):IsCanReceive())
  ;
  (self._redDot):SetActive((self._bm):IsCanReceive())
  if (self._data).status == 1 then
    (self._text):SetText((self._bm):GetTimeStr())
  else
    if (self._data).status == 2 then
      (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1868))
    end
  end
  if (self._data).status ~= 1 and self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

OfflineSweepShowBtnDialog.OpenDetail = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self._bm):IsCanReceive() then
    local csend = (LuaNetManager.CreateProtocol)("protocol.battle.creceivesweep")
    csend:Send()
  else
    do
      if (self._bm):GetStatus() == 1 then
        ((DialogManager.CreateSingletonDialog)("mainline.offlinesweep.offlinesweepdetaildialog")):Init()
      end
    end
  end
end

OfflineSweepShowBtnDialog.ShowFlashingPrompt = function(self)
  -- function num : 0_7
  if (self._bm):IsCanReceive() then
  end
end

return OfflineSweepShowBtnDialog

