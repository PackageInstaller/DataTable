-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TechingtagView.lua

module("logic.extensions.teachingdungeon.view.TechingtagView", package.seeall)

local TechingtagView = class("TechingtagView", ViewComponent)

function TechingtagView:ctor()
	TechingtagView.super.ctor(self)
end

function TechingtagView:buildUI()
	TechingtagView.super.buildUI(self)

	for i = 1, 9 do
		self["itemLeftGo" .. i] = self:getGo("startOrderLeft/item" .. i)
		self["itemLeftText" .. i] = goutil.findChildTextComponent(self.mainGO, "startOrderLeft/item" .. i .. "/bg/Text")
	end

	for i = 1, 9 do
		self["itemRightGo" .. i] = self:getGo("startOrderRight/item" .. i)
		self["itemRightText" .. i] = goutil.findChildTextComponent(self.mainGO, "startOrderRight/item" .. i .. "/bg/Text")
	end

	self:initData()
end

function TechingtagView:bindEvents()
	TechingtagView.super.bindEvents(self)
end

function TechingtagView:unbindEvents()
	TechingtagView.super.unbindEvents(self)
end

function TechingtagView:destroyUI()
	TechingtagView.super.destroyUI(self)
end

function TechingtagView:onEnter()
	TechingtagView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateStartOrder, self.initView, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationUpdateStartOrder, self.initView, self)
	GlobalDispatcher:addListener(TeachingDungeonModel.OnBeginDrag, self.hideTag, self)
	GlobalDispatcher:addListener(TeachingDungeonModel.OnEndDrag, self.showTag, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationDropFromSeat, self.initView, self)
	self:initView()
end

function TechingtagView:onEnterFinished()
	TechingtagView.super.onEnterFinished(self)
end

function TechingtagView:onExit()
	TechingtagView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationDropFromSeat, self.initView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateStartOrder, self.initView, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationUpdateStartOrder, self.initView, self)
	GlobalDispatcher:removeListener(TeachingDungeonModel.OnBeginDrag, self.hideTag, self)
	GlobalDispatcher:removeListener(TeachingDungeonModel.OnEndDrag, self.showTag, self)
end

function TechingtagView:onExitFinished()
	TechingtagView.super.onExitFinished(self)
end

function TechingtagView:initData()
	local creepCfg = TeachingDungeonConfig.instance:getCreepCfg()
	local supportCfg = TeachingDungeonConfig.instance:getSupportCfgs()

	self.myRaceId2Lable = {}
	self.enemyRaceId2Lable = {}

	for k, v in ipairs(creepCfg) do
		self.enemyRaceId2Lable[v.raceId] = not string.nilorempty(v.lable) and v.lable
	end

	for k, v in pairs(supportCfg) do
		self.myRaceId2Lable[v.creepsId] = not string.nilorempty(v.lable) and v.lable
	end
end

function TechingtagView:initView()
	local selfPoses = TeachingDungeonModel.instance:getFormation():GetPositions()
	local enemyForm = MissionModel.instance:getEnemyFormations()
	local enemyPosShow = {}

	if enemyForm then
		for pos, v in pairs(enemyForm) do
			self["itemRightText" .. pos].text = self.enemyRaceId2Lable[v.raceId] or ""
			enemyPosShow[pos] = self.enemyRaceId2Lable[v.raceId]
		end
	end

	local selfPosesKv = {}

	for i, creepsId in ipairs(selfPoses) do
		selfPosesKv[i] = creepsId > 0 and self.myRaceId2Lable[creepsId]
		self["itemLeftText" .. i].text = self.myRaceId2Lable[creepsId] or ""
	end

	for i = 1, 9 do
		GameUtil.SetActive(self["itemLeftGo" .. i], selfPosesKv[i])
		GameUtil.SetActive(self["itemRightGo" .. i], enemyPosShow[i])
	end
end

function TechingtagView:hideTag(posId)
	GameUtil.SetActive(self["itemLeftGo" .. posId], false)
end

function TechingtagView:showTag(posId)
	GameUtil.SetActive(self["itemLeftGo" .. posId], true)
end

return TechingtagView
