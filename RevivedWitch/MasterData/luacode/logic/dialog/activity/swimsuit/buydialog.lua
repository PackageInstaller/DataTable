-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/buydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CFunctionLevelup = (BeanManager.GetTableByName)("activity.cfunctionlevelup")
local CHexagonland = (BeanManager.GetTableByName)("activity.chexagonland")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BuyDialog = class("BuyDialog", Dialog)
BuyDialog.AssetBundleName = "ui/layouts.activitysummer"
BuyDialog.AssetName = "ActivitySummerShopBuy"
BuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuyDialog
  ((BuyDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._item = self:GetChild("Item")
  self._lvText = self:GetChild("Lv")
  self._name = self:GetChild("Name")
  self._detailText = self:GetChild("Detail")
  self._enterBtn = self:GetChild("into")
  self._upgradeBtn = self:GetChild("LevelUp")
  ;
  (self._enterBtn):Subscribe_PointerClickEvent(self.OnEnterBtnClicked, self)
  ;
  (self._upgradeBtn):Subscribe_PointerClickEvent(self.OnUpgradeBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

BuyDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BuyDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CHexagonland, CImagePathTable, _ENV, CStringRes
  self._shopLevel = data.constructionLevel
  self._eventId = data.functionID
  self._constructionId = data.constructionID
  self._canLevelUp = data.canLevelUp
  local record = CHexagonland:GetRecorder(12)
  if not CImagePathTable:GetRecorder(record.image) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._lvText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1597)).msgTextID, self._shopLevel))
  ;
  (self._name):SetText((TextManager.GetText)(record.name))
  self._namestr = (TextManager.GetText)(record.name)
  ;
  (self._detailText):SetText((TextManager.GetText)(record.destribe))
  ;
  (self._upgradeBtn):SetActive(self._canLevelUp)
end

BuyDialog.OnEnterBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.csummeractivityevent")
  if protocol then
    protocol.constructionID = self._constructionId
    protocol.eventID = self._eventId
    protocol:Send()
  end
end

BuyDialog.OnUpgradeBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, CFunctionLevelup
  local resultRecord = nil
  for _,id in pairs(CFunctionLevelup:GetAllIds()) do
    local record = CFunctionLevelup:GetRecorder(id)
    if record and record.landID == self._constructionId and record.level == self._shopLevel + 1 then
      resultRecord = record
      break
    end
  end
  do
    if resultRecord then
      local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.levelupconfirmdialog")
      if dialog then
        dialog:SetData(resultRecord, self._namestr)
      end
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100384)
      end
    end
  end
end

BuyDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

BuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return BuyDialog

