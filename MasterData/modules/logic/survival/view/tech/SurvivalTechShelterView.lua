-- chunkname: @modules/logic/survival/view/tech/SurvivalTechShelterView.lua

module("modules.logic.survival.view.tech.SurvivalTechShelterView", package.seeall)

local SurvivalTechShelterView = class("SurvivalTechShelterView", BaseView)

function SurvivalTechShelterView:onInitView()
	self.content = gohelper.findChild(self.viewGO, "root/ScrollView/Viewport/Content")
	self.cells = gohelper.findChild(self.viewGO, "root/ScrollView/Viewport/Content/cells")
	self.lockAreas = gohelper.findChild(self.viewGO, "root/ScrollView/Viewport/Content/lockAreas")
	self.BG = gohelper.findChild(self.viewGO, "root/ScrollView/Viewport/Content/BG")
	self.techDesc = gohelper.findChild(self.viewGO, "root/techDesc")
	self.animTechDesc = SLFramework.AnimatorPlayer.Get(self.techDesc)
	self.textDesc = gohelper.findChildTextMesh(self.techDesc, "textDesc")
	self.textName = gohelper.findChildTextMesh(self.techDesc, "textName")
	self.textPoint = gohelper.findChildTextMesh(self.techDesc, "textTechPoint")
	self.btnLocked = gohelper.findChildButtonWithAudio(self.techDesc, "btnLocked")
	self.txt_locked = gohelper.findChildTextMesh(self.btnLocked.gameObject, "#txt_locked")
	self.btnUp = gohelper.findChildButtonWithAudio(self.techDesc, "btnUp")
	self.btnLack = gohelper.findChildButtonWithAudio(self.techDesc, "btnLack")
	self.State_Sp = gohelper.findChild(self.techDesc, "Item/State_Sp")
	self.btn_closeDetail = gohelper.findChildButtonWithAudio(self.viewGO, "root/ScrollView/btn_closeDetail")
	self.lines = gohelper.findChild(self.viewGO, "root/ScrollView/Viewport/Content/lines")
	self.line1 = gohelper.findChild(self.lines, "line1")
	self.line2 = gohelper.findChild(self.lines, "line2")
	self.image_talenicon = gohelper.findChildImage(self.techDesc, "Item/#image_talenicon")
	self.survivalrolelevelcomp = gohelper.findChild(self.viewGO, "root/Title/survivalrolelevelcomp")

	gohelper.setActive(self.techDesc, false)

	self.survivalRoleLevelComp = GameFacade.createLuaCompByGo(self.survivalrolelevelcomp, SurvivalRoleLevelComp)

	self.survivalRoleLevelComp:setOnClickFunc(self.onClickBtnLevel, self)

	self.survivalroleleveltipcomp = gohelper.findChild(self.viewGO, "root/Title/survivalroleleveltipcomp")

	local param = SimpleListParam.New()

	param.cellClass = SurvivalTechShelterCellItem
	self.cellList = GameFacade.createSimpleListComp(self.cells, param, nil, self.viewContainer)

	self.cellList:setOnClickItem(self.onClickCell, self)
	self.cellList:setOnSelectChange(self.onCellSelectChange, self)

	param = SimpleListParam.New()
	param.cellClass = SurvivalTechLockArea
	self.areaList = GameFacade.createSimpleListComp(self.lockAreas, param, nil, self.viewContainer)
	param = SimpleListParam.New()
	param.cellClass = SurvivalTechBkgItem
	self.bkgList = GameFacade.createSimpleListComp(self.BG, param, nil, self.viewContainer)
end

function SurvivalTechShelterView:addEvents()
	self.addClickCb(self, self.btnUp, self.onClickBtnUp, self)
	self.addClickCb(self, self.btnLack, self.onClickBtnLack, self)
	self.addClickCb(self, self.btn_closeDetail, self.onClickBtn_closeDetail, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalUnlockInsideTechReply, self.onReceiveSurvivalUnlockInsideTechReply, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function SurvivalTechShelterView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)

	self.buildingId = self.viewParam.buildingId
	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	self.mo = self.weekInfo:getBuildingInfo(self.buildingId)
	self.survivalTechShelterMo = self.mo.survivalTechShelterMo

	self.survivalRoleLevelComp:setData()
	self:refreshTech()
	self:createLine()
