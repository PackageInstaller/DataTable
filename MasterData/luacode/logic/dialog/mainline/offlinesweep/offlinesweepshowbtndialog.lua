local OfflineSweepShowBtnDialog = class("OfflineSweepShowBtnDialog", Dialog)
OfflineSweepShowBtnDialog.AssetBundleName = "ui/layouts.dispatchbattle"
OfflineSweepShowBtnDialog.AssetName = "DispatchBattleWindow"

function OfflineSweepShowBtnDialog:Ctor(...)
  OfflineSweepShowBtnDialog.super.Ctor(self, ...)
  self._bm = NekoData.BehaviorManager.BM_OfflineSweep
  self._data = {}
end

function OfflineSweepShowBtnDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._redDot = self:GetChild("Back/RedDot")
  self._icon = self:GetChild("Back/Frame/Icon")
  self._titleTxt = self:GetChild("Back/Frame/TitleTxt")
  self._text = self:GetChild("Back/Frame/Text")
  self._effect = self:GetChild("Back/Effect")
  self._icon:Subscribe_PointerClickEvent(self.OpenDetail, self)
  self._effect:SetActive(false)
  self._redDot:SetActive(false)
  self:Init()
end

function OfflineSweepShowBtnDialog:OnDestroy()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function OfflineSweepShowBtnDialog:OnBackBtnClicked()
  self:Destroy()
end

function OfflineSweepShowBtnDialog:Init()
  self._titleTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1854))
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

function OfflineSweepShowBtnDialog:OnRefreshProcessShow()
  self._data.status = self._bm:GetStatus()
  self._effect:SetActive(self._bm:IsCanReceive())
  self._redDot:SetActive(self._bm:IsCanReceive())
  if self._data.status == 1 then
    self._text:SetText(self._bm:GetTimeStr())
  elseif self._data.status == 2 then
    self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1868))
  end
  if self._data.status ~= 1 and self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function OfflineSweepShowBtnDialog:OpenDetail()
  if self._bm:IsCanReceive() then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.creceivesweep")
    csend:Send()
  elseif self._bm:GetStatus() == 1 then
    DialogManager.CreateSingletonDialog("mainline.offlinesweep.offlinesweepdetaildialog"):Init()
  end
end

function OfflineSweepShowBtnDialog:ShowFlashingPrompt()
  if self._bm:IsCanReceive() then
  end
end

return OfflineSweepShowBtnDialog
