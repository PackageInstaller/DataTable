-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonnextfloordialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WorldTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local cSceneJump = (BeanManager.GetTableByName)("scene.cscenejump")
local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CDungeonSelectMainlineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local Role = require("logic.manager.experimental.types.role")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local UIManager = ((CS.PixelNeko).UI).UIManager
local MillisecondToDay = 86400000
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local DungeonNextFloorDialog = class("DungeonNextFloorDialog", Dialog)
DungeonNextFloorDialog.AssetBundleName = "ui/layouts.mainline"
DungeonNextFloorDialog.AssetName = "DungeonNext"
local limit = nil
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(12) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(12)
  end
end

local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV, FinishGuide
  local guideId = (notification.userInfo).guideID
  if (notification.userInfo).guideStatus == "Start" then
    if guideId == 8 then
      self._inGuide = true
    end
    if guideId == 12 then
      (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
    end
  end
end

DungeonNextFloorDialog.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : DungeonNextFloorDialog
  ((DungeonNextFloorDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._spirit = nil
  self._floorData = {}
  self._itemData = {}
  self._firstItemData = {}
  self._floorDetail = {}
  self._selectRequestSpirit = 0
end

DungeonNextFloorDialog.OnCreate = function(self)
  -- function num : 0_3 , upvalues : limit, _ENV, WorldTable, MainLineTable, cSceneInfoStatic, cSceneJump, CSpirit, HandleGuideStatusChanged
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._back = self:GetChild("BackImg")
  self._goBtn = self:GetChild("Detail/GoBtn")
  self._goBtn_guide = self:GetChild("Detail/GoBtn/Effect")
  self._vitPanel = self:GetChild("TopGroup/VIT")
  self._vitNum = self:GetChild("TopGroup/VIT/Text")
  self._addVIT = self:GetChild("TopGroup/VIT/Add")
  self._vitRedDot = self:GetChild("TopGroup/VIT/RedDot")
  self._vitIcon = self:GetChild("TopGroup/VIT/Icon")
  self._floorNum = self:GetChild("Detail/LevelNum")
  self._floorName = self:GetChild("Detail/LevelName")
  self._floorBossIcon = self:GetChild("Detail/Boss")
  self._detail1Panel = self:GetChild("Detail/Detail1")
  self._recommendCapacity = self:GetChild("Detail/Detail1/Txt2")
  self._recommendBreakImage = self:GetChild("Detail/Detail1/BreakNumTxt")
  self._detail1Panel_NoBreak = self:GetChild("Detail/Detail1_NoneBreak")
  self._recommendCapacity_NoBreak = self:GetChild("Detail/Detail1_NoneBreak/Txt2")
  self._description = self:GetChild("Detail/Detail2/Txt")
  self._detailBoxExplore = self:GetChild("Detail/Detail3")
  self._detailBoxExploreOpen = self:GetChild("Detail/Detail3/Txt2")
  self._detailBox = self:GetChild("Detail/Detail3/Box")
  self._detailBoxRedDot = self:GetChild("Detail/Detail3/Box/RedDot")
  self._detailBoxExploreTotal = self:GetChild("Detail/Detail3/Txt3")
  self._power = self:GetChild("Detail/CostBack/Txt2")
  self._powerRed = self:GetChild("Detail/CostBack/Txt2Red")
  self._oldPower = self:GetChild("Detail/CostBack/Txt2Delete")
  self._activityTime = self:GetChild("Detail/Activity/Time")
  self._activityBoard = self:GetChild("Detail/Activity")
  self._itemPanel = self:GetChild("Detail/CellPanel")
  self._itemLeftArrow = self:GetChild("Detail/Left")
  self._itemRightArrow = self:GetChild("Detail/Right")
  self._floorPanel = self:GetChild("LeftPanel")
  self._backBtn = self:GetChild("LeaveBtn")
  self._backBtnGuide = self:GetChild("LeaveBtn/Guide")
  self._backGroundEffect = self:GetChild("BackImg/Effect")
  self._recommendedRolesBtn = self:GetChild("Detail/TopBack/Back/Ibtn")
  self._recommended = self:GetChild("Detail/TopBack/Back")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._detailBox):Subscribe_PointerClickEvent(self.OnDetailBoxClicked, self)
  ;
  (self._vitPanel):Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnLeavePressed, self)
  ;
  (self._recommendedRolesBtn):Subscribe_PointerClickEvent(self.OnRecommendedRolesBtnClicked, self)
  ;
  (self._backBtn):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).ZoneBackToMainCity))
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceiveDungeonPointAward, Common.n_ReceiveDungeonPointAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(4)
  self._worldTable = {}
  for _,id in ipairs(WorldTable:GetAllIds()) do
    -- DECOMPILER ERROR at PC275: Confused about usage of register: R6 in 'UnsetPending'

    (self._worldTable)[id] = WorldTable:GetRecorder(id)
  end
  self._mainLineTable = {}
  for _,id in ipairs(MainLineTable:GetAllIds()) do
    -- DECOMPILER ERROR at PC291: Confused about usage of register: R6 in 'UnsetPending'

    (self._mainLineTable)[id] = MainLineTable:GetRecorder(id)
  end
  self._cSceneInfoStatic = {}
  for _,id in ipairs(cSceneInfoStatic:GetAllIds()) do
    -- DECOMPILER ERROR at PC307: Confused about usage of register: R6 in 'UnsetPending'

    (self._cSceneInfoStatic)[id] = cSceneInfoStatic:GetRecorder(id)
  end
  self._cSceneJump = {}
  for _,id in ipairs(cSceneJump:GetAllIds()) do
    -- DECOMPILER ERROR at PC323: Confused about usage of register: R6 in 'UnsetPending'

    (self._cSceneJump)[id] = cSceneJump:GetRecorder(id)
  end
  self._cSpirit = {}
  for _,id in ipairs(CSpirit:GetAllIds()) do
    -- DECOMPILER ERROR at PC339: Confused about usage of register: R6 in 'UnsetPending'

    (self._cSpirit)[id] = CSpirit:GetRecorder(id)
  end
  local cellDialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorbigcell", nil)
  local rootWindow = cellDialog:GetRootWindow()
  self._bigCellWidth = rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  cellDialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorlittlecell", nil)
  rootWindow = cellDialog:GetRootWindow()
  self._smallCellWidth = rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  self._originalX = (self._floorPanel):GetPosition()
  local _ = nil
  _ = (self._floorPanel):GetRectSize()
  self._screenWidth = (self:GetRootWindow()):GetRectSize()
  self._backImgWidth = (self._back):GetRectSize()
  _ = (self._back):GetLocalScale()
  ;
  (self._back):SetLocalScale(1, 1, 1)
  ;
  (self._back):SetSize(0, self._screenWidth, 0, self._backImgHeight * self._backScaleY)
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100308)
  self:OnActivityUpdate()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActivityUpdate, Common.n_ActivityStart, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActivityUpdate, Common.n_ActivityStop, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

DungeonNextFloorDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  self:DestroyNodeDialog()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.spiritrecoverdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.mainline.newmainlinefloorchestrewarddialog")
  if self._backGroundEffectHandler then
    (self._backGroundEffect):ReleaseEffect(self._backGroundEffectHandler)
    self._backGroundEffectHandler = nil
  end
end

DungeonNextFloorDialog.DestroyNodeDialog = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._nodeData then
    for _,node in ipairs(self._nodeData) do
      (node.dialog):Destroy()
      ;
      (node.dialog):RootWindowDestroy()
      for _,line in ipairs(node.line) do
        (line.dialog):Destroy()
        ;
        (line.dialog):RootWindowDestroy()
      end
    end
  end
end

DungeonNextFloorDialog.SetData = function(self, data, lastFloorID, lastFloorIsFirstPass)
  -- function num : 0_6 , upvalues : CDungeonSelectMainlineTable, _ENV, CImagePathTable
  if self._beginDragHandler then
    (self._floorPanel):Unsubscribe_BeginDragEvent(self._beginDragHandler)
    self._beginDragHandler = nil
  end
  if self._dragHandler then
    (self._floorPanel):Unsubscribe_DragEvent(self._dragHandler)
    self._dragHandler = nil
  end
  if self._endDragHandler then
    (self._floorPanel):Unsubscribe_EndDragEvent(self._endDragHandler)
    self._endDragHandler = nil
  end
  if self._cancelDragHandler then
    (self._floorPanel):Unsubscribe_CancelDragEvent(self._cancelDragHandler)
    self._cancelDragHandler = nil
  end
  self:DestroyNodeDialog()
  self._lastFloorID = lastFloorID
  self._lastFloorIsFirstPass = lastFloorIsFirstPass
  self._floorData = {}
  self._nodeData = {}
  self._select = data.curZone
  local unlockLv = (CDungeonSelectMainlineTable:GetRecorder(self._select)).unlockLv
  do
    if not self._inGuide and (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel < unlockLv then
      local dialog = (DialogManager.CreateSingletonDialog)("dungeon.levellimitconfirmdialog")
      if dialog then
        dialog:Init(unlockLv)
      end
    end
    self._worldId = data.worldId
    local imageRecord = CImagePathTable:GetRecorder(((self._worldTable)[self._worldId]).backgroundimage)
    if imageRecord then
      (self._back):SetActive(true)
      ;
      (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      ;
      (self._back):SetActive(false)
    end
    if self._backGroundEffectHandler then
      (self._backGroundEffect):ReleaseEffect(self._backGroundEffectHandler)
      self._backGroundEffectHandler = nil
    end
    self._backGroundEffectHandler = (self._backGroundEffect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(((self._worldTable)[self._worldId]).backgroundeffect))
    self._worldExploreData = {worldId = data.worldId, clearZones = data.clearZones, totalZones = data.totalZones, isReceived = data.isReceived}
    for _,v in ipairs(data.data) do
      local oneline = (self._mainLineTable)[v.id]
      if oneline then
        local sceneInfoOneLine = (self._cSceneInfoStatic)[oneline.sceneid]
        local temp = {}
        temp.id = oneline.id
        temp.sceneId = oneline.sceneid
        temp.spirit = v.spirit
        temp.items = oneline.suredropItems
        temp.firstItem = {itemList = oneline.firstItems, numList = oneline.firstItemNums}
        temp.chanceItems = oneline.itemid
        temp.firstGet = v.firstGet
        temp.img = oneline.sceneimage
        temp.floor = oneline.floor
        temp.name = (TextManager.GetText)(oneline.nameTextID)
        temp.checkPointOpenBoxex = v.checkPointOpenBoxex
        temp.checkPointTotalBoxes = v.checkPointTotalBoxes
        temp.chestAward = {openedBoxes = v.openedBoxes, totalBoxes = v.totalBoxes, isReceived = v.isReceived}
        temp.autoExplore = v.autoExplore
        temp.bossFlag = oneline.isBoss
        temp.delegate = self
        local pos = (string.split)(sceneInfoOneLine.nodepos, ",")
        temp.pos = {x = tonumber(pos[1]), y = tonumber(pos[2])}
        temp.childPoint = v.smallPoint
        temp.unlockLv = oneline.unlockLv
        ;
        (table.insert)(self._floorData, temp)
        ;
        (table.insert)(self._nodeData, {value = temp, parentId = nil, 
childIdList = {}
, type = "big", 
line = {}
, dialog = nil})
        if v.smallPoint then
          for _,smallV in ipairs(v.smallPoint) do
            (table.insert)(self._nodeData, {value = smallV, parentId = nil, 
childIdList = {}
, type = "small", 
line = {}
, dialog = nil})
          end
        end
      else
        do
          do
            LogErrorFormat("MainLineFloorDialog", "wrong cdungeonselectmainline id %s", v.id)
            -- DECOMPILER ERROR at PC243: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC243: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC243: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    self:BuildNodeData()
    ;
    (self._floorPanel):SetHeight(0, self._panelHeight)
    if #self._floorData ~= 0 then
      (self._floorPanel):SetPosition(self._originalX, self._originalOX, 0, 0)
      self._panelPos = 0
    end
    if self._select then
      local nodePos = 0
      for _,node in ipairs(self._nodeData) do
        if (node.value).id == self._select then
          nodePos = ((node.value).pos).y
          break
        end
      end
      do
        do
          self._panelPos = -nodePos + self._screenHeight / 2
          if self._panelPos < -self._panelHeight + self._screenHeight / 2 then
            self._panelPos = -self._panelHeight + self._screenHeight / 2
          end
          if self._panelPos > 0 then
            self._panelPos = 0
          end
          ;
          (self._floorPanel):SetPosition(self._originalX, self._originalOX, 0, self._panelPos)
          self:SetSelectedCell(self._select)
          LogWarning("MainLineFloorDialog", "there is no current floor")
          local message = ((NekoData.BehaviorManager).BM_Game):GetTopMessage()
          if message and message.messageId ~= 0 then
            ((NekoData.BehaviorManager).BM_Message):SendTopMessage(message.messageId, message.parameters)
          end
          self:SetRedDot()
          self:HandleSpriteEvidence()
        end
      end
    end
  end
end

DungeonNextFloorDialog.BuildNodeData = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,opNode in ipairs(self._nodeData) do
    local opJumpAimSceneIds = ((self._cSceneJump)[(opNode.value).sceneId]).nextNode
    for _,fNode in ipairs(self._nodeData) do
      for _,sId in ipairs(opJumpAimSceneIds) do
        if sId == (fNode.value).sceneId then
          local exist = false
          for _,child in ipairs(opNode.childIdList) do
            if child == sId then
              exist = true
              break
            end
          end
          do
            do
              if not exist then
                (table.insert)(opNode.childIdList, sId)
              end
              fNode.parentId = (opNode.value).sceneId
              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  for _,node in ipairs(self._nodeData) do
    if node.type == "small" then
      local pos = (string.split)(((self._cSceneInfoStatic)[(node.value).sceneId]).nodepos, ",")
      local x = tonumber(pos[1])
      local y = tonumber(pos[2])
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (node.value).pos = {x = x, y = y}
    end
    do
      for _,child in ipairs(node.childIdList) do
        local pos = (string.split)(((self._cSceneInfoStatic)[child]).nodepos, ",")
        local line = {
p = {id = (node.value).sceneId, pos = (node.value).pos}
, 
c = {id = child, 
pos = {x = tonumber(pos[1]), y = tonumber(pos[2])}
}
, dialog = nil, bigParentId = (node.value).bigParentId}
        local pId, cId = nil, nil
        for _,d in pairs(self._mainLineTable) do
          if d.sceneid == (line.p).id then
            pId = d.id
            break
          end
        end
        do
          for _,d in pairs(self._mainLineTable) do
            if d.sceneid == (line.c).id then
              cId = d.id
              break
            end
          end
          do
            do
              -- DECOMPILER ERROR at PC145: Confused about usage of register: R15 in 'UnsetPending'

              if (self._mainLineTable)[pId] then
                (line.p).width = self._bigCellWidth
                -- DECOMPILER ERROR at PC148: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (line.p).height = self._bigCellHeight
              else
                -- DECOMPILER ERROR at PC152: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (line.p).width = self._smallCellWidth
                -- DECOMPILER ERROR at PC155: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (line.p).height = self._smallCellHeight
              end
              -- DECOMPILER ERROR at PC162: Confused about usage of register: R15 in 'UnsetPending'

              if (self._mainLineTable)[cId] then
                (line.c).width = self._bigCellWidth
                -- DECOMPILER ERROR at PC165: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (line.c).height = self._bigCellHeight
              else
                -- DECOMPILER ERROR at PC169: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (line.c).width = self._smallCellWidth
                -- DECOMPILER ERROR at PC172: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (line.c).height = self._smallCellHeight
              end
              ;
              (table.insert)(node.line, line)
              -- DECOMPILER ERROR at PC178: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC178: LeaveBlock: unexpected jumping out DO_STMT

            end
          end
        end
      end
      -- DECOMPILER ERROR at PC180: LeaveBlock: unexpected jumping out DO_STMT

    end
  end
  local isBig = nil
  self._accuLineLen = {}
  for _,node in ipairs(self._nodeData) do
    isBig = node.type == "big"
    for _,line in ipairs(node.line) do
      line.dialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorlinecell", (self._floorPanel)._uiObject)
      local pId = nil
      for _,d in pairs(self._mainLineTable) do
        if d.sceneid == (line.p).id then
          pId = d.id
          break
        end
      end
      ;
      (line.dialog):RefreshCell({parentId = pId, bigParentId = line.bigParentId})
      local deltaX = ((line.c).pos).x + (line.c).width / 2 - (((line.p).pos).x + (line.p).width / 2)
      local deltaY = ((line.c).pos).y + (line.c).height / 2 - (((line.p).pos).y + (line.p).height / 2)
      local calLen = deltaX ^ 2 + deltaY ^ 2 ^ 0.5
      local preLen = nil
      if isBig then
        preLen = 0
        -- DECOMPILER ERROR at PC269: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (self._accuLineLen)[tostring((line.c).id)] = calLen
      else
        preLen = (self._accuLineLen)[tostring((line.p).id)] or 0
        -- DECOMPILER ERROR at PC286: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (self._accuLineLen)[tostring((line.c).id)] = (preLen) + calLen
      end
      ;
      (line.dialog):SetWidth(calLen, -(preLen))
      ;
      (line.dialog):SetPosition(0, ((line.p).pos).x + (line.p).width / 2, 0, ((line.p).pos).y + (line.p).height / 2)
      ;
      (line.dialog):SetZRotation(1, 0, deltaX, deltaY)
    end
  end
  self._panelHeight = ((((self._nodeData)[1]).value).pos).y
  for _,node in ipairs(self._nodeData) do
    if node.type == "big" then
      node.dialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorbigcell", (self._floorPanel)._uiObject)
      ;
      (node.dialog):RefreshCell(node.value)
      ;
      (node.dialog):SetPosition(0, ((node.value).pos).x, 0, ((node.value).pos).y)
      if not -(self._accuLineLen)[tostring((node.value).sceneId)] then
        do
          (node.dialog):SetWidthOri(not (self._accuLineLen)[tostring((node.value).sceneId)] or 0)
          if node.type == "small" then
            node.dialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorlittlecell", (self._floorPanel)._uiObject)
            ;
            (node.dialog):RefreshCell(node.value)
            ;
            (node.dialog):SetPosition(0, ((node.value).pos).x, 0, ((node.value).pos).y)
            ;
            (node.dialog):SetWidthOri(not (self._accuLineLen)[tostring((node.value).sceneId)] or -(self._accuLineLen)[tostring((node.value).sceneId)] or 0)
          end
          if self._panelHeight < ((node.value).pos).y then
            self._panelHeight = ((node.value).pos).y
          end
          -- DECOMPILER ERROR at PC435: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC435: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC435: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC435: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if #self._nodeData > 1 then
    if self._beginDragHandler then
      (self._floorPanel):Unsubscribe_BeginDragEvent(self._beginDragHandler)
      self._beginDragHandler = nil
    end
    if self._dragHandler then
      (self._floorPanel):Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      (self._floorPanel):Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      (self._floorPanel):Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
    self._beginDragHandler = (self._floorPanel):Subscribe_BeginDragEvent(self.OnBeginDrag, self)
    self._dragHandler = (self._floorPanel):Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = (self._floorPanel):Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = (self._floorPanel):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  end
  -- DECOMPILER ERROR: 18 unprocessed JMP targets
end

DungeonNextFloorDialog.GetSelectedId = function(self)
  -- function num : 0_8
  return self._select or 0
end

DungeonNextFloorDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._itemFrame then
    return "mainline.mainline.newmainlineflooritemcell"
  end
end

DungeonNextFloorDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._itemFrame then
    return (self._itemData)[index]
  end
end

DungeonNextFloorDialog.NumberOfCell = function(self, frame)
  -- function num : 0_11
  if frame == self._itemFrame then
    return #self._itemData
  end
end

local SortItemByPinji = function(items, get, first, normal, chance)
  -- function num : 0_12 , upvalues : _ENV, Item, ItemTypeEnum
  local resultData = {}
  local itemList = items.itemList or items
  if not items.numList then
    local numList = {}
  end
  for index,id in ipairs(itemList) do
    local item = (Item.Create)(id)
    ;
    (table.insert)(resultData, {item = item, num = numList[index], get = get, first = first, normal = normal, chance = chance})
  end
  local equip = {}
  local item = {}
  for _,v in ipairs(resultData) do
    if (v.item):GetItemType() == ItemTypeEnum.BASEITEM then
      (table.insert)(item, v)
    else
      ;
      (table.insert)(equip, v)
    end
  end
  ;
  (table.sort)(item, function(a, b)
    -- function num : 0_12_0
    do return (b.item):GetPinJiID() < (a.item):GetPinJiID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(equip, function(a, b)
    -- function num : 0_12_1
    do return (b.item):GetPinJiID() < (a.item):GetPinJiID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  resultData = {}
  for _,v in ipairs(equip) do
    (table.insert)(resultData, v)
  end
  for _,v in ipairs(item) do
    (table.insert)(resultData, v)
  end
  return resultData
end

DungeonNextFloorDialog.FireEvent = function(self, id)
  -- function num : 0_13 , upvalues : _ENV
  for _,node in ipairs(self._nodeData) do
    (node.dialog):OnEvent("SetSelected", id, true, self._lastFloorIsFirstPass, self._lastFloorID)
    for _,line in ipairs(node.line) do
      (line.dialog):OnEvent("SetSelected", id, true, self._lastFloorIsFirstPass, self._lastFloorID)
    end
  end
end

DungeonNextFloorDialog.SetSelectedCell = function(self, select)
  -- function num : 0_14 , upvalues : _ENV, CStringRes, CRoleLevelCfgTable, SortItemByPinji, TableFrame
  self._select = select
  if self._select then
    local nodePos = 0
    for _,node in ipairs(self._nodeData) do
      if (node.value).id == self._select then
        nodePos = ((node.value).pos).y
        break
      end
    end
    do
      self._moveDesPos = -nodePos + self._screenHeight / 2
      if self._moveDesPos < -self._panelHeight + self._screenHeight / 2 then
        self._moveDesPos = -self._panelHeight + self._screenHeight / 2
      end
      if self._moveDesPos > 0 then
        self._moveDesPos = 0
      end
      local first = {pos = self._panelPos}
      do
        local last = {pos = self._moveDesPos}
        self._moveTask = (Tween.new)(0.2, first, last, "linear")
        self._needUpdate = true
        self:FireEvent(select)
        for _,v in ipairs(self._floorData) do
          if select == v.id then
            local oneline = (self._mainLineTable)[v.id]
            -- DECOMPILER ERROR at PC73: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._floorDetail).id = v.id
            -- DECOMPILER ERROR at PC76: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._floorDetail).spirit = v.spirit
            local str = (CStringRes:GetRecorder(1506)).msgTextID
            str = (TextManager.GetText)(str)
            str = (string.gsub)(str, "%$parameter1%$", tostring(v.floor))
            str = (string.gsub)(str, "%$parameter2%$", (TextManager.GetText)(oneline.nameTextID))
            ;
            (self._floorName):SetText(str)
            ;
            (self._floorBossIcon):SetActive(oneline.isBoss == 1)
            local clientBreakLevel = (CRoleLevelCfgTable:GetRecorder(oneline.magic)).clientBreakLevel
            ;
            (self._detail1Panel):SetActive(clientBreakLevel > 0)
            ;
            (self._detail1Panel_NoBreak):SetActive(clientBreakLevel == 0)
            if clientBreakLevel > 0 then
              (self._recommendBreakImage):SetText(clientBreakLevel)
              ;
              (self._recommendCapacity):SetText((CRoleLevelCfgTable:GetRecorder(oneline.magic)).clientLevel)
            else
              (self._recommendCapacity_NoBreak):SetText((CRoleLevelCfgTable:GetRecorder(oneline.magic)).clientLevel)
            end
            ;
            (self._description):SetText((TextManager.GetText)(oneline.describeTextID))
            self._selectRequestSpirit = v.spirit
            if self._spirit < v.spirit then
              (self._power):SetActive(false)
              ;
              (self._powerRed):SetActive(true)
            else
              (self._power):SetActive(true)
              ;
              (self._powerRed):SetActive(false)
            end
            self:SetActivityPower(v.id, v.spirit)
            local firstItemData = SortItemByPinji(v.firstItem, v.firstGet, true)
            local normalItemData = SortItemByPinji(v.items, false, false, true)
            local chanceItemData = SortItemByPinji(v.chanceItems, false, false, false, true)
            self._itemData = {}
            for _,list in ipairs({firstItemData, normalItemData, chanceItemData}) do
              for _,v in ipairs(list) do
                (table.insert)(self._itemData, v)
              end
            end
            if self._itemFrame then
              (self._itemFrame):Destroy()
              self._itemFrame = nil
            end
            self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, true, false)
            ;
            (self._itemFrame):SetMargin(40, 40)
            ;
            (self._itemFrame):ReloadAllCell()
            if #self._itemData > 3 then
              (self._itemLeftArrow):SetActive(true)
              ;
              (self._itemRightArrow):SetActive(true)
            else
              (self._itemLeftArrow):SetActive(false)
              ;
              (self._itemRightArrow):SetActive(false)
            end
            if (v.chestAward).totalBoxes == 0 then
              (self._detailBoxExplore):SetActive(false)
            else
              (self._detailBoxExplore):SetActive(true)
            end
            ;
            (self._detailBoxExploreOpen):SetText(tostring((v.chestAward).openedBoxes))
            ;
            (self._detailBoxExploreTotal):SetText(tostring((v.chestAward).totalBoxes))
            break
          end
        end
        if ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldZoneAwardReceiveByFloorId(self._select) then
          (self._detailBoxRedDot):SetActive(false)
        else
          (self._detailBoxRedDot):SetActive(true)
        end
        if self._autoTipsShowTask then
          (GameTimer.RemoveTask)(self._autoTipsShowTask)
          self._autoTipsShowTask = nil
        end
        ;
        (self._recommended):SetActive(self:CheckHasRecommend())
        -- DECOMPILER ERROR: 19 unprocessed JMP targets
      end
    end
  end
end

DungeonNextFloorDialog.OnGoBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self._spirit < (self._floorDetail).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) then
      ((NekoData.DataManager).DM_Team):ClearSupportRole()
      ;
      ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo("MainLine", self:GetSelectedId())
      local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
      crefreshSupportRoleList:Send()
    else
      do
        local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
        if dialog then
          dialog:SetCopyInfo("MainLine", self:GetSelectedId())
        end
      end
    end
  end
