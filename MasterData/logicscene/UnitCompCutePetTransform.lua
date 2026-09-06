-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/cutepet/UnitCompCutePetTransform.lua

module("logicscene.scene.unit.component.cutepet.UnitCompCutePetTransform", package.seeall)

local UnitCompCutePetTransform = class("UnitCompCutePetTransform", UnitCompTransform)

function UnitCompCutePetTransform:setScale(scale)
	Framework.TransformUtil.SetLocalScale(self._trans, scale, scale, scale)
end

return UnitCompCutePetTransform
