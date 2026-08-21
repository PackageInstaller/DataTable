-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationInCampView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationInCampView", package.seeall)

local M = class("HandbookRelationInCampView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._txtTitle = self:getText("title_view_-788888785")
	self._rectCampBtn = self:getUIComponent("handbook_relationship_hero_view_-861599388", UIComponentType.RectTransform)
	self._imgCampIcon = self:getImage("handbook_relationship_hero_view_-138365080")
	self._btnCampDetail = self:getBtn("handbook_relationship_hero_view_-1996637947")
	self._scroll = self:getUIComponent("handbook_relationship_hero_view_-1626159404", UIComponentType.ScrollRect)
	self._txtName = self:getText("handbook_relationship_hero_view_-1479491701")
	self._tipsImgCampIcon = self:getImage("1&handbook_relationship_camp_tips_-1452740336")
	self._tipsName = self:getText("1&handbook_relationship_camp_tips_-672512767")
	self._txtInfluenceZone = self:getText("1&handbook_relationship_camp_tips_-1033331600")
	self._tipsScroll = self:getUIComponent("1&handbook_relationship_camp_tips_-721828417", UIComponentType.ScrollRect)
	self._goItem = self:getGo("1&handbook_relationship_camp_tips_-1038875269")
	self._tipsGO = self:getGo("1&handbook_relationship_camp_tips_-422954445")
	self._tipsMask = Astral.UIClickTrigger.Get(self:getGo("1&handbook_relationship_camp_tips_758703064"))
	self._Bg1 = self:getGo("handbook_relationship_hero_view_564847701")
	self._Bg2 = self:getGo("handbook_relationship_hero_view_-1378073606")

	goutil.setActive(self._tipsGO, false)

	self._patternRoot = {}

	for i = 0, self._scroll.content.childCount - 1 do
		local gobj = self._scroll.content:GetChild(i).gameObject

		self._patternRoot[gobj.name] = gobj
	end

	self._cellCollect_Team = LocalReusableCollection.New(HandbookRelationTeamComp, 3)
	self._cellCollect_Hero = LocalReusableCollection.New(HandbookRelationHeroComp, 10)
end

function M:destroyUI()
	self._btnReturn = nil
	self._txtTitle = nil
	self._rectCampBtn = nil
	self._imgCampIcon = nil
	self._btnCampDetail = nil
	self._scroll = nil
	self._patternRoot = nil
	self._cellCollect_Team = nil
	self._cellCollect_Hero = nil
	self._prefabHero = nil
	self._prefabTeam = nil
	self._tipsScroll = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnCampDetail:AddClickListener(self._onClickCampDetail, self)
	self._tipsMask:AddClickListener(self._onClickMask, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnCampDetail:RemoveClickListener()
	self._tipsMask:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()

	self:_setEvent(true)
	self:changeCampShow(info.camp)
end

function M:changeCampShow(camp)
	if self._campId and self._campId == camp then
		return
	end

	self._campId = camp
	self._txtTitle.text = CommEnum.CampType2Name[self._campId]
	self._cellHero = {}

	self._cellCollect_Team:clearAllInstance()
	self._cellCollect_Hero:clearAllInstance()
	self:refreshView()
	self:refreshCellTag()
end

function M:_onClickMask()
	local uiRoot = self:getUIRoot()

	goutil.setActive(self._tipsGO, false)
	goutil.setActive(self._Bg1, true)
	goutil.setActive(self._Bg2, false)
	goutil.setActive(uiRoot.masterRoot, true)
	IconLoader.setSprite(self._imgCampIcon, IconType.CharacterDetailCamp, string.format("camp_logo_60%s", self._campId))

	local color = self._imgCampIcon.color

	self._imgCampIcon.color = Color.New(color.r, color.g, color.b, self._iconAlpha)
	uiRoot.canvasGroup.alpha = 1
end

function M:onExit()
	self._campId = nil

	self:_setEvent(false)
	self._cellCollect_Team:clearAllInstance()
	self._cellCollect_Hero:clearAllInstance()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self.refreshCellTag, self)
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_RELATION_VIEW_CLOSE, self.handleRelationshipViewClose, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self.refreshCellTag, self)
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_RELATION_VIEW_CLOSE, self.handleRelationshipViewClose, self)
	end
