-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/alchemylvupdetailstagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyStageEffectsCfg = (BeanManager.GetTableByName)("courtyard.calchemystageeffects")
local AlchemyLvUpDetailStageCell = class("AlchemyLvUpDetailStageCell", Dialog)
AlchemyLvUpDetailStageCell.AssetBundleName = "ui/layouts.yard"
AlchemyLvUpDetailStageCell.AssetName = "AlchemyLevelDetailCell"
AlchemyLvUpDetailStageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AlchemyLvUpDetailStageCell
  ((AlchemyLvUpDetailStageCell.super).Ctor)(self, ...)
end

AlchemyLvUpDetailStageCell.OnCreate = function(self)
  -- function num : 0_1
  self._point = self:GetChild("Cell/LvPoint")
  self._title = self:GetChild("Cell/Title")
  self._lv = self:GetChild("Cell/LVNum")
  self._effectTxt = self:GetChild("Cell/Txt3")
  self._select = self:GetChild("Cell/Select")
end

AlchemyLvUpDetailStageCell.OnDestroy = function(self)
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

AlchemyLvUpDetailStageCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CAlchemyStageEffectsCfg, GetStrByEffectRecorder
  local stageRecorder = data.recorder
  local str = ""
  local num = stageRecorder.id - 1
  for i = 1, num do
    str = str .. "1"
  end
  ;
  (self._point):SetText(str)
  ;
  (self._title):SetText((TextManager.GetText)(stageRecorder.stagenametxtid))
  ;
  (self._lv):SetText(((NekoData.BehaviorManager).BM_Alchemy):GetUnlockAlchemyLvByStage(stageRecorder.id))
  local effectId = stageRecorder.stageeffects
  local recorder = CAlchemyStageEffectsCfg:GetRecorder(effectId)
  if recorder then
    local str = GetStrByEffectRecorder(recorder)
    ;
    (self._effectTxt):SetText(str)
  else
    do
      LogInfoFormat("AlchemyLvUpDetailStageCell", "Cannot find record(effectId: %s, stageId: %s) in CAlchemyStageEffectsCfg", effectId, stageRecorder.id)
      ;
      (self._select):SetActive(data.willUnlock)
    end
  end
end

return AlchemyLvUpDetailStageCell

