local Item = require("logic.manager.experimental.types.item")
local ReturnBattlePassUnlockItemCell = class("ReturnBattlePassUnlockItemCell", Dialog)
ReturnBattlePassUnlockItemCell.AssetBundleName = "ui/layouts.welfare"
ReturnBattlePassUnlockItemCell.AssetName = "ReturnBattlePassBuyItemCell"

function ReturnBattlePassUnlockItemCell:Ctor(...)
  ReturnBattlePassUnlockItemCell.super.Ctor(self, ...)
end

function ReturnBattlePassUnlockItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._select:SetActive(false)
  self._icon:Subscribe_PointerClickEvent(self.ItemClick, self)
end

function ReturnBattlePassUnlockItemCell:OnDestroy()
end

function ReturnBattlePassUnlockItemCell:ItemClick()
  if self._data:GetID() == DataCommon.ReturnBattlePass_RoleSelectItemId then
    DialogManager.CreateSingletonDialog("welfare.returnwelfare.roleopstiondialog"):SetData({option = 0}, false)
  else
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      local d = self._data
      tipsDialog:Init({
        item = Item.Create(d:GetID())
      })
      local width, height = self._icon:GetRectSize()
      tipsDialog:SetTipsPosition(width, height, self._icon:GetLocalPointInUiRootPanel())
    end
  end
end

function ReturnBattlePassUnlockItemCell:RefreshCell(data)
  self._data = data
  local imageRecord = data:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetNumber(data:GetCount())
end

return ReturnBattlePassUnlockItemCell
