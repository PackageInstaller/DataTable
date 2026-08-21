-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueGameDiceMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueGameDiceMgr", package.seeall)

local M = class("RogueGameDiceMgr", IRogueFlowComp)
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kDiceRoot = goutil.create("RogueDice")

goutil.addChildToParent(kDiceRoot, kSceneRoot)

local kDicePatternKey = {
	"power",
	"agile",
	"information",
	"communication",
	"insight",
	"lucky",
	"success",
	"crit",
	"sacrifice",
	"wisdomnoodles",
	"bleed",
	"trance",
	"curse",
	"blessing",
	"success",
	"success",
	"success",
	"success",
	"success",
	"success",
	"crit",
	"success",
	"success",
	"success",
	"success",
	"success",
	"success",
	"success",
	"success",
	"success"
}
local kDiceFaceName = {
	"sx_s602_dice_ux",
	"sx_s602_dice_z",
	"sx_s602_dice_x",
	"sx_s602_dice_uz",
	"sx_s602_dice_y",
	"sx_s602_dice_uy"
}
local kRoleDiceIndex = {
	2
}
local kColliderEffectPath = GameUrl.get3dEffectUrl("scene/other/paotuan/paotuan_tx_pengzhuang")
local kExtraPatternEffectPath = GameUrl.get3dEffectUrl("scene/other/paotuan/paotuan_tx_fujiamianbuff")

function M:onInit()
	self._diceObjs = {}
	self._allDiceObjs = {}
	self._diceCallbacks = {}
	self._resDict = {}
	self._resSpriteLoader = MultiResLoader.New()

	self._resSpriteLoader:addResPath(IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice), true)
	self._resSpriteLoader:load(false, self._onSpriteLoaded, self)

	self._resLoader = MultiResLoader.New()

	local resPaths = {}

	for i = 1, 6 do
		local path = self:getDicePath(i)

		table.insert(resPaths, path)
	end

	for i = 1, #kDicePatternKey do
		local path = self:getDicePatternPath(i)

		table.insert(resPaths, path)
	end

	table.insert(resPaths, kColliderEffectPath)
	table.insert(resPaths, kExtraPatternEffectPath)

	local resLoader = self._resLoader

	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllAdditionalLoaded, self._onAdditionalLoaded, self)
end

function M:_onAdditionalLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function M:_onAllAdditionalLoaded(loader)
	self._resLoader:clear()
end

function M:_onSpriteLoaded(res)
	if res.IsSuccess then
		IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	end
end

function M:getRes(resPath)
	return self._resDict[resPath]
end

function M:getAsset(resPath)
	return self:getRes(resPath):GetAsset(nil, nil)
end

function M:_onOneLoaded(res)
	if res.IsSuccess then
		self._diceInst = res:GetAsset(nil, nil)

		for k, v in pairs(self._diceCallbacks) do
			v(self._diceInst)
		end

		self._diceCallbacks = {}
	end
end

function M:getDicePatternTexture(idx)
	local resPath = self:getDicePatternPath(idx)

	return self:getAsset(resPath)
end

function M:getDicePath(idx)
	local path = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/paotuan-prop_dice0" .. idx)

	return path
end

function M:getDicePatternPath(idx)
	local name = string.format("scene/common-elems/common_npc_props/npc_shaizi/texture/s602_plane_%s.png", kDicePatternKey[idx] or "power")
	local path = name

	return path
end

function M:getDiceInst(callback, idx)
	idx = idx or 1

	local path = self:getDicePath(idx)

	self._diceInst = self:getAsset(path)

	if self._diceInst then
		callback(self._diceInst)
	else
		table.insert(self._diceCallbacks, callback)
	end
end

function M:getColliderEffectInst()
	return self:getAsset(kColliderEffectPath)
end

function M:getExtraPatternEffectInst()
	return self:getAsset(kExtraPatternEffectPath)
end

function M:onStart()
	return
end

function M:onClear()
	self._resLoader:clear()
	self._resSpriteLoader:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Dice)

	self._diceObjs = {}
	self._allDiceObjs = {}

	goutil.clearChildren(kDiceRoot)
end

function M:addDice(id)
	return
end

function M:getDiceObj(idx)
	idx = idx or 1
	self._diceObjs[idx] = self._diceObjs[idx] or {}

	if #self._diceObjs[idx] > 0 then
		local obj = self._diceObjs[idx][1]

		table.remove(self._diceObjs[idx], 1)

		return obj
	end

	local path = self:getDicePath(idx)
	local obj = goutil.clone(self:getAsset(path))

	obj.name = idx

	local scale = RoguelikeConst.DICE_SCALE

	Astral.TransformUtil.SetLocalScale(obj.transform, scale, scale, scale)
	goutil.addChildToParent(obj, kDiceRoot)
	table.insert(self._allDiceObjs, obj)

	return obj
end

function M:recoveryDiceObj(diceObj)
	if goutil.isNil(diceObj) then
		return
	end

	local idx = tonumber(diceObj.name)

	self._diceObjs[idx] = self._diceObjs[idx] or {}

	if TableUtil.contains(self._diceObjs[idx], diceObj) then
		return
	end

	local trigger = Astral.CollisionLuaComponentContainer.Add(diceObj, RogueDiceCompTrigger)

	if trigger then
		trigger:reset()
	end

	local rigidbody = diceObj:GetComponent("Rigidbody")

	rigidbody.centerOfMass = Vector3.zero
	rigidbody.isKinematic = false
	rigidbody.useGravity = true
	rigidbody.gameObject:GetComponent("BoxCollider").isTrigger = false

	Astral.TransformUtil.SetPos(diceObj.transform, 5555, 0, 0)
	goutil.setActive(diceObj, false)
	table.insert(self._diceObjs[idx], diceObj)
end

function M:recoveryAllDiceObj()
	for k, v in pairs(self._allDiceObjs) do
		self:recoveryDiceObj(v)
	end
end

function M:getDiceFaceName(idx)
	return kDiceFaceName[idx]
end

function M:setDicePattern(go, pattern)
	local materialSetter = MaterialSetter.Get(go)

	materialSetter:SetGameObject(go)

	local patternIcon = RoguelikeConst.GetPatterIcon(pattern)
	local texture = self:getDicePatternTexture(patternIcon)

	materialSetter:SetTexture(UnityEngine.Shader.PropertyToID("_BaseMap"), texture)
end

function M:getRoleDiceIndex()
	return kRoleDiceIndex
end

function M:getRoleWallDiceIndex()
	return 3
end

function M:getMonsterAttackDiceIndex()
	return 6
end

function M:getDiceIndex(diceMo)
	if diceMo then
		if diceMo:getMainDiceType() == RoguelikeConst.ROGUE_DICE_TYPE.PLAYER then
			if diceMo:getSpecialType() == 1 then
				return 2
			elseif diceMo:getSpecialType() == 2 then
				return 5
			else
				return 1
			end
		elseif diceMo:getMainDiceType() == RoguelikeConst.ROGUE_DICE_TYPE.ROSE then
			return 4
		elseif diceMo:getMainDiceType() == RoguelikeConst.ROGUE_DICE_TYPE.TRUTH then
			return 3
		elseif diceMo:getMainDiceType() == RoguelikeConst.ROGUE_DICE_TYPE.COMBAT then
			local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

			if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
				return 3
			end

			return 1
		end
	end

	return 1
end

return M
