-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/survey/surveyitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local SurveyItemCell = class("SurveyItemCell", Dialog)
SurveyItemCell.AssetBundleName = "ui/layouts.survey"
SurveyItemCell.AssetName = "SurveyItemCell"
SurveyItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SurveyItemCell
  ((SurveyItemCell.super).Ctor)(self, ...)
end

SurveyItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._Select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._Select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

SurveyItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

SurveyItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if not data.item then
    (self._icon):SetSprite((DataCommon.NullImageAsset).assetBundle, (DataCommon.NullImageAsset).assetName)
    ;
    (self._count):SetText("")
    return 
  end
  local imageRecord = (data.item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    (self._count):SetNumber(data.num)
  else
    ;
    (self._count):SetNumber((data.item):GetCount())
  end
end

SurveyItemCell.OnCellClicked = function(self, args, luawindow)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  if not (self._cellData).item then
    return 
  end
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if ((self._cellData).item):GetItemType() == ItemTypeEnum.EQUIP then
    if ((self._cellData).item):IsGained() then
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:RefreshInfo((self._cellData).item)
        tipsDialog:HideBtn()
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    else
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init(((self._cellData).item):GetID())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_1 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    end
  else
    tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData, true)
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

return SurveyItemCell

