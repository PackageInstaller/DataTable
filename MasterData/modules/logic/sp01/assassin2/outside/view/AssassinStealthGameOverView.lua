-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameOverView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameOverView", package.seeall)

local AssassinStealthGameOverView = class("AssassinStealthGameOverView", BaseView)

function AssassinStealthGameOverView:onInitView()
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._btninfo = gohelper.findChildClickWithAudio(self.viewGO, "root/topTab/#btn_info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goinfoUnselect = gohelper.findChild(self.viewGO, "root/topTab/#btn_info/#go_infoUnselect")
	self._goinfoSelect = gohelper.findChild(self.viewGO, "root/topTab/#btn_info/#go_infoSelect")
	self._btnevent = gohelper.findChildClickWithAudio(self.viewGO, "root/topTab/#btn_event", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goeventUnselect = gohelper.findChild(self.viewGO, "root/topTab/#btn_event/#go_eventUnselect")
	self._goeventSelect = gohelper.findChild(self.viewGO, "root/topTab/#btn_event/#go_eventSelect")
	self._goinfoView = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView")
	self._gogrids = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_grids")
	self._gogridItem = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_grids/#go_gridItem")
	self._gotowers = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_towers")
	self._gotowerItem = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_towers/#go_towerItem")
	self._gohor = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_hor")
	self._gohorWall = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_hor/#go_horWall")
	self._gover = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_ver")
	self._goverWall = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_ver/#go_verWall")
	self._goreadme = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_readme")
	self._goreadmeItem = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_readme/#go_readmeItem")
	self._goselectedgreen = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/alarmInfo/green/#go_selected")
	self._goselectedred = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/alarmInfo/red/#go_selected")
	self._goenemyinfolayout = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/alarmInfo/layout")
	self._goenemyinfoItem = gohelper.findChild(self.viewGO, "root/#go_subView/#go_infoView/alarmInfo/layout/#go_enemyInfoItem")
	self._goeventView = gohelper.findChild(self.viewGO, "root/#go_subView/#go_eventView")
	self._simageeventicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_subView/#go_eventView/#simage_icon")
	self._txteventname = gohelper.findChildText(self.viewGO, "root/#go_subView/#go_eventView/name/#txt_name")
	self._txteventdesc = gohelper.findChildText(self.viewGO, "root/#go_subView/#go_eventView/eff/txt_desc")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameOverView:addEvents()
	self._btninfo:AddClickListener(self._btninfoOnClick, self)
	self._btnevent:AddClickListener(self._btneventOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnclick:AddClickListener(self._btnCloseOnClick, self)
end

function AssassinStealthGameOverView:removeEvents()
	self._btninfo:RemoveClickListener()
	self._btnevent:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function AssassinStealthGameOverView:_btninfoOnClick()
	self:setSubViewShow()
	gohelper.setActive(self._goinfoSelect, true)
	gohelper.setActive(self._goinfoUnselect, false)
	gohelper.setActive(self._goeventSelect, false)
	gohelper.setActive(self._goeventUnselect, true)
end

function AssassinStealthGameOverView:_btneventOnClick()
	self:setSubViewShow(true)
	gohelper.setActive(self._goinfoSelect, false)
	gohelper.setActive(self._goinfoUnselect, true)
	gohelper.setActive(self._goeventSelect, true)
	gohelper.setActive(self._goeventUnselect, false)
end

function AssassinStealthGameOverView:_btnCloseOnClick()
	self:closeThis()
end

function AssassinStealthGameOverView:_editableInitView()
	self._dirGOList = self:getUserDataTb_()
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/up/#go_upLight")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/down/#go_downLigth")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/left/#go_leftLight")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/right/#go_rightLight")

	local transGrid = self._gogridItem.transform

	self.gridWidth = recthelper.getWidth(transGrid)
	self.gridHeight = recthelper.getHeight(transGrid)
	self._setInfoView = nil
	self._setEventView = nil
end

function AssassinStealthGameOverView:onUpdateParam()
	self._questId = self.viewParam and self.viewParam.questId

	if self._questId then
		local questType = AssassinConfig.instance:getQuestType(self._questId)

		if questType ~= AssassinEnum.QuestType.Stealth then
			logError(string.format("AssassinStealthGameOverView:onUpdateParam error, quest is not stealth, questId:%s", self._questId))

			return
		end

		local strMapId = AssassinConfig.instance:getQuestParam(self._questId)

		self._mapId = tonumber(strMapId)
	else
		self._mapId = AssassinStealthGameModel.instance:getMapId()
	end
end

function AssassinStealthGameOverView:onOpen()
	self:onUpdateParam()
	self:setTabShow()
	self:_btninfoOnClick()
end

function AssassinStealthGameOverView:setTabShow()
	local eventId = AssassinStealthGameModel.instance:getEventId()

	gohelper.setActive(self._btnevent, not self._questId and eventId)
end

function AssassinStealthGameOverView:setSubViewShow(isEventView)
	if isEventView then
		self:setEventView()
	else
		self:setInfoView()
	end

	gohelper.setActive(self._goinfoView, not isEventView)
	gohelper.setActive(self._goeventView, isEventView)
end

function AssassinStealthGameOverView:setEventView()
	if self._setEventView then
		return
	end

	local eventId = AssassinStealthGameModel.instance:getEventId()
	local img = AssassinConfig.instance:getEventImg(eventId)

	if not string.nilorempty(img) then
		local imgPath = ResUrl.getSp01AssassinSingleBg("stealth/" .. img)

		self._simageeventicon:LoadImage(imgPath)
	end

	self._txteventname.text = AssassinConfig.instance:getEventName(eventId)
	self._txteventdesc.text = AssassinConfig.instance:getEventDesc(eventId)

	local moveDir = AssassinStealthGameModel.instance:getEnemyMoveDir()

	for dir, dirGo in ipairs(self._dirGOList) do
		gohelper.setActive(dirGo, dir == moveDir)
	end

	self._setEventView = true
end

function AssassinStealthGameOverView:setInfoView()
	if self._setInfoView then
		return
	end

	self:setMap()
	self:setReadmeIconList()
	self:setAlarmInfo()

	self._setInfoView = true
end

function AssassinStealthGameOverView:setMap()
	self:clearGridItemList()

	local gridIdList = AssassinConfig.instance:getStealthGameMapGridList(self._mapId)

	gohelper.CreateObjList(self, self._onCreateGrid, gridIdList, self._gogrids, self._gogridItem)

	local towerList = AssassinConfig.instance:getStealthGameMapTowerGridList(self._mapId)

	gohelper.CreateObjList(self, self._onCreateTower, towerList, self._gotowers, self._gotowerItem)

	local verWallList = AssassinConfig.instance:getStealthGameMapWallList(self._mapId)

	gohelper.CreateObjList(self, self._onCreateVerWall, verWallList, self._gover, self._goverWall)

	local horWallList = AssassinConfig.instance:getStealthGameMapWallList(self._mapId, true)

	gohelper.CreateObjList(self, self._onCreateHorWall, horWallList, self._gohor, self._gohorWall)
end

function AssassinStealthGameOverView:_onCreateGrid(obj, data, index)
	local gridItem = self:getUserDataTb_()

	gridItem.go = obj
	gridItem.trans = gridItem.go.transform
	gridItem.gridId = data
	gridItem.go.name = gridItem.gridId
	gridItem.simagegrid = gohelper.findChildSingleImage(gridItem.go, "#go_content/#simage_grid")
	gridItem.imageRefreshPoint = gohelper.findChildImage(gridItem.go, "#go_content/#image_refreshPoint")

	local img = AssassinConfig.instance:getStealthGridImg(self._mapId, gridItem.gridId)

	if not string.nilorempty(img) then
		local imgPath = ResUrl.getSp01AssassinSingleBg("stealth/" .. img)

		gridItem.simagegrid:LoadImage(imgPath)
	end

	local refreshId

	if self._questId then
		local missionId = AssassinConfig.instance:getStealthMapMission(self._mapId)

		refreshId = AssassinConfig.instance:getStealthMissionRefresh(missionId)
	else
		local missionId = AssassinStealthGameModel.instance:getMissionId()
		local isAlertBellRing = AssassinStealthGameModel.instance:isAlertBellRing()
		local refreshId1, refreshId2 = AssassinConfig.instance:getStealthMissionRefresh(missionId)

		refreshId = isAlertBellRing and refreshId2 or refreshId1
	end

	local refreshData = AssassinConfig.instance:getEnemyRefreshData(refreshId, gridItem.gridId)

	if refreshData then
		UISpriteSetMgr.instance:setSp01AssassinSprite(gridItem.imageRefreshPoint, string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", refreshData.index))
	end

	gohelper.setActive(gridItem.imageRefreshPoint, refreshData)

	local x, y = AssassinConfig.instance:getGridPos(self._mapId, gridItem.gridId)
	local posX = (x - 1) * self.gridWidth
	local posY = (y - 1) * self.gridHeight

	recthelper.setAnchor(gridItem.trans, posX, posY)

	self._gridItemList[index] = gridItem
end

function AssassinStealthGameOverView:_onCreateTower(obj, data, index)
	local gridId = data

	obj.name = gridId

	local x, y = AssassinConfig.instance:getGridPos(self._mapId, gridId)
	local posX = (x - 1) * self.gridWidth
	local posY = (y - 1) * self.gridHeight

	recthelper.setAnchor(obj.transform, posX, posY)
end

function AssassinStealthGameOverView:_onCreateVerWall(obj, data, index)
	obj.name = data

	local x, y = AssassinConfig.instance:getWallPos(self._mapId, data)
	local posX = x * self.gridWidth
	local posY = (y - 1) * self.gridHeight

	recthelper.setAnchor(obj.transform, posX, posY)
end

function AssassinStealthGameOverView:_onCreateHorWall(obj, data, index)
	obj.name = data

	local x, y = AssassinConfig.instance:getWallPos(self._mapId, data)
	local posX = (x - 1) * self.gridWidth
	local posY = y * self.gridHeight

	recthelper.setAnchor(obj.transform, posX, posY)
end

function AssassinStealthGameOverView:setReadmeIconList()
	local hasTower = false
	local towerType = AssassinEnum.StealthGamePointType.Tower
	local gridTypeDict = {}
	local gridIdList = AssassinConfig.instance:getStealthGameMapGridList(self._mapId)

	for _, gridId in ipairs(gridIdList) do
		local gridType = AssassinConfig.instance:getGridType(self._mapId, gridId)

		gridTypeDict[gridType] = gridTypeDict[gridType] or {
			icon = AssassinConfig.instance:getStealthGameMapGridTypeIcon(gridType),
			name = AssassinConfig.instance:getStealthGameMapGridTypeName(gridType)
		}
		hasTower = hasTower or AssassinConfig.instance:isGridHasPointType(self._mapId, gridId, towerType)
	end

	local readmeIconList = {}

	for _, gridTypeData in pairs(gridTypeDict) do
		readmeIconList[#readmeIconList + 1] = gridTypeData
	end

	if hasTower then
		readmeIconList[#readmeIconList + 1] = {
			icon = AssassinConfig.instance:getPointTypeSmallIcon(towerType),
			name = AssassinConfig.instance:getPointTypeName(towerType)
		}
	end

	local refreshId

	if self._questId then
		local missionId = AssassinConfig.instance:getStealthMapMission(self._mapId)

		refreshId = AssassinConfig.instance:getStealthMissionRefresh(missionId)
	else
		local missionId = AssassinStealthGameModel.instance:getMissionId()
		local isAlertBellRing = AssassinStealthGameModel.instance:isAlertBellRing()
		local refreshId1, refreshId2 = AssassinConfig.instance:getStealthMissionRefresh(missionId)

		refreshId = isAlertBellRing and refreshId2 or refreshId1
	end

	if refreshId and refreshId > 0 then
		local refreshPositionList = AssassinConfig.instance:getEnemyRefreshPositionList(refreshId)
		local enemyRefreshName = luaLang("assassin_stealth_enemy_refresh_point")

		for i, _ in ipairs(refreshPositionList) do
			readmeIconList[#readmeIconList + 1] = {
				icon = string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", i),
				name = enemyRefreshName
			}
		end
	end

	gohelper.CreateObjList(self, self._onCreateReadmeIcon, readmeIconList, self._goreadme, self._goreadmeItem)
end

function AssassinStealthGameOverView:_onCreateReadmeIcon(obj, data, index)
	local imageicon = gohelper.findChildImage(obj, "#simage_icon")

	UISpriteSetMgr.instance:setSp01AssassinSprite(imageicon, data.icon)

	local txtname = gohelper.findChildText(obj, "#txt_name")

	txtname.text = data.name
end

function AssassinStealthGameOverView:setAlarmInfo()
	local missionId

	if self._questId then
		missionId = AssassinConfig.instance:getStealthMapMission(self._mapId)

		gohelper.setActive(self._goselectedgreen, false)
		gohelper.setActive(self._goselectedred, false)
	else
		missionId = AssassinStealthGameModel.instance:getMissionId()

		local isAlertBellRing = AssassinStealthGameModel.instance:isAlertBellRing()

		gohelper.setActive(self._goselectedgreen, not isAlertBellRing)
		gohelper.setActive(self._goselectedred, isAlertBellRing)
	end

	local allRefreshPositionList = {}
	local refreshId1, refreshId2 = AssassinConfig.instance:getStealthMissionRefresh(missionId)
	local refreshPositionList1 = AssassinConfig.instance:getEnemyRefreshPositionList(refreshId1)
	local refreshPositionList2 = AssassinConfig.instance:getEnemyRefreshPositionList(refreshId2)
	local refreshGridDict2 = {}

	for _, refreshPosition in ipairs(refreshPositionList2) do
		local gridId = refreshPosition[1]

		refreshGridDict2[gridId] = refreshPosition[2]
	end

	for i, refreshPosition in ipairs(refreshPositionList1) do
		local gridId = refreshPosition[1]
		local enemyGroupId = refreshPosition[2]

		allRefreshPositionList[i] = {
			gridId = gridId,
			enemyGroup1 = enemyGroupId,
			enemyGroup2 = refreshGridDict2[gridId]
		}
	end

	self._totalEnemyRefreshInfoCount = #allRefreshPositionList

	if self._totalEnemyRefreshInfoCount == 0 then
		local obj = gohelper.cloneInPlace(self._goenemyinfoItem, "emptyItem")
		local goEmpty = gohelper.findChild(obj, "#go_empty")

		gohelper.setActive(goEmpty, true)

		local gobefroelayout = gohelper.findChild(obj, "beforeLayout")

		gohelper.clone(goEmpty, gobefroelayout)

		local goafterlayout = gohelper.findChild(obj, "afterLayout")

		gohelper.clone(goEmpty, goafterlayout)

		local goenemyItem = gohelper.findChild(obj, "#go_enemyItem")

		gohelper.setActive(goenemyItem, false)

		local goIcon = gohelper.findChild(obj, "icon")

		gohelper.setActive(goIcon, false)
		gohelper.setActive(goEmpty, false)
		gohelper.setActive(self._goenemyinfoItem, false)
	else
		gohelper.CreateObjList(self, self._onCreateAlarmEnemyInfoItem, allRefreshPositionList, self._goenemyinfolayout, self._goenemyinfoItem)
	end
end

function AssassinStealthGameOverView:_onCreateAlarmEnemyInfoItem(obj, data, index)
	local goenemyItem = gohelper.findChild(obj, "#go_enemyItem")

	gohelper.setActive(goenemyItem, false)

	local beforeEnemyList = AssassinConfig.instance:getEnemyListInGroup(data.enemyGroup1)
	local gobefroelayout = gohelper.findChild(obj, "beforeLayout")

	gohelper.CreateObjList(self, self._onCreateEnemyItem, beforeEnemyList, gobefroelayout, goenemyItem)

	local scale = #beforeEnemyList > 3 and 0.8 or 1

	transformhelper.setLocalScale(gobefroelayout.transform, scale, scale, 1)

	local imageicon = gohelper.findChildImage(obj, "icon")
	local iconName = string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", index)

	UISpriteSetMgr.instance:setSp01AssassinSprite(imageicon, iconName)

	local afterEnemyList = AssassinConfig.instance:getEnemyListInGroup(data.enemyGroup2)
	local goafterlayout = gohelper.findChild(obj, "afterLayout")

	gohelper.CreateObjList(self, self._onCreateEnemyItem, afterEnemyList, goafterlayout, goenemyItem)

	scale = #afterEnemyList > 3 and 0.8 or 1

	transformhelper.setLocalScale(goafterlayout.transform, scale, scale, 1)

	local goLine = gohelper.findChild(obj, "#go_Line")

	gohelper.setActive(goLine, index ~= self._totalEnemyRefreshInfoCount)
end

function AssassinStealthGameOverView:_onCreateEnemyItem(obj, data, index)
	local headIcon = AssassinConfig.instance:getEnemyHeadIcon(data)
	local imageenemyIcon = gohelper.findChildImage(obj, "#simage_enemyIcon")

	UISpriteSetMgr.instance:setSp01AssassinSprite(imageenemyIcon, headIcon)
end

function AssassinStealthGameOverView:clearGridItemList()
	if self._gridItemList then
		for _, gridItem in ipairs(self._gridItemList) do
			gridItem.simagegrid:UnLoadImage()
		end
	end

	self._gridItemList = {}
end

function AssassinStealthGameOverView:onClose()
	return
end

function AssassinStealthGameOverView:onDestroyView()
	self:clearGridItemList()

	self._setInfoView = nil
	self._setEventView = nil
end

return AssassinStealthGameOverView
