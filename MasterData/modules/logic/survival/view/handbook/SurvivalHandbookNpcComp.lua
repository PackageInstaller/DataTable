-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookNpcComp.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookNpcComp", package.seeall)

local SurvivalHandbookNpcComp = class("SurvivalHandbookNpcComp", SurvivalHandbookViewComp)

function SurvivalHandbookNpcComp:ctor(parentView)
	self._parentView = parentView
	self.handBookType = SurvivalEnum.HandBookType.Npc
	self.handBookDatas = {}
end

function SurvivalHandbookNpcComp:init(go)
	SurvivalHandbookNpcComp.super.init(self, go)

	self.scroll = gohelper.findChild(go, "#scroll")
	self.npc = gohelper.findChild(go, "#npc")
	self.goNpcInfoRoot = gohelper.findChild(go, "#npc")
	self.btnPeople = gohelper.findChildButtonWithAudio(go, "tab/#btnPeople")
	self.btnLaplace = gohelper.findChildButtonWithAudio(go, "tab/#btnLaplace")
	self.btnFoundation = gohelper.findChildButtonWithAudio(go, "tab/#btnFoundation")
	self.btnZeno = gohelper.findChildButtonWithAudio(go, "tab/#btnZeno")
	self.tabs = {}

	local transNames = {
		"#btnFoundation",
		"#btnLaplace",
		"#btnZeno",
		"#btnPeople"
	}
	local HandBookNpcSubType = SurvivalEnum.HandBookNpcSubType
	local subTypes = {
		HandBookNpcSubType.Foundation,
		HandBookNpcSubType.Laplace,
		HandBookNpcSubType.Zeno,
		HandBookNpcSubType.People
	}

	for i, name in ipairs(transNames) do
		local btnClick = gohelper.findChildButtonWithAudio(go, "tab/" .. name)
		local go_selected = gohelper.findChild(btnClick.gameObject, "#go_Selected")
		local go_redDot = gohelper.findChild(btnClick.gameObject, "#go_redDot")
		local subType = subTypes[i]
		local item = self:getUserDataTb_()

		item.btnClick = btnClick
		item.go_selected = go_selected
		item.subType = subType

		table.insert(self.tabs, item)
		gohelper.setActive(go_selected, false)
		RedDotController.instance:addRedDot(go_redDot, RedDotEnum.DotNode.SurvivalHandbookNpc, subType)
	end

	local resPath = self._parentView.viewContainer:getSetting().otherRes.survivalrewardinheritnpcitem

	self._item = self._parentView:getResInst(resPath, self.go)

	recthelper.setWidth(self._item.transform, 1250)
	gohelper.setActive(self._item, false)

	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self.scroll, SurvivalSimpleListPart, {
		minUpdate = 6
	})

	self._simpleList:setCellUpdateCallBack(self._createItem, self, SurvivalRewardInheritNpcItem, self._item)
end

function SurvivalHandbookNpcComp:onOpen()
	self:selectTab(1, true)
end

function SurvivalHandbookNpcComp:onClose()
	self:selectTab(nil)
end

function SurvivalHandbookNpcComp:addEventListeners()
	for i, v in ipairs(self.tabs) do
		self.addClickCb(self, v.btnClick, self.onClickTab, self, i)
	end
end

function SurvivalHandbookNpcComp:removeEventListeners()
	return
end

function SurvivalHandbookNpcComp:onDestroy()
	return
end

function SurvivalHandbookNpcComp:onClickTab(index)
	self:selectTab(index)
end

function SurvivalHandbookNpcComp:_createItem(obj, data, index)
	obj:updateMo(data, nil, self.onClickItem, self)
end

function SurvivalHandbookNpcComp:onClickItem(item)
	local survivalHandbookMo = item.mo

	if survivalHandbookMo.isUnlock then
		ViewMgr.instance:openView(ViewName.SurvivalHandbookInfoView, {
			handBookType = self.handBookType,
			handBookDatas = self.handBookDatas,
			select = self:getIndex(survivalHandbookMo)
		})
	end
end

function SurvivalHandbookNpcComp:refreshList(isAnim)
	if self.curSelect == nil then
		self._simpleList:setList({})

		return
	end

	tabletool.clear(self.handBookDatas)

	local datas = SurvivalHandbookModel.instance:getHandBookDatas(self.handBookType, self.tabs[self.curSelect].subType)

	table.sort(datas, SurvivalHandbookModel.instance.handBookSortFunc)

	for i, mo in ipairs(datas) do
		if mo.isUnlock then
			table.insert(self.handBookDatas, mo)
		end
	end

	local list = {}
	local temp = {}
	local lineAmount = 5

	for i, survivalHandbookMo in ipairs(datas) do
		local t = {
			survivalHandbookMo = survivalHandbookMo
		}

		table.insert(temp, t)

		if i % lineAmount == 0 or i == #datas then
			local isShowLine = i ~= #datas
			local lineData = {
				viewContainer = self._parentView.viewContainer,
				listData = tabletool.copy(temp),
				isShowLine = isShowLine
			}

			table.insert(list, lineData)
			tabletool.clear(temp)
		end
	end

	if isAnim then
		self._simpleList:setOpenAnimation(0.03)
	end

	self._simpleList:setList(list)
end

function SurvivalHandbookNpcComp:getIndex(survivalHandbookMo)
	for i, mo in ipairs(self.handBookDatas) do
		if survivalHandbookMo == mo then
			return i
		end
	end
end

function SurvivalHandbookNpcComp:selectTab(tarSelect, isAnim)
	local haveChange = (not tarSelect or not self.curSelect or self.curSelect ~= tarSelect) and (not not tarSelect or not not self.curSelect)

	if haveChange then
		if self.curSelect then
			gohelper.setActive(self.tabs[self.curSelect].go_selected, false)
		end

		self.curSelect = tarSelect

		if self.curSelect then
			SurvivalHandbookController.instance:markNewHandbook(self.handBookType, self.tabs[self.curSelect].subType)
			gohelper.setActive(self.tabs[self.curSelect].go_selected, true)
		end

		self:refreshList(isAnim)
	end
end

return SurvivalHandbookNpcComp
