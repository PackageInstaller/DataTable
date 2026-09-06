-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/SuppressTagCell.lua

module("logic.extensions.qichallenge.view.SuppressTagCell", package.seeall)

local SuppressTagCell = class("SuppressTagCell", CustomRightCell)

SuppressTagCell.prefabUrl = "ui/views/qichallenge/suppresstagcell.prefab"

function SuppressTagCell:buildUI()
	self._targetCol = goutil.findChild(self.mainGO, "targetCol")
	self._txtDebuff = goutil.findChildTextComponent(self.mainGO, "targetCol/txtDebuff")

	GameUtil.SetActive(self._targetCol, false)
end

function SuppressTagCell:onUpdateBlockTagActive(activityId, raceId)
	local blockIds = QiChallengeModel.instance:getHardChallengePetMap()
	local isEffect = checknumber(blockIds[raceId]) > 0

	GameUtil.SetActive(self._targetCol, isEffect)

	if isEffect == true then
		local actCfg = QiChallengeConfig.instance:getActivityCfg(activityId)
		local debuffCfg = QiChallengeConfig.instance:getDebuffCfgs(actCfg.deBuffPlanId)
		local debuffTime = checknumber(blockIds[raceId])

		if debuffTime > #debuffCfg then
			debuffTime = #debuffCfg
		end

		self._txtDebuff.text = debuffCfg[debuffTime].tagShow
	end
end

function SuppressTagCell:clearTargetCol()
	return
end

return SuppressTagCell
