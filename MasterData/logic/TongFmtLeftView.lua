-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/formation/TongFmtLeftView.lua

module("logic.extensions.tongbattle.view.formation.TongFmtLeftView", package.seeall)

local TongFmtLeftView = class("TongFmtLeftView", FormationLeftView)

function TongFmtLeftView:onEnter()
	local params = self._viewPresentor:getFirstParam()

	if params and (params.chalType == 3 or params.chalType == 4) then
		GameUtil.SetActive(self._Btn_Formation, false)

		local isReset = false
		local attrType = params.stageId == 1 and "火" or "暗"
		local formation = self:_getCurFormation()

		for pos, id in ipairs(formation:GetPositions()) do
			if id > 0 then
				local petMo = self:_getPet(id)

				if petMo and not petMo:checkHasRace(attrType) then
					isReset = true

					break
				end
			end
		end

		if isReset then
			formation:ResetPosition()
		end
	end

	TongFmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormationUse(false)
end

return TongFmtLeftView
