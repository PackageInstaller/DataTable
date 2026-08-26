-- chunkname: @modules/logic/rouge/map/map/itemcomp/RougeMapLineItem.lua

module("modules.logic.rouge.map.map.itemcomp.RougeMapLineItem", package.seeall)

local RougeMapLineItem = class("RougeMapLineItem", UserDataDispose)

RougeMapLineItem.ShaderParamDict = {
	Angle = UnityEngine.Shader.PropertyToID("_Angle"),
	MainTex = UnityEngine.Shader.PropertyToID("_MainTex"),
	Start = UnityEngine.Shader.PropertyToID("_StartVec"),
	End = UnityEngine.Shader.PropertyToID("_EndVec"),
	Cut1 = UnityEngine.Shader.PropertyToID("_Cut1"),
	Cut2 = UnityEngine.Shader.PropertyToID("_Cut2")
}

function RougeMapLineItem:init(go, map)
	self:__onInit()

	self.go = go
	self.tr = go.transform
	self.map = map

	local renderGo = gohelper.findChild(self.go, "arc")
	local meshRender = renderGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	self.mat = meshRender.material
	self.startPos = Vector4.New(0, 0, 0, 0)
	self.endPos = Vector4.New(0, 0, 0, 0)
	self.startPosVec2 = Vector2.New(0, 0)
	self.endPosVec2 = Vector2.New(0, 0)
	self.angle = 85

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
end

function RougeMapLineItem:drawLine(curNode, preNode)
	self.curNode = curNode
	self.preNode = preNode
	self.curEpisodeIndex = curNode.episodeId
	self.curArriveStatus = self.curNode.arriveStatus
	self.preArriveStatus = self.preNode.arriveStatus
	self.go.name = string.format("%s_%s-%s_%s", self.curEpisodeIndex - 1, self.preNode.index, self.curEpisodeIndex, self.curNode.index)

	self:refreshPos()
	self:refreshLineTexture()
end

function RougeMapLineItem:refreshPos()
	local curPosX, curPosY = RougeMapHelper.getNodeContainerPos(self.curEpisodeIndex, self.curNode:getEpisodePos())
	local prePosX, prePosY = RougeMapHelper.getNodeContainerPos(self.curEpisodeIndex - 1, self.preNode:getEpisodePos())

	curPosX = curPosX - RougeMapEnum.LineOffset
	prePosX = prePosX + RougeMapEnum.LineOffset

	local centerPosX = (curPosX + prePosX) * 0.5
	local centerPosY = (curPosY + prePosY) * 0.5
	local len = math.sqrt((curPosX - prePosX)^2 + (curPosY - prePosY)^2)

	self.startPosX = -len * 0.5
	self.endPosX = -self.startPosX

	self.startPos:Set(self.startPosX, 0, 0, 0)
	self.startPosVec2:Set(self.startPosX, 0)
	self.mat:SetVector(RougeMapLineItem.ShaderParamDict.Start, self.startPos)
	self.endPos:Set(self.endPosX, 0, 0, 0)
	self.endPosVec2:Set(self.endPosX, 0, 0, 0)
	self.mat:SetVector(RougeMapLineItem.ShaderParamDict.End, self.endPos)
	transformhelper.setLocalPos(self.tr, centerPosX, centerPosY, 0)

	local rotationZ = RougeMapHelper.getAngle(prePosX, prePosY, curPosX, curPosY)

	transformhelper.setLocalRotation(self.tr, 0, 0, rotationZ)
	self:refreshLineProgress()
end

function RougeMapLineItem:refreshLineProgress()
	self.isCurNodeFog = self.curNode.fog
	self.isPreNodeFog = self.preNode.fog

	local isPreHoleNode = RougeMapModel.instance:isHoleNode(self.preNode.nodeId)
	local cut1Value = RougeMapEnum.NormalLineCutValue
	local cut2Value = RougeMapEnum.NormalLineCutValue

	if self.isCurNodeFog then
		if self.isPreNodeFog then
			cut1Value = RougeMapEnum.HideLineCutValue
			cut2Value = RougeMapEnum.HideLineCutValue
		else
			cut1Value = isPreHoleNode and RougeMapEnum.HoleLineCutValue or RougeMapEnum.FogLineCutValue
		end
	elseif self.isPreNodeFog then
		cut2Value = RougeMapEnum.HoleLineCutValue
	end

	self.mat:SetFloat(RougeMapLineItem.ShaderParamDict.Cut1, cut1Value)
	self.mat:SetFloat(RougeMapLineItem.ShaderParamDict.Cut2, cut2Value)
end

function RougeMapLineItem:refreshLineTexture()
	self.curArriveStatus = self.curNode.arriveStatus
	self.preArriveStatus = self.preNode.arriveStatus

	local type = RougeMapHelper.getLineType(self.curArriveStatus, self.preArriveStatus)

	self.mat:SetTexture(RougeMapLineItem.ShaderParamDict.MainTex, self.map.lineIconDict[type])
end

function RougeMapLineItem:onUpdateMapInfo()
	if not self:checkNeedRefresh() then
		return
	end

	self.curArriveStatus = self.curNode.arriveStatus
	self.preArriveStatus = self.preNode.arriveStatus

	self:refreshPos()
	self:refreshLineTexture()
end

function RougeMapLineItem:checkNeedRefresh()
	return self.curArriveStatus ~= self.curNode.arriveStatus or self.preArriveStatus ~= self.preNode.arriveStatus or self.isCurNodeFog ~= self.curNode.fog or self.isPreNodeFog ~= self.preNode.fog
end

function RougeMapLineItem:getActorPos(rate)
	local x, y = ZProj.ArcFollowHelper.GetArcToLocalPos(rate, self.startPosVec2, self.endPosVec2, self.angle, nil, nil)

	x, y = SLFramework.TransformHelper.LocalPosToWorldPos(self.tr, x, y, 0, nil, nil, nil)
	x, y = SLFramework.TransformHelper.WorldPosToLocalPos(self.map.trLayerPiecesContainer, x, y, 0, nil, nil, nil)

	return x, y, 0
end

function RougeMapLineItem:destroy()
	self:__onDispose()
end

return RougeMapLineItem
