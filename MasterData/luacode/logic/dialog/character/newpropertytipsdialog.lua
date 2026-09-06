local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local UIManager = CS.PixelNeko.UI.UIManager
local NewPropertyTipsDialog = class("NewPropertyTipsDialog", Dialog)
NewPropertyTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewPropertyTipsDialog.AssetName = "PropDetail"

function NewPropertyTipsDialog:Ctor(...)
  NewPropertyTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function NewPropertyTipsDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = GridFrame.Create(self._field, self, true, 2, false)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._backx, self._backox, self._backy, self._backoy = self._back:GetPosition()
  self._backRectX, self._backRectY = self._back:GetRectSize()
  self._frameRectX, self._frameRectY = self._field:GetRectSize()
end

function NewPropertyTipsDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._callbackFunc then
    self._callbackFunc()
  end
end

function NewPropertyTipsDialog:SetDestroyCallBack(callbackFunc)
  self._callbackFunc = callbackFunc
end

function NewPropertyTipsDialog:Init(data, delegate, isOtherUser)
  self._data = {}
  if isOtherUser then
    local roleIdData = Role.Create(data.id)
    local proData = clone(data.properties)
    for k, v in pairs(proData) do
      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        proData[k] = nil
      end
    end
    local properties = {}
    for k, v in pairs(proData) do
      if k ~= 10 then
        properties[k] = v
      end
    end
    for k, v in pairs(properties) do
      local temp = {}
      temp.attrId = k
      temp.value = v
      if roleIdData:GetDamageType() ~= 1 and k == AttrTypeEnum.ATTACK then
        temp.attrId = AttrTypeEnum.MAGIC_ATTACK
      end
      table.insert(self._data, temp)
    end
  else
    for k, v in pairs(data:GetProperties()) do
      local temp = {}
      temp.attrId = k
      temp.value = v
      if data:GetDamageType() ~= 1 and k == AttrTypeEnum.ATTACK then
        temp.attrId = AttrTypeEnum.MAGIC_ATTACK
      end
      table.insert(self._data, temp)
    end
  end
  table.sort(self._data, function(a, b)
    return a.attrId < b.attrId
  end)
  self._frame:ReloadAllCell()
  local delta = self._frame:GetTotalLength() - self._frameRectY
  if 0 < delta then
    self._back:SetHeight(0, self._backRectY + delta)
    self._back:SetPosition(self._backx, self._backox, self._backy, self._backoy - delta)
  end
end

function NewPropertyTipsDialog:NumberOfCell(frame, index)
  return #self._data
end

function NewPropertyTipsDialog:CellAtIndex(frame, index)
  return "character.newpropertytipscell"
end

function NewPropertyTipsDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function NewPropertyTipsDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function NewPropertyTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

return NewPropertyTipsDialog
