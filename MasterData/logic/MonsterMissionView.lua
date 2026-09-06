-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MonsterMissionView.lua

module(..., package.seeall)

local MonsterMissionView = class("MonsterMissionView", MissionView)

function MonsterMissionView:onEnter()
	self:onEnterInherit()

	self._monsterId = self._viewPresentor._openParam[1]
	self._mstInstanceId = self._viewPresentor._openParam[2]
	self._mstZoneId = self._viewPresentor._openParam[3]

	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self._videoButton.gameObject:SetActive(false)
	self:_setMissionCfgInfo()
	self:_onSpClassLoad()
end

function MonsterMissionView:_setMissionCfgInfo()
	local scene = SceneMgr.instance:getCurScene()
	local sceneId = scene:getSceneId()
	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)
	local monsterCo = SceneConfig.instance:getMonsterMaskterCo(self._monsterId)
	local titleStr = sceneCo.scene_name
	local levelStr = monsterCo.name
	local ruleDesc = "击败敌方阵容即可通关"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
end

function MonsterMissionView:onEnterFinished()
	self:_procLRTxt()
end

function MonsterMissionView:_setBattleResultTxtTitle()
	MonsterMissionView.super._setBattleResultTxtTitle(self)
	BattleModel.instance:setBattleName(self:_getLevelStr())
end

function MonsterMissionView:_getSpClassCo()
	return SceneConfig.instance:getMonsterConfigCo(self._monsterId)
end

function MonsterMissionView:_enterBattle()
	BattleFacade.instance:startFightSceneMonster(self._mstInstanceId, self._mstZoneId, true)
end

return MonsterMissionView
