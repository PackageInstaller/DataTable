-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\DispatchInfoDlg.lua

local ResColor = require("ClientData/ResColor")
local ResHero = require("ClientData/ResHero")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local DispatchHeroAddCell = Class("DispatchHeroAddCell", UIControls.Child)
local STATE = {
	LOCK = 1,
	NORMAL = 3,
	ADD = 2
}

function DispatchHeroAddCell:ctor(...)
	self:initUI()
end

function DispatchHeroAddCell:initUI(...)
	self.gridHero = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")
	self.panelHeroAdd = UIControls.Panel(self, "HeroAdd")
	self.imgAdd = UIControls.Image(self, "HeroAdd/IconAdd")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)
	self.gridHero:setClickCallback(Slot(self.onBtnSensorClick, self))
end

function DispatchHeroAddCell:setData(hero)
	self.hero = hero

	self:refreshState()
	self:_initHeroData()
end

function DispatchHeroAddCell:refreshState(...)
	self.heroInfo = self.mWindow:getHeroResid(self.mIndex)

	if self.hero == nil and self.heroInfo == nil then
		self.state = STATE.ADD
	else
		self.state = STATE.NORMAL
	end

	self.panelHeroAdd:setVisible(self.state == STATE.ADD)
	self.imgAdd:setVisible(self.mWindow.isReady == true)
end

function DispatchHeroAddCell:_initHeroData(...)
	if self.hero == nil and self.heroInfo == nil then
		self.gridHero:setVisible(false)
	else
		if self.hero then
			self.gridHero:setHero(self.hero)
			self.gridHero:setDispatchState()
		elseif self.heroInfo then
			local level = self.heroInfo.level
			local resData = ResHero[self.heroInfo.res_id]
			local modelData = utils.getCommonModelData(resData.model)
			local iconPath = self:_getIconPath(modelData)
			local groupPath = self:_getGroupPath(resData)
			local starPath = self:_getStarPath(self.heroInfo.star)
			local stepImgInfo = self:_getStepImgPath(self.heroInfo.star)

			self.gridHero:setDispatchInfo(level, iconPath, groupPath, starPath, stepImgInfo, self.mWindow.task:getStepDesc())
		end

		self.gridHero:setVisible(true)
	end
end

function DispatchHeroAddCell:_getIconPath(modelData)
	if modelData and modelData.head_path and modelData.head_name then
		return {
			"Atlas/" .. modelData.head_path,
			modelData.head_name
		}
	end
end

function DispatchHeroAddCell:_getGroupPath(resData)
	if resData and resData.camp then
		return UIConst.getHeroCampIconPath(resData.camp)
	end
end

function DispatchHeroAddCell:_getStarPath(star)
	star = star or self.star

	if star then
		local starPath = star < 10 and "IconStar0" or "IconStar"

		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			starPath .. star
		}
	end
end

function DispatchHeroAddCell:_getStepImgPath(star)
	local stepImgIdx = ResStarUpCondition[star].step_img_idx or 1

	return UIConst.HERO_QUALITY_HEAD_CONFIG[stepImgIdx]
end

function DispatchHeroAddCell:onBtnSensorClick(...)
	if self.mWindow.task.isDoing == true then
		-- block empty
	elseif self.mWindow.isShowCardList == false then
		self.mWindow:showCardList(true)
	elseif self.hero then
		self.mWindow:chooseInverse(self.hero.gid)
	end
end

local COLOR = {
	YELLOW = {
		g = 0.8117647058823529,
		a = 1,
		b = 0.5725490196078431,
		r = 1
	},
	GRAY = {
		g = 0.3333333333333333,
		a = 1,
		b = 0.3333333333333333,
		r = 0.3333333333333333
	}
}
local DispatchHeroChooseCell = Class("DispatchHeroChooseCell", UIControls.ScrollViewLoopCell)

function DispatchHeroChooseCell:ctor(...)
	self:initUI()
end

function DispatchHeroChooseCell:initUI(...)
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.imgLock = UIControls.Image(self, "HeroLock")
	self.imgSelect = UIControls.Image(self, "TickHero")
	self.gridHero = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")
