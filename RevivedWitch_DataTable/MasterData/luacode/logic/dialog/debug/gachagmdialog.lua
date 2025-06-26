-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/gachagmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local GachaGMDialog = class("GachaGMDialog", Dialog)
GachaGMDialog.AssetBundleName = "ui/layouts.gm"
GachaGMDialog.AssetName = "GachaGM"
GachaGMDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaGMDialog
  ((GachaGMDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

GachaGMDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, true, true, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

GachaGMDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GachaGMDialog.SetData = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CRoleItemTable, Role, Item
  self._data = {}
  local urList = {rate = 0, num = 0}
  local ssrList = {rate = 0, num = 0}
  local srList = {rate = 0, num = 0}
  local rList = {rate = 0, num = 0}
  local roleList = {}
  local itemList = {}
  local isEquipPool = false
  for roleItemId,rate in pairs(protocol.roleResult) do
    local roleItemRecord = CRoleItemTable:GetRecorder(roleItemId)
    if roleItemRecord then
      local roleId = roleItemRecord.roleid
      local role = (Role.Create)(roleId)
      if not roleList[roleId] then
        roleList[roleId] = {rate = 0, num = 0}
        -- DECOMPILER ERROR at PC39: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (roleList[roleId]).role = role
      end
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R17 in 'UnsetPending'

      ;
      (roleList[roleId]).rate = (roleList[roleId]).rate + rate
      if role:GetRarityId() == 1 then
        rList.rate = rList.rate + rate
      else
        if role:GetRarityId() == 2 then
          srList.rate = srList.rate + rate
        else
          if role:GetRarityId() == 3 then
            ssrList.rate = ssrList.rate + rate
          else
            if role:GetRarityId() == 4 then
              urList.rate = urList.rate + rate
            end
          end
        end
      end
    else
      do
        isEquipPool = true
        do
          local item = (Item.Create)(roleItemId)
          if not itemList[roleItemId] then
            itemList[roleItemId] = {rate = 0, num = 0}
            -- DECOMPILER ERROR at PC89: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (itemList[roleItemId]).item = item
          end
          -- DECOMPILER ERROR at PC94: Confused about usage of register: R16 in 'UnsetPending'

          ;
          (itemList[roleItemId]).rate = (itemList[roleItemId]).rate + rate
          if item:IsUniqueEquip() then
            urList.rate = urList.rate + rate
          else
            if item:GetPinJiID() == 5 then
              ssrList.rate = ssrList.rate + rate
            else
              if item:GetPinJiID() == 3 and roleItemId > 40000 and roleItemId < 50000 then
                srList.rate = srList.rate + rate
              else
                rList.rate = rList.rate + rate
              end
            end
          end
          -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for roleItemId,num in pairs(protocol.roleNums) do
    local roleItemRecord = CRoleItemTable:GetRecorder(roleItemId)
    if roleItemRecord then
      local roleId = roleItemRecord.roleid
      local role = (Role.Create)(roleId)
      if not roleList[roleId] then
        roleList[roleId] = {rate = 0, num = 0}
        -- DECOMPILER ERROR at PC150: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (roleList[roleId]).role = role
      end
      -- DECOMPILER ERROR at PC155: Confused about usage of register: R17 in 'UnsetPending'

      ;
      (roleList[roleId]).num = (roleList[roleId]).num + num
      if role:GetRarityId() == 1 then
        rList.num = rList.num + num
      else
        if role:GetRarityId() == 2 then
          srList.num = srList.num + num
        else
          if role:GetRarityId() == 3 then
            ssrList.num = ssrList.num + num
          else
            if role:GetRarityId() == 4 then
              urList.num = urList.num + num
            end
          end
        end
      end
    else
      do
        isEquipPool = true
        do
          local item = (Item.Create)(roleItemId)
          if not itemList[roleItemId] then
            itemList[roleItemId] = {rate = 0, num = 0}
            -- DECOMPILER ERROR at PC200: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (itemList[roleItemId]).item = item
          end
          -- DECOMPILER ERROR at PC205: Confused about usage of register: R16 in 'UnsetPending'

          ;
          (itemList[roleItemId]).num = (itemList[roleItemId]).num + num
          if item:IsUniqueEquip() then
            urList.num = urList.num + num
          else
            if item:GetPinJiID() == 5 then
              ssrList.num = ssrList.num + num
            else
              if item:GetPinJiID() == 3 and roleItemId > 40000 and roleItemId < 50000 then
                srList.num = srList.num + num
              else
                rList.num = rList.num + num
              end
            end
          end
          -- DECOMPILER ERROR at PC237: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC237: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC237: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if not isEquipPool then
    for _,v in pairs(roleList) do
      (table.insert)(self._data, {title = (v.role):GetRoleName(), num = v.num, rate = v.rate, role = v.role})
    end
    ;
    (table.sort)(self._data, function(a, b)
    -- function num : 0_3_0
    local aRarity = (a.role):GetRarityId()
    local bRarity = (b.role):GetRarityId()
    if bRarity < aRarity then
      return true
    else
      if aRarity < bRarity then
        return false
      else
        if aRarity == bRarity then
          if (a.role):GetRoleId() < (b.role):GetRoleId() then
            return true
          else
            return false
          end
        end
      end
    end
  end
)
    ;
    (table.insert)(self._data, 1, {title = "R", num = rList.num, rate = rList.rate})
    ;
    (table.insert)(self._data, 1, {title = "SR", num = srList.num, rate = srList.rate})
    ;
    (table.insert)(self._data, 1, {title = "SSR", num = ssrList.num, rate = ssrList.rate})
    ;
    (table.insert)(self._data, 1, {title = "UR", num = urList.num, rate = urList.rate})
  else
    ;
    (table.insert)(self._data, {title = "专属装备", num = urList.num, rate = urList.rate})
    ;
    (table.insert)(self._data, {title = "传奇装备", num = ssrList.num, rate = ssrList.rate})
    ;
    (table.insert)(self._data, {title = "金装备", num = srList.num, rate = srList.rate})
    ;
    (table.insert)(self._data, {title = "材料", num = rList.num, rate = rList.rate})
    for _,v in pairs(itemList) do
      (table.insert)(self._data, {title = (v.item):GetName(), num = v.num, rate = v.rate, item = v.item})
    end
  end
  do
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

GachaGMDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GachaGMDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "debug.gachagmcell"
end

GachaGMDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

GachaGMDialog.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_7 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((notification.userInfo).eventData).position).x, (((notification.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

GachaGMDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return GachaGMDialog

