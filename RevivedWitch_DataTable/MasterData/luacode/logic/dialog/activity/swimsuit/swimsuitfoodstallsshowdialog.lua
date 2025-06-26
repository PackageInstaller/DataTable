-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitfoodstallsshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CHexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local Chexagonchatconfig = (BeanManager.GetTableByName)("dialog.chexagonchatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitFoodStallsShowDialog = class("SwimSuitFoodStallsShowDialog", Dialog)
SwimSuitFoodStallsShowDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitFoodStallsShowDialog.AssetName = "ActivitySummerStallsShow"
SwimSuitFoodStallsShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitFoodStallsShowDialog
  ((SwimSuitFoodStallsShowDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SwimSuitFoodStallsShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._item = self:GetChild("BuyBtn")
  self._off = self:GetChild("Item/Off")
  self._on = self:GetChild("Item/On")
  self._detail = self:GetChild("Detail")
  self._title = self:GetChild("Title")
  ;
  (self._off):SetActive(true)
  ;
  (self._on):SetActive(false)
  ;
  (self._item):Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshStatus, Common.n_RefreshFoodStallsStatus, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

SwimSuitFoodStallsShowDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SwimSuitFoodStallsShowDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CHexagonLand, _ENV
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local block = CHexagonLand:GetRecorder(11)
  ;
  (self._title):SetText((TextManager.GetText)(block.name))
  ;
  (self._detail):SetText((TextManager.GetText)(block.destribe))
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copensnackshop")
  if protocol then
    protocol:Send()
    return 
  end
end

SwimSuitFoodStallsShowDialog.RefreshStatus = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):GetSnackData()
  if data.isOpen ~= 1 then
    (self._on):SetActive(next(data) == nil)
    ;
    (self._off):SetActive(data.isOpen == 0)
    ;
    (self._on):SetActive(false)
    ;
    (self._off):SetActive(true)
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

SwimSuitFoodStallsShowDialog.OnCheckbtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.swimsuitfoodstallsdialog")
  if dialog then
    dialog:Init()
  end
  self:Destroy()
end

SwimSuitFoodStallsShowDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

SwimSuitFoodStallsShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return SwimSuitFoodStallsShowDialog

