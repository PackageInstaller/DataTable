-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickChoiceViewList.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceViewList", package.seeall)

local SummonNewCustomPickChoiceViewList = class("SummonNewCustomPickChoiceViewList", BaseView)

function SummonNewCustomPickChoiceViewList:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonNewCustomPickChoiceViewList:_editableInitView()
	self._ownHeroes = {}
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content")
	self._tfcontent = self._gocontent.transform
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem")

	gohelper.setActive(self._goitem, false)
end

function SummonNewCustomPickChoiceViewList:onOpen()
	logNormal("SummonNewCustomPickChoiceViewList onOpen")
	SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
	self:refreshUI()
end

function SummonNewCustomPickChoiceViewList:refreshUI()
	self:refreshList()
end

function SummonNewCustomPickChoiceViewList:refreshList()
	self:refreshItems(SummonNewCustomPickChoiceListModel.instance.ownList, self._ownHeroes, self._gocontent)
	ZProj.UGUIHelper.RebuildLayout(self._tfcontent)
end

function SummonNewCustomPickChoiceViewList:refreshItems(datas, items, goRoot)
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

function SummonNewCustomPickChoiceViewList:getOrCreateItem(index, items, goRoot)
	local item = items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._goitem, goRoot, "item" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, SummonNewCustomPickChoiceItem)

		item.component:init(item.go)
		item.component:addEvents()
		item.component:setClickCallBack(function(heroId)
			SummonNewCustomPickChoiceController.instance:setSelect(heroId)
		end)

		items[index] = item
	end

	return item
end

function SummonNewCustomPickChoiceViewList:addEvents()
	self.addEventCb(self, SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonNewCustomPickChoiceViewList:removeEvents()
	self.removeEventCb(self, SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

return SummonNewCustomPickChoiceViewList
