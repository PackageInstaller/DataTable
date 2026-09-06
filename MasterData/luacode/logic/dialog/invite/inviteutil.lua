local util = {}

function util.SetItemInfo(obj, itemdata)
  local itemFrame = obj:FindChild("_BackGround/Frame")
  local itemIcon = obj:FindChild("_BackGround/Icon")
  local itemNum = obj:FindChild("_Count")
  local item = itemdata.item
  local image = item:GetPinJiImage()
  itemFrame:SetSprite(image.assetBundle, image.assetName)
  image = item:GetIcon()
  itemIcon:SetSprite(image.assetBundle, image.assetName)
  itemNum:SetText(NumberManager.GetShowNumber(itemdata.num))
end

return util
