-- chunkname: @modules/logic/versionactivity3_7/selfselect/view/V3a7SelfSelectPickView.lua

module("modules.logic.versionactivity3_7.selfselect.view.V3a7SelfSelectPickView", package.seeall)

local V3a7SelfSelectPickView = class("V3a7SelfSelectPickView", BaseView)

function V3a7SelfSelectPickView:onInitView()
	self._txtTips = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips")
	self._imageicon = gohelper.findChildImage(self.viewGO, "pickchoice/TipsBG/tip/#image_icon")
	self._txtTips1 = gohelper.findChildText(self.viewGO, "pickchoice/TipsBG/tip/#txt_Tips1")
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_heroitem")
	self._goexskill = gohelper.findChild(self.viewGO, "#go_heroitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#go_heroitem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "#go_heroitem/select/#go_click")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#scroll_hero")
	self._gohas = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_has")
	self._gohasroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_has/#go_hasroot")
	self._golock = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock/title/#txt_locked")
	self._golockroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_lock/#go_lockroot")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7SelfSelectPickView:addEvents()
	return
end

function V3a7SelfSelectPickView:removeEvents()
	return
end

function V3a7SelfSelectPickView:_editableInitView()
	return
end

function V3a7SelfSelectPickView:onClickModalMask()
	self:closeThis()
end

function V3a7SelfSelectPickView:onOpen()
	local item = self.viewParam

	if item then
		::label_6_0::

		local itemCo = ItemModel.instance:getItemConfig(item[1], item[2])
		local canSelectHeroIds = {}
		local disSelectHeroIds = {}

		if itemCo and not string.nilorempty(itemCo.effect) then
			local heroIds = string.splitToNumber(itemCo.effect, "#")

			for _, id in ipairs(heroIds) do
				local heroMo = HeroModel.instance:getByHeroId(id)

				if heroMo then
					table.insert(canSelectHeroIds, id)
				else
					table.insert(disSelectHeroIds, id)
				end
			end

			gohelper.CreateObjList(self, self._onRefreshItem, canSelectHeroIds, self._gohasroot, self._goheroitem, V3a7SelfSelectPickItem)
			gohelper.CreateObjList(self, self._onRefreshItem, disSelectHeroIds, self._golockroot, self._goheroitem, V3a7SelfSelectPickItem)
		end

		gohelper.setActive(self._gohas, #canSelectHeroIds > 0)
		gohelper.setActive(self._golock, #disSelectHeroIds > 0)
	end
end

function V3a7SelfSelectPickView:_onRefreshItem(obj, data, index)
	obj:onUpdateMO(data)
	gohelper.setActive(obj.viewGO, true)
end

function V3a7SelfSelectPickView:onClose()
	return
end

function V3a7SelfSelectPickView:onDestroyView()
	return
end

return V3a7SelfSelectPickView
