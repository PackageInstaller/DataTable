local CAlchemyLvCfg = BeanManager.GetTableByName("courtyard.calchemylv")
local CAlchemyStageCfg = BeanManager.GetTableByName("courtyard.calchemystage")
local CAlchemyStageEffectsCfg = BeanManager.GetTableByName("courtyard.calchemystageeffects")
local MaxAlchemyStage = NekoData.BehaviorManager.BM_Alchemy:GetMaxAlchemyStage()
local TableFrame = require("framework.ui.frame.table.tableframe")
local AlchemyLvUpDetailDialog = class("AlchemyLvUpDetailDialog", Dialog)
AlchemyLvUpDetailDialog.AssetBundleName = "ui/layouts.yard"
AlchemyLvUpDetailDialog.AssetName = "AlchemyLevelDetail"

function AlchemyLvUpDetailDialog:Ctor(...)
  AlchemyLvUpDetailDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function AlchemyLvUpDetailDialog:OnCreate()
  self:GetChild("Back/Level/LevelUpBtn"):SetActive(false)
  self._alchemyLv = self:GetChild("Back/Level/LevelBack/LVNum")
  self._curExp = self:GetChild("Back/Level/Loading/Level/Num")
  self._maxExp = self:GetChild("Back/Level/Loading/Level/NumMax")
  self._curLv = self:GetChild("Back/LevelUp/Level/Num")
  self._nextLv = self:GetChild("Back/LevelUp/Level/Num2")
  self._curRate = self:GetChild("Back/LevelUp/Probability/Num")
  self._nextRate = self:GetChild("Back/LevelUp/Probability/Num2")
  self._rateTxt = self:GetChild("Back/LevelUp/Probability/Txt")
  self._rateTxt:SetText(TextManager.GetText(800126))
  self._curLvStagePoint = self:GetChild("Back/LevelUp/Stage/LvPoint1")
  self._nextLvStagePoint = self:GetChild("Back/LevelUp/Stage/LvPoint2")
  self._curLvStageTitle = self:GetChild("Back/LevelUp/Stage/Txt")
  self._nextLvStageTitle = self:GetChild("Back/LevelUp/Stage/Txt2")
  self._stageLvUp = self:GetChild("Back/LevelUp/Stage/Arrow")
  self._costExp = self:GetChild("Back/Txt")
  self._panel = self:GetChild("Back/Frame")
  self._cancleBtn = self:GetChild("Back/CancelBtn")
  self._lvUpBtn = self:GetChild("Back/LevelBtn")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._lvUpBtn:Subscribe_PointerClickEvent(self.OnLvUpBtnClicked, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshAlchemy, Common.n_RefreshAlchemy, nil)
end

function AlchemyLvUpDetailDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function AlchemyLvUpDetailDialog:OnRefreshAlchemy()
  local curAlchemyLv = NekoData.BehaviorManager.BM_Alchemy:GetAlchemyLevel()
  local maxAlchemyLv = NekoData.BehaviorManager.BM_Alchemy:GetMaxAlchemyLevel()
  local curAlchemyExp = NekoData.BehaviorManager.BM_Alchemy:GetAlchemyExp()
  local alchemyRecord = CAlchemyLvCfg:GetRecorder(curAlchemyLv)
  if curAlchemyExp < alchemyRecord.exp or curAlchemyLv >= maxAlchemyLv then
    self:Destroy()
  else
    self:Init()
  end
end

function AlchemyLvUpDetailDialog:Init()
  local alchemyLevel = NekoData.BehaviorManager.BM_Alchemy:GetAlchemyLevel()
  self._alchemyLv:SetText(alchemyLevel)
  local alchemyExp = NekoData.BehaviorManager.BM_Alchemy:GetAlchemyExp()
  self._curExp:SetText(alchemyExp)
  local alchemyRecord = CAlchemyLvCfg:GetRecorder(alchemyLevel)
  self._maxExp:SetText(alchemyRecord.exp)
  self._curLv:SetText(string.gsub(TextManager.GetText(800132), "%$parameter1%$", alchemyLevel))
  local nextLv = alchemyLevel + 1
  local nextLvAlchemyRecord = CAlchemyLvCfg:GetRecorder(nextLv)
  self._nextLv:SetText(string.gsub(TextManager.GetText(800133), "%$parameter1%$", nextLv))
  self._curRate:SetText(string.gsub(TextManager.GetText(800136), "%$parameter1%$", alchemyRecord.byproductProbability .. "%%"))
  self._nextRate:SetText(string.gsub(TextManager.GetText(800134), "%$parameter1%$", nextLvAlchemyRecord.byproductProbability .. "%%"))
  local curStage = alchemyRecord.alchemystage - 1
  local nextStage = nextLvAlchemyRecord.alchemystage - 1
  local pointStr = ""
  for i = 1, MaxAlchemyStage do
    if i <= curStage then
      pointStr = pointStr .. "1"
    else
      pointStr = pointStr .. "0"
    end
  end
  self._curLvStagePoint:SetText(pointStr)
  pointStr = ""
  for i = 1, MaxAlchemyStage do
    if i <= nextStage then
      pointStr = pointStr .. "1"
    else
      pointStr = pointStr .. "0"
    end
  end
  self._nextLvStagePoint:SetText(pointStr)
  local curStageRecorder = CAlchemyStageCfg:GetRecorder(alchemyRecord.alchemystage)
  local nextStageRecorder = CAlchemyStageCfg:GetRecorder(nextLvAlchemyRecord.alchemystage)
  self._curLvStageTitle:SetText(TextManager.GetText(curStageRecorder.stagenametxtid))
  self._nextLvStageTitle:SetText(TextManager.GetText(nextStageRecorder.stagenametxtid))
  self._stageLvUp:SetActive(curStage < nextStage)
  self._costExp:SetText(string.gsub(TextManager.GetText(800127), "%$parameter1%$", alchemyRecord.exp))
  self._data = {}
  local firstWillUnlockEffectCellIndex
  local allIds = CAlchemyStageCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAlchemyStageCfg:GetRecorder(allIds[i])
    local effectId = recorder.stageeffects
    if effectId then
      local effectRecorder = CAlchemyStageEffectsCfg:GetRecorder(effectId)
      if effectRecorder and effectRecorder.stageeffecttype ~= 1 then
        if not firstWillUnlockEffectCellIndex and recorder.id == nextStageRecorder.id then
          firstWillUnlockEffectCellIndex = #self._data + 1
        end
        table.insert(self._data, {
          recorder = recorder,
          willUnlock = recorder.id == nextStageRecorder.id
        })
      end
    end
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  if firstWillUnlockEffectCellIndex then
    self._frame:MoveDownToIndex(firstWillUnlockEffectCellIndex)
  end
end

function AlchemyLvUpDetailDialog:NumberOfCell(frame)
  return #self._data
end

function AlchemyLvUpDetailDialog:CellAtIndex(frame, index)
  return "alchemy.alchemylvupdetailstagecell"
end

function AlchemyLvUpDetailDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function AlchemyLvUpDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

function AlchemyLvUpDetailDialog:OnLvUpBtnClicked()
  local calchemyranklevelup = LuaNetManager.CreateProtocol("protocol.yard.calchemyranklevelup")
  calchemyranklevelup:Send()
end

return AlchemyLvUpDetailDialog
