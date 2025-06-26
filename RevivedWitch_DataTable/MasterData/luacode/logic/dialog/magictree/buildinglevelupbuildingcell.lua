-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/buildinglevelupbuildingcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CTreeLvUp = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local BuildingLevelUpBuildingCell = class("BuildingLevelUpBuildingCell", Dialog)
BuildingLevelUpBuildingCell.AssetBundleName = "ui/layouts.yard"
BuildingLevelUpBuildingCell.AssetName = "MagicTreeLevelUpCell1"
BuildingLevelUpBuildingCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuildingLevelUpBuildingCell
  ((BuildingLevelUpBuildingCell.super).Ctor)(self, ...)
end

BuildingLevelUpBuildingCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._icon = self:GetChild("Image")
  self._lv = self:GetChild("LVNum")
  self._tips = self:GetChild("TipsFrame")
  ;
  (self._tips):SetActive(false)
end

BuildingLevelUpBuildingCell.OnDestroy = function(self)
  -- function num : 0_2
end

BuildingLevelUpBuildingCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCourtyardNameCfg, _ENV, CImagePathTable, CTreeLvUp, CStringres
  local courtYardRecord = CCourtyardNameCfg:GetRecorder(data.id)
  ;
  (self._title):SetText((TextManager.GetText)(courtYardRecord.nameTextID))
  local imageRecord = nil
  if data.id == DataCommon.MagicTree then
    if not CImagePathTable:GetRecorder((CTreeLvUp:GetRecorder(data.cdtLv)).image) then
      imageRecord = DataCommon.DefaultImageAsset
      if not CImagePathTable:GetRecorder(courtYardRecord.yardconstructionicon) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local str = ""
      if data.cdtLv <= data.curLv then
        self._enough = true
        str = (TextManager.GetText)((CStringres:GetRecorder(1306)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", data.curLv)
      else
        self._enough = false
        str = (TextManager.GetText)((CStringres:GetRecorder(1307)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", data.curLv)
      end
      str = (string.gsub)(str, "%$parameter2%$", data.cdtLv)
      ;
      (self._lv):SetText(str)
    end
  end
end

BuildingLevelUpBuildingCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4
  if eventName == "ShowTips" then
    (self._tips):SetActive(not self._enough)
  end
end

return BuildingLevelUpBuildingCell

