-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillseachView.lua

module("logic.extensions.scriptkill.view.ScriptkillseachView", package.seeall)

local ScriptkillseachView = class("ScriptkillseachView", ViewComponent)

function ScriptkillseachView:unbindEvents()
	ScriptkillseachView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump_1)
	GameUtil.rmClickHandler(self._btnJump_2)
	GameUtil.rmClickHandler(self._btnJump_3)
	self._typewriter:RemoveEventHandler()
	GameUtil.rmClickHandler(self._image)
end

function ScriptkillseachView:bindEvents()
	ScriptkillseachView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnJump_1, self._onClickJump1, self)
	GameUtil.addClickHandler(self._btnJump_2, self._onClickJump2, self)
	GameUtil.addClickHandler(self._btnJump_3, self._onClickJump3, self)
	self._typewriter:AddEventHandler(self._textFinish, self)
	GameUtil.addClickHandler(self._image, self._onImageClick, self)
end

function ScriptkillseachView:buildUI()
	ScriptkillseachView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._image = self:getGo("info/image")
	self._goldBarCon = self:getGo("goldBarCon")
	self._speak = self:getGo("speak")
	self._icon = self:getGo("speak/icon")
	self._txtName = self:getTxt("speak/icon/txtName")
	self._ImgC_Icon = self:getGo("speak/Nego_Icon/ImgC_Icon")
	self._txtSpeak = self:getTxt("speak/bg/txt")
	self._typewriter = self._txtSpeak.gameObject:GetComponent("TypewriterNew")
	self._typewriter.speed = 0.1

	GameUtil.SetActive(self._speak, false)

	self._btnJump_1 = self:getGo("btnJump_1")
	self._btnJump_2 = self:getGo("btnJump_2")
	self._btnJump_3 = self:getGo("btnJump_3")
	self._container = self:getGo("info/container")
	self._btnSelected = self:getGo("btnSelected")

	GameUtil.SetActive(self._btnSelected, false)

	self._btnContainer = self:getGo("btnContainer")
	self._btnCell = self:getGo("btnCell")

	GameUtil.SetActive(self._btnCell, false)

	self._txtPoint = self:getTxt("txtPoint/txt")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._recipeRed = self:getGo("btnJump_1/recipeRed")
end

function ScriptkillseachView:onExit()
	ScriptkillseachView.super.onExit(self)
	removetimer(self._nextSpeak, self)
	uGuiUtil.clearImage(self._image)
	uGuiUtil.clearImage(self._ImgC_Icon)
	RedPointController.instance:unregRedPoint(self._recipeRed)
end

function ScriptkillseachView:onEnter()
	ScriptkillseachView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._chapterId = checknumber(params[2])

	if self._chapterId == 0 then
		self._chapterId = 1
	end

	self._selectTabIdx = 1
	self._speaking = false
	self._speakList = {}
	self._effectMap = {}
	self._errorCount = 0

	self:_initView()

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._recipeRed, taskRedId)
	end

	self.addGEvent(self, GlobalNotify.ScriptKillGetCludeId, self._onGetClueId, self)
	self.addGEvent(self, GlobalNotify.ScriptKillInfoUpdate, self._refreshUI, self)
	GameUtil.doCallbackWhenFirst("ScriptkillseachView_" .. self._activityId .. "_" .. self._chapterId, function()
		local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._chapterId)

		if cfg and checknumber(cfg.storyId) > 0 then
			StoryController.instance:startStory(checknumber(cfg.storyId))
		end
	end)
end

function ScriptkillseachView:_onGetClueId(clueId)
	if checknumber(clueId) > 0 then
		table.insert(self._speakList, clueId)

		local cfg = ScriptKillConfig.instance:getClueCfgById(self._activityId, clueId) or {}

		ScriptKillController.instance:openPopupWindowWithX(cfg.name, cfg.desc)
	end

	if not self._speaking then
		local id = table.remove(self._speakList, 1)

		if id then
			local cfg = ScriptKillConfig.instance:getClueCfgById(self._activityId, id)

			self:_startSpeak(cfg.content, cfg.npcId)
		else
			self._speaking = false
		end
	end
end

function ScriptkillseachView:_startSpeak(content, npcId)
	if not string.nilorempty(content) then
		GameUtil.SetActive(self._speak, true)

		self._speaking = true

		local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, npcId) or {}

		uGuiUtil.setSpriteToImage(self._ImgC_Icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(npcCfg.icon))

		self._txtName.text = npcCfg.name

		local len = #content
		local time = 3
		local spd = time / len

		spd = math.min(0.1, spd)
		spd = math.max(0.03, spd)
		self._typewriter.speed = spd

		self._typewriter:SetText(content)
		removetimer(self._nextSpeak, self)
		settimer(time, self._nextSpeak, self, false)
	else
		self:_nextSpeak()
	end
end

