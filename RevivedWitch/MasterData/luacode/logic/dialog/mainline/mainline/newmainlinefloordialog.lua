-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinefloordialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local Role = require("logic.manager.experimental.types.role")
local WorldTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local cSceneJump = (BeanManager.GetTableByName)("scene.cscenejump")
local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CDungeonSelectMainlineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local UIManager = ((CS.PixelNeko).UI).UIManager
local MillisecondToDay = 86400000
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local MainLineFloorDialog = class("MainLineFloorDialog", Dialog)
MainLineFloorDialog.AssetBundleName = "ui/layouts.mainline"
MainLineFloorDialog.AssetName = "DungeonSelect"
local limit = nil
MainLineFloorDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainLineFloorDialog
  ((MainLineFloorDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._spirit = nil
  self._floorData = {}
  self._itemData = {}
  self._floorDetail = {}
  self._selectRequestSpirit = 0
  self._rightInfoPanelShow = false
  self._hasTriggerGuide = false
  self._floorDetailIsChanging = true
end

MainLineFloorDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : limit, _ENV, AnimatorStaticFunctions, WorldTable, MainLineTable, cSceneInfoStatic, cSceneJump, CSpirit
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._back = self:GetChild("BackImg")
  self._goBtn = self:GetChild("Detail/GoBtn")
  ;
  (self._goBtn):SetActive(true)
  self._goBtnCenter = self:GetChild("Detail/GoBtnCenter")
  ;
  (self._goBtnCenter):SetActive(true)
  self._autoGoBtn = self:GetChild("Detail/AutoBtn")
  ;
  (self._autoGoBtn):SetActive(false)
  self._autoGoBtnTips = self:GetChild("Detail/AutoBtn/Tips")
  ;
  (self._autoGoBtnTips):SetActive(false)
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
  self._floorPanel = self:GetChild("LevelFrame")
  self._worldExploreBox = self:GetChild("WorldExplore/Box")
  self._worldExploreBoxRedDot = self:GetChild("WorldExplore/Box/RedDot")
  self._worldExploreNum = self:GetChild("WorldExplore/Loading/Num/Num")
  self._worldExploreProgress = self:GetChild("WorldExplore/Loading/Loading/BackGround/Progress")
  self._lastWorldBtn = self:GetChild("GroupBtnLeft")
  self._lastWorldName = self:GetChild("GroupBtnLeft/Text2")
  self._leftBtn = self:GetChild("Left")
  self._curWorldBtn = self:GetChild("GroupBtnMid")
  ;
  (self._curWorldBtn):SetSelected(true)
  self._curWorldNum = self:GetChild("GroupBtnMid/Num")
  self._curWorldName = self:GetChild("GroupBtnMid/Text2")
  self._nextWorldBtn = self:GetChild("GroupBtnRight")
  self._nextWorldName = self:GetChild("GroupBtnRight/Text2")
  self._rightBtn = self:GetChild("Right")
  self._autoBtnClickArea = self:GetChild("Detail/Click")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._recommendedRolesBtn = self:GetChild("Detail/Ibtn")
  self._recommendedRolesBtnBack = self:GetChild("Detail/TopBack/Back")
  self._backGroundEffect = self:GetChild("BackImg/Effect")
  self._animator = (AnimatorStaticFunctions.Get)((self:GetRootWindow())._uiObject)
  self._stateExitEventHandler = (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnSwitchStageAnimationStateExit, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._goBtnCenter):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._autoGoBtn):Subscribe_PointerClickEvent(self.OnAutoGoBtnClicked, self)
  ;
  (self._vitPanel):Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  ;
  (self._worldExploreBox):Subscribe_PointerClickEvent(self.OnWorldExploreBoxClicked, self)
  ;
  (self._detailBox):Subscribe_PointerClickEvent(self.OnDetailBoxClicked, self)
  ;
  (self._curWorldBtn):Subscribe_BeginDragEvent(self.OnWorldBtnBeginDrag, self)
  ;
  (self._curWorldBtn):Subscribe_DragEvent(self.OnWorldBtnDrag, self)
  ;
  (self._curWorldBtn):Subscribe_EndDragEvent(self.OnWorldBtnEndDrag, self)
  ;
  (self._curWorldBtn):Subscribe_CancelDragEvent(self.OnWorldBtnEndDrag, self)
  ;
  (self._curWorldBtn):Subscribe_CancelDragEvent(self.OnWorldBtnEndDrag, self)
  ;
  (self._leftBtn):Subscribe_PointerClickEvent(self.OnLastWorldBtnClicked, self)
  ;
  (self._rightBtn):Subscribe_PointerClickEvent(self.OnNextWorldBtnClicked, self)
  ;
  (self._autoBtnClickArea):Subscribe_PointerClickEvent(self.OnAutoBtnClickAreaClicked, self)
  ;
  (self._recommendedRolesBtn):Subscribe_PointerClickEvent(self.OnRecommendedRolesBtnClicked, self)
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceiveDungeonPointAward, Common.n_ReceiveDungeonPointAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceiveDungeonWorldAward, Common.n_ReceiveDungeonWorldAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemNumModify, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(4)
  self._worldTable = {}
  for _,id in ipairs(WorldTable:GetAllIds()) do
    -- DECOMPILER ERROR at PC429: Confused about usage of register: R6 in 'UnsetPending'

    (self._worldTable)[id] = WorldTable:GetRecorder(id)
  end
  self._mainLineTable = {}
  for _,id in ipairs(MainLineTable:GetAllIds()) do
    -- DECOMPILER ERROR at PC445: Confused about usage of register: R6 in 'UnsetPending'

    (self._mainLineTable)[id] = MainLineTable:GetRecorder(id)
  end
  self._cSceneInfoStatic = {}
  for _,id in ipairs(cSceneInfoStatic:GetAllIds()) do
    -- DECOMPILER ERROR at PC461: Confused about usage of register: R6 in 'UnsetPending'

    (self._cSceneInfoStatic)[id] = cSceneInfoStatic:GetRecorder(id)
  end
  self._cSceneJump = {}
  for _,id in ipairs(cSceneJump:GetAllIds()) do
    -- DECOMPILER ERROR at PC477: Confused about usage of register: R6 in 'UnsetPending'

    (self._cSceneJump)[id] = cSceneJump:GetRecorder(id)
  end
  self._cSpirit = {}
  for _,id in ipairs(CSpirit:GetAllIds()) do
    -- DECOMPILER ERROR at PC493: Confused about usage of register: R6 in 'UnsetPending'

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
  self:OnActivityUpdate()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActivityUpdate, Common.n_ActivityStart, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActivityUpdate, Common.n_ActivityStop, nil)