end

function SurvivalTechShelterView:onClose()
	return
end

function SurvivalTechShelterView:onDestroyView()
	return
end

function SurvivalTechShelterView:onShelterBagUpdate()
	self:refreshDescBtn()
	self:refreshTech()
	self:refreshLine()
end

function SurvivalTechShelterView:onReceiveSurvivalUnlockInsideTechReply(msg)
	AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_unlock)
	self:refreshDescBtn()
	self:refreshTech()
	self:refreshLine()

	local items = self.cellList:getItems()

	for i, v in ipairs(items) do
		if v.cfg.id == msg.id then
			v:playUpAnim()

			break
		end
	end

	for curId, dic in pairs(self.goLineDic) do
		for preId, info in pairs(dic) do
			if preId == msg.id then
				local animLight = info.animLight

				animLight:Play("light")
			end
		end
	end
end

function SurvivalTechShelterView:onClickBtnLevel()
	GameFacade.openTipPopView(ViewName.SurvivalRoleLevelTipPopView, self.survivalroleleveltipcomp)
end

function SurvivalTechShelterView:onClickCell(survivalTechShelterCellItem)
	self.cellList:setSelect(survivalTechShelterCellItem.itemIndex)
end

function SurvivalTechShelterView:onClickBtn_closeDetail()
	self.cellList:setSelect(nil)
end

function SurvivalTechShelterView:onClickBtnUp()
	local isCanUp = self.survivalTechShelterMo:isCanUp(self.infoNodeTeachCellId)

	if isCanUp then
		SurvivalWeekRpc.instance:sendSurvivalUnlockInsideTechRequest(self.infoNodeTeachCellId)
	end
end

function SurvivalTechShelterView:onClickBtnLack()
	local isPreNodeSatisfy = self.survivalTechShelterMo:isPreNodeSatisfy(self.infoNodeTeachCellId)
	local isTechPointSatisfy = self.survivalTechShelterMo:isTechPointSatisfy(self.infoNodeTeachCellId)

	if not isTechPointSatisfy then
		GameFacade.showToast(ToastEnum.SurvivalNoMoney)
	elseif not isPreNodeSatisfy then
		GameFacade.showToastString(luaLang("SurvivalTechView_5"))
	end
end

function SurvivalTechShelterView:onCellSelectChange(item, itemIndex)
	if itemIndex then
		self:setTechInfoNode(true, item.cfg.id)
	else
		self:setTechInfoNode(nil)
	end
end

function SurvivalTechShelterView:refreshTech()
	local data = {}

	self.techList = SurvivalTechConfig.instance:getInsideTechList()

	for i, cfg in ipairs(self.techList) do
		table.insert(data, {
			cfg = cfg,
			survivalTechShelterMo = self.survivalTechShelterMo
		})
	end

	self.cellList:setData(data, false)

	self.cellItemDic = {}
	self.maxGroup = 0
	self.levelCell = {}

	local xMax = 0
	local xStartPos = -780
	local yStartPos = 190
	local xSpace = 205
	local ySpace = -190
	local items = self.cellList:getItems()

	for i, v in ipairs(items) do
		local cfg = v.cfg
		local level = cfg.needLv
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

		if self.levelCell[level] == nil then
			self.levelCell[level] = {}
		end

		local info = self.levelCell[level]

		if not info.minColum or column < info.minColum then
			info.minColum = column
		end

		if not info.maxColum or column > info.maxColum then
			info.maxColum = column
		end
	end

	local w = xMax - xStartPos + 250

	recthelper.setWidth(self.content.transform, w)

	data = {}

	for level, info in pairs(self.levelCell) do
		table.insert(data, {
			level = level
		})
	end

	self.areaList:setData(data)

	local areaItems = self.areaList:getItems()

	for i, item in ipairs(areaItems) do
		local level = item.level
		local info = self.levelCell[level]
		local minColum = info.minColum
		local maxColum = info.maxColum
		local minX = xStartPos + (minColum - 1) * xSpace
		local maxX = xStartPos + (maxColum - 1) * xSpace
		local dis = maxX - minX
		local x = minX + dis / 2

		recthelper.setAnchorX(item.viewGO.transform, x)
		recthelper.setWidth(item.viewGO.transform, dis + 140 + 50)
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local clientMo = weekInfo.clientData
	local clientData = clientMo.data
	local techLockCheckLevel = clientData.techLockCheckLevel
	local items = self.areaList:getItems()

	for i, v in ipairs(items) do
		if v.isUnLock and techLockCheckLevel < v.level then
			v:playUnLockAnim()
		end
	end

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo

	clientMo:setTechLockCheckLevel(survivalShelterRoleMo.level)
	clientMo:saveDataToServer()

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

