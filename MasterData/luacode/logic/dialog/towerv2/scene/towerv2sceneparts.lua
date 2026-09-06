local TowerV2SceneParts = class("TowerV2SceneParts")
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2
local cstairlevelcfg = BeanManager.GetTableByName("dungeonselect.cstairlevelcfg")
local ProgressHorizontalTableFrame = require("logic.dialog.towerv2.scene.progresshorizontaltableframe")
local event_spawn_time = tonumber(BeanManager.GetTableByName("dungeonselect.cstairvarcfg"):GetRecorder(3).value)

function TowerV2SceneParts:Ctor(delegate)
  self._delegate = delegate
end

function TowerV2SceneParts:OnCreate()
  self._positionHelper = ProgressHorizontalTableFrame.Create(self._delegate._positionFrame, self, false, false, "Viewport")
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_StrengthLimitChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshPackBtnRedDot, Common.n_RefreshTowerV2RedPoint, nil)
end

function TowerV2SceneParts:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._positionHelper:Destroy()
  if self._task then
    GameTimer.RemoveTask(self._task)
  end
  if self._accountTimer then
    GameTimer.RemoveTask(self._accountTimer)
  end
  if self._timeoutTask then
    GameTimer.RemoveTask(self._timeoutTask)
  end
  if self._runtimePackerLuaAgent then
    self._runtimePackerLuaAgent:Release()
    self._runtimePackerLuaAgent = nil
  end
end

local function show_progress_text(self, show)
  self._delegate._progress.text.value:SetActive(show)
  self._delegate._progress.text.desc:SetActive(show)
  self._delegate._progress.start:SetActive(not show)
end

function TowerV2SceneParts:Refresh()
  self:OnRefreshSpirit()
  self:RefreshSpiritRedPoint()
  local state = bm_towerv2:GetState()
  local current_floor = bm_towerv2:GetCurrentFloorID()
  local recorder = cstairlevelcfg:GetRecorder(current_floor)
  if state == "fresh" then
    if current_floor == cstairlevelcfg:GetAllIds()[1] then
      show_progress_text(self, false)
    else
      show_progress_text(self, true)
    end
  elseif state == "retreat" then
    show_progress_text(self, true)
  elseif state == "continue" or state == "finished" then
    show_progress_text(self, true)
  elseif state == "reset" or state == "buffchoose" then
    show_progress_text(self, true)
  end
  self._delegate._nodeCount:SetText(bm_towerv2:GetReachedCount())
  self._delegate._nodeTotal:SetText(bm_towerv2:GetFloorTotalCount())
  self._delegate._rewardRedpoint:SetActive(bm_towerv2:RewardHasRedpoint())
  self._delegate._buffRedpoint:SetActive(bm_towerv2:BuffHasRedpoint())
  self._delegate._progress.text.value:SetText(TextManager.GetText(recorder.name))
  self:RefreshCost()
  self:RefreshTeam()
  self:RefreshPackBtnRedDot()
end

function TowerV2SceneParts:RefreshCost()
end

function TowerV2SceneParts:RefreshPackBtnRedDot()
  if NekoData.BehaviorManager.BM_TowerV2:GetHasReward() == 1 then
    self._delegate._packBtnRedDot:SetActive(true)
  else
    self._delegate._packBtnRedDot:SetActive(false)
  end
end

function TowerV2SceneParts:ResetMark()
  self._positionHelper:MoveToAssignedPos(0, false)
  self._positionHelper:OnLateUpdate({
    userInfo = {unscaledDeltaTime = 0}
  })
  self:MoveMid(bm_towerv2:GetCurrentFloorIndex(), true)
end

