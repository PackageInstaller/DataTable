-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_ForceAuto.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_ForceAuto", package.seeall)

local FightBuffBehaviour_ForceAuto = class("FightBuffBehaviour_ForceAuto", FightBuffBehaviourBase)
local DefaultAutoBtnPath = "ui/viewres/fight/fighttower/fightautobtnlockview.prefab"
local SiblingIndex = 3

function FightBuffBehaviour_ForceAuto:onAddBuff(entityId, buffId, buffMo)
	self.buffId = buffId
	self.btnRoot = gohelper.findChild(self.viewGo, "root/btns")
	self.srcAutoBtn = gohelper.findChild(self.viewGo, "root/btns/btnAuto")

	self:initParam()

	self.loader = PrefabInstantiate.Create(self.btnRoot)

	self.loader:startLoad(self.resUrl, self.onLoadFinish, self)
	FightDataHelper.stateMgr:setBuffForceAuto(true)
	FightGameMgr.operateMgr:requestAutoFight()
	AudioMgr.instance:trigger(self.audioId)
end

function FightBuffBehaviour_ForceAuto:initParam()
	local co = lua_fight_buff2special_behaviour.configDict[self.buffId]
	local param = co and co.param

	if string.nilorempty(param) then
		self.resUrl = DefaultAutoBtnPath
		self.audioId = 310004

		return
	end

	local paramList = FightStrUtil.instance:getSplitCache(param, "#")

	self.resUrl = paramList and paramList[1] or DefaultAutoBtnPath
	self.audioId = paramList and tonumber(paramList[2]) or 310004
end

function FightBuffBehaviour_ForceAuto:getBtnResUrl()
	local co = lua_fight_buff2special_behaviour.configDict[self.buffId]
	local url = co and co.param

	if string.nilorempty(url) then
		url = DefaultAutoBtnPath
	end

	return url
end

function FightBuffBehaviour_ForceAuto:onLoadFinish()
	self.autoBtn = self.loader:getInstGO()

	gohelper.setSibling(self.autoBtn, SiblingIndex)
	gohelper.setActive(self.srcAutoBtn, false)
	gohelper.setActive(self.autoBtn, true)
end

function FightBuffBehaviour_ForceAuto:onUpdateBuff(entityId, buffId, buffMo)
	return
end

function FightBuffBehaviour_ForceAuto:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.autoBtn)
	gohelper.setActive(self.srcAutoBtn, true)
	FightDataHelper.stateMgr:setBuffForceAuto(false)
end

function FightBuffBehaviour_ForceAuto:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	FightDataHelper.stateMgr:setBuffForceAuto(false)
	FightBuffBehaviour_ForceAuto.super.onDestroy(self)
end

return FightBuffBehaviour_ForceAuto
