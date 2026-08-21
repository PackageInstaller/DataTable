-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroPaintPlusPanel.lua

local ResHero = require("ClientData/ResHero")
local ResPaintRelate = require("ClientData/ResPaintRelate")
local ResHeroPaint = require("ClientData/ResHeroPaint")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResPaintRelateAbility = require("ClientData/ResPaintRelateAbility")
local ResPaintAbility = require("ClientData/ResPaintAbility")
local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local ResColor = require("ClientData/ResColor")
local ResHeroNewPaint = require("ClientData/ResHeroNewPaint")
local ResPaintRelateUnlock = require("ClientData/ResPaintRelateUnlock")
local Hero = require("Common/Object/Hero")
local strClassName = "HeroPaintPlusPanel"
local HeroPaintPlusPanel = Class(strClassName, UIControls.Panel)

function HeroPaintPlusPanel:ctor()
	self:initUI()
end

function HeroPaintPlusPanel:initUI()
	self.upgrade01 = UIControls.Panel(self, self.mPath .. "/Upgrade01")
	self.btnConfirmUnLocked = UIControls.Button(self, self.mPath .. "/Upgrade01/BtnConfirm")

	self.btnConfirmUnLocked:addEventClick(self.onBtnConfirmUnLockedClick)

	self.txtUnlockedTips = UIControls.Label(self, self.mPath .. "/Upgrade01/TextTips")
	self.upgrade02 = UIControls.Panel(self, self.mPath .. "/Upgrade02")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/Upgrade02/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.iconConfirmNew = UIControls.Image(self, self.mPath .. "/Upgrade02/BtnConfirm/IconNew")
	self.maxNode = UIControls.Panel(self, self.mPath .. "/MaxNode")
	self.txtLockTips = UIControls.Panel(self, self.mPath .. "/LockTips/TextTips")
	self.btnInfo = UIControls.Button(self, self.mPath .. "/LockTips/BtnInfo")
	self.relaPropCells = {}
	self.relaHeroCells = {}
	self.mainPropCells = {}

	for i = 1, 6 do
		local path = self.mPath .. "/EnablingPanel/PropertiesNode/Attr0" .. i

		self.relaPropCells[i] = UIControls.Button(self, path)
		self.relaPropCells[i].index = i

		self.relaPropCells[i]:addEventClick(self.onBtnRelaPropCellClick)

		self.relaPropCells[i].txt = UIControls.Label(self, path .. "/Text")
		self.relaPropCells[i].efx = UIControls.LazyEffectPlayer(self, path .. "/Efx")
		self.relaPropCells[i].imgLock = UIControls.Image(self, path .. "/LockImg")
		self.relaPropCells[i].imgBg = UIControls.Image(self, path .. "/BgImage")
		self.relaPropCells[i].imgNum = UIControls.Image(self, path .. "/BgImage/NumImage")
		self.relaPropCells[i].iconNew = UIControls.Image(self, path .. "/IconNew")
		self.relaPropCells[i].efx02 = UIControls.Panel(self, path .. "/Efx02")
		self.relaPropCells[i].unLockTips = UIControls.Image(self, path .. "/UnLockTips")
		self.relaPropCells[i].txtUnlock = UIControls.Label(self, path .. "/UnLockTips/Text")
	end

	self.gridMaterialList = {}
	self.lockTips = UIControls.Panel(self, self.mPath .. "/LockTips")
	self.txtLockTips = UIControls.Label(self, self.mPath .. "/LockTips/TextTips")
	self.btnJumpToHandbook = UIControls.Button(self, self.mPath .. "/LockTips/BtnInfo")

	self.btnJumpToHandbook:addEventClick(self.onBtnJumpToHandbookClick)

	for i = 1, 4 do
		local path = self.mPath .. "/AttrMainPanel/Content/GridCoatingAttr0" .. i

		self.mainPropCells[i] = UIControls.Panel(self, path)
		self.mainPropCells[i].txtNowNum = UIControls.Label(self, path .. "/AttrMain/TextNum1")
		self.mainPropCells[i].txtTargetNum = UIControls.Label(self, path .. "/AttrMain/TextNum2")
		self.mainPropCells[i].txtName = UIControls.Label(self, path .. "/AttrMain/TextName")
		self.mainPropCells[i].icon = UIControls.Image(self, path .. "/AttrMain/Icon")
		self.mainPropCells[i].efx = UIControls.LazyEffectPlayer(self, path .. "/Efx")
	end

	self._slotOnRelaHeroCellClick = Slot(self.onRelaHeroCellConfirm, self)
	self.startLvNode = UIControls.Panel(self, self.mPath .. "/GridHeroNode/StartLvNode")
	self.starCells = {}

	for i = 1, 6 do
		local path = self.mPath .. "/GridHeroNode/StartLvNode/Start0" .. i

		self.starCells[i] = UIControls.Panel(self, path)
		self.starCells[i].light = UIControls.Image(self, path .. "/StartLight")
		self.starCells[i].efx = UIControls.LazyEffectPlayer(self, path .. "/Efx")
	end

	self.efxLvUp = UIControls.LazyEffectPlayer(self, self.mPath .. "/GridHeroNode/StartLvNode/EfxLvUp")
