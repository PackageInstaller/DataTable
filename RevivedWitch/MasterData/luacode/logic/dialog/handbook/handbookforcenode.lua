-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/handbookforcenode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HandBookNode = require("logic.dialog.handbook.handbooknode")
local HandBookForceNode = class("HandBookForceNode", HandBookNode)
local CForceHandBookCfg = (BeanManager.GetTableByName)("handbook.caffiliation_handbook")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
HandBookForceNode.AssetBundleName = "ui/layouts.tujian"
HandBookForceNode.AssetName = "BookRelationForceCell"
HandBookForceNode.Ctor = function(self, parent, parentNode, nodecfg)
  -- function num : 0_0 , upvalues : HandBookForceNode
  ((HandBookForceNode.super).Ctor)(self, parent, parentNode, nodecfg)
  self:Init(nodecfg)
end

HandBookForceNode.Init = function(self, nodecfg)
  -- function num : 0_1 , upvalues : _ENV, HandBookTypeEnum, CForceHandBookCfg, CImagePathTable
  self._handBookId = nodecfg.handbookId
  self._nodeNormal = self:GetChild("Normal")
  self._nodeIcon = self:GetChild("Normal/Force")
  self._nodeName = self:GetChild("Normal/Txt")
  self._nodeLock = self:GetChild("Lock")
  if ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(nodecfg.handbookId, HandBookTypeEnum.FORCE) then
    local forceBookCfg = CForceHandBookCfg:GetRecorder(nodecfg.handbookId)
    if not CImagePathTable:GetRecorder(forceBookCfg.icon) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._nodeIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._nodeName):SetText(nodecfg.id .. " " .. (TextManager.GetText)(forceBookCfg.nameTextID))
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

return HandBookForceNode

