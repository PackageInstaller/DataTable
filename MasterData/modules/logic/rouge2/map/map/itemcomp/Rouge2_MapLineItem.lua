-- chunkname: @modules/logic/rouge2/map/map/itemcomp/Rouge2_MapLineItem.lua

module("modules.logic.rouge2.map.map.itemcomp.Rouge2_MapLineItem", package.seeall)

local Rouge2_MapLineItem = class("Rouge2_MapLineItem", UserDataDispose)

Rouge2_MapLineItem.ShaderParamDict = {
	Angle = UnityEngine.Shader.PropertyToID("_Angle"),
	MainTex = UnityEngine.Shader.PropertyToID("_MainTex"),
	Start = UnityEngine.Shader.PropertyToID("_StartVec"),
	End = UnityEngine.Shader.PropertyToID("_EndVec"),
	Cut1 = UnityEngine.Shader.PropertyToID("_Cut1"),
	Cut2 = UnityEngine.Shader.PropertyToID("_Cut2")
}

function Rouge2_MapLineItem:init(go, map)
	self:__onInit()

	self.go = go
	self.tr = go.transform
	self.map = map
	self.select = false
	self.switch = false

	self:initLines()

	self.startPos = Vector4.New(0, 0, 0, 0)
	self.endPos = Vector4.New(0, 0, 0, 0)
	self.startPosVec2 = Vector2.New(0, 0)
	self.endPosVec2 = Vector2.New(0, 0)
	self.angle = 85

	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectNode, self.onSelectNode, self)
end

function Rouge2_MapLineItem:initLines()
	self.lineGoTab = self:getUserDataTb_()
	self.lineGoTab[Rouge2_MapEnum.LineType.CantArrive] = gohelper.findChild(self.go, "arc_1")
	self.lineGoTab[Rouge2_MapEnum.LineType.NotArrive] = gohelper.findChild(self.go, "arc_1")
	self.lineGoTab[Rouge2_MapEnum.LineType.CanArrive] = gohelper.findChild(self.go, "arc_2")
	self.lineGoTab[Rouge2_MapEnum.LineType.Arrived] = gohelper.findChild(self.go, "arc_out_2")
	self.selectLineWithAnimGo = gohelper.findChild(self.go, "arc_in")
	self.unselectLineWithAnimGo = gohelper.findChild(self.go, "arc_3")

	self:hideAllLines()

	self.meshRenderTab = self:getUserDataTb_()
	self.meshRenderTab[Rouge2_MapEnum.LineType.CantArrive] = self.lineGoTab[Rouge2_MapEnum.LineType.CantArrive]:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
	self.meshRenderTab[Rouge2_MapEnum.LineType.NotArrive] = self.lineGoTab[Rouge2_MapEnum.LineType.NotArrive]:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
	self.meshRenderTab[Rouge2_MapEnum.LineType.CanArrive] = self.lineGoTab[Rouge2_MapEnum.LineType.CanArrive]:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
	self.meshRenderTab[Rouge2_MapEnum.LineType.Arrived] = self.lineGoTab[Rouge2_MapEnum.LineType.Arrived]:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
	self.selectLineWithAnimRenderList = self.selectLineWithAnimGo:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
	self.unselectLineWithAnimRenderList = self.unselectLineWithAnimGo:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
end

function Rouge2_MapLineItem:hideAllLines()
	for _, lineGo in pairs(self.lineGoTab) do
		gohelper.setActive(lineGo, false)
	end

	gohelper.setActive(self.selectLineWithAnimGo, false)
	gohelper.setActive(self.unselectLineWithAnimGo, false)
end

function Rouge2_MapLineItem:drawLine(curNode, preNode)
	self.curNode = curNode
	self.preNode = preNode
	self.curEpisodeIndex = curNode.episodeId
	self.curArriveStatus = self.curNode.arriveStatus
	self.preArriveStatus = self.preNode.arriveStatus
	self.type = Rouge2_MapHelper.getLineType(self.curArriveStatus, self.preArriveStatus)
	self.go.name = string.format("%s_%s-%s_%s", self.curEpisodeIndex - 1, self.preNode.index, self.curEpisodeIndex, self.curNode.index)

	self:refreshPos()
