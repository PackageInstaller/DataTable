-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/illusoryemperor/NsopIllusoryEmperorChallengeMainView.lua

module("logic.extensions.newsummonpetobtain.view.illusoryemperor.NsopIllusoryEmperorChallengeMainView", package.seeall)

local NsopIllusoryEmperorChallengeMainView = class("NsopIllusoryEmperorChallengeMainView", NsopMagicChallengeMainView)

function NsopIllusoryEmperorChallengeMainView:_getMaxScoreStr()
	local maxScore = NewSummonPetObtainModel.instance:getMaxScoreTodayInBS(self._curStageId)

	return string.format("历史最高分：<color=#ffe371>%s</color>", maxScore)
end

function NsopIllusoryEmperorChallengeMainView:_getActivityId()
	return NewSummonPetObtainController.instance:getHuanHuangActivityId()
end

return NsopIllusoryEmperorChallengeMainView
