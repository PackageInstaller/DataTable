-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/resourcefloordialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResourceStageTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local cSceneJump = (BeanManager.GetTableByName)("scene.cscenejump")
local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local DungeonInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeoninfo")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local TypeInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeontype")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local UIManager = ((CS.PixelNeko).UI).UIManager
local MillisecondToDay = 86400000
local limit = nil
local ResourceFloorDialog = class("ResourceFloorDialog", Dialog)
ResourceFloorDialog.AssetBundleName = "ui/layouts.mainline"
ResourceFloorDialog.AssetName = "ResourceSelect"
local FinishGuide = function()
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(11, 3) then
    local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
    ;
    ((NekoData.BehaviorManager).BM_Game):SetGuideTag(GuideType.SPECIAL_ITEM, 1)
  end
end

ResourceFloorDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : ResourceFloorDialog
  ((ResourceFloorDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._spirit = nil
  self._stageData = {}
  self._itemData = {}
  self._floorDetail = {}
  self._select = nil
  self._timeTask = {}
  self._selectRequestSpirit = 0
  self._selectLittleTypeId = nil
  self._detailShow = false
  self._littleTypeRecordMap = {}
end

ResourceFloorDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : limit, _ENV, FinishGuide, ResourceStageTable, cSceneInfoStatic, cSceneJump, CStringRes
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._back = self:GetChild("BackImg")
  self._leftPanel_image = self:GetChild("LeftPanel/Image")
  self._leftPanel_leftLock = self:GetChild("LeftPanel/Image/Lock1")
  self._leftPanel_rightLock = self:GetChild("LeftPanel/Image/Lock2")
  self._title = self:GetChild("Title")
  self._autoBtn = self:GetChild("Detail/AutoBtn")
  self._autoGoBtnTips = self:GetChild("Detail/AutoBtn/Tips")
  ;
  (self._autoGoBtnTips):SetActive(false)
  self._autoBtnClickArea = self:GetChild("Detail/Click")
  self._dispatchBtn = self:GetChild("Detail/DispatchBtn")
  self._dispatchGoBtnTips = self:GetChild("Detail/DispatchBtn/Tips")
  self._dispatchBtn_Text = self:GetChild("Detail/DispatchBtn/_Text")
  ;
  (self._dispatchBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1854))
  ;
  (self._dispatchGoBtnTips):SetActive(false)
  self._dispatchtnClickArea = self:GetChild("Detail/DispatchClick")
  self._dispatchGoBtnTips_txt = self:GetChild("Detail/DispatchBtn/Tips/Txt1")
  self._goBtn = self:GetChild("Detail/GoBtn")
  self._goBtnCenter = self:GetChild("Detail/GoBtnCenter")
  self._recommendedteamBtn = self:GetChild("Detail/TeamBtn")
  self._vitPanel = self:GetChild("TopGroup/VIT")
  self._vitIcon = self:GetChild("TopGroup/VIT/Icon")
  self._vitRedDot = self:GetChild("TopGroup/VIT/redot")
  self._vitNum = self:GetChild("TopGroup/VIT/Text")
  self._detail1Panel = self:GetChild("Detail/Detail1")
  self._recommendCapacity = self:GetChild("Detail/Detail1/Txt2")
  self._recommendBreak = self:GetChild("Detail/Detail1/BreakNumTxt")
  self._detail1Panel_NoBreak = self:GetChild("Detail/Detail1_NoneBreak")
  self._recommendCapacity_NoBreak = self:GetChild("Detail/Detail1_NoneBreak/Txt2")
  self._power = self:GetChild("Detail/CostBack/Txt2")
  self._powerRed = self:GetChild("Detail/CostBack/Txt2Red")
  self._oldPower = self:GetChild("Detail/CostBack/Txt2Delete")
  self._chapterName = self:GetChild("Detail/LevelNum")
  self._firstItemPanel = self:GetChild("Detail/CellPanel")
  self._stagePanel = self:GetChild("LeftPanel")
  self._describe = self:GetChild("Detail/Detail2/Txt")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._recommendedRolesBtn = self:GetChild("Detail/Ibtn")
  self._jobLimit = self:GetChild("Detail/JobLimit")
  self._littleTypes = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC176: Confused about usage of register: R5 in 'UnsetPending'

      (self._littleTypes)[i] = {}
      -- DECOMPILER ERROR at PC184: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._littleTypes)[i]).btn = self:GetChild("GroupBtn" .. R9_PC182)
      -- DECOMPILER ERROR at PC193: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._littleTypes)[i]).img = self:GetChild("GroupBtn" .. R9_PC182 .. "/Img")
      -- DECOMPILER ERROR at PC198: Overwrote pending register: R9 in 'AssignReg'

      -- DECOMPILER ERROR at PC202: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._littleTypes)[i]).txt = self:GetChild("GroupBtn" .. R9_PC182 .. "/Txt")
      -- DECOMPILER ERROR at PC207: Overwrote pending register: R9 in 'AssignReg'

      -- DECOMPILER ERROR at PC211: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._littleTypes)[i]).effect = self:GetChild("GroupBtn" .. R9_PC182 .. "/Effect")
      ;
      (((self._littleTypes)[i]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_2_0 , upvalues : self, i
    self:OnLittleTypeBtnClicked(i)
  end
)
    end
  end
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._autoBtn):Subscribe_PointerClickEvent(self.OnAutoBtnClicked, self)
  ;
  (self._autoBtnClickArea):Subscribe_PointerClickEvent(self.OnAutoBtnClickAreaClicked, self)
  ;
  (self._dispatchBtn):Subscribe_PointerClickEvent(self.OnDispatchBtnClicked, self)
  ;
  (self._dispatchtnClickArea):Subscribe_PointerClickEvent(self.OnDispatchBtnClickAreaClicked, self)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._goBtnCenter):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._vitPanel):Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  ;
  (self._recommendedRolesBtn):Subscribe_PointerClickEvent(self.OnRecommendedRolesBtnClicked, self)
  ;
  (self._recommendedteamBtn):Subscribe_PointerClickEvent(self.OnRecommendedTeamClicked, self)
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritLimit, Common.n_StrengthLimitChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSResourcePanel, Common.n_ReceiveResourcePanel, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.HandleSpriteEvidence, Common.n_RefreshSpirit, nil)
  ;
  (UIBackManager.SwitchToNext)()
  local cellDialog = (DialogManager.CreateDialog)("mainline.resource.resourcefloorbigcell", nil)
  local rootWindow = cellDialog:GetRootWindow()
  self._bigCellWidth = rootWindow:GetRectSize()
  cellDialog:RootWindowDestroy()
  self._stageTable = {}
  for _,id in ipairs(ResourceStageTable:GetAllIds()) do
    -- DECOMPILER ERROR at PC383: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC384: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC387: Confused about usage of register: R8 in 'UnsetPending'

    (self._stageTable)[id] = R9_PC182
  end
  self._cSceneInfoStatic = {}
  for _,id in ipairs(cSceneInfoStatic:GetAllIds()) do
    -- DECOMPILER ERROR at PC399: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC400: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC403: Confused about usage of register: R8 in 'UnsetPending'

    (self._cSceneInfoStatic)[id] = R9_PC182
  end
  self._cSceneJump = {}
  for _,id in ipairs(cSceneJump:GetAllIds()) do
    -- DECOMPILER ERROR at PC415: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC416: Overwrote pending register: R9 in 'AssignReg'

    -- DECOMPILER ERROR at PC419: Confused about usage of register: R8 in 'UnsetPending'

    (self._cSceneJump)[id] = R9_PC182
  end
  self._originalX = (self._stagePanel):GetPosition()
  local _ = nil
  self._panelWidth = (self._stagePanel):GetRectSize()
  self._screenWidth = (self:GetRootWindow()):GetRectSize()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
  self._ibtn = self:GetChild("Tips/Ibtn")
  self._Txt = self:GetChild("Tips/Txt")
  -- DECOMPILER ERROR at PC465: Overwrote pending register: R9 in 'AssignReg'

  ;
  (self._Txt):SetText((TextManager.GetText)((CStringRes:GetRecorder(R9_PC182)).msgTextID))
  ;
  (self._ibtn):Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self:HandleSpriteEvidence()