end

function M:handleRelationshipViewClose(e, heroId)
	if heroId then
		local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

		if cfgCharacter then
			local camp = cfgCharacter.camp

			self:changeCampShow(camp)
		end
	end
end

function M:_onClickReturn()
	self:close()
end

function M:_onClickCampDetail()
	if self._campId and self._campId > 0 then
		local uiRoot = self:getUIRoot()

		Astral.TransformUtil.SetAnchoredPos(self._rectCampBtn, 0, 0)

		local posX = goutil.getWidth(uiRoot.rectTr) * -0.5 + uiRoot.masterRoot.transform.anchoredPosition.x - 20
		local posY = goutil.getHeight(uiRoot.rectTr) * 0.5 - uiRoot.masterRoot.transform.anchoredPosition.y

		Astral.TransformUtil.SetAnchoredPos(self._scroll.content, posX, posY)
		goutil.setActive(self._tipsGO, true)
		goutil.setActive(self._Bg2, true)
		goutil.setActive(self._Bg1, false)
		goutil.setActive(uiRoot.masterRoot, false)
		IconLoader.setSprite(self._imgCampIcon, IconType.CharaterCampCornerIcon, string.format("camp_logo_30%s", self._campId))

		self._iconAlpha = self._imgCampIcon.color.a

		local color = self._imgCampIcon.color

		self._imgCampIcon.color = Color.New(color.r, color.g, color.b, 1)
		uiRoot.canvasGroup.alpha = 0.18

		self:refreshTips()
	end
end

function M:onClickHeroItem(heroCell)
	local heroId = heroCell:getHeroId()
	local isNew = heroCell:getIsNew()
	local isLock = heroCell:getIsLock()
	local isHeroMask = heroCell:getIsHeroMask()

	if isHeroMask then
		print("点击了角色剪影")

		return
	end

	print(string.format("尝试进入角色[%s]的关系网,new[%s],lock[%s]", heroId, isNew, isLock))

	local info = {
		heroId = heroId
	}

	ViewMgr.instance:open(ViewName.HandbookRelationshipView, info)
end

function M:createCellHero(heroId)
	if not self._prefabHero then
		self._prefabHero = self:getPrefab(ResName.Handbook_handbook_relationship_hero_item)
	end

	local cell = self._cellCollect_Hero:createInstance(self._prefabHero)

	cell:setHandler(self)
	cell:setRelationShow(false)
	cell:updateHeroShow(heroId)

	if not self._cellHero[heroId] then
		self._cellHero[heroId] = {}
	end

	table.insert(self._cellHero[heroId], cell)

	return cell
end

function M:createCellTeam()
	if not self._prefabTeam then
		self._prefabTeam = self:getPrefab(ResName.Handbook_handbook_relationship_team)
	end

	return self._cellCollect_Team:createInstance(self._prefabTeam)
end

function M:refreshCellTag()
	local typ = GameEnum.UnlockTypeEnum

	for heroId, cellLst in pairs(self._cellHero or {}) do
		local isNew = GalleryModel.instance:getIsIdUnRead(typ.Hero, heroId)

		if not isNew then
			local heroActiveRelationsIds = HandbookConfig.instance:getHeroRelationIds(heroId)

			isNew = GalleryModel.instance:getIsIdsUnRead(typ.HeroRelation, heroActiveRelationsIds)
		end

		local isLock = not GalleryModel.instance:getIsUnLock(typ.Hero, heroId)

		for _, cell in ipairs(cellLst) do
			if cell:getIsHeroMask() then
				isNew = false
				isLock = false
			end

			cell:setIsNew(isNew)
			cell:setIsLock(isLock)
		end
	end
end

