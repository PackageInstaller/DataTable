local Item = require("logic.manager.experimental.types.item")
local CSummerActivityEvent = require("protocols.def.protocol.activity.csummeractivityevent")
local CHexagonFunction = BeanManager.GetTableByName("activity.chexagonfunction")
local CHexagonBattleConfig = BeanManager.GetTableByName("dungeonselect.chexagonbattleconfig")
local CHexagonChatConfig = BeanManager.GetTableByName("dialog.chexagonchatconfig")
local SwimSuitEventIconCell = class("SwimSuitEventIconCell", Dialog)
SwimSuitEventIconCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitEventIconCell.AssetName = "ActivitySummerBuildingTitle"

function SwimSuitEventIconCell:Ctor(...)
  SwimSuitEventIconCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function SwimSuitEventIconCell:OnCreate()
  self._title = self:GetChild("Ttle")
  self._name = self:GetChild("Ttle/Name")
  self._redDot = self:GetChild("Ttle/RedDot")
  self._mainTitle = self:GetChild("MianTitle")
  self._mainName = self:GetChild("MianTitle/Name")
  self._itemTitle = self:GetChild("ItemTitle")
  self._itemIcon = self:GetChild("ItemTitle/Back/Item")
  self._redcanlevelupEffect = self:GetChild("Ttle/UI_TX_jiantou 1")
  self._bluecanlevelupEffect = self:GetChild("MianTitle/UI_TX_jiantou 1")
  self._itemcanlevelupEffect = self:GetChild("ItemTitle/UI_TX_jiantou 1")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshFoodStallsStatus, Common.n_RefreshFoodStallsStatus, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBlockClick, Common.n_COnBlockClick, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateSummerConstruction, Common.n_SUpdateSummerConstruction, nil)
end

function SwimSuitEventIconCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SwimSuitEventIconCell:RefreshCell(data, delegate)
  self._delegate = delegate
  self._blockId = data.blockId
  self._redcanlevelupEffect:SetActive(false)
  self._bluecanlevelupEffect:SetActive(false)
  self._itemcanlevelupEffect:SetActive(false)
  local funectionRecorder = CHexagonFunction:GetRecorder(data.Id)
  local type = funectionRecorder.type
  self._type = type
  local tagType = funectionRecorder.tagType
  self._tagType = tagType
  local tagName = funectionRecorder.tagName
  local tagItem = funectionRecorder.tagItem
  if tagType == 1 then
    self._title:SetActive(false)
    self._mainTitle:SetActive(true)
    self._itemTitle:SetActive(false)
    self._redcanlevelupEffect:SetActive(data.canLevelUp)
    self._mainName:SetText(TextManager.GetText(tagName))
  elseif tagType == 2 then
    self._title:SetActive(true)
    self._mainTitle:SetActive(false)
    self._itemTitle:SetActive(false)
    self._bluecanlevelupEffect:SetActive(data.canLevelUp)
    self._name:SetText(TextManager.GetText(tagName))
    if type == CSummerActivityEvent.SUMMER_SNACK then
      self._redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):GetSnacRedpoint())
    end
  elseif tagType == 3 then
    self._title:SetActive(false)
    self._mainTitle:SetActive(false)
    self._itemTitle:SetActive(true)
    self._itemcanlevelupEffect:SetActive(data.canLevelUp)
    local imageRecord = Item.Create(tagItem):GetIcon()
    self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

function SwimSuitEventIconCell:OnCellClick()
  self._delegate:OnEventIconClick(self._blockId)
end

function SwimSuitEventIconCell:RefreshFoodStallsStatus(notification)
  if self._type == CSummerActivityEvent.SUMMER_SNACK and self._tagType == 2 then
    self._redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):GetSnacRedpoint())
  end
end

function SwimSuitEventIconCell:OnBlockClick(notification)
  local blockID = notification.userInfo
end

function SwimSuitEventIconCell:OnSUpdateSummerConstruction(notification)
  if notification.result == 0 then
    return
  end
  local construction = notification.userInfo.construction
  if construction.ID ~= self._blockId then
    return
  end
  local canLevelUp = construction.canlvup == 1
  if self._tagType == 1 then
    self._redcanlevelupEffect:SetActive(canLevelUp)
  elseif self._tagType == 2 then
    self._bluecanlevelupEffect:SetActive(canLevelUp)
  elseif self._tagType == 3 then
    self._itemcanlevelupEffect:SetActive(canLevelUp)
  end
end

return SwimSuitEventIconCell