end

ResourceFloorDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  self:DestroyNodeDialog()
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
  if self._timeTask then
    (ServerGameTimer.RemoveTask)(self._timeTask)
    self._timeTask = nil
  end
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.spiritrecoverdialog")
  ;
  (DialogManager.DestroySingletonDialog)("teamedit.teameditprewardialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.resource.completelineupdialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.offlinesweep.offlinesweeptipdialog")
end

ResourceFloorDialog.DestroyNodeDialog = function(self)
  -- function num : 0_4 , upvalues : _ENV
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

ResourceFloorDialog.OnSResourcePanel = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local resourcePanelList = ((NekoData.BehaviorManager).BM_Game):GetResourcePanelList()
  for i,d in ipairs(resourcePanelList) do
    if d.id == (self._data).id then
      self:SetData(d)
      break
    end
  end
end

ResourceFloorDialog.RefreshOfflineSweepActive = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local status = ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus()
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if status ~= 0 and self._offlinesweepDialog == nil then
    self._offlinesweepDialog = (DialogManager.CreateDialog)("mainline.offlinesweep.offlinesweepshowbtndialog", (self._rootWindow)._uiObject)
  end
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
end

ResourceFloorDialog.SetRefreshData = function(self, littleType, playChainsAnimation, fromItemTipsJump)
  -- function num : 0_7 , upvalues : _ENV, CImagePathTable, CRoleLevelCfgTable, SingletonSlideFrame, DungeonInfoTable
  self:DestroyNodeDialog()
  self._nodeData = {}
  local index = littleType
  if not index then
    index = 1
    if not self._haveNoLittleTypes then
      self._selectLittleTypeId = index
    end
  end
  if self._haveNoLittleTypes then
    for i,v in ipairs(self._littleTypes) do
      (v.btn):SetActive(false)
    end
  else
    do
      for i,v in ipairs(self._littleTypes) do
        (v.btn):SetActive(true)
        ;
        (v.btn):SetSelected(i == self._selectLittleTypeId)
        if not CImagePathTable:GetRecorder(((self._littleTypeRecordMap)[i]).tabImage) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (v.img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      do
        if index then
          local data = ((self._data).detailInfo)[index]
          if (self._data).open and data.open then
            self._endTimeNum = data.endTime
            if self._endTimeNum > 0 then
              if self._timeTask then
                (ServerGameTimer.RemoveTask)(self._timeTask)
                self._timeTask = nil
              end
              self._timeTask = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_7_0 , upvalues : self
    self:RefreshTimeTask()
  end
, nil)
            end
            self._dungeonTypeId = nil
            self._stageData = {}
            local addNextLockStage = false
            local select = nil
            local userLevel = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
            for _,v in ipairs(data.stageList) do
              local oneline = (self._stageTable)[v.id]
              if not self._select and v.id == data.curStage then
                self._select = v.id
              end
              if not self._select and not v.lock and oneline.level <= userLevel and not fromItemTipsJump then
                select = v.id
              end
              if self._dungeonTypeId and self._dungeonTypeId ~= oneline.dungeonID then
                LogWarningFormat("ResourceFloorDialog", "there is more than one dungeonID in %s", oneline.dungeonID)
              end
              self._dungeonTypeId = oneline.dungeonID
              if oneline then
                local temp = {}
                temp.id = v.id
                temp.lock = v.lock
                temp.recommendLevel = oneline.levelShow
                temp.minRoleLevel = (CRoleLevelCfgTable:GetRecorder(temp.recommendLevel)).clientLevel
                temp.minBreakLevel = (CRoleLevelCfgTable:GetRecorder(temp.recommendLevel)).clientBreakLevel
                temp.clear = v.clear
                temp.exploreProgress = v.exploreProgress
                temp.spirit = v.spirit
                temp.firstItem = {itemList = oneline.firstItems, numList = oneline.firstItemNums}
                temp.firstGet = v.firstGet
                temp.levelLimit = oneline.level
                temp.maybeItem = oneline.mayDropItems
                temp.sureDropItem = oneline.sureDropItems
                temp.activityItems = v.activityItems
                temp.name = (TextManager.GetText)(oneline.typeNameTextID)
                temp.describe = (TextManager.GetText)(oneline.describeTextID)
                temp.timelength = oneline.mopupTime
                temp.littleImgID = oneline.imageID
                temp.delegate = self
                local pos = (string.split)(oneline.nodepos, ",")
                temp.pos = {x = tonumber(pos[1]), y = tonumber(pos[2])}
                ;
                (table.insert)(self._stageData, temp)
                if (not temp.lock and temp.levelLimit <= userLevel) or not addNextLockStage then
                  (table.insert)(self._nodeData, {value = temp, parentId = nil, 
childIdList = {}
, type = "big", 
line = {}
, dialog = nil})
                  if (temp.lock or userLevel < temp.levelLimit) and not addNextLockStage then
                    addNextLockStage = true
                  end
                end
              end
            end
            ;
            (table.sort)(self._stageData, function(a, b)
    -- function num : 0_7_1
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
            if not self._select then
              if select then
                self._select = select
              elseif (self._stageData)[1] then
                self._select = ((self._stageData)[1]).id
              else
                LogError("ResourceFloorDialog", "there is no curStage and no stageData")
              end
            end
            self._stageList = {}
            for _,r in pairs(self._stageTable) do
              if r.dungeonID == self._dungeonTypeId then
                (table.insert)(self._stageList, {id = r.id})
              end
            end
            ;
            (table.sort)(self._stageList, function(a, b)
    -- function num : 0_7_2
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
            ;
            (table.sort)(self._nodeData, function(a, b)
    -- function num : 0_7_3
    do return (a.value).id < (b.value).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
            self:BuildNodeData()
            ;
            (self._stagePanel):SetWidth(0, self._panelWidth + self._screenWidth / 2)
            if #self._stageData ~= 0 then
              self._panelPos = 0
            end
            local nodePos = 0
            for _,node in ipairs(self._nodeData) do
              if (node.value).id == self._select then
                nodePos = ((node.value).pos).x
                break
              end
            end
            self._panelPos = -nodePos + self._screenWidth / 2
            if self._panelPos < -self._panelWidth + self._screenWidth / 2 then
              self._panelPos = -self._panelWidth + self._screenWidth / 2
            end
            if self._panelPos > 0 then
              self._panelPos = 0
            end
            ;
            (self._stagePanel):SetPosition(0, self._panelPos, self._originalY, self._originalOY)
            self:OnCellClicked(self._select, false, false)
            if self._singletonSlideFrame then
              (self._singletonSlideFrame):Destroy()
            end
            local rectTransform = ((self._rootWindow)._uiObject):GetComponent("RectTransform")
            local stageRectTransform = ((self._stagePanel)._uiObject):GetComponent("RectTransform")
            local pivotX, pivotY = (self._stagePanel):GetPivotPosition()
            local xMinEdge = (rectTransform.rect).xMin + pivotX * (stageRectTransform.rect).width
            local xMaxEdge = (rectTransform.rect).xMax - (1 - pivotX) * (stageRectTransform.rect).width
            self._singletonSlideFrame = (SingletonSlideFrame.Create)(self._stagePanel, false, xMinEdge, xMaxEdge)
            local dungeonInfoRecord = DungeonInfoTable:GetRecorder(data.id)
            local imageRecord = CImagePathTable:GetRecorder(dungeonInfoRecord.backgroundimage)
            if imageRecord then
              (self._back):SetActive(true)
              ;
              (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            else
              (self._back):SetActive(false)
            end
            imageRecord = CImagePathTable:GetRecorder(dungeonInfoRecord.image)
            ;
            (self._leftPanel_image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            if not self._init or playChainsAnimation then
              self._init = true
              if dungeonInfoRecord.showChains == 1 then
                (self._leftPanel_leftLock):SetActive(true)
                ;
                (self._leftPanel_rightLock):SetActive(true)
                ;
                (self._leftPanel_image):PlayAnimation("DungeonSelectLine")
              else
                (self._leftPanel_leftLock):SetActive(false)
                ;
                (self._leftPanel_rightLock):SetActive(false)
              end
            end
            if dungeonInfoRecord.showChains == 1 then
              imageRecord = CImagePathTable:GetRecorder(dungeonInfoRecord.chainsImage)
              ;
              (self._leftPanel_leftLock):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
              ;
              (self._leftPanel_rightLock):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            end
            self:SetRedDot()
          else
            LogErrorFormat("ResourceFloorDialog", "the stage(dungeonInfoId: %s) is not open", data.id)
          end
        end
        -- DECOMPILER ERROR: 31 unprocessed JMP targets
      end
    end
  end
end

ResourceFloorDialog.SetData = function(self, data, fromItemTipsJump)
  -- function num : 0_8 , upvalues : TypeInfoTable, _ENV, DungeonInfoTable
  self._data = data
  local record = TypeInfoTable:GetRecorder((self._data).id)
  self._haveNoLittleTypes = record.showsmalltype == 0
  ;
  (self._title):SetText((TextManager.GetText)(record.nameTextID))
  for k,v in pairs(self._littleTypeRecordMap) do
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

    (self._littleTypeRecordMap)[k] = nil
  end
  local allIds = DungeonInfoTable:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = DungeonInfoTable:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R11 in 'UnsetPending'

    if record.typeID == (self._data).id then
      (self._littleTypeRecordMap)[record.sortID] = record
    end
  end
  self:SetRefreshData(self._selectLittleTypeId, false, fromItemTipsJump)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ResourceFloorDialog.BuildNodeData = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local index = 1
  for _,outData in ipairs(self._nodeData) do
    if (outData.value).id == ((self._stageList)[index]).id then
      index = index + 1
      if #self._stageList >= index then
        for _,inData in ipairs(self._nodeData) do
          if (inData.value).id == ((self._stageList)[index]).id then
            local outDataChildSceneId = (outData.value).id
            for _,threeData in ipairs(self._nodeData) do
              if (threeData.value).id == outDataChildSceneId then
                (table.insert)(threeData.childIdList, (inData.value).id)
                break
              end
            end
            do
              do
                inData.parentId = outDataChildSceneId
                do break end
                -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for _,node in ipairs(self._nodeData) do
    for _,child in ipairs(node.childIdList) do
      local pos = (string.split)(((self._stageTable)[child]).nodepos, ",")
      local line = {
p = {id = (node.value).id, pos = (node.value).pos}
, 
c = {id = child, 
pos = {x = tonumber(pos[1]), y = tonumber(pos[2])}
}
, bigParentId = node.bigParentId, dialog = nil}
      local pId, cId = nil, nil
      for _,d in pairs(self._stageTable) do
        if d.id == (line.p).id then
          pId = d.id
          break
        end
      end
      do
        for _,d in pairs(self._stageTable) do
          if d.id == (line.c).id then
            cId = d.id
            break
          end
        end
        do
          do
            -- DECOMPILER ERROR at PC122: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (line.p).width = self._bigCellWidth
            -- DECOMPILER ERROR at PC125: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (line.p).height = self._bigCellHeight
            -- DECOMPILER ERROR at PC128: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (line.c).width = self._bigCellWidth
            -- DECOMPILER ERROR at PC131: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (line.c).height = self._bigCellHeight
            ;
            (table.insert)(node.line, line)
            -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
  for _,node in ipairs(self._nodeData) do
    for _,line in ipairs(node.line) do
      line.dialog = (DialogManager.CreateDialog)("mainline.resource.resourcefloorlinecell", (self._stagePanel)._uiObject)
      ;
      (line.dialog):RefreshCell({parentId = (line.p).id, bigParentId = line.bigParentId})
      local deltaX = ((line.c).pos).x + (line.c).width / 2 - (((line.p).pos).x + (line.p).width / 2)
      local deltaY = ((line.c).pos).y + (line.c).height / 2 - (((line.p).pos).y + (line.p).height / 2)
      ;
      (line.dialog):SetWidth(deltaX ^ 2 + deltaY ^ 2 ^ 0.5)
      ;
      (line.dialog):SetPosition(0, ((line.p).pos).x + (line.p).width / 2, 0, ((line.p).pos).y + (line.p).height / 2)
      ;
      (line.dialog):SetZRotation(1, 0, deltaX, deltaY)
    end
  end
  self._panelWidth = ((((self._nodeData)[1]).value).pos).x
  for _,node in ipairs(self._nodeData) do
    if node.type == "big" then
      node.dialog = (DialogManager.CreateDialog)("mainline.resource.resourcefloorbigcell", (self._stagePanel)._uiObject)
      ;
      (node.dialog):RefreshCell(node.value)
      ;
      (node.dialog):SetPosition(0, ((node.value).pos).x, 0, ((node.value).pos).y)
    end
    if self._panelWidth < ((node.value).pos).x then
      self._panelWidth = ((node.value).pos).x
    end
  end
end

ResourceFloorDialog.GetSelectedId = function(self)
  -- function num : 0_10
  return self._select
end

ResourceFloorDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._itemFrame then
    return "mainline.mainline.newmainlineflooritemcell"
  end
end

ResourceFloorDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._itemFrame then
    return (self._itemData)[index]
  end
end

ResourceFloorDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13
  if frame == self._itemFrame then
    return #self._itemData
  end
end

local BuildData = function(items, get, first, maybe, sure, activityLimit)
  -- function num : 0_14 , upvalues : _ENV, Item, ItemTypeEnum
  local resultData = {}
  local itemList = items.itemList or items
  if not items.numList then
    local numList = {}
  end
  for index,id in ipairs(itemList) do
    local item = (Item.Create)(id)
    ;
    (table.insert)(resultData, {item = item, num = numList[index], get = get, first = first, normal = sure, chance = maybe, activityLimit = activityLimit})
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
    -- function num : 0_14_0
    do return (b.item):GetPinJiID() < (a.item):GetPinJiID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(equip, function(a, b)
    -- function num : 0_14_1
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

ResourceFloorDialog.FireEvent = function(self, id)
  -- function num : 0_15 , upvalues : _ENV
  for _,node in ipairs(self._nodeData) do
    (node.dialog):OnEvent("SetSelected", id)
  end
end

ResourceFloorDialog.OnCellClicked = function(self, select, isStageId, isRefreshPos)
  -- function num : 0_16 , upvalues : _ENV, BuildData, TableFrame
  local stageId = ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).Resource_Mana)
  if stageId == select then
    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).Resource_Mana)
  end
  local lastDetailShow = self._detailShow
  if not isRefreshPos then
    self._detailShow = true
  end
  local lastSelect = self._select
  if isStageId then
    self._select = ((self._stageTable)[select]).id
  else
    self._select = select
  end
  local onlyRefreshAuto = nil
  if self._select == lastSelect and not isRefreshPos and lastDetailShow == self._detailShow then
    onlyRefreshAuto = true
  end
  if onlyRefreshAuto then
    for _,v in ipairs(self._stageData) do
      if self._select == v.id then
        local autoBtnTag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AutoExplore)
        ;
        (self._autoBtn):SetActive(autoBtnTag)
        ;
        (self._goBtn):SetActive(autoBtnTag)
        ;
        (self._goBtnCenter):SetActive(not autoBtnTag)
        ;
        (self._autoBtn):SetInteractable(v.firstGet)
        local dispatchBtnTag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).OffLineSweep)
        ;
        (self._dispatchBtn):SetActive(dispatchBtnTag)
        ;
        (self._dispatchBtn):SetInteractable(v.firstGet)
        break
      end
    end
  else
    do
      if not isRefreshPos then
        if self._detailShow then
          (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailShow")
        else
          ;
          (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailHide")
        end
      end
      if self._select then
        local nodePos = 0
        for _,node in ipairs(self._nodeData) do
          if (node.value).id == self._select then
            nodePos = ((node.value).pos).x
            break
          end
        end
        do
          self._moveDesPos = -nodePos + self._screenWidth / 2
          if self._moveDesPos < -self._panelWidth + self._screenWidth / 2 then
            self._moveDesPos = -self._panelWidth + self._screenWidth / 2
          end
          if self._moveDesPos > 0 then
            self._moveDesPos = 0
          end
          local px, pox, py, poy = (self._stagePanel):GetPosition()
          self._panelPos = pox
          local first = {pos = self._panelPos}
          do
            local last = {pos = self._moveDesPos}
            self._moveTask = (Tween.new)(0.2, first, last, "linear")
            self._needUpdate = true
            self:FireEvent(self._select)
            for _,v in ipairs(self._stageData) do
              if self._select == v.id then
                local autoBtnTag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AutoExplore)
                ;
                (self._autoBtn):SetActive(autoBtnTag)
                ;
                (self._goBtn):SetActive(autoBtnTag)
                ;
                (self._goBtnCenter):SetActive(not autoBtnTag)
                ;
                (self._autoBtn):SetInteractable(v.firstGet)
                local dispatchBtnTag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).OffLineSweep)
                ;
                (self._dispatchBtn):SetActive(dispatchBtnTag)
                ;
                (self._dispatchBtn):SetInteractable(v.firstGet)
                -- DECOMPILER ERROR at PC225: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (self._floorDetail).id = v.id
                -- DECOMPILER ERROR at PC228: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (self._floorDetail).spirit = v.spirit
                -- DECOMPILER ERROR at PC231: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (self._floorDetail).timelength = v.timelength
                -- DECOMPILER ERROR at PC234: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (self._floorDetail).littleImgID = v.littleImgID
                -- DECOMPILER ERROR at PC237: Confused about usage of register: R15 in 'UnsetPending'

                ;
                (self._floorDetail).name = v.name
                ;
                (self._jobLimit):SetActive(((NekoData.BehaviorManager).BM_Vocation):GetVocationIDs(v.id) ~= "")
                ;
                (self._detail1Panel):SetActive(v.minBreakLevel > 0)
                ;
                (self._detail1Panel_NoBreak):SetActive(v.minBreakLevel == 0)
                if v.minBreakLevel > 0 then
                  (self._recommendBreak):SetText(v.minBreakLevel)
                  ;
                  (self._recommendCapacity):SetText(v.minRoleLevel)
                else
                  (self._recommendCapacity_NoBreak):SetText(v.minRoleLevel)
                end
                ;
                (self._chapterName):SetText(v.name)
                ;
                (self._describe):SetText(v.describe)
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
                self:SetPower(v.id, v.spirit)
                local firstItemData = BuildData(v.firstItem, v.firstGet, true)
                local chanceItemData = BuildData(v.maybeItem, false, false, true, false)
                local normalItemData = BuildData(v.sureDropItem, false, false, false, true)
                local activityItemsData = BuildData(v.activityItems, false, false, false, false, true)
                self._itemData = {}
                for _,list in ipairs({activityItemsData, firstItemData, normalItemData, chanceItemData}) do
                  for _,v in ipairs(list) do
                    (table.insert)(self._itemData, v)
                  end
                end
                if self._itemFrame then
                  (self._itemFrame):Destroy()
                  self._itemFrame = nil
                end
                self._itemFrame = (TableFrame.Create)(self._firstItemPanel, self, false, true)
                ;
                (self._itemFrame):ReloadAllCell()
                break
              end
            end
            -- DECOMPILER ERROR: 12 unprocessed JMP targets
          end
        end
      end
    end
  end
