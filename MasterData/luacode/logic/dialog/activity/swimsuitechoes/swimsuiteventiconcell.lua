local Item = require("logic.manager.experimental.types.item")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local SwimSuitEventIconCell = class("SwimSuitEventIconCell", Dialog)
SwimSuitEventIconCell.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitEventIconCell.AssetName = "ActivitySummer2BuildingTitle"

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
  self._lockTitle = self:GetChild("LockTitle")
  self._leftTime = self:GetChild("LockTitle/Name")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshFoodStallsStatus, Common.n_OnSOpenEchoSnack, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardStatus, Common.n_OnSOpensummerReward, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAwardStatus, Common.n_OnSOpenChallengeMode, nil)
end

function SwimSuitEventIconCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SwimSuitEventIconCell:RefreshCell(data, delegate)
  self._delegate = delegate
  self._blockId = data.blockId
  self._unlockTime = data.unlockTime
  self._funectionRecorder = nil
  if data.Id then
    self._funectionRecorder = CSRFunction:GetRecorder(data.Id)
    self._type = self._funectionRecorder.type
    self._tagType = self._funectionRecorder.type
    self._tagName = self._funectionRecorder.tagName
  end
  if self._type == 1 or self._type == 2 then
    self._title:SetActive(false)
    self._mainTitle:SetActive(true)
    self._itemTitle:SetActive(false)
    self._mainName:SetText(TextManager.GetText(self._tagName))
  elseif self._type == 3 or self._type == 4 or self._type == 5 or self._type == 6 then
    self._title:SetActive(true)
    self._mainTitle:SetActive(false)
    self._itemTitle:SetActive(false)
    self._name:SetText(TextManager.GetText(self._tagName))
  end
  if self._type == 5 then
    self._redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):GetSnacRedpoint())
  end
  if self._type == 6 then
    self._redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):HasAwardRedDot())
  end
  if self._unlockTime > 0 then
    self._lockTitle:SetActive(true)
    self._leftTime:SetText(NekoData.BehaviorManager.BM_Message:GetString(2105))
  else
    self._lockTitle:SetActive(false)
  end
end

function SwimSuitEventIconCell:OnCellClick()
  self._delegate:OnEventIconClick(self._blockId)
end

function SwimSuitEventIconCell:RefreshFoodStallsStatus(notification)
  if self._type == 5 then
    self._redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):GetSnacRedpoint())
  end
end

function SwimSuitEventIconCell:RefreshAwardStatus(notification)
  if self._type == 6 then
    self._redDot:SetActive(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):HasAwardRedDot())
  end
end

return SwimSuitEventIconCell
