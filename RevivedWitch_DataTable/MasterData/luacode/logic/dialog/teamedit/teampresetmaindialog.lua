-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/teampresetmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CElementEffect = (BeanManager.GetTableByName)("role.celementeffect")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local TeamPresetMainDialog = class("TeamPresetMainDialog", Dialog)
TeamPresetMainDialog.AssetBundleName = "ui/layouts.teamedit"
TeamPresetMainDialog.AssetName = "TeamEditMainNew"
local roleNum = 6
local testBattleId = 1184
local testBattleSceneId = 20007
TeamPresetMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TeamPresetMainDialog
  ((TeamPresetMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
  self._teamList = {}
  self._teamId = nil
  self._teamIdList = {}
  self._curTeamRoles = {}
  self._charLargeCell = {}
  self._tempChangeRoleList = nil
  self._oneTimeChangingCurTeamRoles = {}
  self._dialogStr = "teamedit.characterlargecell"
  self._noResponse = true
end

TeamPresetMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, roleNum
  self._btn1 = self:GetChild("Btn1")
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._teamBtn = {}
  for i,c in ipairs({"A", "B", "C", "D", "E"}) do
    do
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

      (self._teamBtn)[i] = {btn = self:GetChild("TopPanel/Team" .. c), name = self:GetChild("TopPanel/Team" .. c .. "/Text"), editBtn = self:GetChild("TopPanel/Team" .. c .. "/Edit")}
      ;
      (((self._teamBtn)[i]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnTeamClicked(i)
  end
)
      if ((self._teamBtn)[i]).editBtn then
        (((self._teamBtn)[i]).editBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnTeamNameEditClicked()
  end
)
      end
    end
  end
  self._pos = {}
  for i = 1, roleNum do
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

    (self._pos)[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i)
    ;
    ((self._pos)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self, i
    self:OnCharPosClicked(i)
  end
)
  end
  self._posLock = {}
  for i = 4, roleNum do
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

    (self._posLock)[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i .. "Lock")
    ;
    ((self._posLock)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self, i
    self:OnCharPosLockClicked(i)
  end
)
    if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AlterNativeRole) then
      ((self._posLock)[i]):SetActive(true)
    else
      ;
      ((self._posLock)[i]):SetActive(false)
    end
  end
  self._switchPositionBtn = self:GetChild("SwitchPositionBtn")
  self._switchPositionBlack = self:GetChild("SwitchPositionBlack")
  self._switchFinishBtn = self:GetChild("SwitchFinishBtn")
  self._testTeamBtn = self:GetChild("Btn4")
  self._elementImg = self:GetChild("ElementStage/Element")
  self._elementContentTxt = self:GetChild("ElementStage/Txt1")
  self._elementContentNum = self:GetChild("ElementStage/Txt2")
  self._elementContentTxtRectX = (self._elementContentTxt):GetRectSize()
  self._elementContentTxtWidthX = (self._elementContentTxt):GetWidth(self._elementContentTxtWidthOX)
  self._elementContentNumPosX = (self._elementContentNum):GetPosition()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._btn1):Subscribe_PointerClickEvent(self.OnBtn1Clicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._switchPositionBtn):Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  ;
  (self._switchFinishBtn):Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  ;
  (self._testTeamBtn):Subscribe_PointerClickEvent(self.OnTestTeamBtnClicked, self)
  ;
  (self._elementImg):Subscribe_PointerClickEvent(self.OnElementBtnClicked, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  self:LoadLocalData()
  local currentTeamId = ((NekoData.BehaviorManager).BM_Team):GetCurrentTeamId()
  if currentTeamId == 5001 then
    currentTeamId = 1
  end
  self:Refresh(currentTeamId)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTeam, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTeam, Common.n_TeamInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFashion, Common.n_RefreshFashion, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLoadBattleEffectEnd, Common.n_LoadBattleEffectEnd, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

TeamPresetMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  ;
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TeamPresetMainDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._baseSceneController = sceneController
end

TeamPresetMainDialog.OnRefreshTeam = function(self, notification)
  -- function num : 0_4
  self:LoadLocalData()
  self:Refresh(self._teamId)
  if (notification.userInfo).name == "schangeroles" and self._haveSendCConfirmRolesBeforeEnterDungeon then
    self._haveSendCConfirmRolesBeforeEnterDungeon = false
    self:BeginTestBtnClicked()
  end
end

TeamPresetMainDialog.RefreshFashion = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for posi,_ in ipairs(self._pos) do
    local index = nil
    for i,v in ipairs(self._curTeamRoles) do
      if posi == v.station and v.roleKey ~= 0 then
        index = i
        break
      end
    end
    do
      if (self._charLargeCell)[posi] then
        ((self._charLargeCell)[posi]):Destroy()
        ;
        ((self._charLargeCell)[posi]):RootWindowDestroy()
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._charLargeCell)[posi] = nil
      end
      do
        if index then
          local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[posi])._uiObject)
          cell:RefreshCell((self._curTeamRoles)[index], self)
          -- DECOMPILER ERROR at PC48: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._charLargeCell)[posi] = cell
        end
        -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