end

ResourceFloorDialog.SetPower = function(self, floor, spirit)
  -- function num : 0_17 , upvalues : _ENV
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
  end
end

ResourceFloorDialog.OnGoBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self._spirit < (self._floorDetail).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    self._auto = false
    if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).AssistBattle) then
      ((NekoData.DataManager).DM_Team):ClearSupportRole()
      ;
      ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo("Resource", (self._floorDetail).id)
      local crefreshSupportRoleList = (LuaNetManager.CreateProtocol)("protocol.chat.crefreshsupportrolelist")
      crefreshSupportRoleList:Send()
    else
      do
        local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
        if dialog then
          dialog:SetCopyInfo("Resource", (self._floorDetail).id)
        end
      end
    end
  end
end

ResourceFloorDialog.OnRecommendedTeamClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copencompletelineup")
  csend.zoneId = (self._floorDetail).id
  csend.playType = csend.RESOURCE_LINEUP
  csend:Send()
  ;
  (DialogManager.CreateSingletonChildDialog)("mainline.resource.completelineupdialog", self._dialogName, self:GetRootWindow())
end

ResourceFloorDialog.OnAutoBtnClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self._spirit < (self._floorDetail).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.autoexplorecontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "AutoExploreResource"
      data.id = (self._floorDetail).id
      data.spirit = (self._floorDetail).spirit
      dialog:SetInfo(data)
    end
  end
