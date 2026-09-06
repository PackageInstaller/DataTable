local CStringres = BeanManager.GetTableByName("message.cstringres")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local MainDialog = class("MainDialog", Dialog)
MainDialog.AssetBundleName = "ui/layouts.activityspringouting"
MainDialog.AssetName = "ActivitySpringOutingMain"

function MainDialog:Ctor(...)
  MainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function MainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._talkText = self:GetChild("Talk/Text")
  self._sheetBtn = {}
  for i = 1, 2 do
    self._sheetBtn[i] = self:GetChild("Cutbtn" .. tostring(i))
    self._sheetBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnSheetBtnClicked(i)
    end, self)
  end
  self._sheetBtn1Text = self:GetChild("Cutbtn1/Text")
  self._sheetBtn2Text = self:GetChild("Cutbtn2/Text")
  self._sheetBtn2RedDot = self:GetChild("Cutbtn2/RedDot")
  LuaNotificationCenter.AddObserver(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnLocalRefreshDragonBoatFestivalRedpoint, nil)
  self:SetStaticRes()
  self:SetData()
  self:OnSheetBtnClicked(1)
end

function MainDialog:SetStaticRes()
  self._sheetBtn1Text:SetText(TextManager.GetText(CStringres:GetRecorder(1974).msgTextID))
  self._sheetBtn2Text:SetText(TextManager.GetText(CStringres:GetRecorder(1815).msgTextID))
end

function MainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
end

function MainDialog:SetData()
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self:RefreshRedDot()
end

function MainDialog:OnSheetBtnClicked(index)
  if index == 1 then
    self:ToFramePage(1):SetData()
  else
    if not self._bm:GetShopIsOpen() then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100469)
      return
    end
    self._bm:SendCGetShopInfo()
  end
end

function MainDialog:OnBackBtnClicked()
  self:Destroy()
end

function MainDialog:ToFramePage(index)
  for key, value in pairs(self._sheetBtn) do
    value:SetSelected(key == index)
  end
  self:SwitchTalkText()
  return self._frame:ToPage(index)
end

function MainDialog:CellAtIndex(frame, index)
  if index == 1 then
    return "activity.dragonboatfestival.sheet1"
  elseif index == 2 then
    return "activity.dragonboatfestival.sheet2"
  end
end

function MainDialog:RefreshRedDot()
  self._sheetBtn2RedDot:SetActive(self._bm:GetRedDot(1))
end

function MainDialog:OpenShop(shopID)
  self:ToFramePage(2):SetData(shopID)
end

function MainDialog:OnSDragonBoatFestivalInfo()
end

function MainDialog:SwitchTalkText()
  local toShowTalkId = -1
  local talkIdCfg = self._bm:GetCActivitySpringOutingCfg()
  if self._bm:GetWishIsOpen() then
    if self._randomTalkIdList == nil then
      self._randomTalkIdList = {}
      local allIds = talkIdCfg:GetAllIds()
      for i = 2, #allIds do
        table.insert(self._randomTalkIdList, talkIdCfg:GetRecorder(i).TextID)
      end
    end
    local randomId = math.random(#self._randomTalkIdList)
    toShowTalkId = self._randomTalkIdList[randomId]
  else
    toShowTalkId = talkIdCfg:GetRecorder(talkIdCfg:GetAllIds()[1]).TextID
  end
  self._talkText:SetText(TextManager.GetText(toShowTalkId))
end

return MainDialog
