-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/anniversaryshare/mainpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MainPage = class("MainPage", Dialog)
MainPage.AssetBundleName = "ui/layouts.welfare"
MainPage.AssetName = "ActivityShareWelfare"
MainPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainPage
  ((MainPage.super).Ctor)(self, ...)
  self._cellData = {}
end

MainPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backImg = self:GetChild("BackImage/ImageArea/Img")
  self._ruleTxt = self:GetChild("BackImage/Frame/RuleTxt")
  self._nowShareTxt = self:GetChild("BackImage/Frame/TxtFrame/Txt")
  self._detailBtn = self:GetChild("BackImage/Frame/TxtFrame/DetailBtn")
  ;
  (self._detailBtn):Subscribe_PointerClickEvent(self.OnDetailBtnClicked, self)
  self._awardPanel = self:GetChild("BackImage/Frame/Award")
  self._itemCell = self:GetChild("BackImage/Frame/Award/ItemCell")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._itemCellIcon = self:GetChild("BackImage/Frame/Award/ItemCell/_BackGround/Icon")
  self._itemCellFrame = self:GetChild("BackImage/Frame/Award/ItemCell/_BackGround/Frame")
  self._itemCellCount = self:GetChild("BackImage/Frame/Award/ItemCell/_Count")
  self._itemCellGet = self:GetChild("BackImage/Frame/Award/Get")
  self._itemCellEffect = self:GetChild("BackImage/Frame/Award/Effect")
  self._itemPanel = self:GetChild("BackImage/Frame/ItemFrame")
  self._shareBtn = self:GetChild("BackImage/Frame/Btn")
  ;
  (self._shareBtn):Subscribe_PointerClickEvent(self.OnShareBtnClicked, self)
  self._shareBtnTxt = self:GetChild("BackImage/Frame/Btn/Text")
  self._shareBtnTxtRedDot = self:GetChild("BackImage/Frame/Btn/RedDot")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, true)
  self._endText = self:GetChild("BackImage/Frame/ShareBack/EndText")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshData, Common.n_OnSAnniversaryShareInfo, nil)
  self._dm = (NekoData.DataManager).DM_AnniversaryShare
  self._bm = (NekoData.BehaviorManager).BM_AnniversaryShare
  self:SetStaticRes()
end

MainPage.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringres, Item
  (self._ruleTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1984)).msgTextID))
  ;
  (self._shareBtnTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(2042)).msgTextID))
  ;
  (self._endText):SetText((TextManager.GetText)((CStringres:GetRecorder(2082)).msgTextID))
  local itemID, itemNum = (self._bm):GetCShareReward()
  self._item = (Item.Create)(itemID)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._itemCellIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._itemCellFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemCellCount):SetText((NumberManager.GetShowNumber)(itemNum))
end

MainPage.OnDestroy = function(self)
  -- function num : 0_3
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
end

MainPage.RefreshTabCell = function(self)
  -- function num : 0_4
  self:RefreshData()
  ;
  (self._bm):SendCQueryAnniversaryShareInfo()
end

MainPage.RefreshData = function(self)
  -- function num : 0_5 , upvalues : _ENV, CStringres, CImagePathTable
  (self._awardPanel):SetActive((self._bm):GetShareIsOpen())
  ;
  (self._shareBtn):SetActive((self._bm):GetShareIsOpen())
  ;
  (self._endText):SetActive(not (self._bm):GetShareIsOpen())
  ;
  (self._nowShareTxt):SetText((TextManager.GetText)((CStringres:GetRecorder(1983)).msgTextID, (self._bm):GetTotalShare()))
  ;
  (self._shareBtnTxtRedDot):SetActive((self._bm):GetDailyShareAward() == ((self._bm):GetSAnniversaryShareInfoDef()).UNLOCKED)
  if not CImagePathTable:GetRecorder((self._bm):GetPictureID()) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._backImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if (self._bm):GetDailyShareAward() == ((self._bm):GetSAnniversaryShareInfoDef()).UNLOCKED then
    (self._itemCellGet):SetActive(false)
    ;
    (self._itemCellEffect):SetActive(false)
  elseif (self._bm):GetDailyShareAward() == ((self._bm):GetSAnniversaryShareInfoDef()).FETCHED then
    (self._itemCellGet):SetActive(true)
    ;
    (self._itemCellEffect):SetActive(false)
  else
    (self._itemCellGet):SetActive(false)
    ;
    (self._itemCellEffect):SetActive(false)
    LogError("MainPage:RefreshTabCell", "Status Error!")
  end
  for key,_ in pairs(self._cellData) do
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R7 in 'UnsetPending'

    (self._cellData)[key] = nil
  end
  local allIDs = ((self._bm):GetCCumulativeSharingExtraAward()):GetAllIds()
  for _,key in ipairs(allIDs) do
    local record = ((self._bm):GetCCumulativeSharingExtraAward()):GetRecorder(key)
    local remoteData = ((self._bm):GetTotShareAward())[key]
    -- DECOMPILER ERROR at PC156: Confused about usage of register: R10 in 'UnsetPending'

    if remoteData then
      (self._cellData)[key] = {id = key, itemID = (record.rewarditem)[1], itemNum = (record.rewardNum)[1], needNum = record.needNum, status = remoteData, progress = (self._bm):GetNeedProgress(key)}
    else
      LogError("AnniversaryShare MainPage:RefreshTabCell", "remoteData error!")
    end
  end
  ;
  (self._itemFrame):ReloadAllCell()
  local hasPosToMove = false
  for k,v in ipairs(self._cellData) do
    if v.status == ((self._bm):GetSAnniversaryShareInfoDef()).UNLOCKED then
      (self._itemFrame):MoveLeftToIndex(k)
      hasPosToMove = true
      break
    end
  end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

MainPage.OnDetailBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(6)
end

MainPage.OnShareBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("welfare.anniversaryshare.sharefullscreendialog")
end

MainPage.OnItemCellClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

MainPage.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return #self._cellData
end

MainPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  return "welfare.anniversaryshare.itemcell"
end

MainPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return (self._cellData)[index]
end

return MainPage