end

ResourceFloorDialog.OnDispatchBtnClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_OfflineSweep):GetTodayLeftNum() <= 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100471)
    return 
  end
  if ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus() ~= 0 then
    if ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus() == 1 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100474)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100475)
    end
    return 
  end
  if self._spirit < (self._floorDetail).spirit then
    (DialogManager.CreateSingletonDialog)("bag.spiritrecoverdialog")
  else
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.offlinesweepcontinuedialog")
    if dialog then
      local data = {}
      data.copyType = "DispatchResource"
      data.id = (self._floorDetail).id
      data.name = (self._floorDetail).name
      data.spirit = (self._floorDetail).spirit
      data.timelength = (self._floorDetail).timelength
      data.littleImgID = (self._floorDetail).littleImgID
      dialog:SetInfo(data)
    end
  end
end

ResourceFloorDialog.OnAutoBtnClickAreaClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100473)
end

ResourceFloorDialog.OnDispatchBtnClickAreaClicked = function(self)
  -- function num : 0_23 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100473)
end

ResourceFloorDialog.OnTipBtnClicked = function(self)
  -- function num : 0_24 , upvalues : _ENV, CStringRes
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.offlinesweep.offlinesweeptipdialog")
  if dialog then
    local content = (CStringRes:GetRecorder(1855)).msgTextID
    local title = (CStringRes:GetRecorder(1870)).msgTextID
    dialog:SetData(content, title)
  end
