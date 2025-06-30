-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitstorybattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CHexagonFunction = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CHexagonChatConfig = (BeanManager.GetTableByName)("dialog.chexagonchatconfig")
local CHexagonBattleConfig = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitStoryBattleDialog = class("SwimSuitStoryBattleDialog", Dialog)
SwimSuitStoryBattleDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitStoryBattleDialog.AssetName = "ActivitySummerStorybattle"
SwimSuitStoryBattleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitStoryBattleDialog
  ((SwimSuitStoryBattleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SwimSuitStoryBattleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._checkbtn = self:GetChild("Checkbtn")
  self._panel = self:GetChild("frame")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("LineBack/Num")
  self._leveltxt = self:GetChild("LevelTxt")
  self._levelnum = self:GetChild("Battlelevel/levelnum")
  self._ranknum = self:GetChild("Battlelevel/Ranknum")
  self._tips = self:GetChild("Tips")
  ;
  (self._tips):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._frame = (TableFrame.Create)(self._panel, self, false)
  ;
  (self._checkbtn):Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

SwimSuitStoryBattleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

SwimSuitStoryBattleDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CHexagonFunction, CHexagonBattleConfig, _ENV, CRoleLevelCfgTable
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local funectionRecorder = CHexagonFunction:GetRecorder(data.functionID)
  local battleID = funectionRecorder.battleID
  if battleID ~= 0 then
    local battleRecorder = CHexagonBattleConfig:GetRecorder(battleID)
    ;
    (self._name):SetText((TextManager.GetText)(battleRecorder.leveltitle))
    self._spirit = battleRecorder.spirit
    ;
    (self._num):SetText(battleRecorder.spirit)
    ;
    (self._leveltxt):SetText((TextManager.GetText)(battleRecorder.levelinfo))
    local clientBreakLevel = (CRoleLevelCfgTable:GetRecorder(battleRecorder.suggestlevel)).clientBreakLevel
    local clientLevel = (CRoleLevelCfgTable:GetRecorder(battleRecorder.suggestlevel)).clientLevel
    ;
    (self._levelnum):SetText(clientLevel)
    ;
    (self._ranknum):SetText(clientBreakLevel)
    self._itemData = {}
    for i,v in ipairs(battleRecorder.firstItems) do
      local temp = {tag = "first", itemID = v, count = (battleRecorder.firstItemNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    for i,v in ipairs(battleRecorder.mayDropItems) do
      local temp = {tag = "may", itemID = v, count = (battleRecorder.mayDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    for i,v in ipairs(battleRecorder.sureDropItems) do
      local temp = {tag = "sure", itemID = v, count = (battleRecorder.sureDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    ;
    (self._frame):ReloadAllCell()
  else
    do
      LogErrorFormat("SwimSuitBattleDialog", "functionID %s 没有找到战斗", data.functionID)
    end
  end
end

SwimSuitStoryBattleDialog.OnCheckbtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < self._spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    ;
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo("SwimSuit", self._functionID, self._constructionID)
    end
  end
end

SwimSuitStoryBattleDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

SwimSuitStoryBattleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

SwimSuitStoryBattleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemData
end

SwimSuitStoryBattleDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.swimsuit.swimsuitbattleitemcell"
end

SwimSuitStoryBattleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemData)[index]
end

SwimSuitStoryBattleDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_10 , upvalues : CHexagonFunction, _ENV
  local funectionRecorder = CHexagonFunction:GetRecorder(self._functionID)
  if not funectionRecorder then
    LogErrorFormat("SwimSuitBattleDialog", "CHexagonFunction 没有找到配置 functionID = %s ", tostring(self._functionID))
    return 
  end
  local battleID = funectionRecorder.battleID
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = battleID
    data.type = "SwimStit"
    dialog:Init(data)
  end
end

return SwimSuitStoryBattleDialog

