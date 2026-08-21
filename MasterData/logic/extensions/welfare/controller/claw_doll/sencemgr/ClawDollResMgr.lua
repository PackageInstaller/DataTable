-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/claw_doll/sencemgr/ClawDollResMgr.lua

module("logic.extensions.welfare.controller.claw_doll.sencemgr.ClawDollResMgr", package.seeall)

local M = class("ClawDollResMgr", ISceneFlowComp)
local json = require("cjson")
local DEFAULT_STARTMOVE_POSITION = {
	z = 2,
	x = 0,
	y = 0
}
local DEFAULT_STARTENGINE_POSITION = {
	z = 0,
	x = -0.6,
	y = 0
}

function M:onInit()
	self._heroLoader = MultiResLoader.New()
	self._handler = Handler.New()
	self._heroResPaths = {}
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onEnterDone()
	local curScene = SceneMgr.instance:getCurScene()

	self._move = curScene.stage:getGoList("move")[1]
	self._verticalTrack = curScene.stage:getGoList("s301_doll machine_g")[1]
	self._engine = curScene.stage:getGoList("s301_doll machine_h")[1]

	local rope = curScene.stage:getGoList("rope")[1]
	local cube = curScene.stage:getGoList("cubeDis_trigger")[1]

	self._claw = curScene.stage:getGoList("s301_machine_i_trigger")[1]
	self._bollPrefab = curScene.stage:getGoList("bolls_trigger")[1]

	local tmepBollList = ClawDollConfig.instance:getBollList()

	self._bollColorList = {}

	for k, v in ipairs(tmepBollList) do
		local tempPrefab = curScene.stage:getGoList(v.model)[1]

		if tempPrefab ~= nil then
			self._bollColorList[k] = tempPrefab.gameObject
		else
			self._bollColorList[k] = self._bollPrefab.gameObject
		end
	end

	self._bollListFirst = curScene.stage:getGoList("bollListFirst")[1]
	self._bollListSecond = curScene.stage:getGoList("bollListSecond")[1]
	self._bollListThird = curScene.stage:getGoList("bollListThird")[1]

	Astral.TransformUtil.SetLocalPos(self._verticalTrack.transform, DEFAULT_STARTMOVE_POSITION.x, DEFAULT_STARTMOVE_POSITION.y, DEFAULT_STARTMOVE_POSITION.z)
	Astral.TransformUtil.SetLocalPos(self._engine.transform, DEFAULT_STARTENGINE_POSITION.x, DEFAULT_STARTENGINE_POSITION.y, DEFAULT_STARTENGINE_POSITION.z)

	self._moveObject = Astral.LuaComponentContainer.Add(self._move, ClawDollClawMove)

	self:_instanceBolls()

	local goTable = {
		vertical = self._verticalTrack,
		engine = self._engine,
		rope = rope,
		cube = cube,
		claw = self._claw,
		bollListFirst = self._bollListFirst,
		bollListSecond = self._bollListSecond,
		bollListThird = self._bollListThird
	}

	self._moveObject:onStart(goTable)
end

function M:onExit()
	self:_setEvent(false)

	self._bollColorList = {}

	self._handler:clear()
	self._heroLoader:clear()

	self._heroResPaths = {}
	self._tempDoll = {}
end

function M:load(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:getAllRoguelikeResoure()
end

function M:getAllRoguelikeResoure()
	self._tempDoll = ClawDollController.instance:getDollInMachineList(ClawDollActivityView.CONFIGID)

	if self._tempDoll == nil then
		self._tempDoll = {}
	end

	local temp = {}

	for i, v in ipairs(self._tempDoll) do
		local info = BackpackConfig.instance:getItemInfoByItemId(v.id)
		local infoJson = json.decode(info.exInfo)
		local modelCO = ModelConfig.instance:getModelConfig(infoJson.modelId)
		local path = GameUrl.getRoguelikeMeshModelUrl(modelCO.rogueResName)

		self._heroLoader:addResPath(path)
		table.insert(self._heroResPaths, path)

		temp[v.id] = path
	end

	ClawDollController.instance:setDollPath(ClawDollActivityView.CONFIGID, temp)
	self._heroLoader:load(self._onAllHeroLoaded, false, self)
end

function M:removeListener()
	self._handler:clear()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ClAW_DOLL_CLAWMOVE, self._clawMove, self)
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_ROPECHANGE, self._ropeLengthChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ClAW_DOLL_CLAWMOVE, self._clawMove, self)
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_ROPECHANGE, self._ropeLengthChange, self)
	end
end

function M:_clawMove(e, initDirection)
	self._moveObject:onMove(initDirection)
end

function M:_ropeLengthChange(e, msg)
	self._moveObject:ropeLengthChange(msg)
end

function M:_instanceBolls()
	for i, v in ipairs(self._heroResPaths) do
		local res = self:getHeroResource(v)

		if res then
			for j = 1, self._tempDoll[i].count do
				local heroGo = goutil.clone(res:GetMainAsset())
				local type = self:_getBollType(self._tempDoll[i].id)
				local tempBollPrefab

				if self._bollColorList[type] == nil then
					tempBollPrefab = goutil.clone(self._bollPrefab.gameObject)
				else
					tempBollPrefab = goutil.clone(self._bollColorList[type])
				end

				local tempBollTrigger = Astral.CollisionLuaComponentContainer.Add(tempBollPrefab, ClawDollBollTrigger)

				tempBollTrigger:updateData(self._tempDoll[i].id)

				local hang = goutil.findChild(tempBollPrefab, "character").transform

				goutil.addChildToParent(heroGo, hang)
				self:setBollPosition(tempBollPrefab)
			end
		end
	end

	goutil.setActive(self._bollPrefab.gameObject, false)

	for k, v in ipairs(self._bollColorList) do
		goutil.setActive(v, false)
	end
end

function M:_getBollType(dollID)
	local info = BackpackConfig.instance:getItemInfoByItemId(dollID)
	local infoJson = json.decode(info.exInfo)
	local dollType = infoJson.bollType

	if dollType == nil or dollType == "" then
		return 0
	end

	return dollType
end

function M:setBollPosition(tempBollPrefab)
	for i = 0, self._bollListFirst.transform.childCount - 1 do
		local childObj = self._bollListFirst.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 0 then
			goutil.addChildToParent(tempBollPrefab, childObj)
			Astral.TransformUtil.SetLocalPos(tempBollPrefab.transform, 0, 0, 0)
			Astral.TransformUtil.SetLocalRotation(tempBollPrefab.transform, 0, 180, 0)

			return
		end
	end

	for i = 0, self._bollListSecond.transform.childCount - 1 do
		local childObj = self._bollListSecond.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 0 then
			goutil.addChildToParent(tempBollPrefab, childObj)
			Astral.TransformUtil.SetLocalPos(tempBollPrefab.transform, 0, 0, 0)

			return
		end
	end

	for i = 0, self._bollListThird.transform.childCount - 1 do
		local childObj = self._bollListThird.transform:GetChild(i).gameObject

		if childObj.transform.childCount == 0 then
			goutil.addChildToParent(tempBollPrefab, childObj)
			Astral.TransformUtil.SetLocalPos(tempBollPrefab.transform, 0, 0, 0)

			return
		end
	end
end

function M:getHeroResource(resPath)
	return self._heroLoader:getResource(resPath)
end

function M:_onAllHeroLoaded()
	if not self._heroLoader:isAllSuccess() then
		if enableErrorLog then
			printError("preload hero resource failed!")
		end

		self._handler:call(false)

		return
	end

	self._handler:call(true)
end

return M
