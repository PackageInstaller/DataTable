local CBossRushStageReward = BeanManager.GetTableByName("dungeonselect.cbossrushstagereward")
local BossStageAwardPanelDialog = class("BossStageAwardPanelDialog", Dialog)
BossStageAwardPanelDialog.AssetBundleName = "ui/layouts.mainline"
BossStageAwardPanelDialog.AssetName = "BossRushReward"
local TableFrame = require("framework.ui.frame.table.tableframe")

function BossStageAwardPanelDialog:Ctor(...)
  BossStageAwardPanelDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function BossStageAwardPanelDialog:OnCreate()
  self._title = self:GetChild("Back2/Title")
  self._frame = self:GetChild("Back2/Frame")
  self._difficultyTxt = self:GetChild("Back2/Difficulty/Txt2")
  self._bossRushWeekTxt = self:GetChild("Back2/BossRushWeekTxt")
  self._helper = TableFrame.Create(self._frame, self, true, true, true)
  self:GetChild("Back2/CloseBtn"):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function BossStageAwardPanelDialog:OnDestroy()
  self._helper:Destroy()
end

function BossStageAwardPanelDialog:Refresh(stagelist, awardGetList, totalPassStage, bossRushId, difficultyLv, name, isWeekBoss)
  self._isWeekBoss = isWeekBoss
  if isWeekBoss then
    self._bossRushWeekTxt:SetActive(true)
    self._bossRushWeekTxt:SetText(TextManager.GetText(1901577))
  else
    self._bossRushWeekTxt:SetActive(false)
  end
  self._title:SetText(name)
  self._difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyStr(difficultyLv, isWeekBoss))
  self._bossRushId = bossRushId
  local getAwardStage = {}
  for _, stageid in pairs(awardGetList) do
    getAwardStage[stageid] = true
  end
  self._awardData = {}
  for index, stageid in pairs(stagelist) do
    local data = {}
    data.stageId = stageid
    if getAwardStage[stageid] then
      data.awardStatus = 2
    elseif totalPassStage >= index then
      data.awardStatus = 1
    else
      data.awardStatus = 0
    end
    table.insert(self._awardData, data)
  end
  self._helper:ReloadAllCell()
  self._helper:MoveToTop()
end

function BossStageAwardPanelDialog:OnBackBtnClicked()
  self:Destroy()
end

function BossStageAwardPanelDialog:NumberOfCell(helper)
  return #self._awardData
end

function BossStageAwardPanelDialog:CellAtIndex(helper, index)
  return "mainline.bossrush.bossstageawardcell"
end

function BossStageAwardPanelDialog:DataAtIndex(helper, index)
  return self._awardData[index]
end

return BossStageAwardPanelDialog
