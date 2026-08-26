-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174ForcePickView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174ForcePickView", package.seeall)

local Act174ForcePickView = class("Act174ForcePickView", BaseView)

function Act174ForcePickView:onInitView()
	self._goBuff = gohelper.findChild(self.viewGO, "#go_Buff")
	self._goBuild = gohelper.findChild(self.viewGO, "#go_Build")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174ForcePickView:addEvents()
	return
end

function Act174ForcePickView:removeEvents()
	return
end

function Act174ForcePickView:_onEscBtnClick()
	if self.gameInfo.gameCount == 0 then
		self:closeThis()
	end
end

function Act174ForcePickView:_editableInitView()
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Buff/simage_title/txt_title")
	self._goTitleEndless = gohelper.findChild(self.viewGO, "#go_Buff/simage_title/txt_title_endless")
end

function Act174ForcePickView:onUpdateParam()
	self:onOpen()
end

function Act174ForcePickView:onOpen()
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.SeasonChange, self.closeThis, self)
	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)

	self.actId = Activity174Model.instance:getCurActId()
	self.bagConfig = lua_activity174_bag
	self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	gohelper.setActive(self._gotopleft, self.gameInfo.gameCount == 0)

	local _, isEndless = Activity174Config.instance:getMaxRound(self.actId, self.gameInfo.gameCount)

	gohelper.setActive(self._goTitle, not isEndless)
	gohelper.setActive(self._goTitleEndless, isEndless)
	self:freshPickBagItem()
end

function Act174ForcePickView:onClose()
	TaskDispatcher.cancelTask(self.nextStep, self)
end

function Act174ForcePickView:onDestroyView()
	self:clearIconList()
end

function Act174ForcePickView:clearIconList()
	if self.buffIconList then
		for _, buffIcon in ipairs(self.buffIconList) do
			buffIcon:UnLoadImage()
		end
	end

	if self.heroIconList then
		for _, heroIcon in ipairs(self.heroIconList) do
			heroIcon:UnLoadImage()
		end
	end

	if self.collectionIconList then
		for _, collectionIcon in ipairs(self.collectionIconList) do
			collectionIcon:UnLoadImage()
		end
	end
end

function Act174ForcePickView:freshPickBagItem()
	if self.viewParam then
		self.forceBagInfo = self.viewParam

		self:clearIconList()

		local bageId = self.forceBagInfo[1].bagInfo.bagId

		self.bagType = self.bagConfig.configDict[bageId].type

		if self.bagType == Activity174Enum.BagType.Enhance then
			self:initBuffSelectItem()
		else
			self:initBuildSelectItem()
		end

		gohelper.setActive(self._goBuff, self.bagType == Activity174Enum.BagType.Enhance)
		gohelper.setActive(self._goBuild, self.bagType ~= Activity174Enum.BagType.Enhance)

		local var_11_0

		if self.bagType == Activity174Enum.BagType.Enhance then
			var_11_0 = Activity174Event.ChooseBuffPackage

			if not Activity174Event.ChooseBuffPackage then
				if self.bagType == Activity174Enum.BagType.StartRare then
					var_11_0 = Activity174Event.ChooseRolePackage or nil
				end
			end
		end

		Activity174Controller.instance:dispatchEvent(var_11_0)
	else
		logError("please open with forceBagInfo")
	end
end

function Act174ForcePickView:initBuffSelectItem()
	self.bagAnimList = self:getUserDataTb_()
	self.buffIconList = self:getUserDataTb_()

	local selectGoParent = gohelper.findChild(self.viewGO, "#go_Buff/scroll_view/Viewport/Content")
	local selectGo = gohelper.findChild(self.viewGO, "#go_Buff/scroll_view/Viewport/Content/SelectItem")

	gohelper.CreateObjList(self, self._onInitBuffItem, self.forceBagInfo, selectGoParent, selectGo)
end

function Act174ForcePickView:_onInitBuffItem(go, data, i)
	local buffIcon = gohelper.findChildSingleImage(go, "simage_bufficon")
	local txtName = gohelper.findChildText(go, "txt_name")
	local txtDesc = gohelper.findChildText(go, "scroll_desc/Viewport/go_desccontent/txt_desc")
	local bagInfo = data.bagInfo
	local enhanceCo = lua_activity174_enhance.configDict[bagInfo.enhanceId[1]]

	buffIcon:LoadImage(ResUrl.getAct174BuffIcon(enhanceCo.icon))

	txtName.text = enhanceCo.title
	txtDesc.text = SkillHelper.buildDesc(enhanceCo.desc)

	SkillHelper.addHyperLinkClick(txtDesc)

	local btnBuy = gohelper.findChildButtonWithAudio(go, "btn_select")

	self.addClickCb(self, btnBuy, self.clickBag, self, i)

	self.buffIconList[i] = buffIcon
	self.bagAnimList[i] = go:GetComponent(gohelper.Type_Animator)
end

