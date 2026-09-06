local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local CBossNianPart = BeanManager.GetTableByName("activity.cbossnianpart")
local CBossNianRankAP = BeanManager.GetTableByName("activity.cbossnianrankap")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemTable = BeanManager.GetTableByName("item.citemattr")
local BossDetailsDialog = class("BossDetailsDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local SpringBossState = LuaNetManager.GetBeanDef("protocol.activity.springboss")
local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local SpringUnlockRecord = CTimedActivitySwitch:GetRecorder(25001)
local timeutils = require("logic.utils.timeutils")
local ChildDialogs = {
  "activity.springfestival.rankdialog",
  "activity.springfestival.spiritrecoverdialog"
}
BossDetailsDialog.AssetBundleName = "ui/layouts.activitynewyear"
BossDetailsDialog.AssetName = "ActivityNewYearBattleDetails"

function BossDetailsDialog:Ctor(...)
  BossDetailsDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BossDetailsDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._totleScore = self:GetChild("LevelPanel/RewardTitle/Num1")
  self._rankNum = self:GetChild("LevelPanel/RewardTitle/Num2")
  self._instructBtn = self:GetChild("GetBtn")
  self._instructBtn:Subscribe_PointerClickEvent(self.OnInstructBtnClicked, self)
  self._detailsBtn = self:GetChild("DetailsBtn")
  self._detailsBtn:Subscribe_PointerClickEvent(self.OnDetailsBtnClicked, self)
  self._rankBtn = self:GetChild("LevelPanel/RankBtn")
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._spiritRedDot = self:GetChild("TopGroup/Num0/RedDot")
  self._spiritNum = self:GetChild("TopGroup/Num0/Text")
  self._spiritAdd = self:GetChild("TopGroup/Num0/Add")
  self._spiritIcon = self:GetChild("TopGroup/Num0/Icon")
  self._spiritPanel = self:GetChild("TopGroup/Num0")
  self._spiritPanel:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._detailsBtn = self:GetChild("DetailsBtn")
  self._model = self:GetChild("Scale/Model")
  self._imgBoxOff = self:GetChild("Scale/Model/ImgBoxOff")
  self._imgBoxOff:Subscribe_PointerClickEvent(self.ReceiveSpringBossReward, self)
  self._imgBoxDot = self:GetChild("AwardBack/AwardImage/Dot")
  self._imgBoxOn = self:GetChild("Scale/Model/ImgBoxOn")
  self._battleBtn = self:GetChild("BattleBtn")
  self._progressNum = self:GetChild("Loading/Num/Num")
  self._battleBtn:Subscribe_PointerClickEvent(self.OnBattleBtnClicked, self)
  self._panel1 = self:GetChild("AwardBack/Frame1")
  self._panel2 = self:GetChild("AwardBack/Frame2")
  self._name = self:GetChild("Name")
  self._weekImage = self:GetChild("Item")
  self._weekTips = self:GetChild("Tips")
  self._tipsBack = self:GetChild("TipsBack")
  self._costIcon = self:GetChild("CostBack/Icon")
  self._costNum = self:GetChild("CostBack/Num")
  self._imgCloud = self:GetChild("Imgcloud")
  self._frame1 = TableFrame.Create(self._panel1, self, false, true)
  self._panelWAnchor, self._panelWWidth = self._panel1:GetWidth()
  self._panelPAnchor, self._panelPOffset = self._panel1:GetXPosition()
  self._frame2 = TableFrame.Create(self._panel2, self, false, true)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpringSpirit, Common.n_RefreshSpringSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.OpenRankDialog, Common.n_OnSSimpleRank, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBackFromBattle, Common.n_EnterMianCity)
  LuaNotificationCenter.AddObserver(self, self.OnSSpringBossState, Common.n_SSpringBossState)
  LuaNotificationCenter.AddObserver(self, self.SReceiveSpringBossReward, Common.n_SReceiveSpringBossReward)
end

function BossDetailsDialog:OnDestroy()
  if self._frame1 then
    self._frame1:Destroy()
  end
  if self._frame2 then
    self._frame2:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
  local dialog = DialogManager.GetDialog("activity.springfestival.bossmaindialog")
  if dialog then
    dialog:ShowSpringFestivalFireworks()
  end
end

