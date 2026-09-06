local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local ShopGeneralPage = class("ShopGeneralPage", Dialog)
ShopGeneralPage.AssetBundleName = "ui/layouts.baseshop"
ShopGeneralPage.AssetName = "GeneralShop"
local BottomToTop = 3
local ROW, COL = 2, 5

function ShopGeneralPage:Ctor(...)
  ShopGeneralPage.super.Ctor(self, ...)
end

function ShopGeneralPage:OnCreate()
  self._back = self:GetChild("Back")
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._refreshBtn = self:GetChild("ChangeBtn")
  self._refresh = self:GetChild("Refresh")
  self._refreshText = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._groupBtnFrame = TableFrame.Create(self._groupBtnArea, self, true, false, true)
  self._refreshBtn:Subscribe_PointerClickEvent(self.OnRefreshBtnClicked, self)
  self._soleBtn = self:GetChild("SoldBtn")
  self._soleBtn2 = self:GetChild("SoldBtn2")
  self._soleBtn:Subscribe_PointerClickEvent(self.OnRoleSolveBtnClicked, self)
  self._soleBtn2:Subscribe_PointerClickEvent(self.OnRoleSolveBtnClicked, self)
end

function ShopGeneralPage:OnDestroy()
  self._cellFrame:Destroy()
  self._groupBtnFrame:Destroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function ShopGeneralPage:RefreshCell(data)
  self._data = data
  self._cellInfo = self._data.goodInfo
  self._groupInfo = self._data.groupInfo or {}
  self._shopId = self._delegate._selectShopID
  self._back:SetActive(self._shopId ~= 13 and self._shopId ~= 3)
  self._refreshBtn:SetActive(self._shopId == 9)
  self._refresh:SetActive(self._shopId == 9 or self._shopId == 7)
  self._soleBtn:SetActive(self._shopId == 8)
  self._soleBtn2:SetActive(self._shopId == 7)
  self._shopInfo = NekoData.BehaviorManager.BM_Shop:GetShopInfoByID(self._shopId)
  local strID
  if self._shopId == 9 or self._shopId == 7 then
    strID = 1523
  else
    strID = 1183
  end
  local rec = BeanManager.GetTableByName("message.cstringres"):GetRecorder(strID).msgTextID
  rec = TextManager.GetText(rec)
  local str = os.date("%Y-%m-%d", self._shopInfo.closeTimeShow // 1000) .. " "
  str = str .. os.date("%H", self._shopInfo.closeTimeShow // 1000) .. ":"
  str = str .. os.date("%M", self._shopInfo.closeTimeShow // 1000) .. ":"
  str = str .. os.date("%S", self._shopInfo.closeTimeShow // 1000)
  rec = string.gsub(rec, "%$parameter1%$", str)
  self._refreshText:SetText(rec)
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if self._shopInfo.closeTimeShow ~= 0 then
    self._task = ServerGameTimer.AddTask(0, 1, function()
      self:CountDown()
    end, nil)
  end
  if self._cellFrame then
    self._cellFrame:Destroy()
  end
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, COL, #self._cellInfo > COL * ROW)
  self._cellFrame:ReloadAllCell()
  self._groupBtnFrame:ReloadAllCell()
  self:GetRootWindow():PlayAnimation("GeneralShopShow")
end

function ShopGeneralPage:NumberOfCell(frame)
  if frame == self._groupBtnFrame then
    return #self._groupInfo
  else
    return #self._cellInfo
  end
end

function ShopGeneralPage:CellAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    return "shop.shopgeneralcell"
  end
end

function ShopGeneralPage:DataAtIndex(frame, index)
  if frame == self._groupBtnFrame then
    return self._groupInfo[index]
  else
    local data = {}
    data.iteminfo = self._cellInfo[index]
    return data
  end
end

function ShopGeneralPage:OnGroupBtnClicked(id)
  self._delegate:OnGroupBtnClicked(id)
end

function ShopGeneralPage:OnCurPosChange(frame, proportion)
  local width, height = self._cellArea:GetRectSize()
  local total = self._cellFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function ShopGeneralPage:OnRefreshBtnClicked()
  if self._shopId ~= 9 then
    return
  end
  if not NekoData.BehaviorManager.BM_Shop:GetShopRefreshCointLeftChange() then
    return
  end
  DialogManager.CreateSingletonDialog("shop.shoprefreshcointips"):SetData()
end

function ShopGeneralPage:OnRoleSolveBtnClicked()
  self._roleList = {}
  local list = NekoData.BehaviorManager.BM_AllRoles:GetRoleList()
  local baginfo = NekoData.BehaviorManager.BM_BagInfo:GetItemHunShiList()
  local white = 0
  local gold = 0
  for _, v in pairs(list) do
    local lockCount = v:GetMaxEvolutionNeedItemCount()
    local record = CItemAttrTable:GetRecorder(v:GetItemId())
    for index, itemid in pairs(record.resolvegetitem) do
      if itemid ~= 0 then
        for _, item in pairs(baginfo) do
          if item:GetID() == itemid then
            self._roleList[itemid] = item:GetCount() - lockCount
            if self._roleList[itemid] <= 0 then
              self._roleList[itemid] = nil
              break
            end
            local rc = CItemAttrTable:GetRecorder(itemid)
            if rc then
              for key, value in pairs(rc.resolvegetitem) do
                if value == DataCommon.WhiteCoin then
                  white = white + self._roleList[itemid] * rc.resolvegetitemnum[key]
                elseif value == DataCommon.GoldCoin then
                  gold = gold + self._roleList[itemid] * rc.resolvegetitemnum[key]
                end
              end
            end
            break
          end
        end
      end
    end
  end
  if table.nums(self._roleList) == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100158)
    return
  end
  DialogManager.CreateSingletonDialog("shop.charresolveshopsolddialog"):SetData(self._roleList, white, gold)
end

function ShopGeneralPage:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    self._cellFrame:FireEvent("BuyGoodRefresh", {
      shopid = arg.shopid,
      goodInfo = arg.goodInfo
    })
  elseif eventName == "ChangedSelected" then
    self._groupBtnFrame:FireEvent("ChangedSelected", arg)
  elseif eventName == "RedPointInfo" then
    self._groupBtnFrame:FireEvent("RedPointInfo", arg)
  end
end

function ShopGeneralPage:CountDown()
  local time = self._shopInfo.closeTimeShow - ServerGameTimer:GetServerTime()
  if time < 0 then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    if protocol then
      protocol.shopId = self._shopId
      protocol:Send()
    end
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

function ShopGeneralPage:PlayTabShowAnimation()
  self._groupBtnArea:PlayAnimation("RecommendShopGroupBtn")
end

return ShopGeneralPage
