-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameGridItem.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameGridItem", package.seeall)

local AssassinStealthGameGridItem = class("AssassinStealthGameGridItem", LuaCompBase)

function AssassinStealthGameGridItem:init(go)
	self.go = go
	self.trans = self.go.transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameGridItem:_editableInitView()
	self._gocontent = gohelper.findChild(self.go, "#go_content")
	self._transcontent = self._gocontent.transform
	self._simagegrid = gohelper.findChildSingleImage(self.go, "#go_content/#simage_grid")
	self._transimggrid = self._simagegrid.transform
	self._goqte = gohelper.findChild(self.go, "#go_content/#go_qte")
	self._gopointparent = gohelper.findChild(self.go, "#go_content/#go_points")
	self._gopointitem = gohelper.findChild(self.go, "#go_content/#go_points/#go_pointItem")
	self._gotrace = gohelper.findChild(self.go, "#go_content/#go_trace")
	self._transtrace = self._gotrace.transform
	self._gowarning = gohelper.findChild(self.go, "#go_content/#go_warring")
	self._goInfoLayout = gohelper.findChild(self.go, "#go_content/#go_infoLayout")
	self._goEnemyRefresh = gohelper.findChild(self.go, "#go_content/#go_infoLayout/#image_legend")
	self._imageEnemyRefreshIcon = gohelper.findChildImage(self.go, "#go_content/#go_infoLayout/#image_legend")
	self._goexpose = gohelper.findChild(self.go, "#go_content/#go_infoLayout/#go_expose")
	self._txtexpose = gohelper.findChildText(self.go, "#go_content/#go_infoLayout/#go_expose/#txt_expose")
	self._entranceNodeDict = self:getUserDataTb_()

	local goup = gohelper.findChild(self.go, "#go_content/#go_roofEntrance/#go_up")
	local godown = gohelper.findChild(self.go, "#go_content/#go_roofEntrance/#go_down")
	local goleft = gohelper.findChild(self.go, "#go_content/#go_roofEntrance/#go_left")
	local goright = gohelper.findChild(self.go, "#go_content/#go_roofEntrance/#go_right")

	self._entranceNodeDict[AssassinEnum.RoofEntranceDir.Up] = goup.transform
	self._entranceNodeDict[AssassinEnum.RoofEntranceDir.Down] = godown.transform
	self._entranceNodeDict[AssassinEnum.RoofEntranceDir.Left] = goleft.transform
	self._entranceNodeDict[AssassinEnum.RoofEntranceDir.Right] = goright.transform
	self._btnclick = gohelper.findChildClickWithAudio(self.go, "#go_content/#go_clickParent/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gohlicon = gohelper.findChild(self.go, "#go_content/#go_clickParent/#btn_click/#go_hlicon")
	self._imagehlicon = gohelper.findChildImage(self.go, "#go_content/#go_clickParent/#btn_click/#go_hlicon/#image_hlicon")
	self._transclick = self._btnclick.transform
	self._transclickParent = gohelper.findChild(self.go, "#go_content/#go_clickParent").transform
	self._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, AssassinStealthGameEffectComp)

	self:_initPoints()
	self:_checkShow()
end

function AssassinStealthGameGridItem:_initPoints()
	self.pointItemList = {}

	local allPointPosList = AssassinConfig.instance:getGridPointPosList()

	gohelper.CreateObjList(self, self._onCreatePointItem, allPointPosList, self._gopointparent, self._gopointitem)
end

