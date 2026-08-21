-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/halo/HaloLinkCurveLine.lua

module("logic.battle.battleflow.component.halo.HaloLinkCurveLine", package.seeall)

local HaloLinkCurveLine = class("HaloLinkCurveLine", IBattleReusable)
local kTexUSpeed = UnityEngine.Shader.PropertyToID("_Basics_Tex_U_Speed")
local kDefaultTexUSpeed = -1
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kHaloLinksRoot = goutil.create("HaloLinks")

goutil.addChildToParent(kHaloLinksRoot, kSceneRoot)

HaloLinkCurveLine.mainGO = false
HaloLinkCurveLine._line = false

function HaloLinkCurveLine:ctor()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local goLine = resMgr:getInst(BattleResourceName.HaloLinks)
	local line = SpaceX.CurveLine.Get(goLine)

	goutil.addChildToParent(goLine, kHaloLinksRoot)

	line.pointCount = 2
	line.interpPointY = 5
	line.useWorldSpace = false
	line.lineWidth = 0.02
	self._line = line
	self._materialSetter = MaterialSetter.Get(goLine)
	self.mainGO = goLine
end

function HaloLinkCurveLine:reuse()
	goutil.setActive(self.mainGO, true)
end

function HaloLinkCurveLine:reset()
	goutil.setActive(self.mainGO, false)
end

function HaloLinkCurveLine:destroy()
	goutil.destroy(self.mainGO)

	self._line = nil
	self._materialSetter = nil
	self.mainGO = nil
end

function HaloLinkCurveLine:setStartPositionXYZ(x, y, z)
	self._line:SetStartPoint(x, y, z)
end

function HaloLinkCurveLine:setEndPositionXYZ(x, y, z)
	self._line:SetEndPoint(x, y, z)
end

function HaloLinkCurveLine:setColorString(colorString)
	self._line:SetColorString(colorString)
end

function HaloLinkCurveLine:setPlaySpeed(playSpeed)
	local uspeed = kDefaultTexUSpeed * playSpeed

	self._materialSetter:SetFloat(kTexUSpeed, uspeed)
end

function HaloLinkCurveLine:rebuild()
	self._line:Rebuild()
end

return HaloLinkCurveLine