end

DungeonNextFloorDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_16 , upvalues : _ENV, limit
  self._spirit = (notification.userInfo).spirit
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  if self._spirit < self._selectRequestSpirit then
    (self._power):SetActive(false)
    ;
    (self._powerRed):SetActive(true)
  else
    ;
    (self._power):SetActive(true)
    ;
    (self._powerRed):SetActive(false)
  end
end

local Leave = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local effect = (EffectFactory.CreateJumpBackEffect)()
  effect:Run()
  ;
  ((EffectFactory.CreateThawEffect)()):Run()
  self:Destroy()
end

DungeonNextFloorDialog.OnLeavePressed = function(self)
  -- function num : 0_18 , upvalues : _ENV, Leave
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(8, 1) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(8)
    Leave(self)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(41, nil, function()
    -- function num : 0_18_0 , upvalues : Leave, self
    Leave(self)
  end
, {}, nil, {})
  end
end

DungeonNextFloorDialog.GetFloorDetail = function(self)
  -- function num : 0_19
  return self._floorDetail
end

DungeonNextFloorDialog.OnAddVITBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

DungeonNextFloorDialog.OnDetailBoxClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.newmainlinefloorchestrewarddialog")
  for _,v in ipairs(self._floorData) do
    if self._select == v.id then
      dialog:SetData({award = v.chestAward, id = v.id})
      break
    end
  end
