-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportHolyLightView.lua

module("logic.extensions.passport.view.PassportHolyLightView", package.seeall)

local PassportHolyLightView = class("PassportHolyLightView", PassportwpView)

function PassportHolyLightView:ctor()
	PassportHolyLightView.super.ctor(self)
end

function PassportHolyLightView:buildUI()
	PassportHolyLightView.super.buildUI(self)
end

function PassportHolyLightView:bindEvents()
	PassportHolyLightView.super.bindEvents(self)
end

function PassportHolyLightView:unbindEvents()
	PassportHolyLightView.super.unbindEvents(self)
end

function PassportHolyLightView:destroyUI()
	PassportHolyLightView.super.destroyUI(self)
end

function PassportHolyLightView:onEnter()
	PassportHolyLightView.super.onEnter(self)
end

function PassportHolyLightView:onEnterFinished()
	PassportHolyLightView.super.onEnterFinished(self)
end

function PassportHolyLightView:onExit()
	PassportHolyLightView.super.onExit(self)
end

function PassportHolyLightView:onExitFinished()
	PassportHolyLightView.super.onExitFinished(self)
end

function PassportHolyLightView:_getOpenparam()
	return 16
end

function PassportHolyLightView:_refreshUI()
	PassportHolyLightView.super._refreshUI(self)

	self._retProress.offsetMin = UnityEngine.Vector2.New(70, -50)
	self._retProress.offsetMax = UnityEngine.Vector2.New(-248, -40)
end

function PassportHolyLightView:_extendCellData(dataList)
	table.insert(dataList, {})

	return dataList
end

function PassportHolyLightView:_onClickBtnBuyPassport()
	if self._curData.hasPay then
		GameUtil.SetActive(self._goBuyPassport, false)
		GameUtil.SetActive(self._goLock, false)
		uGuiUtil.setImageGrayStateRecursive(self._goIconBottom, true)

		return
	end

	local data1, data2, data3, num = PassportModel.instance:getCurDataList(nil, self._curData.funcId)

	if GameUtil.isEmptyString(data1[1]) then
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue, self:_getPassportbuyViewExtraParam())
	else
		UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 2, self._curData.sldValue, self:_getPassportbuyViewExtraParam())
	end
end

function PassportHolyLightView:_isNeedShowCell()
	return false
end

function PassportHolyLightView:_onClickBtnOneKey()
	PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)
end

return PassportHolyLightView
