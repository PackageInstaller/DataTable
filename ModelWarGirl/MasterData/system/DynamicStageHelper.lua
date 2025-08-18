-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\DynamicStageHelper.lua

local ResScene = require("ClientData/ResScene")
local DynamicStage = require("Entity/DynamicStage")
local DynamicStageHelper = Class("DynamicStageHelper")
local self = DynamicStageHelper
local DEFAULT_PREFAB_PATH = "Scenes/DynamicStage/TestDynamicStage.prefab"

function DynamicStageHelper.createDynamicStage(sceneNo, loadedCallback)
	if not sceneNo or not ResScene[sceneNo] then
		return
	end

	if self.stage and self.sceneData and self.sceneData.id == sceneNo then
		DynamicStageHelper.startFarm()

		return self.stage
	end

	DynamicStageHelper.destroyDynamicStage()

	self.sceneData = ResScene[sceneNo]
	self.stage = DynamicStage(sceneNo)

	local prefabPath = self.sceneData.auto_prefab_path or DEFAULT_PREFAB_PATH

	self.stage:loadGameOjbect(prefabPath, self._loadGOCallback)

	return self.stage
end

function DynamicStageHelper.destroyDynamicStage()
	if self.stage then
		self.stage:destroy()

		self.stage = nil
	end
end

function DynamicStageHelper._loadGOCallback()
	self.modelLoaded = {
		[1] = false
	}

	local monsterModelId = self.sceneData.auto_monster_model

	if monsterModelId then
		self.modelLoaded[2] = false

		self.stage:addModel(monsterModelId, "hero", 2, self._addModelCallback)
	end

	local heroInfos = CurAvatar:getNowFormation()
	local heroResId
	local idList = {}

	for gid, pos in pairs(heroInfos) do
		local hero = CurAvatar.heroDic[gid]

		if hero and hero.modelData and hero.modelData.id then
			table.insert(idList, hero.modelData.id)
		end
	end

	if #idList > 0 then
		local randomIndex = math.random(1, #idList)

		heroResId = idList[randomIndex]
	else
		for gid, hero in pairs(CurAvatar.heroDic) do
			heroResId = hero.modelData.id

			break
		end
	end

	self.stage:addModel(heroResId, "hero", 1, self._addModelCallback)
end

function DynamicStageHelper._addModelCallback(idx)
	self.modelLoaded[idx] = true

	local allLoaded = true

	for _, loadEnd in pairs(self.modelLoaded) do
		if not loadEnd then
			allLoaded = false

			break
		end
	end

	if allLoaded then
		DynamicStageHelper.startFarm()
	end
end

function DynamicStageHelper.startFarm(...)
	for idx, _ in pairs(self.modelLoaded) do
		self.stage:modelPlayAnim(idx, "Farm")
	end

	self.stage:playStageAnim("Farm")
end

function DynamicStageHelper.flyIn(...)
	if self.stage then
		-- block empty
	end
end

function DynamicStageHelper.flyAway(...)
	if self.stage then
		self.stage:playStageAnim("FlyAway")
	end
end

return DynamicStageHelper
