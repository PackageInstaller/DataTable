-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/skill/skillitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local SkillItemCell = class("SkillItemCell", Dialog)
SkillItemCell.AssetBundleName = "ui/layouts.basecharacterinfo"
SkillItemCell.AssetName = "SkillItemCell"
SkillItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillItemCell
  ((SkillItemCell.super).Ctor)(self, ...)
end

SkillItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._showFrame = self:GetChild("_BackGround/Frame")
  self._img = self:GetChild("_BackGround/Icon")
  self._numTxt = self:GetChild("_Count/Num")
  self._numRedTxt = self:GetChild("_Count/NumRed")
  self._needNumTxt = self:GetChild("_Count/Max")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SkillItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

SkillItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item
  local itemId = tonumber(data.itemId)
  self._itemId = itemId
  local itemNum = tonumber(data.itemNum)
  local item = (Item.Create)(itemId)
  local imageRecord = item:GetIcon()
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._showFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local haveNum = nil
  if (string.sub)(itemId, 1, 2) == "35" then
    haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(itemId)
  else
    haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(itemId)
  end
  ;
  (self._needNumTxt):SetText((NumberManager.GetShowNumber)(itemNum))
  if itemNum <= haveNum then
    (self._numTxt):SetText((NumberManager.GetShowNumber)(haveNum))
    ;
    (self._numTxt):SetActive(true)
    ;
    (self._numRedTxt):SetActive(false)
  else
    ;
    (self._numRedTxt):SetText((NumberManager.GetShowNumber)(haveNum))
    ;
    (self._numTxt):SetActive(false)
    ;
    (self._numRedTxt):SetActive(true)
  end
end

SkillItemCell.OnCellClick = function(self, args)
  -- function num : 0_4 , upvalues : _ENV, Item
  local width, height = (self:GetRootWindow()):GetRectSize()
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = (Item.Create)(self._itemId)})
    dialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return SkillItemCell

