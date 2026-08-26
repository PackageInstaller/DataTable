-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedGroupItem.lua

module("modules.logic.character.view.recommed.CharacterRecommedGroupItem", package.seeall)

local CharacterRecommedGroupItem = class("CharacterRecommedGroupItem", ListScrollCell)

function CharacterRecommedGroupItem:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_info/#txt_index")
	self._goherogrouplist = gohelper.findChild(self.viewGO, "#go_info/#go_herogrouplist")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_use")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedGroupItem:addEventListeners()
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
end

function CharacterRecommedGroupItem:removeEventListeners()
	self._btnuse:RemoveClickListener()
end

function CharacterRecommedGroupItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function CharacterRecommedGroupItem:_btnuseOnClick()
	local replaceTeamList = {}

	for i, heroId in ipairs(self._groupList) do
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if heroMo then
			local groupPresetMO = HeroSingleGroupPresetMO.New()

			groupPresetMO:init(i, heroMo.uid)
			table.insert(replaceTeamList, groupPresetMO)
		end
	end

	local params = {
		replaceTeamList = replaceTeamList
	}

	HeroGroupPresetController.instance:openHeroGroupPresetTeamView(params)
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

function CharacterRecommedGroupItem:onUpdateMO(mo, viewContainer, recommendMo)
	self._goheroitem = self._goheroitem or viewContainer:getHeroIconRes()
	self._groupList = mo
	self._recommendMo = recommendMo

	gohelper.CreateObjList(self, self._groupItemCB, mo, self._goherogrouplist.gameObject, self._goheroitem, CharacterRecommedHeroIcon)
	gohelper.setActive(self.viewGO, true)
	self:showUseBtn()

	self.viewName = viewContainer.viewName
end

function CharacterRecommedGroupItem:showUseBtn(isShow)
	isShow = isShow and self._recommendMo and self._recommendMo:isOwnHero()

	gohelper.setActive(self._btnuse.gameObject, isShow)
end

function CharacterRecommedGroupItem:setIndex(index)
	self._txtindex.text = index >= 10 and index or "0" .. index
end

function CharacterRecommedGroupItem:_groupItemCB(obj, data, index)
	local mo = CharacterRecommedModel.instance:getHeroRecommendMo(data)

	obj:onUpdateMO(mo)
	obj:setClickCallback(function()
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = mo.heroId,
			formView = self.viewName
		})
	end, self)

	local isOwnHero = mo:isOwnHero()

	obj:SetGrayscale(not isOwnHero)
end

function CharacterRecommedGroupItem:playViewAnim(animName, layer, normalizedTime)
	self._viewAnim = self._viewAnim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._viewAnim then
		self._viewAnim:Play(animName, layer, normalizedTime)
	end
end

function CharacterRecommedGroupItem:onSelect(isSelect)
	return
end

function CharacterRecommedGroupItem:onDestroy()
	return
end

return CharacterRecommedGroupItem
