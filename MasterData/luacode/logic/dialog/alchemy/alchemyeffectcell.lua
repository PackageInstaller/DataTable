local CAlchemyStageEffectsCfg = BeanManager.GetTableByName("courtyard.calchemystageeffects")
local AlchemyEffectCell = class("AlchemyEffectCell", Dialog)
AlchemyEffectCell.AssetBundleName = "ui/layouts.yard"
AlchemyEffectCell.AssetName = "AlchemyMainTxtCell"

function AlchemyEffectCell:Ctor(...)
  AlchemyEffectCell.super.Ctor(self, ...)
end

function AlchemyEffectCell:OnCreate()
  self._effectTxt = self:GetChild("Txt")
end

function AlchemyEffectCell:OnDestroy()
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

function AlchemyEffectCell:RefreshCell(data)
  local str = GetStrByEffectRecorder(data)
  self._effectTxt:SetText(str)
end

return AlchemyEffectCell
