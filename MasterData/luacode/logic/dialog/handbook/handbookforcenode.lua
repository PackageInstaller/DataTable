local HandBookNode = require("logic.dialog.handbook.handbooknode")
local HandBookForceNode = class("HandBookForceNode", HandBookNode)
local CForceHandBookCfg = BeanManager.GetTableByName("handbook.caffiliation_handbook")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
HandBookForceNode.AssetBundleName = "ui/layouts.tujian"
HandBookForceNode.AssetName = "BookRelationForceCell"

function HandBookForceNode:Ctor(parent, parentNode, nodecfg)
  HandBookForceNode.super.Ctor(self, parent, parentNode, nodecfg)
  self:Init(nodecfg)
end

function HandBookForceNode:Init(nodecfg)
  self._handBookId = nodecfg.handbookId
  self._nodeNormal = self:GetChild("Normal")
  self._nodeIcon = self:GetChild("Normal/Force")
  self._nodeName = self:GetChild("Normal/Txt")
  self._nodeLock = self:GetChild("Lock")
  if NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(nodecfg.handbookId, HandBookTypeEnum.FORCE) then
    local forceBookCfg = CForceHandBookCfg:GetRecorder(nodecfg.handbookId)
    local imageRecord = CImagePathTable:GetRecorder(forceBookCfg.icon) or DataCommon.DefaultImageAsset
    self._nodeIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._nodeName:SetText(nodecfg.id .. " " .. TextManager.GetText(forceBookCfg.nameTextID))
    self._nodeNormal:SetActive(true)
    self._nodeLock:SetActive(false)
  else
    self._nodeNormal:SetActive(false)
    self._nodeLock:SetActive(true)
  end
end

return HandBookForceNode
