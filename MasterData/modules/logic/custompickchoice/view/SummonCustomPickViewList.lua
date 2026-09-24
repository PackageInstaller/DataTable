-- chunkname: @modules/logic/custompickchoice/view/SummonCustomPickViewList.lua

module("modules.logic.custompickchoice.view.SummonCustomPickViewList", package.seeall)

local SummonCustomPickViewList = class("SummonCustomPickViewList", BaseView)

function SummonCustomPickViewList:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonCustomPickViewList:_editableInitView()
	self._ownHeroes = {}
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content")
	self._tfcontent = self._gocontent.transform
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem")

	gohelper.setActive(self._goitem, false)
end

function SummonCustomPickViewList:onOpen()
	self:refreshUI()
end

function SummonCustomPickViewList:refreshUI()
	self:refreshList()
end

function SummonCustomPickViewList:refreshList()
	local ownList = SummonCustomPickHeroModel.instance:getOwnList()

	self:refreshItems(ownList, self._ownHeroes, self._gocontent)
	ZProj.UGUIHelper.RebuildLayout(self._tfcontent)
end

function SummonCustomPickViewList:refreshItems(datas, items, goRoot)
	if datas and #datas > 0 then
		gohelper.setActive(goRoot, true)

		for index, mo in ipairs(datas) do
			local item = self:getOrCreateItem(index, items, goRoot)

			item.component:onUpdateMO(mo)
		end
	else
		gohelper.setActive(goRoot, false)
	end
end

function SummonCustomPickViewList:getOrCreateItem(index, items, goRoot)
	local item = items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._goitem, goRoot, "item" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, SummonCustomPickItem)

		item.component:init(item.go)
		item.component:addEvents()
		item.component:setClickCallBack(self._onSetSelect, self)

		items[index] = item
	end

	return item
end

function SummonCustomPickViewList:_onSetSelect(heroId)
	SummonCustomPickHeroModel.instance:setSelectId(heroId)
	SummonCustomPickController.instance:dispatchEvent(SummonCustomPickEvent.OnCustomPickListChanged)
end

function SummonCustomPickViewList:addEvents()
	self.addEventCb(self, SummonCustomPickController.instance, SummonCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonCustomPickViewList:removeEvents()
	self.removeEventCb(self, SummonCustomPickController.instance, SummonCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

return SummonCustomPickViewList
