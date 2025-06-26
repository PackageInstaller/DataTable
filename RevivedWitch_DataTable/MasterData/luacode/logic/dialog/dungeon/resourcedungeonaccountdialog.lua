-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/resourcedungeonaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ResourceDungeonAccountDialog = class("ResourceDungeonAccountDialog", Dialog)
ResourceDungeonAccountDialog.AssetBundleName = "ui/layouts.mainline"
ResourceDungeonAccountDialog.AssetName = "ResourceDungeonFinish"
ResourceDungeonAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResourceDungeonAccountDialog
  ((ResourceDungeonAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._tag = nil
  self._pageIndex = nil
  self._itemAccount = {}
  self._items = {}
end

ResourceDungeonAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cellPanel = self:GetChild("Frame/CellPanel")
  self._frame = self:GetChild("Frame")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCloseResourceDungeonAccountDialog, self)
  self._initialAnchorX = (self._cellPanel):GetWidth()
  self._initialAnchorMinX = (self._cellPanel):GetXPosition()
  ;
  ((EffectFactory.CreateFreezeEffect)()):Run()
  self._timer = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_1_0 , upvalues : self
    self._timer = nil
    self:OnCloseResourceDungeonAccountDialog()
  end
)
end

ResourceDungeonAccountDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._helper then
    (self._helper):Destroy()
  end
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
  if self._timer then
    self._timer = (GameTimer.RemoveTask)(self._timer)
  end
  ;
  ((EffectFactory.CreateThawEffect)()):Run()
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
end

ResourceDungeonAccountDialog.ChangeCellPosition = function(self)
  -- function num : 0_3
  local width = (self._helper):GetTotalLength()
  ;
  (self._cellPanel):SetWidth(0, width)
  ;
  (self._helper):ReloadAllCell()
end

ResourceDungeonAccountDialog.SetData = function(self, id, iteminfos)
  -- function num : 0_4 , upvalues : _ENV, Item, ItemTypeEnum, Equip, Skill, TableFrame
  local recorder = ((BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")):GetRecorder(id)
  self._items = {}
  for _,i in ipairs(recorder.firstItems) do
    do
      local item = (Item.Create)(i)
      local _, info = (table.first)(iteminfos, function(_, v)
    -- function num : 0_4_0 , upvalues : i
    do return v.id == i end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      if info then
        if info.gain == 1 then
          if info.itemtype == ItemTypeEnum.BASEITEM then
            item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(info.id)
          else
            if info.itemtype == ItemTypeEnum.EQUIP then
              item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(info.id)
            end
          end
        else
          if info.itemtype == ItemTypeEnum.BASEITEM then
            item = (Item.Create)(info.id)
          else
            if info.itemtype == ItemTypeEnum.EQUIP then
              item = (Equip.Create)(info.id)
            else
              if info.itemtype == ItemTypeEnum.SKILL then
                item = (Skill.Create)(info.id)
              end
            end
          end
          item:InitWithItemInfo(info)
        end
        -- DECOMPILER ERROR at PC86: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self._items)[#self._items + 1] = {got = true, item = item}
      else
        -- DECOMPILER ERROR at PC95: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self._items)[#self._items + 1] = {got = false, item = item}
      end
    end
  end
  self._helper = (TableFrame.Create)(self._cellPanel, self, false, false)
  ;
  (self._helper):ReloadAllCell()
  self:ChangeCellPosition()
end

ResourceDungeonAccountDialog.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_5
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._helper):FireEvent("SetItemSelectedState", nil)
  end
end

ResourceDungeonAccountDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._items
end

ResourceDungeonAccountDialog.CellAtIndex = function(self, frame)
  -- function num : 0_7
  return "dungeon.resourcedungeonaccountcell"
end

ResourceDungeonAccountDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._items)[index]
end

ResourceDungeonAccountDialog.SetSelectedID = function(self, notification)
  -- function num : 0_9
  self._selectedID = notification
  ;
  (self._helper):FireEvent("SetItemSelectedState", self._selectedID)
end

ResourceDungeonAccountDialog.SetNotSelect = function(self)
  -- function num : 0_10
  self._selectedID = nil
  ;
  (self._helper):FireEvent("SetItemSelectedState", self._selectedID)
end

ResourceDungeonAccountDialog.OnSet = function(self)
  -- function num : 0_11
  if #self._items <= 5 then
    self:OnCloseResourceDungeonAccountDialog()
  end
end

ResourceDungeonAccountDialog.OnCloseResourceDungeonAccountDialog = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("bag.ResourceDungeonAccountDialog")
  ;
  ((NekoData.DataManager).DM_Game):SetStandAloneMode()
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller.HideUI then
    controller:HideUI()
  end
  self:Destroy()
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
  csend:Send()
end

return ResourceDungeonAccountDialog

