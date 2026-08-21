-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/cell/AirWorkshopLevelItemCell.lua

module("logic.extensions.airworkshop.cell.AirWorkshopLevelItemCell", package.seeall)

local M = class("AirWorkshopLevelItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._goRootCreator = registry:findUIElement("air_workshop_level_item_1919265030")
	self._btnPlayer = UIComponentType.ButtonAdapter(registry:findUIElement("air_workshop_level_item_-900273252"))
	self._imgPlayerMask = registry:findUIElement("air_workshop_level_item_-1397172695", UIComponentType.Image)
	self._txtPlayerLevel = registry:findUIElement("air_workshop_level_item_-743850110", UIComponentType.Text)
	self._btnDetail = UIComponentType.ButtonAdapter(registry:findUIElement("air_workshop_level_item_-1809354937"))
	self._imgLevel = registry:findUIElement("air_workshop_level_item_-1211275274", UIComponentType.Image)
	self._txtLevelId = registry:findUIElement("air_workshop_level_item_-1462099238", UIComponentType.Text)
	self._txtLevelScore = registry:findUIElement("air_workshop_level_item_1713768821", UIComponentType.Text)
	self._txtLevelPassRatio = registry:findUIElement("air_workshop_level_item_-1909191561", UIComponentType.Text)
	self._rectTrLevelTabRoot = registry:findUIElement("air_workshop_level_item_1689985373", UIComponentType.RectTransform)
	self._txtLevelCreateTimeTitile = goutil.findChildComponent(mainGO, "objInteractive/txt2", UIComponentType.Text)
	self._txtLevelCreateTime = registry:findUIElement("air_workshop_level_item_-1590720414", UIComponentType.Text)
	self._btnCheck = UIComponentType.ButtonAdapter(registry:findUIElement("1&com_btn_2_-31477526"))
	self._btnEdit = UIComponentType.ButtonAdapter(registry:findUIElement("2&com_btn_2_-31477526"))
	self._btnMsg = UIComponentType.ButtonAdapter(registry:findUIElement("air_workshop_level_item_-1315256426"))
	self._txtMsgCount = registry:findUIElement("air_workshop_level_item_-587239912", UIComponentType.Text)
	self._goRedPointMsg = goutil.findChild(self._txtMsgCount.gameObject, "red_point").gameObject
	self._txtAppreciateCount = registry:findUIElement("air_workshop_level_item_133650451", UIComponentType.Text)
	self._goWin = registry:findUIElement("air_workshop_level_item_-488676027")
	self._goWinScore = registry:findUIElement("air_workshop_level_item_1510757045")
	self._txtWin = registry:findUIElement("air_workshop_level_item_-130023842", UIComponentType.Text)
	self._goFail = registry:findUIElement("air_workshop_level_item_1393305029")
	self._goFailScore = registry:findUIElement("air_workshop_level_item_-1084283290")
	self._txtFail = registry:findUIElement("air_workshop_level_item_-1203063198", UIComponentType.Text)
end

function M:destroyUI()
	self:setHandler(nil)
	self:setClickCheckFunc(nil, nil)
	self:setClickEditFunc(nil, nil)

	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnPlayer:AddClickListener(self._onClickPlayer, self)
	self._btnCheck:AddClickListener(self._onClickCheck, self)
	self._btnEdit:AddClickListener(self._onClickEdit, self)
	self._btnMsg:AddClickListener(self._onClickMsg, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnPlayer:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
	self._btnEdit:RemoveClickListener()
	self._btnMsg:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:_onClickPlayer()
	printWarn("_onClickPlayer")

	if self._playerInfo then
		local bindGo = self._btnPlayer.gameObject
		local uid = self._playerInfo.userId
		local playerLv = self._playerInfo.playerLv
		local portrait = self._playerInfo.portrait
		local nickName = self._playerInfo.nickname

		ToolTipsMgr.showPlayerInfoTips(bindGo, uid, playerLv, portrait, nickName)
	end
end

function M:_onClickCheck()
	if self._funCheck then
		if self._funHandlerCheck then
			self._funCheck(self._funHandlerCheck, self._recordNO, self._mapId, self._airPlayType)
		else
			self._funCheck(self._recordNO, self._mapId, self._airPlayType)
		end
	end
end

function M:_onClickEdit()
	if self._funEdit then
		if self._funHandlerEdit then
			self._funEdit(self._funHandlerEdit, self._recordNO, self._mapId, self._airPlayType)
		else
			self._funEdit(self._recordNO, self._mapId, self._airPlayType)
		end
	end
end

function M:_onClickDetail()
	if self._mapId then
		local params = {}

		params.mapId = self._mapId
		params.showTabCount = 1

		ViewMgr.instance:open(ViewName.AirWorkShopStatisticView, params)
	end
end

function M:_onClickMsg()
	if self._mapId then
		local hideEditBtn = true
		local editBtnInteractable = false

		ToolTipsMgr.showAirWorkShopMessageLogTipsView(self._mapId, self._cover, hideEditBtn, editBtnInteractable)
	end
end

function M:setClickCheckFunc(func, handler)
	self._funCheck = func
	self._funHandlerCheck = handler
end

function M:setClickEditFunc(func, handler)
	self._funEdit = func
	self._funHandlerEdit = handler
end

function M:setCreatorInfoShow(show)
	goutil.setActive(self._goRootCreator, show)
end

function M:setCheckBtnShow(show)
	goutil.setActive(self._btnCheck.gameObject, show)
end

function M:setEditBtnShow(show)
	goutil.setActive(self._btnEdit.gameObject, show)
end

function M:_getPassRatioStr(passRatio)
	return string.format("%s%%", AirWorkShopUtil.formatPassRatio(passRatio * 100, 1))
end

function M:updateData(airMapRecordNO, airPlayType)
	self._recordNO = airMapRecordNO
	self._playerInfo = {
		userId = airMapRecordNO.player.userId,
		createLv = airMapRecordNO.player.createLv,
		portrait = airMapRecordNO.player.portrait,
		nickname = airMapRecordNO.player.nickname,
		playerLv = airMapRecordNO.player.playerLv
	}
	self._mapId = airMapRecordNO.id
	self._cover = airMapRecordNO.stat.cover
	self._airPlayType = airPlayType

	self:setCreatorInfoShow(true)

	self._txtPlayerLevel.text = string.format("Lv.%s", airMapRecordNO.player.createLv)

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(airMapRecordNO.player.portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgPlayerMask, IconType.PlayerInfoMask, portraitCO.icon)
	end

	self:_updateSceneImage(self._cover)

	self._txtLevelId.text = string.format("ID:%s", airMapRecordNO.id)
	self._txtLevelScore.text = string.format("%s%s", airMapRecordNO.stat.point, AirWorkShopEnum.RodeoScoreSuffix)
	self._txtLevelPassRatio.text = self:_getPassRatioStr(airMapRecordNO.stat.passRate)
	self._txtLevelCreateTime.text = ServerTime.formatTimeServerLook(airMapRecordNO.stat.createTime * 0.001, "%Y/%m/%d")
	self._txtLevelCreateTimeTitile.text = lang("tip_air_level_item_time_title_1")

	local msgCountStr = airMapRecordNO.stat.commentCount

	msgCountStr = msgCountStr > 99999 and "999K+" or msgCountStr
	self._txtMsgCount.text = msgCountStr

	local likeCountStr = airMapRecordNO.stat.likeCount

	likeCountStr = likeCountStr > 99999 and "999K+" or likeCountStr
	self._txtAppreciateCount.text = likeCountStr

	goutil.setActive(self._goWin, false)
	goutil.setActive(self._goFail, false)
	self:refreshTag(airMapRecordNO.stat.tagId)
end

function M:updateDataByAirWorkShopRecordMo(airWorkShopRecordMo, airPlayType, hideScore)
	self._recordNO = airWorkShopRecordMo
	self._playerInfo = airWorkShopRecordMo:getCreatorInfo()
	self._mapId = airWorkShopRecordMo:getMapId()
	self._cover = airWorkShopRecordMo:getCover()
	self._airPlayType = airPlayType

	self:setCreatorInfoShow(true)

	self._txtPlayerLevel.text = string.format("Lv.%s", self._playerInfo.createLv)

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(self._playerInfo.portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgPlayerMask, IconType.PlayerInfoMask, portraitCO.icon)
	end

	self:_updateSceneImage(self._cover)

	self._txtLevelId.text = string.format("ID:%s", airWorkShopRecordMo:getMapId())
	self._txtLevelScore.text = string.format("%s%s", airWorkShopRecordMo:getPoint(), AirWorkShopEnum.RodeoScoreSuffix)
	self._txtLevelPassRatio.text = self:_getPassRatioStr(airWorkShopRecordMo:getPassRate())
	self._txtLevelCreateTime.text = ServerTime.formatTimeServerLook(airWorkShopRecordMo:getTimeStamp() * 0.001, "%Y/%m/%d")
	self._txtLevelCreateTimeTitile.text = lang("tip_air_level_item_time_title_2")

	local msgCountStr = airWorkShopRecordMo:getCommentCount()

	msgCountStr = msgCountStr > 99999 and "999K+" or msgCountStr
	self._txtMsgCount.text = msgCountStr

	local likeCountStr = airWorkShopRecordMo:getLikeCount()

	likeCountStr = likeCountStr > 99999 and "999K+" or likeCountStr
	self._txtAppreciateCount.text = likeCountStr

	local isWin = airWorkShopRecordMo:getIsWin()
	local winScoreChange = airWorkShopRecordMo:getScore()

	self._txtWin.text = string.format("+%s%s", winScoreChange, AirWorkShopEnum.RodeoScoreSuffix)
	self._txtFail.text = string.format("%s%s", winScoreChange, AirWorkShopEnum.RodeoScoreSuffix)

	goutil.setActive(self._goWinScore, not hideScore)
	goutil.setActive(self._goFailScore, not hideScore)
	goutil.setActive(self._goWin, isWin)
	goutil.setActive(self._goFail, not isWin)
	self:refreshTag(airWorkShopRecordMo:getTagIds())
end

function M:updateDataByLevelPublish(AirMapStatNO, airPlayType)
	self._recordNO = AirMapStatNO
	self._playerInfo = nil
	self._mapId = AirMapStatNO.id
	self._cover = AirMapStatNO.cover
	self._airPlayType = airPlayType

	self:setCreatorInfoShow(false)
	self:_updateSceneImage(self._cover)

	self._txtLevelId.text = string.format("ID:%s", self._mapId)
	self._txtLevelScore.text = string.format("%s%s", AirMapStatNO.point, AirWorkShopEnum.RodeoScoreSuffix)
	self._txtLevelPassRatio.text = self:_getPassRatioStr(AirMapStatNO.passRate)
	self._txtLevelCreateTime.text = ServerTime.formatTimeServerLook(AirMapStatNO.createTime * 0.001, "%Y/%m/%d")
	self._txtLevelCreateTimeTitile.text = lang("tip_air_level_item_time_title_1")

	local msgCountStr = AirMapStatNO.commentCount

	msgCountStr = msgCountStr > 99999 and "999K+" or msgCountStr
	self._txtMsgCount.text = msgCountStr

	local likeCountStr = AirMapStatNO.likeCount

	likeCountStr = likeCountStr > 99999 and "999K+" or likeCountStr
	self._txtAppreciateCount.text = likeCountStr

	goutil.setActive(self._goWin, false)
	goutil.setActive(self._goFail, false)

	local tags = {}

	for _, tag in ipairs(AirMapStatNO.tagId or {}) do
		table.insert(tags, tag)
	end

	self:refreshTag(tags)
end

function M:refreshTag(tagIds)
	tagIds = tagIds or {}

	local len = #tagIds

	while len > self._rectTrLevelTabRoot.childCount do
		goutil.cloneAndSetParent(self._rectTrLevelTabRoot:GetChild(0).gameObject, self._rectTrLevelTabRoot)
	end

	for i = 0, self._rectTrLevelTabRoot.childCount - 1 do
		local go = self._rectTrLevelTabRoot:GetChild(i).gameObject
		local tagId = tagIds[i + 1]

		if tagId then
			local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioTag, tagId)
			local txtName = goutil.findChildComponent(go, "txtName", UIComponentType.Text)

			txtName.text = cfg and cfg.tagName or "???"
		end

		goutil.setActive(go, tagId)
	end
end

function M:_onSceneImageUpdate(_, cover)
	if self._cover == cover then
		self:_updateSceneImage(cover)
	end
end

function M:_updateSceneImage(cover)
	AirWorkShopUtil.loadSceneImage(self._imgLevel, cover, true)
end

return M
