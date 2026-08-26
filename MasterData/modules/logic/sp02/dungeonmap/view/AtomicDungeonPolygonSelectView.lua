-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonPolygonSelectView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonPolygonSelectView", package.seeall)

local AtomicDungeonPolygonSelectView = class("AtomicDungeonPolygonSelectView", BaseView)

function AtomicDungeonPolygonSelectView:onInitView()
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_task", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self._gotaskReddot = gohelper.findChild(self.viewGO, "root/#btn_task/#go_taskReddot")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/info/#simage_icon")
	self._txtindex = gohelper.findChildText(self.viewGO, "root/info/#txt_index")
	self._txtpolygonName = gohelper.findChildText(self.viewGO, "root/info/polygon/#txt_polygonName")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/info/#txt_Descr")
	self._goresultContent = gohelper.findChild(self.viewGO, "root/info/#go_resultContent")
	self._goresultItem = gohelper.findChild(self.viewGO, "root/info/#go_resultContent/#go_resultItem")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "root/info/difficultylayout/#btn_sub", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self._gomaxSub = gohelper.findChild(self.viewGO, "root/info/difficultylayout/#btn_sub/#go_maxSub")
	self._gohardContent = gohelper.findChild(self.viewGO, "root/info/difficultylayout/#go_hardContent")
	self._gohardItem = gohelper.findChild(self.viewGO, "root/info/difficultylayout/#go_hardContent/#go_hardItem")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "root/info/difficultylayout/#btn_add", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self._gomaxAdd = gohelper.findChild(self.viewGO, "root/info/difficultylayout/#btn_add/#go_maxAdd")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/info/#btn_start", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self._gounFinish = gohelper.findChild(self.viewGO, "root/info/#btn_start/#go_unFinish")
	self._goruleContent = gohelper.findChild(self.viewGO, "root/info/rules/#go_ruleContent")
	self._goruleItem = gohelper.findChild(self.viewGO, "root/info/rules/#go_ruleContent/#go_ruleItem")
	self._scrollpolygon = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_polygon")
	self._gopolygonContent = gohelper.findChild(self.viewGO, "root/#scroll_polygon/viewport/#go_polygonContent")
	self._gopolygonItem = gohelper.findChild(self.viewGO, "root/#scroll_polygon/viewport/#go_polygonContent/#go_polygonItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonPolygonSelectView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self.addEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshTalentItem, self)
end

function AtomicDungeonPolygonSelectView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self.removeEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshTalentItem, self)
end

function AtomicDungeonPolygonSelectView:_btntaskOnClick()
	AtomicController.instance:openRewardView()
end

function AtomicDungeonPolygonSelectView:_btnsubOnClick()
	if self.curHardIndex <= 1 then
		return
	end

	self.curHardIndex = self.curHardIndex - 1
	self.polygonHardMap[self.curPolygonId] = self.curHardIndex

	self:refreshPolygonInfo()
	self:createAndRefreshPolygonItem()
end

function AtomicDungeonPolygonSelectView:_btnaddOnClick()
	if self.curHardIndex >= #self.curPolygonDiffCoList then
		return
	end

	local index = self.curHardIndex + 1

	if not self.polygonMo or not self.polygonMo.unlockDiffList[index] then
		GameFacade.showToast(ToastEnum.AtomicPolygonSelectHardLock)

		return
	end

	self.curHardIndex = index
	self.polygonHardMap[self.curPolygonId] = self.curHardIndex

	self:refreshPolygonInfo()
	self:createAndRefreshPolygonItem()
end

function AtomicDungeonPolygonSelectView:_btnstartOnClick()
	local polygonDiffCo = AtomicDungeonConfig.instance:getPolygonDiffConfig(self.curPolygonId, self.curHardIndex)
	local fightEpisodeCo = DungeonConfig.instance:getEpisodeCO(polygonDiffCo.episodeId)
	local param = {}

	param.episodeId = fightEpisodeCo.id
	param.polygonId = self.curPolygonId
	param.hardIndex = self.curHardIndex
	param.mapId = AtomicDungeonModel.instance:getCurMapId()
	param.isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	AtomicDungeonModel.instance:setLastPolygonFightParam(param)
	DungeonFightController.instance:enterFight(fightEpisodeCo.chapterId, fightEpisodeCo.id)
