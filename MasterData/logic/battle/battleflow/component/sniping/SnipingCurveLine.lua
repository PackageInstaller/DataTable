-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/sniping/SnipingCurveLine.lua

module("logic.battle.battleflow.component.sniping.SnipingCurveLine", package.seeall)

local SnipingCurveLine = class("SnipingCurveLine", IBattleReusable)
local kTexUSpeed = UnityEngine.Shader.PropertyToID("_Basics_Tex_U_Speed")
local kDefaultTexUSpeed = -1

SnipingCurveLine.mainGO = false
SnipingCurveLine._line = false

function SnipingCurveLine:ctor()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local goLine = resMgr:getInst(BattleResourceName.SnipingLine)
	local line = SpaceX.CurveLine.Get(goLine)

	goutil.addChildToParent(goLine, BattleGameObjectRootUtil.effectsRoot)

	line.pointCount = 2
	line.interpPointY = 5
	line.useWorldSpace = false
	self._ownerEntityId = false
	self._targetEntityId = false
	self._line = line
	self._materialSetter = MaterialSetter.Get(goLine)
	self.mainGO = goLine
end

function SnipingCurveLine:reuse()
	goutil.setActive(self.mainGO, true)
end

function SnipingCurveLine:reset()
	goutil.setActive(self.mainGO, false)
end

function SnipingCurveLine:destroy()
	goutil.destroy(self.mainGO)

	self._line = nil
	self._materialSetter = nil
	self.mainGO = nil
end

function SnipingCurveLine:setOwnerEntityId(ownerEntityId)
	self._ownerEntityId = ownerEntityId
end

function SnipingCurveLine:setTargetEntityId(targetEntityId)
	self._targetEntityId = targetEntityId
end

function SnipingCurveLine:getTargetEntityId()
	return self._targetEntityId
end

function SnipingCurveLine:isEqualOwnerEntityId(entityId)
	return self._ownerEntityId == entityId
end

function SnipingCurveLine:setStartPositionXYZ(x, y, z)
	self._line:SetStartPoint(x, y, z)
end

function SnipingCurveLine:setEndPositionXYZ(x, y, z)
	self._line:SetEndPoint(x, y, z)
end

function SnipingCurveLine:setPlaySpeed(playSpeed)
	local uspeed = kDefaultTexUSpeed * playSpeed

	self._materialSetter:SetFloat(kTexUSpeed, uspeed)
end

function SnipingCurveLine:rebuild()
	self._line:Rebuild()
end

return SnipingCurveLine
