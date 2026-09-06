-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xj2MissionFmtRightView.lua

module("logic.extensions.xingjiang.view.Xj2MissionFmtRightView", package.seeall)

local Xj2MissionFmtRightView = class("Xj2MissionFmtRightView", FormationRightView)

function Xj2MissionFmtRightView:_initAllPetList()
	self._allPetList = XingJiangModel.instance:getAllPetList()
end

function Xj2MissionFmtRightView:_onChangePetSkinBody()
	self._allPetList = XingJiangModel.instance:getAllPetList(true)

	self:onRefreshPetLis()
end

return Xj2MissionFmtRightView
