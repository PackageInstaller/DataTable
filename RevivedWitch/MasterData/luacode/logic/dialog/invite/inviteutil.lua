-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/invite/inviteutil.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local util = {}
util.SetItemInfo = function(obj, itemdata)
  -- function num : 0_0 , upvalues : _ENV
  local itemFrame = obj:FindChild("_BackGround/Frame")
  local itemIcon = obj:FindChild("_BackGround/Icon")
  local itemNum = obj:FindChild("_Count")
  local item = itemdata.item
  local image = item:GetPinJiImage()
  itemFrame:SetSprite(image.assetBundle, image.assetName)
  image = item:GetIcon()
  itemIcon:SetSprite(image.assetBundle, image.assetName)
  itemNum:SetText((NumberManager.GetShowNumber)(itemdata.num))
end

return util

