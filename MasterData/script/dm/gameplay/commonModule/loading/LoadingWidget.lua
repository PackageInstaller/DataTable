-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/commonModule/loading/LoadingWidget.lua

local lodinInfo = ConfigReader:getDataTable("Loading")
local firstLoading = {
	KSecondUp = 0,
	KFirst = 1
}

LoadingWidget = class("LoadingWidget", BaseWidget, _M)
LoadingWidgetMap = {
	HERO = HeroLoadingWidget,
	GUIDENEWBEE = GuideLoadingWidget,
	GAMENEWBEE = GameLoadingWidget
}

function LoadingWidget:initialize(view)
	super.initialize(self, view)
end

function LoadingWidget:dispose()
	super.dispose(self)
end

function LoadingWidget:setupView(view)
	local resFile = "asset/ui/LoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")
	AdjustUtils.adjustLayoutUIByRootNode(node)
end

function LoadingWidget:onProgress(task, progress)
	local loadingNode = self:getView():getChildByFullName("bottom.node_pro")
	local loadingBar = loadingNode:getChildByName("loading")

	loadingBar:setPercent(progress * 100)

	local progressNum = loadingNode:getChildByName("textProgress")

	progressNum:setString(string.format("%d", progress * 100))
end

function LoadingWidget:onError(task, err, level)
	if DEBUG and DEBUG > 0 then
		assert(false, "Loading Error:" .. err)
	elseif level > timesharding.kWarning then
		task:abort()
	else
		task:recoveryFromError()
	end
end

function LoadingWidget:onCompleted(task)
	return
end

function LoadingWidget:onAbort(task)
	return
end

HeroLoadingWidget = class("HeroLoadingWidget", LoadingWidget, _M)

function HeroLoadingWidget:initialize(config)
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)

	self._config = config
end

function HeroLoadingWidget:dispose()
	if self._timeScheduler then
		self._timeScheduler:stop()

		self._timeScheduler = nil
	end

	super.dispose(self)
end

