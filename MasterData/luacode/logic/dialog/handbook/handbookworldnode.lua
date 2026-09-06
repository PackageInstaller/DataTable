local HandBookNode = require("logic.dialog.handbook.handbooknode")
local HandBookWorldNode = class("HandBookWorldNode", HandBookNode)
local CWorldHandBookCfg = BeanManager.GetTableByName("handbook.cworldconfig_handbook")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HandBookTypeEnum = LuaNetManager.GetBeanDef("protocol.user.handbooktype")
HandBookWorldNode.AssetBundleName = "ui/layouts.tujian"
HandBookWorldNode.AssetName = "BookRelationWorldCell"

function HandBookWorldNode:Ctor(parent, parentNode, nodecfg)
  HandBookWorldNode.super.Ctor(self, parent, parentNode, nodecfg)
  self:Init(nodecfg)
end

function HandBookWorldNode:Init(nodecfg)
  self._handBookId = nodecfg.handbookId
  self._nodeNormal = self:GetChild("Normal")
  self._nodeIcon = self:GetChild("Normal/World")
  self._nodeName = self:GetChild("Normal/Txt")
  self._nodeLock = self:GetChild("Lock")
  if NekoData.BehaviorManager.BM_HandBook:IsBookUnLock(nodecfg.handbookId, HandBookTypeEnum.WORLD) then
    local worldBookCfg = CWorldHandBookCfg:GetRecorder(nodecfg.handbookId)
    local imageRecord = CImagePathTable:GetRecorder(worldBookCfg.icon) or DataCommon.DefaultImageAsset
    self._nodeIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._nodeName:SetText(TextManager.GetText(worldBookCfg.worldNameTextID))
    self._nodeNormal:SetActive(true)
    self._nodeLock:SetActive(false)
  else
    self._nodeNormal:SetActive(false)
    self._nodeLock:SetActive(true)
  end
end

return HandBookWorldNode