end

function DispatchHeroChooseCell:setData(heroData)
	self.heroData = heroData
	self.hero = heroData.hero

	self.gridHero:setHero(self.hero)
	self.gridHero:setDispatchState()
	self.gridHero:setVisible(true)
	self.imgLock:setVisible(self.heroData.isLimit)
	self.imgSelect:setVisible(self.heroData.isSelect)
end

function DispatchHeroChooseCell:onBtnSensorClick(...)
	if self.heroData.isLimit then
		MsgManager.notice(Lang.get(30666))

		return
	end

	if self.heroData.isSelect == false and self.mWindow:isEnough() then
		MsgManager.notice(Lang.get(30667))

		return
	end

	self.mWindow:onHeroChooseStateChange(self.heroData, not self.heroData.isSelect)
end

local strClassName = "DispatchInfoDlg"
local DispatchInfoDlg = Class(strClassName, UIControls.Window)

function DispatchInfoDlg:ctor(...)
	self:initUI()
end

function DispatchInfoDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnLock = UIControls.Button(self, "BgPanel/BtnLock")

	self.btnLock:addEventClick(self.onBtnLockClick)

	self.imgUnlock = UIControls.Image(self, "BgPanel/BtnLock/ImgUnlock")
	self.imgLock = UIControls.Image(self, "BgPanel/BtnLock/Imglock")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnConfirm.txtContent = UIControls.Label(self, "BgPanel/BtnConfirm/Text")
	self.btnConfirm.txtContentEn = UIControls.Label(self, "BgPanel/BtnConfirm/TextEng")
	self.btnCancel = UIControls.Button(self, "BgPanel/BtnRevoke")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnBlock = UIControls.Button(self, "BgPanel/Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.btnQuickPatch = UIControls.Button(self, "BgPanel/BtnCancel")

	self.btnQuickPatch:addEventClick(self.onBtnQuickPatchClick)

	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.txtRule = UIControls.Label(self, "BgPanel/TextRule")
	self.txtNum = UIControls.Label(self, "BgPanel/TextHeroNumTitle/TextHeroNum")
	self.txtProgress = UIControls.Label(self, "BgPanel/TextConduct")
	self.txtCondition = UIControls.Label(self, "BgPanel/ConditionPanel/Text")
	self.imgCamp = UIControls.Image(self, "BgPanel/ConditionPanel/ImgGroup")
	self.panelCardList = UIControls.Panel(self, "CardListPanel")
	self.panelHero = UIControls.Panel(self, "BgPanel/HeroPanel")
	self.scrollViewHeroList = UIControls.ScrollViewLoopV(self, "CardListPanel/HeroList", 0, self.onHeroChanged)
	self.choosedHeroCells = {}
	self.isShowCardList = false
end

function DispatchInfoDlg:onHeroChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = DispatchHeroChooseCell(sender, "System/Backyard/BtnDispatchChoose", newIdx)
	end

	targetCell:setData(self.heros[newIdx])
end

function DispatchInfoDlg:setData(task, isReady)
	self.choosedHeros = {}
	self.task = task
	self.isReady = isReady

	self:initChoosedHeros()
	self:initHeroData()
	self:initData()
	self:_refreshUI()
end

function DispatchInfoDlg:initChoosedHeros(...)
	local data = self.task:getInTaskHeroInfos()

	for _, info in ipairs(data) do
		local hero = CurAvatar.heroDic[info.use_gid]

		if hero then
			table.insert(self.choosedHeros, hero)
		end
	end
end

function DispatchInfoDlg:initHeroData(...)
	self:refreshChoosedHeros()
end

function DispatchInfoDlg:refreshHeroList(...)
	self.scrollViewHeroList:setTotalCount(#self.heros)
end

function DispatchInfoDlg:getHeroResid(index)
	local data = self.task:getInTaskHeroInfos()

	return data[index]
end

function DispatchInfoDlg:refreshChoosedHeros(...)
	for i = 1, self.task.require_num do
		local cell = self.choosedHeroCells[i]

		if cell then
			-- block empty
		else
			cell = DispatchHeroAddCell(self, "BgPanel/HeroPanel", "System/Backyard/BtnDispatchAdd")

			table.insert(self.choosedHeroCells, cell)
		end

		cell.mIndex = i

		cell:setData(self.choosedHeros[i])
		cell:setVisible(true)
	end

	for i = self.task.require_num + 1, #self.choosedHeroCells do
		self.choosedHeroCells[i]:setVisible(false)
	end
end

function DispatchInfoDlg:initData(...)
	self:initMyHeros()
	self.txtTitle:setText(self.task.name)
	self.txtRule:setText(self.task.desc)

	if self.task.require_step > 0 then
		self.txtCondition:setText(self.task:getStepDesc())
	end

	self.btnLock:setVisible(self.task.isDoing == false)

	if self.task:isRequireCamp() == false then
		self.imgCamp:setVisible(false)
	else
		self.imgCamp:setVisible(true)
		self.imgCamp:setImage("Atlas/HeroAtlas/HeroCardCommonAtlas", "IconGroup0" .. self.task:getRequireCamp())
	end

	for i = 1, #self.task.awardItems do
		local cell = UIControls.getGridAwardContainer(self, "BgPanel/GridMaterialItemPanel")

		cell:setObj(self.task.awardItems[i])

		cell.grid.mDisableWays = true

		cell:setVisible(true)
	end
end

function DispatchInfoDlg:refreshUI(...)
	self:_refreshUI()
end

function DispatchInfoDlg:_refreshUI(...)
	if self.task.isDone == true then
		self:setVisible(false)

		return
	end

	if self.task.isDoing == true then
		self.txtNum:setText(self.task.require_num .. "/" .. self.task.require_num)
	else
		self.txtNum:setText(#self.choosedHeros .. "/" .. self.task.require_num)
	end

	self:changeLockState(self.task.isLock)

	if self:isEnough() or self.task.isDoing == true then
		self.btnQuickPatch:setVisible(false)
	else
		self.btnQuickPatch:setVisible(self:checkQuickChoose())
	end

	if self.task.isDoing then
		self.txtProgress:setVisible(true)
		self.btnConfirm:setVisible(false)
	else
		self.txtProgress:setVisible(false)
		self.btnConfirm:setVisible(true)

		local result = self:checkTaskState()
		local color

		if result == false then
			color = COLOR.GRAY

			self.btnConfirm.txtContent:setColorByRGBA(color.r, color.g, color.b, color.a)
			self.btnConfirm.txtContentEn:setColorByRGBA(color.r, color.g, color.b, color.a)
		else
			color = COLOR.YELLOW

			self.btnConfirm.txtContent:setFontColor(ResColor.WHITE)
			self.btnConfirm.txtContentEn:setColorByRGBA(color.r, color.g, color.b, color.a)
		end

		self.btnConfirm:setObjGray(not result)
	end
end

function DispatchInfoDlg:initMyHeros(...)
	self.heros = {}

	for k, v in pairs(CurAvatar.heroDic) do
		local data = {
			hero = v
		}

		data.isLimit = self:isHeroLimit(v)
		data.isSelect = false

		table.insert(self.heros, data)
	end

	table.sort(self.heros, self._sortHeroFunc)
end

function DispatchInfoDlg._sortHeroFunc(v1, v2)
	if v1.isLimit == v2.isLimit then
		return v1.hero.step < v2.hero.step
	elseif v1.isLimit then
		return false
	else
		return true
	end
end

function DispatchInfoDlg:showCardList(v)
	if v then
		if self.isShowCardList ~= v then
			self:playAni("ShowCardListPanel")

			self.isShowCardList = v

			if self.showHeros == nil then
				self:refreshHeroList()
				self:_refreshUI()

				self.showHeros = true
			end
		end
	elseif self.isShowCardList ~= v then
		self:playAni("CloseCardListPanel")

		self.isShowCardList = v
	end
end

function DispatchInfoDlg:changeLockState(isLock)
	self.imgUnlock:setVisible(not isLock)
	self.imgLock:setVisible(isLock)
	self:refreshTaskState()

	for i, cell in ipairs(self.choosedHeroCells) do
		cell:refreshState()
	end
end

function DispatchInfoDlg:checkTaskState(...)
	if false and self.task.isLock then
		return false, Lang.get(30668)
	elseif self:isEnough() == false then
		return false, Lang.get(30669)
	end

	return true
end

function DispatchInfoDlg:isHeroLimit(hero)
	if self.inTaskMap == nil then
		self.inTaskMap = RearHouseCommon.getInTaskGidsMap()
	end

	local isInTask = self.inTaskMap[hero.gid] == true
	local isAttrNotOk = self.task:isHeroLimit(hero)

	return isInTask or isAttrNotOk
end

function DispatchInfoDlg:chooseInverse(gid)
	for _, heroData in ipairs(self.heros) do
		if heroData.hero.gid == gid then
			self:onHeroChooseStateChange(heroData, false)

			break
		end
	end
end

function DispatchInfoDlg:onHeroChooseStateChange(heroData, isChoose)
	heroData.isSelect = isChoose

	if isChoose then
		table.insert(self.choosedHeros, heroData.hero)
	else
		for i = #self.choosedHeros, 1, -1 do
			if self.choosedHeros[i].gid == heroData.hero.gid then
				table.remove(self.choosedHeros, i)

				break
			end
		end
	end

	self:refreshChoosedHeros()
	self:refreshHeroList()
	self:_refreshUI()
end

function DispatchInfoDlg:isEnough(...)
	return #self.choosedHeros == self.task.require_num
end

function DispatchInfoDlg:checkQuickChoose(...)
	local data = self:_getQuickChooseData()

	return #data == self.task.require_num
end

function DispatchInfoDlg:_getQuickChooseData(...)
	local data = {}
	local choosedMap = {}

	for _, hero in ipairs(self.choosedHeros) do
		choosedMap[hero.gid] = true

		table.insert(data, hero)
	end

	for _, heroData in ipairs(self.heros) do
		if heroData.isLimit == true then
			break
		end

		if choosedMap[heroData.hero.gid] ~= true and #data < self.task.require_num then
			table.insert(data, heroData.hero)

			if #data == self.task.require_num then
				break
			end
		end
	end

	return data
end

function DispatchInfoDlg:_onQuickChoose(...)
	self.choosedHeros = self:_getQuickChooseData()

	local map = {}

	for _, hero in ipairs(self.choosedHeros) do
		map[hero.gid] = true
	end

	for _, heroData in ipairs(self.heros) do
		if map[heroData.hero.gid] then
			heroData.isSelect = true
		else
			heroData.isSelect = false
		end
	end

	table.sort(self.choosedHeros, self._sortHeroByStep)
	self:refreshChoosedHeros()
	self:refreshHeroList()
	self:_refreshUI()
end

function DispatchInfoDlg._sortHeroByStep(v1, v2)
	return v1.step < v2.step
end

function DispatchInfoDlg:refreshTaskState(...)
	local ui = UIManager.getUI("dispatchDlg", nil, false)

	if ui then
		ui:refreshList()
	end
end

function DispatchInfoDlg:onBtnQuickPatchClick(...)
	self:_onQuickChoose()
end

function DispatchInfoDlg:onBtnBlockClick(...)
	self:showCardList(false)
end

function DispatchInfoDlg:onBtnCancelClick(...)
	local function yesFunc(...)
		self.task.endTime = 0

		self:_refreshUI()
		self:refreshTaskState()
	end

	local content = Lang.get(30670)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, -1)
end

function DispatchInfoDlg:onBtnConfirmClick(...)
	local result, hint = self:checkTaskState()

	if not result then
		MsgManager.notice(hint)

		return
	end

	local data = RearHouseCommon.getDispatchReqData(self.task.data.id, self.choosedHeros)

	RPC.houseDispatchStart(data)
	self:setVisible(false)
end

function DispatchInfoDlg:onBtnLockClick(...)
	if self.task.isLock then
		RPC.houseDispatchLock(self.task.data.id, 0)
	else
		RPC.houseDispatchLock(self.task.data.id, 1)
	end
end

function DispatchInfoDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return DispatchInfoDlg
