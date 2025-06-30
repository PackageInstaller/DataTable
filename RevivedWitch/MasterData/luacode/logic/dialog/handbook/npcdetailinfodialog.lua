-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/npcdetailinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CNPCConfig_Handbook = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local NpcDetailInfoDialog = class("NpcDetailInfoDialog", Dialog)
NpcDetailInfoDialog.AssetBundleName = "ui/layouts.tujian"
NpcDetailInfoDialog.AssetName = "CharBookMain"
NpcDetailInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcDetailInfoDialog
  ((NpcDetailInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._initialized = false
  self._npcList = {}
  self._pos = 0
end

NpcDetailInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CStringRes, TabFrame
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._name = self:GetChild("BackGround/UI/CharName/Back/Name")
  self._rank = self:GetChild("BackGround/UI/CharName/Rank")
  self._viewBtn = self:GetChild("BackGround/UI/ViewBtn")
  self._jobImg = self:GetChild("BackGround/UI/CharName/JobImg")
  self._jobTxt = self:GetChild("BackGround/UI/CharName/JobTxt")
  self._charTitle = self:GetChild("BackGround/UI/CharName/CharTitle")
  ;
  (self._charTitle):SetActive(false)
  self._groupBtnInfoArea = self:GetChild("BackGround/GroupBtnArea")
  ;
  (self._groupBtnInfoArea):SetActive(false)
  self._groupBtnInfo = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtnInfo)[i] = {}
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._groupBtnInfo)[i]).btn = self:GetChild("BackGround/GroupBtnArea/Btn" .. i .. "/GroupBtn")
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._groupBtnInfo)[i]).title = self:GetChild("Top/Title" .. i)
      ;
      (((self._groupBtnInfo)[i]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupClick(i)
  end
)
    end
  end
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._groupBtnInfo)[3]).title = self:GetChild("Top/Title1")
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._groupBtnInfo)[2]).title = self:GetChild("Top/Title3")
  -- DECOMPILER ERROR at PC99: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._groupBtnInfo)[1]).title = self:GetChild("Top/Title2")
  ;
  (((self._groupBtnInfo)[1]).title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1290)).msgTextID))
  ;
  (((self._groupBtnInfo)[2]).title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1291)).msgTextID))
  ;
  (((self._groupBtnInfo)[3]).title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1289)).msgTextID))
  ;
  (self._rank):SetActive(false)
  ;
  (self._jobImg):SetActive(false)
  ;
  (self._jobTxt):SetActive(false)
  ;
  (((self._groupBtnInfo)[2]).btn):SetActive(false)
  ;
  (((self._groupBtnInfo)[2]).title):SetActive(false)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._panelWnd = self:GetChild("BackGround/RightPanel")
  self._pageHelper = (TabFrame.Create)(self._panelWnd, self)
  ;
  (self._viewBtn):Subscribe_PointerClickEvent(self.OnViewBtnClick, self)
  self._roleEvaluationBtn = self:GetChild("BackGround/UI/AppraiseBtn")
  ;
  (self._roleEvaluationBtn):Subscribe_PointerClickEvent(self.OnRoleEvaluationBtnClicked, self)
  ;
  (self._roleEvaluationBtn):SetActive(false)
  self._leftArrow = self:GetChild("BackGround/UI/LeftArrow")
  self._rightArrow = self:GetChild("BackGround/UI/RightArrow")
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._cutoverbtnPanel = self:GetChild("BackGround/CutoverBtn")
  self._cutoverbtnPanel_groupBtn = self:GetChild("BackGround/CutoverBtn/GroupBtn")
  ;
  (self._cutoverbtnPanel_groupBtn):SetSelected(false)
  self._cutoverbtnPanel_redDot = self:GetChild("BackGround/CutoverBtn/GroupBtn/RedDot")
  ;
  (self._cutoverbtnPanel_groupBtn):Subscribe_PointerClickEvent(self.OnCutoverBtnClick, self)
end

NpcDetailInfoDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._pageHelper):Destroy()
end

NpcDetailInfoDialog.Init = function(self, npcid)
  -- function num : 0_3 , upvalues : _ENV, CNPCConfig_Handbook, HandBookTypeEnum
  for _,v in ipairs(CNPCConfig_Handbook:GetAllIds()) do
    local record = CNPCConfig_Handbook:GetRecorder(v)
    if record.isShow == 1 and ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(record.id, HandBookTypeEnum.NPC) then
      (table.insert)(self._npcList, record.id)
      if record.id == npcid then
        self._pos = #self._npcList
      end
    end
  end
  if #self._npcList == 1 then
    (self._leftArrow):SeActive(false)
    ;
    (self._rightArrow):SeActive(false)
  end
  self._initialized = true
