-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/alchemyeffectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyStageEffectsCfg = (BeanManager.GetTableByName)("courtyard.calchemystageeffects")
local AlchemyEffectCell = class("AlchemyEffectCell", Dialog)
AlchemyEffectCell.AssetBundleName = "ui/layouts.yard"
AlchemyEffectCell.AssetName = "AlchemyMainTxtCell"
AlchemyEffectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AlchemyEffectCell
  ((AlchemyEffectCell.super).Ctor)(self, ...)
end

AlchemyEffectCell.OnCreate = function(self)
  -- function num : 0_1
  self._effectTxt = self:GetChild("Txt")
end

AlchemyEffectCell.OnDestroy = function(self)
  -- function num : 0_2
end

local GetStrByEffectRecorder = function(recorder)
  -- function num : 0_3 , upvalues : _ENV
  local str = (TextManager.GetText)(recorder.stageeffecttxtid)
  local params = {}
  if recorder.stageeffecttype == 1 then
    (table.insert)(params, recorder.stageeffectparameter1)
  else
    if recorder.stageeffecttype == 2 then
      (table.insert)(params, recorder.stageeffectparameter1 / 10)
    else
      if recorder.stageeffecttype == 3 then
        (table.insert)(params, recorder.stageeffectparameter1)
        ;
        (table.insert)(params, recorder.stageeffectparameter2)
      end
    end
  end
  for i,v in ipairs(params) do
    str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
  end
  return str
end

AlchemyEffectCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : GetStrByEffectRecorder
  local str = GetStrByEffectRecorder(data)
  ;
  (self._effectTxt):SetText(str)
end

return AlchemyEffectCell

