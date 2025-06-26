-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/sheet2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SkinTypeId = 91
local Sheet2 = class("Sheet2", Dialog)
Sheet2.AssetBundleName = "ui/layouts.activitysummer2"
Sheet2.AssetName = "ActivitySummer2OtherShop"
Sheet2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Sheet2
  ((Sheet2.super).Ctor)(self, ...)
  self._goodsData = {}
end

Sheet2.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._cellPanel = self:GetChild("Back/Frame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, false, true, false)
  self._tipsBtn = self:GetChild("Back/Tips")
  ;
  (self._tipsBtn):Subscribe_PointerClickEvent(self.OnTipsBtnClicked, self)
  self._endTime = self:GetChild("Back/EndTimeBack/EndTime")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_RefreshShopInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShopInfo, Common.n_BuyShopGood, nil)
  ;
  (self._endTime):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2148))
end

Sheet2.OnDestroy = function(self)
  -- function num : 0_2
  if self._cellFrame then
    (self._cellFrame):Destroy()
  end
end

Sheet2.SetData = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._shopID = protocol.shopId
  self:RefreshShopInfo()
end

Sheet2.RefreshShopInfo = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local goodsData = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(self._shopID)
  if PrintTable then
    LogError("_shopID", tostring(self._shopID))
    PrintTable(goodsData, 3, "goodsData")
  end
  if #goodsData ~= 3 then
    LogErrorFormat("SummerEchoes.Sheet2.SetData", "The shop goods length error! | %d", #goodsData)
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
    -- function num : 0_4_0
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
  -- function num : 0_5
  return #self._goodsData
end

Sheet2.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.swimsuitechoes.shopgoodscell1"
end

Sheet2.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return {data = (self._goodsData)[index], index = index}
end

Sheet2.OnTipsBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(14)
end

return Sheet2

