-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/diyimingplus/DiYiMingPlusMainView.lua

module("logic.extensions.timelimitedchallenge.view.diyimingplus.DiYiMingPlusMainView", package.seeall)

local DiYiMingPlusMainView = class("DiYiMingPlusMainView", XiuMumMainView)

function DiYiMingPlusMainView:buildUI()
	DiYiMingPlusMainView.super.buildUI(self)

	self._btnIntroduce = self:getBtn("petInfo/btnIntroduce")
end

function DiYiMingPlusMainView:bindEvents()
	DiYiMingPlusMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickIntroduce, self)
end

function DiYiMingPlusMainView:unbindEvents()
	DiYiMingPlusMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function DiYiMingPlusMainView:_getActivityId()
	return 239003
end

function DiYiMingPlusMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.DiYiMingPlusLevelView)
end

function DiYiMingPlusMainView:_onClickIntroduce()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		PetbookController.instance:openPetinfoView(cfg.raceId)
	end
end

function DiYiMingPlusMainView:_onClickShop()
	GotoMgr.gotoByString("func#545#3")
end

return DiYiMingPlusMainView
