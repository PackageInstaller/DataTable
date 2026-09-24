-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedGroupItem.lua

module("modules.logic.character.view.recommed.CharacterRecommedGroupItem", package.seeall)

local CharacterRecommedGroupItem = class("CharacterRecommedGroupItem", ListScrollCell)

function CharacterRecommedGroupItem:onInitView()
	self.transform = self.viewGO.transform
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_info/#txt_index")
	self._goherogrouplist = gohelper.findChild(self.viewGO, "#go_info/#go_herogrouplist")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_use")
	self._goexpand = gohelper.findChild(self.viewGO, "#go_expand")
	self._goremainlist = gohelper.findChild(self.viewGO, "#go_expand/#go_remainlist")
	self._goremainitem = gohelper.findChild(self.viewGO, "#go_expand/#go_remainlist/#go_remainitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_team")
	self._btnexpand = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_expand")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_fold")

	self:setExpand(false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedGroupItem:addEventListeners()
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	self._btnexpand:AddClickListener(self._btnexpandOnClick, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnExpandTeam, self._onExpandTeam, self)
end

function CharacterRecommedGroupItem:removeEventListeners()
	self._btnuse:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnexpand:RemoveClickListener()
end

function CharacterRecommedGroupItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterRecommedGroupItem:_btnuseOnClick()
	if not self._showMainHeroMap then
		return
	end

	local replaceTeamList = {}

	for i = 1, CharacterRecommedEnum.TeamMaxHero do
		local uid

		if HeroGroupModel.instance:isPositionOpen(i) then
			local heroInfo = self._showMainHeroMap[i]
			local heroId = heroInfo and heroInfo:getHeroId()

			if heroId then
				::label_5_0::

				local heroMo = HeroModel.instance:getByHeroId(heroId)

				uid = heroMo and heroMo.uid
			end
		end

		local groupPresetMO = HeroSingleGroupPresetMO.New()

		groupPresetMO:init(i, uid)
		table.insert(replaceTeamList, groupPresetMO)
	end

	local params = {
		replaceTeamList = replaceTeamList
	}

	HeroGroupPresetController.instance:openHeroGroupPresetTeamView(params)
end

function CharacterRecommedGroupItem:_btnfoldOnClick()
	self:setExpand(false)
end

function CharacterRecommedGroupItem:_btnexpandOnClick()
	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnExpandTeam, self._teamId)
end

function CharacterRecommedGroupItem:_editableInitView()
	return
end

function CharacterRecommedGroupItem:_editableAddEvents()
	return
end

function CharacterRecommedGroupItem:_editableRemoveEvents()
	return
end

function CharacterRecommedGroupItem:onUpdateMO(mo, viewContainer, recommendMo, focusHeroId)
	self._goheroitem = self._goheroitem or viewContainer:getHeroIconRes()
	self._recommendMo = recommendMo
	self._viewContainer = viewContainer
	self._teamCo = mo
	self._teamId = self._teamCo.id
	self._groupMo = CharacterRecommedModel.instance:getTeamGroupMo(self._teamId)
	self._mainTeam = self._groupMo:getMainTeam()
	self._mainHeroList = self._mainTeam and self._mainTeam:getHeroList()
	self._remainTeam = self._groupMo:getRemainTeam()
	self._focusHeroId = focusHeroId

	self:_initShowMainHeroList()
	gohelper.CreateObjList(self, self._groupItemCB, self._showMainHeroList, self._goherogrouplist, self._goheroitem, CharacterRecommedReplaceHeroIcon)
	gohelper.CreateObjList(self, self._remainTeamCB, self._remainTeam, self._goremainlist, self._goremainitem, CharacterRecommedTeamItem)
	gohelper.setActive(self.viewGO, true)
	self:showUseBtn()
	self:checkShowExpandBtn()

	self.viewName = viewContainer.viewName
	self._txttitle.text = self._teamCo.teamName
end

