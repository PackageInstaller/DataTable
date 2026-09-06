local TabFrame = require("framework.ui.frame.tab.tabframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CLittlebattlePass = BeanManager.GetTableByName("activity.clittlebattlepass")
local GifTofTimeMainDialog = class("GifTofTimeMainDialog", Dialog)
GifTofTimeMainDialog.AssetBundleName = "ui/layouts.battlepassnew"
GifTofTimeMainDialog.AssetName = "BattlePassNewMain"
local BtnType = {
  Dream = 1,
  KillBoss = 2,
  Shop = 3,
  Puzzle = 4,
  Maze = 5
}

function GifTofTimeMainDialog:Ctor(...)
  GifTofTimeMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._btnType = BtnType.Dream
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID)
  self._shopId = DataCommon.GiftofTime.Shop.ShopID
end

function GifTofTimeMainDialog:OnCreate()
  self._cutBtn1_Text = self:GetChild("Cutbtn1/_Text")
  self._cutBtn2_Text = self:GetChild("Cutbtn2/_Text")
  self._cutBtn3_Text = self:GetChild("Cutbtn3/_Text")
  self._cutBtn1_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1930))
  self._cutBtn2_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1931))
  self._cutBtn3_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1932))
  self._ImageBack = self:GetChild("ImageBack")
  local record = CLittlebattlePass:GetRecorder(self._bm:GetCurrentActId())
  if record then
    local imageRecord = CImagePathTable:GetRecorder(record.backImageID) or DataCommon.DefaultImageAsset
    self._ImageBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._cutBtn1 = self:GetChild("Cutbtn1")
  self._cutBtn1RedDot = self:GetChild("Cutbtn1/RedDot")
  self._cutBtn2 = self:GetChild("Cutbtn2")
  self._cutBtn2RedDot = self:GetChild("Cutbtn2/RedDot")
  self._cutBtn3 = self:GetChild("Cutbtn3")
  self._cutBtn3RedDot = self:GetChild("Cutbtn3/RedDot")
  self._cutBtn1RedDot:SetActive(false)
  self._cutBtn2RedDot:SetActive(false)
  self._cutBtn3RedDot:SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._talkText = self:GetChild("Talk1/Text")
  self._panel = self:GetChild("Frame")
  self._frame = TabFrame.Create(self._panel, self)
  self._cutBtn1:Subscribe_PointerClickEvent(self.OnCutBtn1Clicked, self)
  self._cutBtn2:Subscribe_PointerClickEvent(self.OnCutBtn2Clicked, self)
  self._cutBtn3:Subscribe_PointerClickEvent(self.OnCutBtn3Clicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_NewDreamSpiralRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_SWitchInAgainstBossUpLv, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_SReturnAgainstBossInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_NewDreamSpiralTaskRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_RefreshShopInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSeet2Btn, Common.n_OnSOpenBpPuzzle, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSOpenBpPuzzle, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSUnlockBpPuzzle, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_OnSReceivedBpAward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSeet2Btn, Common.n_OnSOpenLabyrinth, nil)
end

function GifTofTimeMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function GifTofTimeMainDialog:Init()
  self._puzzleBM = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)
  self._mazeBM = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  self:RefreshSeet2Btn()
  self:OnCutBtn1Clicked()
  self:RefreshRedDot()
end

function GifTofTimeMainDialog:RefreshSeet2Btn()
  if self._puzzleBM and self._puzzleBM:GetIsOpen() then
    self._cutBtn2_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1956))
  elseif self._mazeBM and self._mazeBM:GetIsOpen() then
    self._cutBtn2_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1976))
  elseif self._bm:IsBossKillOpen() then
    self._cutBtn2_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1931))
  else
    self._cutBtn2_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2037))
  end
end

function GifTofTimeMainDialog:RefreshRedDot(info)
  if info and info.userInfo and info.userInfo == "close" then
    self:OnBackBtnClicked()
    return
  end
  self._cutBtn1RedDot:SetActive(self._bm:HasUntakeAward())
  self._cutBtn2RedDot:SetActive(not self._bm:HasBossKillRedDot() and (not self._puzzleBM or not self._puzzleBM:ShowRedDot()) and self._mazeBM and self._mazeBM:ShowRedDot())
  self._cutBtn3RedDot:SetActive(self._bm:HasFreeGood())
end

function GifTofTimeMainDialog:OnCutBtn1Clicked()
  self._cutBtn1:SetSelected(true)
  self._cutBtn2:SetSelected(false)
  self._cutBtn3:SetSelected(false)
  self._frame:ToPage(BtnType.Dream)
end

function GifTofTimeMainDialog:OnCutBtn2Clicked()
  if not self._bm:IsBossKillOpen() and (not self._puzzleBM or not self._puzzleBM:GetIsOpen()) and (not self._mazeBM or not self._mazeBM:GetIsOpen()) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100479)
    return
  end
  self._cutBtn1:SetSelected(false)
  self._cutBtn2:SetSelected(true)
  self._cutBtn3:SetSelected(false)
  if self._puzzleBM and self._puzzleBM:GetIsOpen() then
    self._frame:ToPage(BtnType.Puzzle)
  elseif self._mazeBM and self._mazeBM:GetIsOpen() then
    self._frame:ToPage(BtnType.Maze)
  else
    self._frame:ToPage(BtnType.KillBoss)
  end
end

function GifTofTimeMainDialog:OnCutBtn3Clicked()
  if not self._bm:IsBossKillOpen() and (not self._puzzleBM or not self._puzzleBM:GetIsOpen()) and (not self._mazeBM or not self._mazeBM:GetIsOpen()) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100479)
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  protocol.shopId = self._shopId
  protocol:Send()
  self._cutBtn1:SetSelected(false)
  self._cutBtn2:SetSelected(false)
  self._cutBtn3:SetSelected(true)
  self._frame:ToPage(BtnType.Shop)
end

function GifTofTimeMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function GifTofTimeMainDialog:CellAtIndex(frame, index)
  if index == BtnType.Dream then
    return "activity.giftoftime.newdreamspiralpage"
  elseif index == BtnType.KillBoss then
    return "activity.giftoftime.killbosspage"
  elseif index == BtnType.Shop then
    return "activity.giftoftime.shopmainpage"
  elseif index == BtnType.Puzzle then
    return "activity.giftoftime.puzzlepage"
  elseif index == BtnType.Maze then
    return "activity.giftoftime.mazepage"
  end
end

function GifTofTimeMainDialog:DidToPage(frame, index)
  if frame == self._frame then
    if index == BtnType.Dream then
      self._frame:GetCellAtIndex(BtnType.Dream):Refresh()
    elseif index == BtnType.KillBoss then
      self._frame:GetCellAtIndex(BtnType.KillBoss):Refresh()
    elseif index == BtnType.Shop then
      self._frame:GetCellAtIndex(BtnType.Shop):RefreshGoodsData()
    elseif index == BtnType.Puzzle then
      self._frame:GetCellAtIndex(BtnType.Puzzle):RefreshData()
    elseif index == BtnType.Maze then
      self._frame:GetCellAtIndex(BtnType.Maze):RefreshData()
    end
    self._btnType = index
  end
end

function GifTofTimeMainDialog:AddNewModal(dialog)
  if dialog._dialogName == "activity.giftoftime.killbosscharacterinfodialog" then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

return GifTofTimeMainDialog
