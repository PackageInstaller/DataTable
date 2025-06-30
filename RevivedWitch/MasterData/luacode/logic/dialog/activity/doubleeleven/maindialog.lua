-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/doubleeleven/maindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNPCElevenCfg = (BeanManager.GetTableByName)("activity.cnpcelevencfg")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activityeleven"
MainDialog.AssetName = "ActivityElevenMain"
MainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainDialog
  ((MainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

MainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._talkPanel = self:GetChild("Talk")
  self._talkText = self:GetChild("Talk/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._panel = self:GetChild("Frame")
  self._frame = (TabFrame.Create)(self._panel, self)
  self._sheetBtn = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

      (self._sheetBtn)[i] = self:GetChild("Cutbtn" .. tostring(i))
      ;
      ((self._sheetBtn)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSheetBtnClicked(i)
  end
, self)
    end
  end
  self._shopBtnRedDot = self:GetChild("Cutbtn3/RedDot")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._talkPanel):Subscribe_PointerClickEvent(self.OnTalkPanelClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSOpenDoubleElevenActivity, Common.n_OnSOpenDoubleElevenActivity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_1_1 , upvalues : _ENV
    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100410)
    end
  end
, Common.n_OnDoubleElevenActivityEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopRedDot, Common.n_RefreshActivityShopRedDot, nil)
  self:SetData()
  self:OnSheetBtnClicked(1)
  self:OnTalkPanelClicked()
end

MainDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._frame then
    (self._frame):Destroy()
  end
end

MainDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DoubleElevenActivityID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)
  self:RefreshShopRedDot()
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  protocol.shopId = DataCommon.DoubleElevenShopID
  protocol:Send()
end

MainDialog.OnSheetBtnClicked = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  if not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)):GetIsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100410)
    return 
  end
  if index == 2 then
    (self._bm):SendOpenCardSheetProtocol()
  else
    ;
    (self:ToFramePage(index)):SetData()
  end
end

MainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

MainDialog.ToFramePage = function(self, index)
  -- function num : 0_6 , upvalues : _ENV
  self:OnTalkPanelClicked()
  for key,value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  do return (self._frame):ToPage(index) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MainDialog.OnTalkPanelClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV, CNPCElevenCfg
  local randomID = (math.random)(1, #CNPCElevenCfg:GetAllIds())
  local record = CNPCElevenCfg:GetRecorder((CNPCElevenCfg:GetAllIds())[randomID])
  ;
  (self._talkText):SetText((TextManager.GetText)(record.TextID))
end

MainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if index == 1 then
    return "activity.doubleeleven.sheet1"
  else
    if index == 2 then
      return "activity.doubleeleven.sheet2"
    else
      if index == 3 then
        return "activity.doubleeleven.sheet3"
      end
    end
  end
end

MainDialog.OnSOpenDoubleElevenActivity = function(self, notification)
  -- function num : 0_9
  (self:ToFramePage(2)):SetData()
end

MainDialog.RefreshShopRedDot = function(self)
  -- function num : 0_10
  (self._shopBtnRedDot):SetActive((self._bm):GetFreeRedDot())
end

return MainDialog

