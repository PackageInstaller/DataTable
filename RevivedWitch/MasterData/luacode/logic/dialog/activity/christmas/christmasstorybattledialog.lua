-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasstorybattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CHexagonBattleConfig = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasStoryBattleDialog = class("ChristmasStoryBattleDialog", Dialog)
ChristmasStoryBattleDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasStoryBattleDialog.AssetName = "ActivityChristmasStorybattle"
ChristmasStoryBattleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasStoryBattleDialog
  ((ChristmasStoryBattleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

ChristmasStoryBattleDialog.OnCreate = function(self)
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

ChristmasStoryBattleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChristmasStoryBattleDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CInterfaceFunction, CHexagonBattleConfig, _ENV, CRoleLevelCfgTable
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local funectionRecorder = CInterfaceFunction:GetRecorder(data.functionID)
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
    for i,v in ipairs(battleRecorder.sureDropItems) do
      local temp = {tag = "sure", itemID = v, count = (battleRecorder.sureDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    for i,v in ipairs(battleRecorder.mayDropItems) do
      local temp = {tag = "may", itemID = v, count = (battleRecorder.mayDropItemsNums)[i]}
      ;
      (table.insert)(self._itemData, temp)
    end
    ;
    (self._frame):ReloadAllCell()
  else
    do
      LogErrorFormat("ChristmasStoryBattleDialog", "functionID %s 没有找到战斗", data.functionID)
    end
  end
end

ChristmasStoryBattleDialog.OnCheckbtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, CInterfaceFunction, CChristmasActivityEvent
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID) < self._spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    ;
    ((NekoData.DataManager).DM_Team):ClearSupportRole()
    local type = (CInterfaceFunction:GetRecorder(self._functionID)).type
    do
      if type == CChristmasActivityEvent.COMMON_TOWER then
        local dialog = (DialogManager.CreateSingletonDialog)("activity.christmas.christmaspart2commonbattledteameditdialog")
        if dialog then
          dialog:SetCopyInfo("Christmas", self._functionID, self._constructionID)
        end
        self:OnBackBtnClicked()
        return 
      end
      local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
      if dialog then
        dialog:SetCopyInfo("Christmas", self._functionID, self._constructionID)
      end
    end
  end
end

ChristmasStoryBattleDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ChristmasStoryBattleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  self:Destroy()
end

ChristmasStoryBattleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemData
end

ChristmasStoryBattleDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.christmas.christmasbattleitemcell"
end

ChristmasStoryBattleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemData)[index]
end

ChristmasStoryBattleDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_10 , upvalues : CInterfaceFunction, _ENV
  local funectionRecorder = CInterfaceFunction:GetRecorder(self._functionID)
  if not funectionRecorder then
    LogErrorFormat("ChristmasStoryBattleDialog", "CInterfaceFunction 没有找到配置 functionID = %s ", tostring(self._functionID))
    return 
  end
  local battleID = funectionRecorder.battleID
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = battleID
    data.type = "Christmas"
    dialog:Init(data)
  end
end

return ChristmasStoryBattleDialog

