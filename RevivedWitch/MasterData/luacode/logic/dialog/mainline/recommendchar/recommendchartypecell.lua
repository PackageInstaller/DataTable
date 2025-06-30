-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/recommendchar/recommendchartypecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBattleTypeCfg = (BeanManager.GetTableByName)("role.cbattletypecfg")
local RecommendCharTypeCell = class("RecommendCharTypeCell", Dialog)
RecommendCharTypeCell.AssetBundleName = "ui/layouts.mainline"
RecommendCharTypeCell.AssetName = "RecommendCharTypeCell"
RecommendCharTypeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendCharTypeCell
  ((RecommendCharTypeCell.super).Ctor)(self, ...)
end

RecommendCharTypeCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Back/Txt1")
end

RecommendCharTypeCell.OnDestroy = function(self)
  -- function num : 0_2
end

RecommendCharTypeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CBattleTypeCfg, _ENV
  local recorder = CBattleTypeCfg:GetRecorder(data)
  if recorder then
    (self._txt):SetText((TextManager.GetText)(recorder.typenameTextID))
  else
    ;
    (self._txt):SetText("")
  end
end

return RecommendCharTypeCell

