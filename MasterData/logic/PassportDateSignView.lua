-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/datesign/PassportDateSignView.lua

module("logic.extensions.passport.view.datesign.PassportDateSignView", package.seeall)

local PassportDateSignView = class("PassportDateSignView", PassportshowView)

function PassportDateSignView:buildUI()
	PassportDateSignView.super.buildUI(self)

	self._btnInvestment = goutil.findChild(self.mainGO, "container/btnInvestment")
	self._conRole = goutil.findChild(self.mainGO, "container/con/role")
end

function PassportDateSignView:bindEvents()
	PassportDateSignView.super.bindEvents(self)

	if self._btnInvestment then
		GameUtil.addClickHandler(self._btnInvestment, self._onClickBtnInvestment, self)
	end
end

function PassportDateSignView:unbindEvents()
	PassportDateSignView.super.unbindEvents(self)

	if self._btnInvestment then
		GameUtil.rmClickHandler(self._btnInvestment)
	end
end

function PassportDateSignView:onEnterFinished()
	PassportDateSignView.super.onEnterFinished(self)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 1014702, self._conRole, 1, callBack, true, 0, 0)
end

function PassportDateSignView:onExitFinished()
	PassportDateSignView.super.onExitFinished(self)

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)
end

function PassportDateSignView:_onClickBtnInvestment()
	if self._curData.hasPay then
		return
	end

	PassportController.instance:_buyPassportWithDifferentPayType(self._curData.actId, false)
end

return PassportDateSignView
