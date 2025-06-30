-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/monthsign/monthsigncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local MonthSignCell = class("MonthSignCell", Dialog)
MonthSignCell.AssetBundleName = "ui/layouts.welfare"
MonthSignCell.AssetName = "WelfareSign30DayCell"
MonthSignCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthSignCell
  ((MonthSignCell.super).Ctor)(self, ...)
end

MonthSignCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._progress = self:GetChild("ProgressBack/Progress")
  self._progress_cur = self:GetChild("ProgressBack/Num/Num")
  self._progress_max = self:GetChild("ProgressBack/Num/NumMax")
  self._itemCell = self:GetChild("ItemCell")
  self._itemCell_frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemCell_icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemCell_count = self:GetChild("ItemCell/_Count")
  self._lock = self:GetChild("LockBtn")
  self._received = self:GetChild("DoneBtn")
  self._grey = self:GetChild("Light")
  self._getBtn = self:GetChild("GetBtn")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
end

MonthSignCell.OnDestroy = function(self)
  -- function num : 0_2
end

MonthSignCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1911, {(data.record).cumulativeDays}))
  ;
  (self._progress_max):SetText((data.record).cumulativeDays)
  if data.tag ~= "lock" then
    (self._progress):SetFillAmount(1)
    ;
    (self._progress_cur):SetText((data.record).cumulativeDays)
  else
    ;
    (self._progress):SetFillAmount(((self._delegate)._data).signTotalNum / (data.record).cumulativeDays)
    ;
    (self._progress_cur):SetText(((self._delegate)._data).signTotalNum)
  end
  self._item = (Item.Create)((data.record).rewardId)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._itemCell_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetShopPinJiBackGroundImage()
  ;
  (self._itemCell_frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemCell_count):SetText((data.record).nums)
  ;
  (self._getBtn):SetActive(data.tag == "get")
  ;
  (self._lock):SetActive(data.tag == "lock")
  ;
  (self._received):SetActive(data.tag == "received")
  ;
  (self._grey):SetActive(data.tag == "received")
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

MonthSignCell.OnGetBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.login.creceivesignmonthreward")
  protocol.signNum = ((self._cellData).record).id
  protocol:Send()
end

MonthSignCell.OnItemCellClicked = function(self)
  -- function num : 0_5 , upvalues : CSkinItem, _ENV, CRoleItemTable
  if (self._item):GetItemTypeId() == 91 then
    local cfg = CSkinItem:GetRecorder((self._item):GetID())
    if not cfg then
      LogErrorFormat("MonthSignCell", "record with id %s is not exist in cskinitem", (self._item):GetID())
    end
    local dlg = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
    local data = {}
    ;
    (table.insert)(data, {itemId = cfg.Skinid})
    dlg:SetData((dlg.TargetType).OnlyShow, data)
  else
    do
      local cfg = CRoleItemTable:GetRecorder((self._item):GetID())
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
            tipsDialog:Init({item = self._item})
            local width, height = (self._itemCell):GetRectSize()
            tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
          end
        end
      end
    end
  end
end

return MonthSignCell

