local MainLineTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CSpirit = BeanManager.GetTableByName("dungeonselect.cdungeonselectstrength")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local MainLineFloorDialog = class("MainLineFloorDialog", Dialog)
MainLineFloorDialog.AssetBundleName = "ui/layouts.mainline"
MainLineFloorDialog.AssetName = "MainLineFloor"
local limit

function MainLineFloorDialog:Ctor(...)
  MainLineFloorDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._spirit = nil
  self._floorData = {}
  self._itemData = {}
  self._firstItemData = {}
  self._floorDetail = {}
  self._selectRequestSpirit = 0
  self._goGuideEffectHandler = nil
end

function MainLineFloorDialog:OnCreate()
  limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
  self._goBtn = self:GetChild("GoBtn")
  self._goGuideEffect = self:GetChild("GoBtn/Effect")
  self._vitPanel = self:GetChild("TopGroup/VIT")
  self._vitNum = self:GetChild("TopGroup/VIT/Text")
  self._addVIT = self:GetChild("TopGroup/VIT/Add")
  self._floorName = self:GetChild("RightPanel/ChapterName")
  self._exploreProgress = self:GetChild("RightPanel/Detail1/Txt2")
  self._recommendCapacity = self:GetChild("RightPanel/Detail2/Txt2")
  self._description = self:GetChild("RightPanel/Detail3/Txt")
  self._power = self:GetChild("Txt2")
  self._powerRed = self:GetChild("Txt2Red")
  self._itemPanel = self:GetChild("RightPanel/CellPanel")
  self._firstItemPanel = self:GetChild("RightPanel/CellPanel2")
  self._leftArrow = self:GetChild("RightPanel/LeftArrow")
  self._rightArrow = self:GetChild("RightPanel/RightArrow")
  self._floorPanel = self:GetChild("LeftPanel")
  self._floorFrame = TableFrame.Create(self._floorPanel, self, true, true, true)
  self._floorFrame:SetMargin(20, 0)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  self._vitPanel:Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._vitNum:SetText(tostring(self._spirit) .. "/" .. tostring(limit))
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(4)
end

function MainLineFloorDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  LuaNotificationCenter.RemoveObserver(self)
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
  if self._firstItemFrame then
    self._firstItemFrame:Destroy()
  end
  self._floorFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("bag.spiritrecoverdialog")
  DialogManager.DestroySingletonDialog("teamedit.teameditprewardialog")
end

function MainLineFloorDialog:SetData(data)
  self._floorData = {}
  local curZone
  for _, v in ipairs(data) do
    local oneline = MainLineTable:GetRecorder(v.id)
    curZone = v.curZone
    if oneline then
      local temp = {}
      temp.id = oneline.id
      temp.spirit = v.spirit
      temp.items = v.items
      temp.firstItem = v.firstItem
      temp.firstGet = v.firstGet
      temp.img = oneline.sceneimage
      temp.floor = oneline.floor
      temp.name = TextManager.GetText(oneline.nameTextID)
      table.insert(self._floorData, temp)
    end
  end
  self._floorFrame:ReloadAllCell()
  if #self._floorData ~= 0 then
    self._floorFrame:MoveTopToIndex(1)
  end
  for i, v in ipairs(self._floorData) do
    if curZone == v.id then
      self._select = v
      if #self._floorData ~= 0 then
        self._floorFrame:MoveTopToIndex(i)
      end
    end
  end
  if self._select then
    self:OnCellClicked(self._select)
  else
    LogWarning("MainLineFloorDialog", "there is no current floor")
  end
end

function MainLineFloorDialog:GetSelectedId()
  if self._select then
    return self._select.id
  else
    return 0
  end
end

function MainLineFloorDialog:CellAtIndex(frame, index)
  if frame == self._floorFrame then
    return "mainline.mainline.mainlineselectcell"
  elseif frame == self._itemFrame then
    if self._itemData[index]:GetItemType() == ItemTypeEnum.BASEITEM then
      return "mainline.mainline.mainlineflooritemcell"
    elseif self._itemData[index]:GetItemType() == ItemTypeEnum.EQUIP then
      return "mainline.mainline.mainlinefloorequipcell"
    end
  elseif frame == self._firstItemFrame then
    if self._firstItemData[index].item:GetItemType() == ItemTypeEnum.BASEITEM then
      return "mainline.mainline.mainlineflooritemcell"
    elseif self._firstItemData[index].item:GetItemType() == ItemTypeEnum.EQUIP then
      return "mainline.mainline.mainlinefloorequipcell"
    end
  end
end

function MainLineFloorDialog:DataAtIndex(frame, index)
  if frame == self._floorFrame then
    return self._floorData[index]
  elseif frame == self._itemFrame then
    return self._itemData[index]
  elseif frame == self._firstItemFrame then
    return self._firstItemData[index]
  end
end

function MainLineFloorDialog:NumberOfCell(frame)
  if frame == self._floorFrame then
    return #self._floorData
  elseif frame == self._itemFrame then
    return #self._itemData
  elseif frame == self._firstItemFrame then
    return #self._firstItemData
  end
end

function MainLineFloorDialog:SetFloorFrameSelectedID(args)
  self._selectedID = args
  self._floorFrame:FireEvent("SetFloorSelectedState", self._selectedID)
end