end

local indexToPropNameMap = {
	"e_atk",
	"e_mhp",
	"star_atk_percent",
	"star_mhp_percent"
}

function HeroPaintPlusPanel:setHero(hero)
	self.hero = hero

	if not self.hero then
		return
	end

	local heroID = self.hero.id

	self.resReplateData = ResPaintRelate[heroID]
	self.materialResData = self.hero:getPaintPlusMaterialResData()

	if self.resReplateData then
		local typeId = self.resReplateData.type_id

		self.baseAbility = ResHeroNewPaint[typeId]

		for i = 1, 4 do
			local iconData = ClientUtils.getRolePropIcon(indexToPropNameMap[i])

			if iconData then
				self.mainPropCells[i].icon:setImage(iconData[1], iconData[2])
			end

			local name = ClientUtils.getRolePropZhName(indexToPropNameMap[i])

			if name then
				self.mainPropCells[i].txtName:setText(name)
			end
		end

		self.relateAbility = self.resReplateData.relate_ability

		if self.relateAbility then
			for i = 1, #self.relateAbility do
				local id = self.relateAbility[i]

				if id and ResPaintAbility[id] and self.relaPropCells[i] then
					self.relaPropCells[i].txt:setText(ResPaintAbility[id].simple_desc)
				end
			end
		end

		self.relaHeroData = self.resReplateData.relate_hero

		if self.relaHeroData then
			if #self.relaHeroCells == 0 then
				for i = 1, #self.relaHeroData do
					self.relaHeroCells[i] = GridHeroStarUp(self, self.mPath .. "/GridHeroNode/AssociatedHero", "System/StarUp/GridHeroStarUp")

					self.relaHeroCells[i]:setVisible(true)
				end
			end

			local count = math.min(#self.relaHeroData, #self.relaHeroCells)

			for i = 1, count do
				local heroID = self.relaHeroData[i]
				local fakeFlag = false
				local hero = CurAvatar:getMaxStartLvHeroByHeroId(heroID)

				if not hero then
					fakeFlag = true
					hero = Hero({
						resid = heroID
					})
					hero.notHave = true
				end

				self.relaHeroCells[i]:setHero(hero)

				if fakeFlag then
					self.relaHeroCells[i].notUnlock:setVisible(true)
				else
					self.relaHeroCells[i].notUnlock:setVisible(false)
				end

				self.relaHeroCells[i]:setClickCallback(self._slotOnRelaHeroCellClick)
				self.relaHeroCells[i]:showPaintPlus()

				if not fakeFlag then
					self.relaHeroCells[i]:showPaintPlusSpeLevel0()
				end
			end

			for i = count + 1, #self.relaHeroCells do
				self.relaHeroCells[i]:setVisible(false)
			end
		end

		if not self.gridMianHero then
			self.gridMianHero = GridHeroStarUp(self, self.mPath .. "/GridHeroNode/MainHero", "System/StarUp/GridHeroStarUp")
		end

		self.gridMianHero:setVisible(true)
		self.gridMianHero.panelOtherInfo:setVisible(true)
		self.gridMianHero:setHero(self.hero)
		self.gridMianHero:showPaintPlusSpeLevel0()
		self.gridMianHero:showPaintPlus()
	end

	self:refreshUI()
end

function HeroPaintPlusPanel:checkUpMainLevelLimit(...)
	local nowMainLevel = self.nowMainLevel
	local materialResData = self.materialResData
	local sorceFlag = true
	local levelFlag = true
	local hint = ""

	if nowMainLevel == 0 then
		return true
	else
		local resData = materialResData

		if resData[nowMainLevel + 1] then
			local data = resData[nowMainLevel + 1]

			if data.proficient_score then
				local nowTotalSorce = CurAvatar:getTotalProficient()

				sorceFlag = nowTotalSorce >= data.proficient_score
			end

			if data.proficient_level then
				local nowLevel = CurAvatar:getProficientLevelByTeamIndex(self.hero.team)

				levelFlag = nowLevel >= data.proficient_level
			end

			hint = utils.format(ResClientNotice[740].notice, data.proficient_level, data.proficient_score)
		end
	end

	return sorceFlag and levelFlag, hint
end

function HeroPaintPlusPanel:setRelaCellSelState(i)
	if not i or not self.relaPropCells[i] then
		return
	end

	local color = ResColor.WHITE

	self.relaPropCells[i].txt:setFontColor(color)
	self.relaPropCells[i].imgLock:setVisible(false)
	self.relaPropCells[i].iconNew:setVisible(false)
	self.relaPropCells[i].efx02:setVisible(true)
	self.relaPropCells[i].imgBg:setImage("Atlas/HeroAtlas/HeroCoatingCanvasAtlas2", "BgInstructionsNml1")
	self.relaPropCells[i].imgNum:setImage("Atlas/HeroAtlas/HeroCoatingCanvasAtlas2", "BgNumberNml" .. i)
end

function HeroPaintPlusPanel:setRelaCellHightState(i)
	if not i or not self.relaPropCells[i] then
		return
	end

	local color = ResColor.GREYLIGHT

	self.relaPropCells[i].txt:setFontColor(color)
	self.relaPropCells[i].imgLock:setVisible(true)
	self.relaPropCells[i].iconNew:setVisible(true)
	self.relaPropCells[i].efx02:setVisible(false)
	self.relaPropCells[i].imgBg:setImage("Atlas/HeroAtlas/HeroCoatingCanvasAtlas2", "BgInstructionsDis1")
	self.relaPropCells[i].imgNum:setImage("Atlas/HeroAtlas/HeroCoatingCanvasAtlas2", "BgNumberDis" .. i)
end

function HeroPaintPlusPanel:setRelaCellDisState(i)
	if not i or not self.relaPropCells[i] then
		return
	end

	local color = ResColor.GREYLIGHT

	self.relaPropCells[i].txt:setFontColor(color)
	self.relaPropCells[i].imgLock:setVisible(true)
	self.relaPropCells[i].iconNew:setVisible(false)
	self.relaPropCells[i].efx02:setVisible(false)
	self.relaPropCells[i].imgBg:setImage("Atlas/HeroAtlas/HeroCoatingCanvasAtlas2", "BgInstructionsDis1")
	self.relaPropCells[i].imgNum:setImage("Atlas/HeroAtlas/HeroCoatingCanvasAtlas2", "BgNumberDis" .. i)
end

function HeroPaintPlusPanel:getUnlockTipsTxt(i)
	local txt = ""
	local typeId = ResPaintRelate[self.hero.id].type_id

	if typeId and ResPaintRelateUnlock[typeId] then
		local unLockResData = ResPaintRelateUnlock[typeId]
		local resNowData = unLockResData[i]

		if resNowData then
			local levels = {}

			table.insert(levels, resNowData.paint_level)

			if resNowData.relate_paint_level then
				for i, v in ipairs(resNowData.relate_paint_level) do
					table.insert(levels, v)
				end
			end

			local heroIDs = {}

			table.insert(heroIDs, self.hero.id)

			if self.resReplateData and self.resReplateData.relate_hero then
				local heros = self.resReplateData.relate_hero

				for index = 1, #heros do
					table.insert(heroIDs, heros[i])
				end
			end

			local showLevels = {}
			local count = math.min(#heroIDs, #levels)

			for i = 1, count do
				local data = CurAvatar:getPaintPlusShowLevelByHeroId(heroIDs[i], levels[i])

				table.insert(showLevels, data)
			end

			local sameFlag = true

			for i = 1, #showLevels do
				if showLevels[i] ~= showLevels[1] then
					sameFlag = false

					break
				end
			end

			local txtLevel = ""
			local herosName = ""
			local hint = ""

			if sameFlag then
				hint = ResClientNotice[750].notice
				herosName = self.hero.name
				txtLevel = showLevels[1]
			else
				hint = ResClientNotice[749].notice
				herosName = utils.format("%1s,", self.hero.name)

				if self.resReplateData and self.resReplateData.relate_hero then
					local heros = self.resReplateData.relate_hero

					for index = 1, #heros do
						local heroID = heros[index]

						if heroID and ResHero[heroID] then
							herosName = utils.format("%1s%2s", herosName, ResHero[heroID].hero_name)
						end

						if index ~= #heros then
							herosName = utils.format("%1s,", herosName)
						end
					end
				end

				for i = 1, showLevels do
					txtLevel = utils.format("%1s%2s", txtLevel, showLevels[1])

					if i ~= #showLevels then
						txtLevel = utils.format("%1s,", txtLevel)
					end
				end
			end

			txt = utils.format(hint, herosName, txtLevel)
		end
	end

	return txt
end

function HeroPaintPlusPanel:setRelaCellUnLockTips(i)
	if not i then
		return
	end

	for index = 1, 6 do
		if index == i then
			self.relaPropCells[index].unLockTips:setVisible(true)

			local txt = self:getUnlockTipsTxt(i)

			self.relaPropCells[index].txtUnlock:setText(txt)
		else
			self.relaPropCells[index].unLockTips:setVisible(false)
		end
	end
end

function HeroPaintPlusPanel:refreshUI()
	self.nowRelateLevel = self.hero:getPaintPlusRelateLevel()
	self.nowCanUpRelateLevel = self.hero:canUpPaintPlusRelateLevel()

	local canlevel = self.nowRelateLevel

	if self.nowCanUpRelateLevel then
		canlevel = canlevel + 1
	end

	for i = 1, 6 do
		if i <= self.nowRelateLevel then
			self:setRelaCellSelState(i)
		elseif i <= canlevel then
			self:setRelaCellHightState(i)
		else
			self:setRelaCellDisState(i)
		end
	end

	self:setRelaCellUnLockTips(self.nowRelateLevel + 1)

	if self.baseAbility then
		self.nowMainLevel = self.hero:getPaintPlusMainLevel()

		if self.nowMainLevel == 0 then
			for i = 1, 4 do
				self.mainPropCells[i].txtNowNum:setText(0)
			end

			self.startLvNode:setVisible(false)
		else
			self.nowMainData = self.baseAbility[self.nowMainLevel]

			if self.nowMainData then
				for i = 1, 4 do
					local name = indexToPropNameMap[i]
					local num = self.nowMainData[name] or 0

					if string.find(name, "percent") then
						num = num / 100
						num = utils.format("%1s%%", num)
					end

					self.mainPropCells[i].txtNowNum:setText(num)
				end
			end

			if self.nowMainLevel == #self.baseAbility then
				self.startLvNode:setVisible(false)
			else
				self.startLvNode:setVisible(true)
				self:setStartCellState()
			end
		end

		if not self.baseAbility[self.nowMainLevel + 1] then
			for i = 1, 4 do
				self.mainPropCells[i].txtTargetNum:setVisible(false)
			end
		else
			local nextData = self.baseAbility[self.nowMainLevel + 1]

			if self.nowMainLevel == 0 then
				for i = 1, 4 do
					local name = indexToPropNameMap[i]

					if nextData[name] and nextData[name] ~= 0 then
						self.mainPropCells[i].txtTargetNum:setVisible(true)
						self.mainPropCells[i].txtTargetNum:setText(nextData[name])
					else
						self.mainPropCells[i].txtTargetNum:setVisible(false)
					end
				end
			else
				for i = 1, 4 do
					local name = indexToPropNameMap[i]

					if self.nowMainData[name] ~= nextData[name] then
						self.mainPropCells[i].txtTargetNum:setVisible(true)

						local num = nextData[name] or 0

						if string.find(name, "percent") then
							num = num / 100
							num = utils.format("%1s%%", num)
						end

						self.mainPropCells[i].txtTargetNum:setText(num)
					else
						self.mainPropCells[i].txtTargetNum:setVisible(false)
					end
				end
			end
		end
	end

	local checkUpMainLevelLimit, hint = self:checkUpMainLevelLimit()

	if checkUpMainLevelLimit then
		self:refreshMaterialShow()
		self.lockTips:setVisible(false)
	else
		self.lockTips:setVisible(true)
		self.txtLockTips:setText(hint)
		self.upgrade01:setVisible(false)
		self.upgrade02:setVisible(false)
		self.maxNode:setVisible(false)
	end
end

function HeroPaintPlusPanel:setStartCellState(...)
	self.nowMainLevel = self.hero:getPaintPlusMainLevel()

	if self.nowMainLevel == #self.baseAbility then
		self.startLvNode:setVisible(false)

		return
	end

	local showLevel = self.hero:getPaintPlusShowLevel()
	local count = 0
	local startLevel = 0

	for _, data in ipairs(self.materialResData) do
		if data.paint_show_level and data.paint_show_level == showLevel then
			startLevel = _

			break
		end
	end

	for _, data in ipairs(self.materialResData) do
		if data.paint_show_level and data.paint_show_level == showLevel then
			count = count + 1
		end
	end

	local lvIndex = self.nowMainLevel - startLevel + 1

	if showLevel == 1 then
		count = count + 1
		lvIndex = lvIndex + 1
	end

	for i = 1, 6 do
		self.starCells[i]:setVisible(i <= count)
		self.starCells[i].light:setVisible(i < lvIndex)
	end
end

function HeroPaintPlusPanel:refreshMaterialShow(...)
	self.nowMainLevel = self.hero:getPaintPlusMainLevel()

	if self.nowMainLevel == 0 then
		self:setUnlockedShow()
	elseif self.nowMainLevel == #self.baseAbility then
		self:setMaxMaterialShow(true)
	else
		self:setMaxMaterialShow(false)
		self:refreshMaterialInfo()
	end
end

function HeroPaintPlusPanel:refreshPaintMainState(...)
	if self.baseAbility then
		self.nowMainLevel = self.hero:getPaintPlusMainLevel()
		self.nowMainData = self.baseAbility[self.nowMainLevel]

		if self.nowMainData then
			for i = 1, 4 do
				local name = indexToPropNameMap[i]
				local num = self.nowMainData[name] or 0

				if string.find(name, "percent") then
					num = num / 100
					num = utils.format("%1s%%", num)
				end

				self.mainPropCells[i].txtNowNum:setText(num)
			end
		end
	end

	if not self.baseAbility[self.nowMainLevel + 1] then
		for i = 1, 4 do
			self.mainPropCells[i].txtTargetNum:setVisible(false)
		end
	else
		local nextData = self.baseAbility[self.nowMainLevel + 1]

		if self.nowMainLevel == 0 then
			for i = 1, 4 do
				local name = indexToPropNameMap[i]

				if nextData[name] and nextData[name] ~= 0 then
					self.mainPropCells[i].txtTargetNum:setVisible(true)

					local num = nextData[name] or 0

					if string.find(name, "percent") then
						num = num / 100
						num = utils.format("%1s%%", num)
					end

					self.mainPropCells[i].txtTargetNum:setText(num)
				else
					self.mainPropCells[i].txtTargetNum:setVisible(false)
				end
			end
		else
			for i = 1, 4 do
				local name = indexToPropNameMap[i]

				if self.nowMainData[name] ~= nextData[name] then
					self.mainPropCells[i].txtTargetNum:setVisible(true)

					local num = nextData[name] or 0

					if string.find(name, "percent") then
						num = num / 100
						num = utils.format("%1s%%", num)
					end

					self.mainPropCells[i].txtTargetNum:setText(num)
				else
					self.mainPropCells[i].txtTargetNum:setVisible(false)
				end
			end
		end
	end

	local checkUpMainLevelLimit, hint = self:checkUpMainLevelLimit()

	if checkUpMainLevelLimit then
		self:refreshMaterialShow()
	else
		self.lockTips:setVisible(true)
		self.txtLockTips:setText(hint)
		self.upgrade01:setVisible(false)
		self.upgrade02:setVisible(false)
		self.maxNode:setVisible(false)
	end

	self.gridMianHero:setHero(self.hero)
	self:refreshPaintRelateState()

	self.lockClick = false
end

function HeroPaintPlusPanel:onUpPaintMainLevel()
	self.nowMainLevel = self.hero:getPaintPlusMainLevel()
	self.nowMainData = self.baseAbility[self.nowMainLevel]

	if self.nowMainLevel == 1 then
		for i = 1, 4 do
			local name = indexToPropNameMap[i]

			if self.nowMainData[name] and self.nowMainData[name] ~= 0 then
				self.mainPropCells[i].efx:playEffect()
			end
		end
	else
		local preData = self.baseAbility[self.nowMainLevel - 1]

		if preData then
			for i = 1, 4 do
				local name = indexToPropNameMap[i]

				if self.nowMainData[name] ~= preData[name] then
					self.mainPropCells[i].efx:playEffect()
				end
			end
		end
	end

	if self.nowMainLevel ~= 0 and self.nowMainLevel ~= #self.baseAbility then
		self.startLvNode:setVisible(true)
	end

	local showLevel = self.hero:getPaintPlusShowLevel()
	local lvIndex = 0
	local startLevel = 0

	for _, data in ipairs(self.materialResData) do
		if data.paint_show_level and data.paint_show_level == showLevel then
			startLevel = _

			break
		end
	end

	local lvIndex = self.nowMainLevel - startLevel + 1

	if showLevel == 1 then
		lvIndex = lvIndex + 1
	end

	local showLvUpFlag = false

	if lvIndex == 1 then
		showLvUpFlag = true
		showLevel = showLevel - 1

		local count = 0

		for _, data in ipairs(self.materialResData) do
			if data.paint_show_level and data.paint_show_level == showLevel then
				count = count + 1
			end
		end

		lvIndex = count + 1

		if showLevel == 1 then
			lvIndex = lvIndex + 1
		end
	end

	for i = 1, 6 do
		if i == lvIndex - 1 then
			self.starCells[i].efx:playEffect()
		end
	end

	if showLvUpFlag then
		self.efxLvUp:playEffect()
	end

	self:setStartCellState()

	if self.timerMain then
		self.timerMain:Stop()
	end

	self.timerMain = Timer.New(Slot(self.refreshPaintMainState, self), 0.5, 1)

	self.timerMain:Start()
end

function HeroPaintPlusPanel:refreshPaintRelateState(...)
	self.nowRelateLevel = self.hero:getPaintPlusRelateLevel()

	local canUpPaintRelateLevel = self.hero:canUpPaintPlusRelateLevel()

	if self.nowRelateLevel then
		for i = 1, 6 do
			if i <= self.nowRelateLevel then
				self:setRelaCellSelState(i)
			elseif canUpPaintRelateLevel and i == self.nowRelateLevel + 1 then
				self:setRelaCellHightState(i)
			else
				self:setRelaCellDisState(i)
			end
		end
	end

	self:setRelaCellUnLockTips(self.nowRelateLevel + 1)

	self.lockClick = false
end

function HeroPaintPlusPanel:onUpPaintRelateLevel(data)
	self.nowRelateLevel = self.hero:getPaintPlusRelateLevel()

	if self.nowRelateLevel and self.relaPropCells[self.nowRelateLevel] then
		self.relaPropCells[self.nowRelateLevel].efx:playEffect()
	end

	if self.timerRelate then
		self.timerRelate:Stop()
	end

	self.timerRelate = Timer.New(Slot(self.refreshPaintRelateState, self), 0.5, 1)

	self.timerRelate:Start()
end

function HeroPaintPlusPanel:setUnlockedShow(...)
	self.maxNode:setVisible(false)
	self.upgrade01:setVisible(true)
	self.upgrade02:setVisible(false)

	local canUnLock = self.hero:checkCanUnlockedMainLevel()

	self.btnConfirmUnLocked:setVisible(canUnLock)

	local resData = ResClientNotice[744]

	if resData then
		local hint = resData.notice
		local heroNames = ""

		if self.resReplateData and self.resReplateData.relate_hero then
			local heros = self.resReplateData.relate_hero

			for i = 1, #heros do
				if i ~= 1 then
					heroNames = heroNames .. ","
				end

				local heroID = heros[i]

				if heroID and ResHero[heroID] then
					heroNames = heroNames .. ResHero[heroID].hero_name
				end
			end
		end

		hint = string.gsub(hint, "%%s", heroNames)

		self.txtUnlockedTips:setText(hint)
	end
end

function HeroPaintPlusPanel:setMaxMaterialShow(state)
	self.upgrade01:setVisible(not state)
	self.upgrade02:setVisible(not state)
	self.maxNode:setVisible(state)
end

function HeroPaintPlusPanel:refreshMaterialInfo(...)
	self.upgrade01:setVisible(false)
	self.upgrade02:setVisible(true)

	self.lackInfo = {}

	local paintData = {}

	paintData.resData = self.materialResData[self.nowMainLevel + 1]

	local materialList = CurAvatar:getPaintNeedMaterialList(self.hero.id, paintData)

	for i, materialInfo in pairs(materialList) do
		if not self.gridMaterialList[i] then
			self.gridMaterialList[i] = MaterialItemGridChild(self, self.mPath .. "/Upgrade02/ItemNode", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		local enough = self.gridMaterialList[i]:setMaterial(materialInfo.id, materialInfo.num)

		self.gridMaterialList[i].needNum = materialInfo.num
		self.gridMaterialList[i].uiConfig = {
			AutoOpenGuide = 1
		}

		local hasNum = CurAvatar:getItemNumById(materialInfo.id)

		if hasNum < materialInfo.num then
			self.gridMaterialList[i].lackNum = materialInfo.num - hasNum
		else
			self.gridMaterialList[i].lackNum = nil
		end

		self.gridMaterialList[i].selectHero = self.hero.id

		if self.gridMaterialList[i].lackNum and self.gridMaterialList[i].lackNum > 0 and CurAvatar:canConvertPaintItem(materialInfo.id, self.hero.id) then
			self.gridMaterialList[i]:setAddPanel(1)
			self.gridMaterialList[i].imgAdd2:setVisible(true)
			self.gridMaterialList[i].addPanel.textAdd:setText(Lang.get(56188))
		else
			self.gridMaterialList[i].imgAdd2:setVisible(false)
		end

		if not enough then
			table.insert(self.lackInfo, Lang.get(30293))
		end
	end

	for i = #materialList + 1, #self.gridMaterialList do
		self.gridMaterialList[i]:destroy()

		self.gridMaterialList[i] = nil
	end

	self.iconConfirmNew:setVisible(#self.lackInfo == 0)
end

function HeroPaintPlusPanel:onBtnConfirmClick(...)
	if self.lockClick then
		return
	end

	if not CurAvatar.heroPaintNoConfirm then
		CurAvatar.heroPaintNoConfirm = {}
	end

	if #self.lackInfo == 0 then
		local nowMainLevel = self.hero:getPaintPlusMainLevel()

		if not CurAvatar.heroPaintNoConfirm[self.hero.id] then
			local function yesFunc()
				CurAvatar.heroPaintNoConfirm[self.hero.id] = self.confirmui.attentionSwitch:isOn()

				RPC.heroNewPaint(self.hero.id, nowMainLevel + 1)

				self.lockClick = true
			end

			local function noFunc()
				CurAvatar.heroPaintNoConfirm[self.hero.id] = self.confirmui.attentionSwitch:isOn()
			end

			local msgContent = ClientUtils.getClientNotice(341)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1126), msgContent, yesFunc, noFunc, -1)

			self.confirmui = UIManager.getUI("confirmui", nil, false)

			self.confirmui:showToggle(Lang.get(30272), CurAvatar.heroPaintNoConfirm[self.hero.id] or true)

			return
		else
			RPC.heroNewPaint(self.hero.id, nowMainLevel + 1)

			self.lockClick = true
		end
	else
		MsgManager.notice(utils.format(Lang.get(89946), self.lackInfo[1]))
	end
end

function HeroPaintPlusPanel:onBtnConfirmUnLockedClick(...)
	if self.lockClick then
		return
	end

	self.lockClick = true

	RPC.heroNewPaint(self.hero.id, 1)
end

function HeroPaintPlusPanel:onBtnJumpToHandbookClick(...)
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_TEAM)

	if isLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HANDBOOK_TEAM))

		return
	end

	UIManager.getUI("handBookTeamOverviewDlg", true)
	self.mWindow:setVisible(false)
