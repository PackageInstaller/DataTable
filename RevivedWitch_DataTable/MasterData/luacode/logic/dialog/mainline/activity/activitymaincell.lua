-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/activity/activitymaincell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TypeInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeontype")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RedDotManager = require("logic.redpoint.reddotmanager")
local ActivityMainCell = class("ActivityMainCell", Dialog)
ActivityMainCell.AssetBundleName = "ui/layouts.mainline"
ActivityMainCell.AssetName = "ActivityMainCell"
local Activit = {Fragment = 1, BossRush = 2, Tower = 3, OffLinePvp = 4, UndecidedRoad = 5, SeasonPvp = 7}
ActivityMainCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivityMainCell
  ((ActivityMainCell.super).Ctor)(self, ...)
end

ActivityMainCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._panel = self:GetChild("Panel")
  self._img = self:GetChild("Panel/Map")
  self._grey = self:GetChild("Panel/Grey")
  self._lockTxt = self:GetChild("Panel/LockTxt")
  self._name = self:GetChild("Panel/Title")
  self._back = self:GetChild("Panel/Back")
  self._numPanel = self:GetChild("Panel/Num")
  self._num = self:GetChild("Panel/Num/Num")
  self._maxNumber = self:GetChild("Panel/MaxNum")
  ;
  (self._numPanel):SetActive(false)
  self._redDot = self:GetChild("Panel/RedDot")
  self._openTxt = self:GetChild("Panel/RoadOpenTxt")
  ;
  (self._panel):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshOpenState, Common.n_RefreshUndecidedRoadState, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRed, Common.n_RefreshFragmentPanelRed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRed, Common.n_RefreshUndecidedRoadRedDot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRed, Common.n_SeasonPvpAward, nil)
end

ActivityMainCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ActivityMainCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, ImageTable, Activit
  self._data = data
  ;
  (self._openTxt):SetActive(false)
  ;
  (self._name):SetText((TextManager.GetText)(data.name))
  local imageRecord = ImageTable:GetRecorder(data.imageID)
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.id == Activit.Tower then
    self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Tower)
  else
    if data.id == Activit.BossRush then
      self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BossRush)
    else
      if data.id == Activit.Fragment then
        self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Fragment)
      else
        if data.id == Activit.OffLinePvp then
          self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).OffLinePvp)
        else
          if data.id == Activit.UndecidedRoad then
            self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).UndecidedRoad)
            if ((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonIsOpen() then
              (self._openTxt):SetActive(not self.lock)
              if data.id == Activit.SeasonPvp then
                self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).OffLinePvp)
              end
              ;
              (self._grey):SetActive(self.lock)
              ;
              (self._lockTxt):SetActive(self.lock)
              ;
              (self._lockTxt):SetText((TextManager.GetText)(data.unlockTxt))
              ;
              (self._redDot):SetActive(self:IsReadDotOn())
            end
          end
        end
      end
    end
  end
end

ActivityMainCell.IsReadDotOn = function(self)
  -- function num : 0_4 , upvalues : Activit, _ENV, RedDotManager
  -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P3

  -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P3

  do return ((self._data).id ~= Activit.BossRush or not ((NekoData.BehaviorManager).BM_Game):IsBossPanelShowRed()) and (((self._data).id == Activit.SeasonPvp and (RedDotManager.ShouldSeasonShowRedDot)())) end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ActivityMainCell.OnRefreshRed = function(self)
  -- function num : 0_5
  (self._redDot):SetActive(self:IsReadDotOn())
end

ActivityMainCell.RefreshOpenState = function(self)
  -- function num : 0_6 , upvalues : Activit, _ENV
  if (self._data).id == Activit.UndecidedRoad then
    self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).UndecidedRoad)
    if ((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonIsOpen() then
      (self._openTxt):SetActive(not self.lock)
    end
  end
end

ActivityMainCell.OnCellClicked = function(self)
  -- function num : 0_7
  if not self.lock then
    (self._delegate):OnWorldIClicked((self._data).id)
  end
end

return ActivityMainCell