end

MainLineFloorDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  self:DestroyNodeDialog()
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  if self._autoTipsShowTask then
    (GameTimer.RemoveTask)(self._autoTipsShowTask)
    self._autoTipsShowTask = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.mainline.newmainlinefloorworldrewarddialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.mainline.newmainlinefloorchestrewarddialog")
  if self._backGroundEffectHandler then
    (self._backGroundEffect):ReleaseEffect(self._backGroundEffectHandler)
    self._backGroundEffectHandler = nil
  end
end

MainLineFloorDialog.DestroyNodeDialog = function(self)
  -- function num : 0_3 , upvalues : _ENV
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

MainLineFloorDialog.SetData = function(self, data)
  -- function num : 0_4 , upvalues : CImagePathTable, _ENV
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
  self._floorData = {}
  self._nodeData = {}
  self._select = data.curZone
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
  ;
  (self._animator):Play("DungeonSelectShow")
  self:SetLeftWorldInfo()
  self._worldExploreData = {worldId = data.worldId, clearZones = data.clearZones, totalZones = data.totalZones, isReceived = data.isReceived}
  ;
  (self._worldExploreNum):SetText(tostring((self._worldExploreData).clearZones) .. "/" .. tostring((self._worldExploreData).totalZones))
  ;
  (self._worldExploreProgress):SetFillAmount((self._worldExploreData).clearZones / (self._worldExploreData).totalZones)
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
  (self._floorPanel):SetHeight(0, self._panelHeight + self._screenHeight / 2)
  ;
  (self._floorPanel):SetPosition(self._originalX, self._originalOX, 0, 0)
  if #self._floorData ~= 0 then
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
        self:OnCellClicked(self._select)
        LogWarning("MainLineFloorDialog", "there is no current floor")
        if ((NekoData.BehaviorManager).BM_Game):GetIfDungeonWorldAwardReceiveByWorldId(self._worldId) then
          (self._worldExploreBoxRedDot):SetActive(false)
        else
          ;
          (self._worldExploreBoxRedDot):SetActive(true)
        end
        self:SetRedDot()
        self:StartEffectFireEvent()
        self:HandleSpriteEvidence()
      end
    end
  end
