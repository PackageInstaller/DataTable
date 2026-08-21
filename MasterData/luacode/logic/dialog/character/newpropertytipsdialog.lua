-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newpropertytipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local UIManager = ((CS.PixelNeko).UI).UIManager
local NewPropertyTipsDialog = class("NewPropertyTipsDialog", Dialog)
NewPropertyTipsDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewPropertyTipsDialog.AssetName = "PropDetail"
NewPropertyTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewPropertyTipsDialog
  ((NewPropertyTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

NewPropertyTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._back = self:GetChild("Back")
  self._field = self:GetChild("Frame")
  self._frame = (GridFrame.Create)(self._field, self, true, 2, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._backx = (self._back):GetPosition()
  self._backRectX = (self._back):GetRectSize()
  self._frameRectX = (self._field):GetRectSize()
end

NewPropertyTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._callbackFunc then
    (self._callbackFunc)()
  end
end

NewPropertyTipsDialog.SetDestroyCallBack = function(self, callbackFunc)
  -- function num : 0_3
  self._callbackFunc = callbackFunc
end

NewPropertyTipsDialog.Init = function(self, data, delegate, isOtherUser)
  -- function num : 0_4 , upvalues : Role, _ENV, AttrTypeEnum
  self._data = {}
  if isOtherUser then
    local roleIdData = (Role.Create)(data.id)
    local proData = clone(data.properties)
    for k,v in pairs(proData) do
      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        proData[k] = nil
      end
    end
    local properties = {}
    for k,v in pairs(proData) do
      if k ~= 10 then
        properties[k] = v
      end
    end
    for k,v in pairs(properties) do
      local temp = {}
      temp.attrId = k
      temp.value = v
      if roleIdData:GetDamageType() ~= 1 and k == AttrTypeEnum.ATTACK then
        temp.attrId = AttrTypeEnum.MAGIC_ATTACK
      end
      ;
      (table.insert)(self._data, temp)
    end
  else
    do
      for k,v in pairs(data:GetProperties()) do
        local temp = {}
        temp.attrId = k
        temp.value = v
        if data:GetDamageType() ~= 1 and k == AttrTypeEnum.ATTACK then
          temp.attrId = AttrTypeEnum.MAGIC_ATTACK
        end
        ;
        (table.insert)(self._data, temp)
      end
      do
        ;
        (table.sort)(self._data, function(a, b)
    -- function num : 0_4_0
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        ;
        (self._frame):ReloadAllCell()
        local delta = (self._frame):GetTotalLength() - self._frameRectY
        if delta > 0 then
          (self._back):SetHeight(0, self._backRectY + delta)
          ;
          (self._back):SetPosition(self._backx, self._backox, self._backy, self._backoy - delta)
        end
      end
    end
  end
end

NewPropertyTipsDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_5
  return #self._data
end

NewPropertyTipsDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "character.newpropertytipscell"
end

NewPropertyTipsDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

NewPropertyTipsDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

NewPropertyTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

return NewPropertyTipsDialog

