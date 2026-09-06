-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonWoodenChallengeSliderCell.lua

module("logic.extensions.season.view.SeasonWoodenChallengeSliderCell", package.seeall)

local SeasonWoodenChallengeSliderCell = class("SeasonWoodenChallengeSliderCell", PlayerSliderCell)

function SeasonWoodenChallengeSliderCell:init(data, view, rectTrans, callbackParams)
	self._view = view
	self._rectTrans = rectTrans
	self._data = data
	self._callbackParams = callbackParams

	local progress = 0

	progress = self._callbackParams.parseGetProgress and self._callbackParams.parseGetProgress(data) or self._callbackParams.needScore
	self._txtScore.text = checknumber(progress) > 100000000 and langPara("%d亿", checkint(progress / 100000000)) or checknumber(progress) > 10000 and langPara("%d万", checkint(progress / 10000)) or progress
	self._prize = self._callbackParams.prize and self._callbackParams.prize or self._data.prize

	self:_doInit()
	self:_afterInit()
end

return SeasonWoodenChallengeSliderCell
