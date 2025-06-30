-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/rankbosscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RankBossCell = class("RankBossCell", Dialog)
RankBossCell.AssetBundleName = "ui/layouts.activitystar"
RankBossCell.AssetName = "ActivityStarRankBossCell"
RankBossCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RankBossCell
  ((RankBossCell.super).Ctor)(self, ...)
end

RankBossCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  self._difficultyBack = self:GetChild("Difficulty")
  self._difficultyTxt = self:GetChild("Difficulty/Txt")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RankBossCell.OnDestroy = function(self)
  -- function num : 0_2
end

RankBossCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder(data.tapimageid) then
    local image = DataCommon.DefaultImageAsset
  end
  ;
  (self._img):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(data.nametextid))
  ;
  (self._select):SetActive(data.id == (self._delegate)._tabType)
  ;
  (self._difficultyTxt):SetText((TextManager.GetText)(data.rankingmarktxt))
  if not CImagePathTable:GetRecorder(data.rankingmarkpic) then
    image = DataCommon.DefaultImageAsset
  end
  ;
  (self._difficultyBack):SetSprite(image.assetBundle, image.assetName)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

RankBossCell.OnCellClicked = function(self)
  -- function num : 0_4
  if (self._cellData).id == (((self._delegate)._typeData).tabTypeEnum)[(((self._delegate)._typeData).type).Easy] then
    (self._delegate):SetType((self._delegate)._activityId, (((self._delegate)._typeData).type).Easy)
  else
    if (self._cellData).id == (((self._delegate)._typeData).tabTypeEnum)[(((self._delegate)._typeData).type).Hard] then
      (self._delegate):SetType((self._delegate)._activityId, (((self._delegate)._typeData).type).Hard)
    end
  end
end

RankBossCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self._cellData).id ~= (self._delegate)._tabType then
    (self._select):SetActive(eventName ~= "ChooseBossRush")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return RankBossCell