end

local set_activity_time = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local endtime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(1)
  local time = (ServerGameTimer.GetServerTimeForecast)()
  local info = (os.date)("!*t", (endtime - time) // 1000)
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1126)).msgTextID
  str = (TextManager.GetText)(str)
  str = str:gsub("%$parameter(%d)%$", {["1"] = info.day, ["2"] = info.hour, ["3"] = info.min})
  ;
  (self._activityTime):SetText(str)
end

DungeonNextFloorDialog.OnActivityUpdate = function(self)
  -- function num : 0_23 , upvalues : _ENV, set_activity_time
  if ((NekoData.BehaviorManager).BM_Activity):HasActivity(1) and not self._activityTask then
    self._activityTask = (ServerGameTimer.AddTask)(0, 60, set_activity_time, self)
  end
  if self._activityTask then
    (ServerGameTimer.RemoveTask)(self._activityTask)
    self._activityTask = nil
  end
  if self._select then
    for _,v in pairs(self._floorData) do
      if v.id == self._select then
        self:SetActivityPower(v.id, v.spirit)
        break
      end
    end
  end
end

DungeonNextFloorDialog.SetActivityPower = function(self, floor, spirit)
  -- function num : 0_24 , upvalues : _ENV, set_activity_time
  if ((NekoData.BehaviorManager).BM_Activity):HasActivity(1) then
    local manager = ((NekoData.BehaviorManager).BM_Activity):GetManager(1)
    local range = manager:GetRange()
    for _,id in pairs(range) do
      if id == floor then
        local newspirit = (math.floor)(spirit * manager:GetDiscount())
        ;
        (self._power):SetText(newspirit)
        ;
        (self._powerRed):SetText(newspirit)
        ;
        (self._oldPower):SetActive(true)
        ;
        (self._oldPower):SetText(spirit)
        ;
        (self._activityBoard):SetActive(true)
        set_activity_time(self)
        return 
      end
    end
  end
  do
    ;
    (self._oldPower):SetActive(false)
    ;
    (self._power):SetText(spirit)
    ;
    (self._powerRed):SetText(spirit)
    ;
    (self._activityBoard):SetActive(false)
  end