function MainLineFloorDialog:OnCellClicked(select)
  self._select = select
  self:SetFloorFrameSelectedID(select.id)
  for _, v in ipairs(self._floorData) do
    if select.id == v.id then
      local oneline = MainLineTable:GetRecorder(v.id)
      self._floorDetail.id = v.id
      self._floorDetail.spirit = v.spirit
      self._floorName:SetText(TextManager.GetText(oneline.nameTextID))
      self._recommendCapacity:SetText(oneline.magic)
      self._description:SetText(TextManager.GetText(oneline.describeTextID))
      self._selectRequestSpirit = v.spirit
      if v.spirit > self._spirit then
        self._power:SetActive(false)
        self._powerRed:SetActive(true)
      else
        self._power:SetActive(true)
        self._powerRed:SetActive(false)
      end
      self._power:SetText(v.spirit)
      self._powerRed:SetText(v.spirit)
      self._firstItemData = {}
      for _, w in ipairs(v.firstItem) do
        local item
        if w.gain == 1 then
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = NekoData.BehaviorManager.BM_BagInfo:GetItem(w.id)
          elseif w.itemtype == ItemTypeEnum.EQUIP then
            item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(w.id)
          end
        else
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = Item.Create(w.id)
          elseif w.itemtype == ItemTypeEnum.EQUIP then
            item = Equip.Create(w.id)
          elseif w.itemtype == ItemTypeEnum.SKILL then
            item = Skill.Create(w.id)
          end
          item:InitWithItemInfo(w)
        end
        local temp = {item = item, get = false}
        temp.get = v.firstGet
        table.insert(self._firstItemData, temp)
      end
      if self._firstItemFrame then
        self._firstItemFrame:Destroy()
        self._firstItemFrame = nil
      end
      self._firstItemFrame = TableFrame.Create(self._firstItemPanel, self, false, true, false)
      self._firstItemFrame:SetMargin(40, 40)
      self._firstItemFrame:ReloadAllCell()
      self._itemData = {}
      for _, w in ipairs(v.items) do
        local item
        if w.gain == 1 then
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = NekoData.BehaviorManager.BM_BagInfo:GetItem(w.id)
          elseif w.itemtype == ItemTypeEnum.EQUIP then
            item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(w.id)
          end
        else
          if w.itemtype == ItemTypeEnum.BASEITEM then
            item = Item.Create(w.id)
          elseif w.itemtype == ItemTypeEnum.EQUIP then
            item = Equip.Create(w.id)
          elseif w.itemtype == ItemTypeEnum.SKILL then
            item = Skill.Create(w.id)
          end
          item:InitWithItemInfo(w)
        end
        table.insert(self._itemData, item)
      end
      local equip = {}
      local item = {}
      for _, v in ipairs(self._itemData) do
        if v:GetItemType() == ItemTypeEnum.BASEITEM then
          table.insert(item, v)
        else
          table.insert(equip, v)
        end
      end
      table.sort(item, function(a, b)
        return a:GetPinJiID() > b:GetPinJiID()
      end)
      table.sort(equip, function(a, b)
        return a:GetPinJiID() > b:GetPinJiID()
      end)
      self._itemData = {}
      for _, v in ipairs(equip) do
        table.insert(self._itemData, v)
      end
      for _, v in ipairs(item) do
        table.insert(self._itemData, v)
      end
      if #self._itemData <= 4 then
        self._leftArrow:SetActive(false)
        self._rightArrow:SetActive(false)
      else
        self._leftArrow:SetActive(false)
        self._rightArrow:SetActive(true)
      end
      if self._itemFrame then
        self._itemFrame:Destroy()
        self._itemFrame = nil
      end
      self._itemFrame = TableFrame.Create(self._itemPanel, self, false, true, false)
      self._itemFrame:SetMargin(40, 40)
      self._itemFrame:ReloadAllCell()
      break
    end
  end
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(5, 3) then
    if select.id == 2 then
      if self._goGuideEffectHandler == nil then
        self._goGuideEffectHandler = NekoData.BehaviorManager.BM_Guide:CreateGuide(self._goGuideEffect)
      end
    else
      NekoData.BehaviorManager.BM_Guide:DestroyGuide(self._goGuideEffect, self._goGuideEffectHandler)
      self._goGuideEffectHandler = nil
    end
  end
end

function MainLineFloorDialog:OnGoBtnClicked()
  if self._floorDetail.spirit > self._spirit then
    DialogManager.CreateSingletonDialog("bag.spiritrecoverdialog")
  else
    NekoData.DataManager.DM_Team:ClearSupportRole()
    NekoData.BehaviorManager.BM_Team:SaveTeamEditCopyInfo("MainLine", self:GetSelectedId())
    local crefreshSupportRoleList = LuaNetManager.CreateProtocol("protocol.chat.crefreshsupportrolelist")
    crefreshSupportRoleList:Send()
  end
end

function MainLineFloorDialog:OnLeftArrowClicked()
  local rightIndex = self._itemFrame:GetRightIndex()
  self._itemFrame:MoveRightToIndex(rightIndex - 1, true)
end

function MainLineFloorDialog:OnRightArrowClicked()
  local leftIndex = self._itemFrame:GetLeftIndex()
  self._itemFrame:MoveLeftToIndex(leftIndex + 1, true)
end

function MainLineFloorDialog:OnCurPosChange(frame, ratio)
  if frame == self._itemFrame then
    if ratio == 0 then
      self._leftArrow:SetActive(false)
    elseif ratio == 1 then
      self._rightArrow:SetActive(false)
    else
      self._leftArrow:SetActive(true)
      self._rightArrow:SetActive(true)
    end
  end
end

function MainLineFloorDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._vitNum:SetText(tostring(self._spirit) .. "/" .. tostring(limit))
  if self._selectRequestSpirit > self._spirit then
    self._power:SetActive(false)
    self._powerRed:SetActive(true)
  else
    self._power:SetActive(true)
    self._powerRed:SetActive(false)
  end
end

function MainLineFloorDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

function MainLineFloorDialog:GetFloorDetail()
  return self._floorDetail
end

function MainLineFloorDialog:OnAddVITBtnClicked()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

return MainLineFloorDialog
