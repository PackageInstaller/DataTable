-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversary/levelcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
local FirstLevelId = (CAnniversarylevel:GetAllIds())[1]
local EffectRecord = ((BeanManager.GetTableByName)("dungeonselect.canniversaryspecialcfg")):GetRecorder(2)
local LevelCell = class("LevelCell", Dialog)
LevelCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
LevelCell.AssetName = "Activity1YearAnniversaryCell"
LevelCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelCell, _ENV
  ((LevelCell.super).Ctor)(self, ...)
  self._bm = (NekoData.BehaviorManager).BM_Anniversary
end

LevelCell.OnCreate = function(self)
  -- function num : 0_1
  (self:GetChild("1")):SetActive(true)
  self._normal = self:GetChild("1/LevelBack")
  self._normal_icon = self:GetChild("1/LevelBack/LevelIn")
  self._normal_name = self:GetChild("1/LevelBack/Back/Name")
  self._select = self:GetChild("1/SelectBack")
  self._select_icon = self:GetChild("1/SelectBack/LevelIn")
  self._select_name = self:GetChild("1/SelectBack/Back/Name")
  self._limit = self:GetChild("1/Lock")
  self._limit_txt = self:GetChild("1/Lock/Txt")
  self._new = self:GetChild("1/New")
  self._title = self:GetChild("1/Title")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

LevelCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._handler then
    ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
end

LevelCell.SetData = function(self, delegate, data)
  -- function num : 0_3 , upvalues : LevelStateEnum, _ENV, CImagePathTable, FirstLevelId, EffectRecord
  self._delegate = delegate
  self._data = data
  self._levelId = (data.data).levelId
  self._status = (data.data).status
  if self._status == LevelStateEnum.LOCK then
    (self._normal):SetActive(true)
    ;
    (self._select):SetActive(false)
    ;
    (self._limit):SetActive(false)
    ;
    (self._new):SetActive(false)
  else
    if self._levelId == (self._delegate)._selectLevelId then
      (self._normal):SetActive(false)
      ;
      (self._select):SetActive(true)
    else
      ;
      (self._normal):SetActive(true)
      ;
      (self._select):SetActive(false)
    end
    ;
    (self._limit):SetActive(false)
    if self._status ~= LevelStateEnum.PASSED then
      (self._new):SetActive(true)
      if self._status == LevelStateEnum.UNSTART then
        (self._limit):SetActive(true)
        local levelStartStr = (string.sub)((data.record).levelstart, 6, 16)
        local monthStr = (string.sub)(levelStartStr, 1, 2)
        local dayStr = (string.sub)(levelStartStr, 4, 5)
        local hourStr = (string.sub)(levelStartStr, 7, -1)
        local str = (string.gsub)((TextManager.GetText)(1900882), "%$parameter1%$", tonumber(monthStr))
        str = (string.gsub)(str, "%$parameter2%$", tonumber(dayStr))
        str = (string.gsub)(str, "%$parameter3%$", hourStr)
        ;
        (self._limit_txt):SetText(str)
      end
    else
      do
        ;
        (self._new):SetActive(false)
        ;
        (self._title):SetText((TextManager.GetText)((data.record).leveltitle))
        ;
        (self._normal_name):SetText((TextManager.GetText)((data.record).levelname))
        ;
        (self._select_name):SetText((TextManager.GetText)((data.record).levelname))
        if not CImagePathTable:GetRecorder((data.record).levelpicselect) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._select_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        if not CImagePathTable:GetRecorder((data.record).levelpicgrey) then
          imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._normal_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        if (self._bm):IsPlayGuideClickEffect() and self._levelId == FirstLevelId and not self._handler and EffectRecord and EffectRecord.type ~= "" and EffectRecord.type ~= "0" then
          self._handler = ((NekoData.BehaviorManager).BM_Game):CreateGuideClickEffectDialog(self._rootWindow, tonumber(EffectRecord.type))
        end
        if self._handler then
          ((NekoData.BehaviorManager).BM_Game):DestroyGuideClickEffectDialog(self._handler)
          self._handler = nil
        end
      end
    end
  end
end

LevelCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SelectLevelById(self._levelId)
end

LevelCell.OnEvent = function(self, eventName)
  -- function num : 0_5
  if eventName == "SetSelected" then
    if self._levelId == (self._delegate)._selectLevelId then
      (self._normal):SetActive(false)
      ;
      (self._select):SetActive(true)
      self:PlayAnimation()
    else
      ;
      (self._normal):SetActive(true)
      ;
      (self._select):SetActive(false)
    end
  end
end

LevelCell.PlayAnimation = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local nodeStr = tostring(((self._data).record).levelanim)
  ;
  (self._rootWindow):PlayAnimation("ActivityStarCell1")
end

return LevelCell

