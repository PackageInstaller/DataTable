-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/swimsuitstorybattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CSRResourceDungeonStage = (BeanManager.GetTableByName)("activity.csrresourcedungeonstage")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitStoryBattleDialog = class("SwimSuitStoryBattleDialog", Dialog)
SwimSuitStoryBattleDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitStoryBattleDialog.AssetName = "ActivitySummer2Storybattle"
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
  -- function num : 0_3 , upvalues : CSRFunction, _ENV, CSRResourceDungeonStage, CRoleLevelCfgTable
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local funectionRecorder = CSRFunction:GetRecorder(data.functionID)
  ;
  (self._name):SetText((TextManager.GetText)(funectionRecorder.tagName))
  ;
  (self._leveltxt):SetText((TextManager.GetText)(funectionRecorder.destribeTextID))
  local levelID = funectionRecorder.levelID
  if levelID ~= 0 then
    local levelRecorder = CSRResourceDungeonStage:GetRecorder(levelID)
    self._spirit = levelRecorder.spirit
    ;
    (self._num):SetText(levelRecorder.spirit)
    local clientBreakLevel = (CRoleLevelCfgTable:GetRecorder(levelRecorder.levelShow)).clientBreakLevel
    local clientLevel = (CRoleLevelCfgTable:GetRecorder(levelRecorder.levelShow)).clientLevel
    ;
    (self._levelnum):SetText(clientLevel)
    ;
    (self._ranknum):SetText(clientBreakLevel)
    self._itemData = {}
    local temp = {tag = "first", itemID = levelRecorder.firstItems, count = levelRecorder.firstItemNums}
    ;
    (table.insert)(self._itemData, temp)
    for i,v in ipairs(levelRecorder.sureDropItems) do
      local temp = {tag = "sure", itemID = v, count = (levelRecorder.sureItemNums)[i]}
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
    if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) then
      ((NekoData.DataManager).DM_Team):ClearSupportRole()
      ;
      ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo("SwimSuitEchoes", self._functionID, self._constructionID)
      local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
      crefreshSupportRoleList:Send()
    else
      do
        ;
        ((NekoData.DataManager).DM_Team):ClearSupportRole()
        local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
        if dialog then
          dialog:SetCopyInfo("SwimSuitEchoes", self._functionID, self._constructionID)
        end
      end
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
  return "activity.swimsuitechoes.swimsuitbattleitemcell"
end

SwimSuitStoryBattleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemData)[index]
end

SwimSuitStoryBattleDialog.OnTipsBtnClicked = function(self)
  -- function num : 0_10 , upvalues : CSRFunction, _ENV
  local funectionRecorder = CSRFunction:GetRecorder(self._functionID)
  local levelID = funectionRecorder.levelID
  if levelID == 0 then
    LogErrorFormat("SwimSuitBattleDialog", "CSRFunction 没有找到配置 functionID = %s ", tostring(self._functionID))
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = levelID
    data.type = "SwimSuitEchoes"
    dialog:Init(data)
  end
end

return SwimSuitStoryBattleDialog

