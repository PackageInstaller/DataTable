local Item = require("logic.manager.experimental.types.item")
local SkillItemCell = class("SkillItemCell", Dialog)
SkillItemCell.AssetBundleName = "ui/layouts.basecharacterinfo"
SkillItemCell.AssetName = "SkillItemCell"

function SkillItemCell:Ctor(...)
  SkillItemCell.super.Ctor(self, ...)
end

function SkillItemCell:OnCreate()
  self._showFrame = self:GetChild("_BackGround/Frame")
  self._img = self:GetChild("_BackGround/Icon")
  self._numTxt = self:GetChild("_Count/Num")
  self._numRedTxt = self:GetChild("_Count/NumRed")
  self._needNumTxt = self:GetChild("_Count/Max")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function SkillItemCell:OnDestroy()
end

function SkillItemCell:RefreshCell(data)
  local itemId = tonumber(data.itemId)
  self._itemId = itemId
  local itemNum = tonumber(data.itemNum)
  local item = Item.Create(itemId)
  local imageRecord = item:GetIcon()
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._showFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local haveNum
  if string.sub(itemId, 1, 2) == "35" then
    haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(itemId)
  else
    haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(itemId)
  end
  self._needNumTxt:SetText(NumberManager.GetShowNumber(itemNum))
  if itemNum <= haveNum then
    self._numTxt:SetText(NumberManager.GetShowNumber(haveNum))
    self._numTxt:SetActive(true)
    self._numRedTxt:SetActive(false)
  else
    self._numRedTxt:SetText(NumberManager.GetShowNumber(haveNum))
    self._numTxt:SetActive(false)
    self._numRedTxt:SetActive(true)
  end
end

function SkillItemCell:OnCellClick(args)
  local width, height = self:GetRootWindow():GetRectSize()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = Item.Create(self._itemId)
    })
    dialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return SkillItemCell
