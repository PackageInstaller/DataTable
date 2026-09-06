local CSkin = BeanManager.GetTableByName("role.cskin")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local RoleSkin = strictclass("RoleSkin")

function RoleSkin:Ctor(skinId)
  self._skinId = skinId
  self._skinRecorder = CSkin:GetRecorder(skinId)
  if not self._skinRecorder then
    LogErrorFormat("RoleSkin", "recorder with id %s is not exist in cskin", skinId)
  end
  self._shapeRecord = CNpcShapeTable:GetRecorder(self._skinRecorder.shapeID)
  if not self._shapeRecord then
    LogErrorFormat("RoleSkin", "recorder with id %s is not exist in cnpcshape", self._skinRecorder.shapeID)
  end
end

function RoleSkin:GetSkinId()
  return self._skinId
end

function RoleSkin:GetBigBustImg()
  return CImagePathTable:GetRecorder(self._shapeRecord.bigbustID) or DataCommon.DefaultImageAsset
end

function RoleSkin:GetRoleIdBySkin()
  return self._skinRecorder.roleid
end

function RoleSkin:GetYearBySkin()
  return self._skinRecorder.year
end

function RoleSkin:GetSkinName()
  return TextManager.GetText(self._skinRecorder.skinNameTextID)
end

function RoleSkin:GetGetWayText()
  if self._skinRecorder.getwayID ~= 0 then
    return TextManager.GetText(self._skinRecorder.getwayID)
  end
end

function RoleSkin:IsShowLiveText()
  if self._skinRecorder.ifLive == 1 then
    return Live2DManager.CanUse() and self._shapeRecord.live2DAssetBundleName and self._shapeRecord.live2DAssetBundleName ~= "" and self._shapeRecord.live2DPrefabName and self._shapeRecord.live2DPrefabName ~= ""
  end
end

return RoleSkin
