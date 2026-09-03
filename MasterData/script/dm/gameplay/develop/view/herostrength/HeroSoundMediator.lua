-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroSoundMediator.lua

HeroSoundMediator = class("HeroSoundMediator", DmAreaViewMediator, _M)

HeroSoundMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroSoundMediator:has("_customDataSystem", {
	is = "rw"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	["main.right.button"] = "onClickRight",
	["main.left.button"] = "onClickLeft"
}
local kHeroRarityAnim = {
	[15] = {
		45
	},
	[14] = {
		45
	},
	[13] = {
		20
	},
	[12] = {
		10
	},
	[11] = {
		13
	}
}

function HeroSoundMediator:initialize()
	super.initialize(self)
end

function HeroSoundMediator:dispose()
	super.dispose(self)
end

function HeroSoundMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)

	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroSoundMediator:enterWithData(data)
	self._heroId = data.id
	self._idList = self._heroSystem:getOwnHeroIds()

	for i = 1, #self._idList do
		if self._idList[i].id == data.id then
			self._curIdIndex = i

			break
		end
	end

	self._canChange = true

	self:refreshData()
	self:refreshCustomData()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:initView()
	self:refreshHeroInfo()
end

function HeroSoundMediator:refreshData()
	self._heroSystem:setUiSelectHeroId(self._heroId)

	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._soundList = self._heroSystem:getHeroSoundListById(self._heroId)
	self._soundPlayingPath = ""
	self._soundId = nil
	self._preCell = nil
end

function HeroSoundMediator:refreshCustomData()
	self._customValue = {}

	local customKey = CustomDataKey.kHeroSound .. self._heroId
	local customData = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if customData then
		self._customValue = string.split(customData, "&")
	end

	self._hasNewSound = #self._customValue < #self._soundList

	if self._hasNewSound then
		local oldLength = #self._customValue
		local customValue = ""
		local length = 0

		for i = 1, #self._soundList do
			if self._soundList[i].unlock then
				customValue = i == 1 and self._soundList[i].path or customValue .. "&" .. self._soundList[i].path
				length = length + 1
			end
		end

		if oldLength ~= length and customValue ~= "" then
			self._customDataSystem:setValue(PrefixType.kGlobal, customKey, customValue)
		end
	end
end

