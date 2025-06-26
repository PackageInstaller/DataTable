-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/signboard/signboardcharfashioncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
local SignboardCharFashionCell = class("SignboardCharFashionCell", Dialog)
SignboardCharFashionCell.AssetBundleName = "ui/layouts.signboard"
SignboardCharFashionCell.AssetName = "SignboardClothesCell"
SignboardCharFashionCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SignboardCharFashionCell
  ((SignboardCharFashionCell.super).Ctor)(self, ...)
  self._choose = false
end

SignboardCharFashionCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Back/Char")
  self._current = self:GetChild("Back/Current")
  self._live = self:GetChild("Back/Live2d")
  self._select = self:GetChild("Back/Select")
  self._name = self:GetChild("Back/Name")
  self._downBlack = self:GetChild("Back/DownBlack")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SignboardCharFashionCell.OnDestroy = function(self)
  -- function num : 0_2
end

SignboardCharFashionCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, RoleSkin
  self._data = data
  if data.isAlinna then
    if not CImagePathTable:GetRecorder((data.data).bigbustID) then
      local record = DataCommon.DefaultImageAsset
    end
    ;
    (self._img):SetSprite(record.assetBundle, record.assetName)
    local currentRole = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).backgroundRole
    local isWearing = currentRole == 0
    self._choose = isWearing
    ;
    (self._current):SetActive(isWearing)
    ;
    (self._select):SetActive(isWearing)
    ;
    (self._name):SetActive(false)
    ;
    (self._downBlack):SetActive(false)
    ;
    (self._live):SetActive(false)
  else
    local roleSkin = (RoleSkin.Create)(data.skinID)
    local imgRecord = roleSkin:GetBigBustImg()
    ;
    (self._img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    ;
    (self._name):SetText(roleSkin:GetSkinName())
    local curWearFashionId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).backgroundSkin
    local isWearing = curWearFashionId == data.skinID
    self._choose = isWearing
    ;
    (self._current):SetActive(isWearing)
    ;
    (self._select):SetActive(isWearing)
    ;
    (self._downBlack):SetActive(true)
    ;
    (self._live):SetActive(roleSkin:IsShowLiveText())
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

SignboardCharFashionCell.OnCellClick = function(self, args)
  -- function num : 0_4
  if self._choose then
    return 
  end
  ;
  (self._delegate):OnFashionCellClick(self._data)
end

return SignboardCharFashionCell