function TowerV2SceneParts:RefreshTeam()
  local roles = table.select(NekoData.BehaviorManager.BM_Team:GetTowerTeamsInfo()[1001].roles, function(v, k)
    return {id = v, station = k}
  end)
  roles = table.todict(roles, function(_, role)
    return role.station
  end, function(_, role)
    return role.id
  end)
  local diff = self._roles == nil
  if self._roles then
    for station, id in pairs(roles) do
      if id ~= self._roles[station] then
        diff = true
      end
    end
  end
  self._roles = roles
  local headAssetbundles = {}
  local headAssetNames = {}
  local rawImages = {}
  for station, id in pairs(roles) do
    if id ~= 0 then
      local hp = bm_towerv2:GetRoleHP(id)
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(id)
      local img = role:GetDiamondHeadImageRecord()
      if img ~= DataCommon.DefaultImageAsset then
        table.insert(headAssetbundles, img.assetBundle)
        table.insert(headAssetNames, img.assetName)
        table.insert(rawImages, self._delegate._teams[station].icon:GetRawImage())
      else
        LogErrorFormat("DungeonHUD", "there is no diamondHeadImage for role %d", key)
      end
      self._delegate._teams[station].hp:SetFillAmount(hp)
    else
      self._delegate._teams[station].hp:SetFillAmount(1)
    end
    if roles[station + 3] and roles[station + 3] ~= 0 then
      self._delegate._teams.links[station]:SetActive(true)
    elseif self._delegate._teams.links[station] then
      self._delegate._teams.links[station]:SetActive(false)
    end
  end
  if diff and self._runtimePackerLuaAgent then
    self._runtimePackerLuaAgent:Release()
    self._runtimePackerLuaAgent = nil
  end
  if not self._runtimePackerLuaAgent then
    self._runtimePackerLuaAgent = CS.PixelNeko.UI.RuntimePackerStaticFunctions.GenerateAtlasIntoRT(rawImages, headAssetbundles, headAssetNames)
  end
end

local function cache_position_cell_size()
  local dlg = DialogManager.CreateSingletonDialog("towerv2.scene.towerv2progresssmallcell")
  local width = dlg:GetRootWindow():GetRectSize()
  dlg:Destroy()
  return width
end

function TowerV2SceneParts:Init()
  self._positionFrameWidth = self._delegate._positionFrame:GetRectSize()
  _, self._positionYPosAnchored = self._delegate._positionMark:GetAnchoredPosition()
  self._positionWidth = cache_position_cell_size()
  TransformStaticFunctions.SetParent(self._delegate._positionMark:GetUIObject().transform, self._delegate._positionFrame:GetUIObject().transform, true)
  self._positionHelper:ReloadAllCell()
  local left = self._positionHelper:GetLeftIndex()
  local right = self._positionHelper:GetRightIndex()
  local length = right - left + 1
  local mid = math.ceil(length / 2)
  self._positionInfo = {length = length, mid = mid}
  self:ResetMark()
  self._timeoutTask = GameTimer.AddTask(0, 60, self.RefreshTimeout, self)
end

function TowerV2SceneParts:RefreshTimeout()
  local sec = (bm_towerv2:GetRefreshTime() - 60000) // 1000
  local str = TextManager.GetText(700770)
  str = string.gsub(str, "%$parameter1%$", math.floor(os.date("!%d", sec) - 1))
  str = string.gsub(str, "%$parameter2%$", os.date("!%H", sec))
  self._delegate._refesh.text:SetText(str)
end

function TowerV2SceneParts:OnBuffClick()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(62) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(62)
  end
  DialogManager.CreateSingletonDialog("towerv2.towerv2buffdialog"):Refresh()
  bm_towerv2:SetBuffRedpoint(false)
  self:Refresh()
end

function TowerV2SceneParts:OnPreviewRewardClick()
  LuaNotificationCenter.AddObserver(self, self.OnPreviewReward, Common.n_TowerV2PreviewReward)
  bm_towerv2:RequestRewardPreview()
end

function TowerV2SceneParts:OnPreviewReward()
  DialogManager.CreateSingletonDialog("towerv2.towerv2rewardpreviewdialog")
  LuaNotificationCenter.RemoveObserver(self, Common.n_TowerV2PreviewReward)
end

local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")