function HeroSoundMediator:initWidgetInfo()
	self._main = self:getView():getChildByName("main")
	self._heroNode = self._main:getChildByName("heroNode")
	self._listPanel = self._main:getChildByName("listPanel")
	self._toastPanel = self._main:getChildByName("toastPanel")

	self._toastPanel:setVisible(false)

	self._primeTextPosX = self._toastPanel:getChildByFullName("clipNode.text"):getPositionX()
	self._primeTextPosY = self._toastPanel:getChildByFullName("clipNode.text"):getPositionY()

	self._toastPanel:getChildByFullName("clipNode.text"):getVirtualRenderer():setDimensions(330, 0)

	self._name = self._main:getChildByName("name")
	self._cvname = self._main:getChildByName("cvname")

	self._cvname:setLineSpacing(-6)
	GameStyle:setCommonOutlineEffect(self._cvname)

	self._nameBg = self._main:getChildByName("nameBg")
	self._name1 = self._main:getChildByName("name1")
	self._rarityIcon = self._main:getChildByName("rarityIcon")
	self._cell = self:getView():getChildByName("cell")

	self._cell:setVisible(false)
	GameStyle:setCommonOutlineEffect(self._cell:getChildByName("name"), 154, 1)

	local lineGradiantVec2 = {
		{
			ratio = 0,
			color = cc.c4b(176, 255, 0, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(252, 255, 23, 255)
		}
	}

	self._cell:getChildByFullName("newMark"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	self._cell:getChildByFullName("newMark"):enableOutline(cc.c4b(57, 75, 10, 229.5), 2)

	local leftBtn = self._main:getChildByFullName("left.leftBtn")
	local rightBtn = self._main:getChildByFullName("right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)

	self._heroPanelAnim = cc.MovieClip:create("renwu_yinghun")

	self._heroPanelAnim:addTo(self._heroNode)
	self._heroPanelAnim:addCallbackAtFrame(30, function()
		self._heroPanelAnim:stop()
	end)
	self._heroPanelAnim:gotoAndStop(30)
	self._heroPanelAnim:setPosition(cc.p(0, 0))
	self._heroPanelAnim:setPlaySpeed(1.5)

	self._heroAnimPanel = self._heroPanelAnim:getChildByName("heroPanel")
end

function HeroSoundMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("HEROS_UI56")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroSoundMediator:initView()
	local cellWidth, cellHeight = self._cell:getContentSize().width, self._cell:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return cellWidth, cellHeight
	end

	local function numberOfCellsInTableView(table)
		return #self._soundList
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCellByTag(idx + 1)

		if cell == nil then
			cell = cc.TableViewCell:new()

			local node = self._cell:clone()

			node:setVisible(true)
			node:addTo(cell)
			node:setPosition(cc.p(0, 0))
			node:setName("Cell")
		end

		self:createCell(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._listPanel:getContentSize())

	self._soundView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._listPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function HeroSoundMediator:createCell(cell, index)
	local node = cell:getChildByFullName("Cell")

	node:setVisible(false)

	local data = self._soundList[index]

	if data then
		node:setVisible(true)

		local name = node:getChildByFullName("name")

		name:setString(data.text)

		if self._hasNewSound then
			local new = not table.indexof(self._customValue, data.path)
			local newMark = node:getChildByFullName("newMark")

			newMark:setVisible(self._hasNewSound and data.unlock)

			local soundBg1 = node:getChildByFullName("soundBg1")
			local soundBg2 = node:getChildByFullName("soundBg2")
			local unlockPanel = node:getChildByFullName("unlockPanel")

			unlockPanel:setVisible(false)

			local lockPanel = node:getChildByFullName("lockPanel")

			lockPanel:setVisible(false)

			local playing = unlockPanel:getChildByFullName("normal")
			local animBg = unlockPanel:getChildByFullName("animBg")

			if not playing:getChildByFullName("PlayAnim") then
				local anim = cc.MovieClip:create("yuyin_yinghunyuyinbofang")

				anim:addTo(playing):center(playing:getContentSize())
				anim:setName("PlayAnim")
			end

			local playingSound = self._soundPlayingPath == data.path

			if playingSound then
				self._playingNode = node
			end

			playing:getChildByFullName("PlayAnim"):setVisible(playingSound)

			local image = playingSound and "yinghun_yuyin_voice1.png" or "yinghun_yuyin_voice2.png"

			animBg:loadTexture(image, 1)

			if data.unlock then
				soundBg1:setVisible(true)
				soundBg2:setVisible(false)
				unlockPanel:setSwallowTouches(false)
				unlockPanel:setVisible(true)
				unlockPanel:addClickEventListener(function()
					self:onClickSound(data, node)
				end)
			else
				soundBg2:setVisible(true)
				soundBg1:setVisible(false)
				lockPanel:setVisible(true)
			end
		end
	end
end

function HeroSoundMediator:getFontSizeForName(str)
	local fontSize = 50

	repeat
		local lvLabel = cc.Label:createWithTTF(str, CUSTOM_TTF_FONT_1, fontSize)

		fontSize = fontSize - 2
	until lvLabel:getContentSize().width <= 200 or fontSize < 2

	return fontSize
end

function HeroSoundMediator:refreshHeroInfo()
	self:refreshBg()
	self._heroPanelAnim:gotoAndPlay(0)
	self._heroAnimPanel:removeAllChildren()

	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = self._heroData:getModel()
	})

	self._heroAnimPanel:addChild(img)

	local name = self._heroData:getName()

	self._name:setString(name)

	local cvname = Strings:get("GALLERY_UI10", {
		cvname = self._heroData:getCVName()
	})

	self._cvname:setString(cvname)

	local length = utf8.len(cvname)

	if length > 10 then
		self._cvname:setFontSize(18)
	else
		self._cvname:setFontSize(24)
	end

	self._name1:setString(name)
	self._name1:setFontSize(self:getFontSizeForName(name))
	GameStyle:setHeroNameByQuality(self._name1, self._heroData:getQuality())
	self._nameBg:setScaleX((self._name1:getContentSize().width + 35) / self._nameBg:getContentSize().width)
	self._rarityIcon:removeAllChildren()

	local rarity = IconFactory:getHeroRarityAnim(self._heroData:getRarity())

	rarity:addTo(self._rarityIcon):offset(kHeroRarityAnim[self._heroData:getRarity()][1], 30)
end

function HeroSoundMediator:onClickSound(data, node)
	if AudioEngine:getInstance():getRoleEffectOff() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Hero_Voice_OpenTips")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._soundPlayingPath ~= "" and self._soundPlayingPath == data.path then
		return
	end

	if self._hasNewSound and not table.indexof(self._customValue, data.path) then
		self._customValue[#self._customValue + 1] = data.path
		self._hasNewSound = #self._customValue < #self._soundList
	end

	self._soundPlayingPath = data.path

	self:stopEffect()

	if not self._preCell then
		self._preCell = node
	else
		self:resetPlayAnim(self._preCell, false)

		self._preCell = node
	end

	self._soundId = AudioEngine:getInstance():playRoleEffect(data.path, false, function()
		self._preCell = nil
		self._soundId = nil
		self._soundPlayingPath = ""

		self._soundView:stopScroll()
		self._toastPanel:setVisible(false)
		self:resetPlayAnim(node, false)

		if self._playingNode then
			self:resetPlayAnim(self._playingNode, false)

			self._playingNode = nil
		end
	end)

	self._soundView:stopScroll()

	if self._hasNewSound then
		local new = not table.indexof(self._customValue, data.path)
		local newMark = node:getChildByFullName("newMark")

		newMark:setVisible(self._hasNewSound and data.unlock)
		self:resetPlayAnim(node, self._soundPlayingPath == data.path)
		self:showToast(data)
	end
end

function HeroSoundMediator:resetPlayAnim(node, show)
	local unlockPanel = node:getChildByFullName("unlockPanel")
	local animBg = unlockPanel:getChildByFullName("animBg")
	local playing = unlockPanel:getChildByFullName("normal")

	if not playing:getChildByFullName("PlayAnim") then
		local anim = cc.MovieClip:create("yuyin_yinghunyuyinbofang")

		anim:addTo(playing):center(playing:getContentSize())
		anim:setName("PlayAnim")
	end

	playing:getChildByFullName("PlayAnim"):setVisible(show)

	local image = show and "yinghun_yuyin_voice1.png" or "yinghun_yuyin_voice2.png"

	animBg:loadTexture(image, 1)
end

function HeroSoundMediator:showToast(data)
	local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
	local isHide = table.indexof(HideVoice, self._heroId)

	if isHide then
		return
	end

	self._toastPanel:setVisible(true)

	local text = self._toastPanel:getChildByFullName("clipNode.text")

	text:setString(data.soundDesc)
	text:stopAllActions()
	text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))
	self:setTextAnim()
