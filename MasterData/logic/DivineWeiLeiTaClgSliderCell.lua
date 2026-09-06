-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgSliderCell.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgSliderCell", package.seeall)

local DivineWeiLeiTaClgSliderCell = class("DivineWeiLeiTaClgSliderCell", PlayerSliderCell)

function DivineWeiLeiTaClgSliderCell:ctor(luaComponentContainer)
	self.super.ctor(self, luaComponentContainer)

	self._imgTarget = goutil.findChild(self.mainGO, "imgTarget")
end

function DivineWeiLeiTaClgSliderCell:update()
	local rewardCfg = self._data
	local isGeted = self._callbackParams.isPlayerRewardGeted(rewardCfg)
	local isCanGet = self._callbackParams.isPlayerRewardCanGet(rewardCfg)

	goutil.setActive(self._canGet, isCanGet)
	goutil.setActive(self._geted, isGeted)
	GameUtil.SetGray(self._imgTarget, not isCanGet and not isGeted)

	if isCanGet then
		self:_playEffect()
	else
		self:_clearEffect()
	end

	if self._callbackParams and self._callbackParams.updateCellFunc then
		self._callbackParams.updateCellFunc(self._item, self._data, self._view)
	end

	return isGeted, isCanGet
end

return DivineWeiLeiTaClgSliderCell
