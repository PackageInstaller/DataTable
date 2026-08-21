-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/handbookworldnode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HandBookNode = require("logic.dialog.handbook.handbooknode")
local HandBookWorldNode = class("HandBookWorldNode", HandBookNode)
local CWorldHandBookCfg = (BeanManager.GetTableByName)("handbook.cworldconfig_handbook")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
HandBookWorldNode.AssetBundleName = "ui/layouts.tujian"
HandBookWorldNode.AssetName = "BookRelationWorldCell"
HandBookWorldNode.Ctor = function(self, parent, parentNode, nodecfg)
  -- function num : 0_0 , upvalues : HandBookWorldNode
  ((HandBookWorldNode.super).Ctor)(self, parent, parentNode, nodecfg)
  self:Init(nodecfg)
end

HandBookWorldNode.Init = function(self, nodecfg)
  -- function num : 0_1 , upvalues : _ENV, HandBookTypeEnum, CWorldHandBookCfg, CImagePathTable
  self._handBookId = nodecfg.handbookId
  self._nodeNormal = self:GetChild("Normal")
  self._nodeIcon = self:GetChild("Normal/World")
  self._nodeName = self:GetChild("Normal/Txt")
  self._nodeLock = self:GetChild("Lock")
  if ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(nodecfg.handbookId, HandBookTypeEnum.WORLD) then
    local worldBookCfg = CWorldHandBookCfg:GetRecorder(nodecfg.handbookId)
    if not CImagePathTable:GetRecorder(worldBookCfg.icon) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._nodeIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._nodeName):SetText((TextManager.GetText)(worldBookCfg.worldNameTextID))
    ;
    (self._nodeNormal):SetActive(true)
    ;
    (self._nodeLock):SetActive(false)
  else
    do
      ;
      (self._nodeNormal):SetActive(false)
      ;
      (self._nodeLock):SetActive(true)
    end
  end
end

return HandBookWorldNode

