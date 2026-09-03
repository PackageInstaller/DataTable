-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeMainMediator.lua

require("dm.gameplay.maze.view.MazeOptionCell")
require("dm.gameplay.maze.view.MazeChapterCell")

MazeMainMediator = class("MazeMainMediator", DmAreaViewMediator, _M)

MazeMainMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeMainMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["leftpanel.kzbtn"] = "onClickCards",
	["leftpanel.bwbtn"] = "onClickTreasure",
	["eventSkill.checkBtn"] = "onClickEventSkillUse",
	["bg_title.btnjs"] = "onClickOvewMaze",
	["leftpanel.jnbtn"] = "onClickEventSkill"
}

function MazeMainMediator:initialize()
	super.initialize(self)

	self._optionCells = {}
	self._chapterCells = {}
	self._selectIndex = ""
	self._selectChapterIndex = ""
end

function MazeMainMediator:dispose()
	super.dispose(self)
end

function MazeMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_UPDATE_OPTION, self, self.updateOptions)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_REFRESH_OPTION_SUC, self, self.updateOptions)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_FINALL_BOSS_SHOW, self, self.showFinalBoss)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_SHOW_GP, self, self.showVotesView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_BUFF_SUC, self, self.updateBuff)
end

function MazeMainMediator:onRemove()
	super.onRemove(self)
end

function MazeMainMediator:enterWithData(data)
	self:initData()
	self:initViews()
	self:updateQuestion()
	self:updateChapterBossSuspect()
end

function MazeMainMediator:initData()
	self._isShowEventTips = false
end

function MazeMainMediator:initViews()
	self._bgTitle = self:getView():getChildByFullName("bg_title")
	self._optionsPanel = self:getView():getChildByFullName("optionsPanel")
	self._chapterPanel = self:getView():getChildByFullName("chapterPanel")
	self._blurBg = self:getView():getChildByFullName("Image_6")
	self._lv = self._bgTitle:getChildByFullName("level")
	self._cardNum = self._bgTitle:getChildByFullName("cardnum")
	self._hpNode = self._bgTitle:getChildByFullName("s1bg.fg")
	self._expNode = self._bgTitle:getChildByFullName("s2bg.fg")
	self._masterexp = self._bgTitle:getChildByFullName("mazeexp")
	self._bossnum = self._bgTitle:getChildByFullName("bossnum")
	self._finalBoss = self:getView():getChildByFullName("finalBossPanel")
	self._eventTips = self:getView():getChildByFullName("eventSkill")

	self._eventTips:setVisible(self._isShowEventTips)
	self:initHeadTouch()
	self:updateMasterView()
	self:updateOptions()
	self:updateBuff()
	self:setupTopInfoWidget()
end

function MazeMainMediator:initHeadTouch()
	local headtouch = self:getView():getChildByFullName("bg_title.headtouch")

	headtouch:addTouchEventListener(function(sender, eventType)
		self:onClickSkill(sender, eventType)
	end)

	local skilltouchmask = self:getView():getChildByFullName("eventSkill")

	skilltouchmask:addTouchEventListener(function(sender, eventType)
		self._eventTips:setVisible(false)
	end)
end

function MazeMainMediator:updateBuff()
	if self._mazeSystem._mazeChapter then
		local buffData = self._mazeSystem._mazeChapter:getBuffData()
		local panel = self:getView():getChildByFullName("bg_title.Panel_1")

		panel:removeAllChildren()

		local count = 1

		if buffData then
			for k, v in pairs(buffData) do
				local bufficon = ConfigReader:getDataByNameIdAndKey("SkillAttrEffect", v.id, "Icon")
				local skillicon = IconFactory:createSkillPic({
					id = bufficon
				})

				skillicon:setPosition(20 + (count - 1) * 50, 18)
				skillicon:setScale(0.5)
				panel:addChild(skillicon)

				count = count + 1

				print("buffid--->", v.id)
			end
		end
	end
end