end

DungeonNextFloorDialog.OnBeginDrag = function(self, args)
  -- function num : 0_25
  self._dragSpeed = 0
  self._dragDelta = 0
  self._slideTime = 0.5
  self._needUpdate = false
end

DungeonNextFloorDialog.OnCellClicked = function(self, select)
  -- function num : 0_26 , upvalues : _ENV
  if self._select ~= select then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100214)
  end
end

DungeonNextFloorDialog.OnDrag = function(self, args)
  -- function num : 0_27 , upvalues : UIManager
  local pressPosition = args.pressPosition
  local position = args.position
  local _, localPressY = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, pressPosition.x, pressPosition.y)
  local _, localY = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, position.x, position.y)
  self._dragSpeed = args.ySpeed / 10
  local currentPosition = self._panelPos
  self._panelPos = currentPosition - self._dragDelta
  self._dragDelta = localY - localPressY
  self._panelPos = self._panelPos + self._dragDelta
  if self._panelPos < -self._panelHeight + self._screenHeight / 2 then
    self._panelPos = -self._panelHeight + self._screenHeight / 2
  end
  if self._panelPos > 0 then
    self._panelPos = 0
  end
  if currentPosition ~= self._panelPos then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

DungeonNextFloorDialog.OnEndDrag = function(self, args)
  -- function num : 0_28 , upvalues : UIManager, _ENV
  self._dragDelta = 0
  local _, original = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, 0, 0)
  local _, speed = (UIManager.ScreenPointToLocalPointInRectangle)((self._floorPanel)._uiObject, 0, self._dragSpeed)
  speed = original - speed
  self._dragSpeed = speed
  if self._panelPos < -self._panelHeight + self._screenHeight / 2 then
    self._panelPos = -self._panelHeight + self._screenHeight / 2
  end
  if self._panelPos > 0 then
    self._panelPos = 0
  end
  self._slideOriPos = self._panelPos
  local first = {spe = speed}
  local last = {spe = 0}
  self._slideTask = (Tween.new)(self._slideTime, first, last, "linear")
  self._needUpdate = true
