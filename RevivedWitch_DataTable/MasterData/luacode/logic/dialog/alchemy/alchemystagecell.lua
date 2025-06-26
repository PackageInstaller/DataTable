-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/alchemystagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyStageEffectsCfg = (BeanManager.GetTableByName)("courtyard.calchemystageeffects")
local AlchemyStageCell = class("AlchemyStageCell", Dialog)
AlchemyStageCell.AssetBundleName = "ui/layouts.yard"
AlchemyStageCell.AssetName = "AlchemyStageCell"
AlchemyStageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AlchemyStageCell
  ((AlchemyStageCell.super).Ctor)(self, ...)
end

AlchemyStageCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._point = self:GetChild("Panel/LvPoint")
  self._title = self:GetChild("Panel/Title")
  self._lv = self:GetChild("Panel/LVNum")
  self._effectTxt = self:GetChild("Panel/Txt3")
  self._unLockEffectTxt = self:GetChild("Panel/Txt2")
  ;
  (self._unLockEffectTxt):SetText((TextManager.GetText)(800113))
end

AlchemyStageCell.OnDestroy = function(self)
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

AlchemyStageCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CAlchemyStageEffectsCfg, GetStrByEffectRecorder
  local str = ""
  local num = data.id - 1
  for i = 1, num do
    str = str .. "1"
  end
  ;
  (self._point):SetText(str)
  ;
  (self._title):SetText((TextManager.GetText)(data.stagenametxtid))
  ;
  (self._lv):SetText(((NekoData.BehaviorManager).BM_Alchemy):GetUnlockAlchemyLvByStage(data.id))
  local effectId = data.stageeffects
  local recorder = CAlchemyStageEffectsCfg:GetRecorder(effectId)
  if recorder then
    local str = GetStrByEffectRecorder(recorder)
    ;
    (self._effectTxt):SetText(str)
  else
    do
      LogInfoFormat("AlchemyStageCell", "Cannot find record(effectId: %s, stageId: %s) in CAlchemyStageEffectsCfg", effectId, data.id)
    end
  end
end

return AlchemyStageCell