function MazeMainMediator:resetOptionsPancel()
	local max = 3
	local optionsPanel = self._optionsPanel

	if not optionsPanel._location then
		optionsPanel._location = {}

		for i = 1, max do
			local key = tostring(i - 1)

			optionsPanel._location[key] = optionsPanel:getChildByFullName("option_" .. key)
		end

		optionsPanel._location.boss = optionsPanel:getChildByFullName("option_boss")
	end

	for k, v in pairs(optionsPanel._location) do
		v:removeAllChildren()
	end
end

function MazeMainMediator:updateOptions()
	self._finalBoss:setVisible(false)

	local mazeSystem = self._mazeSystem
	local mazeChapter = mazeSystem._mazeChapter

	if not mazeChapter then
		return
	end

	local lastCount = mazeChapter:getBossStep()
	local showOptions = mazeChapter:getShowOption()

	self:resetOptionsPancel()

	local optionsPanel = self._optionsPanel

	self._optionCells = {}

	if table.nums(showOptions) > 0 then
		for k, v in pairs(showOptions) do
			local optioncell = self:getInjector():injectInto(MazeOptionCell:new(v, mazeSystem))

			optioncell:updateUI()

			local optionModel = optioncell:getModel()

			if optionModel:isTypeBoss() then
				lastCount = lastCount + 1
			end

			self._optionCells[k] = optioncell

			local cellView = optioncell:getView()

			optioncell:setIndex(k)
			optioncell._touchmask:addTouchEventListener(function(sender, eventType)
				optioncell:onClickCell(sender, eventType)

				self._selectIndex = k

				mazeSystem:setCurOptionIndex(self._selectIndex)
				self:resetOtherOptions(optioncell)
			end)

			local parentNode

			;(optionModel:isTypeBoss() and optionsPanel._location.boss or optionsPanel._location[k]):addChild(cellView)
		end
	end

	self:updateBuff()
	self._bossnum:setString(lastCount)
	self._optionsPanel:setVisible(not mazeChapter:getIsNeedSelecgChapter())
	self._chapterPanel:setVisible(mazeChapter:getIsNeedSelecgChapter())

	if mazeChapter:getIsNeedSelecgChapter() then
		self:showChapterPanel()
	end

	self:updateMasterView()
	self:updateSuspectList()
end

function MazeMainMediator:showChapterPanel()
	local chapterOptions = self._mazeSystem:getNextChaptersId()

	dump(chapterOptions, "可选章节数据")

	local parentNode = self._chapterPanel:getChildByFullName("chapter_1")

	parentNode:removeAllChildren()

	self._chapterCells = {}

	if table.nums(chapterOptions) > 0 then
		for k, v in pairs(chapterOptions) do
			local parentNode = self._chapterPanel:getChildByFullName("chapter_" .. k)
			local chaptercell = MazeChapterCell:new(v, self._mazeSystem)

			self._chapterCells[k] = chaptercell

			local cellView = chaptercell:getView()

			chaptercell:setChapterIndex(v)
			chaptercell._touchmask:addTouchEventListener(function(sender, eventType)
				chaptercell:onClickCell(sender, eventType)

				self._selectChapterIndex = v

				self._mazeSystem:setCurChapterIndex(self._selectChapterIndex)
				self:resetOtherChapters()
			end)
			cellView:getChildByFullName("cellclone.bg.title"):setString(chaptercell:getChapterName())
			cellView:getChildByFullName("cellclone.desc"):setString(chaptercell:getChapterDesc())
			cellView:getChildByFullName("cellclone.checkBtn.Text_3"):setString(chaptercell:getChapterBtnName())

			local icon = chaptercell:getChapterIcon()
			local iconbg = cellView:getChildByFullName("cellclone.bg.icon_bg.icon")
			local aninode = cellView:getChildByFullName("cellclone.bg.icon_bg.aninode")

			parentNode:addChild(cellView)
			chaptercell._checkBtn:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					print("点击了chapter--->", chaptercell:getChapterIndex())
					self._mazeSystem:requestNextChapterMaze(self._mazeSystem._mazeEvent:getConfigId(), function(response)
						print("进入下一章节成功")
						self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
					end)
				end
			end)
		end
	end
