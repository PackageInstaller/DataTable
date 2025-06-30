-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/xiguadialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CFunctionLevelup = (BeanManager.GetTableByName)("activity.cfunctionlevelup")
local CHexagonland = (BeanManager.GetTableByName)("activity.chexagonland")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local XiGuaDialog = class("XiGuaDialog", Dialog)
XiGuaDialog.AssetBundleName = "ui/layouts.activitysummer"
XiGuaDialog.AssetName = "ActivitySummerXiGuaCell"
XiGuaDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : XiGuaDialog
  ((XiGuaDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

XiGuaDialog.OnCreate = function(self)
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

XiGuaDialog.OnDestroy = function(self)
  -- function num : 0_2
end

XiGuaDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CHexagonland, CImagePathTable, _ENV, CStringRes
  self._constructionLevel = data.constructionLevel
  self._functionIDs = data.functionIDs
  self._constructionId = data.constructionID
  self._canLevelUp = data.canLevelUp
  local record = CHexagonland:GetRecorder(9)
  if not CImagePathTable:GetRecorder(record.image) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._lvText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1597)).msgTextID, self._constructionLevel))
  ;
  (self._name):SetText((TextManager.GetText)(record.name))
  self._namestr = (TextManager.GetText)(record.name)
  ;
  (self._detailText):SetText((TextManager.GetText)(record.destribe))
  ;
  (self._upgradeBtn):SetActive(self._canLevelUp)
end

XiGuaDialog.OnEnterBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialogName = "activity.swimsuit.xiguabattleselectdialog"
  local dialog = (DialogManager.GetDialog)(dialogName)
  if not dialog then
    dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  end
  dialog:SetData({functionIDs = self._functionIDs, constructionID = self._constructionId, constructionLevel = self._constructionLevel})
end

XiGuaDialog.OnUpgradeBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, CFunctionLevelup
  local resultRecord = nil
  for _,id in pairs(CFunctionLevelup:GetAllIds()) do
    local record = CFunctionLevelup:GetRecorder(id)
    if record and record.landID == self._constructionId and record.level == self._constructionLevel + 1 then
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

XiGuaDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

XiGuaDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_SummerActivityCancelBlockSelect, nil, nil)
  self:Destroy()
end

return XiGuaDialog