TeamPresetMainDialog.LoadLocalData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self._teamList = ((NekoData.BehaviorManager).BM_Team):GetTeamsInfo()
  self._teamIdList = {}
  for id,_ in pairs(self._teamList) do
    (table.insert)(self._teamIdList, id)
  end
  for id,v in pairs(self._teamList) do
    if (self._teamBtn)[id] and ((self._teamBtn)[id]).name then
      (((self._teamBtn)[id]).name):SetText(v.name)
    end
  end
  ;
  (table.sort)(self._teamIdList, function(a, b)
    -- function num : 0_6_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

TeamPresetMainDialog.Refresh = function(self, teamId)
  -- function num : 0_7 , upvalues : _ENV
  if #self._teamIdList > 0 and teamId and teamId > 0 and (self._teamList)[teamId] then
    self._teamId = teamId
    self._teamInfo = (self._teamList)[teamId]
  end
  if self._teamInfo then
    self._name = (self._teamInfo).name
    for i,v in ipairs(self._teamBtn) do
      if i == teamId then
        (((self._teamBtn)[i]).btn):SetSelected(true)
        if v.editBtn then
          (v.editBtn):SetActive(true)
        end
      else
        ;
        (((self._teamBtn)[i]).btn):SetSelected(false)
        if v.editBtn then
          (v.editBtn):SetActive(false)
        end
      end
    end
    do
      while (self._curTeamRoles)[#self._curTeamRoles] do
        (table.remove)(self._curTeamRoles, #self._curTeamRoles)
      end
      for k,v in pairs((self._teamInfo).roles) do
        local temp = {}
        temp.station = k
        temp.roleKey = v
        ;
        (table.insert)(self._curTeamRoles, temp)
      end
      ;
      (table.sort)(self._curTeamRoles, function(a, b)
    -- function num : 0_7_0
    do return b.station < a.station end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      for posi,_ in ipairs(self._pos) do
        local index = nil
        for i,v in ipairs(self._curTeamRoles) do
          if posi == v.station and v.roleKey ~= 0 then
            index = i
            break
          end
        end
        do
          if (self._charLargeCell)[posi] then
            ((self._charLargeCell)[posi]):Destroy()
            ;
            ((self._charLargeCell)[posi]):RootWindowDestroy()
            -- DECOMPILER ERROR at PC122: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._charLargeCell)[posi] = nil
          end
          do
            if index then
              local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[posi])._uiObject)
              cell:RefreshCell((self._curTeamRoles)[index], self)
              -- DECOMPILER ERROR at PC138: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self._charLargeCell)[posi] = cell
            end
            -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      local tag = false
      for k,v in pairs((self._teamInfo).roles) do
        if v and v ~= 0 then
          tag = true
          break
        end
      end
      do
        ;
        (self._testTeamBtn):SetInteractable(tag)
        self:RefreshTeamElementInfo()
      end
    end
  end
end

