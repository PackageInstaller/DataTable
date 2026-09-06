local CNPCElevenCfg = BeanManager.GetTableByName("activity.cnpcelevencfg")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activityeleven"
MainDialog.AssetName = "ActivityElevenMain"

function MainDialog:Ctor(...)
  MainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function MainDialog:OnCreate()
  self._talkPanel = self:GetChild("Talk")
  self._talkText = self:GetChild("Talk/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._sheetBtn = {}
  for i = 1, 3 do
    self._sheetBtn[i] = self:GetChild("Cutbtn" .. tostring(i))
    self._sheetBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnSheetBtnClicked(i)
    end, self)
  end
  self._shopBtnRedDot = self:GetChild("Cutbtn3/RedDot")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._talkPanel:Subscribe_PointerClickEvent(self.OnTalkPanelClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSOpenDoubleElevenActivity, Common.n_OnSOpenDoubleElevenActivity, nil)
  LuaNotificationCenter.AddObserver(self, function()
    if GlobalGameFSM:GetCurrentState() ~= "Dungeon" then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100410)
    end
  end, Common.n_OnDoubleElevenActivityEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshShopRedDot, Common.n_RefreshActivityShopRedDot, nil)
  self:SetData()
  self:OnSheetBtnClicked(1)
  self:OnTalkPanelClicked()
end

function MainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function MainDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DoubleElevenActivityID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DoubleElevenActivityID)
  self:RefreshShopRedDot()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  protocol.shopId = DataCommon.DoubleElevenShopID
  protocol:Send()
end

function MainDialog:OnSheetBtnClicked(index)
  if not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DoubleElevenActivityID):GetIsOpen() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100410)
    return
  end
  if index == 2 then
    self._bm:SendOpenCardSheetProtocol()
  else
    self:ToFramePage(index):SetData()
  end
end

function MainDialog:OnBackBtnClicked()
  self:Destroy()
end

function MainDialog:ToFramePage(index)
  self:OnTalkPanelClicked()
  for key, value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  return self._frame:ToPage(index)
end

function MainDialog:OnTalkPanelClicked()
  local randomID = math.random(1, #CNPCElevenCfg:GetAllIds())
  local record = CNPCElevenCfg:GetRecorder(CNPCElevenCfg:GetAllIds()[randomID])
  self._talkText:SetText(TextManager.GetText(record.TextID))
end

function MainDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "activity.doubleeleven.sheet1"
  elseif index == 2 then
    return "activity.doubleeleven.sheet2"
  elseif index == 3 then
    return "activity.doubleeleven.sheet3"
  end
end

function MainDialog:OnSOpenDoubleElevenActivity(notification)
  self:ToFramePage(2):SetData()
end

function MainDialog:RefreshShopRedDot()
  self._shopBtnRedDot:SetActive(self._bm:GetFreeRedDot())
end

return MainDialog
