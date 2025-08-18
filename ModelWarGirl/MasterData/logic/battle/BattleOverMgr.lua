-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\battle\\BattleOverMgr.lua

local Entity = require("Entity/Entity")
local ResHero = require("ClientData/ResHero")
local ModelTool = require("Entity/ModelTool")
local Model = require("Entity/Model")
local BattleConst = require("Common/FrameBattle/BattleConst")
local MvpLogo = require("UI/Control/Logo/MvpLogo")
local Actor = Class("Actor", Entity)

function Actor:ctor(entitiId, name, hero, activeOnLoaded, isMvp, isLose)
	self.isLose = isLose
	self.isMvp = isMvp
	self.loaded = false
	self.heroId = hero.id
	self.hero = hero
	self.commonModelId = hero:getShowModelId()
	self.activeOnLoaded = activeOnLoaded

	self:addMovementAux()
	self:createModel()
end

function Actor:createModel(...)
	if not self.modelLoadedCallBack then
		self.modelLoadedCallBack = Slot(self.delayLoaded, self)
	end

	if self.entityModel ~= nil then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	if self.entityModel == nil then
		self.entityModel = Model(self.modelLoadedCallBack, self.id)

		self.entityModel:setModelDataShow(self.commonModelId, Const.MODEL_TYPE.ShowResult)
		self.entityModel:loadGameObject(nil, true)
	end

	return self.entityModel
end

function Actor:delayLoaded(...)
	Actor.super.OnModelLoadedEnd(self)

	self.loaded = true
	self.modelObject = self.entityModel.modelGameObject

	self.entityModel:setModelAlwaysAnim()
	self.entityModel:setOutline(false)

	if SceneManager.isCurSceneRainy() then
		self.entityModel:setRainyMat(true)
	end

	self.entityModel:setTonemapping(true)
	ModelTool.addBaseModel(self.entityModel:getModelInsId(), self.hero:getShowBaseModelId(), 1, Const.HERO_BASE_TYPE.Battle)
	self:setEntityLayer("Player")

	if self.isLose then
		self:playAni("Lose")
	else
		self:playAni("Show")
	end

	if self.isMvp then
		if self.isLose then
			CueManager.playHeroVocal(self.heroId, Const.HERO_VOCAL_FAIL)
		else
			CueManager.playHeroVocal(self.heroId, Const.HERO_VOCAL_VICTORY)
		end
	end

	self:onModelLoadedEnd()
end

function Actor:onModelLoadedEnd()
	self.controller:AdjustMvpTopRoot(self.entityModel.modelGameObject)
	self:initLogo()
end

function Actor:initLogo(time)
	if not self.isMvp or self.isLose then
		return
	end

	self.logo = MvpLogo(self.controller, "System/Battle/Result/BattleResultMVPLogo", 0, 0, self)

	self.logo:setVisible(false)

	self.timer = Timer(function(...)
		if self.logo then
			self.logo:setVisible(true)
			self.logo:playAni("ShowMVPLogo", nil)
		end
	end, 1, 1)

	self.timer:Start()
end

function Actor:playAni(name)
	self:playAnimator(name)
end

function Actor:setPosition(posInfo, centerPos)
	local y = 0.1

	if self.info then
		local posConfig = self.info.pos == nil and {
			x = 0,
			y = 0
		} or {
			x = self.info.pos[1],
			y = self.info.pos[2]
		}

		y = y + posConfig.y
	end

	self.pos = posInfo
	self.gameObject.transform.position = posInfo.position + Vector3(0, y, 0) + centerPos
	self.gameObject.transform.eulerAngles = posInfo.rotation
end

function Actor:destroy()
	Actor.super.destroy(self)

	if self.logo then
		self.logo:destroy()
	end

	self.modelObject = nil

	if self.timer then
		self.timer:Stop()
	end
end

local strClassName = "BattleOverMgr"
local BattleOverMgr = Class(strClassName)

function BattleOverMgr:ctor(posInfo, entityDict, centerPos, isLose)
	self.entityDict = entityDict
	self.posInfo = posInfo
	self.actors = {}
	self.centerPos = centerPos
	self.isLose = isLose

	self:createModels()
end

function BattleOverMgr:createModels()
	if self.entityDict then
		local vocalIndex = math.random(1, #self.entityDict)

		for id, hero in ipairs(self.entityDict) do
			if id <= #self.posInfo then
				self.actors[id] = Actor(BattleConst.BATTLE_OVER_HEROS_ENTITY_ID + id, "", hero, true, id == 1, self.isLose)

				self.actors[id]:setPosition(self.posInfo[id], self.centerPos)
			end
		end
	end
end

function BattleOverMgr:isBattleOverActorsAllLoaded(...)
	if self.actors then
		for id, actor in ipairs(self.actors) do
			if actor.loaded == false then
				return false
			end
		end
	end

	return true
end

function BattleOverMgr:destroy()
	if self.actors then
		for id, actor in ipairs(self.actors) do
			actor:destroy()
		end

		self.actors = nil
	end
end

return BattleOverMgr