function ScriptkillseachView:_tryShowError()
	self._errorCount = self._errorCount + 1

	local zoneId = self._zoneList[self._selectTabIdx]

	if not self._zoneMap[zoneId] then
		local isAllOK = true

		for i, v in ipairs(self._zoneMap[zoneId]) do
			if not self._clueIdMap[v.clueId] then
				isAllOK = false
			end
		end

		if isAllOK then
			TipsFacade.instance:openCommonTips("此区域线索已经全部找到")
		end

		if self._errorCount % 3 == 0 then
			local tem

			for i, v in ipairs(self._zoneMap[zoneId]) do
				if not self._clueIdMap[v.clueId] and not string.nilorempty(v.tips) then
					if self:_checkAllUnlock(v.unlockIds) then
						self:_startSpeak(v.tips, v.npcId)

						return
					elseif tem == nil then
						tem = v
					end
				end
			end

			if tem then
				self:_startSpeak(tem.tips, tem.npcId)

				return
			end
		end
	end
end

function ScriptkillseachView:_textFinish()
	return
end

function ScriptkillseachView:_nextSpeak()
	GameUtil.SetActive(self._speak, false)

	self._speaking = false

	self:_onGetClueId()
end

function ScriptkillseachView:_updateData()
	self._clueIds = ScriptKillModel.instance:getClueIds(self._activityId) or {}
	self._clueIdMap = {}

	for i, v in ipairs(self._clueIds) do
		self._clueIdMap[v] = true
	end
end

function ScriptkillseachView:_refreshUI()
	local info = ScriptKillModel.instance:getInfo(self._activityId) or {}

	self._txtPoint.text = checknumber(info.todayActionPoint)

	self:_updateData()
	self:_refreshRightTap()
	self:_refreshSelect()
end

function ScriptkillseachView:_selectTabCell(idx)
	local zoneId = self._zoneList[idx]
	local zoneCfg = ScriptKillConfig.instance:getZoneCfgById(self._activityId, self._chapterId, zoneId)

	if self:_checkAllUnlock(zoneCfg.unlockIds) then
		self._selectTabIdx = idx

		self:_refreshUI()
	else
		TipsFacade.instance:openCommonTips(zoneCfg.tips)
	end
end

function ScriptkillseachView:_initRightTap()
	self._selectBtnList = {}

	goutil.clearChildren(self._btnContainer)

	for i, v in ipairs(self._zoneList) do
		local go = goutil.clone(self._btnCell, "btnCell_" .. i)

		goutil.addChildToParent(go, self._btnContainer)
		GameUtil.SetActive(go, true)

		local lock = goutil.findChild(go, "lock")
		local txt = goutil.findChildTextComponent(go, "txtName")
		local zoneCfg = ScriptKillConfig.instance:getZoneCfgById(self._activityId, self._chapterId, v)

		if self._selectTabIdx == i then
			GameUtil.setUIGroupIdx(go, 1)
		else
			GameUtil.setUIGroupIdx(go, 0)
		end

		GameUtil.SetActive(lock, not self:_checkAllUnlock(zoneCfg.unlockIds))

		txt.text = zoneCfg.name

		table.insert(self._selectBtnList, go)
		GameUtil.addClickHandler(go, function()
			self:_selectTabCell(i)
		end)
	end
end

function ScriptkillseachView:_refreshRightTap()
	for i, go in ipairs(self._selectBtnList) do
		local lock = goutil.findChild(go, "lock")
		local txt = goutil.findChildTextComponent(go, "txtName")
		local zoneCfg = ScriptKillConfig.instance:getZoneCfgById(self._activityId, self._chapterId, self._zoneList[i])

		if self._selectTabIdx == i then
			GameUtil.setUIGroupIdx(go, 1)
		else
			GameUtil.setUIGroupIdx(go, 0)
		end

		GameUtil.SetActive(lock, not self:_checkAllUnlock(zoneCfg.unlockIds))

		txt.text = zoneCfg.name
	end
end

function ScriptkillseachView:_initView()
	self:_updateData()

	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._chapterId) or {}

	self._txtTitle.text = cfg.name
	self._zoneList = {}
	self._zoneMap = {}

	local list = ScriptKillConfig.instance:getClueCfgListById(self._activityId, self._chapterId) or {}

	for i, v in ipairs(list) do
		if v.zoneId > 0 then
			if table.indexof(self._zoneList, v.zoneId) == false then
				table.insert(self._zoneList, v.zoneId)
			end

			self._zoneMap[v.zoneId] = self._zoneMap[v.zoneId] or {}

			table.insert(self._zoneMap[v.zoneId], v)
		end
	end

	self:_initRightTap()
	self:_selectTabCell(self._selectTabIdx)
end