function HeroLoadingWidget:setupView()
	local view = self:getView()

	super.setupView(self, view)

	if self._config then
		local kBgImage = {
			[HeroType.kTank] = {
				"bg_ld_hu_01.png",
				"bg_ld_hu_02.png"
			},
			[HeroType.kDPS] = {
				"bg_ld_ho_01.png",
				"bg_ld_ho_02.png"
			},
			[HeroType.kGank] = {
				"bg_ld_la_01.png",
				"bg_ld_la_02.png"
			}
		}
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local heroSystem = developSystem:getHeroSystem()
		local heroId = self._config.HeroId
		local heroData = heroSystem:getHeroShowData(heroId)

		if heroData then
			local heroType = heroData.heroType
			local bottomPanel = view:getChildByFullName("bottom")

			if bottomPanel then
				local imgRes = kBgImage[heroType][1]
				local bottomBgImg = bottomPanel:getChildByName("Image_bg")

				bottomBgImg:loadTexture("asset/ui/loading/" .. imgRes)

				self._tipsLabel = bottomPanel:getChildByFullName("node_pro.changeTips")
				self._tipsList = self._config.Content

				if self._tipsList and #self._tipsList > 0 then
					local index = math.random(1, #self._tipsList)
					local tipsStr = Strings:get(self._tipsList[index])

					self._tipsLabel:setString(tipsStr)
				end
			end

			local bgName = kBgImage[heroType][2]
			local bg = cc.Sprite:create("asset/ui/loading/" .. bgName)

			bg:addTo(view, -1):center(view:getContentSize())

			local resFile = "asset/ui/heroLoading.csb"
			local node = cc.CSLoader:createNode(resFile)

			node:addTo(view, 9):setName("main"):center(view:getContentSize())
			self:decorateWidgetView(heroData)

			self._gameServerAgent = self:getInjector():getInstance("GameServerAgent")
			self._enterTime = self._gameServerAgent:remoteTimestamp()
			self._delayTime = self._config.Interval

			self:createTimeScheduler()
		end
	end
end

function HeroLoadingWidget:decorateWidgetView(heroData)
	local mainView = self:getView():getChildByName("main")
	local skillPanel = mainView:getChildByName("Panel_skill")

	skillPanel:setVisible(false)

	local skillNameColor = {
		[HeroType.kTank] = cc.c3b(159, 64, 12),
		[HeroType.kDPS] = cc.c3b(129, 15, 15),
		[HeroType.kGank] = cc.c3b(12, 49, 143)
	}
	local heroType = heroData.heroType
	local color = skillNameColor[heroType]
	local heroSkillList = heroData.skills

	for i = 1, 4 do
		local skill = heroSkillList[i]

		if skill then
			local panelClone = skillPanel:clone()
			local resFile = ConfigReader:getDataByNameIdAndKey("Skill", skill.id, "Icon")

			resFile = "asset/battleSkill/" .. resFile

			if not cc.FileUtils:getInstance():isFileExist(resFile) then
				resFile = "asset/battleSkill/SK_H001_1.png"
			end

			local skillImg = cc.Sprite:create(resFile)

			skillImg:setScale(0.9)
			skillImg:addTo(panelClone):posite(64, 87)

			local nameLabel = panelClone:getChildByName("Text_name")
			local config = ConfigReader:getRecordById("Skill", skill.id)

			nameLabel:setString(Strings:get(config.Name))
			nameLabel:enableShadow(color, cc.size(0, -2), 6)

			local node = mainView:getChildByName("Node_skill" .. i)

			panelClone:addTo(node):center(node:getContentSize())
			panelClone:setVisible(true)
		end
	end

	local heroPanel = mainView:getChildByName("Panel_hero")
	local roleNode = heroPanel:getChildByName("rolenode")
	local rolePic = RoleFactory:createRolePortraitAnim(heroData.modelId)

	if rolePic then
		roleNode:addChild(rolePic)
		rolePic:setScale(1.2)
		rolePic:setPosition(-50, -150)
	end

	local heroConfig = ConfigReader:getRecordById("HeroBase", heroData.id)
	local nameRes = heroConfig.NamePic
	local nameNode = heroPanel:getChildByName("namenode")
	local typeImg = heroPanel:getChildByName("typeimg")
	local nameImg = cc.Sprite:create("asset/heroName/" .. nameRes)

	if nameImg then
		nameImg:setAnchorPoint(cc.p(1, 0.5))
		nameImg:setScale(0.75)
		nameImg:addTo(nameNode)
	end

	local picName = GameStyle:getTeamHeroTypePath(heroData.heroType)

	if picName then
		typeImg:loadTexture(picName, ccui.TextureResType.plistType)
	end

	local rareNode = heroPanel:getChildByName("rarenode")
	local icon = IconFactory:createRareBigIcon({
		rare = heroData.rareity
	})

	icon:addTo(rareNode):center(rareNode:getContentSize())

	if nameImg then
		rareNode:offset(-nameImg:getContentSize().width * 0.75 - 90, 0)
	end
end

function HeroLoadingWidget:createTimeScheduler()
	local function update()
		local time = self._gameServerAgent:remoteTimestamp() - self._enterTime

		if self._delayTime and time > self._delayTime and self._tipsList and #self._tipsList > 0 and self._tipsLabel then
			local index = math.random(1, #self._tipsList)
			local tipsStr = Strings:get(self._tipsList[index])

			self._tipsLabel:setString(tipsStr)

			self._enterTime = self._gameServerAgent:remoteTimestamp()
		end
	end

	self._timeScheduler = LuaScheduler:getInstance():schedule(update, 1, true)
end

GameLoadingWidget = class("GameLoadingWidget", LoadingWidget, _M)

function GameLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function GameLoadingWidget:setupView()
	local view = self:getView()

	super.setupView(self, view)

	local bg = cc.Sprite:create("asset/ui/loading/bg_ld_xyx_02.png")

	bg:addTo(view, -1):center(view:getContentSize())

	local resFile = "asset/ui/gameLoading.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 9):setName("main"):center(view:getContentSize())

	local bottomPanel = view:getChildByFullName("bottom")

	if bottomPanel then
		local bottomBgImg = bottomPanel:getChildByName("Image_bg")

		bottomBgImg:loadTexture("asset/ui/loading/bg_ld_ho_01.png")
	end
end

GuideLoadingWidget = class("GuideLoadingWidget", LoadingWidget, _M)

function GuideLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function GuideLoadingWidget:setupView()
	local view = self:getView()

	super.setupView(self, view)
end

BuildLoadingWidget = class("BuildLoadingWidget", LoadingWidget, _M)

function BuildLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function BuildLoadingWidget:setupView()
	local view = self:getView()
	local resFile = "asset/ui/enterLoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")
	AdjustUtils.adjustLayoutUIByRootNode(node)

	local node_bg = node:getChildByFullName("Node_bg")
	local node_des = node:getChildByFullName("Node_des")
	local node_anim = node:getChildByFullName("Node_anim")
	local _tab = {}
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local loginInfo = ConfigReader:getDataTable("Loading")
	local desInfo

	if guideAgent:isGuiding() and guideAgent:getCurrentScriptName() == "guide_chapterOne1_4" then
		desInfo = loginInfo.LoadingTips_Buildfirst
	else
		for k, v in pairs(loginInfo) do
			if v.Type == "Build" then
				_tab[#_tab + 1] = v
			end
		end

		desInfo = _tab[math.random(1, #_tab)]
	end

	local background = desInfo.Background
	local content = desInfo.Content
	local img, index = CommonUtils.randomByWeight(background.quanzhong, background.img)

	img = img or "qm_bg_bj.jpg"

	local tips, index = CommonUtils.randomByWeight(content.quanzhong, content.img)

	tips = tips or ""

	local text_des1 = node_des:getChildByFullName("Text_des1")
	local text_des2 = node_des:getChildByFullName("Text_des2")

	text_des1:setString("Tips:")
	text_des2:setString(Strings:get(tips))
	text_des1:setPositionX(text_des2:getPositionX() - text_des2:getContentSize().width / 2)

	local bg = ccui.ImageView:create("asset/scene/" .. img)

	bg:addTo(node_bg):posite(0, 0)

	local anim = cc.MovieClip:create("bb_loading")

	anim:addTo(node_anim, 1)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	anim:gotoAndPlay(1)
end

function BuildLoadingWidget:onProgress(task, progress)
	return
end

PveLoadingWidget = class("PveLoadingWidget", LoadingWidget, _M)

function PveLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function PveLoadingWidget:setupView(data)
	local loadingId = data.loadingId
	local view = self:getView()
	local resFile = "asset/ui/enterLoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")
	AdjustUtils.adjustLayoutUIByRootNode(node)

	local node_bg = node:getChildByFullName("Node_bg")
	local node_des = node:getChildByFullName("Node_des")
	local node_anim = node:getChildByFullName("Node_anim")
	local desInfo

	if loadingId then
		desInfo = ConfigReader:getRecordById("Loading", loadingId)
	end

	if desInfo == nil then
		local _tab = {}
		local lodinInfo = ConfigReader:getDataTable("Loading")

		for k, v in pairs(lodinInfo) do
			if v.Type == "PVP" then
				_tab[#_tab + 1] = v
			end
		end

		desInfo = _tab[math.random(1, #_tab)]
	end

	local text_des1 = node_des:getChildByFullName("Text_des1")
	local text_des2 = node_des:getChildByFullName("Text_des2")
	local strs = desInfo.Content
	local random = math.random(1, #strs)
	local str = Strings:get(strs[random])

	text_des1:setString("Tips:")
	text_des2:setString(str)
	text_des1:setPositionX(text_des2:getPositionX() - text_des2:getContentSize().width / 2)

	local bg = ccui.ImageView:create("asset/scene/" .. desInfo.Background)

	bg:addTo(node_bg):posite(0, 0)

	local anim = cc.MovieClip:create("bb_loading")

	anim:addTo(node_anim, 1)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	anim:gotoAndPlay(1)
end

function PveLoadingWidget:onProgress(task, progress)
	return
end

PvpLoadingWidget = class("PvpLoadingWidget", LoadingWidget, _M)

function PvpLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function PvpLoadingWidget:setupView(data)
	local loadingId = data.loadingId
	local view = self:getView()
	local resFile = "asset/ui/enterLoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")
	AdjustUtils.adjustLayoutUIByRootNode(node)

	local node_bg = node:getChildByFullName("Node_bg")
	local node_des = node:getChildByFullName("Node_des")
	local node_anim = node:getChildByFullName("Node_anim")

	node_des:setVisible(false)

	local desInfo

	if loadingId then
		desInfo = ConfigReader:getRecordById("Loading", loadingId)
	end

	if desInfo == nil then
		local _tab = {}
		local lodinInfo = ConfigReader:getDataTable("Loading")

		for k, v in pairs(lodinInfo) do
			if v.Type == "PVP" then
				_tab[#_tab + 1] = v
			end
		end

		desInfo = _tab[math.random(1, #_tab)]
	end

	local text_des1 = node_des:getChildByFullName("Text_des1")
	local text_des2 = node_des:getChildByFullName("Text_des2")
	local strs = desInfo.Content
	local random = math.random(1, #strs)
	local str = Strings:get(strs[random])

	text_des1:setString("Tips:")
	text_des2:setString(str)

	local bg = ccui.ImageView:create("asset/scene/" .. desInfo.Background)

	bg:addTo(node_bg):posite(0, 0)

	local anim = cc.MovieClip:create("bb_loading")

	anim:addTo(node_anim, 1)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	anim:gotoAndPlay(1)
end

function PvpLoadingWidget:onProgress(task, progress)
	return
end

EnterGameLoadingWidget = class("EnterGameLoadingWidget", LoadingWidget, _M)

function EnterGameLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function EnterGameLoadingWidget:setupView()
	local view = self:getView()
	local resFile = "asset/ui/EnterGameLoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")
	AdjustUtils.adjustLayoutUIByRootNode(node)
	self:initProgress()
end

function EnterGameLoadingWidget:initProgress()
	local loadingNode = self:getView():getChildByFullName("bottom.loading.node_pro")
	local moveNode = loadingNode:getChildByName("img_move")
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", "ZZBBWei")
	local model = ConfigReader:getRecordById("RoleModel", roleModel).Model
	local node = RoleFactory:createRoleAnimation(model)

	node:setScale(0.5)
	node:playAnimation(0, "run", true)
	node:offset(0, -20)
	node:addTo(moveNode:getChildByName("anim_node"))
	node:setLocalZOrder(-1)

	local rightAnim = cc.MovieClip:create("aa_loading")

	rightAnim:play()
	rightAnim:addTo(loadingNode:getChildByFullName("anim.anim"))

	local loadingAnim = cc.MovieClip:create("cc_loading")

	loadingAnim:play()
	loadingAnim:offset(0, -3)
	loadingAnim:addTo(moveNode)
end

function EnterGameLoadingWidget:onProgress(task, progress)
	local loadingNode = self:getView():getChildByFullName("bottom.loading.node_pro")
	local loadingBar = loadingNode:getChildByName("loading")

	loadingBar:setPercent(progress * 100)

	local moveNode = loadingNode:getChildByName("img_move")

	moveNode:posite(-509 + 975 * progress)

	local progressNum = loadingNode:getChildByFullName("anim.percent_text")

	progressNum:setString(string.format("%d", progress * 100))
end

CommonLoadingWidget = class("CommonLoadingWidget", LoadingWidget, _M)

function CommonLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function CommonLoadingWidget:setupView(data)
	local loadingId = data.loadingId
	local loadingType = data.loadingType
	local view = self:getView()
	local resFile = "asset/ui/enterLoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")
	AdjustUtils.adjustLayoutUIByRootNode(node)

	local node_bg = node:getChildByFullName("Node_bg")
	local node_des = node:getChildByFullName("Node_des")
	local node_anim = node:getChildByFullName("Node_anim")
	local desInfo

	if loadingId then
		desInfo = ConfigReader:getRecordById("Loading", loadingId)
	end

	if desInfo == nil then
		desInfo = self:getLoadingData(loadingType)
	end

	local background = desInfo.Background
	local content = desInfo.Content
	local img, index = CommonUtils.randomByWeight(background.quanzhong, background.img)

	img = img or "qm_bg_bj.jpg"

	local tips, index = CommonUtils.randomByWeight(content.quanzhong, content.img)

	tips = tips or ""

	local text_des1 = node_des:getChildByFullName("Text_des1")
	local text_des2 = node_des:getChildByFullName("Text_des2")

	text_des1:setString("Tips:")
	text_des2:setString(Strings:get(tips))

	local bg = ccui.ImageView:create("asset/scene/" .. img)

	bg:addTo(node_bg):posite(0, 0)

	local anim = cc.MovieClip:create("bb_loading")

	anim:addTo(node_anim, 1)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		mc:gotoAndPlay(1)
	end)
	anim:gotoAndPlay(1)
end

function CommonLoadingWidget:onProgress(task, progress)
	return
end

function CommonLoadingWidget:getLoadingData(type)
	local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local idStr = string.split(player:getRid(), "_")
	local userId = type .. idStr[1]
	local value = cc.UserDefault:getInstance():getStringForKey(userId, tostring(firstLoading.KFirst))
	local count = firstLoading.KSecondUp

	if value == tostring(firstLoading.KFirst) then
		count = firstLoading.KFirst

		cc.UserDefault:getInstance():setStringForKey(userId, tostring(firstLoading.KSecondUp))
	end

	local d

	for k, v in pairs(lodinInfo) do
		if v.Type == type and v.FirstLoading == count then
			d = v

			break
		end
	end

	return d
end
