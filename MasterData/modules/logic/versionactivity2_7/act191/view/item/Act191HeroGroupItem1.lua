-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191HeroGroupItem1.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem1", package.seeall)

local Act191HeroGroupItem1 = class("Act191HeroGroupItem1", LuaCompBase)

function Act191HeroGroupItem1:init(go)
	self.go = go
	self.goEmpty = gohelper.findChild(go, "go_Empty")
	self.goHero = gohelper.findChild(go, "go_Hero")
	self.btnClick = gohelper.findChildButton(go, "btn_Click")
	self.loader = PrefabInstantiate.Create(self.goHero)

	self.loader:startLoad(Activity191Enum.PrefabPath.HeroHeadItem, self.onLoadCallBack, self)

	self.enableClick = true
	self.dragging = false
end

function Act191HeroGroupItem1:onLoadCallBack()
	local go = self.loader:getInstGO()

	if go then
		self.heroHeadItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191HeroHeadItem, {
			exSkill = true
		})

		if self.needFresh then
			self.heroHeadItem:setData(self.heroId)

			self.needFresh = false
		end
	end
end

function Act191HeroGroupItem1:addEventListeners()
	if self.btnClick then
		self.addClickCb(self, self.btnClick, self.onClick, self)
	end
end

function Act191HeroGroupItem1:setData(heroId)
	self.heroId = heroId

	if heroId and heroId ~= 0 then
		if self.heroHeadItem then
			self.heroHeadItem:setData(heroId)

			self.needFresh = false
		else
			self.needFresh = true
		end

		gohelper.setActive(self.goEmpty, false)
		gohelper.setActive(self.goHero, true)
	else
		gohelper.setActive(self.goEmpty, true)
		gohelper.setActive(self.goHero, false)
	end
end

function Act191HeroGroupItem1:setIndex(index)
	self._index = index
end

function Act191HeroGroupItem1:setClickEnable(bool)
	self.enableClick = bool
end

function Act191HeroGroupItem1:onClick()
	if not self.enableClick or self.dragging then
		return
	end

	if self.param then
		Act191StatController.instance:statButtonClick(self.param.fromView, string.format("heroClick_%s_%s_%s", self.param.type, self._index, (self.heroHeadItem and self.heroHeadItem.config or nil) and self.heroHeadItem.config.name))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local param = {}

	param.index = self._index
	param.heroId = self.heroId

	ViewMgr.instance:openView(ViewName.Act191HeroEditView, param)
end

function Act191HeroGroupItem1:setExtraParam(param)
	self.param = param
end

function Act191HeroGroupItem1:setDrag(bool)
	self.dragging = bool
end

return Act191HeroGroupItem1