function CharacterRecommedGroupItem:_initShowMainHeroList()
	self._showMainHeroList = {}
	self._showMainHeroMap = {}
	self._focusHeroInfo = self:_findFocusHeroInfo()
	self._focusTeamIndex = nil
	self._focusPosIndex = nil

	if self._focusHeroInfo then
		self._focusTeamIndex, self._focusPosIndex = self._focusHeroInfo:getCurPos()
	end

	for _, heroInfo in ipairs(self._mainHeroList) do
		local _, posIndex = heroInfo:getCurPos()

		if posIndex == self._focusPosIndex then
			table.insert(self._showMainHeroList, self._focusHeroInfo)

			self._showMainHeroMap[posIndex] = self._focusHeroInfo
		else
			table.insert(self._showMainHeroList, heroInfo)

			self._showMainHeroMap[posIndex] = heroInfo
		end
	end
end

function CharacterRecommedGroupItem:_findFocusHeroInfo()
	for _, heroInfo in ipairs(self._mainHeroList) do
		local heroId = heroInfo:getHeroId()

		if heroId == self._focusHeroId then
			return heroInfo
		end
	end

	if not self._remainTeam then
		return
	end

	for _, remainTeam in ipairs(self._remainTeam) do
		for _, heroInfo in ipairs(remainTeam:getHeroList()) do
			local heroId = heroInfo:getHeroId()

			if heroId == self._focusHeroId then
				return heroInfo
			end
		end
	end
end

function CharacterRecommedGroupItem:checkShowExpandBtn()
	gohelper.setActive(self._btnexpand.gameObject, false)

	if self._remainTeam then
		for _, remainTeam in ipairs(self._remainTeam) do
			for _, heroInfo in ipairs(remainTeam:getHeroList()) do
				local _, posIndex = heroInfo:getCurPos()

				if posIndex ~= self._focusPosIndex then
					gohelper.setActive(self._btnexpand.gameObject, true)

					return
				end
			end
		end
	end
end

function CharacterRecommedGroupItem:_groupItemCB(obj, data, index)
	local _, posIndex = data:getCurPos()
	local heroId = data:getHeroId()
	local destiny = data:getDestinyId()
	local mo = CharacterRecommedModel.instance:getHeroRecommendMo(heroId)

	obj:onUpdateMO(mo, destiny, self._mainTeam, posIndex)
	obj:setClickCallback(function()
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = mo.heroId,
			formView = self.viewName
		})
	end, self)

	local isOwnHero = mo:isOwnHero()

	obj:SetGrayscale(not isOwnHero)
end

function CharacterRecommedGroupItem:showUseBtn(isShow)
	isShow = isShow and self._recommendMo and self._recommendMo:isOwnHero()

	gohelper.setActive(self._btnuse.gameObject, isShow)
end

function CharacterRecommedGroupItem:setIndex(index)
	self._txtindex.text = index >= 10 and index or "0" .. index
end

function CharacterRecommedGroupItem:setHeightChangeCallback(callback, callobj)
	self._heightChangeCallback = callback
	self._heightChangeCallobj = callobj
end

function CharacterRecommedGroupItem:_remainTeamCB(teamItem, data, index)
	teamItem:onUpdateMO(data, self._viewContainer, self._focusPosIndex)
end

function CharacterRecommedGroupItem:playViewAnim(animName, layer, normalizedTime)
	self._viewAnim = self._viewAnim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._viewAnim then
		self._viewAnim:Play(animName, layer, normalizedTime)
	end
end

function CharacterRecommedGroupItem:setExpand(isExpand)
	if self._isExpand == isExpand then
		return
	end

	local isFirst = self._isExpand == nil

	self._isExpand = isExpand

	gohelper.setActive(self._goexpand, self._isExpand)
	gohelper.setActive(self._btnexpand.gameObject, not self._isExpand)
	gohelper.setActive(self._btnfold.gameObject, self._isExpand)

	if not isFirst and self._heightChangeCallback then
		self._heightChangeCallback(self._heightChangeCallobj, self, isExpand)
	end
end

function CharacterRecommedGroupItem:_onExpandTeam(teamId)
	self:setExpand(teamId == self._teamId)
end

function CharacterRecommedGroupItem:onSelect(isSelect)
	return
end

function CharacterRecommedGroupItem:onDestroy()
	return
end

return CharacterRecommedGroupItem
