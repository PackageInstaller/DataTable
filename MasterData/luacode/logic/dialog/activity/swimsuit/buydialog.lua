local UIManager = CS.PixelNeko.UI.UIManager
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CFunctionLevelup = BeanManager.GetTableByName("activity.cfunctionlevelup")
local CHexagonland = BeanManager.GetTableByName("activity.chexagonland")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BuyDialog = class("BuyDialog", Dialog)
BuyDialog.AssetBundleName = "ui/layouts.activitysummer"
BuyDialog.AssetName = "ActivitySummerShopBuy"

function BuyDialog:Ctor(...)
  BuyDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BuyDialog:OnCreate()
  self._item = self:GetChild("Item")
  self._lvText = self:GetChild("Lv")
  self._name = self:GetChild("Name")
  self._detailText = self:GetChild("Detail")
  self._enterBtn = self:GetChild("into")
  self._upgradeBtn = self:GetChild("LevelUp")
  self._enterBtn:Subscribe_PointerClickEvent(self.OnEnterBtnClicked, self)
  self._upgradeBtn:Subscribe_PointerClickEvent(self.OnUpgradeBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function BuyDialog:OnDestroy()
end

function BuyDialog:SetData(data)
  self._shopLevel = data.constructionLevel
  self._eventId = data.functionID
  self._constructionId = data.constructionID
  self._canLevelUp = data.canLevelUp
  local record = CHexagonland:GetRecorder(12)
  local imageRecord = CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
  self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._lvText:SetText(TextManager.GetText(CStringRes:GetRecorder(1597).msgTextID, self._shopLevel))
  self._name:SetText(TextManager.GetText(record.name))
  self._namestr = TextManager.GetText(record.name)
  self._detailText:SetText(TextManager.GetText(record.destribe))
  self._upgradeBtn:SetActive(self._canLevelUp)
end

function BuyDialog:OnEnterBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.csummeractivityevent")
  if protocol then
    protocol.constructionID = self._constructionId
    protocol.eventID = self._eventId
    protocol:Send()
  end
end

function BuyDialog:OnUpgradeBtnClicked()
  local resultRecord
  for _, id in pairs(CFunctionLevelup:GetAllIds()) do
    local record = CFunctionLevelup:GetRecorder(id)
    if record and record.landID == self._constructionId and record.level == self._shopLevel + 1 then
      resultRecord = record
      break
    end
  end
  if resultRecord then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.levelupconfirmdialog")
    if dialog then
      dialog:SetData(resultRecord, self._namestr)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100384)
  end
end

function BuyDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function BuyDialog:OnBackBtnClicked()
  self:Destroy()
end

return BuyDialog