end

DungeonNextFloorDialog.UpdateView = function(self, deltaTime)
  -- function num : 0_29
  if self._needUpdate then
    (self._floorPanel):SetPosition(self._originalX, self._originalOX, 0, self._panelPos)
    local delta = self._backImgHeight * self._backScaleY - self._screenHeight
    local pos = -self._panelPos / (-self._panelHeight + self._screenHeight / 2) * delta
    if pos < -delta then
      pos = -delta
    end
    if pos > 0 then
      pos = 0
    end
    ;
    (self._back):SetPosition(0, 0, 0, pos)
    if not self._slideTask and not self._moveTask then
      self._needUpdate = false
    end
  end
end

DungeonNextFloorDialog.OnLateUpdate = function(self, notification)
  -- function num : 0_30
  local deltaTime = (notification.userInfo).deltaTime
  if self._needUpdate then
    if self._slideTask then
      if (self._slideTask):update(deltaTime) then
        self._panelPos = self._slideOriPos - (self._dragSpeed + ((self._slideTask).subject).spe) * self._slideTime / 2
        self._slideTask = nil
        self._slideOriPos = nil
      else
        self._panelPos = self._slideOriPos - (self._dragSpeed + ((self._slideTask).subject).spe) * (self._slideTask).clock / 2
      end
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

      if self._slideTask and (-self._panelHeight + self._screenHeight / 2 < self._panelPos or self._panelPos < 0) then
        (self._slideTask).clock = (self._slideTask).clock + 2 * deltaTime
      end
      if self._panelPos < -self._panelHeight + self._screenHeight / 2 then
        self._panelPos = -self._panelHeight + self._screenHeight / 2
      end
      if self._panelPos > 0 then
        self._panelPos = 0
      end
    end
    if self._moveTask then
      if (self._moveTask):update(deltaTime) then
        self._panelPos = self._moveDesPos
        self._moveTask = nil
        self._moveDesPos = nil
      else
        self._panelPos = ((self._moveTask).subject).pos
      end
    end
    self:UpdateView(deltaTime)
  end
