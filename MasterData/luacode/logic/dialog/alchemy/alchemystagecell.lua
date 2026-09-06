local CAlchemyStageEffectsCfg = BeanManager.GetTableByName("courtyard.calchemystageeffects")
local AlchemyStageCell = class("AlchemyStageCell", Dialog)
AlchemyStageCell.AssetBundleName = "ui/layouts.yard"
AlchemyStageCell.AssetName = "AlchemyStageCell"

function AlchemyStageCell:Ctor(...)
  AlchemyStageCell.super.Ctor(self, ...)
end

function AlchemyStageCell:OnCreate()
  self._point = self:GetChild("Panel/LvPoint")
  self._title = self:GetChild("Panel/Title")
  self._lv = self:GetChild("Panel/LVNum")
  self._effectTxt = self:GetChild("Panel/Txt3")
  self._unLockEffectTxt = self:GetChild("Panel/Txt2")
  self._unLockEffectTxt:SetText(TextManager.GetText(800113))
end

function AlchemyStageCell:OnDestroy()
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

function AlchemyStageCell:RefreshCell(data)
  local str = ""
  local num = data.id - 1
  for i = 1, num do
    str = str .. "1"
  end
  self._point:SetText(str)
  self._title:SetText(TextManager.GetText(data.stagenametxtid))
  self._lv:SetText(NekoData.BehaviorManager.BM_Alchemy:GetUnlockAlchemyLvByStage(data.id))
  local effectId = data.stageeffects
  local recorder = CAlchemyStageEffectsCfg:GetRecorder(effectId)
  if recorder then
    local str = GetStrByEffectRecorder(recorder)
    self._effectTxt:SetText(str)
  else
    LogInfoFormat("AlchemyStageCell", "Cannot find record(effectId: %s, stageId: %s) in CAlchemyStageEffectsCfg", effectId, data.id)
  end
end

return AlchemyStageCell
