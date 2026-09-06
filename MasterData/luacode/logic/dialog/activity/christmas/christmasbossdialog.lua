local TableFrame = require("framework.ui.frame.table.tableframe")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CChrisBossShow = BeanManager.GetTableByName("dungeonselect.cchrisbossshow")
local CHexagonBattleConfig = BeanManager.GetTableByName("dungeonselect.chexagonbattleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ChristmasBossDialog = class("ChristmasBossDialog", Dialog)
ChristmasBossDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBossDialog.AssetName = "ActivityChristmasBossDetail"

function ChristmasBossDialog:Ctor(...)
  ChristmasBossDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ChristmasBossDialog:OnCreate()
  self._goBtn = self:GetChild("Back/Panel/GoBtn")
  self._closeBtn = self:GetChild("Back/Panel/CloseBtn")
  self._rankBtn = self:GetChild("Back/Panel/RankBtn")
  self._rankBtnText = self:GetChild("Back/Panel/RankBtn/_Text")
  self._tips = self:GetChild("Back/Panel/Tips")
  self._cellPanel = self:GetChild("Back/Panel/CellPanel")
  self._backImage1 = self:GetChild("Back/Panel/BackImage1")
  self._backImage2 = self:GetChild("Back/Panel/BackImage2")
  self._model = self:GetChild("Back/Panel/Model")
  self._difficultyLevel = self:GetChild("Back/Panel/DifficultyLevel")
  self._difficultyLevel:SetActive(false)
  self._name = self:GetChild("Back/Panel/TextName")
  self._battleTime = self:GetChild("Back/Panel/BattleTime")
  self._cellPanel = self:GetChild("Back/Panel/CellPanel")
  self._black = self:GetChild("Black")
  self._difficultyTxt = self:GetChild("Back/Panel/Levelrank")
  self._difficultyTxt:SetActive(false)
  self._frame = TableFrame.Create(self._cellPanel, self, false)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.Destroy, self)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._black:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.SOpenHardBoss, Common.n_SOpenHardBoss, nil)
end

function ChristmasBossDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function ChristmasBossDialog:SetData(data)
  self._functionIDs = data.functionIDs
  self._constructionID = data.constructionID
  self._locked = data.locked
  local funectionRecorder = CInterfaceFunction:GetRecorder(self._functionIDs[1])
  if not funectionRecorder then
    LogErrorFormat("ChristmasBattleDialog", "CInterfaceFunction 没有找到配置 functionID = %s ", tostring(data.functionID))
    return
  end
  local type = funectionRecorder.type
  if type == CChristmasActivityEvent.COMMON_BOSS then
    self._rankBtn:SetActive(false)
    self._tips:SetActive(false)
    self._battleTime:SetActive(true)
    self._backImage1:SetActive(true)
    self._backImage2:SetActive(false)
    self._difficultyTxt:SetActive(false)
  else
    self._rankBtnText:SetText(TextManager.GetText(1901403))
    self._battleTime:SetActive(false)
    self._backImage1:SetActive(false)
    self._backImage2:SetActive(true)
    self._difficultyTxt:SetActive(true)
    local index = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetSChristmasBossTimes()
    self._difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(index, "Christmas"))
  end
  self._itemData = {}
  local recorder = CChrisBossShow:GetRecorder(self._functionIDs[1])
  local battleID = funectionRecorder.battleID
  if battleID ~= 0 then
    self._battleRecorder = CHexagonBattleConfig:GetRecorder(battleID)
    self._name:SetText(TextManager.GetText(self._battleRecorder.leveltitle))
    self._itemData = {}
    for i, v in ipairs(self._battleRecorder.firstItems) do
      local temp = {
        tag = "first",
        itemID = v,
        count = self._battleRecorder.firstItemNums[i]
      }
      table.insert(self._itemData, temp)
    end
    for i, v in ipairs(self._battleRecorder.sureDropItems) do
      local temp = {
        tag = "sure",
        itemID = v,
        count = self._battleRecorder.sureDropItemsNums[i]
      }
      table.insert(self._itemData, temp)
    end
    for i, v in ipairs(self._battleRecorder.mayDropItems) do
      local temp = {
        tag = "may",
        itemID = v,
        count = self._battleRecorder.mayDropItemsNums[i]
      }
      table.insert(self._itemData, temp)
    end
    self._frame:ReloadAllCell()
  else
    LogErrorFormat("ChristmasBattleDialog", "functionID %s 没有找到战斗", tostring(self._functionIDs[1]))
  end
end

function ChristmasBossDialog:SOpenHardBoss(notification)
  self._leftNum = notification.userInfo.leftNum
  self._battleTime:SetText(string.gsub(TextManager.GetText(1901404), "%$parameter%$", self._leftNum))
end

function ChristmasBossDialog:OnGoBtnClicked()
  local type = CInterfaceFunction:GetRecorder(self._functionIDs[1]).type
  if type == CChristmasActivityEvent.COMMON_BOSS and self._leftNum and self._leftNum == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100442)
    return
  end
  NekoData.DataManager.DM_Team:ClearSupportRole()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.undecidedroadteameditdialog")
  if dialog then
    dialog:SetCopyInfo("ChristmasBoss", self._functionIDs[1], self._constructionID)
  end
  self:Destroy()
end

function ChristmasBossDialog:OnRankBtnClicked()
  DialogManager.CreateSingletonDialog("activity.christmas.rankmaindialog"):SetType(self._functionIDs[1])
end

function ChristmasBossDialog:NumberOfCell(frame)
  return #self._itemData
end

function ChristmasBossDialog:CellAtIndex(frame, index)
  return "activity.christmas.christmasbattleitemcell"
end

function ChristmasBossDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

function ChristmasBossDialog:OnBackBtnClicked()
  self:Destroy()
end

return ChristmasBossDialog