end

function AtomicDungeonPolygonSelectView:_btnPolygonItemOnClick(polygonItem)
	if not polygonItem.isUnLock then
		local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(polygonItem.config.id)

		GameFacade.showToastString(mapInfoConfig.unlockDesc)

		return
	end

	if self.curPolygonId == polygonItem.config.id then
		return
	end

	self.curPolygonId = polygonItem.config.id
	self.curHardIndex = self.polygonHardMap[self.curPolygonId] or 1
	self.polygonMo = AtomicDungeonModel.instance:getPolygonMo(self.curPolygonId)

	local curUnlockDiff = self.polygonMo:getCurUnlockDiff()

	self.curHardIndex = curUnlockDiff < self.curHardIndex and 1 or self.curHardIndex
	polygonItem.curSelectState = self.curPolygonId == polygonItem.config.id
	self.curSelectMapId = polygonItem.config.mapId

	self.animInfo:Play("refresh", 0, 0)
	self.animInfo:Update(0)
	self:refreshPolygonItemSelectState()
end

function AtomicDungeonPolygonSelectView:_btnadditionRuleclickOnClick()
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self.ruleList,
		offSet = {
			0,
			-155
		}
	})
end

function AtomicDungeonPolygonSelectView:_btnTalentClickOnClick(talentItem)
	local param = {}

	param.nodeId = talentItem.id

	AtomicController.instance:openTalentView(param)
end

function AtomicDungeonPolygonSelectView:_editableInitView()
	self.curHardIndex = 1
	self.polygonItemMap = self:getUserDataTb_()
	self.ruleItemList = self:getUserDataTb_()
	self.resultItemList = self:getUserDataTb_()
	self.hardItemList = self:getUserDataTb_()
	self.talentItemList = self:getUserDataTb_()
	self.polygonHardMap = {}

	gohelper.setActive(self._goruleItem, false)
	gohelper.setActive(self._gopolygonItem, false)
	gohelper.setActive(self._goresultItem, false)
	gohelper.setActive(self._gohardItem, false)

	self.goInfo = gohelper.findChild(self.viewGO, "root/info")
	self.animInfo = self.goInfo:GetComponent(gohelper.Type_Animator)
	self.infoAnimEventWrap = self.goInfo:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.infoAnimEventWrap:AddEventListener("refresh content", self.refreshPolygonInfo, self)

	self.taskAnim = gohelper.findChild(self.viewGO, "root/#btn_task/ani"):GetComponent(gohelper.Type_Animator)
end

function AtomicDungeonPolygonSelectView:onUpdateParam()
	return
end

function AtomicDungeonPolygonSelectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.stop_ui_langchao_mapamb_loop)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_screen_open)

	self.lastPolygonFightParam = self.viewParam

	RedDotController.instance:addRedDot(self._gotaskReddot, RedDotEnum.DotNode.SP02AtomicReward, nil, self.refreshTaskRedDotShow, self)
	self:refreshUI()
end

function AtomicDungeonPolygonSelectView:onOpenFinish()
	self:playUnlockAnim()
end

function AtomicDungeonPolygonSelectView:refreshTaskRedDotShow(redDotIcon)
	redDotIcon:defaultRefreshDot()
	self.taskAnim:Play(redDotIcon.show and "loop" or "idle", 0, 0)
	self.taskAnim:Update(0)
end