end

ResourceFloorDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_25 , upvalues : _ENV, limit
  (self._vitNum):SetText((NumberManager.GetShowNumber)((notification.userInfo).spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  self._spirit = (notification.userInfo).spirit
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

ResourceFloorDialog.RefreshSpiritLimit = function(self)
  -- function num : 0_26 , upvalues : limit, _ENV
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
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

ResourceFloorDialog.RefreshTimeTask = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local time = self._endTimeNum - (ServerGameTimer.GetServerTimeForecast)()
  if time < 0 then
    time = 0
    if self._timeTask then
      (ServerGameTimer.RemoveTask)(self._timeTask)
      self._timeTask = nil
    end
  end
  local tempTimeTable = (os.date)("!*t", time // 1000)
  if time < 86400000 then
  end
end

ResourceFloorDialog.OnBackBtnClicked = function(self)
  -- function num : 0_28
  self:Destroy()
end

ResourceFloorDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_29 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ResourceFloorDialog.GetFloorDetail = function(self)
  -- function num : 0_30
  return self._floorDetail
end

ResourceFloorDialog.OnAddVITBtnClicked = function(self)
  -- function num : 0_31 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

ResourceFloorDialog.OnBeginDrag = function(self, args)
  -- function num : 0_32
  self._dragSpeed = 0
  self._dragDelta = 0
  self._slideTime = 0.5
  self._needUpdate = false
end

ResourceFloorDialog.OnDrag = function(self, args)
  -- function num : 0_33 , upvalues : UIManager
  local pressPosition = args.pressPosition
  local position = args.position
  local localPressX, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._stagePanel)._uiObject, pressPosition.x, pressPosition.y)
  local localX, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._stagePanel)._uiObject, position.x, position.y)
  self._dragSpeed = args.xSpeed / 10
  local currentPosition = self._panelPos
  self._panelPos = currentPosition - self._dragDelta
  self._dragDelta = localX - localPressX
  self._panelPos = self._panelPos + self._dragDelta
  if self._panelPos < -self._panelWidth + self._screenWidth / 2 then
    self._panelPos = -self._panelWidth + self._screenWidth / 2
  end
  if self._panelPos > 0 then
    self._panelPos = 0
  end
  if currentPosition ~= self._panelPos then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