function M:refreshView()
	local camp = self._campId

	self._txtName.text = self:_getCampName(camp)

	IconLoader.setSprite(self._imgCampIcon, IconType.CharacterDetailCamp, string.format("camp_logo_60%s", camp))

	local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCampInfo, camp)

	if not cfg then
		self:close()

		return
	end

	local len_organisation = cfg.organisation and #cfg.organisation or 0
	local uiPattern = cfg.uiPattern

	if string.nilorempty(uiPattern) then
		uiPattern = string.format("%s", len_organisation)
	end

	local rootGobj = self._patternRoot[uiPattern]

	if rootGobj then
		self:setUIRoot(rootGobj)
	else
		printWarn("无法找到[%s]的uiPattern节点，将使用1", uiPattern)

		uiPattern = "1"

		self:setUIRoot(self._patternRoot[uiPattern])
	end

	for key, _rootRect in pairs(self._patternRoot) do
		local show = key == uiPattern

		goutil.setActive(_rootRect.gameObject, show)
	end

	local uiRoot = self:getUIRoot()

	if uiRoot then
		self._rectCampBtn:SetParent(uiRoot.campBtnRoot.transform)
		Astral.TransformUtil.SetAnchoredPos(self._rectCampBtn, 0, 0)

		local posX = goutil.getWidth(uiRoot.rectTr) * -0.5 + uiRoot.masterRoot.transform.anchoredPosition.x
		local posY = goutil.getHeight(uiRoot.rectTr) * 0.5 - uiRoot.masterRoot.transform.anchoredPosition.y

		Astral.TransformUtil.SetAnchoredPos(self._scroll.content, posX, posY)

		self._scroll.velocity = {
			x = 0,
			y = 0
		}

		local heroId_master = cfg.master
		local showMaster = heroId_master > 0 or cfg.masterMask ~= 0

		if showMaster then
			local cell = self:createCellHero(heroId_master)
			local masterName = string.nilorempty(cfg.masterName) and lang("tip_handbook_camp_master_name") or cfg.masterName

			cell:setJobTxt(masterName)
			cell:setIsHeroMask(cfg.masterMask ~= 0)
			goutil.addChildToParent(cell:getMainGO(), uiRoot.masterRoot.transform)
		end

		goutil.setActive(uiRoot.masterRoot.gameObject, showMaster)

		if len_organisation > 0 then
			local rootLstTeam = uiRoot.group

			if len_organisation ~= #rootLstTeam then
				printWarn(string.format("uiPattern[%s],与配表小组数[%s]不对应", #rootLstTeam, len_organisation))
			end

			for index, groupId in ipairs(cfg.organisation) do
				local cfgGroup = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryOrganisationInfo, groupId)

				if cfgGroup then
					local pos = cfgGroup.pos
					local teamRoot = uiRoot.group[index]

					if teamRoot then
						local cellTeam = self:createCellTeam()

						cellTeam:setName(cfgGroup.name)

						local leaderId = cfgGroup.leader

						if leaderId > 0 or cfgGroup.leaderMask ~= 0 then
							local cellLeader = self:createCellHero(leaderId)

							if leaderId > 0 then
								cellLeader:setJobTxt()
							else
								local leaderName = string.nilorempty(cfgGroup.leaderName) and "队长" or cfgGroup.leaderName

								cellLeader:setJobTxt(leaderName)
							end

							cellLeader:setIsHeroMask(cfgGroup.leaderMask ~= 0)
							goutil.addChildToParent(cellLeader:getMainGO(), cellTeam:getLeaderRoot())
						end

						local members = cfgGroup.members

						if members then
							local uiPatternMember = cfgGroup.uiPattern

							if string.nilorempty(uiPatternMember) then
								uiPatternMember = string.format("%s", #members)
							end

							cellTeam:updateMembersVisible(uiPatternMember)

							for memberIndex, memberHeroId in ipairs(members) do
								local memberRoot = cellTeam:getMembersPosRoot(uiPatternMember, memberIndex - 1)

								if memberRoot then
									local cellMember = self:createCellHero(memberHeroId)

									cellMember:setJobTxt()
									cellMember:setIsHeroMask(memberHeroId <= 0)
									goutil.addChildToParent(cellMember:getMainGO(), memberRoot)
								end
							end
						end

						goutil.addChildToParent(cellTeam:getMainGO(), teamRoot)
					else
						printError(string.format("小组[%s],无法找到uiPattern[%s]节点,小组pos[%s]节点", groupId, uiPattern, pos))
					end
				else
					printError(string.format("小组[%s],无法找配置", groupId))
				end
			end
		end
	else
		printError(string.format("无法找到uiPattern[%s]的节点", uiPattern))
	end
end

function M:getUIRoot()
	return self._showUIRoot
end

function M:setUIRoot(root)
	if root then
		local campBtnRoot = goutil.findChild(root, "cellCamp")

		self._showUIRoot = {
			cellMaster = false,
			cellTeam = false,
			rectTr = root:GetComponent(UIComponentType.RectTransform),
			campBtnRoot = goutil.findChild(root, "cellCamp"),
			masterRoot = goutil.findChild(root, "cellMaster"),
			groupRoot = goutil.findChild(root, "group"),
			canvasGroup = goutil.findChild(root, "group"):GetComponent(ComponentType.CanvasGroup),
			group = {}
		}

		local groupR = self._showUIRoot.groupRoot.transform

		for i = 0, groupR.childCount - 1 do
			local tr = groupR:GetChild(i)

			table.insert(self._showUIRoot.group, tr)
		end
	else
		self._showUIRoot = nil
	end
end

function M:_getCampName(camp)
	return CommEnum.CampType2Name[camp]
end

function M:refreshTips()
	local camp = self._campId

	self._tipsName.text = self:_getCampName(camp)

	IconLoader.setSprite(self._tipsImgCampIcon, IconType.BigCamp, string.format("camp_logo_30%s", camp))

	local cfg = HandbookConfig.instance:getConfigByKey(ConfigName.GalleryCampInfo, camp)

	if cfg then
		self._txtInfluenceZone.text = string.format("%s:%s", lang("tip_handbook_camp_title_1"), cfg.influenceZone)

		local index = 1

		index = self:_setDescItem(index, lang("tip_handbook_camp_title_2"), cfg.desc)
		index = self:_setDescItem(index, lang("tip_handbook_camp_title_3"), cfg.aim)
		index = self:_setDescItem(index, lang("tip_handbook_camp_title_4"), cfg.industry)
		index = self:_setDescItem(index, lang("tip_handbook_camp_title_5"), self:_getCampRelationContent(cfg))
	end

	self._tipsScroll.verticalNormalizedPosition = 1
end

function M:_setDescItem(index, title, content)
	local rootTr = self._tipsScroll.content.transform

	while rootTr.childCount < index + 1 do
		goutil.cloneAndSetParent(self._goItem, rootTr)
	end

	local tmpGo = rootTr:GetChild(index).gameObject
	local _title = goutil.findChildTextComponent(tmpGo, "txtTitle")
	local _content = goutil.findChildTextComponent(tmpGo, "txtDesc")

	_title.text = title
	_content.text = content

	goutil.setActive(tmpGo, true)

	return index + 1
end

function M:_getCampRelationContent(cfg)
	local lst_amity = cfg.amity
	local lst_hostile = cfg.hostile
	local len_amity = lst_amity and #lst_amity or 0
	local len_hostile = lst_hostile and #lst_hostile or 0

	if len_amity == 0 and len_hostile == 0 then
		return string.format("【%s】", lang("tip_handbook_camp_relation_1"))
	else
		local t = {}
		local amity = {}
		local hostile = {}

		for _, _camp in ipairs(cfg.amity or {}) do
			table.insert(amity, self:_getCampName(_camp))
		end

		for _, _camp in ipairs(cfg.hostile or {}) do
			table.insert(hostile, self:_getCampName(_camp))
		end

		if #amity > 0 then
			table.insert(t, string.format("%s：", lang("tip_handbook_camp_relation_2")))
			table.insert(t, table.concat(amity, "、"))
			table.insert(t, "\n")
		end

		if #hostile > 0 then
			table.insert(t, string.format("%s：", lang("tip_handbook_camp_relation_3")))
			table.insert(t, table.concat(hostile, "、"))
		end

		return table.concat(t)
	end
end

return M
