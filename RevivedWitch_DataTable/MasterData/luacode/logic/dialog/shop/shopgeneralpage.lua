-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopgeneralpage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local ShopGeneralPage = class("ShopGeneralPage", Dialog)
ShopGeneralPage.AssetBundleName = "ui/layouts.baseshop"
ShopGeneralPage.AssetName = "GeneralShop"
local BottomToTop = 3
local ROW, COL = 2, 5
ShopGeneralPage.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGeneralPage
  ((ShopGeneralPage.super).Ctor)(self, ...)
end

ShopGeneralPage.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
  self._back = self:GetChild("Back")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._refreshBtn = self:GetChild("ChangeBtn")
  self._refresh = self:GetChild("Refresh")
  self._refreshText = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("CellFrame")
  self._groupBtnArea = self:GetChild("GroupBtnFrame")
  self._groupBtnFrame = (TableFrame.Create)(self._groupBtnArea, self, true, false, true)
  ;
  (self._refreshBtn):Subscribe_PointerClickEvent(self.OnRefreshBtnClicked, self)
  self._soleBtn = self:GetChild("SoldBtn")
  self._soleBtn2 = self:GetChild("SoldBtn2")
  ;
  (self._soleBtn):Subscribe_PointerClickEvent(self.OnRoleSolveBtnClicked, self)
  ;
  (self._soleBtn2):Subscribe_PointerClickEvent(self.OnRoleSolveBtnClicked, self)
end

ShopGeneralPage.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  ;
  (self._groupBtnFrame):Destroy()
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

ShopGeneralPage.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, GridFrame, COL, ROW
  self._data = data
  self._cellInfo = (self._data).goodInfo
  if not (self._data).groupInfo then
    self._groupInfo = {}
    self._shopId = (self._delegate)._selectShopID
    ;
    (self._back):SetActive(self._shopId ~= 13 and self._shopId ~= 3)
    ;
    (self._refreshBtn):SetActive(self._shopId == 9)
    ;
    (self._refresh):SetActive(self._shopId == 9 or self._shopId == 7)
    ;
    (self._soleBtn):SetActive(self._shopId == 8)
    ;
    (self._soleBtn2):SetActive(self._shopId == 7)
    self._shopInfo = ((NekoData.BehaviorManager).BM_Shop):GetShopInfoByID(self._shopId)
    local strID = nil
    if self._shopId == 9 or self._shopId == 7 then
      strID = 1523
    else
      strID = 1183
    end
    local rec = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(strID)).msgTextID
    rec = (TextManager.GetText)(rec)
    local str = (os.date)("%Y-%m-%d", (self._shopInfo).closeTimeShow // 1000) .. " "
    str = str .. (os.date)("%H", (self._shopInfo).closeTimeShow // 1000) .. ":"
    str = str .. (os.date)("%M", (self._shopInfo).closeTimeShow // 1000) .. ":"
    str = str .. (os.date)("%S", (self._shopInfo).closeTimeShow // 1000)
    rec = (string.gsub)(rec, "%$parameter1%$", str)
    ;
    (self._refreshText):SetText(rec)
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    if (self._shopInfo).closeTimeShow ~= 0 then
      self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:CountDown()
  end
, nil)
    end
    if self._cellFrame then
      (self._cellFrame):Destroy()
    end
    self._cellFrame = (GridFrame.Create)(self._cellArea, self, true, COL, COL * ROW < #self._cellInfo)
    ;
    (self._cellFrame):ReloadAllCell()
    ;
    (self._groupBtnFrame):ReloadAllCell()
    ;
    (self:GetRootWindow()):PlayAnimation("GeneralShopShow")
    -- DECOMPILER ERROR: 12 unprocessed JMP targets
  end
end

ShopGeneralPage.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._groupBtnFrame then
    return #self._groupInfo
  else
    return #self._cellInfo
  end
end

ShopGeneralPage.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._groupBtnFrame then
    return "shop.shopleftbarbtncell"
  else
    return "shop.shopgeneralcell"
  end
end

ShopGeneralPage.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._groupBtnFrame then
    return (self._groupInfo)[index]
  else
    local data = {}
    data.iteminfo = (self._cellInfo)[index]
    return data
  end
end

ShopGeneralPage.OnGroupBtnClicked = function(self, id)
  -- function num : 0_7
  (self._delegate):OnGroupBtnClicked(id)
end

ShopGeneralPage.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
  local width, height = (self._cellArea):GetRectSize()
  local total = (self._cellFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

ShopGeneralPage.OnRefreshBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self._shopId ~= 9 then
    return 
  end
  if not ((NekoData.BehaviorManager).BM_Shop):GetShopRefreshCointLeftChange() then
    return 
  end
  ;
  ((DialogManager.CreateSingletonDialog)("shop.shoprefreshcointips")):SetData()
end

ShopGeneralPage.OnRoleSolveBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV, CItemAttrTable
  self._roleList = {}
  local list = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()
  local baginfo = ((NekoData.BehaviorManager).BM_BagInfo):GetItemHunShiList()
  local white = 0
  local gold = 0
  for _,v in pairs(list) do
    local lockCount = v:GetMaxEvolutionNeedItemCount()
    local record = CItemAttrTable:GetRecorder(v:GetItemId())
    for index,itemid in pairs(record.resolvegetitem) do
      if itemid ~= 0 then
        for _,item in pairs(baginfo) do
          -- DECOMPILER ERROR at PC43: Confused about usage of register: R22 in 'UnsetPending'

          if item:GetID() == itemid then
            (self._roleList)[itemid] = item:GetCount() - lockCount
            -- DECOMPILER ERROR at PC49: Confused about usage of register: R22 in 'UnsetPending'

            if (self._roleList)[itemid] <= 0 then
              (self._roleList)[itemid] = nil
              break
            end
            local rc = CItemAttrTable:GetRecorder(itemid)
            if rc then
              for key,value in pairs(rc.resolvegetitem) do
                if value == DataCommon.WhiteCoin then
                  white = white + (self._roleList)[itemid] * (rc.resolvegetitemnum)[key]
                else
                  if value == DataCommon.GoldCoin then
                    gold = gold + (self._roleList)[itemid] * (rc.resolvegetitemnum)[key]
                  end
                end
              end
            end
            break
          end
        end
      end
    end
  end
  if (table.nums)(self._roleList) == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100158)
    return 
  end
  ;
  ((DialogManager.CreateSingletonDialog)("shop.charresolveshopsolddialog")):SetData(self._roleList, white, gold)
end

ShopGeneralPage.OnEvent = function(self, eventName, arg)
  -- function num : 0_11
  if eventName == "BuyGoodRefresh" then
    (self._cellFrame):FireEvent("BuyGoodRefresh", {shopid = arg.shopid, goodInfo = arg.goodInfo})
  else
    if eventName == "ChangedSelected" then
      (self._groupBtnFrame):FireEvent("ChangedSelected", arg)
    else
      if eventName == "RedPointInfo" then
        (self._groupBtnFrame):FireEvent("RedPointInfo", arg)
      end
    end
  end
end

ShopGeneralPage.CountDown = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local time = (self._shopInfo).closeTimeShow - ServerGameTimer:GetServerTime()
  if time < 0 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
    if protocol then
      protocol.shopId = self._shopId
      protocol:Send()
    end
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

ShopGeneralPage.PlayTabShowAnimation = function(self)
  -- function num : 0_13
  (self._groupBtnArea):PlayAnimation("RecommendShopGroupBtn")
end

return ShopGeneralPage

