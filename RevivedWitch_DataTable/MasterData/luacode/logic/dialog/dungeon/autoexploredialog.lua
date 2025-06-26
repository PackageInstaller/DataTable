-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/autoexploredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AutoExploreDialog = class("AutoExploreDialog", Dialog)
AutoExploreDialog.AssetBundleName = "ui/layouts.dungeon"
AutoExploreDialog.AssetName = "AutoExplore"
local cvarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local roleNum = 6
local deltaNumBetweenRoleAndAlternate = 3
local waitTime = nil
AutoExploreDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AutoExploreDialog
  ((AutoExploreDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._showTeam = {false, false, false, false, false, false}
  self._finishiTimes = 0
end

AutoExploreDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : roleNum, CStringRes, _ENV
  self._teamIcons = {}
  for i = 1, roleNum do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    (self._teamIcons)[i] = {board = self:GetChild("Char" .. i), icon = self:GetChild("Char" .. i .. "/Back/Photo"), hp = self:GetChild("Char" .. i .. "/Frame")}
    ;
    (((self._teamIcons)[i]).icon):Subscribe_PointerClickEvent(self.OnTeamIconClick, self)
  end
  self._setting = self:GetChild("Setting")
  self._leave = self:GetChild("Leave")
  self._progress = {bar = self:GetChild("Loading/Background/Progress"), text = self:GetChild("Num/Num"), current = -1, target = 0, total = 0}
  self._effect = self:GetChild("Num/Num/Effect")
  self._icon = self:GetChild("Loading/Background/CharBack")
  self._countNumPanel = self:GetChild("CountNum")
  self._countNum = self:GetChild("CountNum/Num")
  self._countNumMax = self:GetChild("CountNum/NumMax")
  self._countDownPanel = self:GetChild("CountDown")
  self._countDownTxt = self:GetChild("CountDown/Text")
  local str = (CStringRes:GetRecorder(1418)).msgTextID
  str = (TextManager.GetText)(str)
  ;
  (self._countDownTxt):SetText(str)
  self._countDownNum = self:GetChild("CountDown/Num")
  self._countDownFinishiBtn = self:GetChild("CountDown/StopBtn")
  ;
  (self._countDownFinishiBtn):Subscribe_PointerClickEvent(self.FinishiCountDown, self)
  ;
  (self._leave):Subscribe_PointerClickEvent(self.OnLeaveClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetTeamInfo, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  local autoExploreTimes = ((NekoData.BehaviorManager).BM_Game):GetAutoExploreTimes()
  if autoExploreTimes then
    (self._countNumPanel):SetActive(true)
    ;
    (self._countNum):SetText(autoExploreTimes.current)
    ;
    (self._countNumMax):SetText(autoExploreTimes.totle)
  end
  _ = ((self._progress).bar):GetWidth()
end

AutoExploreDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, AutoExploreDialog
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  ((AutoExploreDialog.super).OnDestroy)(self)
  if self._handler then
    (self._effect):ReleaseEffect(self._handler)
    self._handler = nil
  end
end

AutoExploreDialog.OnLeaveClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller and controller:CanPause() then
    controller:Pause()
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(36, nil, function()
    -- function num : 0_3_0 , upvalues : _ENV
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
    req:Send()
  end
, nil, function()
    -- function num : 0_3_1 , upvalues : controller
    controller:Resume()
  end
)
  end
end

AutoExploreDialog.OnTeamIconClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100082)
end

AutoExploreDialog.SetData = function(self, current, total)
  -- function num : 0_5 , upvalues : _ENV
  local showProgressIncrease = false
  if current < total then
    showProgressIncrease = true
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

    if (self._progress).current == -1 then
      (self._progress).current = current
    end
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  if showProgressIncrease then
    (self._progress).target = current + 1
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._progress).total = total
    self._subject = {v = (self._progress).current}
    self._target = {v = (self._progress).target}
    local time = tonumber((((BeanManager.GetTableByName)("battle.cbattleconstcfg")):GetRecorder(75)).attr)
    self._tween = (Tween.new)(time, self._subject, self._target)
  else
    do
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._progress).current = current
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._progress).target = current
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._progress).total = total
      ;
      ((self._progress).bar):SetFillAmount(current / total)
      ;
      (self._icon):SetXPosition(0, self._initialLength)
      ;
      ((self._progress).text):SetText((math.floor)(current / total * 100) .. "%")
      self:SetTeamInfo()
    end
  end