end

function MazeMainMediator:showFinalBoss()
	print("--------显示最终boss-------")

	local allSuspect = self._mazeSystem._mazeChapter._suspectPointList
	local unlockSuspect = self._mazeSystem._mazeChapter._finalSuspects

	if table.nums(unlockSuspect) <= 0 then
		return
	end

	dump(allSuspect, "allSuspect")
	dump(unlockSuspect, "_finalSuspects")

	local bossList = {}

	for k, v in pairs(allSuspect) do
		bossList[k] = 0

		for kk, vv in pairs(unlockSuspect) do
			if vv == k then
				bossList[k] = 1
			end
		end
	end

	self:createFinalBossList(bossList)
	self._finalBoss:setVisible(true)
end

function MazeMainMediator:createFinalBossList(bosslist)
	local index = 1
	local parent = self:getView():getChildByFullName("finalBossPanel.suspectPanel")

	parent:setInnerContainerSize(cc.size(table.nums(bosslist) * 300, 160))

	for k, v in pairs(bosslist) do
		if v == 1 then
			local cell = self:getView():getChildByFullName("finalBossPanel.cellclone")
			local bosscell = cell:clone()

			bosscell:setSwallowTouches(false)
			bosscell:setPosition(100 + (index - 1) * 300, 0)
			parent:addChild(bosscell)
			self:setFinalBossInfo(bosscell, k, v)

			index = index + 1
		end
	end

	for k, v in pairs(bosslist) do
		if v == 0 then
			local cell = self:getView():getChildByFullName("finalBossPanel.cellclone")
			local bosscell = cell:clone()

			bosscell:setSwallowTouches(false)
			bosscell:setPosition(100 + (index - 1) * 300, 0)
			parent:addChild(bosscell)
			bosscell:getChildByFullName("bg.icon_bg"):setGray(true)
			self:setFinalBossInfo(bosscell, k, v)

			index = index + 1
		end
	end

	dump(bosslist, "bosslist")
end

function MazeMainMediator:createFinalBossAni(id)
	local iconidd = ConfigReader:getDataByNameIdAndKey("RoleModel", id, "Model")
	local ani = self._mazeSystem:createOneMasterAni(iconidd)

	ani:playAnimation(0, "stand", true)
	ani:setGray(false)

	return ani
end

function MazeMainMediator:setFinalBossInfo(cell, id, lockstage)
	local name = Strings:get(ConfigReader:getDataByNameIdAndKey("PansLabSuspects", id, "Name"))

	cell:getChildByFullName("lock"):setVisible(lockstage == 0)
	cell:getChildByFullName("bg.title"):setString(name)

	local ani = self:createFinalBossAni(ConfigReader:getDataByNameIdAndKey("PansLabSuspects", id, "Model"))
	local an = cell:getChildByFullName("bg.icon_bg.Panel_14")

	if lockstage == 0 then
		cell:getChildByFullName("bg.icon_bg"):setGray(true)
		cell:getChildByFullName("checkBtn"):setVisible(false)
	end

	ani:setGray(lockstage == 0)
	an:addChild(ani)
	cell:getChildByFullName("checkBtn"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._mazeSystem:requestMazeFinalBossBattleBefore(self._mazeSystem._mazeEvent:getConfigId(), id, function()
				return
			end)
		end
	end)
end

function MazeMainMediator:showVotesView()
	if not self._mazeSystem._mazeChapter then
		return
	end

	local suspectsdata = self._mazeSystem._mazeChapter._suspectPointList
	local votes = 0

	for k, v in pairs(suspectsdata) do
		votes = votes + v
	end

	self._mazeSystem:getChapter()._nextChapterIds = ConfigReader:getDataByNameIdAndKey("PansLabChapter", self._mazeSystem._mazeChapter._chapterId, "NextChapter") or ""

	local c0 = table.nums(self._mazeSystem._mazeChapter._showOptions)
	local c1 = table.nums(suspectsdata)
	local c2 = self._mazeSystem._mazeChapter._nextChapterIds
	local c3 = table.nums(self._mazeSystem._mazeChapter._leftOptions)

	if c1 > 0 and votes > 0 and c2 == "" and c3 == 0 and c0 == 0 then
		local view = self:getInjector():getInstance("MazeSuspectVotesView")
		local data = {
			suspects = suspectsdata
		}

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	end
end

