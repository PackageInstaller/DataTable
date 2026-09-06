local UIManager = CS.PixelNeko.UI.UIManager
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CSRResourceDungeonStage = BeanManager.GetTableByName("activity.csrresourcedungeonstage")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitStoryBattleDialog = class("SwimSuitStoryBattleDialog", Dialog)
SwimSuitStoryBattleDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitStoryBattleDialog.AssetName = "ActivitySummer2Storybattle"

function SwimSuitStoryBattleDialog:Ctor(...)
  SwimSuitStoryBattleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SwimSuitStoryBattleDialog:OnCreate()
  self._checkbtn = self:GetChild("Checkbtn")
  self._panel = self:GetChild("frame")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("LineBack/Num")
  self._leveltxt = self:GetChild("LevelTxt")
  self._levelnum = self:GetChild("Battlelevel/levelnum")
  self._ranknum = self:GetChild("Battlelevel/Ranknum")
  self._tips = self:GetChild("Tips")
  self._tips:Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._frame = TableFrame.Create(self._panel, self, false)
  self._checkbtn:Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function SwimSuitStoryBattleDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function SwimSuitStoryBattleDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local funectionRecorder = CSRFunction:GetRecorder(data.functionID)
  self._name:SetText(TextManager.GetText(funectionRecorder.tagName))
  self._leveltxt:SetText(TextManager.GetText(funectionRecorder.destribeTextID))
  local levelID = funectionRecorder.levelID
  if levelID ~= 0 then
    local levelRecorder = CSRResourceDungeonStage:GetRecorder(levelID)
    self._spirit = levelRecorder.spirit
    self._num:SetText(levelRecorder.spirit)
    local clientBreakLevel = CRoleLevelCfgTable:GetRecorder(levelRecorder.levelShow).clientBreakLevel
    local clientLevel = CRoleLevelCfgTable:GetRecorder(levelRecorder.levelShow).clientLevel
    self._levelnum:SetText(clientLevel)
    self._ranknum:SetText(clientBreakLevel)
    self._itemData = {}
    local temp = {
      tag = "first",
      itemID = levelRecorder.firstItems,
      count = levelRecorder.firstItemNums
    }
    table.insert(self._itemData, temp)
    for i, v in ipairs(levelRecorder.sureDropItems) do
      local temp = {
        tag = "sure",
        itemID = v,
        count = levelRecorder.sureItemNums[i]
      }
      table.insert(self._itemData, temp)
    end
    self._frame:ReloadAllCell()
  else
    LogErrorFormat("SwimSuitBattleDialog", "functionID %s 没有找到战斗", data.functionID)
  end
end

function SwimSuitStoryBattleDialog:OnCheckbtnClicked()
  if self._spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  elseif NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) then
    NekoData.DataManager.DM_Team:ClearSupportRole()
    NekoData.BehaviorManager.BM_Team:SaveTeamEditCopyInfo("SwimSuitEchoes", self._functionID, self._constructionID)
    local crefreshSupportRoleList = LuaNetManager.CreateProtocol("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  else
    NekoData.DataManager.DM_Team:ClearSupportRole()
    local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo("SwimSuitEchoes", self._functionID, self._constructionID)
    end
  end
end

function SwimSuitStoryBattleDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function SwimSuitStoryBattleDialog:OnBackBtnClicked()
  self:Destroy()
end

function SwimSuitStoryBattleDialog:NumberOfCell(frame)
  return #self._itemData
end

function SwimSuitStoryBattleDialog:CellAtIndex(frame, index)
  return "activity.swimsuitechoes.swimsuitbattleitemcell"
end

function SwimSuitStoryBattleDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

function SwimSuitStoryBattleDialog:OnTipsBtnClicked()
  local funectionRecorder = CSRFunction:GetRecorder(self._functionID)
  local levelID = funectionRecorder.levelID
  if levelID == 0 then
    LogErrorFormat("SwimSuitBattleDialog", "CSRFunction 没有找到配置 functionID = %s ", tostring(self._functionID))
    return
  end
  local dialog = DialogManager.CreateSingletonDialog("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = levelID
    data.type = "SwimSuitEchoes"
    dialog:Init(data)
  end
end

return SwimSuitStoryBattleDialog
