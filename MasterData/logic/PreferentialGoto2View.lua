-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PreferentialGoto2View.lua

module("logic.extensions.bonus.view.PreferentialGoto2View", package.seeall)

local PreferentialGoto2View = class("PreferentialGoto2View", PreferentialGoto1View)

function PreferentialGoto2View:ctor()
	PreferentialGoto2View.super.ctor(self)

	self._redpointId = RedPointModel.ID_PREFERENTIAL_RECOMMEND_JUMP_WEEKLY_2
end

return PreferentialGoto2View