ResourceFloorDialog.OnEndDrag = function(self, args)
  -- function num : 0_34 , upvalues : UIManager, _ENV
  self._dragDelta = 0
  local original, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._stagePanel)._uiObject, 0, 0)
  local speed, _ = (UIManager.ScreenPointToLocalPointInRectangle)((self._stagePanel)._uiObject, self._dragSpeed, 0)
  speed = original - speed
  self._dragSpeed = speed
  if self._panelPos < -self._panelWidth + self._screenWidth / 2 then
    self._panelPos = -self._panelWidth + self._screenWidth / 2
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

ResourceFloorDialog.UpdateView = function(self, deltaTime)
  -- function num : 0_35
  if self._needUpdate then
    (self._stagePanel):SetPosition(0, self._panelPos, self._originalY, self._originalOY)
    if not self._slideTask and not self._moveTask then
      self._needUpdate = false
    end
  end
end

ResourceFloorDialog.OnLateUpdate = function(self, notification)
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

      if self._slideTask and (-self._panelWidth + self._screenWidth / 2 < self._panelPos or self._panelPos < 0) then
        (self._slideTask).clock = (self._slideTask).clock + 2 * deltaTime
      end
      if self._panelPos < -self._panelWidth + self._screenWidth / 2 then
        self._panelPos = -self._panelWidth + self._screenWidth / 2
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

