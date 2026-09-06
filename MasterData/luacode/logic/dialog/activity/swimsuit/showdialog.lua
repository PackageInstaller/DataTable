local UIManager = CS.PixelNeko.UI.UIManager
local CHexagonland = BeanManager.GetTableByName("activity.chexagonland")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ShowDialog = class("ShowDialog", Dialog)
ShowDialog.AssetBundleName = "ui/layouts.activitysummer"
ShowDialog.AssetName = "ActivitySummerShow"

function ShowDialog:Ctor(...)
  ShowDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ShowDialog:OnCreate()
  self._item = self:GetChild("Item")
  self._name = self:GetChild("Title")
  self._detailText = self:GetChild("Detail")
  self._enterBtn = self:GetChild("BuyBtn")
  self._enterBtn:Subscribe_PointerClickEvent(self.OnEnterBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function ShowDialog:OnDestroy()
end

function ShowDialog:SetData(data)
  self._shopLevel = data.constructionLevel
  self._eventId = data.functionID
  self._constructionId = data.constructionID
  local record = CHexagonland:GetRecorder(8)
  local imageRecord = CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
  self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.name))
  self._detailText:SetText(TextManager.GetText(record.destribe))
end

function ShowDialog:OnEnterBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.csummeractivityevent")
  if protocol then
    protocol.constructionID = self._constructionId
    protocol.eventID = self._eventId
    protocol:Send()
  end
end

function ShowDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ShowDialog:OnBackBtnClicked()
  self:Destroy()
end

return ShowDialog
