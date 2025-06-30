-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2buffchoosedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2BuffChooseDialog = class("TowerEventBoxTips", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
TowerV2BuffChooseDialog.AssetBundleName = "ui/layouts.stair"
TowerV2BuffChooseDialog.AssetName = "StairBuffChoose"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(60, 1) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(60)
  end
end

local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV, FinishGuide
  local guideId = (notification.userInfo).guideID
  if guideId == 60 and (notification.userInfo).guideStatus == "Start" then
    (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

TowerV2BuffChooseDialog.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : TowerV2BuffChooseDialog
  ((TowerV2BuffChooseDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2BuffChooseDialog.OnCreate = function(self)
  -- function num : 0_3 , upvalues : TableFrame, _ENV, HandleGuideStatusChanged
  self._frame = self:GetChild("Frame")
  self._countdown = self:GetChild("CountDown")
  self._confirm = self:GetChild("ConfirmButton")
  self._text = {desc = self:GetChild("Txt"), current = self:GetChild("Num1"), delim = self:GetChild("Num2"), total = self:GetChild("Num3")}
  self._helper = (TableFrame.Create)(self._frame, self, false, false)
  ;
  (self._confirm):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuffChoose, Common.n_TowerV2BuffChoice, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
  self._towerv2scenedialog = (DialogManager.GetDialog)("towerv2.scene.towerv2scenedialog")
  if self._towerv2scenedialog then
    (self._towerv2scenedialog):SaveChooseTextActiveStateAndHide()
  end
end

TowerV2BuffChooseDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._helper):Destroy()
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
  if self._towerv2scenedialog then
    (self._towerv2scenedialog):RestoreChooseTextActiveState()
  end
end

TowerV2BuffChooseDialog.SetData = function(self, id, candidates, controller, progress)
  -- function num : 0_5
  self._id = id
  self._candidates = candidates
  self._controller = controller
  self._current = progress or 0
  self:NextChoice()
end

TowerV2BuffChooseDialog.Refresh = function(self, choices)
  -- function num : 0_6 , upvalues : bm_towerv2, _ENV
  (self._countdown):SetActive(bm_towerv2:IsInAutoExplore())
  self._choices = choices
  ;
  (self._helper):ReloadAllCell()
  ;
  (self._helper):FireEvent("selected", nil)
  ;
  (self._helper):FireEvent("appear", nil)
  for _,v in pairs(self._text) do
    v:SetActive(#self._candidates ~= 1)
  end
  if #self._candidates ~= 1 then
    ((self._text).current):SetText(self._current)
    ;
    ((self._text).total):SetText(#self._candidates)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

TowerV2BuffChooseDialog.NextChoice = function(self)
  -- function num : 0_7 , upvalues : bm_towerv2, _ENV
  self._current = self._current + 1
  if #self._candidates < self._current then
    self:Destroy()
    ;
    (self._controller):OnBuffChooseFinish(self._id)
  else
    self:Refresh((self._candidates)[self._current])
  end
  if bm_towerv2:IsInAutoExplore() then
    self._timeout = 3
    ;
    (self._countdown):SetText(self._timeout)
    if self._timer then
      (GameTimer.RemoveTask)(self._timer)
    end
    self._timer = (GameTimer.AddTask)(1, 1, function()
    -- function num : 0_7_0 , upvalues : self, _ENV
    self._timeout = self._timeout - 1
    if self._timeout ~= 0 then
      (self._countdown):SetText(self._timeout)
    else
      self:OnCellClick((math.min)((table.unpack)(self._choices)))
      self:OnConfirmClick()
    end
  end
)
  end
end

TowerV2BuffChooseDialog.OnBuffChoose = function(self, notification)
  -- function num : 0_8
  self._clicked = false
  self:NextChoice()
  self._selected = nil
end

TowerV2BuffChooseDialog.OnConfirmClick = function(self)
  -- function num : 0_9 , upvalues : bm_towerv2
  if self._clicked then
    return 
  end
  if not self._selected then
    return 
  end
  local state = bm_towerv2:GetState()
  if state == "reset" or state == "buffchoose" then
    bm_towerv2:ChooseBuff(self._current, self._selected)
  else
    if not self._id then
      bm_towerv2:ChooseBuff(bm_towerv2:GetCurrentFloorID(), self._selected)
      self._clicked = true
    end
  end
end

TowerV2BuffChooseDialog.OnCellClick = function(self, id)
  -- function num : 0_10 , upvalues : _ENV
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
  self._selected = id
  ;
  (self._helper):FireEvent("selected", id)
end

TowerV2BuffChooseDialog.NumberOfCell = function(self, helper)
  -- function num : 0_11
  return #self._choices
end

TowerV2BuffChooseDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_12
  return "towerv2.towerv2buffchoosecell"
end

TowerV2BuffChooseDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_13
  return (self._choices)[index]
end

return TowerV2BuffChooseDialog