end

NpcDetailInfoDialog.Refresh = function(self, npcid, roleid)
  -- function num : 0_4 , upvalues : CNPCConfig_Handbook, CNpcShapeTable, _ENV, CImagePathTable
  if not self._initialized then
    self:Init(npcid)
  end
  self._npcId = npcid
  local npcfg = CNPCConfig_Handbook:GetRecorder(npcid)
  local shapeRecord = CNpcShapeTable:GetRecorder(npcfg.shapeID)
  ;
  (self._name):SetText((TextManager.GetText)(npcfg.NPCNameTextID))
  ;
  (self._rolePanel):SetAnimatorTrigger("loadReady")
  if self._handler then
    (self._live2D):Release(self._handler)
    self._handler = nil
  end
  if (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    (self._photo):SetActive(false)
    self._handler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
      local lihuiImage = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetActive(true)
    ;
    (self._photo):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    ;
    (self._photo):SetLocalScale(scale, scale, scale)
    ;
    (self._photo):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
  end
  do
    ;
    (self._pageHelper):ToPage(3)
    ;
    (self._cutoverbtnPanel):SetActive(roleid)
    ;
    (self._cutoverbtnPanel):SetActive(roleid ~= nil)
    self._roleId = roleid
    ;
    (self._cutoverbtnPanel_redDot):SetActive(false)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

NpcDetailInfoDialog.OnGroupClick = function(self, index)
  -- function num : 0_5
  (self._pageHelper):ToPage(index)
end

NpcDetailInfoDialog.DidToPage = function(self, helper, index)
  -- function num : 0_6
  local dlg = (self._pageHelper):GetCellAtIndex(index)
  if dlg.Refresh then
    dlg:Refresh(self._npcId)
  end
  for i = 1, 3 do
    (((self._groupBtnInfo)[i]).btn):SetSelected(index == i)
    ;
    (((self._groupBtnInfo)[i]).title):SetActive(index == i)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

NpcDetailInfoDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_7
  if index == 1 then
    return "handbook.npcarchivepart"
  else
    if index == 3 then
      return "handbook.npcstorypart"
    end
  end
end

NpcDetailInfoDialog.OnViewBtnClick = function(self, ...)
  -- function num : 0_8
  (self:GetRootWindow()):SetAnimatorInteger("state", 1)
  self._fullShow = true
end

NpcDetailInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  if self._fullShow then
    (self:GetRootWindow()):SetAnimatorInteger("state", 2)
    self._fullShow = false
    return 
  end
  self:Destroy()
end

NpcDetailInfoDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

NpcDetailInfoDialog.OnRoleEvaluationBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.card.cgetcomments")
  if protocol then
    protocol.roleId = self._npcId
    protocol.commentType = 1
    protocol.lastIndex = 0
    protocol:Send()
  end
end

NpcDetailInfoDialog.OnLeftArrowClick = function(self)
  -- function num : 0_12 , upvalues : CNPCConfig_Handbook, _ENV
  if self._pos == 1 then
    self._pos = #self._npcList
  else
    self._pos = self._pos - 1
  end
  local npcID = (self._npcList)[self._pos]
  local roleID = (CNPCConfig_Handbook:GetRecorder(npcID)).roleID
  if roleID == -1 or ((NekoData.BehaviorManager).BM_HandBook):IsLockedRole(roleID) or not ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(roleID) then
    roleID = nil
  end
  self:Refresh(npcID, roleID)
  ;
  ((self._pageHelper):GetCellAtIndex(3)):Refresh(npcID)
end

NpcDetailInfoDialog.OnRightArrowClick = function(self)
  -- function num : 0_13 , upvalues : CNPCConfig_Handbook, _ENV
  if self._pos == #self._npcList then
    self._pos = 1
  else
    self._pos = self._pos + 1
  end
  local npcID = (self._npcList)[self._pos]
  local roleID = (CNPCConfig_Handbook:GetRecorder(npcID)).roleID
  if roleID == -1 or ((NekoData.BehaviorManager).BM_HandBook):IsLockedRole(roleID) or not ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(roleID) then
    roleID = nil
  end
  self:Refresh(npcID, roleID)
  ;
  ((self._pageHelper):GetCellAtIndex(3)):Refresh(npcID)
end

NpcDetailInfoDialog.OnCutoverBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("handbook.handbooksceneroledetailinfodialog")):Refresh(self._roleId, self._npcId)
  self:Destroy()
end

return NpcDetailInfoDialog

