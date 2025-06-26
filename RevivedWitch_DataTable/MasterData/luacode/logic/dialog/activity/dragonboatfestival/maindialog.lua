-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/dragonboatfestival/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activityspringouting"
MainDialog.AssetName = "ActivitySpringOutingMain"
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainDialog
  ((MainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._talkText = self:GetChild("Talk/Text")
  self._sheetBtn = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

      (self._sheetBtn)[i] = self:GetChild("Cutbtn" .. tostring(i))
      ;
      ((self._sheetBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSheetBtnClicked(i)
  end
, self)
    end
  end
  self._sheetBtn1Text = self:GetChild("Cutbtn1/Text")
  self._sheetBtn2Text = self:GetChild("Cutbtn2/Text")
  self._sheetBtn2RedDot = self:GetChild("Cutbtn2/RedDot")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_OnLocalRefreshDragonBoatFestivalRedpoint, nil)
  self:SetStaticRes()
  self:SetData()
  self:OnSheetBtnClicked(1)
end

MainDialog.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringres
  (self._sheetBtn1Text):SetText((TextManager.GetText)((CStringres:GetRecorder(1974)).msgTextID))
  ;
  (self._sheetBtn2Text):SetText((TextManager.GetText)((CStringres:GetRecorder(1815)).msgTextID))
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_3
  if self._frame then
    (self._frame):Destroy()
  end
end

MainDialog.SetData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self:RefreshRedDot()
end

MainDialog.OnSheetBtnClicked = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  if index == 1 then
    (self:ToFramePage(1)):SetData()
  else
    if not (self._bm):GetShopIsOpen() then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100469)
      return 
    end
    ;
    (self._bm):SendCGetShopInfo()
  end
end

MainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

MainDialog.ToFramePage = function(self, index)
  -- function num : 0_7 , upvalues : _ENV
  for key,value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  self:SwitchTalkText()
  do return (self._frame):ToPage(index) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if index == 1 then
    return "activity.dragonboatfestival.sheet1"
  else
    if index == 2 then
      return "activity.dragonboatfestival.sheet2"
    end
  end
end

MainDialog.RefreshRedDot = function(self)
  -- function num : 0_9
  (self._sheetBtn2RedDot):SetActive((self._bm):GetRedDot(1))
end

MainDialog.OpenShop = function(self, shopID)
  -- function num : 0_10
  (self:ToFramePage(2)):SetData(shopID)
end

MainDialog.OnSDragonBoatFestivalInfo = function(self)
  -- function num : 0_11
end

MainDialog.SwitchTalkText = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local toShowTalkId = -1
  local talkIdCfg = (self._bm):GetCActivitySpringOutingCfg()
  if (self._bm):GetWishIsOpen() then
    if self._randomTalkIdList == nil then
      self._randomTalkIdList = {}
      local allIds = talkIdCfg:GetAllIds()
      for i = 2, #allIds do
        (table.insert)(self._randomTalkIdList, (talkIdCfg:GetRecorder(i)).TextID)
      end
    end
    do
      do
        local randomId = (math.random)(#self._randomTalkIdList)
        toShowTalkId = (self._randomTalkIdList)[randomId]
        toShowTalkId = (talkIdCfg:GetRecorder((talkIdCfg:GetAllIds())[1])).TextID
        ;
        (self._talkText):SetText((TextManager.GetText)(toShowTalkId))
      end
    end
  end
end

return MainDialog

