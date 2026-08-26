-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickTipsView.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickTipsView", package.seeall)

local SummonNewCustomPickTipsView = class("SummonNewCustomPickTipsView", BaseView)

function SummonNewCustomPickTipsView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._btncloseBg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeBg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonNewCustomPickTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncloseBg:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonNewCustomPickTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncloseBg:RemoveClickListener()
	self.removeEventCb(self, SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, self.refreshUI, self)
end

function SummonNewCustomPickTipsView:_btncloseOnClick()
	self:closeThis()
end

function SummonNewCustomPickTipsView:_editableInitView()
	self._noGainHeroes = {}
	self._ownHeroes = {}
	self._gobg = gohelper.findChild(self.viewGO, "bg")
	self._goitem = gohelper.findChild(self.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	self._gocontent = gohelper.findChild(self.viewGO, "root/#scroll_rule/Viewport/#go_storeItem")
	self._goNoGain = gohelper.findChild(self.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	self._goOwn = gohelper.findChild(self.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/#go_own")
	self._goTitleNoGain = gohelper.findChild(self.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/Title1")
	self._goTitleOwn = gohelper.findChild(self.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/Title2")

	gohelper.setActive(self._goitem, false)

	self._tfcontent = self._gocontent.transform
end

function SummonNewCustomPickTipsView:onUpdateParam()
	return
end

function SummonNewCustomPickTipsView:onOpen()
	logNormal("SummonCustomPickChoiceList onOpen")
	self:refreshUI()
end

function SummonNewCustomPickTipsView:refreshUI()
	self:refreshList()
end

function SummonNewCustomPickTipsView:refreshList()
	self:refreshItems(SummonNewCustomPickChoiceListModel.instance.noGainList, self._noGainHeroes, self._goNoGain, self._goTitleNoGain)
	self:refreshItems(SummonNewCustomPickChoiceListModel.instance.ownList, self._ownHeroes, self._goOwn, self._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(self._tfcontent)
end

function SummonNewCustomPickTipsView:refreshItems(datas, items, goRoot, goTitle)
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

function SummonNewCustomPickTipsView:getOrCreateItem(index, items, goRoot)
	local item = items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._goitem, goRoot, "item" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, SummonNewCustomPickChoiceItem)

		item.component:init(item.go)
		item.component:addEvents()

		items[index] = item
	end

	return item
end

function SummonNewCustomPickTipsView:onClose()
	return
end

function SummonNewCustomPickTipsView:onDestroyView()
	return
end

return SummonNewCustomPickTipsView