TeamPresetMainDialog.RefreshTeamElementInfo = function(self)
  -- function num : 0_8 , upvalues : _ENV, LineUpStation, CElementEffect, CImagePathTable, CStringRes
  local currentTeamRoleList = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(self._teamId)
  local stationElementTag = {}
  local etherStationList = {}
  local ElementType = {Ether = 4}
  local haveTeamInfo = false
  for station,roleId in pairs(currentTeamRoleList) do
    if roleId ~= 0 then
      haveTeamInfo = true
      stationElementTag[station] = (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(roleId)):GetElement()
      if stationElementTag[station] == ElementType.Ether then
        (table.insert)(etherStationList, station)
      end
    end
  end
  self._oneTotalElementValue = nil
  self._elementStage = nil
  if haveTeamInfo then
    if stationElementTag[LineUpStation.FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] ~= ElementType.Ether then
      for _,station in ipairs(etherStationList) do
        stationElementTag[station] = stationElementTag[LineUpStation.FRONT_ROW]
      end
    else
      do
        if stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.MIDDLE_ROW] ~= ElementType.Ether then
          for _,station in ipairs(etherStationList) do
            stationElementTag[station] = stationElementTag[LineUpStation.MIDDLE_ROW]
          end
        else
          do
            if stationElementTag[LineUpStation.BACK_ROW] and stationElementTag[LineUpStation.BACK_ROW] ~= ElementType.Ether then
              for _,station in ipairs(etherStationList) do
                stationElementTag[station] = stationElementTag[LineUpStation.BACK_ROW]
              end
            else
              do
                if stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] ~= ElementType.Ether then
                  for _,station in ipairs(etherStationList) do
                    stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW]
                  end
                else
                  do
                    if stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] ~= ElementType.Ether then
                      for _,station in ipairs(etherStationList) do
                        stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW]
                      end
                    else
                      do
                        if stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] and stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] ~= ElementType.Ether then
                          for _,station in ipairs(etherStationList) do
                            stationElementTag[station] = stationElementTag[LineUpStation.ALTERNATE_BACK_ROW]
                          end
                        end
                        do
                          if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.BACK_ROW] then
                            self._elementStage = 1
                            if stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_FRONT_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_MIDDLE_ROW] and stationElementTag[LineUpStation.FRONT_ROW] == stationElementTag[LineUpStation.ALTERNATE_BACK_ROW] then
                              self._elementStage = 2
                            end
                            self._oneTotalElementValue = stationElementTag[LineUpStation.FRONT_ROW]
                          end
                          local StageType = {NoStage = 0}
                          if self._elementStage then
                            local elementRecord = CElementEffect:GetRecorder(self._elementStage)
                            if not CImagePathTable:GetRecorder(elementRecord.image) then
                              local imgRecord = DataCommon.DefaultImageAsset
                            end
                            ;
                            (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                            local str = (TextManager.GetText)((CStringRes:GetRecorder(1492)).msgTextID)
                            ;
                            (self._elementContentTxt):SetText(str)
                            local delta = (self._elementContentTxt):GetPreferredSize() - self._elementContentTxtRectX
                            ;
                            (self._elementContentTxt):SetWidth(self._elementContentTxtWidthX, self._elementContentTxtWidthOX + delta)
                            ;
                            (self._elementContentNum):SetPosition(self._elementContentNumPosX, self._elementContentNumPosOX + delta, self._elementContentNumPosY, self._elementContentNumPosOY)
                            ;
                            (self._elementContentNum):SetActive(true)
                            ;
                            (self._elementContentNum):SetText(tostring((math.floor)(elementRecord.effect / 1000 * 100)) .. "%")
                          else
                            do
                              local elementRecord = CElementEffect:GetRecorder(StageType.NoStage)
                              if not CImagePathTable:GetRecorder(elementRecord.image) then
                                local imgRecord = DataCommon.DefaultImageAsset
                              end
                              ;
                              (self._elementImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                              ;
                              (self._elementContentTxt):SetText((TextManager.GetText)(elementRecord.describe))
                              local delta = (self._elementContentTxt):GetPreferredSize() - self._elementContentTxtRectX
                              ;
                              (self._elementContentTxt):SetWidth(self._elementContentTxtWidthX, self._elementContentTxtWidthOX + delta)
                              ;
                              (self._elementContentNum):SetActive(false)
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

TeamPresetMainDialog.OnBtn1Clicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(3, nil, function()
    -- function num : 0_9_0 , upvalues : _ENV, self
    local cbreakLineup = (LuaNetManager.CreateProtocol)("protocol.login.cbreaklineup")
    if cbreakLineup then
      cbreakLineup.lineupId = self._teamId
      cbreakLineup:Send()
    end
  end
, {}, nil, {})
end

TeamPresetMainDialog.OnTeamClicked = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  for i,v in ipairs(self._teamBtn) do
    if v.editBtn then
      (v.editBtn):SetActive(false)
    end
  end
  if ((self._teamBtn)[index]).editBtn then
    (((self._teamBtn)[index]).editBtn):SetActive(true)
  end
  self:Refresh((self._teamIdList)[index])
end

TeamPresetMainDialog.OnTeamNameEditClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditchangenamedialog")
  dialog:SetTeamName(self._name, self._teamId)
end

TeamPresetMainDialog.ReturnRoleList = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local roleList = {}
  for _,v in ipairs(self._curTeamRoles) do
    if v.roleKey ~= 0 then
      (table.insert)(roleList, ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v.roleKey))
    end
  end
  return roleList
end

TeamPresetMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

TeamPresetMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

TeamPresetMainDialog.OnCharPosLockClicked = function(self, posIndex)
  -- function num : 0_15 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100244)