end

AutoExploreDialog.OnUpdate = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if self._tween then
    local finish = (self._tween):update((notification.userInfo).deltaTime)
    local ratio = (math.min)(1, (self._subject).v / (self._progress).total)
    ;
    ((self._progress).bar):SetFillAmount(ratio)
    ;
    ((self._progress).text):SetText((math.floor)(ratio * 100) .. "%")
    ;
    (self._icon):SetXPosition(0, ratio * self._initialLength)
    if finish then
      self._tween = nil
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._progress).current = (self._progress).target
    end
  end
  do
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller and controller.CanPause then
      (self._leave):SetActive(controller:CanPause())
    end
  end
end

AutoExploreDialog.PlayEndEffect = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._future = {Run = function()
    -- function num : 0_7_0 , upvalues : self, _ENV
    self._handler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1031))
    ;
    (self._effect):Subscribe_UIEffectEndEvent(self.OnEffectEnd, self)
    local autoExploreTimes = ((NekoData.BehaviorManager).BM_Game):GetAutoExploreTimes()
    if autoExploreTimes then
      (self._countNum):SetText(autoExploreTimes.current)
    end
  end
, Then = function(_, callback)
    -- function num : 0_7_1 , upvalues : self
    self._callback = callback
  end
}
  return self._future
end

AutoExploreDialog.End = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local autoExploreTimes = ((NekoData.BehaviorManager).BM_Game):GetAutoExploreTimes()
  if autoExploreTimes then
    (self._countNum):SetText(autoExploreTimes.current)
  end
end

AutoExploreDialog.OnEffectEnd = function(self)
  -- function num : 0_9
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateUpdate, self)
  ;
  (self:GetRootWindow()):PlayAnimation("AutoExploreHide")
end

AutoExploreDialog.OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_10
  if stateName == "AutoExploreHide" and self._callback then
    (self._callback)()
  end
end

AutoExploreDialog.SetTeamInfo = function(self)
  -- function num : 0_11 , upvalues : _ENV, LineUpStation, deltaNumBetweenRoleAndAlternate, roleNum
  self._curTeamId = ((NekoData.BehaviorManager).BM_Team):GetCurrentTeamId()
  local teamRole = {}
  if self._curTeamId then
    teamRole = ((((NekoData.BehaviorManager).BM_Team):GetTeamsInfo())[self._curTeamId]).roles
  end
  local i = 1
  local goInBattleRoleIndex = 1
  self._roleList = {}
  for station,key in pairs(teamRole) do
    if key ~= 0 then
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
      if station == LineUpStation.FRONT_ROW or station == LineUpStation.MIDDLE_ROW or station == LineUpStation.BACK_ROW then
        if not role then
          LogErrorFormat("autoexplore", "wrong role key %d", key)
        else
          -- DECOMPILER ERROR at PC56: Confused about usage of register: R10 in 'UnsetPending'

          if (self._teamIcons)[goInBattleRoleIndex] then
            (self._roleList)[i] = role
            local img = role:GetDiamondHeadImageRecord()
            if img ~= DataCommon.DefaultImageAsset then
              (((self._teamIcons)[goInBattleRoleIndex]).icon):SetSprite(img.assetBundle, img.assetName)
            else
              LogErrorFormat("autoexplore", "there is no diamondHeadImage for role %d", key)
            end
            local roles = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
            for _,v in pairs(roles) do
              if key == v:GetRoleId() then
                (((self._teamIcons)[goInBattleRoleIndex]).hp):SetFillAmount(v:GetCurrentHp() / v:GetMaxHp())
              end
            end
            -- DECOMPILER ERROR at PC102: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (self._showTeam)[goInBattleRoleIndex] = true
          end
        end
        do
          local alternateRoleId = teamRole[station + deltaNumBetweenRoleAndAlternate]
          if alternateRoleId and alternateRoleId ~= 0 then
            i = i + 1
            role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(alternateRoleId)
            if not role then
              LogErrorFormat("DungeonHUD", "wrong alternate role id %d", alternateRoleId)
            else
              -- DECOMPILER ERROR at PC127: Confused about usage of register: R11 in 'UnsetPending'

              ;
              (self._roleList)[i] = role
              local img = role:GetDiamondHeadImageRecord()
              if img ~= DataCommon.DefaultImageAsset then
                (((self._teamIcons)[goInBattleRoleIndex + deltaNumBetweenRoleAndAlternate]).icon):SetSprite(img.assetBundle, img.assetName)
              else
                LogErrorFormat("autoexplore", "there is no diamondHeadImage for role %d", key)
              end
              local roles = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
              for _,v in pairs(roles) do
                if key == v:GetRoleId() then
                  (((self._teamIcons)[goInBattleRoleIndex + deltaNumBetweenRoleAndAlternate]).hp):SetFillAmount(v:GetCurrentHp() / v:GetMaxHp())
                end
              end
              -- DECOMPILER ERROR at PC179: Confused about usage of register: R13 in 'UnsetPending'

              ;
              (self._showTeam)[goInBattleRoleIndex + deltaNumBetweenRoleAndAlternate] = true
            end
          end
          do
            do
              do
                goInBattleRoleIndex = goInBattleRoleIndex + 1
                i = i + 1
                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC182: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  for index = 1, roleNum do
    (((self._teamIcons)[index]).board):SetActive((self._showTeam)[index])
  end
