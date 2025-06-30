-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/charfashioncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
local CharFashionCell = class("CharFashionCell", Dialog)
CharFashionCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharFashionCell.AssetName = "CharClothesCell"
CharFashionCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharFashionCell
  ((CharFashionCell.super).Ctor)(self, ...)
  self._choose = false
end

CharFashionCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Back/Char")
  self._current = self:GetChild("Back/Current")
  self._gray = self:GetChild("Back/Grey")
  self._grayTxt = self:GetChild("Back/Grey/Back/Txt")
  self._live = self:GetChild("Back/Live2d")
  self._select = self:GetChild("Back/Select")
  self._redDot = self:GetChild("Back/RedDot")
  self._name = self:GetChild("Back/Name")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

CharFashionCell.OnDestroy = function(self)
  -- function num : 0_2
end

local RefreshRedDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._redDot):SetActive(((NekoData.BehaviorManager).BM_RedPoint):GetRedPointNum(8, {(self._data).roleId, (self._data).skinID}) > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CharFashionCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : RoleSkin, _ENV, RefreshRedDot
  self._data = data
  self._skin = (RoleSkin.Create)(data.skinID)
  local imgRecord = (self._skin):GetBigBustImg()
  ;
  (self._img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(data.roleId)
  local curWearFashionId = role:GetDefaultFashion()
  local isWearing = curWearFashionId == data.skinID
  ;
  (self._name):SetText((self._skin):GetSkinName())
  ;
  (self._current):SetActive(isWearing)
  ;
  (self._gray):SetActive((not data.hasGotten and not isWearing))
  ;
  (self._grayTxt):SetText((self._skin):GetGetWayText())
  ;
  (self._live):SetActive((self._skin):IsShowLiveText())
  ;
  (self._select):SetActive((self._data).index == (self._delegate)._curSelectIdx)
  self._choose = (self._delegate)._curSelectIdx == (self._data).index
  RefreshRedDot(self)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

CharFashionCell.OnCellClick = function(self, args)
  -- function num : 0_5
  if self._choose then
    return 
  end
  ;
  (self._delegate):UpdateLive2D(self._data)
end

CharFashionCell.OnEvent = function(self, eventName, index)
  -- function num : 0_6 , upvalues : RefreshRedDot
  if index ~= (self._data).index then
    (self._select):SetActive(eventName ~= "select")
    self._choose = index == (self._data).index
    if eventName == "RefreshRedDot" then
      RefreshRedDot(self)
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

return CharFashionCell