function Act174ForcePickView:initBuildSelectItem()
	self.heroIconList = self:getUserDataTb_()
	self.collectionIconList = self:getUserDataTb_()
	self.bagAnimList = self:getUserDataTb_()

	local selectGoParent = gohelper.findChild(self.viewGO, "#go_Build/scroll_view/Viewport/Content")
	local selectGo = gohelper.findChild(self.viewGO, "#go_Build/scroll_view/Viewport/Content/SelectItem")

	gohelper.CreateObjList(self, self._onInitBuildItem, self.forceBagInfo, selectGoParent, selectGo)
end

function Act174ForcePickView:_onInitBuildItem(go, data, i)
	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	local turnCo = Activity174Config.instance:getTurnCo(self.actId, gameInfo.gameCount)
	local bagNames = string.split(turnCo.name, "#")
	local txtName = gohelper.findChildText(go, "name/txt_name")

	txtName.text = bagNames[i] or ""

	local btnBuy = gohelper.findChildButtonWithAudio(go, "btn_select")

	self.addClickCb(self, btnBuy, self.clickBag, self, i)

	local roleGo = gohelper.findChild(go, "role/roleitem")
	local collectionGo = gohelper.findChild(go, "collection/collectionitem")
	local bagInfo = data.bagInfo

	for j, heroId in ipairs(bagInfo.heroId) do
		local go1 = gohelper.cloneInPlace(roleGo)
		local heroCo = Activity174Config.instance:getRoleCo(heroId)
		local imageRare = gohelper.findChildImage(go1, "rare")
		local heroIcon = gohelper.findChildSingleImage(go1, "heroicon")
		local btnClick = gohelper.findChildButtonWithAudio(go1, "heroicon")
		local imageCareer = gohelper.findChildImage(go1, "career")
		local txtName1 = gohelper.findChildText(go1, "name")

		UISpriteSetMgr.instance:setCommonSprite(imageRare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))
		UISpriteSetMgr.instance:setCommonSprite(imageCareer, "lssx_" .. heroCo.career)
		heroIcon:LoadImage(ResUrl.getHeadIconSmall(heroCo.skinId))

		txtName1.text = heroCo.name

		self.addClickCb(self, btnClick, self.clickRole, self, {
			x = i,
			y = j
		})

		self.heroIconList[#self.heroIconList + 1] = heroIcon
	end

	for j, itemId in ipairs(bagInfo.itemId) do
		local go2 = gohelper.cloneInPlace(collectionGo)
		local co = Activity174Config.instance:getCollectionCo(itemId)
		local imageRare = gohelper.findChildImage(go2, "rare")
		local collectionIcon = gohelper.findChildSingleImage(go2, "collectionicon")
		local btnClick = gohelper.findChildButtonWithAudio(go2, "collectionicon")

		collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(co.icon))
		UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_propitembg_" .. co.rare)
		self.addClickCb(self, btnClick, self.clickCollection, self, {
			x = i,
			y = j
		})

		self.collectionIconList[#self.collectionIconList + 1] = collectionIcon
	end

	gohelper.setActive(roleGo, false)
	gohelper.setActive(collectionGo, false)

	self.bagAnimList[i] = go:GetComponent(gohelper.Type_Animator)
end

function Act174ForcePickView:clickBag(index)
	local forceBagInfo = self.forceBagInfo[index]

	Activity174Rpc.instance:sendSelectAct174ForceBagRequest(self.actId, forceBagInfo.index, self.forcePickReply, self)

	self.selectIndex = index
end

function Act174ForcePickView:forcePickReply(cmd, resultCode)
	if resultCode == 0 then
		local index = self.selectIndex

		if index and self.bagAnimList[index] then
			self.bagAnimList[index]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(self.nextStep, self, 0.67)

		self.selectIndex = nil
	end
end

function Act174ForcePickView:clickRole(param)
	if self.forceBagInfo[param.x] then
		local bagInfo = self.forceBagInfo[param.x].bagInfo

		if bagInfo then
			local roleId = bagInfo.heroId[param.y]
			local roleCo = Activity174Config.instance:getRoleCo(roleId)

			if roleCo then
				local viewParam = {}

				viewParam.type = Activity174Enum.ItemTipType.Character
				viewParam.co = roleCo
				viewParam.showMask = true

				Activity174Controller.instance:openItemTipView(viewParam)
			end
		end
	end
end

function Act174ForcePickView:clickCollection(param)
	if self.forceBagInfo[param.x] then
		local bagInfo = self.forceBagInfo[param.x].bagInfo

		if bagInfo then
			local collectionId = bagInfo.itemId[param.y]
			local collectionCo = Activity174Config.instance:getCollectionCo(collectionId)

			if collectionCo then
				local viewParam = {}

				viewParam.type = Activity174Enum.ItemTipType.Collection
				viewParam.co = collectionCo
				viewParam.showMask = true

				Activity174Controller.instance:openItemTipView(viewParam)
			end
		end
	end
end

function Act174ForcePickView:nextStep()
	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	if gameInfo.state == Activity174Enum.GameState.ForceSelect then
		Activity174Controller.instance:openForcePickView(gameInfo:getForceBagsInfo())
	else
		Activity174Controller.instance:openGameView()
		self:closeThis()
	end
end

return Act174ForcePickView
