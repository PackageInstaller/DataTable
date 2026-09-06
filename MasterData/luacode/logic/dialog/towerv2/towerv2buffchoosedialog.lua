local TowerV2BuffChooseDialog = class("TowerEventBoxTips", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
TowerV2BuffChooseDialog.AssetBundleName = "ui/layouts.stair"
TowerV2BuffChooseDialog.AssetName = "StairBuffChoose"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(60, 1) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(60)
  end
end

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 60 and notification.userInfo.guideStatus == "Start" then
    LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

function TowerV2BuffChooseDialog:Ctor(...)
  TowerV2BuffChooseDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerV2BuffChooseDialog:OnCreate()
  self._frame = self:GetChild("Frame")
  self._countdown = self:GetChild("CountDown")
  self._confirm = self:GetChild("ConfirmButton")
  self._text = {
    desc = self:GetChild("Txt"),
    current = self:GetChild("Num1"),
    delim = self:GetChild("Num2"),
    total = self:GetChild("Num3")
  }
  self._helper = TableFrame.Create(self._frame, self, false, false)
  self._confirm:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuffChoose, Common.n_TowerV2BuffChoice, nil)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
  self._towerv2scenedialog = DialogManager.GetDialog("towerv2.scene.towerv2scenedialog")
  if self._towerv2scenedialog then
    self._towerv2scenedialog:SaveChooseTextActiveStateAndHide()
  end
end

function TowerV2BuffChooseDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._helper:Destroy()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
  end
  if self._towerv2scenedialog then
    self._towerv2scenedialog:RestoreChooseTextActiveState()
  end
end

function TowerV2BuffChooseDialog:SetData(id, candidates, controller, progress)
  self._id = id
  self._candidates = candidates
  self._controller = controller
  self._current = progress or 0
  self:NextChoice()
end

function TowerV2BuffChooseDialog:Refresh(choices)
  self._countdown:SetActive(bm_towerv2:IsInAutoExplore())
  self._choices = choices
  self._helper:ReloadAllCell()
  self._helper:FireEvent("selected", nil)
  self._helper:FireEvent("appear", nil)
  for _, v in pairs(self._text) do
    v:SetActive(#self._candidates ~= 1)
  end
  if #self._candidates ~= 1 then
    self._text.current:SetText(self._current)
    self._text.total:SetText(#self._candidates)
  end
end

function TowerV2BuffChooseDialog:NextChoice()
  self._current = self._current + 1
  if self._current > #self._candidates then
    self:Destroy()
    self._controller:OnBuffChooseFinish(self._id)
  else
    self:Refresh(self._candidates[self._current])
  end
  if bm_towerv2:IsInAutoExplore() then
    self._timeout = 3
    self._countdown:SetText(self._timeout)
    if self._timer then
      GameTimer.RemoveTask(self._timer)
    end
    self._timer = GameTimer.AddTask(1, 1, function()
      self._timeout = self._timeout - 1
      if self._timeout ~= 0 then
        self._countdown:SetText(self._timeout)
      else
        self:OnCellClick(math.min(table.unpack(self._choices)))
        self:OnConfirmClick()
      end
    end)
  end
end

function TowerV2BuffChooseDialog:OnBuffChoose(notification)
  self._clicked = false
  self:NextChoice()
  self._selected = nil
end

function TowerV2BuffChooseDialog:OnConfirmClick()
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
    bm_towerv2:ChooseBuff(self._id or bm_towerv2:GetCurrentFloorID(), self._selected)
  end
  self._clicked = true
end

function TowerV2BuffChooseDialog:OnCellClick(id)
  if self._timer then
    GameTimer.RemoveTask(self._timer)
  end
  self._selected = id
  self._helper:FireEvent("selected", id)
end

function TowerV2BuffChooseDialog:NumberOfCell(helper)
  return #self._choices
end

function TowerV2BuffChooseDialog:CellAtIndex(helper, index)
  return "towerv2.towerv2buffchoosecell"
end

function TowerV2BuffChooseDialog:DataAtIndex(helper, index)
  return self._choices[index]
end

return TowerV2BuffChooseDialog