function ScriptkillseachView:_refreshSelect()
	local zoneId = self._zoneList[self._selectTabIdx]

	if not self._zoneMap[zoneId] then
		local list = {}
		local zoneCfg = ScriptKillConfig.instance:getZoneCfgById(self._activityId, self._chapterId, zoneId)

		uGuiUtil.setSpriteToImage(self._image.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/scriptkill", zoneCfg.imgUrl))

		if zoneCfg.isFlip then
			GameUtil.setLocalScale(self._image, -1, 1, 1)
		else
			GameUtil.setLocalScale(self._image, 1, 1, 1)
		end

		local childCount = self._container.transform.childCount

		for i = 1, childCount do
			local trans = self._container.transform:GetChild(i - 1)
			local go = trans.gameObject

			if self._effectMap[go] then
				UIEffectManager.instance:stopEffect(self._effectMap[go])
			end
		end

		self._effectMap = {}

		local tempList = {}

		for i, v in ipairs(list) do
			table.insert(tempList, v)
		end

		ArraySort.sortOn(tempList, {
			function(c)
				if not self._clueIdMap[c.clueId] and self:_checkAllUnlock(c.unlockIds) then
					return 1
				end

				return 0
			end,
			"clueId"
		}, {
			ArraySort.NUMERIC,
			ArraySort.DESCENDING
		})
		goutil.clearChildren(self._container)

		for i, v in ipairs(tempList) do
			local go = goutil.clone(self._btnSelected, "btnSelect_" .. v.clueId)

			goutil.addChildToParent(go, self._container)
			GameUtil.SetActive(go, true)
			GameUtil.addClickHandler(go, function()
				self:_onClickClue(v)
			end)

			if not v.pos then
				GameUtil.setAnchoredPos(go, checknumber(v.pos[1]), checknumber(v.pos[2]))

				if not self._clueIdMap[v.clueId] then
					if v.hasUnlockEffect and self:_checkAllUnlock(v.unlockIds) == true then
						local effName = "20240430/jubensha/fx_ui_jubensha_dianji.prefab"

						self._effectMap[go] = self:_playEffect(effName, go)
					end
				else
					GameUtil.SetActive(go, false)
				end
			end
		end
	end
end

function ScriptkillseachView:_playEffect(effName, go)
	local handler = UIEffectManager.instance:playEffect(self, effName, go, 0, 0, true)

	handler:setParent(go.transform)
	handler:setScale(1)
	handler:setLocalPos(0, 0, 0)

	return handler
end

function ScriptkillseachView:_checkAllUnlock(unlockIds)
	unlockIds = unlockIds or {}

	for i, v in ipairs(unlockIds) do
		if not self._clueIdMap[v] then
			return false
		end
	end

	return true
end

function ScriptkillseachView:_onClickClue(cfg)
	if self:_checkAllUnlock(cfg.unlockIds) == false then
		TipsFacade.instance:openCommonTips(cfg.lockTips)

		return
	end

	local clueId = cfg.clueId

	if not self._clueIdMap[clueId] then
		ScriptKillController.instance:sendGetClue(self._activityId, clueId)
	else
		self:_tryShowError()
		ScriptKillController.instance:sendUseActionPoint(self._activityId)
	end
end

function ScriptkillseachView:_onImageClick()
	self:_tryShowError()
	ScriptKillController.instance:sendUseActionPoint(self._activityId)
end

function ScriptkillseachView:_onPointerDownHandler(go, eventData)
	local mainCamera = GlobalModel.instance.uiCamera
	local worldPos = mainCamera:ScreenToWorldPoint(eventData.position)
	local localPos = self._image.transform:InverseTransformPoint(worldPos)

	printError(">>>>>>>>>>>>>>>>>>>", eventData.position.x, eventData.position.y, "|", worldPos.x, worldPos.y, "|", localPos.x, localPos.y)

	local zoneId = self._zoneList[self._selectTabIdx]

	if not self._zoneMap[zoneId] then
		local isFound = false

		for i, v in ipairs(self._zoneMap[zoneId]) do
			if not v.pos then
				local pos = {}
				local x = checknumber(pos[1])
				local y = checknumber(pos[2])

				if not self._clueIdMap[v.clueId] and (localPos.x - x) * (localPos.x - x) + (localPos.y - y) * (localPos.y - y) <= 100 then
					isFound = true

					self:_onClickClue(v)

					return
				end
			end
		end

		if not isFound then
			self:_onImageClick()
		end
	end
end

function ScriptkillseachView:_onClickTip()
	TipsFacade.instance:openRulesView("scriptkillmainview_rule")
end

function ScriptkillseachView:_onClickJump1()
	UIStateManager.instance:push(ViewName.ScriptkillbookView, self._activityId, self._chapterId)
end

function ScriptkillseachView:_onClickJump2()
	UIStateManager.instance:push(ViewName.ScriptkillguessView, self._activityId)
end

function ScriptkillseachView:_onClickJump3()
	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, self._chapterId)

	if cfg and checknumber(cfg.storyId) > 0 then
		StoryController.instance:startStory(checknumber(cfg.storyId))
	end
end

return ScriptkillseachView
