local CAlchemyStageEffectsCfg = BeanManager.GetTableByName("courtyard.calchemystageeffects")
local AlchemyLvUpDetailStageCell = class("AlchemyLvUpDetailStageCell", Dialog)
AlchemyLvUpDetailStageCell.AssetBundleName = "ui/layouts.yard"
AlchemyLvUpDetailStageCell.AssetName = "AlchemyLevelDetailCell"

function AlchemyLvUpDetailStageCell:Ctor(...)
  AlchemyLvUpDetailStageCell.super.Ctor(self, ...)
end

function AlchemyLvUpDetailStageCell:OnCreate()
  self._point = self:GetChild("Cell/LvPoint")
  self._title = self:GetChild("Cell/Title")
  self._lv = self:GetChild("Cell/LVNum")
  self._effectTxt = self:GetChild("Cell/Txt3")
  self._select = self:GetChild("Cell/Select")
end

function AlchemyLvUpDetailStageCell:OnDestroy()
end

local function GetStrByEffectRecorder(recorder)
  local str = TextManager.GetText(recorder.stageeffecttxtid)
  local params = {}
  if recorder.stageeffecttype == 1 then
    table.insert(params, recorder.stageeffectparameter1)
  elseif recorder.stageeffecttype == 2 then
    table.insert(params, recorder.stageeffectparameter1 / 10)
  elseif recorder.stageeffecttype == 3 then
    table.insert(params, recorder.stageeffectparameter1)
    table.insert(params, recorder.stageeffectparameter2)
  end
  for i, v in ipairs(params) do
    str = string.gsub(str, "%$parameter" .. i .. "%$", v)
  end
  return str
end

function AlchemyLvUpDetailStageCell:RefreshCell(data)
  local stageRecorder = data.recorder
  local str = ""
  local num = stageRecorder.id - 1
  for i = 1, num do
    str = str .. "1"
  end
  self._point:SetText(str)
  self._title:SetText(TextManager.GetText(stageRecorder.stagenametxtid))
  self._lv:SetText(NekoData.BehaviorManager.BM_Alchemy:GetUnlockAlchemyLvByStage(stageRecorder.id))
  local effectId = stageRecorder.stageeffects
  local recorder = CAlchemyStageEffectsCfg:GetRecorder(effectId)
  if recorder then
    local str = GetStrByEffectRecorder(recorder)
    self._effectTxt:SetText(str)
  else
    LogInfoFormat("AlchemyLvUpDetailStageCell", "Cannot find record(effectId: %s, stageId: %s) in CAlchemyStageEffectsCfg", effectId, stageRecorder.id)
  end
  self._select:SetActive(data.willUnlock)
end

return AlchemyLvUpDetailStageCell
