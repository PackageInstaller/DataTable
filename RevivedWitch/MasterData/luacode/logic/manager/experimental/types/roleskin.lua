-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/roleskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local RoleSkin = strictclass("RoleSkin")
RoleSkin.Ctor = function(self, skinId)
  -- function num : 0_0 , upvalues : CSkin, _ENV, CNpcShapeTable
  self._skinId = skinId
  self._skinRecorder = CSkin:GetRecorder(skinId)
  if not self._skinRecorder then
    LogErrorFormat("RoleSkin", "recorder with id %s is not exist in cskin", skinId)
  end
  self._shapeRecord = CNpcShapeTable:GetRecorder((self._skinRecorder).shapeID)
  if not self._shapeRecord then
    LogErrorFormat("RoleSkin", "recorder with id %s is not exist in cnpcshape", (self._skinRecorder).shapeID)
  end
end

RoleSkin.GetSkinId = function(self)
  -- function num : 0_1
  return self._skinId
end

RoleSkin.GetBigBustImg = function(self)
  -- function num : 0_2 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).bigbustID) then
    return DataCommon.DefaultImageAsset
  end
end

RoleSkin.GetRoleIdBySkin = function(self)
  -- function num : 0_3
  return (self._skinRecorder).roleid
end

RoleSkin.GetYearBySkin = function(self)
  -- function num : 0_4
  return (self._skinRecorder).year
end

RoleSkin.GetSkinName = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (TextManager.GetText)((self._skinRecorder).skinNameTextID)
end

RoleSkin.GetGetWayText = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self._skinRecorder).getwayID ~= 0 then
    return (TextManager.GetText)((self._skinRecorder).getwayID)
  end
end

RoleSkin.IsShowLiveText = function(self)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC27: Unhandled construct in 'MakeBoolean' P1

  if (Live2DManager.CanUse)() and (self._shapeRecord).live2DAssetBundleName and ((self._shapeRecord).live2DAssetBundleName == "" or (self._shapeRecord).live2DPrefabName and (self._shapeRecord).live2DPrefabName == "") then
    do return (self._skinRecorder).ifLive ~= 1 end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

return RoleSkin

