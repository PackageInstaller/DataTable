-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/agcoinaccesstaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskCfg = (BeanManager.GetTableByName)("mission.ccoinmissionconfig")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local AgCoinAccessTaskCell = class("AgCoinAccessTaskCell", Dialog)
AgCoinAccessTaskCell.AssetBundleName = "ui/layouts.baseshop"
AgCoinAccessTaskCell.AssetName = "CoinGetCell"
AgCoinAccessTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AgCoinAccessTaskCell
  ((AgCoinAccessTaskCell.super).Ctor)(self, ...)
end

AgCoinAccessTaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._taskName = self:GetChild("Txt")
  self._taskCurValue = self:GetChild("Txt1")
  self._taskDestValue = self:GetChild("Txt3")
  self._coinIcon = self:GetChild("Image")
  self._coinNum = self:GetChild("Num")
end

AgCoinAccessTaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

AgCoinAccessTaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : TaskCfg, _ENV, CItemAttrTable, CImagePathTable
  local cfg = TaskCfg:GetRecorder(data.taskid)
  ;
  (self._taskName):SetText((TextManager.GetText)(cfg.missionnameTextID))
  ;
  (self._taskCurValue):SetText(data.curValue)
  ;
  (self._taskDestValue):SetText(data.destValue)
  local itemcfg = CItemAttrTable:GetRecorder(cfg.itemid)
  if not CImagePathTable:GetRecorder(itemcfg.icon) then
    local iconinfo = DataCommon.DefaultImageAsset
  end
  ;
  (self._coinIcon):SetSprite(iconinfo.assetBundle, iconinfo.assetName)
  ;
  (self._coinNum):SetText(cfg.itemnum)
end

return AgCoinAccessTaskCell