end

function HeroPaintPlusPanel:onBtnRelaPropCellClick(sender)
	local canUp = self.hero:canUpPaintPlusRelateLevel()

	if self.nowRelateLevel and self.nowRelateLevel + 1 == sender.index and canUp then
		RPC.heroPaintRelateUnlock(self.hero.id, sender.index)
	end
end

function HeroPaintPlusPanel:onRelaHeroCellClick(sender)
	if sender and sender.hero then
		local have = true

		if sender.hero.notHave then
			have = false
		end

		if have then
			local canJump = CurAvatar:canShowPaintEntry(sender.hero)

			if canJump then
				local ui = UIManager.tryGetUI("heroPaintingDlg")

				if ui and ui:getVisible() then
					ui:setHero(sender.hero)
				end
			else
				local resData = ResClientNotice[747]

				if resData then
					local notice = resData.notice

					MsgManager.notice(notice)
				end
			end
		else
			local resData = ResClientNotice[746]

			if resData then
				local notice = resData.notice

				MsgManager.notice(notice)
			end
		end
	end
end

function HeroPaintPlusPanel:onRelaHeroCellConfirm(sender)
	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", string.format(ResClientNotice[748].notice), Functor(self.onRelaHeroCellClick, self, sender))
end

function HeroPaintPlusPanel:destroy()
	if self.timerMain then
		self.timerMain:Stop()

		self.timerMain = nil
	end

	if self.timerRelate then
		self.timerRelate:Stop()

		self.timerRelate = nil
	end

	HeroPaintPlusPanel.super.destroy(self)
end

return HeroPaintPlusPanel
