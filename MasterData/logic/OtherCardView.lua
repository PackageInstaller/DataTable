-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/OtherCardView.lua

module("logic.extensions.roleinfo.view.OtherCardView", package.seeall)

local OtherCardView = class("OtherCardView", MyCardView)

function OtherCardView:ctor()
	OtherCardView.super.ctor(self)
end

function OtherCardView:bindEvents()
	OtherCardView.super.bindEvents(self)
end

function OtherCardView:unbindEvents()
	OtherCardView.super.unbindEvents(self)
end

function OtherCardView:buildUI()
	OtherCardView.super.buildUI(self)
end

function OtherCardView:onEnter()
	OtherCardView.super.onEnter(self)

	self.curMo = RoleModel.instance.curCardInfo
end

function OtherCardView:onEnterFinished()
	OtherCardView.super.onEnterFinished(self)
end

function OtherCardView:onExit()
	OtherCardView.super.onExit(self)
end

function OtherCardView:onExitFinished()
	OtherCardView.super.onExitFinished(self)
end

function OtherCardView:_showGoldBar()
	return
end

function OtherCardView:_setExteriorUI()
	if self.curMo.playerMessageSkinId > 0 then
		if not self.curMo.playerMessageSkinId then
			local messageSkinId = 1
			local skinName = BattleStartAnimConfig.instance:getPlayerMessageSkinCfgById(messageSkinId).otherskinPath

			self:showTabAt(self._exteriorskinCon, skinName, viewParams)
		end
	end
end

return OtherCardView
