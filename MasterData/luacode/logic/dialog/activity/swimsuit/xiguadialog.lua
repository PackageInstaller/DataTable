local UIManager = CS.PixelNeko.UI.UIManager
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CFunctionLevelup = BeanManager.GetTableByName("activity.cfunctionlevelup")
local CHexagonland = BeanManager.GetTableByName("activity.chexagonland")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local XiGuaDialog = class("XiGuaDialog", Dialog)
XiGuaDialog.AssetBundleName = "ui/layouts.activitysummer"
XiGuaDialog.AssetName = "ActivitySummerXiGuaCell"

function XiGuaDialog:Ctor(...)
  XiGuaDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function XiGuaDialog:OnCreate()
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

function XiGuaDialog:OnDestroy()
end

function XiGuaDialog:SetData(data)
  self._constructionLevel = data.constructionLevel
  self._functionIDs = data.functionIDs
  self._constructionId = data.constructionID
  self._canLevelUp = data.canLevelUp
  local record = CHexagonland:GetRecorder(9)
  local imageRecord = CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
  self._item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._lvText:SetText(TextManager.GetText(CStringRes:GetRecorder(1597).msgTextID, self._constructionLevel))
  self._name:SetText(TextManager.GetText(record.name))
  self._namestr = TextManager.GetText(record.name)
  self._detailText:SetText(TextManager.GetText(record.destribe))
  self._upgradeBtn:SetActive(self._canLevelUp)
end

function XiGuaDialog:OnEnterBtnClicked()
  local dialogName = "activity.swimsuit.xiguabattleselectdialog"
  local dialog = DialogManager.GetDialog(dialogName)
  dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
  dialog:SetData({
    functionIDs = self._functionIDs,
    constructionID = self._constructionId,
    constructionLevel = self._constructionLevel
  })
end

function XiGuaDialog:OnUpgradeBtnClicked()
  local resultRecord
  for _, id in pairs(CFunctionLevelup:GetAllIds()) do
    local record = CFunctionLevelup:GetRecorder(id)
    if record and record.landID == self._constructionId and record.level == self._constructionLevel + 1 then
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

function XiGuaDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function XiGuaDialog:OnBackBtnClicked()
  LuaNotificationCenter.PostNotification(Common.n_SummerActivityCancelBlockSelect, nil, nil)
  self:Destroy()
end

return XiGuaDialog