end

DungeonNextFloorDialog.OnCurPosChange = function(self, frame, ratio)
  -- function num : 0_31
  if frame == self._itemFrame then
    if ratio == 0 then
      (self._itemLeftArrow):SetActive(false)
    else
      if ratio == 1 then
        (self._itemRightArrow):SetActive(false)
      else
        ;
        (self._itemLeftArrow):SetActive(true)
        ;
        (self._itemRightArrow):SetActive(true)
      end
    end
  end
end

DungeonNextFloorDialog.OnReceiveDungeonPointAward = function(self, notification)
  -- function num : 0_32 , upvalues : _ENV
  for _,v in ipairs(self._floorData) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    if v.id == (notification.userInfo).id then
      (v.chestAward).isReceived = 1
      ;
      (self._detailBoxRedDot):SetActive(false)
      break
    end
  end
end

DungeonNextFloorDialog.OnRecommendedRolesBtnClicked = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = (self._floorDetail).id
    data.type = "MainLine"
    dialog:Init(data)
  end
end

DungeonNextFloorDialog.CheckHasRecommend = function(self)
  -- function num : 0_34 , upvalues : CDungeonSelectMainlineTable
  local id = (self._floorDetail).id
  local recommendIds = (CDungeonSelectMainlineTable:GetRecorder(id)).recommendid
  -- DECOMPILER ERROR at PC13: Unhandled construct in 'MakeBoolean' P3

  do return (recommendIds and #recommendIds > 0) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DungeonNextFloorDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_35 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime then
      local time = deltime - (ServerGameTimer.GetServerTime)()
      if time < MillisecondToDay and time > 0 then
        return true
      end
    end
  end
  return false
end

DungeonNextFloorDialog.SetRedDot = function(self)
  -- function num : 0_36
  (self._vitRedDot):SetActive(self:HaveSpiritItemSoonExpire())
end

DungeonNextFloorDialog.HandleSpriteEvidence = function(self)
  -- function num : 0_37 , upvalues : _ENV, CImagePathTable, CVarconfig, Item
  local haveSpriteEvidence = (((NekoData.BehaviorManager).BM_Currency):GetSpiritRecoverTimes())[DataCommon.SpriteEvidence]
  if haveSpriteEvidence then
    if not CImagePathTable:GetRecorder(tonumber((CVarconfig:GetRecorder(125)).Value)) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._vitIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      local imageRecord = ((Item.Create)(DataCommon.SpiritID)):GetIcon()
      ;
      (self._vitIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
end

return DungeonNextFloorDialog

