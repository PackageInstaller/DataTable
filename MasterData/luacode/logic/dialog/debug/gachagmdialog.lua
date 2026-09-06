local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local GachaGMDialog = class("GachaGMDialog", Dialog)
GachaGMDialog.AssetBundleName = "ui/layouts.gm"
GachaGMDialog.AssetName = "GachaGM"

function GachaGMDialog:Ctor(...)
  GachaGMDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function GachaGMDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, true, true, true)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function GachaGMDialog:OnDestroy()
  self._frame:Destroy()
end

function GachaGMDialog:SetData(protocol)
  self._data = {}
  local urList = {rate = 0, num = 0}
  local ssrList = {rate = 0, num = 0}
  local srList = {rate = 0, num = 0}
  local rList = {rate = 0, num = 0}
  local roleList = {}
  local itemList = {}
  local isEquipPool = false
  for roleItemId, rate in pairs(protocol.roleResult) do
    local roleItemRecord = CRoleItemTable:GetRecorder(roleItemId)
    if roleItemRecord then
      local roleId = roleItemRecord.roleid
      local role = Role.Create(roleId)
      if not roleList[roleId] then
        roleList[roleId] = {rate = 0, num = 0}
        roleList[roleId].role = role
      end
      roleList[roleId].rate = roleList[roleId].rate + rate
      if role:GetRarityId() == 1 then
        rList.rate = rList.rate + rate
      elseif role:GetRarityId() == 2 then
        srList.rate = srList.rate + rate
      elseif role:GetRarityId() == 3 then
        ssrList.rate = ssrList.rate + rate
      elseif role:GetRarityId() == 4 then
        urList.rate = urList.rate + rate
      end
    else
      isEquipPool = true
      local item = Item.Create(roleItemId)
      if not itemList[roleItemId] then
        itemList[roleItemId] = {rate = 0, num = 0}
        itemList[roleItemId].item = item
      end
      itemList[roleItemId].rate = itemList[roleItemId].rate + rate
      if item:IsUniqueEquip() then
        urList.rate = urList.rate + rate
      elseif item:GetPinJiID() == 5 then
        ssrList.rate = ssrList.rate + rate
      elseif item:GetPinJiID() == 3 and 40000 < roleItemId and roleItemId < 50000 then
        srList.rate = srList.rate + rate
      else
        rList.rate = rList.rate + rate
      end
    end
  end
  for roleItemId, num in pairs(protocol.roleNums) do
    local roleItemRecord = CRoleItemTable:GetRecorder(roleItemId)
    if roleItemRecord then
      local roleId = roleItemRecord.roleid
      local role = Role.Create(roleId)
      if not roleList[roleId] then
        roleList[roleId] = {rate = 0, num = 0}
        roleList[roleId].role = role
      end
      roleList[roleId].num = roleList[roleId].num + num
      if role:GetRarityId() == 1 then
        rList.num = rList.num + num
      elseif role:GetRarityId() == 2 then
        srList.num = srList.num + num
      elseif role:GetRarityId() == 3 then
        ssrList.num = ssrList.num + num
      elseif role:GetRarityId() == 4 then
        urList.num = urList.num + num
      end
    else
      isEquipPool = true
      local item = Item.Create(roleItemId)
      if not itemList[roleItemId] then
        itemList[roleItemId] = {rate = 0, num = 0}
        itemList[roleItemId].item = item
      end
      itemList[roleItemId].num = itemList[roleItemId].num + num
      if item:IsUniqueEquip() then
        urList.num = urList.num + num
      elseif item:GetPinJiID() == 5 then
        ssrList.num = ssrList.num + num
      elseif item:GetPinJiID() == 3 and 40000 < roleItemId and roleItemId < 50000 then
        srList.num = srList.num + num
      else
        rList.num = rList.num + num
      end
    end
  end
  if not isEquipPool then
    for _, v in pairs(roleList) do
      table.insert(self._data, {
        title = v.role:GetRoleName(),
        num = v.num,
        rate = v.rate,
        role = v.role
      })
    end
    table.sort(self._data, function(a, b)
      local aRarity = a.role:GetRarityId()
      local bRarity = b.role:GetRarityId()
      if aRarity > bRarity then
        return true
      elseif aRarity < bRarity then
        return false
      elseif aRarity == bRarity then
        if a.role:GetRoleId() < b.role:GetRoleId() then
          return true
        else
          return false
        end
      end
    end)
    table.insert(self._data, 1, {
      title = "R",
      num = rList.num,
      rate = rList.rate
    })
    table.insert(self._data, 1, {
      title = "SR",
      num = srList.num,
      rate = srList.rate
    })
    table.insert(self._data, 1, {
      title = "SSR",
      num = ssrList.num,
      rate = ssrList.rate
    })
    table.insert(self._data, 1, {
      title = "UR",
      num = urList.num,
      rate = urList.rate
    })
  else
    table.insert(self._data, {
      title = "专属装备",
      num = urList.num,
      rate = urList.rate
    })
    table.insert(self._data, {
      title = "传奇装备",
      num = ssrList.num,
      rate = ssrList.rate
    })
    table.insert(self._data, {
      title = "金装备",
      num = srList.num,
      rate = srList.rate
    })
    table.insert(self._data, {
      title = "材料",
      num = rList.num,
      rate = rList.rate
    })
    for _, v in pairs(itemList) do
      table.insert(self._data, {
        title = v.item:GetName(),
        num = v.num,
        rate = v.rate,
        item = v.item
      })
    end
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GachaGMDialog:NumberOfCell(frame)
  return #self._data
end

function GachaGMDialog:CellAtIndex(frame, index)
  return "debug.gachagmcell"
end

function GachaGMDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function GachaGMDialog:OnGlobalPointerDown(notification)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, notification.userInfo.eventData.position.x, notification.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function GachaGMDialog:OnBackBtnClicked()
  self:Destroy()
end

return GachaGMDialog
