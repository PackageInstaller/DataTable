-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifuchallengeView.lua

module("logic.extensions.infinitefuture.view.SaifuchallengeView", package.seeall)

local SaifuchallengeView = class("SaifuchallengeView", InfinfuchallengeView)

function SaifuchallengeView:bindEvents()
	InfinfuchallengeView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(function()
		if not self.stageId then
			return
		end

		if self.isOver then
			FloatWordMgr.instance:show("已通过所有关卡")
		else
			UIStateManager.instance:push(ViewName.SaifullevelsView)
		end
	end, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(InfinitefutureModel.instance.curPetId)
	end, self)
end

return SaifuchallengeView
