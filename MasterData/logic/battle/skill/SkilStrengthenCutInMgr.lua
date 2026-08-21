-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/SkilStrengthenCutInMgr.lua

module("logic.battle.skill.SkilStrengthenCutInMgr", package.seeall)

local SkilStrengthenCutInMgr = class("SkilStrengthenCutInMgr")
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function SkilStrengthenCutInMgr:ctor()
	self._goCutIn = false
end

function SkilStrengthenCutInMgr:init()
	local resMgr = BattleMgr.instance:getResourceMgr()

	self._goCutIn = resMgr:getInst(BattleResourceName.StrengthenCutIn)

	goutil.setActive(self._goCutIn, false)
	goutil.addChildToParent(self._goCutIn, kSceneRoot)
end

function SkilStrengthenCutInMgr:turnOnCutIn(isSolo)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_lizhi_scene_switch, nil, nil, nil)
	Astral.TransformUtil.SetLocalScale(self._goCutIn.transform, 1, 1, 1)
	goutil.setActive(self._goCutIn, true)
end

function SkilStrengthenCutInMgr:turnOffCutIn()
	goutil.setActive(self._goCutIn, false)
end

function SkilStrengthenCutInMgr:expandCutIn()
	Astral.TransformUtil.SetLocalScale(self._goCutIn.transform, 1.5, 1.5, 1)
end

function SkilStrengthenCutInMgr:clear()
	if self._goCutIn then
		goutil.destroy(self._goCutIn)

		self._goCutIn = false
	end
end

SkilStrengthenCutInMgr.instance = SkilStrengthenCutInMgr.New()

return SkilStrengthenCutInMgr