function AssassinStealthGameGridItem:_onCreatePointItem(obj, data, index)
	local pointItem = self:getUserDataTb_()

	pointItem.go = obj
	pointItem.trans = pointItem.go.transform
	pointItem.go.name = index
	pointItem.gocontent = gohelper.findChild(pointItem.go, "#go_pointContent")
	pointItem.transcontent = pointItem.gocontent.transform
	pointItem.imageicon = gohelper.findChildImage(pointItem.go, "#go_pointContent/#image_icon")
	pointItem.iconTrans = pointItem.imageicon.transform
	pointItem.btn = gohelper.findChildClickWithAudio(pointItem.go, "#go_pointContent/#image_icon/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	pointItem.normalhl = gohelper.findChild(pointItem.go, "#go_pointContent/#image_icon/#btn_click/highlight")
	pointItem.gardenhl = gohelper.findChild(pointItem.go, "#go_pointContent/#image_icon/#btn_click/highlight_garden")
	pointItem.haystackhl = gohelper.findChild(pointItem.go, "#go_pointContent/#image_icon/#btn_click/highlight_haystack")
	pointItem.haystackhl1 = gohelper.findChild(pointItem.go, "#go_pointContent/#image_icon/#btn_click/highlight_haystack_01")

	pointItem.btn:AddClickListener(self._clickPoint, self, index)
	transformhelper.setLocalPosXY(pointItem.trans, data.x, data.y)

	self.pointItemList[index] = pointItem
end

function AssassinStealthGameGridItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinStealthGameGridItem:removeEventListeners()
	self._btnclick:RemoveClickListener()

	for _, pointItem in ipairs(self.pointItemList) do
		pointItem.btn:RemoveClickListener()
	end
end

function AssassinStealthGameGridItem:_btnclickOnClick()
	AssassinStealthGameController.instance:clickGridItem(self.id)
end

function AssassinStealthGameGridItem:_clickPoint(index)
	AssassinStealthGameController.instance:clickGridItem(self.id, index)
end

function AssassinStealthGameGridItem:initData(gridId)
	self.id = gridId
	self.go.name = self.id
	self._goInfoLayout.name = string.format("gridInfo-%s", self.id)
end

function AssassinStealthGameGridItem:setEffParent(effParentGo, effParentTrans)
	self._effectParent = effParentGo
	self._effectParentTrans = effParentTrans
end

function AssassinStealthGameGridItem:setMap(mapId)
	self.mapId = mapId

	local worldPos = self:getGoPosition()

	self._effPos = self._effectParentTrans:InverseTransformPoint(worldPos)

	self:_checkShow()
end

function AssassinStealthGameGridItem:_checkShow()
	self._isShow = AssassinConfig.instance:isShowGrid(self.mapId, self.id)

	self:setGrid()
	self:refresh()

	local infoParent

	if self._isShow then
		infoParent = AssassinStealthGameEntityMgr.instance:getInfoTrans()
	end

	if gohelper.isNil(infoParent) then
		infoParent = self._transcontent
	end

	self._goInfoLayout.transform:SetParent(infoParent, true)
	gohelper.setActive(self._gocontent, self._isShow)
end

function AssassinStealthGameGridItem:setGrid()
	if not self._isShow then
		return
	end

	self:setGridType()
	self:setPoint()
	self:setIsEasyExpose()
end

function AssassinStealthGameGridItem:setGridType()
	local img = AssassinConfig.instance:getStealthGridImg(self.mapId, self.id)

	if not string.nilorempty(img) then
		local imgPath = ResUrl.getSp01AssassinSingleBg("stealth/" .. img)

		self._simagegrid:LoadImage(imgPath)
	end

	local rotation = AssassinConfig.instance:getStealthGridRotation(self.mapId, self.id)

	transformhelper.setLocalRotation(self._transimggrid, 0, 0, rotation)
end

function AssassinStealthGameGridItem:setPoint()
	if not self.pointItemList then
		return
	end

	for index, pointItem in ipairs(self.pointItemList) do
		local x = 0
		local y = 0
		local pointType = AssassinConfig.instance:getGridPointType(self.mapId, self.id, index)

		if pointType and pointType ~= AssassinEnum.StealthGamePointType.Empty then
			local icon, rotation = AssassinConfig.instance:getPointTypeShowData(self.mapId, self.id, index)

			if pointType == AssassinEnum.StealthGamePointType.Tower then
				local pos = AssassinEnum.TowerPointPos[index]

				x = pos and pos.x or x
				y = pos and pos.y or y
				icon = string.format("%s_%s", icon, index)
			elseif pointType == AssassinEnum.StealthGamePointType.Garden then
				gohelper.setActive(pointItem.normalhl, false)
				gohelper.setActive(pointItem.gardenhl, true)
				gohelper.setActive(pointItem.haystackhl, false)
				gohelper.setActive(pointItem.haystackhl1, false)
			elseif pointType == AssassinEnum.StealthGamePointType.HayStack then
				gohelper.setActive(pointItem.normalhl, false)
				gohelper.setActive(pointItem.gardenhl, false)

				local isExtraIcon = icon == "assassin2_stealth_game_haystack_01"

				gohelper.setActive(pointItem.haystackhl, not isExtraIcon)
				gohelper.setActive(pointItem.haystackhl1, isExtraIcon)
			else
				gohelper.setActive(pointItem.normalhl, true)
				gohelper.setActive(pointItem.gardenhl, false)
				gohelper.setActive(pointItem.haystackhl, false)
				gohelper.setActive(pointItem.haystackhl1, false)
			end

			UISpriteSetMgr.instance:setSp01AssassinSprite(pointItem.imageicon, icon, true)
			transformhelper.setEulerAngles(pointItem.transcontent, 0, 0, rotation)
			gohelper.setActive(pointItem.gocontent, true)
		else
			gohelper.setActive(pointItem.gocontent, false)
		end

		transformhelper.setLocalPosXY(pointItem.iconTrans, x, y)
	end
end

function AssassinStealthGameGridItem:setIsEasyExpose()
	local isEasyExpose = AssassinConfig.instance:getGridIsEasyExpose(self.mapId, self.id)

	gohelper.setActive(self._gowarning, isEasyExpose)
end

function AssassinStealthGameGridItem:changeHighlightClickParent(parentTrans)
	if gohelper.isNil(parentTrans) then
		self._transclick:SetParent(self._transclickParent)
	else
		self._transclick:SetParent(parentTrans)
	end

	self:refreshHighlightPos()
end

function AssassinStealthGameGridItem:refreshHighlightPos()
	local worldPos = self:getGoPosition()
	local pos = self._transclick.parent:InverseTransformPoint(worldPos)

	transformhelper.setLocalPosXY(self._transclick, pos.x, pos.y)
end

function AssassinStealthGameGridItem:refresh(effectId)
	self:refreshGridCanClick()
	self:refreshPointCanClick()
	self:refreshIsQteGrid()
	self:refreshTrace()
	self:refreshEnemyRefreshPoint()
	self:refreshTrap()
	self:playEffect(effectId)
end

function AssassinStealthGameGridItem:refreshGridCanClick()
	if not self._isShow then
		return
	end

	local isCanMove = AssassinStealthGameHelper.isSelectedHeroCanMoveTo(self.id)
	local isCanUseSkillProp2Grid = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(self.id)
	local hasAliveEnemy = AssassinStealthGameModel.instance:isHasAliveEnemy(self.id)

	if isCanMove and hasAliveEnemy then
		local exposeRate = AssassinStealthGameModel.instance:getExposeRate(self.id)

		self._txtexpose.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), exposeRate)

		gohelper.setActive(self._goexpose, true)
	else
		gohelper.setActive(self._goexpose, false)
	end

	if isCanUseSkillProp2Grid then
		local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

		if selectedIsSkill then
			AssassinHelper.setAssassinSkillIcon(selectedSkillPropId, self._imagehlicon)
		else
			AssassinHelper.setAssassinItemIcon(selectedSkillPropId, self._imagehlicon)
		end
	end

	gohelper.setActive(self._gohlicon, isCanUseSkillProp2Grid)
	gohelper.setActive(self._btnclick, isCanMove or isCanUseSkillProp2Grid)