function BossDetailsDialog:SetData(data)
  self._bossData = data
  self._bossID = data.bossId
  self._imgCloud:SetActive(self._bossID == 4 and self._bossData.state < SpringBossState.DEFEAT)
  local rankAndScore = self._bm:GetBossScoreAndRank()
  self._totleScore:SetText(rankAndScore.score)
  if rankAndScore.rank == -1 then
    self._rankNum:SetText(TextManager.GetText(701681))
  else
    self._rankNum:SetText(rankAndScore.rank)
  end
  self._progress:SetFillAmount(data.bloodVolume / 100 / 100)
  self._progressNum:SetText(data.bloodVolume / 100 .. "%")
  local recorder = CBossNianPart:GetRecorder(data.bossId)
  local npcShapeRecorder = CNPCShape:GetRecorder(recorder.bossModel)
  if not self._handler and data.state == SpringBossState.PROCESS then
    self._handler = self._model:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
    local scale = tonumber(recorder.bossSize)
    self._model:SetLocalScale(scale, scale, scale)
    self._modelobj = TransformStaticFunctions.GetChild(self._model._uiObject, "Model/" .. npcShapeRecorder.prefabNameUI .. "(Clone)")
    self._modelAnimator = AnimatorStaticFunctions.Get(self._modelobj)
  end
  self._imgBoxDot:SetActive(self._bossData.state == SpringBossState.DEFEAT)
  self._imgBoxOff:SetActive(self._bossData.state == SpringBossState.DEFEAT)
  self._imgBoxOn:SetActive(self._bossData.state == SpringBossState.OPENBOX)
  self._name:SetText(TextManager.GetText(recorder.bossName))
  local imageRecord = CImagePathTable:GetRecorder(recorder.bossWeakIcon)
  self._weekImage:SetActive(recorder.bossWeakIcon > 0)
  self._weekTips:SetActive(recorder.bossWeakIcon > 0)
  self._tipsBack:SetActive(recorder.bossWeakIcon > 0)
  if recorder.bossWeakIcon > 0 then
    self._weekImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._weekTips:SetText(TextManager.GetText(recorder.bossWeakWord))
  end
  self._battleBtn:SetInteractable(data.state == SpringBossState.PROCESS)
  self._costNum:SetText(recorder.battleCost)
  self._battleCost = recorder.battleCost
  local itemRecorder = CItemTable:GetRecorder(DataCommon.SpringFestivalFu)
  if itemRecorder then
    imageRecord = CImagePathTable:GetRecorder(itemRecorder.icon)
    self._costIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._spiritIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  self._rewardData1, self._rewardData2 = self._bm:GetBossRewardData(self._bossID)
  self._frame1:ReloadAllCell()
  if #self._rewardData1 < 3 then
    self._panel1:SetWidth(self._panelWAnchor, self._frame1:GetTotalLength())
    self._panel1:SetXPosition(self._panelPAnchor, self._panelPOffset + (self._panelWWidth - self._frame1:GetTotalLength()) / 2)
  end
  self._frame2:ReloadAllCell()
  self:RefreshSpringSpirit()
end

function BossDetailsDialog:OnBackBtnClicked()
  self:Destroy()
end

function BossDetailsDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function BossDetailsDialog:RefreshSpringSpirit()
  self._spirit = self._bm:GetSpringSpirit()
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(self._bm:GetSpiritLimit()))
end

function BossDetailsDialog:OnSpiritAddBtnClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpringFestivalFu)
end

function BossDetailsDialog:OnBattleBtnClicked()
  self._endTime = timeutils.GetConfigFormatTimeStamp(SpringUnlockRecord.closeTime)
  if ServerGameTimer.GetServerTime() > self._endTime then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100455)
    return
  end
  if self._battleCost <= self._bm:GetSpringSpirit() then
    local dialog = DialogManager.CreateSingletonDialog("teamedit.springfestivalteameditdialog")
    if dialog then
      dialog:SetCopyInfo("SpringFestival", self._bossID)
    end
  else
    DialogManager.CreateSingletonDialog("activity.springfestival.spiritrecoverdialog")
  end
end

function BossDetailsDialog:NumberOfCell(frame)
  if self._frame1 == frame then
    return #self._rewardData1
  else
    return #self._rewardData2
  end
end

function BossDetailsDialog:CellAtIndex(frame, index)
  return "activity.springfestival.rewardcell"
end

function BossDetailsDialog:DataAtIndex(frame, index)
  if self._frame1 == frame then
    return self._rewardData1[index]
  else
    return self._rewardData2[index]
  end
end

function BossDetailsDialog:OnRankBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.ranking.csimplerank")
  if protocol then
    protocol.rankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef().SPRING_FESTIVAL
    protocol.rankId = self._bm:GetRankID()
    protocol:Send()
  end
end

function BossDetailsDialog:OnInstructBtnClicked()
  DialogManager.CreateSingletonDialog("activity.springfestival.tipsdialog"):SetData(701661, CBossNianRankAP:GetRecorder(1).rankForReward)
end

function BossDetailsDialog:OnDetailsBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = self._bossID
    data.type = "SpringFestival"
    dialog:Init(data)
  end
end

function BossDetailsDialog:OpenRankDialog(data)
  if data.userInfo.rankType == NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef().SPRING_FESTIVAL then
    DialogManager.CreateSingletonDialog("activity.springfestival.rankdialog")
  end
end

function BossDetailsDialog:AddNewModal(dialog)
  if table.contain(ChildDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function BossDetailsDialog:OnBackFromBattle()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cspringbossstate")
  csend:Send()
end

function BossDetailsDialog:OnSSpringBossState()
  local bossDataNew = self._bm:GetBossInfoByID(self._bossID)
  if not self._modelAnimator then
    return
  end
  if bossDataNew.bloodVolume == 0 and self._modelAnimator then
    self._modelAnimator:Play("DeadDisappear")
    StateEventTriggerHelper.AddAnimationEventListener(self._modelobj, "DeadDisappear", function()
      self._imgBoxDot:SetActive(bossDataNew.state == SpringBossState.DEFEAT)
      self._imgBoxOff:SetActive(bossDataNew.state == SpringBossState.DEFEAT)
      self._imgBoxOn:SetActive(bossDataNew.state == SpringBossState.OPENBOX)
      if self._handler ~= 0 then
        self._model:ReleaseModel(self._handler)
        self._handler = 0
        self._modelAnimator = nil
      end
    end)
  else
    self._modelAnimator:Play("Attacked")
  end
  self:SetData(bossDataNew)
end

function BossDetailsDialog:ReceiveSpringBossReward()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.creceivespringbossreward")
  if protocol then
    protocol.bossId = self._bossData.bossId
    protocol:Send()
  end
end

function BossDetailsDialog:SReceiveSpringBossReward()
  self._bossData = self._bm:GetBossInfoByID(self._bossID)
  self._imgBoxDot:SetActive(self._bossData.state == SpringBossState.DEFEAT)
  self._imgBoxOff:SetActive(self._bossData.state == SpringBossState.DEFEAT)
  self._imgBoxOn:SetActive(self._bossData.state == SpringBossState.OPENBOX)
end

return BossDetailsDialog
