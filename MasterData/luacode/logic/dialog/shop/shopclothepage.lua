local CStringRes = BeanManager.GetTableByName("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DM_RedDot = NekoData.DataManager.DM_RedDot
local ShopClothePage = class("ShopClothePage", Dialog)
ShopClothePage.AssetBundleName = "ui/layouts.baseshop"
ShopClothePage.AssetName = "FashionShop"

function ShopClothePage:Ctor(...)
  ShopClothePage.super.Ctor(self, ...)
  self._emptyShowText = {
    [6] = 1422,
    [15] = 1424
  }
end

function ShopClothePage:OnCreate()
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._emptyTxt = self:GetChild("EmptyTxt")
  self._fashionBtn = self:GetChild("FashionBtn")
  self._fashionBtn_Text = self:GetChild("FashionBtn/Text")
  self._fashionBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1902))
  self._fashionBtn_RedDot = self:GetChild("FashionBtn/RedDot")
  self._cellFrame = GridFrame.Create(self._cellArea, self, false, 1)
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, true, false, true)
  self._fashionBtn:Subscribe_PointerClickEvent(self.OnFashionBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshFashionBtnRewardRedDot, Common.n_RefreshSkinCollectAwardStatus, nil)
end

function ShopClothePage:OnDestroy()
  self._cellFrame:Destroy()
  self._groupBtnFrame:Destroy()
  DialogManager.DestroySingletonDialog("shop.roleskinlist.roleskinlistmaindialog")
  if self._clothTask1 then
    ServerGameTimer.RemoveTask(self._clothTask1)
    self._clothTask1 = nil
  end
  if self._clothTask2 then
    ServerGameTimer.RemoveTask(self._clothTask2)
    self._clothTask2 = nil
  end
end

function ShopClothePage:RefreshCell(data)
  self._groupBtnShowData = data.groupInfo
  self._groupBtnFrame:ReloadAllCell()
  self._goodInfoData = data.goodInfo
  if self._delegate._selectShopID == 6 then
    self._goodInfoData = {}
    for _, value in pairs(data.goodInfo) do
      if value.goodRemain > 0 then
        table.insert(self._goodInfoData, value)
      end
    end
  end
  table.sort(self._goodInfoData, function(a, b)
    return a.sortId < b.sortId
  end)
  if self._delegate._selectShopID == 6 then
    self._itemRedDotNodes = DM_RedDot.nodeChildShop[self._delegate._selectShopID].childNode.ItemData
    DM_RedDot.ClearNodeChild(self._itemRedDotNodes)
    for _, value in pairs(self._goodInfoData) do
      local tempNode = DM_RedDot.CreateNewNodeToTree(value.goodId, self._itemRedDotNodes)
      tempNode.haveRedDot = DM_RedDot.GetRedDotIsUnreadWithNode(tempNode)
      local tempChildNode = DM_RedDot.CreateNewNodeToTree("hasFreeGoodNotBuy", tempNode)
      tempChildNode.haveRedDot = value.discountPrice == 0 and value.goodRemain ~= 0
      tempChildNode = DM_RedDot.CreateNewNodeToTree("breakUnlockCloth", tempNode)
      tempChildNode.haveRedDot = value.goodId > 10000
    end
    if DM_RedDot.GetIDOpenFirst(DM_RedDot.nodeChildShop[self._delegate._selectShopID].nodeName) then
      DM_RedDot.SetIDNotOpenFirst(DM_RedDot.nodeChildShop[self._delegate._selectShopID].nodeName)
      for _, value in pairs(self._itemRedDotNodes.childNode) do
        DM_RedDot.SetNodeRead(value, true)
      end
    end
    LuaNotificationCenter.PostNotification(Common.n_ShopRedPoint, nil, nil)
  else
    self._itemRedDotNodes = nil
  end
  self._cellFrame:ReloadAllCell()
  if next(self._goodInfoData) then
    self._emptyTxt:SetActive(false)
  else
    self._emptyTxt:SetActive(true)
    self._emptyTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(self._emptyShowText[self._delegate._selectShopID]).msgTextID))
  end
  if self._clothTask1 then
    ServerGameTimer.RemoveTask(self._clothTask1)
    self._clothTask1 = nil
  end
  if self._clothTask2 then
    ServerGameTimer.RemoveTask(self._clothTask2)
    self._clothTask2 = nil
  end
  if self._delegate._selectShopID == 6 then
    for _, value in pairs(self._goodInfoData) do
      if 0 < value.endTime then
        self._timeCount = 0
        self._clothTask1 = ServerGameTimer.AddTask(1, 1, self.UpdateTime, self)
        self._clothTask2 = ServerGameTimer.AddTask(value.endTime // 1000, -1, self.RemoveOnTimeEnd, self)
        break
      end
    end
  end
  self:RefreshFashionBtnRewardRedDot()
end

function ShopClothePage:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    return #self._groupBtnShowData
  else
    return #self._goodInfoData
  end
end

function ShopClothePage:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    return "shop.shopclothecell"
  end
end

function ShopClothePage:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return self._groupBtnShowData[index]
  else
    return {
      iteminfo = self._goodInfoData[index],
      index = index,
      itemRedDotNodes = self._itemRedDotNodes
    }
  end
end

function ShopClothePage:OnGroupBtnClicked(id)
  self._delegate:OnGroupBtnClicked(id)
end

function ShopClothePage:UpdateTime()
  if self._delegate._selectShopID ~= 6 then
    if self._clothTask1 then
      ServerGameTimer.RemoveTask(self._clothTask1)
      self._clothTask1 = nil
    end
    return
  end
  for _, value in pairs(self._goodInfoData) do
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
    local lastPos = self._cellFrame:GetCurrentPosition()
    self._cellFrame:ReloadAllCell()
    if lastPos then
      self._cellFrame:MoveToAssignedPos(lastPos)
    end
  end
end

function ShopClothePage:RemoveOnTimeEnd()
  if self._delegate._selectShopID == 6 then
    NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(6)
  end
end

function ShopClothePage:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self._groupBtnFrame:FireEvent("ChangedSelected", arg)
  elseif eventName == "BuyGoodRefresh" then
    self._cellFrame:FireEvent("BuyGoodRefresh", {
      shopid = arg.shopid,
      goodInfo = arg.goodInfo
    })
  elseif eventName == "RedPointInfo" and (self._delegate._selectShopID == 6 or self._delegate._selectShopID == 15) then
    self._groupBtnFrame:FireEvent("RedPointInfo", arg)
    if self._delegate._selectShopID == 6 then
      self._cellFrame:FireEvent("RedPointInfo", arg)
    end
  end
end

function ShopClothePage:PlayTabShowAnimation()
  self._groupBtnArea:PlayAnimation("RecommendShopGroupBtn")
end

function ShopClothePage:OnFashionBtnClick()
  local dialog = DialogManager.CreateSingletonDialog("shop.roleskinlist.roleskinlistmaindialog")
  if dialog then
    dialog:Init()
  end
end

function ShopClothePage:RefreshFashionBtnRewardRedDot()
  local needShowFashionRedPoint = DM_RedDot.GetNodeResult(DM_RedDot.nodeShop.childNode.KeyHasFashionRewardToGet)
  self._fashionBtn_RedDot:SetActive(needShowFashionRedPoint)
end

return ShopClothePage
