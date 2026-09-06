-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventRelationshipView.lua

module("logic.extensions.jieshenevent.view.JieShenEventRelationshipView", package.seeall)

local JieShenEventRelationshipView = class("JieShenEventRelationshipView", RoleRelationshipView)

function JieShenEventRelationshipView:ctor()
	JieShenEventRelationshipView.super.ctor(self)
end

function JieShenEventRelationshipView:unbindEvents()
	JieShenEventRelationshipView.super.unbindEvents(self)
end

function JieShenEventRelationshipView:bindEvents()
	JieShenEventRelationshipView.super.bindEvents(self)
end

function JieShenEventRelationshipView:buildUI()
	JieShenEventRelationshipView.super.buildUI(self)

	local cellGo = goutil.findChild(self.mainGO, "scoreprogressview/scrollercell")
	local updateCellHandler = GameUtil.handler(self._updateProgressCell, self)
	local clearCellHandler = GameUtil.handler(self._clearProgressCell, self)
	local exParams = {
		isHorizontal = true
	}

	self._progressList = ProgressList.create(self._proScrollerGo, cellGo, updateCellHandler, clearCellHandler, exParams)
end

function JieShenEventRelationshipView:onExit()
	JieShenEventRelationshipView.super.onExit(self)
end

function JieShenEventRelationshipView:onEnter()
	JieShenEventRelationshipView.super.onEnter(self)
end

function JieShenEventRelationshipView:_onUpdateShipLineUI()
	for shipId, rsShipData in ipairs(self._rsShipCfg) do
		local isShipLineHasConnect = self:_isShipLineHasConnect(shipId)
		local isLineSelected = self:_isLineSelected(shipId)

		self:_setLine(self._lineList, shipId, isShipLineHasConnect)
		self:_setLine(self._dotLineList, shipId, isLineSelected)

		if isShipLineHasConnect then
			local lineGo = self._lineList:getLineGo(shipId)

			if lineGo then
				local txtShipTab = goutil.findChildTextComponent(lineGo, "imgTabBg/txtShipTab")
				local tabBg = goutil.findChild(lineGo, "imgTabBg")
				local changeGroup = lineGo:GetComponent(ComponentType.UIChangeGroup)

				if txtShipTab then
					txtShipTab.text = rsShipData.txtShipTab or ""
				end

				if tabBg then
					Framework.TransformUtil.SetEuler(tabBg.gameObject.transform, 0, 0, 0)
				end

				if changeGroup and checknumber(rsShipData.showType) > 0 then
					changeGroup:SetState(rsShipData.showType - 1)
				end

				local arrowGo = goutil.findChild(lineGo, "imgArrow")

				GameUtil.SetActive(arrowGo, rsShipData.showArrow)
			end
		end
	end

	if self._rsBoxShipCfg then
		for shipId, rsBoxShipData in ipairs(self._rsBoxShipCfg) do
			local lineKey = "boxLine_" .. shipId

			self._lineList:showLine(rsBoxShipData.startPos, rsBoxShipData.endPos, lineKey)

			local lineGo = self._lineList:getLineGo(lineKey)

			if lineGo then
				local txtShipTab = goutil.findChildTextComponent(lineGo, "imgTabBg/txtShipTab")
				local tabBg = goutil.findChild(lineGo, "imgTabBg")
				local changeGroup = lineGo:GetComponent(ComponentType.UIChangeGroup)

				if txtShipTab then
					txtShipTab.text = rsBoxShipData.txtShipTab or ""
				end

				if tabBg then
					Framework.TransformUtil.SetEuler(tabBg.gameObject.transform, 0, 0, 0)
				end

				if changeGroup and checknumber(rsBoxShipData.showType) > 0 then
					changeGroup:SetState(rsBoxShipData.showType - 1)
				end

				local arrowGo = goutil.findChild(lineGo, "imgArrow")

				GameUtil.SetActive(arrowGo, rsBoxShipData.showArrow)
			end
		end
	end
end

function JieShenEventRelationshipView:_setLine(lineList, shipId, isShow)
	if isShow then
		local rsShipData = self._rsShipCfg[shipId]
		local roleIdA, roleIdB = rsShipData.shipLine[1], rsShipData.shipLine[2]
		local posA, posB = self._rsRoleCfg[roleIdA].headPos, self._rsRoleCfg[roleIdB].headPos

		lineList:showLine(posA, posB, shipId, -140)
	else
		lineList:hideLine(shipId)
	end
end

return JieShenEventRelationshipView