end

MainLineFloorDialog.BuildNodeData = function(self)
  -- function num : 0_5 , upvalues : _ENV
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
  for _,node in ipairs(self._nodeData) do
    for _,line in ipairs(node.line) do
      line.dialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorlinecell", (self._floorPanel)._uiObject)
      local pId = nil
      for _,d in pairs(self._mainLineTable) do
        if d.sceneid == (line.p).id then
          pId = d.id
          break
        end
      end
      do
        ;
        (line.dialog):RefreshCell({parentId = pId, bigParentId = line.bigParentId})
        local deltaX = ((line.c).pos).x + (line.c).width / 2 - (((line.p).pos).x + (line.p).width / 2)
        do
          local deltaY = ((line.c).pos).y + (line.c).height / 2 - (((line.p).pos).y + (line.p).height / 2)
          ;
          (line.dialog):SetWidth(deltaX ^ 2 + deltaY ^ 2 ^ 0.5)
          ;
          (line.dialog):SetPosition(0, ((line.p).pos).x + (line.p).width / 2, 0, ((line.p).pos).y + (line.p).height / 2)
          ;
          (line.dialog):SetZRotation(1, 0, deltaX, deltaY)
          -- DECOMPILER ERROR at PC281: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  if (self._nodeData)[1] then
    self._panelHeight = ((((self._nodeData)[1]).value).pos).y
  end
  for _,node in ipairs(self._nodeData) do
    if node.type == "big" then
      node.dialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorbigcell", (self._floorPanel)._uiObject)
      ;
      (node.dialog):RefreshCell(node.value)
      ;
      (node.dialog):SetPosition(0, ((node.value).pos).x, 0, ((node.value).pos).y)
    else
      if node.type == "small" then
        node.dialog = (DialogManager.CreateDialog)("mainline.mainline.newmainlinefloorlittlecell", (self._floorPanel)._uiObject)
        ;
        (node.dialog):RefreshCell(node.value)
        ;
        (node.dialog):SetPosition(0, ((node.value).pos).x, 0, ((node.value).pos).y)
      end
    end
    if self._panelHeight < ((node.value).pos).y then
      self._panelHeight = ((node.value).pos).y
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
end

MainLineFloorDialog.GetSelectedId = function(self)
  -- function num : 0_6
  return self._select or 0
end

MainLineFloorDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._itemFrame then
    return "mainline.mainline.newmainlineflooritemcell"
  end
end

MainLineFloorDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._itemFrame then
    return (self._itemData)[index]
  end
end

MainLineFloorDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  if frame == self._itemFrame then
    return #self._itemData
  end
end