end

TeamPresetMainDialog.OnCharPosClicked = function(self, posIndex)
  -- function num : 0_16 , upvalues : _ENV
  if self._inSwitchPositionState or self._noResponse then
    return 
  end
  local index = nil
  for i,v in ipairs(self._curTeamRoles) do
    if posIndex == v.station then
      index = i
      break
    end
  end
  do
    if index then
      local dialog = (DialogManager.CreateSingletonDialog)("teamedit.changeteamroledialog")
      dialog:SetFilterCondition(((NekoData.BehaviorManager).BM_Team):GetTeamFilterCondition())
      dialog:Init(self._teamInfo, (self._curTeamRoles)[index])
    end
  end
end

TeamPresetMainDialog.OnCharCellBeginDrag = function(self, screenPosition, data)
  -- function num : 0_17 , upvalues : CanvasStaticFunctions, _ENV
  self._draging = true
  self._currentDragingCellData = data
  self._tempChangeRoleList = {}
  ;
  ((((self._pos)[data.station])._uiObject).transform):SetAsLastSibling()
  local maxSortingOrderInfo = {order = 0, station = 0}
  local originalOrder = (CanvasStaticFunctions.GetCanvasSortingOrder)((((self._charLargeCell)[data.station]):GetRootWindow())._uiObject)
  for station,cell in pairs(self._charLargeCell) do
    local temp = (CanvasStaticFunctions.GetCanvasSortingOrder)((cell:GetRootWindow())._uiObject)
    if maxSortingOrderInfo.order < temp then
      maxSortingOrderInfo.order = temp
      maxSortingOrderInfo.station = station
    end
  end
  if data.station ~= maxSortingOrderInfo.station then
    (CanvasStaticFunctions.SetCanvasSortingOrder)((((self._charLargeCell)[data.station]):GetRootWindow())._uiObject, maxSortingOrderInfo.order)
    if originalOrder ~= -1 then
      (CanvasStaticFunctions.SetCanvasSortingOrder)((((self._charLargeCell)[maxSortingOrderInfo.station]):GetRootWindow())._uiObject, originalOrder)
    end
  end
end

TeamPresetMainDialog.OnCharCellDrag = function(self, screenPosition, data)
  -- function num : 0_18 , upvalues : UIManager, _ENV
  if (self._charLargeCell)[data.station] then
    (((self._charLargeCell)[data.station]):GetRootWindow()):SetAnchoredPosition((UIManager.ScreenPointToLocalPointInRectangle)(((self._pos)[data.station])._uiObject, screenPosition.x, screenPosition.y))
  else
    LogErrorFormat("TeamPresetMainDialog", "wrong data.station %s in teamcell %s", data.station, self._dialogStr)
  end
end

