-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationPickListItem.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationPickListItem", package.seeall)

local SummonSimulationPickListItem = class("SummonSimulationPickListItem", LuaCompBase)

function SummonSimulationPickListItem:init(go)
	self.go = go
	self._simageHeroIcon = gohelper.findChildSingleImage(self.go, "heroicon/#simage_icon")
	self._imagecareer = gohelper.findChildImage(self.go, "#image_career")
	self._imagerare = gohelper.findChildImage(self.go, "#image_rare")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._txtnameen = gohelper.findChildText(self.go, "#txt_nameen")
	self._btnclick = gohelper.findChildButton(self.go, "")
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self.go)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
	self._btnclick:AddClickListener(self._onbtnclick, self)

	self._gonew = gohelper.findChild(self.go, "#go_new")
end

function SummonSimulationPickListItem:_onLongClickItem()
	if not self._heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		showHome = false,
		heroId = self._heroId
	})
end

function SummonSimulationPickListItem:_onbtnclick()
	if not self._selectType then
		return
	end

	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectItem, self._selectType)
end

function SummonSimulationPickListItem:removeEvent()
	self._btnclick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function SummonSimulationPickListItem:removeEventListeners()
	self._btnLongPress:RemoveLongPressListener()
end

function SummonSimulationPickListItem:setData(heroId, selectType)
	self._heroId = heroId
	self._selectType = selectType

	self:_refreshUI()
end

function SummonSimulationPickListItem:_refreshUI()
	local heroId = self._heroId
	local config = HeroConfig.instance:getHeroCO(heroId)
	local skinId = config.skinId
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	self._simageHeroIcon:LoadImage(ResUrl.getHeadIconMiddle(tostring(skinConfig.largeIcon)))

	self._txtname.text = config.name
	self._txtnameen.text = config.nameEng

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(config.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bg_pz00" .. tostring(CharacterEnum.Color[config.rare]))

	if not self.newDot then
		self.newDot = MonoHelper.addNoUpdateLuaComOnceToGo(self._gonew, CommonRedDotIconNoEvent)

		self.newDot:setShowType(RedDotEnum.Style.Green)
		self.newDot:setCheckShowRedDotFunc(self.refreshDot, self)
	else
		self.newDot:refreshRedDot()
	end

	gohelper.setActive(self._gonew, true)
end

function SummonSimulationPickListItem:refreshDot(item)
	local heroMo = HeroModel.instance:getByHeroId(self._heroId)

	return not heroMo
end

function SummonSimulationPickListItem:onDestroy()
	self._btnLongPress:RemoveLongPressListener()
	self._btnclick:RemoveClickListener()
end

return SummonSimulationPickListItem
