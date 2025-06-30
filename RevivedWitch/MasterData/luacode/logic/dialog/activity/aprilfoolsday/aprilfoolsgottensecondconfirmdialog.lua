-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolsgottensecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local UIManager = ((CS.PixelNeko).UI).UIManager
local AprilFoolsGottenSecondConfirmDialog = class("AprilFoolsGottenSecondConfirmDialog", Dialog)
AprilFoolsGottenSecondConfirmDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsGottenSecondConfirmDialog.AssetName = "ActivityAprilFoolsSecond"
AprilFoolsGottenSecondConfirmDialog.ShowDialogType = {Role = 1, Item = 2, DungeonUnlock = 3, ShopUnlock = 4}
AprilFoolsGottenSecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsGottenSecondConfirmDialog
  ((AprilFoolsGottenSecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._showingList = {}
  self._isOpening = false
end

AprilFoolsGottenSecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CStringRes, TableFrame
  self._back = self:GetChild("Back")
  self._title = self:GetChild("Back/Text")
  self._name = self:GetChild("Back/Name")
  self._charImg = self:GetChild("HeadPhoto")
  self._panel = self:GetChild("Frame")
  self._dungeonBattleBtnImg = self:GetChild("BattleBtn")
  self._shopBtnImg = self:GetChild("ShopBtn")
  self._tipsTxt = self:GetChild("Back/TextTip")
  ;
  (self._tipsTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1479)).msgTextID))
  self._panelAnchorMinX = (self._panel):GetAnchorAndOffset()
  self._itemFrame = (TableFrame.Create)(self._panel, self, false, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

AprilFoolsGottenSecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._itemFrame then
    (self._itemFrame):Destroy()
    self._itemFrame = nil
  end
end

AprilFoolsGottenSecondConfirmDialog.SetData = function(self, typeNum, data)
  -- function num : 0_3 , upvalues : _ENV
  (table.insert)(self._showingList, {typeNum = typeNum, data = data})
  if not self._isOpening then
    self._isOpening = true
    self:ShowNext()
  end
end

AprilFoolsGottenSecondConfirmDialog.ShowNext = function(self)
  -- function num : 0_4 , upvalues : _ENV, CStringRes, Role, ItemTypeEnum, Item
  if #self._showingList > 0 then
    local typeNum = ((self._showingList)[1]).typeNum
    local data = ((self._showingList)[1]).data
    if typeNum == (self.ShowDialogType).Role then
      (self._panel):SetActive(false)
      ;
      (self._charImg):SetActive(true)
      ;
      (self._name):SetActive(true)
      ;
      (self._dungeonBattleBtnImg):SetActive(false)
      ;
      (self._shopBtnImg):SetActive(false)
      ;
      (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1786)).msgTextID))
      local role = (Role.Create)(data)
      local image = role:GetShapeLittleHeadImageRecord()
      ;
      (self._charImg):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._name):SetText(role:GetRoleName())
    else
      do
        if typeNum == (self.ShowDialogType).Item then
          (self._panel):SetActive(true)
          ;
          (self._charImg):SetActive(false)
          ;
          (self._name):SetActive(false)
          ;
          (self._dungeonBattleBtnImg):SetActive(false)
          ;
          (self._shopBtnImg):SetActive(false)
          ;
          (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1785)).msgTextID))
          self._itemList = {}
          local item = nil
          for _,d in ipairs(data) do
            if d.gain == 1 then
              if d.itemtype == ItemTypeEnum.BASEITEM then
                item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(d.bagtype, d.id)
              else
                LogErrorFormat("AprilFoolsGottenSecondConfirmDialog", "wrong itemtype %s bagtype %s ItemInfo.id %s", d.itemtype, d.bagtype, d.id)
              end
            else
              if d.itemtype == ItemTypeEnum.BASEITEM then
                item = (Item.Create)(d.id)
                item:InitWithItemInfo(d)
              else
                LogErrorFormat("AprilFoolsGottenSecondConfirmDialog", "wrong itemtype %s ItemInfo.id %s", d.itemtype, d.id)
              end
            end
            if item then
              (table.insert)(self._itemList, {item = item, num = d.number})
            else
              LogErrorFormat("AprilFoolsGottenSecondConfirmDialog", "ItemInfo.id %s is wrong", d.id)
            end
          end
          ;
          (self._itemFrame):ReloadAllCell()
          local totalLength = (self._itemFrame):GetTotalLength()
          ;
          (self._panel):SetAnchorAndOffset(0.5, self._panelAnchorMinY, 0.5, self._panelAnchorMaxY, -totalLength / 2, self._panelOffsetMinY, totalLength / 2, self._panelOffsetMaxY)
          ;
          (self._itemFrame):ReloadAllCell()
        else
          do
            do
              if typeNum == (self.ShowDialogType).DungeonUnlock then
                (self._panel):SetActive(false)
                ;
                (self._charImg):SetActive(false)
                ;
                (self._name):SetActive(false)
                ;
                (self._dungeonBattleBtnImg):SetActive(true)
                ;
                (self._shopBtnImg):SetActive(false)
                ;
                (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1834)).msgTextID))
              else
                if typeNum == (self.ShowDialogType).ShopUnlock then
                  (self._panel):SetActive(false)
                  ;
                  (self._charImg):SetActive(false)
                  ;
                  (self._name):SetActive(false)
                  ;
                  (self._dungeonBattleBtnImg):SetActive(false)
                  ;
                  (self._shopBtnImg):SetActive(true)
                  ;
                  (self._title):SetText((TextManager.GetText)((CStringRes:GetRecorder(1835)).msgTextID))
                end
              end
              ;
              (table.remove)(self._showingList, 1)
              do return true end
              do return false end
            end
          end
        end
      end
    end
  end
end

AprilFoolsGottenSecondConfirmDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_5
  if not self:ShowNext() then
    self:Destroy()
  end
end

AprilFoolsGottenSecondConfirmDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_6 , upvalues : _ENV, UIManager
  local dialog = (DialogManager.GetDialog)("bag.itemtipsdialog")
  if not (UIManager.RectangleContainsScreenPoint)((self._panel)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and not dialog then
    self:OnConfirmBtnClicked()
  end
end

AprilFoolsGottenSecondConfirmDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemList
end

AprilFoolsGottenSecondConfirmDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.aprilfoolsday.aprilfoolsgottensecondconfirmitemcell"
end

AprilFoolsGottenSecondConfirmDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemList)[index]
end

return AprilFoolsGottenSecondConfirmDialog

