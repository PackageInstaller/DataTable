-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/scene/towerv2sceneparts.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2SceneParts = class("TowerV2SceneParts")
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
local cstairlevelcfg = (BeanManager.GetTableByName)("dungeonselect.cstairlevelcfg")
local ProgressHorizontalTableFrame = require("logic.dialog.towerv2.scene.progresshorizontaltableframe")
local event_spawn_time = tonumber((((BeanManager.GetTableByName)("dungeonselect.cstairvarcfg")):GetRecorder(3)).value)
TowerV2SceneParts.Ctor = function(self, delegate)
  -- function num : 0_0
  self._delegate = delegate
end

TowerV2SceneParts.OnCreate = function(self)
  -- function num : 0_1 , upvalues : ProgressHorizontalTableFrame, _ENV
  self._positionHelper = (ProgressHorizontalTableFrame.Create)((self._delegate)._positionFrame, self, false, false, "Viewport")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_StrengthLimitChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritRedPoint, Common.n_ItemNumModify, nil)
end

TowerV2SceneParts.Destroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._positionHelper):Destroy()
  if self._task then
    (GameTimer.RemoveTask)(self._task)
  end
  if self._accountTimer then
    (GameTimer.RemoveTask)(self._accountTimer)
  end
  if self._timeoutTask then
    (GameTimer.RemoveTask)(self._timeoutTask)
  end
  if self._runtimePackerLuaAgent then
    (self._runtimePackerLuaAgent):Release()
    self._runtimePackerLuaAgent = nil
  end
end

local show_progress_text = function(self, show)
  -- function num : 0_3
  ((((self._delegate)._progress).text).value):SetActive(show)
  ;
  ((((self._delegate)._progress).text).desc):SetActive(show)
  ;
  (((self._delegate)._progress).start):SetActive(not show)
end

TowerV2SceneParts.Refresh = function(self)
  -- function num : 0_4 , upvalues : bm_towerv2, cstairlevelcfg, show_progress_text, _ENV
  self:OnRefreshSpirit()
  self:RefreshSpiritRedPoint()
  local state = bm_towerv2:GetState()
  local current_floor = bm_towerv2:GetCurrentFloorID()
  local recorder = cstairlevelcfg:GetRecorder(current_floor)
  if state == "fresh" then
    if current_floor == (cstairlevelcfg:GetAllIds())[1] then
      show_progress_text(self, false)
    else
      show_progress_text(self, true)
    end
  else
    if state == "retreat" then
      show_progress_text(self, true)
    else
      if state == "continue" or state == "finished" then
        show_progress_text(self, true)
      else
        if state == "reset" or state == "buffchoose" then
          show_progress_text(self, true)
        end
      end
    end
  end
  ;
  ((self._delegate)._nodeCount):SetText(bm_towerv2:GetReachedCount())
  ;
  ((self._delegate)._nodeTotal):SetText(bm_towerv2:GetFloorTotalCount())
  ;
  ((self._delegate)._rewardRedpoint):SetActive(bm_towerv2:RewardHasRedpoint())
  ;
  ((self._delegate)._buffRedpoint):SetActive(bm_towerv2:BuffHasRedpoint())
  ;
  ((((self._delegate)._progress).text).value):SetText((TextManager.GetText)(recorder.name))
  self:RefreshCost()
  self:RefreshTeam()
end

TowerV2SceneParts.RefreshCost = function(self)
  -- function num : 0_5 , upvalues : bm_towerv2, _ENV
  local cost = bm_towerv2:GetSpiritCost(bm_towerv2:GetCurrentFloorID())
  if cost == 0 then
    cost = ((bm_towerv2:GetFloorInfoByIndex(1)).cfg).apCost
  end
  ;
  (((self._delegate)._cost).value):SetText(tostring(cost))
  ;
  (((self._delegate)._cost).insufficient):SetText(tostring(cost))
  local insufficient = ((NekoData.BehaviorManager).BM_Currency):GetSpirit() < cost
  ;
  (((self._delegate)._cost).value):SetActive(not insufficient)
  ;
  (((self._delegate)._cost).insufficient):SetActive(insufficient)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TowerV2SceneParts.RefreshTimeout = function(self)
  -- function num : 0_6 , upvalues : bm_towerv2, _ENV
  local sec = (bm_towerv2:GetRefreshTime() - 60000) // 1000
  local str = (TextManager.GetText)(700770)
  str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
  ;
  (((self._delegate)._refesh).text):SetText(str)
end

TowerV2SceneParts.ResetMark = function(self)
  -- function num : 0_7 , upvalues : bm_towerv2
  (self._positionHelper):MoveToAssignedPos(0, false)
  ;
  (self._positionHelper):OnLateUpdate({
userInfo = {unscaledDeltaTime = 0}
})
  self:MoveMid(bm_towerv2:GetCurrentFloorIndex(), true)
