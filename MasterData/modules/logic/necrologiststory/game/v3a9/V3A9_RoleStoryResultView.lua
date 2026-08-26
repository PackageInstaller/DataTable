-- chunkname: @modules/logic/necrologiststory/game/v3a9/V3A9_RoleStoryResultView.lua

module("modules.logic.necrologiststory.game.v3a9.V3A9_RoleStoryResultView", package.seeall)

local V3A9_RoleStoryResultView = class("V3A9_RoleStoryResultView", BaseView)

function V3A9_RoleStoryResultView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/mask")
	self.btnCloseTips = gohelper.findChildButtonWithAudio(self.viewGO, "root/Tips/#btn_closeTips")
	self.goTips = gohelper.findChild(self.viewGO, "root/Tips")
	self.animTips = gohelper.findChildAnim(self.viewGO, "root/Tips")
	self.btnTips = gohelper.findChildButtonWithAudio(self.viewGO, "root/Title/txt_title/#btn_tips")
	self.txtTipsDesc = gohelper.findChildTextMesh(self.viewGO, "root/Tips/tips/#txt_desc")
	self.txtChat = gohelper.findChildTextMesh(self.viewGO, "root/Role/bg/#txt_chat")
	self.goBottom = gohelper.findChild(self.viewGO, "root/Bottom")
	self.txtEgg = gohelper.findChildTextMesh(self.viewGO, "root/Bottom/eggs/#txt_eggs")
	self.goAttribute = gohelper.findChild(self.viewGO, "root/Attribute")
	self.attributeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self.goAttribute)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A9_RoleStoryResultView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
	self.addClickCb(self, self.btnCloseTips, self.onClickCloseTips, self)
	self.addClickCb(self, self.btnTips, self.showTips, self)
end

function V3A9_RoleStoryResultView:removeEvents()
	self:removeClickCb(self.btnCloseTips)
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnTips)
end

function V3A9_RoleStoryResultView:_editableInitView()
	return
end

function V3A9_RoleStoryResultView:onClickClose()
	self:closeThis()
end

function V3A9_RoleStoryResultView:onClickCloseTips()
	gohelper.setActive(self.btnCloseTips, false)
	self.animTips:Play("close")
end

function V3A9_RoleStoryResultView:showTips()
	gohelper.setActive(self.goTips, true)
	gohelper.setActive(self.btnCloseTips, true)
	self.animTips:Play("open")
end

function V3A9_RoleStoryResultView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function V3A9_RoleStoryResultView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A9_RoleStoryResultView:refreshParam()
	if not self.viewParam then
		local viewParam = {}
		local storyId = viewParam.roleStoryId

		self.heroStoryId = storyId

		if storyId then
			self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
		end
	end
end

function V3A9_RoleStoryResultView:refreshView()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_yct_yishi_evaluation)
	self.attributeAnimatorPlayer:Play("result", self.onPlayComplete, self)

	local result = self.gameBaseMO:getResultData()

	self.resultData = result

	self:refreshStarList({
		result.star1Count,
		result.star2Count,
		result.star3Count
	})
	self:refreshTipsBtn(result.randomConfig)
end

function V3A9_RoleStoryResultView:initStarList()
	if self.starList then
		return
	end

	self.starList = {}

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.starList = {}

		local rootPath = string.format("root/Attribute/attribute_%s/star", i)

		for j = 1, 5 do
			local starItem = self:getUserDataTb_()

			starItem.greyGO = gohelper.findChild(self.viewGO, string.format("%s/%s/grey", rootPath, j))
			starItem.lightGO = gohelper.findChild(self.viewGO, string.format("%s/%s/light", rootPath, j))
			item.starList[j] = starItem
		end

		self.starList[i] = item
	end
end

function V3A9_RoleStoryResultView:refreshStarList(starCountList)
	self:initStarList()

	local starTotalCount = 0

	for i, item in ipairs(self.starList) do
		local starCount = starCountList[i]

		for j, starItem in ipairs(item.starList) do
			local isLight = j <= starCount

			gohelper.setActive(starItem.greyGO, not isLight)
			gohelper.setActive(starItem.lightGO, isLight)
		end

		starTotalCount = starTotalCount + starCount
	end

	local levelConfig = NecrologistStoryV3A9Config.instance:getLevelConfig(starTotalCount)

	self.levelId = levelConfig.id

	local go = gohelper.findChild(self.viewGO, string.format("root/Attribute/attribute_4/level/image_%s", self.levelId))

	gohelper.setActive(go, true)

	if levelConfig then
		self.txtChat.text = levelConfig.starDesc or ""
	end
end

function V3A9_RoleStoryResultView:refreshTipsBtn(randomConfig)
	local isSLevel = self.levelId == 3

	gohelper.setActive(self.btnTips, not isSLevel)

	if isSLevel then
		return
	end

	local items = string.splitToNumber(randomConfig.item, "#")
	local dict = {}

	for i, itemId in ipairs(items) do
		local config = NecrologistStoryV3A9Config.instance:getItemConfig(itemId)

		if config then
			dict[config.type] = dict[config.type] or {}

			table.insert(dict[config.type], config.group)
		end
	end

	local param1 = table.concat(dict[1], ",")
	local param2 = table.concat(dict[2], ",")

	self.txtTipsDesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v3a9_resultview_tips_txt"), param1, param2)
end

function V3A9_RoleStoryResultView:refreshEgg(config, starCount)
	local eggStarCount = 5
	local showEgg = eggStarCount <= starCount and config ~= nil

	gohelper.setActive(self.goBottom, showEgg)

	if showEgg then
		self.txtEgg.text = config.itemNew

		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_activity_reward_ending)
	end
end

function V3A9_RoleStoryResultView:onPlayComplete()
	if not self.resultData then
		return
	end

	self:refreshEgg(self.resultData.config, self.resultData.star3Count)
end

function V3A9_RoleStoryResultView:onDestroyView()
	return
end

return V3A9_RoleStoryResultView
