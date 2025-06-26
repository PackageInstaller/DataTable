-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopclothepage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local ShopClothePage = class("ShopClothePage", Dialog)
ShopClothePage.AssetBundleName = "ui/layouts.baseshop"
ShopClothePage.AssetName = "FashionShop"
ShopClothePage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopClothePage
  ((ShopClothePage.super).Ctor)(self, ...)
  self._emptyShowText = {[6] = 1422, [15] = 1424}
end

ShopClothePage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame, TableFrame
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._emptyTxt = self:GetChild("EmptyTxt")
  self._fashionBtn = self:GetChild("FashionBtn")
  self._fashionBtn_Text = self:GetChild("FashionBtn/Text")
  ;
  (self._fashionBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1902))
  self._fashionBtn_RedDot = self:GetChild("FashionBtn/RedDot")
  self._cellFrame = (GridFrame.Create)(self._cellArea, self, false, 1)
  self._groupBtnFrame = (TableFrame.Create)(self._groupBtnArea, self, true, false, true)
  ;
  (self._fashionBtn):Subscribe_PointerClickEvent(self.OnFashionBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshFashionBtnRewardRedDot, Common.n_RefreshSkinCollectAwardStatus, nil)
end

ShopClothePage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  ;
  (self._groupBtnFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("shop.roleskinlist.roleskinlistmaindialog")
  if self._clothTask1 then
    (ServerGameTimer.RemoveTask)(self._clothTask1)
    self._clothTask1 = nil
  end
  if self._clothTask2 then
    (ServerGameTimer.RemoveTask)(self._clothTask2)
    self._clothTask2 = nil
  end
end

ShopClothePage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, DM_RedDot, CStringRes
  self._groupBtnShowData = data.groupInfo
  ;
  (self._groupBtnFrame):ReloadAllCell()
  self._goodInfoData = data.goodInfo
  if (self._delegate)._selectShopID == 6 then
    self._goodInfoData = {}
    for _,value in pairs(data.goodInfo) do
      if value.goodRemain > 0 then
        (table.insert)(self._goodInfoData, value)
      end
    end
  end
  do
    ;
    (table.sort)(self._goodInfoData, function(a, b)
    -- function num : 0_3_0
    do return a.sortId < b.sortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    if (self._delegate)._selectShopID == 6 then
      self._itemRedDotNodes = (((DM_RedDot.nodeChildShop)[(self._delegate)._selectShopID]).childNode).ItemData
      ;
      (DM_RedDot.ClearNodeChild)(self._itemRedDotNodes)
      for _,value in pairs(self._goodInfoData) do
        local tempNode = (DM_RedDot.CreateNewNodeToTree)(value.goodId, self._itemRedDotNodes)
        tempNode.haveRedDot = (DM_RedDot.GetRedDotIsUnreadWithNode)(tempNode)
        local tempChildNode = (DM_RedDot.CreateNewNodeToTree)("hasFreeGoodNotBuy", tempNode)
        tempChildNode.haveRedDot = value.discountPrice == 0 and value.goodRemain ~= 0
        tempChildNode = (DM_RedDot.CreateNewNodeToTree)("breakUnlockCloth", tempNode)
        tempChildNode.haveRedDot = value.goodId > 10000
      end
      if (DM_RedDot.GetIDOpenFirst)(((DM_RedDot.nodeChildShop)[(self._delegate)._selectShopID]).nodeName) then
        (DM_RedDot.SetIDNotOpenFirst)(((DM_RedDot.nodeChildShop)[(self._delegate)._selectShopID]).nodeName)
        for _,value in pairs((self._itemRedDotNodes).childNode) do
          (DM_RedDot.SetNodeRead)(value, true)
        end
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_ShopRedPoint, nil, nil)
    else
      self._itemRedDotNodes = nil
    end
    ;
    (self._cellFrame):ReloadAllCell()
    if next(self._goodInfoData) then
      (self._emptyTxt):SetActive(false)
    else
      (self._emptyTxt):SetActive(true)
      ;
      (self._emptyTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder((self._emptyShowText)[(self._delegate)._selectShopID])).msgTextID))
    end
    if self._clothTask1 then
      (ServerGameTimer.RemoveTask)(self._clothTask1)
      self._clothTask1 = nil
    end
    if self._clothTask2 then
      (ServerGameTimer.RemoveTask)(self._clothTask2)
      self._clothTask2 = nil
    end
    if (self._delegate)._selectShopID == 6 then
      for _,value in pairs(self._goodInfoData) do
        if value.endTime > 0 then
          self._timeCount = 0
          self._clothTask1 = (ServerGameTimer.AddTask)(1, 1, self.UpdateTime, self)
          self._clothTask2 = (ServerGameTimer.AddTask)(value.endTime // 1000, -1, self.RemoveOnTimeEnd, self)
          break
        end
      end
    end
    self:RefreshFashionBtnRewardRedDot()
    -- DECOMPILER ERROR: 13 unprocessed JMP targets
  end
end

ShopClothePage.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._groupBtnFrame then
    return #self._groupBtnShowData
  else
    return #self._goodInfoData
  end
end

ShopClothePage.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    return "shop.shopclothecell"
  end
end

ShopClothePage.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._groupBtnFrame then
    return (self._groupBtnShowData)[index]
  else
    return {iteminfo = (self._goodInfoData)[index], index = index, itemRedDotNodes = self._itemRedDotNodes}
  end
end

ShopClothePage.OnGroupBtnClicked = function(self, id)
  -- function num : 0_7
  (self._delegate):OnGroupBtnClicked(id)
end

ShopClothePage.UpdateTime = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if (self._delegate)._selectShopID ~= 6 then
    if self._clothTask1 then
      (ServerGameTimer.RemoveTask)(self._clothTask1)
      self._clothTask1 = nil
    end
    return 
  end
  for _,value in pairs(self._goodInfoData) do
    if value.endTime > 0 then
      local divRes = value.endTime - 1000
      if divRes < 0 then
        divRes = 0
      end
      value.endTime = divRes
    end
  end
  self._timeCount = self._timeCount + 1000
  if self._timeCount == 60000 then
    self._timeCount = 0
    local lastPos = (self._cellFrame):GetCurrentPosition()
    ;
    (self._cellFrame):ReloadAllCell()
    if lastPos then
      (self._cellFrame):MoveToAssignedPos(lastPos)
    end
  end
end

ShopClothePage.RemoveOnTimeEnd = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (self._delegate)._selectShopID == 6 then
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(6)
  end
end

ShopClothePage.OnEvent = function(self, eventName, arg)
  -- function num : 0_10
  if eventName == "ChangedSelected" then
    (self._groupBtnFrame):FireEvent("ChangedSelected", arg)
  else
    if eventName == "BuyGoodRefresh" then
      (self._cellFrame):FireEvent("BuyGoodRefresh", {shopid = arg.shopid, goodInfo = arg.goodInfo})
    else
      if eventName == "RedPointInfo" and ((self._delegate)._selectShopID == 6 or (self._delegate)._selectShopID == 15) then
        (self._groupBtnFrame):FireEvent("RedPointInfo", arg)
        if (self._delegate)._selectShopID == 6 then
          (self._cellFrame):FireEvent("RedPointInfo", arg)
        end
      end
    end
  end
end

ShopClothePage.PlayTabShowAnimation = function(self)
  -- function num : 0_11
  (self._groupBtnArea):PlayAnimation("RecommendShopGroupBtn")
end

ShopClothePage.OnFashionBtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("shop.roleskinlist.roleskinlistmaindialog")
  if dialog then
    dialog:Init()
  end
end

ShopClothePage.RefreshFashionBtnRewardRedDot = function(self)
  -- function num : 0_13 , upvalues : DM_RedDot
  local needShowFashionRedPoint = (DM_RedDot.GetNodeResult)(((DM_RedDot.nodeShop).childNode).KeyHasFashionRewardToGet)
  ;
  (self._fashionBtn_RedDot):SetActive(needShowFashionRedPoint)
end

return ShopClothePage