end

TowerV2SceneParts.RefreshTeam = function(self)
  -- function num : 0_8 , upvalues : _ENV, bm_towerv2
  local roles = (table.select)(((((NekoData.BehaviorManager).BM_Team):GetTowerTeamsInfo())[1001]).roles, function(v, k)
    -- function num : 0_8_0
    return {id = v, station = k}
  end
)
  roles = (table.todict)(roles, function(_, role)
    -- function num : 0_8_1
    return role.station
  end
, function(_, role)
    -- function num : 0_8_2
    return role.id
  end
)
  local diff = self._roles == nil
  if self._roles then
    for station,id in pairs(roles) do
      if id ~= (self._roles)[station] then
        diff = true
      end
    end
  end
  self._roles = roles
  local headAssetbundles = {}
  local headAssetNames = {}
  local rawImages = {}
  for station,id in pairs(roles) do
    if id ~= 0 then
      local hp = bm_towerv2:GetRoleHP(id)
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(id)
      local img = role:GetDiamondHeadImageRecord()
      if img ~= DataCommon.DefaultImageAsset then
        (table.insert)(headAssetbundles, img.assetBundle)
        ;
        (table.insert)(headAssetNames, img.assetName)
        ;
        (table.insert)(rawImages, ((((self._delegate)._teams)[station]).icon):GetRawImage())
      else
        LogErrorFormat("DungeonHUD", "there is no diamondHeadImage for role %d", key)
      end
      ;
      ((((self._delegate)._teams)[station]).hp):SetFillAmount(hp)
    else
      ((((self._delegate)._teams)[station]).hp):SetFillAmount(1)
    end
    if roles[station + 3] and roles[station + 3] ~= 0 then
      ((((self._delegate)._teams).links)[station]):SetActive(true)
    elseif (((self._delegate)._teams).links)[station] then
      ((((self._delegate)._teams).links)[station]):SetActive(false)
    end
  end
  if diff and self._runtimePackerLuaAgent then
    (self._runtimePackerLuaAgent):Release()
    self._runtimePackerLuaAgent = nil
  end
  if not self._runtimePackerLuaAgent then
    self._runtimePackerLuaAgent = ((((CS.PixelNeko).UI).RuntimePackerStaticFunctions).GenerateAtlasIntoRT)(rawImages, headAssetbundles, headAssetNames)
  end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

local cache_position_cell_size = function()
  -- function num : 0_9 , upvalues : _ENV
  local dlg = (DialogManager.CreateSingletonDialog)("towerv2.scene.towerv2progresssmallcell")
  local width = (dlg:GetRootWindow()):GetRectSize()
  dlg:Destroy()
  return width
end

TowerV2SceneParts.Init = function(self)
  -- function num : 0_10 , upvalues : _ENV, cache_position_cell_size, TransformStaticFunctions
  self._positionFrameWidth = ((self._delegate)._positionFrame):GetRectSize()
  _ = ((self._delegate)._positionMark):GetAnchoredPosition()
  self._positionWidth = cache_position_cell_size()
  ;
  (TransformStaticFunctions.SetParent)((((self._delegate)._positionMark):GetUIObject()).transform, (((self._delegate)._positionFrame):GetUIObject()).transform, true)
  ;
  (self._positionHelper):ReloadAllCell()
  local left = (self._positionHelper):GetLeftIndex()
  local right = (self._positionHelper):GetRightIndex()
  local length = right - left + 1
  local mid = (math.ceil)(length / 2)
  self._positionInfo = {length = length, mid = mid}
  self:ResetMark()
  self._timeoutTask = (GameTimer.AddTask)(0, 60, self.RefreshTimeout, self)
end

TowerV2SceneParts.RefreshTimeout = function(self)
  -- function num : 0_11 , upvalues : bm_towerv2, _ENV
  local sec = (bm_towerv2:GetRefreshTime() - 60000) // 1000
  local str = (TextManager.GetText)(700770)
  str = (string.gsub)(str, "%$parameter1%$", (math.floor)((os.date)("!%d", sec) - 1))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%H", sec))
  ;
  (((self._delegate)._refesh).text):SetText(str)
end

TowerV2SceneParts.OnBuffClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, bm_towerv2
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(62) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(62)
  end
  ;
  ((DialogManager.CreateSingletonDialog)("towerv2.towerv2buffdialog")):Refresh()
  bm_towerv2:SetBuffRedpoint(false)
  self:Refresh()
end

