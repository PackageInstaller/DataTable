-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpdbqbView.lua

module("logic.extensions.passport.view.PassportwpdbqbView", package.seeall)

local PassportwpdbqbView = class("PassportwpdbqbView", PassportwpView)

function PassportwpdbqbView:buildUI()
	PassportwpdbqbView.super.buildUI(self)

	self.effResPath = "fx_ui_tongxingzheng/fx_ui_tongxingzheng_02.prefab"
end

function PassportwpdbqbView:onEnter()
	PassportwpdbqbView.super.onEnter(self)

	self._buyView = ViewName.PassportwpbuynewView
end

function PassportwpdbqbView:_onClickBtnBuyPassport()
	if self._curData.hasPay then
		GameUtil.SetActive(self._goBuyPassport, false)
		GameUtil.SetActive(self._goLock, false)
		uGuiUtil.setImageGrayStateRecursive(self._goIconBottom, true)

		return
	end

	UIStateManager.instance:push(ViewName.PassportbuyView, self._curData.actCfg, self._curData.funcCfg, 1, self._curData.sldValue)
end

return PassportwpdbqbView
