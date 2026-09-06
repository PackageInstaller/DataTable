local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CLoverInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cvalentineinterfacefunction")
local CHexagonBattleConfig = BeanManager.GetTableByName("dungeonselect.chexagonbattleconfig")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local LoverStoryBattleDialog = class("LoverStoryBattleDialog", Dialog)
LoverStoryBattleDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverStoryBattleDialog.AssetName = "ActivityValentinesStorybattle"

function LoverStoryBattleDialog:Ctor(...)
  LoverStoryBattleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function LoverStoryBattleDialog:OnCreate()
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

function LoverStoryBattleDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function LoverStoryBattleDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local funectionRecorder = CLoverInterfaceFunction:GetRecorder(data.functionID)
  local battleID = funectionRecorder.battleID
  if battleID ~= 0 then
    local battleRecorder = CHexagonBattleConfig:GetRecorder(battleID)
    self._name:SetText(TextManager.GetText(battleRecorder.leveltitle))
    self._spirit = battleRecorder.spirit
    self._num:SetText(battleRecorder.spirit)
    self._leveltxt:SetText(TextManager.GetText(battleRecorder.levelinfo))
    local clientBreakLevel = CRoleLevelCfgTable:GetRecorder(battleRecorder.suggestlevel).clientBreakLevel
    local clientLevel = CRoleLevelCfgTable:GetRecorder(battleRecorder.suggestlevel).clientLevel
    self._levelnum:SetText(clientLevel)
    self._ranknum:SetText(clientBreakLevel)
    self._itemData = {}
    for i, v in ipairs(battleRecorder.firstItems) do
      local temp = {
        tag = "first",
        itemID = v,
        count = battleRecorder.firstItemNums[i]
      }
      table.insert(self._itemData, temp)
    end
    for i, v in ipairs(battleRecorder.mayDropItems) do
      local temp = {
        tag = "may",
        itemID = v,
        count = battleRecorder.mayDropItemsNums[i]
      }
      table.insert(self._itemData, temp)
    end
    for i, v in ipairs(battleRecorder.sureDropItems) do
      local temp = {
        tag = "sure",
        itemID = v,
        count = battleRecorder.sureDropItemsNums[i]
      }
      table.insert(self._itemData, temp)
    end
    self._frame:ReloadAllCell()
  else
    LogErrorFormat("LoverStoryBattleDialog", "functionID %s 没有找到战斗", data.functionID)
  end
end

function LoverStoryBattleDialog:OnCheckbtnClicked()
  if self._spirit > NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID) then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    NekoData.DataManager.DM_Team:ClearSupportRole()
    local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
    if dialog then
      dialog:SetCopyInfo("Lover", self._functionID, self._constructionID)
    end
  end
end

function LoverStoryBattleDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function LoverStoryBattleDialog:OnBackBtnClicked()
  self:Destroy()
end

function LoverStoryBattleDialog:NumberOfCell(frame)
  return #self._itemData
end

function LoverStoryBattleDialog:CellAtIndex(frame, index)
  return "activity.lover.loverbattleitemcell"
end

function LoverStoryBattleDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

function LoverStoryBattleDialog:OnTipsBtnClicked()
  local funectionRecorder = CLoverInterfaceFunction:GetRecorder(self._functionID)
  if not funectionRecorder then
    LogErrorFormat("LoverStoryBattleDialog", "CLoverInterfaceFunction 没有找到配置 functionID = %s ", tostring(self._functionID))
    return
  end
  local battleID = funectionRecorder.battleID
  local dialog = DialogManager.CreateSingletonDialog("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = battleID
    data.type = "Lover"
    dialog:Init(data)
  end
end

return LoverStoryBattleDialog