function SurvivalTechShelterView:createLine()
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
			local line

			for j, preNodeId in ipairs(ids) do
				local preCfg = lua_survival_inside_tech.configDict[preNodeId]
				local prePointPos = string.splitToNumber(preCfg.point, "#")
				local preColumn = prePointPos[1]
				local preRow = prePointPos[2]
				local preItem = self.cellItemDic[preCfg.id]
				local prePosX, prePosY = recthelper.getAnchor(preItem.viewGO.transform)

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

				gohelper.setActive(light, self.survivalTechShelterMo:isFinish(preCfg.id))

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

function SurvivalTechShelterView:refreshLine()
	for curId, dic in pairs(self.goLineDic) do
		for preId, info in pairs(dic) do
			local light = info.light

			gohelper.setActive(light, self.survivalTechShelterMo:isFinish(preId))
		end
	end
end

function SurvivalTechShelterView:setTechInfoNode(isShow, teachCellId)
	if isShow then
		AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_draw)

		if not self.isShowTechDesc then
			gohelper.setActive(self.techDesc, true)
			self.animTechDesc:Play("open", nil, nil)
		end

		self.infoNodeTeachCellId = teachCellId
		self.infoNodeTeachCellCfg = lua_survival_inside_tech.configDict[teachCellId]

		self:refreshDescBtn()
	elseif self.isShowTechDesc then
		self.animTechDesc:Play("close", nil, nil)
	end

	self.isShowTechDesc = isShow
end

function SurvivalTechShelterView:refreshDescBtn()
	local isFinish = self.survivalTechShelterMo:isFinish(self.infoNodeTeachCellId)
	local isLevelSatisfy, needLv = self.survivalTechShelterMo:isLevelSatisfy(self.infoNodeTeachCellId)
	local isPreNodeSatisfy = self.survivalTechShelterMo:isPreNodeSatisfy(self.infoNodeTeachCellId)
	local isTechPointSatisfy = self.survivalTechShelterMo:isTechPointSatisfy(self.infoNodeTeachCellId)
	local isCanUp = not isFinish and isLevelSatisfy and isPreNodeSatisfy and isTechPointSatisfy

	gohelper.setActive(self.btnLocked, not isFinish and not isLevelSatisfy)
	gohelper.setActive(self.btnLack, not isFinish and isLevelSatisfy and (not isTechPointSatisfy or not isPreNodeSatisfy))
	gohelper.setActive(self.btnUp, isCanUp)
	gohelper.setActive(self.State_Sp, self.infoNodeTeachCellCfg.sign == 1)

	if not isLevelSatisfy then
		self.txt_locked.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalTechShelterView_1"), {
			needLv
		})
	end

	self.textName.text = self.infoNodeTeachCellCfg.name
	self.textDesc.text = self.infoNodeTeachCellCfg.desc

	if isFinish then
		gohelper.setActive(self.textPoint.gameObject, false)
	else
		gohelper.setActive(self.textPoint.gameObject, true)

		self.textPoint.text = not self.survivalTechShelterMo:isTechPointSatisfy(self.infoNodeTeachCellId) and string.format("<color=#D97373>%s</color>", self.survivalTechShelterMo:getCost(self.infoNodeTeachCellId)) or string.format("<color=#E8E4D6>%s</color>", self.survivalTechShelterMo:getCost(self.infoNodeTeachCellId))
	end

	local cfg = lua_survival_inside_tech.configDict[self.infoNodeTeachCellId]

	if not string.nilorempty(cfg.icon) then
		UISpriteSetMgr.instance:setSurvivalSprite2(self.image_talenicon, cfg.icon)
	end
end

return SurvivalTechShelterView
