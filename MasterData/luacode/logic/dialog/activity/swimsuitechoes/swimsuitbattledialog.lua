local TableFrame = require("framework.ui.frame.table.tableframe")
local CSRLand = BeanManager.GetTableByName("activity.csrland")
local State = {
  Unlock = 1,
  Lock = 2,
  Repeat = 3
}
local SwimSuitBattleDialog = class("SwimSuitBattleDialog", Dialog)
SwimSuitBattleDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitBattleDialog.AssetName = "ActivitySummer2FullscreenMain"

function SwimSuitBattleDialog:Ctor(...)
  SwimSuitBattleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SwimSuitBattleDialog:OnCreate()
  self._backBtnText = self:GetChild("BackBtn/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._title = self:GetChild("Title")
  self._topGroupPanel = self:GetChild("TopGroup")
  self._centerPanel = self:GetChild("frame")
  self._centerFrame = TableFrame.Create(self._centerPanel, self, false, true)
end

function SwimSuitBattleDialog:OnDestroy()
  if self._centerFrame then
    self._centerFrame:Destroy()
  end
end

function SwimSuitBattleDialog:SetData(data)
  self._functionIDs = data.functionIDs
  self._constructionID = data.constructionID
  self._locked = data.locked
  self._autoExplore = data.autoExplore
  local landRecord = CSRLand:GetRecorder(self._constructionID)
  local backName = landRecord.name
  self._title:SetText(TextManager.GetText(backName))
  self._stateCommon = State
  self._battlesData = {}
  for i, v in ipairs(self._functionIDs) do
    local temp = {
      functionID = v,
      state = State.Unlock,
      constructionID = self._constructionID,
      index = i
    }
    table.insert(self._battlesData, temp)
  end
  for _, v in ipairs(self._locked) do
    if not table.contain(self._functionIDs, v) then
      local temp = {
        functionID = v,
        state = State.Lock,
        constructionID = self._constructionID,
        index = #self._battlesData + 1
      }
      table.insert(self._battlesData, temp)
    else
      for j, k in ipairs(self._battlesData) do
        if k.functionID == v then
          self._battlesData[j].state = State.Lock
        end
      end
    end
  end
  for _, v in ipairs(self._autoExplore) do
    if not table.contain(self._functionIDs, v) then
      local temp = {
        functionID = v,
        state = State.Repeat,
        constructionID = self._constructionID,
        index = #self._battlesData + 1
      }
      table.insert(self._battlesData, temp)
    else
      for j, k in ipairs(self._battlesData) do
        if k.functionID == v then
          self._battlesData[j].state = State.Repeat
        end
      end
    end
  end
  self._centerFrame:ReloadAllCell()
end

function SwimSuitBattleDialog:NumberOfCell(frame)
  return #self._battlesData
end

function SwimSuitBattleDialog:CellAtIndex(frame, index)
  return "activity.swimsuitechoes.resourcedetailcell"
end

function SwimSuitBattleDialog:DataAtIndex(frame, index)
  return self._battlesData[index]
end

function SwimSuitBattleDialog:OnBackBtnClicked()
  self:Destroy()
end

function SwimSuitBattleDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return SwimSuitBattleDialog
