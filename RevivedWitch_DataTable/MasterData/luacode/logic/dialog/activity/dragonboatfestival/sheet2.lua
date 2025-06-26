-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/dragonboatfestival/sheet2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SkinTypeId = 91
local Sheet2 = class("Sheet2", Dialog)
Sheet2.AssetBundleName = "ui/layouts.activityspringouting"
Sheet2.AssetName = "ActivitySpringOutingShop"
Sheet2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet2
  ((Sheet2.super).Ctor)(self, ...)
  self._goodsData = {}
end

Sheet2.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._activityTime = self:GetChild("ActiveTime")
  self._desTxt = self:GetChild("Txt")
  self._tipsBtn = self:GetChild("Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._cellPanel = self:GetChild("FrameShop")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, false, true, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSDragonBoatFestivalInfo, Common.n_SDragonBoatFestivalInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_BuyShopGood, nil)
  self:SetStaticRes()
end

Sheet2.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._activityTime):SetText((TextManager.GetText)((CStringRes:GetRecorder(1812)).msgTextID))
  ;
  (self._desTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1842)).msgTextID))
end

Sheet2.OnDestroy = function(self)
  -- function num : 0_3
  if self._cellFrame then
    (self._cellFrame):Destroy()
  end
end

Sheet2.SetData = function(self, shopID)
  -- function num : 0_4 , upvalues : _ENV
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  self._shopID = shopID
  self:RefreshShopInfo()
end

Sheet2.RefreshShopInfo = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local goodsData = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(self._shopID)
  if PrintTable then
    LogError("_shopID", tostring(self._shopID))
    PrintTable(goodsData, 3, "goodsData")
  end
  if #goodsData ~= 3 then
    LogErrorFormat("DragonBoatFestival.Sheet2.SetData", "The shop goods length error! | %d", #goodsData)
    return 
  end
  if self._goodsData then
    for key,_ in pairs(self._goodsData) do
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

      (self._goodsData)[key] = nil
    end
  else
    do
      self._goodsData = {}
      for _,value in pairs(goodsData) do
        (table.insert)(self._goodsData, value)
      end
      ;
      (table.sort)(self._goodsData, function(a, b)
    -- function num : 0_5_0
    do return a.discountPrice < b.discountPrice end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      ;
      (self._cellFrame):ReloadAllCell()
    end
  end
end

Sheet2.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._goodsData
end

Sheet2.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "activity.dragonboatfestival.shopgoodscell"
end

Sheet2.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return {data = (self._goodsData)[index], index = index}
end

Sheet2.OnTipsBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV, CStringRes
  local dialogName = "activity.dragonboatfestival.tipsdialog"
  local dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  if dialog then
    dialog:SetData((CStringRes:GetRecorder(1810)).msgTextID, (CStringRes:GetRecorder(1814)).msgTextID)
  end
end

Sheet2.OnSDragonBoatFestivalInfo = function(self)
  -- function num : 0_10
end

return Sheet2