TeamPresetMainDialog.OnCharCellEndDrag = function(self, screenPosition, data)
  -- function num : 0_19 , upvalues : _ENV, roleNum, UIManager, LineUpStation
  self._draging = false
  for _,v in ipairs(self._oneTimeChangingCurTeamRoles) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R8 in 'UnsetPending'

    (self._tempChangeRoleList)[v.station] = v.roleKey
  end
  for i = 1, roleNum do
    if (UIManager.RectangleContainsScreenPoint)(((self._pos)[i])._uiObject, screenPosition.x, screenPosition.y) then
      local originalRoleInfo = {}
      for _,v in ipairs(self._oneTimeChangingCurTeamRoles) do
        if i == v.station then
          originalRoleInfo.station = v.station
          originalRoleInfo.roleKey = v.roleKey
        end
      end
      do
        if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AlterNativeRole) and (originalRoleInfo.station == LineUpStation.ALTERNATE_FRONT_ROW or originalRoleInfo.station == LineUpStation.ALTERNATE_MIDDLE_ROW or originalRoleInfo.station == LineUpStation.ALTERNATE_BACK_ROW) then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100244)
          break
        end
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R8 in 'UnsetPending'

        if originalRoleInfo.station ~= data.station then
          (self._tempChangeRoleList)[originalRoleInfo.station] = data.roleKey
          -- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._tempChangeRoleList)[data.station] = originalRoleInfo.roleKey
          if (self._charLargeCell)[originalRoleInfo.station] then
            ((self._charLargeCell)[originalRoleInfo.station]):Destroy()
            ;
            ((self._charLargeCell)[originalRoleInfo.station]):RootWindowDestroy()
            -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._charLargeCell)[originalRoleInfo.station] = nil
          end
          do
            if data.roleKey ~= 0 then
              local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[originalRoleInfo.station])._uiObject)
              cell:RefreshCell({station = originalRoleInfo.station, roleKey = data.roleKey}, self)
              -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self._charLargeCell)[originalRoleInfo.station] = cell
            end
            if (self._charLargeCell)[data.station] then
              ((self._charLargeCell)[data.station]):Destroy()
              ;
              ((self._charLargeCell)[data.station]):RootWindowDestroy()
              -- DECOMPILER ERROR at PC136: Confused about usage of register: R8 in 'UnsetPending'

              ;
              (self._charLargeCell)[data.station] = nil
            end
            do
              do
                if originalRoleInfo.roleKey ~= 0 then
                  local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[data.station])._uiObject)
                  cell:RefreshCell({station = data.station, roleKey = originalRoleInfo.roleKey}, self)
                  -- DECOMPILER ERROR at PC158: Confused about usage of register: R9 in 'UnsetPending'

                  ;
                  (self._charLargeCell)[data.station] = cell
                end
                for _,v in ipairs(self._oneTimeChangingCurTeamRoles) do
                  if v.station == originalRoleInfo.station then
                    v.roleKey = data.roleKey
                  end
                  if v.station == data.station then
                    v.roleKey = originalRoleInfo.roleKey
                  end
                end
                do return  end
                do break end
                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  if (self._charLargeCell)[data.station] then
    ((self._charLargeCell)[data.station]):Destroy()
    ;
    ((self._charLargeCell)[data.station]):RootWindowDestroy()
    -- DECOMPILER ERROR at PC197: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._charLargeCell)[data.station] = nil
  end
  if data.roleKey ~= 0 then
    local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[data.station])._uiObject)
    cell:RefreshCell({station = data.station, roleKey = data.roleKey}, self)
    -- DECOMPILER ERROR at PC219: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._charLargeCell)[data.station] = cell
  end
end

TeamPresetMainDialog.OnSwitchPositionBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV, LineUpStation
  if self._inSwitchPositionState then
    if self._draging then
      self:OnCharCellEndDrag({x = 0, y = 0}, self._currentDragingCellData)
    end
    ;
    (self._switchPositionBtn):SetActive(true)
    ;
    (self._switchFinishBtn):SetActive(false)
    self._inSwitchPositionState = false
    ;
    (self._switchPositionBlack):SetActive(false)
    local haveTempChangeRole = false
    for _,v in ipairs(self._curTeamRoles) do
      if self._tempChangeRoleList and (self._tempChangeRoleList)[v.station] and (self._tempChangeRoleList)[v.station] ~= v.roleKey then
        haveTempChangeRole = true
      end
    end
    if haveTempChangeRole then
      local req = (LuaNetManager.CreateProtocol)("protocol.login.cconfirmroles")
      req.lineupId = self._teamId
      req.roles = {[LineUpStation.FRONT_ROW] = (self._tempChangeRoleList)[LineUpStation.FRONT_ROW], [LineUpStation.MIDDLE_ROW] = (self._tempChangeRoleList)[LineUpStation.MIDDLE_ROW], [LineUpStation.BACK_ROW] = (self._tempChangeRoleList)[LineUpStation.BACK_ROW], [LineUpStation.ALTERNATE_FRONT_ROW] = (self._tempChangeRoleList)[LineUpStation.ALTERNATE_FRONT_ROW], [LineUpStation.ALTERNATE_MIDDLE_ROW] = (self._tempChangeRoleList)[LineUpStation.ALTERNATE_MIDDLE_ROW], [LineUpStation.ALTERNATE_BACK_ROW] = (self._tempChangeRoleList)[LineUpStation.ALTERNATE_BACK_ROW]}
      req:Send()
      self._tempChangeRoleList = {}
    end
  else
    do
      ;
      (self._switchPositionBtn):SetActive(false)
      ;
      (self._switchFinishBtn):SetActive(true)
      self._inSwitchPositionState = true
      ;
      (self._switchPositionBlack):SetActive(true)
      self._oneTimeChangingCurTeamRoles = clone(self._curTeamRoles)
    end
  end
