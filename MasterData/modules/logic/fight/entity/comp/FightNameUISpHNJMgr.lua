-- chunkname: @modules/logic/fight/entity/comp/FightNameUISpHNJMgr.lua

module("modules.logic.fight.entity.comp.FightNameUISpHNJMgr", package.seeall)

local FightNameUISpHNJMgr = class("FightNameUISpHNJMgr", UserDataDispose)
local path = "ui/viewres/fight/fightsphongnujiancharge.prefab"

function FightNameUISpHNJMgr:init(entity, viewGO)
	FightNameUISpHNJMgr.super.__onInit(self)

	self.entity = entity
	self.entityMo = self.entity:getMO()
	self.entityId = self.entityMo.uid
	self.entityData = entity.entityData
	self.viewGO = viewGO
	self.goContainer = gohelper.findChild(viewGO, "layout/go_sphongnujian")

	gohelper.setActive(self.goContainer, false)

	self.preShow = false
	self.loaded = false

	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)

	local hasChannel = FightHelper.checkHas4_0HNJChannelBuff(self.entityMo)

	if hasChannel then
		self:loadAsset()
	end
end

function FightNameUISpHNJMgr:loadAsset()
	if self.loader then
		return
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(path)
	self.loader:startLoad(self.onAssetLoaded, self)
end

function FightNameUISpHNJMgr:onBuffUpdate(entityId)
	if entityId ~= self.entityId then
		return
	end

	if self.loaded then
		return self:refreshUI()
	end

	local hasChannel = FightHelper.checkHas4_0HNJChannelBuff(self.entityMo)

	if not hasChannel then
		return
	end

	self:loadAsset()
end

function FightNameUISpHNJMgr:onAssetLoaded()
	local assetItem = self.loader:getFirstAssetItem()

	if not assetItem then
		return
	end

	local resObj = assetItem:GetResource()

	self.go = gohelper.clone(resObj, self.goContainer)
	self.animator = self.go:GetComponent(gohelper.Type_Animator)
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)

	local goProgress = gohelper.findChild(self.go, "#image_progress")

	self.goEffect1 = gohelper.findChild(self.go, "#go_effect_1")
	self.goEffect2 = gohelper.findChild(self.go, "#go_effect_2")

	gohelper.setActive(self.goEffect1, true)
	gohelper.setActive(self.goEffect2, true)

	self.progressList = self:getUserDataTb_()

	for i = 1, FightEnum.SP_HNJ_MAX do
		local go = gohelper.findChild(goProgress, i)

		gohelper.setActive(go, false)
		table.insert(self.progressList, go)
	end

	self.loaded = true

	self:refreshUI()
end

function FightNameUISpHNJMgr:refreshUI()
	local hasChannel = FightHelper.checkHas4_0HNJChannelBuff(self.entityMo)

	if not hasChannel then
		self:hideContainer()

		self.preShow = false

		return
	end

	self.preShow = true

	self.animatorPlayer:Stop()
	gohelper.setActive(self.goContainer, true)

	local count = FightHelper.get4_0HNJChannelCount(self.entityMo)
	local max = FightHelper.get4_0HNJChannelMax()

	for i = 1, max do
		gohelper.setActive(self.progressList[i], i <= count)
	end

	for i = max + 1, FightEnum.SP_HNJ_MAX do
		gohelper.setActive(self.progressList[i], false)
	end

	local animName = max <= count and "full" or "open"

	self.animator:Play(animName)
end

function FightNameUISpHNJMgr:hideContainer()
	if not self.preShow then
		return
	end

	self.animatorPlayer:Play("close", self._hideContainer, self)
end

function FightNameUISpHNJMgr:_hideContainer()
	gohelper.setActive(self.goContainer, false)
end

function FightNameUISpHNJMgr:dispose()
	if self.animatorPlayer then
		self.animatorPlayer:Stop()

		self.animatorPlayer = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	FightNameUISpHNJMgr.super.__onDispose(self)
end

return FightNameUISpHNJMgr