function TowerV2SceneParts:OnTeamCharClicked(i)
  if self._roles[i] and self._roles[i] ~= 0 then
    local role = read_only_cast(NekoData.BehaviorManager.BM_AllRoles:GetRole(self._roles[i]):Clone())
    local max = role:GetMaxHp()
    role:SetProperties({
      [AttrTypeEnum.HP] = math.ceil(bm_towerv2:GetRoleHP(role:GetId()) * max)
    })
    local dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
    dialog:Refresh(role)
  end
end

function TowerV2SceneParts:MoveMid(index, instant)
  self._index = index
  local total_num = self:NumberOfCell(self._positionHelper)
  local left = self._positionHelper:GetLeftIndex()
  local right = self._positionHelper:GetRightIndex()
  if instant then
    self._positionHelper:MoveToAssignedPos(math.max(1, math.min(index - 1, total_num - self._positionInfo.length + 1)), false)
    self._positionHelper:UpdateView(0)
    self:SetMarkScreenPos(index, true)
  elseif 1 <= index - left and 2 < index and right ~= total_num then
    self._positionHelper:MoveToAssignedPos(index - 1, true)
    self._positionHelper:UpdateView(0)
  else
    self:SetMarkScreenPos(index, false)
  end
  self._positionHelper:FireEvent("refresh")
end

function TowerV2SceneParts:SetMarkScreenPos(index, instant)
  local _, current = self._delegate._positionMark:GetXPosition()
  local delta = math.max(index - self._positionHelper:GetLeftIndex(), 0)
  self._markDest = delta * self._positionWidth
  if instant then
    self._delegate._positionMark:SetXPosition(0, self._markDest)
  else
    self._markTask = Tween.new(event_spawn_time, {x = current}, {
      x = self._markDest
    }, "linear")
  end
end

function TowerV2SceneParts:OnUpdate(deltaTime, unscaledDeltaTime)
  if self._markTask then
    if self._markTask:update(deltaTime) then
      self._delegate._positionMark:SetXPosition(0, self._markDest)
      self._markTask = nil
      self._positionHelper:FireEvent("refresh")
    else
      self._delegate._positionMark:SetXPosition(0, self._markTask.subject.x)
    end
  end
end

function TowerV2SceneParts:OnRefreshSpirit(notification)
  local limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  local current = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._delegate._spirit.text:SetText(tostring(current) .. "/" .. tostring(limit))
  self:RefreshCost()
end

function TowerV2SceneParts:RefreshSpiritRedPoint()
  self._delegate._spirit.reddot:SetActive(self:HaveSpiritItemSoonExpire())
end

function TowerV2SceneParts:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < 86400000 then
      return true
    end
  end
  return false
end

function TowerV2SceneParts:OnSpiritClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function TowerV2SceneParts:OnRefreshInfoClick()
  DialogManager.CreateSingletonDialog("towerv2.towerv2tipdialog")
end

function TowerV2SceneParts:NumberOfCell(helper)
  if helper == self._positionHelper then
    return bm_towerv2:GetFloorCount()
  end
end

function TowerV2SceneParts:CellAtIndex(helper, index)
  if helper == self._positionHelper then
    if index == bm_towerv2:GetFloorCount() then
      return "towerv2.scene.towerv2progresslargecell"
    else
      return "towerv2.scene.towerv2progresssmallcell"
    end
  end
end

function TowerV2SceneParts:DataAtIndex(helper, index)
  return index
end

function TowerV2SceneParts:MoveToAssignedPosTweenParam(helper)
  return event_spawn_time, "linear"
end

function TowerV2SceneParts:OnRankBtnClick()
  DialogManager.CreateSingletonDialog("towerv2.scene.towerv2rankdialog")
end

function TowerV2SceneParts:OnPackBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.crougetowerupdateunreceivedreward")
  csend:Send()
  DialogManager.CreateSingletonDialog("towerv2.scene.towerv2packdialog")
end

return TowerV2SceneParts