end

function AssassinStealthGameGridItem:refreshPointCanClick()
	if not self._isShow then
		return
	end

	for index, pointItem in ipairs(self.pointItemList) do
		local pointType = AssassinConfig.instance:getGridPointType(self.mapId, self.id, index)

		gohelper.setActive(pointItem.btn, (pointType and pointType ~= AssassinEnum.StealthGamePointType.Empty or nil) and AssassinStealthGameHelper.isSelectedHeroCanMoveTo(self.id, index))
	end
end

function AssassinStealthGameGridItem:refreshIsQteGrid()
	if not self._isShow then
		return
	end

	local isShowQte = false
	local isQTEGrid = AssassinStealthGameModel.instance:isQTEInteractGrid(self.id)

	if isQTEGrid then
		isShowQte = true
	else
		local missionId = AssassinStealthGameModel.instance:getMissionId()

		if missionId and missionId ~= 0 then
			local missionType = AssassinConfig.instance:getStealthMissionType(missionId)

			if missionType == AssassinEnum.MissionType.TargetGrid1 or missionType == AssassinEnum.MissionType.TargetGrid2 or missionType == AssassinEnum.MissionType.TargetGrid3 then
				local targetGrids = AssassinConfig.instance:getStealthMissionParam(missionId, true)

				if targetGrids then
					for _, targetGridId in ipairs(targetGrids) do
						if targetGridId == self.id then
							isShowQte = true

							break
						end
					end
				end
			end
		end
	end

	gohelper.setActive(self._goqte, isShowQte)
