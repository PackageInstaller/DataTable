local TowerV2RewardDialog = class("TowerV2RewardDialog", Dialog)
TowerV2RewardDialog.AssetBundleName = "ui/layouts.stair"
TowerV2RewardDialog.AssetName = "StairReward"
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2
local cstringres = BeanManager.GetTableByName("message.cstringres")
local TowerV2SceneParts = require("logic.dialog.towerv2.scene.towerv2sceneparts")
local GridFrame = require("framework.ui.frame.grid.gridframe")

function TowerV2RewardDialog:Ctor(...)
  TowerV2RewardDialog.super.Ctor(self, ...)
  self._parts = TowerV2SceneParts.Create(self)
end

function TowerV2RewardDialog:OnCreate()
  self._title = self:GetChild("Title")
  self._frame = self:GetChild("Frame/Line/ItemFrame")
  self._team = self:GetChild("TeamBtn")
  self._team:Subscribe_PointerClickEvent(self.OnTeamClick, self)
  self._continue = self:GetChild("GoBtn")
  self._continue:Subscribe_PointerClickEvent(self.OnContinueClick, self)
  self._back = self:GetChild("BackBtn")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
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
  self._topgroup = self:GetChild("TopGroup")
  self._topgroup:SetActive(false)
  self._spirit = {
    text = self:GetChild("TopGroup/VIT/Text"),
    button = self:GetChild("TopGroup/VIT/Add"),
    reddot = self:GetChild("TopGroup/VIT/RedDot")
  }
  self._detailCount = self:GetChild("Detail/Count")
  self._detailCount:SetActive(false)
  self._nodeCount = self:GetChild("Detail/Count/Num")
  self._nodeTotal = self:GetChild("Detail/Count/NumMax")
  self._rewardPreview = self:GetChild("Detail/Count/Box")
  self._rewardRedpoint = self:GetChild("Detail/Count/Box/NewRedDot1")
  self._positionFrame = self:GetChild("PositionFrame")
  self._positionMark = self:GetChild("StairPositionCurrent")
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
  self._helper = GridFrame.Create(self._frame, self, true, 3)
  self._frame:SetActive(false)
  for i = 1, 6 do
    self._teams[i].board:Subscribe_PointerClickEvent(function()
      self._parts:OnTeamCharClicked(i)
    end, self)
  end
  self._rankBtn = self:GetChild("RankBtn")
  self._rankBtn:Subscribe_PointerClickEvent(self._parts.OnRankBtnClick, self._parts)
  self._packBtn = self:GetChild("PackBtn")
  self._packBtn:Subscribe_PointerClickEvent(self._parts.OnPackBtnClick, self._parts)
  self._packBtnEffect = self:GetChild("PackBtn/Effect")
  self._packBtnEffect:SetActive(false)
  self._packBtnRedDot = self:GetChild("PackBtn/RedDot")
  self._packBtnRedDot:SetActive(false)
  LuaNotificationCenter.AddObserver(self, self.OnReward, Common.n_TowerV2Reward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
  self._handle = self:GetRootWindow():Subscribe_StateUpdateEvent(self.OnStateUpdate, self)
  self._refesh.info:Subscribe_PointerClickEvent(self._parts.OnRefreshInfoClick, self._parts)
  self._rewardPreview:Subscribe_PointerClickEvent(self._parts.OnPreviewRewardClick, self._parts)
  self._spirit.button:Subscribe_PointerClickEvent(self._parts.OnSpiritClick, self._parts)
  self._buff:Subscribe_PointerClickEvent(self._parts.OnBuffClick, self._parts)
  self._parts:OnCreate()
end

function TowerV2RewardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._helper:Destroy()
  self._parts:Destroy()
end

function TowerV2RewardDialog:SetData(items)
  self._items = items or {}
  self._parts:Init()
  self:Refresh()
end

function TowerV2RewardDialog:Refresh()
  if #self._items ~= 0 then
    self._frame:SetActive(true)
    self._helper:ReloadAllCell()
  end
  local text = TextManager.GetText(cstringres:GetRecorder(1388).msgTextID)
  text = text .. TextManager.GetText(bm_towerv2:GetCurrentFloorInfo().cfg.name)
  self._parts:Refresh()
  local complete = bm_towerv2:GetState() == "complete"
  self._team:SetActive(not complete)
  self._continue:SetActive(not complete)
end

function TowerV2RewardDialog:OnReward(notification)
  self:SetData(NekoData.BehaviorManager.BM_TowerV2:GetLastRewards())
  self:Refresh()
end

function TowerV2RewardDialog:OnNewStairs()
  DialogManager.DestroySingletonDialog("towerv2.scene.towerv2rewarddialog")
end

function TowerV2RewardDialog:OnContinueClick()
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost <= NekoData.BehaviorManager.BM_Currency:GetSpirit() then
    NekoData.BehaviorManager.BM_TowerV2:Forward()
  else
    NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  end
end

function TowerV2RewardDialog:OnBackBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(59, nil, function()
    local type = 66
    if bm_towerv2:GetState() == "complete" then
      type = nil
    end
    EffectFactory.CreateJumpBackEffect(type):Run()
  end)
end

function TowerV2RewardDialog:OnTeamClick()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.towerv2teameditdialog")
  dialog:GoTowerBattle("forward")
end

function TowerV2RewardDialog:OnStateUpdate(handle, stateName, normalizedTime)
  if 1 <= normalizedTime and bm_towerv2:GetState() == "complete" then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(116, nil, function()
      EffectFactory.CreateJumpBackEffect():Run()
    end)
    self:GetRootWindow():Unsubscribe_StateUpdateEvent(self._handle)
  end
end

function TowerV2RewardDialog:AddNewModal()
end

function TowerV2RewardDialog:NumberOfCell(helper)
  return #self._items
end

function TowerV2RewardDialog:CellAtIndex(helper, index)
  return "towerv2.towerv2itemcell"
end

function TowerV2RewardDialog:DataAtIndex(helper, index)
  return self._items[index]
end

return TowerV2RewardDialog