function AtomicDungeonPolygonSelectView:refreshUI()
	if self.viewParam then
		if not self.viewParam.mapId then
			local curMapId = AtomicDungeonModel.instance:getCurMapId()
			local mapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(curMapId)
			local mapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(mapConfig.infoId)
			local arenaMapId = mapConfig.infoId

			if mapInfoConfig.type == AtomicDungeonEnum.MapType.Polygon then
				arenaMapId = AtomicDungeonConfig.instance:getArenaMapIdByPolygonMapId(curMapId)
			end

			self.curSelectMapId = self.curSelectMapId or arenaMapId

			if self.viewParam then
				self.curPolygonId = self.viewParam.polygonId or AtomicDungeonConfig.instance:getPolygonIdByArenaMapId(self.curSelectMapId)
			end

			local curPolygonCo = AtomicDungeonConfig.instance:getPolygonConfig(self.curPolygonId)
			local isUnLock = AtomicDungeonModel.instance:getPolygonMo(curPolygonCo.id)

			if isUnLock then
				self.curPolygonId = self.curPolygonId or self:getFirstUnlockPolygonId()
			end

			self.curPassDiff = AtomicDungeonModel.instance:getPolygonDiffResult(self.curPolygonId)
			self.polygonMo = AtomicDungeonModel.instance:getPolygonMo(self.curPolygonId)
			self.curSelectMapId = self.polygonMo.config.mapId

			local curUnlockDiff = self.polygonMo:getCurUnlockDiff()

			if self.viewParam then
				self.curHardIndex = self.viewParam.hardIndex or AtomicDungeonController.instance:getCurPolygonSelectHard(self.curPolygonId)
			end

			self.curHardIndex = curUnlockDiff < self.curHardIndex and 1 or self.curHardIndex

			local savePolygonHardMap = AtomicDungeonController.instance:getLocalPolygonSelectHardMap()

			for mapId, hardIndex in pairs(savePolygonHardMap) do
				self.polygonHardMap[tonumber(mapId)] = hardIndex
			end

			self:refreshPolygonInfo()
			self:createAndRefreshPolygonItem()
			self:refreshPolygonItemSelectState()
			self:refreshResultItemAnim()
			self:refreshTalentItem()
		end
	end
end

function AtomicDungeonPolygonSelectView:getFirstUnlockPolygonId()
	local allPolygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()

	for _, polygonCo in ipairs(allPolygonCoList) do
		local isUnLock = AtomicDungeonModel.instance:getPolygonMo(polygonCo.id)

		if isUnLock then
			return polygonCo.id
		end
	end

	return allPolygonCoList[1].id
end

