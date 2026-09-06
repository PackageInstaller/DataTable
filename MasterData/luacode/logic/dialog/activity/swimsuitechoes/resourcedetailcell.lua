local TableFrame = require("framework.ui.frame.table.tableframe")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CSRResourceDungeonStage = BeanManager.GetTableByName("activity.csrresourcedungeonstage")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local ResourceDetailCell = class("ResourceDetailCell", Dialog)
ResourceDetailCell.AssetBundleName = "ui/layouts.activitysummer2"
ResourceDetailCell.AssetName = "ActivitySummer2ResourceDetail"

function ResourceDetailCell:Ctor(...)
  ResourceDetailCell.super.Ctor(self, ...)
  self._itemData = {}
end

function ResourceDetailCell:OnCreate()
  self._name = self:GetChild("DetailBack/LevelName")
  self.recomLevel = self:GetChild("DetailBack/Detail1/Txt2")
  self._breakNumTxt = self:GetChild("DetailBack/Detail1/BreakNumTxt")
  self._breakLevelBack = self:GetChild("DetailBack/Detail1/BreakLevelBack")
  self._ibtn = self:GetChild("DetailBack/Ibtn")
  self._ibtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._detailText = self:GetChild("DetailBack/Detail2/Txt")
  self._cellPanel = self:GetChild("DetailBack/CellPanel")
  self._cellFrame = TableFrame.Create(self._cellPanel, self, false, false)
  self._txt2 = self:GetChild("DetailBack/CostBack/Txt2")
  self._goBtn = self:GetChild("DetailBack/GoBtn")
  self._autoBtn = self:GetChild("DetailBack/AutoBtn")
  self._dispatchBtn = self:GetChild("DetailBack/DispatchBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._autoBtn:Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  self._dispatchBtn:Subscribe_PointerClickEvent(self.OnDisPatchBtnClicked, self)
  self._autoBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AutoExplore))
  self._dispatchBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.OffLineSweep))
  self._lockMask = self:GetChild("Lock")
  self._lockMaskText = self:GetChild("Lock/Text")
end

function ResourceDetailCell:OnDestroy()
  if self._cellPanel then
    self._cellFrame:Destroy()
  end
end

function ResourceDetailCell:RefreshCell(data)
  self._stateCommon = self._delegate._stateCommon
  self._data = data
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  self._lockMask:SetActive(self._data.state == self._stateCommon.Lock)
  local csrRecorder = CSRFunction:GetRecorder(self._data.functionID)
  if csrRecorder.levelID == 0 then
    LogError("ResourceDetailCell:RefreshCell", "csrRecorder.levelID == 0")
    self._lockMask:SetActive(true)
    return
  end
  self._autoBtn:SetInteractable(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):HasFinishBlockBattle(self._constructionID, self._functionID))
  self._dispatchBtn:SetInteractable(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):HasFinishBlockBattle(self._constructionID, self._functionID))
  self._levelRecorder = CSRResourceDungeonStage:GetRecorder(csrRecorder.levelID)
  self._spirit = self._levelRecorder.spirit
  self._txt2:SetText(self._spirit)
  self._lockMaskText:SetText(TextManager.GetText(self._levelRecorder.unlockTextID))
  local clientBreakLevel = CRoleLevelCfgTable:GetRecorder(self._levelRecorder.levelShow).clientBreakLevel
  local clientLevel = CRoleLevelCfgTable:GetRecorder(self._levelRecorder.levelShow).clientLevel
  self.recomLevel:SetText(clientLevel)
  self._breakNumTxt:SetText(clientBreakLevel)
  self._name:SetText(TextManager.GetText(self._levelRecorder.nameID))
  self._detailText:SetText(TextManager.GetText(self._levelRecorder.descriptionID))
  self._itemData = {}
  local temp = {
    tag = "first",
    itemID = self._levelRecorder.firstItems,
    count = self._levelRecorder.firstItemNums
  }
  table.insert(self._itemData, temp)
  for i, v in ipairs(self._levelRecorder.sureDropItems) do
    local temp = {
      tag = "sure",
      itemID = v,
      count = self._levelRecorder.sureItemNums[i]
    }
    table.insert(self._itemData, temp)
  end
  self._cellFrame:ReloadAllCell()
end

function ResourceDetailCell:NumberOfCell(frame)
  return #self._itemData
end

function ResourceDetailCell:CellAtIndex(frame, index)
  return "activity.swimsuitechoes.swimsuitbattleitemcell"
end

function ResourceDetailCell:DataAtIndex(frame, index)
  return self._itemData[index]
end

function ResourceDetailCell:OnIBtnClicked()
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

function ResourceDetailCell:OnDisPatchBtnClicked()
  if NekoData.BehaviorManager.BM_OfflineSweep:GetTodayLeftNum() <= 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100471)
    return
  end
  if NekoData.BehaviorManager.BM_OfflineSweep:GetStatus() ~= 0 then
    if NekoData.BehaviorManager.BM_OfflineSweep:GetStatus() == 1 then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100474)
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100475)
    end
    return
  end
  if self._spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.offlinesweepcontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "DispatchSummerEchoes"
      data.id = self._functionID
      data.name = TextManager.GetText(self._levelRecorder.nameID)
      data.spirit = self._levelRecorder.spirit
      data.timelength = self._levelRecorder.mopupTime
      data.littleImgID = nil
      dialog:SetInfo(data)
    end
  end
end

function ResourceDetailCell:OnAutoBtnClicked()
  if self._spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "AutoExploreSummerEchoes"
      data.id = self._functionID
      data.spirit = self._spirit
      dialog:SetInfo(data)
    end
  end
end

function ResourceDetailCell:OnGoBtnClicked()
  if self._spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.AssistBattle) then
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
    self._delegate:OnBackBtnClicked()
  end
end

return ResourceDetailCell