local SortItemByPinji = function(items, get, first, normal, chance)
  -- function num : 0_10 , upvalues : _ENV, Item, ItemTypeEnum
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
    -- function num : 0_10_0
    if (a.item):GetID() >= (b.item):GetID() then
      do return (a.item):GetPinJiID() ~= (b.item):GetPinJiID() end
      do return (b.item):GetPinJiID() < (a.item):GetPinJiID() end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  ;
  (table.sort)(equip, function(a, b)
    -- function num : 0_10_1
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

MainLineFloorDialog.FireEvent = function(self, id)
  -- function num : 0_11 , upvalues : _ENV
  for _,node in ipairs(self._nodeData) do
    (node.dialog):OnEvent("SetSelected", id)
    for _,line in ipairs(node.line) do
      (line.dialog):OnEvent("SetSelected", id)
    end
  end
end

MainLineFloorDialog.StartEffectFireEvent = function(self)
  -- function num : 0_12 , upvalues : _ENV
  for _,node in ipairs(self._nodeData) do
    (node.dialog):OnEvent("StartEffect", self._select)
    for _,line in ipairs(node.line) do
      (line.dialog):OnEvent("StartEffect", self._select)
    end
  end
end

MainLineFloorDialog.OnCellClicked = function(self, select)
  -- function num : 0_13 , upvalues : _ENV, CDungeonSelectMainlineTable, CStringRes, CRoleLevelCfgTable, SortItemByPinji, TableFrame
  self._floorDetailIsChanging = true
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
            -- DECOMPILER ERROR at PC74: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self._floorDetail).id = v.id
            local recommendIds = (CDungeonSelectMainlineTable:GetRecorder((self._floorDetail).id)).recommendid
            local monsterIds = (CDungeonSelectMainlineTable:GetRecorder((self._floorDetail).id)).monsterid
            ;
            (self._recommendedRolesBtn):SetActive(#recommendIds > 0 or #monsterIds > 0)
            ;
            (self._recommendedRolesBtnBack):SetActive(#recommendIds > 0 or #monsterIds > 0)
            -- DECOMPILER ERROR at PC111: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (self._floorDetail).spirit = v.spirit
            -- DECOMPILER ERROR at PC114: Confused about usage of register: R10 in 'UnsetPending'

            ;
            (self._floorDetail).unlockLv = v.unlockLv
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
            local autoGoTag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AutoExplore)
            ;
            (self._autoGoBtn):SetActive(autoGoTag)
            ;
            (self._goBtn):SetActive(autoGoTag)
            ;
            (self._goBtnCenter):SetActive(not autoGoTag)
            self._autoGoBtnTipsNotShow = v.autoExplore == 0
            ;
            (self._autoGoBtn):SetInteractable(v.autoExplore == 1)
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
        (self._autoGoBtnTips):SetActive(false)
        self._floorDetailIsChanging = false
        -- DECOMPILER ERROR: 23 unprocessed JMP targets
      end
    end
  end
end

MainLineFloorDialog.OnGoBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self._floorDetailIsChanging then
    LogInfo("MainLineFloorDialog", "floorDetailIsChanging")
    return 
  end
  if (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel < (self._floorDetail).unlockLv then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100232, {(self._floorDetail).unlockLv})
  else
    if self._spirit < (self._floorDetail).spirit then
      (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
    else
      self._auto = false
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
end

MainLineFloorDialog.OnLeftArrowClicked = function(self)
  -- function num : 0_15
  local rightIndex = (self._itemFrame):GetRightIndex()
  ;
  (self._itemFrame):MoveRightToIndex(rightIndex - 1, true)
end

MainLineFloorDialog.OnRightArrowClicked = function(self)
  -- function num : 0_16
  local leftIndex = (self._itemFrame):GetLeftIndex()
  ;
  (self._itemFrame):MoveLeftToIndex(leftIndex + 1, true)
end

MainLineFloorDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_17 , upvalues : _ENV, limit
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

local set_activity_time = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local endtime = ((NekoData.BehaviorManager).BM_Activity):GetEndTime(1)
  local time = (ServerGameTimer.GetServerTimeForecast)()
  local info = (os.date)("!*t", (endtime - time) // 1000)
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1126)).msgTextID
  str = (TextManager.GetText)(str)
  str = str:gsub("%$parameter(%d)%$", {["1"] = info.day, ["2"] = info.hour, ["3"] = info.min})
  ;
  (self._activityTime):SetText(str)
end

MainLineFloorDialog.OnActivityUpdate = function(self)
  -- function num : 0_19 , upvalues : _ENV, set_activity_time
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

MainLineFloorDialog.SetActivityPower = function(self, floor, spirit)
  -- function num : 0_20 , upvalues : _ENV, set_activity_time
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

MainLineFloorDialog.OnBackBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if self._stateExitEventHandler then
    (self:GetRootWindow()):Unsubscribe_StateExitEvent(self._stateExitEventHandler)
    self._stateExitEventHandler = nil
  end
  self._stateExitEventHandler = (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnExitStageAnimationStateExit, self)
  ;
  (self._animator):Play("DungeonSelectHide")
  local dialog = (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")
  if dialog and dialog._fromTaskJump then
    (DialogManager.DestroySingletonDialog)("mainline.mainline.mainlineworlddialog")
  end
end

MainLineFloorDialog.OnExitStageAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_22
  if stateName == "DungeonSelectHide" then
    self:Destroy()
  end
end

MainLineFloorDialog.OnSwitchStageAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_23 , upvalues : _ENV
  if stateName == "DungeonSelectHide" then
    local dialog = (DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")
    if dialog then
      dialog:OnWorldIClicked(self._swichID, true)
    end
  end
end

MainLineFloorDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_24 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

MainLineFloorDialog.GetFloorDetail = function(self)
  -- function num : 0_25
  return self._floorDetail
end

MainLineFloorDialog.OnAddVITBtnClicked = function(self)
  -- function num : 0_26 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

MainLineFloorDialog.OnWorldExploreBoxClicked = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.newmainlinefloorworldrewarddialog")
  dialog:SetData(self._worldExploreData)
end

MainLineFloorDialog.OnDetailBoxClicked = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.newmainlinefloorchestrewarddialog")
  for _,v in ipairs(self._floorData) do
    if self._select == v.id then
      dialog:SetData({award = v.chestAward, id = v.id})
      break
    end
  end
end

MainLineFloorDialog.SetLeftWorldInfo = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local worldList = ((NekoData.BehaviorManager).BM_Game):GetDungeonList()
  self._lastWorldId = nil
  self._nextWorldId = nil
  self._curWorldId = nil
  local last = false
  for i,w in ipairs(worldList) do
    if last then
      self._nextWorldId = w.worldId
      break
    else
      self._lastWorldId = self._curWorldId
    end
    self._curWorldId = w.worldId
    if w.worldId == self._worldId then
      last = true
    end
  end
  do
    if self._lastWorldId then
      (self._lastWorldName):SetText((TextManager.GetText)(((self._worldTable)[self._lastWorldId]).worldTextID))
      ;
      (self._lastWorldBtn):SetActive(true)
      ;
      (self._leftBtn):SetActive(true)
    else
      ;
      (self._lastWorldBtn):SetActive(false)
      ;
      (self._leftBtn):SetActive(false)
    end
    if self._curWorldId then
      (self._curWorldNum):SetText(((self._worldTable)[self._curWorldId]).chapternum)
      ;
      (self._curWorldName):SetText((TextManager.GetText)(((self._worldTable)[self._curWorldId]).worldTextID))
      ;
      (self._curWorldBtn):SetActive(true)
    else
      ;
      (self._curWorldBtn):SetActive(false)
    end
    if self._nextWorldId then
      (self._nextWorldName):SetText((TextManager.GetText)(((self._worldTable)[self._nextWorldId]).worldTextID))
      ;
      (self._nextWorldBtn):SetActive(true)
      ;
      (self._rightBtn):SetActive(true)
    else
      ;
      (self._nextWorldBtn):SetActive(false)
      ;
      (self._rightBtn):SetActive(false)
    end
  end
end

MainLineFloorDialog.OnLastWorldBtnClicked = function(self)
  -- function num : 0_30
  self._swichID = self._lastWorldId
  ;
  (self._animator):Play("DungeonSelectHide")
end

MainLineFloorDialog.OnNextWorldBtnClicked = function(self)
  -- function num : 0_31
  self._swichID = self._nextWorldId
  ;
  (self._animator):Play("DungeonSelectHide")
end

MainLineFloorDialog.OnBeginDrag = function(self, args)
  -- function num : 0_32
  self._dragSpeed = 0
  self._dragDelta = 0
  self._slideTime = 0.5
  self._needUpdate = false
end

MainLineFloorDialog.OnDrag = function(self, args)
  -- function num : 0_33 , upvalues : UIManager
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

MainLineFloorDialog.OnEndDrag = function(self, args)
  -- function num : 0_34 , upvalues : UIManager, _ENV
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

MainLineFloorDialog.UpdateView = function(self, deltaTime)
  -- function num : 0_35
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

MainLineFloorDialog.OnLateUpdate = function(self, notification)
  -- function num : 0_36
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

MainLineFloorDialog.OnReceiveDungeonPointAward = function(self, notification)
  -- function num : 0_37 , upvalues : _ENV
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

MainLineFloorDialog.OnReceiveDungeonWorldAward = function(self, notification)
  -- function num : 0_38
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if self._worldId == (notification.userInfo).id then
    (self._worldExploreData).isReceived = 1
    ;
    (self._worldExploreBoxRedDot):SetActive(false)
  end
end

MainLineFloorDialog.OnAutoGoBtnClicked = function(self)
  -- function num : 0_39 , upvalues : _ENV
  if self._spirit < (self._floorDetail).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "AutoExploreMainline"
      data.id = self:GetSelectedId()
      data.spirit = (self._floorDetail).spirit
      dialog:SetInfo(data)
    end
  end
end

MainLineFloorDialog.OnWorldBtnDrag = function(self, args)
  -- function num : 0_40
  if (args.delta).x ~= 0 then
    self._direction = (args.delta).x
  end
end

MainLineFloorDialog.OnWorldBtnEndDrag = function(self, args)
  -- function num : 0_41
  -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

  if self._direction and self._direction > 0 and self._lastWorldId then
    self:OnLastWorldBtnClicked()
  end
  if self._direction < 0 and self._nextWorldId then
    self:OnNextWorldBtnClicked()
  end
end

MainLineFloorDialog.OnCurPosChange = function(self, frame, ratio)
  -- function num : 0_42
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

MainLineFloorDialog.OnAutoBtnClickAreaClicked = function(self)
  -- function num : 0_43 , upvalues : _ENV
  if self._autoGoBtnTipsNotShow then
    (self._autoGoBtnTips):SetActive(true)
    if self._autoTipsShowTask then
      (GameTimer.RemoveTask)(self._autoTipsShowTask)
      self._autoTipsShowTask = nil
    end
    self._autoTipsShowTask = (GameTimer.AddTask)(3, -1, function()
    -- function num : 0_43_0 , upvalues : self
    (self._autoGoBtnTips):SetActive(false)
  end
)
  end
end

MainLineFloorDialog.OnRecommendedRolesBtnClicked = function(self)
  -- function num : 0_44 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = (self._floorDetail).id
    data.type = "MainLine"
    dialog:Init(data)
  end
end

MainLineFloorDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_45 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

MainLineFloorDialog.SetRedDot = function(self)
  -- function num : 0_46
  (self._vitRedDot):SetActive(self:HaveSpiritItemSoonExpire())
end

MainLineFloorDialog.HandleSpriteEvidence = function(self)
  -- function num : 0_47 , upvalues : _ENV, CImagePathTable, CVarconfig, Item
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

return MainLineFloorDialog

