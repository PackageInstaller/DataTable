local TowerV2DefeatDialog = class("TowerV2DefeatDialog", Dialog)
TowerV2DefeatDialog.AssetBundleName = "ui/layouts.stair"
TowerV2DefeatDialog.AssetName = "StairDefeat"
local TowerV2SceneParts = require("logic.dialog.towerv2.scene.towerv2sceneparts")
local cstairlevelcfg = BeanManager.GetTableByName("dungeonselect.cstairlevelcfg")
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2DefeatDialog:Ctor(...)
  TowerV2DefeatDialog.super.Ctor(self, ...)
  self._parts = TowerV2SceneParts.Create(self)
end

function TowerV2DefeatDialog:OnCreate()
  self._team = self:GetChild("DownArea/DualBtn/TeamBtn")
  self._retreat = self:GetChild("DownArea/DualBtn/GoBtn")
  self._restart = self:GetChild("DownArea/DualBtn/RestartBtn")
  self._gotargetlvl = self:GetChild("DownArea/DualBtn/GoHalfBtn")
  self._gotargetlvlTxt = self:GetChild("DownArea/DualBtn/GoHalfBtn/_Text")
  self._gotargetlvl:SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._teams = {
    links = {}
  }
  for i = 1, 3 do
    self._teams.links[i] = self:GetChild("Link" .. i)
  end
  for i = 1, 6 do
    local path_t = "Char" .. i
    self._teams[i] = {
      board = self:GetChild(path_t),
      icon = self:GetChild(path_t .. "/Back/Photo"),
      hp = self:GetChild(path_t .. "/Frame"),
      dot = self:GetChild(path_t .. "/Dot")
    }
    self._teams[i].dot:SetActive(false)
  end
  self._nodeCount = self:GetChild("Detail/Count/Num")
  self._nodeTotal = self:GetChild("Detail/Count/NumMax")
  self._rewardPreview = self:GetChild("Detail/Count/Box")
  self._rewardRedpoint = self:GetChild("Detail/Count/Box/NewRedDot1")
  self._positionFrame = self:GetChild("PositionFrame")
  self._positionMark = self:GetChild("StairPositionCurrent")
  self._topgroup = self:GetChild("TopGroup")
  self._topgroup:SetActive(false)
  self._spirit = {
    text = self:GetChild("TopGroup/VIT/Text"),
    button = self:GetChild("TopGroup/VIT/Add"),
    reddot = self:GetChild("TopGroup/VIT/RedDot")
  }
  self._buff = self:GetChild("BuffBtn")
  self._buffRedpoint = self:GetChild("BuffBtn/Effect")
  self._progress = {
    start = self:GetChild("TitleBack/Empty"),
    text = {
      desc = self:GetChild("TitleBack/Txt1"),
      value = self:GetChild("TitleBack/Txt2")
    }
  }
  self._refesh = {
    text = self:GetChild("Detail/Refresh/Time"),
    info = self:GetChild("Detail/Refresh/Ibtn")
  }
  self._progressFrame = self:GetChild("TitleBack")
  for i = 1, 6 do
    self._teams[i].board:Subscribe_PointerClickEvent(function()
      self._parts:OnTeamCharClicked(i)
    end, self)
  end
  self._team:Subscribe_PointerClickEvent(self.OnTeamClick, self)
  self._retreat:Subscribe_PointerClickEvent(self.OnRetreatClick, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._restart:Subscribe_PointerClickEvent(self.OnRestartClick, self)
  self._gotargetlvl:Subscribe_PointerClickEvent(self.OnGoTargetLvlClicked, self)
  self._rankBtn = self:GetChild("RankBtn")
  self._rankBtn:Subscribe_PointerClickEvent(self._parts.OnRankBtnClick, self._parts)
  self._packBtn = self:GetChild("PackBtn")
  self._packBtn:Subscribe_PointerClickEvent(self._parts.OnPackBtnClick, self._parts)
  self._packBtnEffect = self:GetChild("PackBtn/Effect")
  self._packBtnEffect:SetActive(false)
  self._packBtnRedDot = self:GetChild("PackBtn/RedDot")
  self._packBtnRedDot:SetActive(false)
  self._refesh.info:Subscribe_PointerClickEvent(self._parts.OnRefreshInfoClick, self._parts)
  self._rewardPreview:Subscribe_PointerClickEvent(self._parts.OnPreviewRewardClick, self._parts)
  self._spirit.button:Subscribe_PointerClickEvent(self._parts.OnSpiritClick, self._parts)
  self._buff:Subscribe_PointerClickEvent(self._parts.OnBuffClick, self._parts)
  LuaNotificationCenter.AddObserver(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_TowerV2Reward, nil)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
  self:InitBtn()
  self._parts:OnCreate()
  self._parts:Init()
end

function TowerV2DefeatDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._runtimePackerLuaAgent then
    self._runtimePackerLuaAgent:Release()
    self._runtimePackerLuaAgent = nil
  end
  self._parts:Destroy()
end

function TowerV2DefeatDialog:InitBtn()
  self._team:SetActive(false)
  self._retreat:SetActive(false)
  self._restart:SetActive(false)
  self._gotargetlvl:SetActive(false)
  self.posionList = {}
  local scale, offset = self._team:GetWidth()
  local posion1 = {}
  posion1.scalex, posion1.offsetx, posion1.scaley, posion1.offsety = self._team:GetPosition()
  table.insert(self.posionList, posion1)
  local posion2 = {}
  posion2.scalex, posion2.offsetx, posion2.scaley, posion2.offsety = self._retreat:GetPosition()
  table.insert(self.posionList, posion2)
  local posion3 = {}
  posion3.scalex, posion3.offsetx, posion3.scaley, posion3.offsety = self._gotargetlvl:GetPosition()
  table.insert(self.posionList, posion3)
  local posion4 = {}
  posion4.scalex, posion4.offsetx, posion4.scaley, posion4.offsety = self._restart:GetPosition()
  table.insert(self.posionList, posion4)
  self.showTab = {}
  table.insert(self.showTab, self._team)
  table.insert(self.showTab, self._retreat)
  local isReachedBoss = bm_towerv2:IsReachedBossStair()
  if isReachedBoss then
    scale, offset = 0, 0
    self:UpdateTargetlvlTxt()
    table.insert(self.showTab, self._gotargetlvl)
  end
  table.insert(self.showTab, self._restart)
  for index, v in ipairs(self.showTab) do
    v:SetActive(true)
    local cposion = self.posionList[index]
    v:SetPosition(cposion.scalex, cposion.offsetx + offset / 2, cposion.scaley, cposion.offsety)
  end
end

function TowerV2DefeatDialog:UpdateTargetlvlTxt()
  local targetlv = bm_towerv2:GetBossRetryStair()
  local recorder = cstairlevelcfg:GetRecorder(targetlv)
  self._gotargetlvlTxt:SetText(TextManager.GetText(recorder.name))
end

function TowerV2DefeatDialog:Refresh()
  self._parts:Refresh()
end

function TowerV2DefeatDialog:OnNewStairs()
  DialogManager.DestroySingletonDialog("towerv2.scene.towerv2defeatdialog")
end

function TowerV2DefeatDialog:OnRetreatClick()
  local cost = bm_towerv2:GetFloorInfoByIndex(1).cfg.apCost
  if cost <= NekoData.BehaviorManager.BM_Currency:GetSpirit() then
    bm_towerv2:Retreat()
  else
    NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

function TowerV2DefeatDialog:OnTeamClick()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.towerv2teameditdialog")
  dialog:GoTowerBattle("retreat")
end

function TowerV2DefeatDialog:OnBackBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(59, nil, function()
    EffectFactory.CreateJumpBackEffect(66):Run()
  end, nil, nil)
end

function TowerV2DefeatDialog:AddNewModal()
end

function TowerV2DefeatDialog:OnRestartClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(154, nil, function()
    bm_towerv2:Reset(1)
  end, nil, nil)
end

function TowerV2DefeatDialog:OnGoTargetLvlClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(155, nil, function()
    local isReachedBoss = bm_towerv2:IsReachedBossStair()
    if isReachedBoss then
      bm_towerv2:Reset(3)
    end
  end, nil, nil)
end

return TowerV2DefeatDialog
