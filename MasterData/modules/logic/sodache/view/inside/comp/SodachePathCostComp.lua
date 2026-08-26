-- chunkname: @modules/logic/sodache/view/inside/comp/SodachePathCostComp.lua

module("modules.logic.sodache.view.inside.comp.SodachePathCostComp", package.seeall)

local SodachePathCostComp = class("SodachePathCostComp", LuaCompBase)

function SodachePathCostComp:init(go)
	self.go = go
	self._anim = gohelper.findComponentAnim(go)
	self._txtcur = gohelper.findChildTextMesh(go, "bg/#txt_current")
	self._txtuse = gohelper.findChildTextMesh(go, "bg/#txt_use")
	self._uiFollower = gohelper.onceAddComponent(go, typeof(ZProj.UIFollower))

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	gohelper.setActive(go, true)
	self._anim:Play("close", 0, 1)
	self._uiFollower:Set(mainCamera, uiCamera, plane, self.go.transform, 0, 0.4, 0, 0, 0)
end

function SodachePathCostComp:setTargetGo(go, nodeCo, pathInfo)
	local dis = pathInfo and pathInfo.dis
	local costStr = ""

	self.nodeCo = nodeCo

	if go then
		self._anim:Play("open")

		local cost = SodacheUtil.getAttr(SodacheEnum.AttrId.MoveFirstCost) + dis * SodacheUtil.getAttr(SodacheEnum.AttrId.MoveStepCost)

		cost = math.floor(cost * (1 + SodacheUtil.getAttr(SodacheEnum.AttrId.MoveActionFixPer) / 1000))
		cost = cost + SodacheUtil.getAttr(SodacheEnum.AttrId.MoveActionFix)
		costStr = -cost
		self._txtuse.text = -cost
		self._txtcur.text = SodacheUtil.getAttr(SodacheEnum.AttrId.ActionPoint)

		self._uiFollower:SetTarget3d(go.transform)
		self._uiFollower:SetEnable(true)
	else
		self._uiFollower:SetEnable(false)
		self._anim:Play("close")
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnPathCostStrChange, costStr, pathInfo)
end

return SodachePathCostComp
