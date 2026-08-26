-- chunkname: @modules/logic/survival/view/tech/fragment/SurvivalTechCommonFragment.lua

module("modules.logic.survival.view.tech.fragment.SurvivalTechCommonFragment", package.seeall)

local SurvivalTechCommonFragment = class("SurvivalTechCommonFragment", LuaCompBase)

function SurvivalTechCommonFragment:ctor(survivalTechView)
	self.survivalTechView = survivalTechView
end

function SurvivalTechCommonFragment:init(viewGO)
	self.viewGO = viewGO
	self.content = gohelper.findChild(viewGO, "ScrollView/Viewport/Content")
	self.BG = gohelper.findChild(self.viewGO, "ScrollView/Viewport/Content/BG")
	self.lines = gohelper.findChild(viewGO, "ScrollView/Viewport/Content/lines")
	self.line1 = gohelper.findChild(self.lines, "line1")
	self.line2 = gohelper.findChild(self.lines, "line2")
	self.cells = gohelper.findChild(viewGO, "ScrollView/Viewport/Content/cells")
	self.SurvivalTechCellItem = gohelper.findChild(self.cells, "SurvivalTechCellItem")

	local param = SimpleListParam.New()

	param.cellClass = SurvivalTechCellItem
	self.cellList = GameFacade.createSimpleListComp(self.cells, param, self.SurvivalTechCellItem, self.viewContainer)

	self.cellList:setOnClickItem(self.onClickCell, self)

	param = SimpleListParam.New()
	param.cellClass = SurvivalTechBkgItem
	self.bkgList = GameFacade.createSimpleListComp(self.BG, param, nil, self.viewContainer)
	self.survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo
end

function SurvivalTechCommonFragment:addEventListeners()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTechChange, self.onTechChange, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalOutSideTechUnlockReply, self.onReceiveSurvivalOutSideTechUnlockReply, self)
end

function SurvivalTechCommonFragment:onTechChange()
	self:refreshTech()
	self:refreshLine()
end

function SurvivalTechCommonFragment:onReceiveSurvivalOutSideTechUnlockReply(param)
	AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_unlock_2)
	self:refreshTech()
	self:refreshLine()

	local id = param.teachCellId
	local items = self.cellList:getItems()

	for i, v in ipairs(items) do
		if v.cfg.id == id then
			v:playUpAnim()

			break
		end
	end

	for curId, dic in pairs(self.goLineDic) do
		for preId, info in pairs(dic) do
			if preId == id then
				local animLight = info.animLight

				animLight:Play("light")
			end
		end
	end
end

function SurvivalTechCommonFragment:onClickCell(survivalTechCellItem)
	local cfg = survivalTechCellItem.cfg

	self.survivalTechView:selectCell(survivalTechCellItem.itemIndex, cfg.id)
end

function SurvivalTechCommonFragment:selectCell(itemIndex)
	self.cellList:setSelect(itemIndex)
end

function SurvivalTechCommonFragment:setData(techId)
	self.techId = techId

	self:refreshTech()
	self:createLine()
end

function SurvivalTechCommonFragment:refreshTech()
	local data = {}

	self.techList = SurvivalTechConfig.instance:getTechList(self.techId)

	for i, cfg in ipairs(self.techList) do
		table.insert(data, {
			cfg = cfg
		})
	end

	self.cellList:setData(data, false)

	self.cellItemDic = {}
	self.maxGroup = 0

	local xMax = 0
	local xStartPos = -780
	local yStartPos = 190
	local xSpace = 205
	local ySpace = -190
	local items = self.cellList:getItems()

	for i, v in ipairs(items) do
		local cfg = v.cfg
		local pos = string.splitToNumber(cfg.point, "#")
		local column = pos[1]
		local row = pos[2]
		local x = xStartPos + (column - 1) * xSpace
		local y = yStartPos + (row - 1) * ySpace

		recthelper.setAnchor(v.viewGO.transform, x, y)

		if xMax < x then
			xMax = x
		end

		self.cellItemDic[cfg.id] = v

		local groupNum = math.floor((column - 1) / 3) + 1

		if groupNum > self.maxGroup then
			self.maxGroup = groupNum
		end
	end

	local w = xMax - xStartPos + 250

	recthelper.setWidth(self.content.transform, w)

	data = {}

	for i = 1, self.maxGroup do
		table.insert(data, {})
	end

	self.bkgList:setData(data)

	items = self.bkgList:getItems()

	for i, item in ipairs(items) do
		local index = i * 3 - 1
		local x = xStartPos + (index - 1) * xSpace

		recthelper.setAnchorX(item.viewGO.transform, x)
	end
