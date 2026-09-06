-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NNCFmtLeftView.lua

module("logic.extensions.niannianchall.view.lightking.NNCFmtLeftView", package.seeall)

local NNCFmtLeftView = class("NNCFmtLeftView", FormationLeftView)

function NNCFmtLeftView:onExit()
	NianNianChallController.instance:saveFormation()
	NNCFmtLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LightKingGetFormRes, self._onGetFormRes, self)
end

function NNCFmtLeftView:buildUI()
	NNCFmtLeftView.super.buildUI(self)
end

function NNCFmtLeftView:onEnter()
	NNCFmtLeftView.super.onEnter(self)
	GameUtil.SetActive(self._Btn_Formation, false)
	self:_setActiveBtnFormationUse(false)

	local supportPetCfg = NianNianChallModel.instance:getSupportPetCfg()

	if supportPetCfg then
		local fixedPos = {
			supportPetCfg.posId
		}

		self:_setFixedPos(fixedPos)
	end
end

function NNCFmtLeftView:_getItemSeatCls()
	return NNCItemSeat
end

function NNCFmtLeftView:_getPet(petId)
	return NianNianChallModel.instance:getPet(petId)
end

function NNCFmtLeftView:_getCurFormation()
	return NianNianChallModel.instance:getFormation()
end

function NNCFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local mo = self:_getPet(petId)

	if mo then
		return true
	end

	return false
end

function NNCFmtLeftView:resetNum()
	return 6
end

return NNCFmtLeftView
