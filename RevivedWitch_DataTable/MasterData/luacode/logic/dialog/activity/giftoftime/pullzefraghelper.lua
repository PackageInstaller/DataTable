-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/pullzefraghelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PullzeFragHelper = class("PullzeFragHelper")
PullzeFragHelper.Ctor = function(self, rootElement, indexNum)
  -- function num : 0_0 , upvalues : _ENV
  self._rootElement = rootElement
  self._indexNum = indexNum
  ;
  (self._rootElement):Subscribe_PointerClickEvent(self.OnRootClicked, self)
  self._num = (self._rootElement):FindChild("Num")
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
end

PullzeFragHelper.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

PullzeFragHelper.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self._data = data
  ;
  (self._rootElement):SetActive(not (self._data).isOpen)
  ;
  (self._num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1962, {(self._data).moneyNum}))
end

PullzeFragHelper.OnRootClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not (self._data).isOpen then
    if (self._data).moneyNum <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.WitchSeal) then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(144, {(self._data).moneyNum}, function()
    -- function num : 0_3_0 , upvalues : self
    (self._bm):SendCUnlockBpPuzzle(self._indexNum)
  end
, {}, nil, {})
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100482)
    end
  end
end

return PullzeFragHelper