ResourceFloorDialog.OnRecommendedRolesBtnClicked = function(self)
  -- function num : 0_37 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.dungeonselectdetail.dungeonselectdetaildialog")
  if dialog then
    local data = {}
    data.id = (self._floorDetail).id
    data.type = "Resource"
    dialog:Init(data)
  end
end

ResourceFloorDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_38 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

ResourceFloorDialog.SetRedDot = function(self)
  -- function num : 0_39
  (self._vitRedDot):SetActive(self:HaveSpiritItemSoonExpire())
end

ResourceFloorDialog.OnLittleTypeBtnClicked = function(self, index)
  -- function num : 0_40 , upvalues : _ENV
  if self._selectLittleTypeId ~= index then
    ((NekoData.BehaviorManager).BM_Team):SaveTeamEditCopyInfo("Resource")
    self._selectLittleTypeId = index
    local lastDetailShow = self._detailShow
    self._detailShow = false
    self._select = nil
    if lastDetailShow then
      (self:GetRootWindow()):PlayAnimation("ResourceSelectDetailHide")
    end
    self:SetRefreshData(index, true)
  end
end

ResourceFloorDialog.HandleSpriteEvidence = function(self)
  -- function num : 0_41 , upvalues : _ENV, CImagePathTable, CVarconfig, Item
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

return ResourceFloorDialog

