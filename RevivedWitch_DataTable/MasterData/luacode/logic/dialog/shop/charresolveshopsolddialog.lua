-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/charresolveshopsolddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CharResolveShopSoldDialig = class("CharResolveShopSoldDialig", Dialog)
CharResolveShopSoldDialig.AssetBundleName = "ui/layouts.baseshop"
CharResolveShopSoldDialig.AssetName = "CharResolveShopSold"
CharResolveShopSoldDialig.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharResolveShopSoldDialig
  ((CharResolveShopSoldDialig.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

CharResolveShopSoldDialig.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._goldFlowerNum = self:GetChild("Panel/Flower1/Text")
  self._goldFlowerAddNum = self:GetChild("Panel/Flower1/Add")
  self._whiteFlowerNum = self:GetChild("Panel/Flower2/Text")
  self._whiteFlowerAddNum = self:GetChild("Panel/Flower2/Add")
  self._cancelBtn = self:GetChild("Panel/CancelButton")
  self._confirmBtn = self:GetChild("Panel/ConfirmButton")
  self._area = self:GetChild("Panel/Frame")
  self._frame = (GridFrame.Create)(self._area, self, true, 5, true)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

CharResolveShopSoldDialig.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

CharResolveShopSoldDialig.SetData = function(self, roleList, whitenum, goldnum)
  -- function num : 0_3 , upvalues : _ENV
  self._roleList = {}
  for k,v in pairs(roleList) do
    (table.insert)(self._roleList, {itemid = k, num = v})
  end
  ;
  (self._whiteFlowerNum):SetText(((NekoData.BehaviorManager).BM_Currency):GetWhiteCoin())
  if whitenum == 0 then
    (self._whiteFlowerAddNum):SetActive(false)
  else
    ;
    (self._whiteFlowerAddNum):SetText("+" .. whitenum)
  end
  ;
  (self._goldFlowerNum):SetText(((NekoData.BehaviorManager).BM_Currency):GetGoldCoin())
  if goldnum == 0 then
    (self._goldFlowerAddNum):SetActive(false)
  else
    ;
    (self._goldFlowerAddNum):SetText("+" .. goldnum)
  end
  ;
  (self._frame):ReloadAllCell()
end

CharResolveShopSoldDialig.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._roleList
end

CharResolveShopSoldDialig.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "shop.charresolveshopsoldcell"
end

CharResolveShopSoldDialig.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  local data = {}
  data.itemid = ((self._roleList)[index]).itemid
  data.num = ((self._roleList)[index]).num
  return data
end

CharResolveShopSoldDialig.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

CharResolveShopSoldDialig.OnConfirmBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cquickdecompose2petal")
  if protocol then
    protocol:Send()
  end
end

return CharResolveShopSoldDialig

