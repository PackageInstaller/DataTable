local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ResourceDungeonAccountDialog = class("ResourceDungeonAccountDialog", Dialog)
ResourceDungeonAccountDialog.AssetBundleName = "ui/layouts.mainline"
ResourceDungeonAccountDialog.AssetName = "ResourceDungeonFinish"

function ResourceDungeonAccountDialog:Ctor(...)
  ResourceDungeonAccountDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._tag = nil
  self._pageIndex = nil
  self._itemAccount = {}
  self._items = {}
end

function ResourceDungeonAccountDialog:OnCreate()
  self._cellPanel = self:GetChild("Frame/CellPanel")
  self._frame = self:GetChild("Frame")
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCloseResourceDungeonAccountDialog, self)
  self._initialAnchorX, self._initialOffsetX = self._cellPanel:GetWidth()
  self._initialAnchorMinX, self._initialOffsetMinX = self._cellPanel:GetXPosition()
  EffectFactory.CreateFreezeEffect():Run()
  self._timer = GameTimer.AddTask(1, 0, function()
    self._timer = nil
    self:OnCloseResourceDungeonAccountDialog()
  end)
end

function ResourceDungeonAccountDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._helper then
    self._helper:Destroy()
  end
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  if self._timer then
    self._timer = GameTimer.RemoveTask(self._timer)
  end
  EffectFactory.CreateThawEffect():Run()
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
end

function ResourceDungeonAccountDialog:ChangeCellPosition()
  local width = self._helper:GetTotalLength()
  self._cellPanel:SetWidth(0, width)
  self._helper:ReloadAllCell()
end

function ResourceDungeonAccountDialog:SetData(id, iteminfos)
  local recorder = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage"):GetRecorder(id)
  self._items = {}
  for _, i in ipairs(recorder.firstItems) do
    local item = Item.Create(i)
    local _, info = table.first(iteminfos, function(_, v)
      return v.id == i
    end)
    if info then
      if info.gain == 1 then
        if info.itemtype == ItemTypeEnum.BASEITEM then
          item = NekoData.BehaviorManager.BM_BagInfo:GetItem(info.id)
        elseif info.itemtype == ItemTypeEnum.EQUIP then
          item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(info.id)
        end
      else
        if info.itemtype == ItemTypeEnum.BASEITEM then
          item = Item.Create(info.id)
        elseif info.itemtype == ItemTypeEnum.EQUIP then
          item = Equip.Create(info.id)
        elseif info.itemtype == ItemTypeEnum.SKILL then
          item = Skill.Create(info.id)
        end
        item:InitWithItemInfo(info)
      end
      self._items[#self._items + 1] = {got = true, item = item}
    else
      self._items[#self._items + 1] = {got = false, item = item}
    end
  end
  self._helper = TableFrame.Create(self._cellPanel, self, false, false)
  self._helper:ReloadAllCell()
  self:ChangeCellPosition()
end

function ResourceDungeonAccountDialog:OnGlobalPointerDown(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._helper:FireEvent("SetItemSelectedState", nil)
  end
end

function ResourceDungeonAccountDialog:NumberOfCell(frame)
  return #self._items
end

function ResourceDungeonAccountDialog:CellAtIndex(frame)
  return "dungeon.resourcedungeonaccountcell"
end

function ResourceDungeonAccountDialog:DataAtIndex(frame, index)
  return self._items[index]
end

function ResourceDungeonAccountDialog:SetSelectedID(notification)
  self._selectedID = notification
  self._helper:FireEvent("SetItemSelectedState", self._selectedID)
end

function ResourceDungeonAccountDialog:SetNotSelect()
  self._selectedID = nil
  self._helper:FireEvent("SetItemSelectedState", self._selectedID)
end

function ResourceDungeonAccountDialog:OnSet()
  if #self._items <= 5 then
    self:OnCloseResourceDungeonAccountDialog()
  end
end

function ResourceDungeonAccountDialog:OnCloseResourceDungeonAccountDialog()
  DialogManager.DestroySingletonDialog("bag.ResourceDungeonAccountDialog")
  NekoData.DataManager.DM_Game:SetStandAloneMode()
  DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller.HideUI then
    controller:HideUI()
  end
  self:Destroy()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
  csend:Send()
end

return ResourceDungeonAccountDialog
