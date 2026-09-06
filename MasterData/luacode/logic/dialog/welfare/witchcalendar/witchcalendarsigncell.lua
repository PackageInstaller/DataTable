local Item = require("logic.manager.experimental.types.item")
local CMonthloginsupplementarySignature = BeanManager.GetTableByName("welfare.cmonthloginsupplementarysignature")
local CSkinItem = BeanManager.GetTableByName("item.cskinitem")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local WitchCalendarSignCell = class("WitchCalendarSignCell", Dialog)
WitchCalendarSignCell.AssetBundleName = "ui/layouts.welfare"
WitchCalendarSignCell.AssetName = "MonthLoginItemCell"

function WitchCalendarSignCell:Ctor(...)
  WitchCalendarSignCell.super.Ctor(self, ...)
end

function WitchCalendarSignCell:OnCreate()
  self._dayTxt = self:GetChild("Day")
  self._signPatch = self:GetChild("SignPatch")
  self._backImg = self:GetChild("Back")
  self._effect = self:GetChild("Effect")
  self._gotImg = self:GetChild("GotImg")
  self._highlight = self:GetChild("Highlight")
  self._monthCardImage = self:GetChild("MonthCardTxt")
  self._item = {
    icon = self:GetChild("ItemCell/_BackGround/Icon"),
    count = self:GetChild("ItemCell/_Count"),
    frame = self:GetChild("ItemCell/_BackGround/Frame")
  }
  self._item.icon:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._signPatch:Subscribe_PointerClickEvent(self.OnPendingBtnClicked, self)
  self._highlight:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
end

function WitchCalendarSignCell:OnDestroy()
end

function WitchCalendarSignCell:RefreshCell(data)
  self.data = data
  self._isToday = data.tag == "today"
  self._isReceived = data.tag == "received"
  self._isPending = data.tag == "pending"
  self._isLock = data.tag == "lock"
  local item = Item.Create(data.record.itemID)
  item:SetCount(data.record.itemNum)
  self._dayTxt:SetText(data.id)
  self._item.icon:SetSprite(item:GetIconAB())
  self._item.count:SetText(item:GetCount())
  self._item.frame:SetSprite(item:GetPinJiImageAB())
  self._item.itemData = item
  self._highlight:SetActive(self._isToday)
  self._gotImg:SetActive(self._isReceived)
  self._signPatch:SetActive(self._isPending)
  imageRecord = CImagePath:GetRecorder(data.record.itemcellbackID) or DataCommon.DefaultImageAsset
  self._backImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._monthCardImage:SetActive(data.record.monthcardJurisdiction ~= 0)
end

function WitchCalendarSignCell:OnGetBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cmonthlysign")
  protocol.dayId = self._cellData.id
  protocol:Send()
end

function WitchCalendarSignCell:OnPendingBtnClicked()
  local time = self._delegate._data.complementNum + 1
  if time <= 0 then
    return
  end
  local record = CMonthloginsupplementarySignature:GetRecorder(time)
  record = record or CMonthloginsupplementarySignature:GetRecorder(#CMonthloginsupplementarySignature:GetAllIds())
  local isEnough = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(record.spenditemid) >= record.spenditemNumb
  if isEnough or record.spenditemNumb == 0 then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(145, {
      record.spenditemNumb
    }, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.activity.ccomplementsigned")
      protocol.dayId = self._cellData.id
      protocol:Send()
    end, {}, nil, {})
  elseif record.spenditemid == DataCommon.SoulDropID then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
      NekoData.DataManager.DM_Shop:ClientSetOpenShopID(19)
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end, {}, nil, {})
  end
end

function WitchCalendarSignCell:OnItemCellClicked()
  if self._item.itemData:GetItemTypeId() == 91 then
    local cfg = CSkinItem:GetRecorder(self._item.itemData:GetID())
    if not cfg then
      LogErrorFormat("WitchCalendarSignCell", "record with id %s is not exist in cskinitem", self._item.itemData:GetID())
    end
    local dlg = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
    local data = {}
    table.insert(data, {
      itemId = cfg.Skinid
    })
    dlg:SetData(dlg.TargetType.OnlyShow, data)
  else
    local cfg = CRoleItemTable:GetRecorder(self._item.itemData:GetID())
    if cfg then
      local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
      local roleInfoDialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
      local roleIDList = {
        cfg.roleid
      }
      local cfgIDList = {4}
      roleInfoDialog:Init({
        roleIdList = roleIDList,
        cfgIdList = cfgIDList,
        index = 1
      }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
    else
      local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init({
          item = self._item.itemData
        })
        local width, height = self._item.frame:GetRectSize()
        tipsDialog:SetTipsPosition(width, height, self._item.frame:GetLocalPointInUiRootPanel())
      end
    end
  end
end

return WitchCalendarSignCell