end

function HeroSoundMediator:setTextAnim()
	local clipNode = self._toastPanel:getChildByFullName("clipNode")
	local text = self._toastPanel:getChildByFullName("clipNode.text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function HeroSoundMediator:refreshBg()
	local heroData = self._heroSystem:getHeroInfoById(self._heroId)
	local bgPanel = self._main:getChildByFullName("animPanel")

	bgPanel:removeAllChildren()

	local bgAnim = GameStyle:getHeroPartyBg(heroData.party)

	bgAnim:addTo(bgPanel)
end

function HeroSoundMediator:onClickLeft()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)
	self:stopEffect()

	self._curIdIndex = self._curIdIndex - 1

	if self._curIdIndex < 1 then
		self._curIdIndex = #self._idList
	end

	self._heroId = self._idList[self._curIdIndex].id

	self:refreshData()
	self:refreshCustomData()
	self:refreshHeroInfo()
	self._soundView:stopScroll()
	self._soundView:reloadData()
	self._toastPanel:setVisible(false)
end

function HeroSoundMediator:onClickRight()
	if not self._canChange then
		return
	end

	self._canChange = false

	performWithDelay(self:getView(), function()
		self._canChange = true
	end, 0.3)
	self:stopEffect()

	self._curIdIndex = self._curIdIndex + 1

	if self._curIdIndex > #self._idList then
		self._curIdIndex = 1
	end

	self._heroId = self._idList[self._curIdIndex].id

	self:refreshData()
	self:refreshCustomData()
	self:refreshHeroInfo()
	self._soundView:stopScroll()
	self._soundView:reloadData()
	self._toastPanel:setVisible(false)
end

function HeroSoundMediator:onClickBack()
	self:stopEffect()
	self:dismiss()
end

function HeroSoundMediator:stopEffect()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)
	end
end