end

AutoExploreDialog.StartCountDown = function(self)
  -- function num : 0_12 , upvalues : waitTime, _ENV, cvarconfig
  if self._task then
    return 
  end
  waitTime = tonumber((cvarconfig:GetRecorder(64)).Value)
  local str = tostring(waitTime)
  ;
  (self._countDownNum):SetText(str)
  ;
  (self._countDownPanel):SetActive(true)
  self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_12_0 , upvalues : self
    self:CountDown()
  end
, nil)
end

AutoExploreDialog.CountDown = function(self)
  -- function num : 0_13 , upvalues : waitTime, _ENV
  waitTime = waitTime - 1
  local str = tostring(waitTime)
  ;
  (self._countDownNum):SetText(str)
  if waitTime < 1 then
    (self._countDownPanel):SetActive(false)
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

AutoExploreDialog.FinishiCountDown = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
    if controller and controller._type == type.ACTIVITY then
      local CEVENTLIST = (BeanManager.GetTableByName)("dungeonselect.ceventlist")
      local summeractivityEvents = (CEVENTLIST:GetRecorder((DataCommon.Activities).SwimSuit)).levenid
      local summerEchoesactivityEvents = (CEVENTLIST:GetRecorder((DataCommon.Activities).SummerEchoes)).levenid
      if (table.contain)(summeractivityEvents, controller._zoneID) and ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(21) then
        ((LuaNetManager.CreateProtocol)("protocol.battle.cfinishautoexplorewithoutback")):Send()
        local req = (LuaNetManager.CreateProtocol)("protocol.activity.cgetsummeractivityinfo")
        req:Send()
        ;
        ((NekoData.DataManager).DM_Game):ClearAutoExploreData()
        return 
      else
        do
          do
            if (table.contain)(summerEchoesactivityEvents, controller._zoneID) and ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(161) then
              ((LuaNetManager.CreateProtocol)("protocol.battle.cfinishautoexplorewithoutback")):Send()
              ;
              (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):SendCGetSummerEchoInfo()
              ;
              ((NekoData.DataManager).DM_Game):ClearAutoExploreData()
              return 
            end
            ;
            ((NekoData.DataManager).DM_Game):ClearAutoExploreData()
            local req = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
            req:Send()
          end
        end
      end
    end
  end
end

return AutoExploreDialog