TowerV2SceneParts.OnPreviewRewardClick = function(self)
  -- function num : 0_13 , upvalues : _ENV, bm_towerv2
  (LuaNotificationCenter.AddObserver)(self, self.OnPreviewReward, Common.n_TowerV2PreviewReward)
  bm_towerv2:RequestRewardPreview()
end

TowerV2SceneParts.OnPreviewReward = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("towerv2.towerv2rewardpreviewdialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_TowerV2PreviewReward)
end

local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
TowerV2SceneParts.OnTeamCharClicked = function(self, i)
  -- function num : 0_15 , upvalues : _ENV, AttrTypeEnum, bm_towerv2
  if (self._roles)[i] and (self._roles)[i] ~= 0 then
    local role = read_only_cast((((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._roles)[i])):Clone())
    local max = role:GetMaxHp()
    role:SetProperties({[AttrTypeEnum.HP] = (math.ceil)(bm_towerv2:GetRoleHP(role:GetId()) * max)})
    local dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
    dialog:Refresh(role)
  end
end

TowerV2SceneParts.MoveMid = function(self, index, instant)
  -- function num : 0_16 , upvalues : _ENV
  self._index = index
  local total_num = self:NumberOfCell(self._positionHelper)
  local left = (self._positionHelper):GetLeftIndex()
  local right = (self._positionHelper):GetRightIndex()
  if instant then
    (self._positionHelper):MoveToAssignedPos((math.max)(1, (math.min)(index - 1, total_num - (self._positionInfo).length + 1)), false)
    ;
    (self._positionHelper):UpdateView(0)
    self:SetMarkScreenPos(index, true)
  else
    if index - left >= 1 and index > 2 and right ~= total_num then
      (self._positionHelper):MoveToAssignedPos(index - 1, true)
      ;
      (self._positionHelper):UpdateView(0)
    else
      self:SetMarkScreenPos(index, false)
    end
  end
  ;
  (self._positionHelper):FireEvent("refresh")
end

TowerV2SceneParts.SetMarkScreenPos = function(self, index, instant)
  -- function num : 0_17 , upvalues : _ENV, event_spawn_time
  local _, current = ((self._delegate)._positionMark):GetXPosition()
  local delta = (math.max)(index - (self._positionHelper):GetLeftIndex(), 0)
  self._markDest = delta * self._positionWidth
  if instant then
    ((self._delegate)._positionMark):SetXPosition(0, self._markDest)
  else
    self._markTask = (Tween.new)(event_spawn_time, {x = current}, {x = self._markDest}, "linear")
  end
end

TowerV2SceneParts.OnUpdate = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_18
  if self._markTask then
    if (self._markTask):update(deltaTime) then
      ((self._delegate)._positionMark):SetXPosition(0, self._markDest)
      self._markTask = nil
      ;
      (self._positionHelper):FireEvent("refresh")
    else
      ;
      ((self._delegate)._positionMark):SetXPosition(0, ((self._markTask).subject).x)
    end
  end
end

TowerV2SceneParts.OnRefreshSpirit = function(self, notification)
  -- function num : 0_19 , upvalues : _ENV
  local limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  local current = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (((self._delegate)._spirit).text):SetText(tostring(current) .. "/" .. tostring(limit))
  self:RefreshCost()
end

TowerV2SceneParts.RefreshSpiritRedPoint = function(self)
  -- function num : 0_20
  (((self._delegate)._spirit).reddot):SetActive(self:HaveSpiritItemSoonExpire())
end

TowerV2SceneParts.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < 86400000 then
      return true
    end
  end
  return false
end

TowerV2SceneParts.OnSpiritClick = function(self)
  -- function num : 0_22 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

TowerV2SceneParts.OnRefreshInfoClick = function(self)
  -- function num : 0_23 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("towerv2.towerv2tipdialog")
end

TowerV2SceneParts.NumberOfCell = function(self, helper)
  -- function num : 0_24 , upvalues : bm_towerv2
  if helper == self._positionHelper then
    return bm_towerv2:GetFloorCount()
  end
end

TowerV2SceneParts.CellAtIndex = function(self, helper, index)
  -- function num : 0_25 , upvalues : bm_towerv2
  if helper == self._positionHelper then
    if index == bm_towerv2:GetFloorCount() then
      return "towerv2.scene.towerv2progresslargecell"
    else
      return "towerv2.scene.towerv2progresssmallcell"
    end
  end
end

TowerV2SceneParts.DataAtIndex = function(self, helper, index)
  -- function num : 0_26
  return index
end

TowerV2SceneParts.MoveToAssignedPosTweenParam = function(self, helper)
  -- function num : 0_27 , upvalues : event_spawn_time
  return event_spawn_time, "linear"
end

return TowerV2SceneParts

