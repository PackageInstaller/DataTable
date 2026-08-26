-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventPlaySceneAnimator.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventPlaySceneAnimator", package.seeall)

local FightTLEventPlaySceneAnimator = class("FightTLEventPlaySceneAnimator", FightTimelineTrackItem)

function FightTLEventPlaySceneAnimator:onTrackStart(fightStepData, duration, paramsArr)
	local playObj
	local fightScene = GameSceneMgr.instance:getCurScene()

	if fightScene then
		local sceneObj = FightGameMgr.sceneLevelMgr:getSceneGo()

		playObj = sceneObj and gohelper.findChild(sceneObj, paramsArr[1])
	end

	if not playObj then
		return
	end

	self.playObj = playObj
	self.paramsArr = paramsArr

	local loadPath = paramsArr[4]

	if not string.nilorempty(loadPath) then
		local loadWork = self.com_registWork(self, FightWorkLoadAnimator, loadPath, playObj, self)

		loadWork:registFinishCallback(self.playAnimator, self)
		loadWork:start()
	else
		self:playAnimator()
	end
end

function FightTLEventPlaySceneAnimator:playAnimator()
	local aniName = self.paramsArr[2]
	local animator = gohelper.onceAddComponent(self.playObj, typeof(UnityEngine.Animator))

	if animator then
		animator.speed = FightModel.instance:getSpeed()

		if self.paramsArr[3] == "1" then
			SLFramework.AnimatorPlayer.Get(animator.gameObject):Play(aniName, nil, nil)
		else
			animator:Play(aniName, 0, 0)
		end
	end
end

function FightTLEventPlaySceneAnimator:onTrackEnd()
	return
end

return FightTLEventPlaySceneAnimator
