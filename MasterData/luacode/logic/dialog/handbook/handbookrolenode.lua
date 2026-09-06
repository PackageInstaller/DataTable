local HandBookNode = require("logic.dialog.handbook.handbooknode")
local HandBookRoleNode = class("HandBookRoleNode", HandBookNode)
local CNpcHandBookCfg = BeanManager.GetTableByName("handbook.cnpcconfig_handbook")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
HandBookRoleNode.AssetBundleName = "ui/layouts.tujian"
HandBookRoleNode.AssetName = "BookRelationCharCell"

function HandBookRoleNode:Ctor(parent, parentNode, nodecfg)
  HandBookRoleNode.super.Ctor(self, parent, parentNode, nodecfg)
  self:Init(nodecfg)
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self._nodeWindow:GetPosition()
  LuaNotificationCenter.AddObserver(self, self.RefreshRedData, Common.n_RefreshRoleFavorAwardStatus, nil)
end

function HandBookRoleNode:SetDelegate(delegate)
  self._delegate = delegate
end

function HandBookRoleNode:Destroy(...)
  LuaNotificationCenter.RemoveObserver(self)
  HandBookRoleNode.super.Destroy(self)
end

function HandBookRoleNode:Init(nodecfg)
  self._nodeCfg = nodecfg
  self._nodeType = nodecfg.nodeType
  self._handBookId = nodecfg.handbookId
  self._nodeNormal = self:GetChild("Normal")
  self._nodeIcon = self:GetChild("Normal/Char")
  self._nodeName = self:GetChild("Normal/Txt")
  self._nodeLock = self:GetChild("Lock")
  self._redIcon = self:GetChild("RedDot")
  if self._nodeType == 1 then
    if nodecfg.handbookId == 1 or NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(nodecfg.handbookId) then
      local roleConfigRecord = RoleConfigTable:GetRecorder(nodecfg.handbookId)
      local shapeRecord = CNpcShapeTable:GetRecorder(roleConfigRecord.shapeID)
      local imageRecord = CImagePathTable:GetRecorder(shapeRecord.headID) or DataCommon.DefaultImageAsset
      self._nodeIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if nodecfg.handbookId == 1 then
        self._nodeName:SetText(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)
      else
        self._nodeName:SetText(TextManager.GetText(roleConfigRecord.nameTextID))
      end
      self._nodeNormal:SetActive(true)
      self._nodeLock:SetActive(false)
      self._redIcon:SetActive(NekoData.BehaviorManager.BM_HandBook:IsCanDrawRoleFavorAward(nodecfg.handbookId))
    else
      self._nodeNormal:SetActive(false)
      self._nodeLock:SetActive(true)
      self._redIcon:SetActive(false)
    end
  elseif self._nodeType == 2 then
    if NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(nodecfg.handbookId, HandBookTypeEnum.NPC) then
      local npcfg = CNpcHandBookCfg:GetRecorder(nodecfg.handbookId)
      local shapeRecord = CNpcShapeTable:GetRecorder(npcfg.shapeID)
      local imageRecord = CImagePathTable:GetRecorder(shapeRecord.headID) or DataCommon.DefaultImageAsset
      self._nodeIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._nodeName:SetText(TextManager.GetText(npcfg.NPCNameTextID))
      self._nodeNormal:SetActive(true)
      self._nodeLock:SetActive(false)
    else
      self._nodeNormal:SetActive(false)
      self._nodeLock:SetActive(true)
    end
    self._redIcon:SetActive(false)
  end
  self._nodeNormal:Subscribe_PointerClickEvent(self.OnIconClicked, self)
end

function HandBookRoleNode:OnIconClicked()
  if not self._delegate:IsPlayMovingAni() then
    self._delegate:RefreshPosBySelectNode(self._pos_offset_x, self._pos_offset_y, self._nodeCfg)
  end
end

function HandBookRoleNode:RefreshRedData(notification)
  if self._nodeCfg.handbookId == notification.userInfo.id then
    self._redIcon:SetActive(notification.userInfo.canDrawAward)
  end
end

return HandBookRoleNode
