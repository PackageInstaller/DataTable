-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushweekcultivatedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local BossRushWeekCultivateDialog = class("BossRushWeekCultivateDialog", Dialog)
BossRushWeekCultivateDialog.AssetBundleName = "ui/layouts.mainline"
BossRushWeekCultivateDialog.AssetName = "BossRushWeekSkill"
BossRushWeekCultivateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushWeekCultivateDialog, _ENV
  ((BossRushWeekCultivateDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = (NekoData.BehaviorManager).BM_WeekBoss
  self._skillNodePosData = {}
  self._skillNodeLineCells = {}
  self._unlockSkillNodes = {}
  self._selectNodeId = -1
  self._rowCellList = {}
  self._skillNodeLineCells = {}
end

BossRushWeekCultivateDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._titleTxt = self:GetChild("Title")
  self._skillFrame = self:GetChild("Frame/SkillFrame")
  self._initLocal_posX = (self._skillFrame):GetLocalPosition()
  self._skillFrameWidth = (self._skillFrame):GetDeltaSize()
  self._skillNodeFrame = self:GetChild("Frame/SkillFrame/Frame")
  self._lineFrame = self:GetChild("Frame/SkillFrame/FrameLine")
  self._tipsTxt = self:GetChild("Back/Txt")
  self._skillEffectDetail = self:GetChild("Back/PropSkill/Frame/Detail")
  self._detailTitleTxt = self:GetChild("Back/PropSkill/Effect")
  self._skillName = self:GetChild("Back/PropSkill/SkillName")
  self._rightSkillImgFrame = self:GetChild("Back/PropSkill/Skill")
  self._canUnlockSkillTimesTxt = self:GetChild("NeedTxt/Txt")
  self._unlockTimesTxt = self:GetChild("Back/Down/Need/Txt1")
  self._unlockBtn = self:GetChild("Back/Down/Btn")
  self._unlockBtnTxt = self:GetChild("Back/Down/Btn/_Text")
  self._beforeLockCannotUnlockPanel = self:GetChild("Back/Down/Lock")
  self._beforeLockCannotUnlockBtn = self:GetChild("Back/Down/Lock/Btn")
  self._beforeLockCannotUnlockTxt = self:GetChild("Back/Down/Lock/Txt")
  self._beforeLockCannotUnlockBtnTxt = self:GetChild("Back/Down/Lock/Btn/_Text")
  self._unlockPanel = self:GetChild("Back/UnLock")
  self._unlockTxt = self:GetChild("Back/UnLock/Txt")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._unlockBtn):Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSWeekBossTalent, Common.n_SWeekBossTalent, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSImproveTalent, Common.n_SImproveTalent, nil)
  local cellDialog = (DialogManager.CreateDialog)("mainline.bossrush.bossrushweekcultivateskillcell", nil)
  self._rowCellWidth = (cellDialog._rootWindow):GetRectSize()
  cellDialog:RootWindowDestroy()
  self:Init()
  self:InitRefresh()
end

BossRushWeekCultivateDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  do
    while (self._rowCellList)[#self._rowCellList] do
      local dialog = (self._rowCellList)[#self._rowCellList]
      dialog:Destroy()
      dialog:RootWindowDestroy()
      ;
      (table.remove)(self._rowCellList, #self._rowCellList)
    end
    do
      while (self._skillNodeLineCells)[#self._skillNodeLineCells] do
        local dialog = (self._skillNodeLineCells)[#self._skillNodeLineCells]
        dialog:Destroy()
        dialog:RootWindowDestroy()
        ;
        (table.remove)(self._skillNodeLineCells, #self._skillNodeLineCells)
      end
      if self._rightSkillDialog then
        (self._rightSkillDialog):Destroy()
        ;
        (self._rightSkillDialog):RootWindowDestroy()
        self._rightSkillDialog = nil
      end
      if self._singletonSlideFrame then
        (self._singletonSlideFrame):Destroy()
      end
    end
  end
end

BossRushWeekCultivateDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._rightSkillDialog = (DialogManager.CreateDialog)("mainline.bossrush.bossrushweekcultivaterightskillcelldialog", (self._rightSkillImgFrame)._uiObject)
  ;
  (self._unlockBtnTxt):SetText((TextManager.GetText)(1901582))
  ;
  (self._unlockTxt):SetText((TextManager.GetText)(1901583))
  ;
  (self._beforeLockCannotUnlockTxt):SetText((TextManager.GetText)(1901585))
  ;
  (self._beforeLockCannotUnlockBtnTxt):SetText((TextManager.GetText)(1901584))
  ;
  (self._tipsTxt):SetText((TextManager.GetText)(1901580))
  ;
  (self._titleTxt):SetText((TextManager.GetText)(1901579))
  ;
  (self._detailTitleTxt):SetText((TextManager.GetText)(1901623))
end

local BuildRowNodeData = function(self)
  -- function num : 0_4 , upvalues : _ENV, SingletonSlideFrame
  local rowNum = nil
  local map = {}
  for k,v in pairs(self._allSkillNodes) do
    local posList = (string.split)(v.nodePosition, ";")
    local row = tonumber(posList[1])
    if not rowNum or rowNum < row then
      rowNum = row
    end
    local frontList = nil
    if v.frontNode ~= "-1" then
      frontList = (string.split)(v.frontNode, ";")
    end
    local frontNodeList = {}
    if frontList then
      for _,nodeId in ipairs(frontList) do
        (table.insert)(frontNodeList, tonumber(nodeId))
      end
    end
    do
      do
        local column = tonumber(posList[2])
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (self._skillNodePosData)[v.id] = {
pos = {row = row, column = column}
, frontNodeList = frontNodeList}
        if not map[row] then
          map[row] = {}
        end
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (map[row])[column] = true
        -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  if not rowNum then
    return 
  end
  local skillRowCell = (DialogManager.CreateDialog)("mainline.bossrush.bossrushweekcultivateskillcell", (self._skillNodeFrame)._uiObject)
  for i = 1, rowNum do
    local dialog = (DialogManager.CopyDialog)("mainline.bossrush.bossrushweekcultivateskillcell", (skillRowCell._rootWindow)._uiObject, (self._skillNodeFrame)._uiObject)
    ;
    (dialog:GetRootWindow()):SetAnchoredPosition(0, -((i - 1) * self._rowCellHeight))
    dialog:Init(self, i, map[i])
    ;
    (table.insert)(self._rowCellList, dialog)
  end
  skillRowCell:RootWindowDestroy()
  ;
  (self._skillFrame):SetDeltaSize(self._skillFrameWidth, self._rowCellHeight * rowNum)
  local local_maxPosY = self._initLocal_posY + self._rowCellHeight * rowNum - self._skillFrameHeight
  if self._singletonSlideFrame then
    (self._singletonSlideFrame):Destroy()
  end
  self._singletonSlideFrame = (SingletonSlideFrame.Create)(self._skillFrame, true, self._initLocal_posY, local_maxPosY)
  if (self._skillNodePosData)[self._selectNodeId] then
    local x, y, z = (self._skillFrame):GetLocalPosition()
    local posY = y + ((((self._skillNodePosData)[self._selectNodeId]).pos).row - 3) * self._rowCellHeight
    if posY < self._initLocal_posY then
      posY = self._initLocal_posY
    else
      if local_maxPosY < posY then
        posY = local_maxPosY
      end
    end
    ;
    (self._skillFrame):SetLocalPosition(x, posY, nil)
  end
end

local BuildSkillNodeLines = function(self)
  -- function num : 0_5 , upvalues : _ENV, UIManager, TransformStaticFunctions
  local skillLineCell = (DialogManager.CreateDialog)("character.characterskilllinecell", (self._lineFrame)._uiObject)
  for k,v in pairs(self._allSkillNodes) do
    local data = (self._skillNodePosData)[k]
    if #data.frontNodeList > 0 then
      for _,frontNodeId in ipairs(data.frontNodeList) do
        if (self._skillNodePosData)[frontNodeId] then
          local startLocation = ((self._skillNodePosData)[frontNodeId]).pos
          local startChild = ((((self._rowCellList)[startLocation.row])._posChilds)[startLocation.column]).panel
          local endLocation = ((self._skillNodePosData)[k]).pos
          local endChild = ((((self._rowCellList)[endLocation.row])._posChilds)[endLocation.column]).panel
          local startPos = (UIManager.InverseTransformPoint)((self._lineFrame)._uiObject, ((CS.UnityEngine).Vector3)((TransformStaticFunctions.GetPosition)(startChild._uiObject)))
          local endPos = (UIManager.InverseTransformPoint)((self._lineFrame)._uiObject, ((CS.UnityEngine).Vector3)((TransformStaticFunctions.GetPosition)(endChild._uiObject)))
          local deltaX = endPos.x - startPos.x
          local deltaY = endPos.y - startPos.y
          local len = deltaX ^ 2 + deltaY ^ 2 ^ 0.5
          local dialog = (DialogManager.CopyDialog)("character.characterskilllinecell", (skillLineCell._rootWindow)._uiObject, (self._lineFrame)._uiObject)
          ;
          (dialog._rootWindow):SetWidth(0, len)
          ;
          (dialog._rootWindow):SetZRotation(1, 0, deltaX, deltaY)
          ;
          (TransformStaticFunctions.SetLocalPosition)((dialog._rootWindow)._uiObject, (startPos.x + endPos.x) / 2, (startPos.y + endPos.y) / 2, startPos.z)
          ;
          (table.insert)(self._skillNodeLineCells, dialog)
        else
          do
            do
              LogErrorFormat("BossRushWeekCultivateDialog", "nodeid %s frontnodeid %s is not exist", k, frontNodeId)
              -- DECOMPILER ERROR at PC121: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC121: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC121: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  skillLineCell:RootWindowDestroy()
end

BossRushWeekCultivateDialog.SelectSkillNode = function(self, skillNodeId)
  -- function num : 0_6 , upvalues : _ENV
  if self._selectNodeId ~= skillNodeId then
    self._selectNodeId = skillNodeId
    for i,v in ipairs(self._rowCellList) do
      v:OnEvent("SetSelected")
    end
    self:RefreshDetailPanel()
  end
end

BossRushWeekCultivateDialog.RefreshSkillNode = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for k,v in pairs(self._allSkillNodes) do
    local data = (self._skillNodePosData)[k]
    ;
    ((self._rowCellList)[(data.pos).row]):Refresh(v)
  end
  for i,v in ipairs(self._rowCellList) do
    v:AllSkillNodesRefreshFinished()
  end
end

BossRushWeekCultivateDialog.InitRefresh = function(self)
  -- function num : 0_8 , upvalues : _ENV, BuildRowNodeData, BuildSkillNodeLines
  self._allSkillNodes = (self._bm):GetAllTalentNodes()
  self._nodeIdList = (self._bm):GetSortedNodeIdList()
  self._unlockSkillNodes = (self._bm):GetUnlockTalentNode()
  self._selectNodeId = (self._nodeIdList)[#self._nodeIdList]
  local findAgain = true
  for _,id in ipairs(self._nodeIdList) do
    if (self._bm):GetNodeStatus(id) == ((self._bm).NodeStatusType).CanBeUnlock then
      self._selectNodeId = id
      findAgain = false
      break
    end
  end
  do
    if findAgain then
      local nodeStatus = nil
      local have = false
      for _,id in ipairs(self._nodeIdList) do
        nodeStatus = (self._bm):GetNodeStatus(id)
        have = nodeStatus & ((self._bm).NodeStatusType).HasBeenUnlocked == 0 and nodeStatus & ((self._bm).NodeStatusType).ConflictedHasBeenUnlock == 0 and nodeStatus & ((self._bm).NodeStatusType).BeforeNodeLock == 0 and nodeStatus & ((self._bm).NodeStatusType).TimesNotEnough ~= 0
        if have then
          self._selectNodeId = id
          break
        end
      end
    end
    self._skillNodePosData = {}
    do
      while (self._rowCellList)[#self._rowCellList] do
        local dialog = (self._rowCellList)[#self._rowCellList]
        dialog:Destroy()
        dialog:RootWindowDestroy()
        ;
        (table.remove)(self._rowCellList, #self._rowCellList)
      end
      do
        while (self._skillNodeLineCells)[#self._skillNodeLineCells] do
          local dialog = (self._skillNodeLineCells)[#self._skillNodeLineCells]
          dialog:Destroy()
          dialog:RootWindowDestroy()
          ;
          (table.remove)(self._skillNodeLineCells, #self._skillNodeLineCells)
        end
        BuildRowNodeData(self)
        BuildSkillNodeLines(self)
        self:RefreshSkillNode()
        self:RefreshDetailPanel()
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
end

BossRushWeekCultivateDialog.RefreshDetailPanel = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not (self._allSkillNodes)[self._selectNodeId] then
    return 
  end
  local str = (TextManager.GetText)(1901581)
  str = (string.gsub)(str, "%$parameter1%$", (self._bm):GetTalentLeftNumber())
  ;
  (self._canUnlockSkillTimesTxt):SetText(str)
  str = (TextManager.GetText)(1901596)
  str = (string.gsub)(str, "%$parameter1%$", ((self._allSkillNodes)[self._selectNodeId]).unlockConsumptionTimes)
  ;
  (self._unlockTimesTxt):SetText(str)
  ;
  (self._skillEffectDetail):SetText((TextManager.GetText)(((self._allSkillNodes)[self._selectNodeId]).buffDescriptionID))
  ;
  (self._skillName):SetText((TextManager.GetText)(((self._allSkillNodes)[self._selectNodeId]).buffNameID))
  ;
  (self._rightSkillDialog):SetData(self._selectNodeId, (self._allSkillNodes)[self._selectNodeId])
  local nodeStatus = (self._bm):GetNodeStatus(self._selectNodeId)
  ;
  (self._unlockBtn):SetActive(false)
  ;
  (self._unlockBtn):SetInteractable(false)
  ;
  (self._beforeLockCannotUnlockPanel):SetActive(false)
  ;
  (self._unlockPanel):SetActive(false)
  -- DECOMPILER ERROR at PC110: Unhandled construct in 'MakeBoolean' P1

  if nodeStatus & ((self._bm).NodeStatusType).HasBeenUnlocked == 0 and nodeStatus & ((self._bm).NodeStatusType).ConflictedHasBeenUnlock == 0 then
    if nodeStatus & ((self._bm).NodeStatusType).BeforeNodeLock == 0 then
      (self._unlockBtn):SetActive(true)
      if nodeStatus & ((self._bm).NodeStatusType).TimesNotEnough == 0 and nodeStatus == ((self._bm).NodeStatusType).CanBeUnlock then
        (self._unlockBtn):SetInteractable(true)
      end
    else
      ;
      (self._beforeLockCannotUnlockPanel):SetActive(true)
    end
  end
  ;
  (self._unlockPanel):SetActive(true)
end

BossRushWeekCultivateDialog.OnUnlockBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not (self._allSkillNodes)[self._selectNodeId] then
    return 
  end
  if ((self._allSkillNodes)[self._selectNodeId]).conflictedNode == 0 then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(139, {}, function()
    -- function num : 0_10_0 , upvalues : self
    self:SendProtocolImproveTalent(self._selectNodeId)
  end
, {}, nil, {})
  else
    if not (self._unlockSkillNodes)[((self._allSkillNodes)[self._selectNodeId]).conflictedNode] then
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(140, {}, function()
    -- function num : 0_10_1 , upvalues : self
    self:SendProtocolImproveTalent(self._selectNodeId)
  end
, {}, nil, {})
    else
      LogErrorFormat("BossRushWeekCultivateDialog", "conflictedNode has unlock. should not unlock this nodeid %s", self._selectNodeId)
    end
  end
end

BossRushWeekCultivateDialog.SendProtocolImproveTalent = function(self, nodeId)
  -- function num : 0_11 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.cimprovetalent")
  protocol.unlockNode = nodeId
  protocol:Send()
end

BossRushWeekCultivateDialog.OnSWeekBossTalent = function(self)
  -- function num : 0_12
  self:InitRefresh()
end

BossRushWeekCultivateDialog.OnSImproveTalent = function(self, notification)
  -- function num : 0_13
  self._unlockSkillNodes = (self._bm):GetUnlockTalentNode()
  self:RefreshSkillNode()
  self:RefreshDetailPanel()
end

BossRushWeekCultivateDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

BossRushWeekCultivateDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return BossRushWeekCultivateDialog

