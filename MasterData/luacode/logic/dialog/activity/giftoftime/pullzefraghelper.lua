local PullzeFragHelper = class("PullzeFragHelper")

function PullzeFragHelper:Ctor(rootElement, indexNum)
  self._rootElement = rootElement
  self._indexNum = indexNum
  self._rootElement:Subscribe_PointerClickEvent(self.OnRootClicked, self)
  self._num = self._rootElement:FindChild("Num")
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
end

function PullzeFragHelper:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function PullzeFragHelper:RefreshCell(data)
  self._data = data
  self._rootElement:SetActive(not self._data.isOpen)
  self._num:SetText(NekoData.BehaviorManager.BM_Message:GetString(1962, {
    self._data.moneyNum
  }))
end

function PullzeFragHelper:OnRootClicked()
  if not self._data.isOpen then
    if NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.WitchSeal) >= self._data.moneyNum then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(144, {
        self._data.moneyNum
      }, function()
        self._bm:SendCUnlockBpPuzzle(self._indexNum)
      end, {}, nil, {})
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100482)
    end
  end
end

return PullzeFragHelper