end

function SurvivalTechCommonFragment:createLine()
	local lineXOffset = 24
	local lineYOffset = 15

	self.goLineDic = {}

	local middleRow = 2

	for i, cfg in ipairs(self.techList) do
		local preNodes = cfg.preNodes

		if not string.nilorempty(preNodes) then
			local ids = string.splitToNumber(cfg.preNodes, "#")
			local pointPos = string.splitToNumber(cfg.point, "#")
			local curColumn = pointPos[1]
			local curRow = pointPos[2]
			local curItem = self.cellItemDic[cfg.id]
			local curPosX, curPosY = recthelper.getAnchor(curItem.viewGO.transform)

			for j, preNodeId in ipairs(ids) do
				local preCfg = lua_survival_outside_tech.configDict[preNodeId]
				local prePointPos = string.splitToNumber(preCfg.point, "#")
				local preColumn = prePointPos[1]
				local preRow = prePointPos[2]
				local preItem = self.cellItemDic[preCfg.id]
				local prePosX, prePosY = recthelper.getAnchor(preItem.viewGO.transform)
				local line

				if math.abs(preColumn - curColumn) == 1 and math.abs(preRow - curRow) == 1 then
					local xScale = 1
					local yScale = 1
					local xPos = prePosX + (curPosX - prePosX) / 2
					local yPos = prePosY + (curPosY - prePosY) / 2

					yScale = preRow <= middleRow and curRow <= middleRow and 1 or -1

					local v = curColumn - preColumn + (curRow - preRow)

					xScale = v == 0 and 1 or -1

					if yScale == -1 then
						xScale = -xScale
					end

					xPos = xPos + lineXOffset * -xScale
					yPos = yPos + lineYOffset * yScale
					line = gohelper.clone(self.line2, self.lines, string.format("斜线 %s_%s", preCfg.id, cfg.id))

					transformhelper.setLocalScale(line.transform, xScale, yScale, 1)
					recthelper.setAnchor(line.transform, xPos, yPos)
				else
					local xPos = prePosX + (curPosX - prePosX) / 2
					local yPos = prePosY + (curPosY - prePosY) / 2
					local rotation

					if preColumn == curColumn then
						rotation = 90
					elseif preRow == curRow then
						rotation = 0
					end

					line = gohelper.clone(self.line1, self.lines, string.format("直线 %s_%s", preCfg.id, cfg.id))

					recthelper.setAnchor(line.transform, xPos, yPos)
					transformhelper.setLocalRotation(line.transform, 0, 0, rotation)
				end

				local light = gohelper.findChild(line, "Light")

				gohelper.setActive(light, self.survivalOutSideTechMo:isFinish(self.techId, preCfg.id))

				local animLight = light:GetComponent(typeof(UnityEngine.Animator))

				if self.goLineDic[cfg.id] == nil then
					self.goLineDic[cfg.id] = {}
				end

				local t = self:getUserDataTb_()

				self.goLineDic[cfg.id][preCfg.id] = t
				t.go = line
				t.light = light
				t.animLight = animLight
			end
		end
	end

	gohelper.setActive(self.line1, false)
	gohelper.setActive(self.line2, false)
end

function SurvivalTechCommonFragment:refreshLine()
	for curId, dic in pairs(self.goLineDic) do
		for preId, info in pairs(dic) do
			local light = info.light

			gohelper.setActive(light, self.survivalOutSideTechMo:isFinish(self.techId, preId))
		end
	end
end

return SurvivalTechCommonFragment
