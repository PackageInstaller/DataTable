-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/showdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CHexagonland = (BeanManager.GetTableByName)("activity.chexagonland")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ShowDialog = class("ShowDialog", Dialog)
ShowDialog.AssetBundleName = "ui/layouts.activitysummer"
ShowDialog.AssetName = "ActivitySummerShow"
ShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShowDialog
  ((ShowDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

ShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._item = self:GetChild("Item")
  self._name = self:GetChild("Title")
  self._detailText = self:GetChild("Detail")
  self._enterBtn = self:GetChild("BuyBtn")
  ;
  (self._enterBtn):Subscribe_PointerClickEvent(self.OnEnterBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

ShowDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ShowDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CHexagonland, CImagePathTable, _ENV
  self._shopLevel = data.constructionLevel
  self._eventId = data.functionID
  self._constructionId = data.constructionID
  local record = CHexagonland:GetRecorder(8)
  if not CImagePathTable:GetRecorder(record.image) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.name))
  ;
  (self._detailText):SetText((TextManager.GetText)(record.destribe))
end

ShowDialog.OnEnterBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.csummeractivityevent")
  if protocol then
    protocol.constructionID = self._constructionId
    protocol.eventID = self._eventId
    protocol:Send()
  end
end

ShowDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

return ShowDialog

