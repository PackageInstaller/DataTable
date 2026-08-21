-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/event/RogueUnitCompEventInfo.lua

module("logic.extensions.roguelike.unit.comp.event.RogueUnitCompEventInfo", package.seeall)

local URL_INFO = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/rogue_event")
local M = class("RogueUnitCompEventInfo", RogueUnitCompBase)

function M:onInit()
	self._transformComp = self._unit.transform
	self._meshModel = self._unit.meshModel
	self._meshModel._curAnimState = false
	self._resLoader = SingleResLoader.New()

	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:onReset()
	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:_onMeshModelLoaded()
	local goInst = self._unit.meshModel:getInst()

	if goInst then
		local parentGo = goInst.transform

		goutil.addChildToParent(self._goInst, parentGo)
	end
end

function M:_buildUI(mainGO)
	self._goIcon = goutil.findChild(mainGO, "icon")
	self._txtDiff = goutil.findChild(mainGO, "text"):GetComponent("TextMesh")
end

function M:setIcon(pattern)
	self._pattern = pattern

	if self._goInst then
		self:setImage()
	elseif self._resLoader then
		self._resLoader:load(URL_INFO, self._onResLoaded, self)
	end
end

function M:setImage()
	if not self._pattern then
		return
	end

	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
	local resPath = diceMgr:getDicePatternPath(self._pattern)
	local dynIcon = SpriteDynIcon.Get(self._goIcon)

	dynIcon:SetImage(resPath, nil, nil)

	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()
	local diff = replyCo.difficulty + RogueMgr.instance:getModel():getEventChangeDifficulty()

	diff = math.max(1, diff)
	self._txtDiff.text = string.format(lang("tip_r_event_diff"), diff)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	local parentGo = self._transformComp._transform

	goutil.addChildToParent(self._goInst, parentGo)
	self:_buildUI(self._goInst)
	self:setImage()
end

function M:onDestroy()
	self:onReset()
end

return M