function AtomicDungeonPolygonSelectView:refreshPolygonInfo()
	local polygonDiffCo = AtomicDungeonConfig.instance:getPolygonDiffConfig(self.curPolygonId, self.curHardIndex)

	self._simageicon:LoadImage(ResUrl.getAtomicSingleBg(polygonDiffCo.image))

	self._txtpolygonName.text = polygonDiffCo.name
	self._txtindex.text = string.format("%02d", self.curSelectMapId)
	self._txtdesc.text = polygonDiffCo.description
	self.curPassDiff = AtomicDungeonModel.instance:getPolygonDiffResult(self.curPolygonId)

	gohelper.setActive(self._gounFinish, self.curPassDiff < polygonDiffCo.difficulty)

	self.curPolygonDiffCoList = AtomicDungeonConfig.instance:getAllPolygonDiffCoList(self.curPolygonId)

	local resultShowDataList = self:buildResultShowData(self.curPolygonId)

	self:refreshResultItem(resultShowDataList)
	self:refreshHardItem()
	gohelper.setActive(self._gomaxSub, self.curHardIndex <= 1)

	local curUnlockDiff = self.polygonMo:getCurUnlockDiff()

	gohelper.setActive(self._gomaxAdd, self.curHardIndex >= #self.curPolygonDiffCoList or curUnlockDiff <= self.curHardIndex)
	self:refreshAdditionRule()
	self:refreshTalentItem()
end

function AtomicDungeonPolygonSelectView:buildResultShowData(polygonId)
	local allPolygonDiffCoList = AtomicDungeonConfig.instance:getAllPolygonDiffCoList(polygonId)
	local passDiff = AtomicDungeonModel.instance:getPolygonDiffResult(polygonId)
	local resultShowDataList = {}

	for _, diffCo in ipairs(allPolygonDiffCoList) do
		local resultShowData = {}

		resultShowData.difficulty = diffCo.difficulty
		resultShowData.passDiff = passDiff

		table.insert(resultShowDataList, resultShowData)
	end

	return resultShowDataList
end

function AtomicDungeonPolygonSelectView:refreshResultItem(resultShowDataList)
	for index, resultShowData in ipairs(resultShowDataList) do
		local resultItem = self.resultItemList[index]

		if not resultItem then
			resultItem = {
				go = gohelper.clone(self._goresultItem, self._goresultContent, "resultItem" .. index)
			}
			resultItem.goDark = gohelper.findChild(resultItem.go, "go_dark")
			resultItem.goLight = gohelper.findChild(resultItem.go, "go_light")
			resultItem.lightAnim = resultItem.goLight:GetComponent(gohelper.Type_Animation)
			self.resultItemList[index] = resultItem
		end

		gohelper.setActive(resultItem.go, true)
		gohelper.setActive(resultItem.goDark, resultShowData.difficulty > resultShowData.passDiff)
		gohelper.setActive(resultItem.goLight, resultShowData.difficulty <= resultShowData.passDiff)
	end

	for index = #resultShowDataList + 1, #self.resultItemList do
		local resultItem = self.resultItemList[index]

		gohelper.setActive(resultItem.go, false)
	end
end

function AtomicDungeonPolygonSelectView:refreshHardItem()
	for index, polygonDiffCo in ipairs(self.curPolygonDiffCoList) do
		local hardItem = self.hardItemList[index]

		if not hardItem then
			hardItem = {
				go = gohelper.clone(self._gohardItem, self._gohardContent, "hardItem" .. index)
			}
			hardItem.goDark = gohelper.findChild(hardItem.go, "go_dark")
			hardItem.goLight = gohelper.findChild(hardItem.go, "go_light")
			hardItem.lightAnim = hardItem.goLight:GetComponent(gohelper.Type_Animation)
			self.hardItemList[index] = hardItem
		end

		gohelper.setActive(hardItem.go, index <= self.curHardIndex)
		gohelper.setActive(hardItem.goDark, index > self.curPassDiff)
		gohelper.setActive(hardItem.goLight, index <= self.curPassDiff)
	end

	for index = #self.curPolygonDiffCoList + 1, #self.hardItemList do
		local hardItem = self.hardItemList[index]

		gohelper.setActive(hardItem.go, false)
	end
end

function AtomicDungeonPolygonSelectView:refreshResultItemAnim()
	local polygonDiffCo = AtomicDungeonConfig.instance:getPolygonDiffConfig(self.curPolygonId, self.curHardIndex)

	if self.lastPolygonFightParam and self.lastPolygonFightParam.episodeId == polygonDiffCo.episodeId then
		local saveData = AtomicDungeonController.instance:getLockPolygonData(polygonDiffCo.id)

		if saveData then
			self.savePassDiff = saveData.passDiff or 0
		end

		self.curPassDiff = AtomicDungeonModel.instance:getPolygonDiffResult(self.curPolygonId)

		for index, resultItem in ipairs(self.resultItemList) do
			if index > self.savePassDiff and index <= self.curPassDiff then
				gohelper.setActive(resultItem.goDark, true)
				gohelper.setActive(resultItem.goLight, false)
			end
		end

		for index, hardItem in ipairs(self.hardItemList) do
			if index > self.savePassDiff and index <= self.curPassDiff then
				gohelper.setActive(hardItem.goDark, true)
				gohelper.setActive(hardItem.goLight, false)
			end
		end

		TaskDispatcher.runDelay(self.playNewUnlockAnim, self, 1.5)
	end

	self.lastPolygonFightParam = nil
end

function AtomicDungeonPolygonSelectView:playNewUnlockAnim()
	local isUnlockNew = false

	for index, resultItem in ipairs(self.resultItemList) do
		if index > self.savePassDiff and index <= self.curPassDiff then
			gohelper.setActive(resultItem.goLight, true)
			gohelper.setActive(resultItem.goDark, false)
			resultItem.lightAnim:Play()

			isUnlockNew = true
		end
	end

	for index, hardItem in ipairs(self.hardItemList) do
		if index > self.savePassDiff and index <= self.curPassDiff then
			gohelper.setActive(hardItem.goLight, true)
			gohelper.setActive(hardItem.goDark, false)
			hardItem.lightAnim:Play()
		end
	end

	if isUnlockNew then
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_checkpoint_unlock)
		TaskDispatcher.runDelay(self.jumpNextHard, self, 0.6)
	end

	local isOtherPolygonAllPass = self:checkOtherPolygonIsAllPass()
	local maxDifficulty = self.curPolygonDiffCoList[#self.curPolygonDiffCoList].difficulty

	if self.savePassDiff ~= self.curPassDiff and self.curPassDiff == maxDifficulty and not isOtherPolygonAllPass then
		GameFacade.showToast(ToastEnum.AtomicPolygonSelectHardAllUnlock)

		local allPolygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()

		for index, polygonCo in pairs(allPolygonCoList) do
			self.polygonHardMap[polygonCo.id] = maxDifficulty
		end

		AtomicDungeonController.instance:saveLocalPolygonSelectHard(self.polygonHardMap)
	end
end

function AtomicDungeonPolygonSelectView:jumpNextHard()
	if self.curHardIndex >= #self.curPolygonDiffCoList then
		return
	end

	local index = self.curHardIndex + 1

	if not self.polygonMo or not self.polygonMo.unlockDiffList[index] then
		return
	end

	self:_btnaddOnClick()
end

function AtomicDungeonPolygonSelectView:createAndRefreshPolygonItem()
	local allPolygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()

	for index, polygonCo in ipairs(allPolygonCoList) do
		local polygonItem = self.polygonItemMap[index]

		if not polygonItem then
			polygonItem = {
				go = gohelper.clone(self._gopolygonItem, self._gopolygonContent, "polygonItem" .. index)
			}
			polygonItem.anim = polygonItem.go:GetComponent(gohelper.Type_Animator)
			polygonItem.simagePic = gohelper.findChildSingleImage(polygonItem.go, "go_normal/simage_pic")
			polygonItem.txtName = gohelper.findChildText(polygonItem.go, "go_normal/name/txt_name")
			polygonItem.goResultContent = gohelper.findChild(polygonItem.go, "go_normal/go_resultContent")
			polygonItem.goResultItem = gohelper.findChild(polygonItem.go, "go_normal/go_resultContent/go_resultItem")
			polygonItem.goLock = gohelper.findChild(polygonItem.go, "go_normal/go_lock")
			polygonItem.btnClick = gohelper.findChildButtonWithAudio(polygonItem.go, "btn_click", AudioEnum3_10.Outside.play_ui_langchao_general_click)

			polygonItem.btnClick:AddClickListener(self._btnPolygonItemOnClick, self, polygonItem)

			self.polygonItemMap[index] = polygonItem
		end

		gohelper.setActive(polygonItem.go, true)

		polygonItem.config = polygonCo
		polygonItem.curSelectState = self.curPolygonId == polygonCo.id
		polygonItem.lastSelectState = polygonItem.lastSelectState
		polygonItem.isUnLock = AtomicDungeonModel.instance:getPolygonMo(polygonCo.id)

		local saveLocalData = AtomicDungeonController.instance:getLockPolygonData(polygonCo.id)
		local var_25_0 = polygonItem.lastUnlockState

		if not polygonItem.lastUnlockState then
			if saveLocalData then
				var_25_0 = saveLocalData.isUnLock or false
			end
		end

		polygonItem.lastUnlockState = var_25_0

		polygonItem.simagePic:LoadImage(ResUrl.getAtomicSingleBg(polygonCo.icon))

		if polygonItem.isUnLock then
			polygonItem.txtName.text = polygonCo.name or "????"
		end

		local resultShowDataList = self:buildResultShowData(polygonCo.id)

		gohelper.CreateObjList(self, self.onPolygonResultItemShow, resultShowDataList, polygonItem.goResultContent, polygonItem.goResultItem)
		gohelper.setActive(polygonItem.goLock, not polygonItem.isUnLock)
	end
end

function AtomicDungeonPolygonSelectView:onPolygonResultItemShow(obj, data, index)
	local goDark = gohelper.findChild(obj, "go_dark")
	local goLight = gohelper.findChild(obj, "go_light")

	gohelper.setActive(goDark, data.difficulty > data.passDiff)
	gohelper.setActive(goLight, data.difficulty <= data.passDiff)
end

function AtomicDungeonPolygonSelectView:checkOtherPolygonIsAllPass()
	local allPolygonCoList = AtomicDungeonConfig.instance:getAllPolygonCoList()
	local isAllPass = false

	for index, polygonCo in ipairs(allPolygonCoList) do
		if polygonCo.id ~= self.curPolygonId then
			local passDiff = AtomicDungeonModel.instance:getPolygonDiffResult(polygonCo.id)
			local allPolygonDiffCoList = AtomicDungeonConfig.instance:getAllPolygonDiffCoList(polygonCo.id)

			if passDiff == allPolygonDiffCoList[#allPolygonDiffCoList].difficulty then
				isAllPass = true

				break
			end
		end
	end

	return isAllPass
end

function AtomicDungeonPolygonSelectView:refreshPolygonItemSelectState()
	for _, polygonItem in pairs(self.polygonItemMap) do
		polygonItem.curSelectState = self.curPolygonId == polygonItem.config.id

		if polygonItem.curSelectState and polygonItem.lastSelectState ~= polygonItem.curSelectState then
			polygonItem.anim:Play("select", 0, 0)
			polygonItem.anim:Update(0)

			polygonItem.lastSelectState = polygonItem.curSelectState
		elseif not polygonItem.curSelectState and polygonItem.lastSelectState ~= polygonItem.curSelectState then
			polygonItem.anim:Play(polygonItem.isUnLock and "unselect" or "lock_idle", 0, 0)
			polygonItem.anim:Update(0)

			polygonItem.lastSelectState = polygonItem.curSelectState
		end
	end
end

function AtomicDungeonPolygonSelectView:playUnlockAnim()
	for index, polygonItem in pairs(self.polygonItemMap) do
		if polygonItem.isUnLock and polygonItem.lastUnlockState ~= polygonItem.isUnLock and not polygonItem.curSelectState then
			polygonItem.anim:Play("unlock", 0, 0)
			polygonItem.anim:Update(0)

			polygonItem.lastUnlockState = polygonItem.isUnLock
		end
	end
end

function AtomicDungeonPolygonSelectView:refreshAdditionRule()
	local polygonDiffCo = AtomicDungeonConfig.instance:getPolygonDiffConfig(self.curPolygonId, self.curHardIndex)
	local dungeonEpisodeCo = DungeonConfig.instance:getEpisodeCO(polygonDiffCo.episodeId)
	local battleCo = lua_battle.configDict[dungeonEpisodeCo.battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""

			self.ruleList = not string.nilorempty(additionRule) and FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#") or {}

			for index, ruleData in ipairs(self.ruleList) do
				local targetId = ruleData[1]
				local ruleId = ruleData[2]
				local ruleCo = lua_rule.configDict[ruleId]

				if ruleCo then
					local ruleItem = self.ruleItemList[index]

					if not ruleItem then
						ruleItem = {
							config = ruleCo,
							go = gohelper.clone(self._goruleItem, self._goruleContent, ruleCo.id)
						}
						ruleItem.ruleTag = gohelper.findChildImage(ruleItem.go, "image_ruleTag")
						ruleItem.ruleIcon = gohelper.findChildImage(ruleItem.go, "image_ruleIcon")
						ruleItem.btnClick = gohelper.findChildButtonWithAudio(ruleItem.go, "btn_click", AudioEnum3_10.Outside.play_ui_langchao_general_click)

						ruleItem.btnClick:AddClickListener(self._btnadditionRuleclickOnClick, self, ruleItem)

						self.ruleItemList[index] = ruleItem
					end

					gohelper.setActive(ruleItem.go, true)
					UISpriteSetMgr.instance:setCommonSprite(ruleItem.ruleTag, "wz_" .. targetId)
					UISpriteSetMgr.instance:setDungeonLevelRuleSprite(ruleItem.ruleIcon, ruleCo.icon)
				end
			end

			for index = #self.ruleList + 1, #self.ruleItemList do
				gohelper.setActive(self.ruleItemList[index].go, false)
			end
		end
	end
end

function AtomicDungeonPolygonSelectView:refreshTalentItem()
	local equipTalentList = AtomicModel.instance:getTalentEquipList()
	local polygonDiffCo = AtomicDungeonConfig.instance:getPolygonDiffConfig(self.curPolygonId, self.curHardIndex)
	local needTalentIdList = string.splitToNumber(polygonDiffCo.skillId, "#")

	for index, talentId in ipairs(needTalentIdList) do
		local talentItem = self.talentItemList[index]

		if not talentItem then
			talentItem = {
				go = gohelper.findChild(self.viewGO, "root/info/Skill/skillslot/#go_slot" .. index),
				index = index
			}
			talentItem.imageIcon = gohelper.findChildImage(talentItem.go, "image_icon")
			talentItem.goLock = gohelper.findChild(talentItem.go, "go_locked")
			talentItem.btnClick = gohelper.findChildButtonWithAudio(talentItem.go, "btn_click", AudioEnum3_10.Outside.play_ui_langchao_general_click)

			talentItem.btnClick:AddClickListener(self._btnTalentClickOnClick, self, talentItem)

			self.talentItemList[index] = talentItem
		end

		talentItem.id = talentId
		talentItem.config = AtomicConfig.instance:getTalentConfig(talentId)

		UISpriteSetMgr.instance:setSp02AtomicIconSprite(talentItem.imageIcon, talentItem.config.icon)

		local isUseTalent = tabletool.indexOf(equipTalentList, talentId)

		gohelper.setActive(talentItem.goLock, not isUseTalent)
	end
end

function AtomicDungeonPolygonSelectView:onClose()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_mapamb_loop)
	AtomicDungeonController.instance:saveLocalPolygonSelectHard(self.polygonHardMap)
	AtomicDungeonController.instance:saveLocalPolygonData()
	TaskDispatcher.cancelTask(self.jumpNextHard, self)
	TaskDispatcher.cancelTask(self.playNewUnlockAnim, self)
	AtomicDungeonController.instance:saveLocalPolygonSelectUnlockIdList()
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnClosePolygonSelectView)
end

function AtomicDungeonPolygonSelectView:onDestroyView()
	self._simageicon:UnLoadImage()

	for _, polygonItem in pairs(self.polygonItemMap) do
		polygonItem.btnClick:RemoveClickListener()
		polygonItem.simagePic:UnLoadImage()
	end

	for _, ruleItem in pairs(self.ruleItemList) do
		ruleItem.btnClick:RemoveClickListener()
	end

	for _, talentItem in pairs(self.talentItemList) do
		talentItem.btnClick:RemoveClickListener()
	end

	self.infoAnimEventWrap:RemoveAllEventListener()
end

return AtomicDungeonPolygonSelectView
