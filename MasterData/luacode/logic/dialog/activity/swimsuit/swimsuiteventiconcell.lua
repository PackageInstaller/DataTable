-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuiteventiconcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CSummerActivityEvent = require("protocols.def.protocol.activity.csummeractivityevent")
local CHexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CHexagonBattleConfig = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
local CHexagonChatConfig = (BeanManager.GetTableByName)("dialog.chexagonchatconfig")
local SwimSuitEventIconCell = class("SwimSuitEventIconCell", Dialog)
SwimSuitEventIconCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitEventIconCell.AssetName = "ActivitySummerBuildingTitle"
SwimSuitEventIconCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitEventIconCell
  ((SwimSuitEventIconCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

SwimSuitEventIconCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
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
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFoodStallsStatus, Common.n_RefreshFoodStallsStatus, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBlockClick, Common.n_COnBlockClick, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSUpdateSummerConstruction, Common.n_SUpdateSummerConstruction, nil)
end

SwimSuitEventIconCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SwimSuitEventIconCell.RefreshCell = function(self, data, delegate)
  -- function num : 0_3 , upvalues : CHexagonFunction, _ENV, CSummerActivityEvent, Item
  self._delegate = delegate
  self._blockId = data.blockId
  ;
  (self._redcanlevelupEffect):SetActive(false)
  ;
  (self._bluecanlevelupEffect):SetActive(false)
  ;
  (self._itemcanlevelupEffect):SetActive(false)
  local funectionRecorder = CHexagonFunction:GetRecorder(data.Id)
  local type = funectionRecorder.type
  self._type = type
  local tagType = funectionRecorder.tagType
  self._tagType = tagType
  local tagName = funectionRecorder.tagName
  local tagItem = funectionRecorder.tagItem
  if tagType == 1 then
    (self._title):SetActive(false)
    ;
    (self._mainTitle):SetActive(true)
    ;
    (self._itemTitle):SetActive(false)
    ;
    (self._redcanlevelupEffect):SetActive(data.canLevelUp)
    ;
    (self._mainName):SetText((TextManager.GetText)(tagName))
  else
    if tagType == 2 then
      (self._title):SetActive(true)
      ;
      (self._mainTitle):SetActive(false)
      ;
      (self._itemTitle):SetActive(false)
      ;
      (self._bluecanlevelupEffect):SetActive(data.canLevelUp)
      ;
      (self._name):SetText((TextManager.GetText)(tagName))
      if type == CSummerActivityEvent.SUMMER_SNACK then
        (self._redDot):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):GetSnacRedpoint())
      end
    else
      if tagType == 3 then
        (self._title):SetActive(false)
        ;
        (self._mainTitle):SetActive(false)
        ;
        (self._itemTitle):SetActive(true)
        ;
        (self._itemcanlevelupEffect):SetActive(data.canLevelUp)
        local imageRecord = ((Item.Create)(tagItem)):GetIcon()
        ;
        (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
    end
  end
end

SwimSuitEventIconCell.OnCellClick = function(self)
  -- function num : 0_4
  (self._delegate):OnEventIconClick(self._blockId)
end

SwimSuitEventIconCell.RefreshFoodStallsStatus = function(self, notification)
  -- function num : 0_5 , upvalues : CSummerActivityEvent, _ENV
  if self._type == CSummerActivityEvent.SUMMER_SNACK and self._tagType == 2 then
    (self._redDot):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):GetSnacRedpoint())
  end
end

SwimSuitEventIconCell.OnBlockClick = function(self, notification)
  -- function num : 0_6
  local blockID = notification.userInfo
end

SwimSuitEventIconCell.OnSUpdateSummerConstruction = function(self, notification)
  -- function num : 0_7
  if notification.result == 0 then
    return 
  end
  local construction = (notification.userInfo).construction
  if construction.ID ~= self._blockId then
    return 
  end
  local canLevelUp = construction.canlvup == 1
  if self._tagType == 1 then
    (self._redcanlevelupEffect):SetActive(canLevelUp)
  elseif self._tagType == 2 then
    (self._bluecanlevelupEffect):SetActive(canLevelUp)
  elseif self._tagType == 3 then
    (self._itemcanlevelupEffect):SetActive(canLevelUp)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

return SwimSuitEventIconCell