end

function Rouge2_MapLineItem:refreshPos()
	local curPosX, curPosY = Rouge2_MapHelper.getNodeContainerPos(self.curEpisodeIndex, self.curNode:getEpisodePos())
	local prePosX, prePosY = Rouge2_MapHelper.getNodeContainerPos(self.curEpisodeIndex - 1, self.preNode:getEpisodePos())

	curPosX = curPosX - Rouge2_MapEnum.LineOffset
	prePosX = prePosX + Rouge2_MapEnum.LineOffset

	local centerPosX = (curPosX + prePosX) * 0.5
	local centerPosY = (curPosY + prePosY) * 0.5
	local len = math.sqrt((curPosX - prePosX)^2 + (curPosY - prePosY)^2)

	self:hideAllLines()

	local goLine, meshRenderList = self:geetLineAndMat()

	gohelper.setActive(goLine, true)

	self.startPosX = -len * 0.5
	self.endPosX = -self.startPosX

	self.startPos:Set(self.startPosX, 0, 0, 0)
	self.startPosVec2:Set(self.startPosX, 0)
	self.endPos:Set(self.endPosX, 0, 0, 0)
	self.endPosVec2:Set(self.endPosX, 0, 0, 0)

	if meshRenderList then
		local meshRenderNum = meshRenderList.Length

		for i = 0, meshRenderNum - 1 do
			local mat = meshRenderList[i].material

			mat:SetVector(Rouge2_MapLineItem.ShaderParamDict.Start, self.startPos)
			mat:SetVector(Rouge2_MapLineItem.ShaderParamDict.End, self.endPos)
		end
	end

	transformhelper.setLocalPos(self.tr, centerPosX, centerPosY, 0)

	local rotationZ = Rouge2_MapHelper.getAngle(prePosX, prePosY, curPosX, curPosY)

	transformhelper.setLocalRotation(self.tr, 0, 0, rotationZ)
end

function Rouge2_MapLineItem:geetLineAndMat()
	local goLine, meshRenderList

	if self.type == Rouge2_MapEnum.LineType.CanArrive and self.switch then
		goLine = self.select and self.selectLineWithAnimGo or self.unselectLineWithAnimGo
		meshRenderList = self.select and self.selectLineWithAnimRenderList or self.unselectLineWithAnimRenderList
	else
		goLine = self.lineGoTab[self.type]
		meshRenderList = self.meshRenderTab[self.type]
	end

	return goLine, meshRenderList
end

function Rouge2_MapLineItem:onUpdateMapInfo()
	if not self:checkNeedRefresh() then
		return
	end

	self.curArriveStatus = self.curNode.arriveStatus
	self.preArriveStatus = self.preNode.arriveStatus
	self.type = Rouge2_MapHelper.getLineType(self.curArriveStatus, self.preArriveStatus)

	self:refreshPos()
end

function Rouge2_MapLineItem:onSelectNode(nodeMo)
	local select = nodeMo == self.curNode

	if self.select == select then
		return
	end

	self.select = select
	self.switch = true

	self:refreshPos()
end

function Rouge2_MapLineItem:checkNeedRefresh()
	return self.curArriveStatus ~= self.curNode.arriveStatus or self.preArriveStatus ~= self.preNode.arriveStatus
end

function Rouge2_MapLineItem:getActorPos(rate)
	local x, y = ZProj.ArcFollowHelper.GetArcToLocalPos(rate, self.startPosVec2, self.endPosVec2, self.angle, nil, nil)

	x, y = SLFramework.TransformHelper.LocalPosToWorldPos(self.tr, x, y, 0, nil, nil, nil)
	x, y = SLFramework.TransformHelper.WorldPosToLocalPos(self.map.trLayerPiecesContainer, x, y, 0, nil, nil, nil)

	return x, y, 0
end

function Rouge2_MapLineItem:destroy()
	self:__onDispose()
end

return Rouge2_MapLineItem