end

TeamPresetMainDialog.OnTestTeamBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV, LineUpStation
  local frontRoleId, frontAlternativeRoleId = 0, 0
  local middleRoleId, middleAlternativeRoleId = 0, 0
  local backRoleId, backAlternativeRoleId = 0, 0
  for _,v in ipairs(self._curTeamRoles) do
    if v.station == LineUpStation.FRONT_ROW then
      frontRoleId = v.roleKey
    end
    if v.station == LineUpStation.MIDDLE_ROW then
      middleRoleId = v.roleKey
    end
    if v.station == LineUpStation.BACK_ROW then
      backRoleId = v.roleKey
    end
    if v.station == LineUpStation.ALTERNATE_FRONT_ROW then
      frontAlternativeRoleId = v.roleKey
    end
    if v.station == LineUpStation.ALTERNATE_MIDDLE_ROW then
      middleAlternativeRoleId = v.roleKey
    end
    if v.station == LineUpStation.ALTERNATE_BACK_ROW then
      backAlternativeRoleId = v.roleKey
    end
  end
  local haveOneAlternativeRoleButNoInBattleRole = false
  -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P3

  if (frontRoleId == 0 and frontAlternativeRoleId ~= 0) or middleRoleId ~= 0 or backRoleId == 0 and backAlternativeRoleId ~= 0 then
    haveOneAlternativeRoleButNoInBattleRole = true
  end
  if haveOneAlternativeRoleButNoInBattleRole then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(68, nil, function()
    -- function num : 0_21_0 , upvalues : frontRoleId, frontAlternativeRoleId, middleRoleId, middleAlternativeRoleId, backRoleId, backAlternativeRoleId, _ENV, self, LineUpStation
    if frontRoleId == 0 and frontAlternativeRoleId ~= 0 then
      frontRoleId = frontAlternativeRoleId
      frontAlternativeRoleId = 0
    end
    if middleRoleId == 0 and middleAlternativeRoleId ~= 0 then
      middleRoleId = middleAlternativeRoleId
      middleAlternativeRoleId = 0
    end
    if backRoleId == 0 and backAlternativeRoleId ~= 0 then
      backRoleId = backAlternativeRoleId
      backAlternativeRoleId = 0
    end
    local req = (LuaNetManager.CreateProtocol)("protocol.login.cconfirmroles")
    req.lineupId = self._teamId
    req.roles = {[LineUpStation.FRONT_ROW] = frontRoleId, [LineUpStation.MIDDLE_ROW] = middleRoleId, [LineUpStation.BACK_ROW] = backRoleId, [LineUpStation.ALTERNATE_FRONT_ROW] = frontAlternativeRoleId, [LineUpStation.ALTERNATE_MIDDLE_ROW] = middleAlternativeRoleId, [LineUpStation.ALTERNATE_BACK_ROW] = backAlternativeRoleId}
    req:Send()
    self._haveSendCConfirmRolesBeforeEnterDungeon = true
  end
)
  else
    self:BeginTestBtnClicked()
  end
end

TeamPresetMainDialog.BeginTestBtnClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV, testBattleId, testBattleSceneId
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
  req.battleType = req.TEST
  req.id = testBattleId
  req.battleSceneId = testBattleSceneId
  req.lineupID = self._teamId
  req:Send()
end

TeamPresetMainDialog.OnElementBtnClicked = function(self)
  -- function num : 0_23 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("teamedit.teamelementinfodialog")):SetData(self._oneTotalElementValue, self._elementStage)
end

TeamPresetMainDialog.OnLoadBattleEffectEnd = function(self)
  -- function num : 0_24 , upvalues : _ENV
  local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
end

TeamPresetMainDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_25
  if stateName == "TeamEditShow" then
    self._noResponse = false
  end
end

return TeamPresetMainDialog

