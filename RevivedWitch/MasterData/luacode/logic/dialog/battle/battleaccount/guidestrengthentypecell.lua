-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/guidestrengthentypecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local GuideStrengthenTypeCell = class("GuideStrengthenTypeCell", Dialog)
GuideStrengthenTypeCell.AssetBundleName = "ui/layouts.battlelose"
GuideStrengthenTypeCell.AssetName = "DefeatGuideWayCell"
GuideStrengthenTypeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuideStrengthenTypeCell
  ((GuideStrengthenTypeCell.super).Ctor)(self, ...)
end

GuideStrengthenTypeCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon_normal = self:GetChild("Image")
  self._txt_normal = self:GetChild("Txt")
  self._icon_select = self:GetChild("Select")
  self._txt_select = self:GetChild("TxtSelect")
  self._recommend = self:GetChild("recommend")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

GuideStrengthenTypeCell.OnDestroy = function(self)
  -- function num : 0_2
end

local Select = function(self, select)
  -- function num : 0_3
  (self._icon_normal):SetActive(not select)
  ;
  (self._txt_normal):SetActive(not select)
  ;
  (self._icon_select):SetActive(select)
  ;
  (self._txt_select):SetActive(select)
end

GuideStrengthenTypeCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : CImagePathTable, _ENV, Select
  local iconId_normal, txtId_normal, iconId_select, txtId_select = nil, nil, nil, nil
  if data.tag == "RoleLevelUp" then
    iconId_normal = 12610
    iconId_select = 12611
    txtId_normal = 701092
    txtId_select = 701089
  else
    if data.tag == "RoleStrengthenEquip" then
      iconId_normal = 12608
      iconId_select = 12609
      txtId_normal = 701094
      txtId_select = 701091
    else
      if data.tag == "ImproveSkill" then
        iconId_normal = 12612
        iconId_select = 12613
        txtId_normal = 701093
        txtId_select = 701090
      end
    end
  end
  if not CImagePathTable:GetRecorder(iconId_normal) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon_normal):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if not CImagePathTable:GetRecorder(iconId_select) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon_select):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._txt_normal):SetText((TextManager.GetText)(txtId_normal))
  ;
  (self._txt_select):SetText((TextManager.GetText)(txtId_select))
  if (self._delegate)._selectGuideType and data.tag == ((self._delegate)._selectGuideType).tag then
    Select(self, true)
  else
    Select(self, false)
  end
  if (self._delegate)._recommendTag and data.tag == (self._delegate)._recommendTag then
    (self._recommend):SetActive(true)
  else
    ;
    (self._recommend):SetActive(false)
  end
end

GuideStrengthenTypeCell.OnCellClick = function(self)
  -- function num : 0_5
  (self._delegate):SetSelect(self._cellData)
end

GuideStrengthenTypeCell.OnEvent = function(self)
  -- function num : 0_6 , upvalues : Select
  if (self._delegate)._selectGuideType and (self._cellData).tag == ((self._delegate)._selectGuideType).tag then
    Select(self, true)
  else
    Select(self, false)
  end
end

return GuideStrengthenTypeCell

