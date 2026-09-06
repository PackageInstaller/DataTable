-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/illusoryemperor/NsopIllusoryEmperorMainView.lua

module("logic.extensions.newsummonpetobtain.view.illusoryemperor.NsopIllusoryEmperorMainView", package.seeall)

local NsopIllusoryEmperorMainView = class("NsopIllusoryEmperorMainView", NewSummonPetObtainMainView)

function NsopIllusoryEmperorMainView:buildUI()
	NsopIllusoryEmperorMainView.super.buildUI(self)

	self._btnMiBao = goutil.findChild(self.mainGO, "btnMiBao")
	self._btnFullRebate = goutil.findChild(self.mainGO, "btnFullRebate")
end

function NsopIllusoryEmperorMainView:bindEvents()
	NsopIllusoryEmperorMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnMiBao, self._onClickBtnMiBao, self)
	GameUtil.addClickHandler(self._btnFullRebate, self._onClickBtnFullRebate, self)
end

function NsopIllusoryEmperorMainView:unbindEvents()
	NsopIllusoryEmperorMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnMiBao)
	GameUtil.rmClickHandler(self._btnFullRebate)
end

function NsopIllusoryEmperorMainView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.NsopIllusoryEmperorChallengeMainView)
end

function NsopIllusoryEmperorMainView:_onClickBtnMiBao()
	local jumpToStr = NewSummonPetObtainConfig.instance:getNspoCommonValue(self._activityId, "NSOP_JUMP_MIBAOSHOP_KEY")

	GotoMgr.gotoByString(jumpToStr)
end

function NsopIllusoryEmperorMainView:_onClickBtnFullRebate()
	local jumpToStr = NewSummonPetObtainConfig.instance:getNspoCommonValue(self._activityId, "NSOP_JUMP_FullRebate_KEY")

	GotoMgr.gotoByString(jumpToStr)
end

function NsopIllusoryEmperorMainView:_isNeedBgEff()
	return false
end

function NsopIllusoryEmperorMainView:_isNeedSpine()
	return false
end

function NsopIllusoryEmperorMainView:_getActivityId()
	return NewSummonPetObtainController.instance:getHuanHuangActivityId()
end

function NsopIllusoryEmperorMainView:_onClickBtnMusic()
	UIStateManager.instance:push(ViewName.NsopIllusoryEmperorMusicMainView)
end

function NsopIllusoryEmperorMainView:_setOpenTime()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

return NsopIllusoryEmperorMainView
