-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationPickResultHeroItem.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationPickResultHeroItem", package.seeall)

local SummonSimulationPickResultHeroItem = class("SummonSimulationPickResultHeroItem", LuaCompBase)

function SummonSimulationPickResultHeroItem:init(go)
	self.go = go
	self._imagebg = gohelper.findChildImage(self.go, "bg/#image_bg")
	self._simageicon = gohelper.findChildSingleImage(self.go, "mask/#simage_icon")
	self._imagerare = gohelper.findChildImage(self.go, "mask1/#image_rare")
	self._imagerarebar = gohelper.findChildImage(self.go, "#image_rarebar")
	self._imagecareer = gohelper.findChildImage(self.go, "#image_career")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._btnClick = gohelper.findChildButton(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonSimulationPickResultHeroItem:addEventListeners()
	self._btnClick:AddClickListener(self._onClick, self)
end

function SummonSimulationPickResultHeroItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function SummonSimulationPickResultHeroItem:_editableInitView()
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnClick.gameObject)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)

	self._gonew = gohelper.findChild(self.go, "reddot")
end

function SummonSimulationPickResultHeroItem:_onClick()
	if not self._index or self._index == SummonSimulationPickModel.instance:getCurSelectIndex() then
		return
	end

	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectItem, self._index)
end

function SummonSimulationPickResultHeroItem:_onLongClickItem()
	if not self._heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		showHome = false,
		heroId = self._heroId
	})
end

function SummonSimulationPickResultHeroItem:setInfo(heroId, index)
	self._heroId = heroId
	self._index = index

	self:_refreshUI()
end

function SummonSimulationPickResultHeroItem:_refreshUI()
	local heroId = self._heroId
	local config = HeroConfig.instance:getHeroCO(heroId)
	local skinId = config.skinId
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(tostring(skinConfig.headIcon)))

	self._txtname.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(config.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bg_pz00" .. tostring(CharacterEnum.Color[config.rare]))
	UISpriteSetMgr.instance:setCommonSprite(self._imagerarebar, "equipbar" .. tostring(CharacterEnum.Color[config.rare]))
	UISpriteSetMgr.instance:setCommonSprite(self._imagebg, "bgequip" .. tostring(CharacterEnum.Color[config.rare]))

	if not self.newDot then
		self.newDot = MonoHelper.addNoUpdateLuaComOnceToGo(self._gonew, CommonRedDotIconNoEvent)

		self.newDot:setShowType(RedDotEnum.Style.Green)
		self.newDot:setCheckShowRedDotFunc(self.refreshDot, self)
	else
		self.newDot:refreshRedDot()
	end

	gohelper.setActive(self._gonew, true)
end

function SummonSimulationPickResultHeroItem:refreshDot(item)
	local heroMo = HeroModel.instance:getByHeroId(self._heroId)

	return not heroMo
end

function SummonSimulationPickResultHeroItem:onDestroy()
	return
end

return SummonSimulationPickResultHeroItem
