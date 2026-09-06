-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/formation/XXYFmtRightView.lua

module("logic.extensions.xinxiyamirror.view.formation.XXYFmtRightView", package.seeall)

local XXYFmtRightView = class("XXYFmtRightView", FormationRightView)

function XXYFmtRightView:onEnter()
	XXYFmtRightView.super.onEnter(self)

	self._params = self._viewPresentor:getFirstParam()
end

function XXYFmtRightView:updateForbit(data)
	local inTeam = self:getInTeam(data)
	local hasUp = false
	local hasOneHire = self:getHasHireInTeam(data)
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(not inTeam and (hasUp or hasOneHire or canNotUp or hasOne or canNotUpWithYuan or (self._params.isMirror or nil) and XinxiyaMirrorModel.instance:checkIsMirrorPet(data.raceId)))
end

function XXYFmtRightView:_onForbidDragTips(petData)
	XXYFmtRightView.super._onForbidDragTips(self, petData)

	if (self._params.isMirror or nil) and XinxiyaMirrorModel.instance:checkIsMirrorPet(petData.raceId) then
		FloatWordMgr.instance:show("已被选为镜像精灵，无法再使用！")

		return
	end
end

return XXYFmtRightView
