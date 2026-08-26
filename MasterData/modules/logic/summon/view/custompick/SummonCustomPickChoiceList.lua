-- chunkname: @modules/logic/summon/view/custompick/SummonCustomPickChoiceList.lua

module("modules.logic.summon.view.custompick.SummonCustomPickChoiceList", package.seeall)

local SummonCustomPickChoiceList = class("SummonCustomPickChoiceList", BaseView)

function SummonCustomPickChoiceList:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonCustomPickChoiceList:addEvents()
	return
end

function SummonCustomPickChoiceList:removeEvents()
	return
end

function SummonCustomPickChoiceList:_editableInitView()
	self._noGainHeroes = {}
	self._ownHeroes = {}
	self._gobg = gohelper.findChild(self.viewGO, "bg")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	self._goNoGain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	self._goOwn = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")
	self._goTitleNoGain = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	self._goTitleOwn = gohelper.findChild(self.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	self.goTips2 = gohelper.findChild(self.viewGO, "Tips2")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title")
	self._txtTips = gohelper.findChildText(self.viewGO, "TipsBG/Tips")

	gohelper.setActive(self._goitem, false)

	self._tfcontent = self._gocontent.transform
end

function SummonCustomPickChoiceList:onDestroyView()
	return
end

function SummonCustomPickChoiceList:onOpen()
	logNormal("SummonCustomPickChoiceList onOpen")
	self.addEventCb(self, SummonCustomPickChoiceController.instance, SummonEvent.onCustomPickListChanged, self.refreshUI, self)
	self:refreshUI()
end

function SummonCustomPickChoiceList:onClose()
	return
end

function SummonCustomPickChoiceList:refreshUI()
	self:refreshList()

	local maxCount = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()
	local text = maxCount == 2 and luaLang("summoncustompickchoice_txt_Title_Two") or string.format(luaLang("summoncustompickchoice_txt_Title_Multiple"), maxCount)

	self._txtTitle.text = text

	gohelper.setActive(self.goTips2, maxCount ~= 1)

	local poolType = SummonCustomPickChoiceListModel.instance:getPoolType()

	text = poolType == SummonEnum.Type.StrongCustomOnePick and luaLang("summon_strong_custompick_desc") or luaLang("p_selfselectsixchoiceview_txt_tips")
	self._txtTips.text = text
end

function SummonCustomPickChoiceList:refreshList()
	self:refreshItems(SummonCustomPickChoiceListModel.instance.noGainList, self._noGainHeroes, self._goNoGain, self._goTitleNoGain)
	self:refreshItems(SummonCustomPickChoiceListModel.instance.ownList, self._ownHeroes, self._goOwn, self._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(self._tfcontent)
end

function SummonCustomPickChoiceList:refreshItems(datas, items, goRoot, goTitle)
	if datas and #datas > 0 then
		gohelper.setActive(goRoot, true)
		gohelper.setActive(goTitle, true)

		for index, mo in ipairs(datas) do
			local item = self:getOrCreateItem(index, items, goRoot)

			item.component:onUpdateMO(mo)
		end
	else
		gohelper.setActive(goRoot, false)
		gohelper.setActive(goTitle, false)
	end
end

function SummonCustomPickChoiceList:getOrCreateItem(index, items, goRoot)
	local item = items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._goitem, goRoot, "item" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, SummonCustomPickChoiceItem)

		item.component:init(item.go)
		item.component:addEvents()

		items[index] = item
	end

	return item
end

return SummonCustomPickChoiceList
