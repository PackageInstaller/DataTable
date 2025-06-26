-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasstoryendscoredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CInterEntry = (BeanManager.GetTableByName)("dungeonselect.cinterentry")
local CChrisfinal = (BeanManager.GetTableByName)("dungeonselect.cchrisfinal")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasStoryEndScoreDialog = class("ChristmasStoryEndScoreDialog", Dialog)
ChristmasStoryEndScoreDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasStoryEndScoreDialog.AssetName = "ActivityChristmasEndScore"
ChristmasStoryEndScoreDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasStoryEndScoreDialog, _ENV
  ((ChristmasStoryEndScoreDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)
end

ChristmasStoryEndScoreDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._charChip = self:GetChild("Back/CharChip")
  self._name = self:GetChild("Back/Name")
  self._levelImg = self:GetChild("Level")
  self._nums = {}
  for i = 1, 3 do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

    (self._nums)[i] = {}
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._nums)[i]).Num = self:GetChild("NumBack" .. i .. "/Num")
  end
  self._sing = self:GetChild("NumBack1/Sing")
  self._show = self:GetChild("NumBack2/Show")
  self._jump = self:GetChild("NumBack3/Jump")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, false, false)
  self._getBtn = self:GetChild("GetBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateConstructionEvent, Common.n_OnSUpdateChristmasConstructionEvent, nil)
end

ChristmasStoryEndScoreDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
  end
end

ChristmasStoryEndScoreDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CChrisfinal, CImagePathTable
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local currencyItem = (Item.Create)(DataCommon.ChristmasSing)
  ;
  (self._sing):SetText(currencyItem:GetName())
  local currencyItem = (Item.Create)(DataCommon.ChristmasExpressiveForce)
  ;
  (self._show):SetText(currencyItem:GetName())
  local currencyItem = (Item.Create)(DataCommon.ChristmasJump)
  ;
  (self._jump):SetText(currencyItem:GetName())
  ;
  (((self._nums)[1]).Num):SetText((self._bm):GetScoreByType(DataCommon.ChristmasSing))
  ;
  (((self._nums)[2]).Num):SetText((self._bm):GetScoreByType(DataCommon.ChristmasExpressiveForce))
  ;
  (((self._nums)[3]).Num):SetText((self._bm):GetScoreByType(DataCommon.ChristmasJump))
  local recorder = CChrisfinal:GetRecorder(self._functionID)
  self._itemData = {}
  if recorder then
    for i,v in ipairs(recorder.collectbonus) do
      local temp = {tag = "item", itemID = v, count = (recorder.collectbonusnum)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._name):SetText((TextManager.GetText)(recorder.textID))
    if not CImagePathTable:GetRecorder(recorder.picid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._charChip):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._getBtn):SetInteractable(recorder.type == 1)
  else
    LogErrorFormat("ChristmasStoryEndScoreDialog", "CChrisfinal NO Exist Id %s", self._functionID)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ChristmasStoryEndScoreDialog.OnGetBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cchristmasactivityevent")
  csend.constructionID = self._constructionID
  csend.eventID = self._functionID
  csend:Send()
end

ChristmasStoryEndScoreDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

ChristmasStoryEndScoreDialog.OnSUpdateConstructionEvent = function(self, notification)
  -- function num : 0_6 , upvalues : CInterEntry, _ENV
  if self._constructionID and CInterEntry:GetRecorder(self._constructionID) then
    local recorder = CInterEntry:GetRecorder(self._constructionID)
    local pos = recorder.posId
    for _,event in ipairs((notification.userInfo).updates) do
      if next(event.events) ~= nil then
        local recorder = CInterEntry:GetRecorder(event.construction)
        if pos == recorder.posId then
          self:SetData({functionID = (event.events)[1], constructionID = event.construction})
          break
        end
      end
    end
  end
end

ChristmasStoryEndScoreDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemData
end

ChristmasStoryEndScoreDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.christmas.christmasbattleitemcell"
end

ChristmasStoryEndScoreDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemData)[index]
end

return ChristmasStoryEndScoreDialog

