-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/witchcalendar/witchcalendarsigncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CMonthloginsupplementarySignature = (BeanManager.GetTableByName)("welfare.cmonthloginsupplementarysignature")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local WitchCalendarSignCell = class("WitchCalendarSignCell", Dialog)
WitchCalendarSignCell.AssetBundleName = "ui/layouts.welfare"
WitchCalendarSignCell.AssetName = "MonthLoginItemCell"
WitchCalendarSignCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WitchCalendarSignCell
  ((WitchCalendarSignCell.super).Ctor)(self, ...)
end

WitchCalendarSignCell.OnCreate = function(self)
  -- function num : 0_1
  self._dayTxt = self:GetChild("Day")
  self._signPatch = self:GetChild("SignPatch")
  self._backImg = self:GetChild("Back")
  self._effect = self:GetChild("Effect")
  self._gotImg = self:GetChild("GotImg")
  self._highlight = self:GetChild("Highlight")
  self._monthCardImage = self:GetChild("MonthCardTxt")
  self._item = {icon = self:GetChild("ItemCell/_BackGround/Icon"), count = self:GetChild("ItemCell/_Count"), frame = self:GetChild("ItemCell/_BackGround/Frame")}
  ;
  ((self._item).icon):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self._signPatch):Subscribe_PointerClickEvent(self.OnPendingBtnClicked, self)
  ;
  (self._highlight):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
end

WitchCalendarSignCell.OnDestroy = function(self)
  -- function num : 0_2
end

WitchCalendarSignCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CImagePath
  self.data = data
  self._isToday = data.tag == "today"
  self._isReceived = data.tag == "received"
  self._isPending = data.tag == "pending"
  self._isLock = data.tag == "lock"
  local item = (Item.Create)((data.record).itemID)
  item:SetCount((data.record).itemNum)
  ;
  (self._dayTxt):SetText(data.id)
  ;
  ((self._item).icon):SetSprite(item:GetIconAB())
  ;
  ((self._item).count):SetText(item:GetCount())
  ;
  ((self._item).frame):SetSprite(item:GetPinJiImageAB())
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._item).itemData = item
  ;
  (self._highlight):SetActive(self._isToday)
  ;
  (self._gotImg):SetActive(self._isReceived)
  ;
  (self._signPatch):SetActive(self._isPending)
  if not CImagePath:GetRecorder((data.record).itemcellbackID) then
    imageRecord = DataCommon.DefaultImageAsset
    ;
    (self._backImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._monthCardImage):SetActive((data.record).monthcardJurisdiction ~= 0)
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

WitchCalendarSignCell.OnGetBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cmonthlysign")
  protocol.dayId = (self._cellData).id
  protocol:Send()
end

WitchCalendarSignCell.OnPendingBtnClicked = function(self)
  -- function num : 0_5 , upvalues : CMonthloginsupplementarySignature, _ENV
  local time = ((self._delegate)._data).complementNum + 1
  if time <= 0 then
    return 
  end
  local record = CMonthloginsupplementarySignature:GetRecorder(time)
  if not record then
    record = CMonthloginsupplementarySignature:GetRecorder(#CMonthloginsupplementarySignature:GetAllIds())
  end
  local isEnough = record.spenditemNumb <= ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(record.spenditemid)
  if isEnough or record.spenditemNumb == 0 then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(145, {record.spenditemNumb}, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.ccomplementsigned")
    protocol.dayId = (self._cellData).id
    protocol:Send()
  end
, {}, nil, {})
  elseif record.spenditemid == DataCommon.SoulDropID then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(108, nil, function()
    -- function num : 0_5_1 , upvalues : _ENV
    ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(19)
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
, {}, nil, {})
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

WitchCalendarSignCell.OnItemCellClicked = function(self)
  -- function num : 0_6 , upvalues : CSkinItem, _ENV, CRoleItemTable
  if ((self._item).itemData):GetItemTypeId() == 91 then
    local cfg = CSkinItem:GetRecorder(((self._item).itemData):GetID())
    if not cfg then
      LogErrorFormat("WitchCalendarSignCell", "record with id %s is not exist in cskinitem", ((self._item).itemData):GetID())
    end
    local dlg = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
    local data = {}
    ;
    (table.insert)(data, {itemId = cfg.Skinid})
    dlg:SetData((dlg.TargetType).OnlyShow, data)
  else
    do
      local cfg = CRoleItemTable:GetRecorder(((self._item).itemData):GetID())
      if cfg then
        local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
        local roleInfoDialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
        local roleIDList = {cfg.roleid}
        local cfgIDList = {4}
        roleInfoDialog:Init({roleIdList = roleIDList, cfgIdList = cfgIDList, index = 1}, (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo)
      else
        do
          local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
          if tipsDialog then
            tipsDialog:Init({item = (self._item).itemData})
            local width, height = ((self._item).frame):GetRectSize()
            tipsDialog:SetTipsPosition(width, height, ((self._item).frame):GetLocalPointInUiRootPanel())
          end
        end
      end
    end
  end
end

return WitchCalendarSignCell