function MazeMainMediator:updateTreasureUse()
	if self._mazeSystem._mazeChapter then
		local treasure = self._mazeSystem._mazeChapter:getDelTreasure()

		if treasure then
			dump(treasure, "有使用的被动宝物")

			local view = self:getInjector():getInstance("MazeTreasureUseSucView")
			local data = {
				name = treasure:getName(),
				effect = treasure:getDesc()
			}

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))

			self._mazeSystem._mazeChapter.delTreasure = nil
		end
	end
end

function MazeMainMediator:updateQuestion()
	local have, questions = self._mazeSystem:haveQuestion()
	local clueset = self._mazeSystem:getClueSet()
	local cluesetid = self._mazeSystem:getClueSetId()

	if have then
		local view = self:getInjector():getInstance("MazeQuestionView")
		local data = {
			question = questions,
			clues = clueset,
			cluesid = cluesetid
		}

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	else
		self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
		self:showVotesView()
	end
end

function MazeMainMediator:updateChapterBossSuspect()
	local have, suspects = self._mazeSystem:haveBossSuspect()
	local eff = self._mazeSystem:getBossSuspectEff()
	local ques = self._mazeSystem:getBossSuspectQues()

	if have then
		local view = self:getInjector():getInstance("MazeChapteBossView")
		local data = {
			suspects = suspects,
			effect = eff,
			question = ques
		}

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	end
end

function MazeMainMediator:updateMasterView()
	local master = self._mazeSystem:getSelectMaster()
	local parentNode = self._bgTitle:getChildByFullName("txbg")

	if not master.id then
		return
	end

	local info = {
		name = "head",
		id = ConfigReader:getDataByNameIdAndKey("EnemyMaster", master.id, "RoleModel")
	}
	local img = IconFactory:createRoleIconSpriteNew(info)

	img = IconFactory:addStencilForIcon(img, 2, cc.size(100, 100))

	img:setScale(1.2)
	img:addTo(parentNode):center(parentNode:getContentSize()):offset(0, 7)
	self._lv:setString("Lv." .. self._mazeSystem:getSelectMasterLv())
	self._cardNum:setString(self._mazeSystem:getCurHeroNum() .. "/10")

	local curhp = self._mazeSystem:getMasterCurHp()
	local maxhp = self._mazeSystem:getMasterMaxHp()
	local curexp = self._mazeSystem:getMasterCurExp()
	local maxexp = self._mazeSystem:getMasterLevelMaxExp()
	local hpratio = curhp / maxhp

	if hpratio > 1 then
		hpratio = 1
	end

	self._hpNode:setScaleX(hpratio)
	self._expNode:setScaleX(curexp / maxexp)
	self._masterexp:setString(curexp .. "/" .. maxexp)
end

function MazeMainMediator:resetOtherOptions()
	local showOptions = self._mazeSystem._mazeChapter:getShowOption()

	for k, v in pairs(showOptions) do
		local parentNode = self._optionsPanel:getChildByFullName("option_" .. k)
		local cell = self._optionCells[k]

		if k ~= self._selectIndex then
			cell:resetCell()
		end
	end
end

function MazeMainMediator:resetOtherChapters()
	local showChapters = self._mazeSystem:getNextChaptersId()

	for k, v in pairs(showChapters) do
		local parentNode = self._chapterPanel:getChildByFullName("chapter_" .. k)
		local cell = self._chapterCells[k]

		if v ~= self._selectChapterIndex then
			cell:resetCell()
		end
	end
end

function MazeMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("PansLabNormal")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		title = "",
		hideLine = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickExit, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MazeMainMediator:resumeWithData()
	print("-----------resumeWithData----------")

	if self._mazeSystem:getMasterIsLvUp() then
		self._mazeSystem:setMasterIsLvUp(false)

		local name = self._mazeSystem:getSelectMasterName()
		local oldattr, newattr, difAttr = self._mazeSystem:getMasterUpAttr()
		local data = {
			olddata = oldattr,
			newdata = newattr,
			difdata = difAttr,
			masterid = self._mazeSystem:getSelectMasterId(),
			heroname = name
		}
		local view = self:getInjector():getInstance("MazeMasterUpSucView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	end

	self:updateTreasureUse()
end

function MazeMainMediator:onClickSkill(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("MazeMasterSkillView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil))
	end
end

function MazeMainMediator:onClickTreasure(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		print("宝物")

		local view = self:getInjector():getInstance("MazeTreasureOwnView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil))
	end
end

function MazeMainMediator:onClickEventSkill(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._isShowEventTips = not self._isShowEventTips

		local skillusebtn = self:getView():getChildByFullName("eventSkill.checkBtn")

		if self._mazeSystem._mazeChapter:getSkill().coolDown == 0 then
			skillusebtn:setGray(false)
			skillusebtn:setTouchEnabled(true)
		else
			skillusebtn:setTouchEnabled(false)
			skillusebtn:setGray(true)
		end

		self._eventTips:getChildByFullName("effect"):setString(self._mazeSystem._mazeChapter:getSkill().desc)
		self._eventTips:getChildByFullName("cdtime"):setString(self._mazeSystem._mazeChapter:getSkill().coolDown .. "次战斗后冷却")
		self._eventTips:setVisible(self._isShowEventTips)
	end
end

function MazeMainMediator:onClickEventSkillUse(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		print("----释放事件技能-----")

		self._isShowEventTips = false

		self._eventTips:setVisible(false)

		local data = self._mazeSystem._heros
		local view = self:getInjector():getInstance("MazeHeroUpView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			_index = 4,
			_data = data
		}))
	end
end

function MazeMainMediator:onClickCards(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._mazeSystem:enterTeamView()
	end
end

function MazeMainMediator:didFinishResumeTransition()
	print("--------------MazeMainMediator:didFinishResumeTransition()-----------")
	self:updateQuestion()
	self:updateChapterBossSuspect()
end

function MazeMainMediator:getKeyByValue(targetTable, value)
	for k, v in pairs(targetTable) do
		if value == v then
			return k
		end
	end
end

function MazeMainMediator:updateSuspectList()
	local suspectList = self._mazeSystem:getAllSuspectList()

	dump(suspectList, "suspectList")

	for i = 1, 8 do
		local parentNode = self:getView():getChildByFullName("cell_" .. i)

		parentNode:setVisible(false)
	end

	for i, v in ipairs(suspectList) do
		local num = v.num
		local id = v.id

		if num > 0 then
			local parentNode = self:getView():getChildByFullName("cell_" .. i)
			local votes = parentNode:getChildByFullName("votes")

			votes:setString(num)

			local ids = ConfigReader:getDataByNameIdAndKey("PansLabSuspects", id, "Model")
			local head = parentNode:getChildByFullName("head")
			local img = IconFactory:createRoleIconSpriteNew({
				id = ids
			})

			img:setScale(0.5)

			img = IconFactory:addStencilForIcon(img, 2, cc.size(76, 76))

			img:addTo(head):center(head:getContentSize()):offset(-3, 3)
			parentNode:setVisible(true)
		end
	end
end

function MazeMainMediator:onClickOvewMaze(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local outSelf, delegate = self, {}
		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("MAZE_OVER_TIPS"),
			sureBtn = {},
			cancelBtn = {}
		}

		local function fun()
			outSelf._mazeSystem:requestOverMaze(self._mazeSystem._mazeEvent:getConfigId(), function(response)
				outSelf:dismiss()
				outSelf._mazeSystem:setIsInPoint(false)
			end)
		end

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				fun()
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
end

function MazeMainMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end