end

function AssassinStealthGameGridItem:refreshTrace()
	local pointTrans
	local gridMo = AssassinStealthGameModel.instance:getGridMo(self.id)
	local tracePointIndex = gridMo and gridMo:getTracePointIndex()

	if tracePointIndex and tracePointIndex > 0 then
		pointTrans = self:getPointTrans(tracePointIndex)
	end

	if gohelper.isNil(pointTrans) then
		gohelper.setActive(self._gotrace, false)
	else
		self._transtrace:SetParent(pointTrans, false)
		gohelper.setActive(self._gotrace, true)
	end
end

function AssassinStealthGameGridItem:refreshEnemyRefreshPoint()
	local refreshData
	local missionId = AssassinStealthGameModel.instance:getMissionId()

	if missionId and missionId ~= 0 then
		local isAlertBellRing = AssassinStealthGameModel.instance:isAlertBellRing()
		local refreshId1, refreshId2 = AssassinConfig.instance:getStealthMissionRefresh(missionId)
		local refreshId = isAlertBellRing and refreshId2 or refreshId1

		refreshData = AssassinConfig.instance:getEnemyRefreshData(refreshId, self.id)
	end

	if refreshData then
		UISpriteSetMgr.instance:setSp01AssassinSprite(self._imageEnemyRefreshIcon, string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", refreshData.index))
	end

	gohelper.setActive(self._goEnemyRefresh, refreshData)
end

function AssassinStealthGameGridItem:refreshTrap()
	local gridMo = AssassinStealthGameModel.instance:getGridMo(self.id)

	if not gridMo then
		return
	end

	local hasFog = gridMo:getHasFog()

	if hasFog then
		self:playEffect(AssassinEnum.EffectId.GridFog)
	else
		self:removeEffect(AssassinEnum.EffectId.GridFog)
	end

	local trapTypeDict = AssassinConfig.instance:getTrapTypeList()

	for trapType, trapIdList in ipairs(trapTypeDict) do
		local effectId = AssassinConfig.instance:getAssassinTrapEffectId(trapIdList[1])
		local hasTrap = gridMo:hasTrapType(trapType)

		if hasTrap then
			self:playEffect(effectId)
		else
			self:removeEffect(effectId)
		end
	end
end

function AssassinStealthGameGridItem:playEffect(effectId, finishCb, finishCbObj, finishCbParam, parentObj, localPos)
	if self._isShow and self._effectComp then
		if gohelper.isNil(parentObj) then
			self._effectComp:playEffect(effectId, finishCb, finishCbObj, finishCbParam, self._effectParent, self._effPos)
		else
			self._effectComp:playEffect(effectId, finishCb, finishCbObj, finishCbParam, parentObj, localPos)
		end
	end
end

function AssassinStealthGameGridItem:removeEffect(effectId)
	if not self._effectComp or not effectId or effectId == 0 then
		return
	end

	self._effectComp:removeEffect(effectId)
end

function AssassinStealthGameGridItem:isShow()
	return self._isShow
end

function AssassinStealthGameGridItem:getGoPosition()
	return self.trans.position
end

function AssassinStealthGameGridItem:getPointTrans(pointIndex)
	local pointItem = self.pointItemList[pointIndex]

	return pointItem and pointItem.trans
end

function AssassinStealthGameGridItem:getEntranceNodeTrans(dir)
	return self._entranceNodeDict[dir]
end

function AssassinStealthGameGridItem:onDestroy()
	self._simagegrid:UnLoadImage()

	self.pointItemList = nil

	gohelper.destroy(self._transclick)
	gohelper.destroy(self._goInfoLayout)
end

return AssassinStealthGameGridItem
