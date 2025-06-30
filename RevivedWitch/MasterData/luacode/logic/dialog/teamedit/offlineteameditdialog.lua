-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/teamedit/offlineteameditdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CElementEffect = (BeanManager.GetTableByName)("role.celementeffect")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local OffLineTeamEditDialog = class("OffLineTeamEditDialog", Dialog)
OffLineTeamEditDialog.AssetBundleName = "ui/layouts.offlinepvp"
OffLineTeamEditDialog.AssetName = "OffLinePVPTeam"
local TEAMID = 3000
local roleNum = 3
OffLineTeamEditDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OffLineTeamEditDialog
  ((OffLineTeamEditDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._teamId = -1
  self._teamInfo = {}
  self._curTeamRoles = {}
  self._charLargeCell = {}
  self._dialogStr = "teamedit.characterlargecell"
end

OffLineTeamEditDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : roleNum, TEAMID, _ENV
  self._btn4 = self:GetChild("Btn4")
  self._panel = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._switchPositionBtn = self:GetChild("SwitchPositionBtn")
  self._switchPositionBlack = self:GetChild("SwitchPositionBlack")
  self._switchFinishBtn = self:GetChild("SwitchFinishBtn")
  self._pos = {}
  for i = 1, roleNum do
    do
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      (self._pos)[i] = self:GetChild("TeamBack/CharacterPanel/CellFrame/Pos" .. i)
      ;
      ((self._pos)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCharPosClicked(i)
  end
)
    end
  end
  self._elementImg = self:GetChild("ElementStage/Element")
  self._elementContentTxt = self:GetChild("ElementStage/Txt1")
  self._elementContentNum = self:GetChild("ElementStage/Txt2")
  self._elementContentTxtRectX = (self._elementContentTxt):GetRectSize()
  self._elementContentTxtWidthX = (self._elementContentTxt):GetWidth(self._elementContentTxtWidthOX)
  self._elementContentNumPosX = (self._elementContentNum):GetPosition()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._btn4):Subscribe_PointerClickEvent(self.OnBtn4Clicked, self)
  ;
  (self._switchPositionBtn):Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  ;
  (self._switchFinishBtn):Subscribe_PointerClickEvent(self.OnSwitchPositionBtnClicked, self)
  ;
  (self._elementImg):Subscribe_PointerClickEvent(self.OnElementBtnClicked, self)
  self._teamId = TEAMID
  self._teamInfo = (((NekoData.BehaviorManager).BM_Team):GetTeamsInfo())[TEAMID]
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_TeamInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFashion, Common.n_RefreshFashion, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_RoleInfoChange, nil)
end

OffLineTeamEditDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

OffLineTeamEditDialog.SetData = function(self, battleId)
  -- function num : 0_3
  self._battleId = battleId
  self:Refresh()
end

OffLineTeamEditDialog.RefreshFashion = function(self)
  -- function num : 0_4 , upvalues : _ENV
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

OffLineTeamEditDialog.Refresh = function(self)
  -- function num : 0_5 , upvalues : _ENV
  while 1 do
    if self._teamInfo then
      if (self._curTeamRoles)[#self._curTeamRoles] then
        (table.remove)(self._curTeamRoles, #self._curTeamRoles)
        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
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
    -- function num : 0_5_0
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
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._charLargeCell)[posi] = nil
      end
      do
        if index then
          local cell = (DialogManager.CreateDialog)(self._dialogStr, ((self._pos)[posi])._uiObject)
          cell:RefreshCell((self._curTeamRoles)[index], self)
          -- DECOMPILER ERROR at PC84: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (self._charLargeCell)[posi] = cell
        end
        -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out DO_STMT

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
    (self._btn4):SetInteractable(tag)
    self:RefreshTeamElementInfo()
  end
end

OffLineTeamEditDialog.RefreshTeamElementInfo = function(self)
  -- function num : 0_6 , upvalues : _ENV, LineUpStation, CElementEffect, CImagePathTable, CStringRes
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

OffLineTeamEditDialog.OnBtn4Clicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattlestart")
  req.battleType = req.ARENA
  req.id = self._battleId
  LogErrorFormat("OffLineTeamEditDialog", "--- battleId = %s ---", self._battleId)
  req.lineupID = self._teamId
  req:Send()
end

OffLineTeamEditDialog.OnCharPosClicked = function(self, posIndex)
  -- function num : 0_8 , upvalues : _ENV
  if self._inSwitchPositionState then
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

OffLineTeamEditDialog.OnCharCellBeginDrag = function(self, screenPosition, data)
  -- function num : 0_9 , upvalues : CanvasStaticFunctions, _ENV
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

OffLineTeamEditDialog.OnCharCellDrag = function(self, screenPosition, data)
  -- function num : 0_10 , upvalues : UIManager, _ENV
  if (self._charLargeCell)[data.station] then
    (((self._charLargeCell)[data.station]):GetRootWindow()):SetAnchoredPosition((UIManager.ScreenPointToLocalPointInRectangle)(((self._pos)[data.station])._uiObject, screenPosition.x, screenPosition.y))
  else
    LogErrorFormat("OffLineTeamEditDialog", "wrong data.station %s in teamcell %s", data.station, self._dialogStr)
  end
end

OffLineTeamEditDialog.OnCharCellEndDrag = function(self, screenPosition, data)
  -- function num : 0_11 , upvalues : _ENV, roleNum, UIManager, LineUpStation
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

OffLineTeamEditDialog.OnSwitchPositionBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV, LineUpStation
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

OffLineTeamEditDialog.OnElementBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teamelementinfodialog")
  if dialog then
    dialog:SetData(self._oneTotalElementValue, self._elementStage)
    dialog:HideStage2()
  end
end

OffLineTeamEditDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

OffLineTeamEditDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return OffLineTeamEditDialog

