-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/firefly/fireflylevelupdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CFireflylvupCfg = (BeanManager.GetTableByName)("courtyard.cfireflylvup")
local FireflyLevelUpDialog = class("FireflyLevelUpDialog", Dialog)
FireflyLevelUpDialog.AssetBundleName = "ui/layouts.yard"
FireflyLevelUpDialog.AssetName = "YardLightLevelUp"
FireflyLevelUpDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FireflyLevelUpDialog
  ((FireflyLevelUpDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._items = {}
  self._gameTimerID = nil
end

FireflyLevelUpDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._curLevelTxt = self:GetChild("Back/Level/LevelNum1")
  self._nextLevelTxt = self:GetChild("Back/Level/LevelNum2")
  self._curEffectTxt = self:GetChild("Back/Effect/Frame/Txt1")
  self._nextEffectTxt = self:GetChild("Back/Effect/Frame/Txt1/Arrow/Txt2")
  self._itemsPanel = self:GetChild("Back/Condition/Frame")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._curEffectWidth = (self._curEffectTxt):GetDeltaSize()
  self._nextEffectWidth = (self._nextEffectTxt):GetDeltaSize()
  self._itemsFrame = (TableFrame.Create)(self._itemsPanel, self, false, false)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self:Init()
end

FireflyLevelUpDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._gameTimerID then
    (GameTimer.RemoveTask)(self._gameTimerID)
    self._gameTimerID = nil
  end
  ;
  (self._itemsFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

FireflyLevelUpDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CFireflylvupCfg
  local curLv = ((NekoData.BehaviorManager).BM_Firefly):GetFireflyLevel()
  ;
  (self._curLevelTxt):SetText(curLv)
  local nextLv = curLv + 1
  ;
  (self._nextLevelTxt):SetText(nextLv)
  local record = CFireflylvupCfg:GetRecorder(curLv)
  if record then
    (self._curEffectTxt):SetText(record.num)
    local textWidth, textHeight = (self._curEffectTxt):GetPreferredSize()
    ;
    (self._curEffectTxt):SetDeltaSize(textWidth, self._curEffectHeight)
  end
  do
    record = CFireflylvupCfg:GetRecorder(nextLv)
    if record then
      (self._nextEffectTxt):SetText(record.num)
      local textWidth, textHeight = (self._nextEffectTxt):GetPreferredSize()
      ;
      (self._nextEffectTxt):SetDeltaSize(textWidth, self._nextEffectHeight)
    end
    do
      local list = (string.split)(record.items, "@")
      ;
      (table.insert)(self._items, {id = tonumber(list[1]), num = tonumber(list[2])})
      self._enough = true
      for i,v in ipairs(self._items) do
        local haveNum = 0
        if (string.sub)(v.id, 1, 2) == "35" then
          haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(v.id)
        else
          haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v.id)
        end
        if haveNum < v.num then
          self._enough = false
          break
        end
      end
      do
        ;
        (self._itemsFrame):ReloadAllCell()
        local width, height = (self._itemsPanel):GetRectSize()
        local cellPanelWidth = width / 3 * #self._items
        local cellPanelHeight = (self._itemsFrame):GetTotalLength()
        local rootWindowAnchoredx, rootWindowAnchoredy = (self._itemsPanel):GetAnchoredPosition()
        ;
        (self._itemsPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
        ;
        (self._itemsPanel):SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
        ;
        (self._itemsFrame):ReloadAllCell()
      end
    end
  end
end

FireflyLevelUpDialog.NumberOfCell = function(self)
  -- function num : 0_4
  return #self._items
end

FireflyLevelUpDialog.CellAtIndex = function(self)
  -- function num : 0_5
  return "magictree.buildinglevelupitemcell"
end

FireflyLevelUpDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._items)[index]
end

FireflyLevelUpDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

FireflyLevelUpDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._enough then
    local cglowwormCapacityLv = (LuaNetManager.CreateProtocol)("protocol.yard.cglowwormcapacitylv")
    cglowwormCapacityLv:Send()
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100220)
      if not self._gameTimerID then
        self._gameTimerID = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_8_0 , upvalues : self
    (self._itemsFrame):FireEvent("ShowTips")
  end
)
      end
    end
  end
end

return FireflyLevelUpDialog

